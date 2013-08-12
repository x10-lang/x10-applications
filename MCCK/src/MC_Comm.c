#include "MC.h"

#ifdef INCLUDE_MADRE
#include "madre.h"
#endif

/* Meta-data for indexing */
static int *displ;          /* where to place proc i's incoming data in memory on this proc */
static int *sdispl;         /* where is proc i's outgoing data in memory on this proc */

/* Meta-data for MADRE communication map */
#ifdef INCLUDE_MADRE
static int *destRanks;
static int *destIndices;
static MADRE_Object MADRE_particle;
#endif

void nonblocking_exchange(MC* mc, int *myRecvCount, int *mySendCount);
void blocking_exchange(MC* mc, int *myRecvCount, int *mySendCount);

#ifdef INCLUDE_MADRE
void MADRE_exchange(MC* mc, int *myRecvCount, int *mySendCount);                                                         
#endif

// comm_choice constants are declared in MC.h header file
//mySendCount and myRecvCount are declared and initialized in MC_Cycle.c, passed to comm functions

/* Given the choice of communication technique (blocking, nonblocking, MADRE) for this cycle, 
 * comm_init initializes comm metadata and returns the appropriate exchange function */
void (*MC_Comm_init(MC* mc, int comm_choice))(MC* mc, int* myRecvCount, int* mySendCount) {
  sdispl = (int *) calloc(mc->nprocs,sizeof(int));
  displ = (int *) calloc(mc->nprocs,sizeof(int));
  assert(displ);
  assert(sdispl);

  if (comm_choice == MC_NONBLOCK) return  &nonblocking_exchange;
  else if (comm_choice == MC_BLOCK) return &blocking_exchange;

#ifdef INCLUDE_MADRE
  else if (comm_choice == MC_MADRE){
    int maxBlocks = mc->sizep/(int)MADRE_BLOCK_LENGTH;
    destRanks = (int *) calloc(maxBlocks,sizeof(int));
    destIndices = (int *) calloc(maxBlocks,sizeof(int));
    assert(destRanks);
    assert(destIndices);
    MADRE_particle = MADRE_create(mc->particles, "phBred", maxBlocks, MADRE_BLOCK_LENGTH, mc->ParticleType, MPI_COMM_WORLD); 
    return &MADRE_exchange; 
  }
#endif

  else {
    printf("Invalid communication choice...\n");
    MPI_Abort(MPI_COMM_WORLD, 0);
  }
}

/* Call this after each cycle */ 
void MC_Comm_destroy(int comm_choice) {
  free(displ);
  free(sdispl);

#ifdef INCLUDE_MADRE
  if(comm_choice == MC_MADRE){
    MADRE_destroy(MADRE_particle);
    free(destRanks);
    free(destIndices);
  }
#endif
}  

void nonblocking_exchange(MC* mc, int *myRecvCount, int *mySendCount){
  MPI_Request rreqs[6],sreqs[6];
  int nsends;          /* how many particles I'm sending at this stage */
  int nrecvs;          /* how many particles I'm receiving at this stage */
  int i;
  Particle *p;
  p = mc->particles;
  /* This is for convenience. It points to the begin location of the recv area of particle buffer */
  Particle *recvBuf;

  nsends = 0; nrecvs = 0;
  /* set the pointer for where incoming particles will be received */
  recvBuf = p+mc->nparticles;

  /*now set the recv pointers locally on each proc. */
  for (i=1;i<(mc->nprocs);++i) displ[i] = displ[i-1] + myRecvCount[i-1];

  /*and for convenience the send pointers locally on each proc. */
  for (i=1;i<(mc->nprocs);++i) sdispl[i] = sdispl[i-1] + mySendCount[i-1];

  for (i=0;i<(mc->nprocs);i++){
    if (mySendCount[i] > 0 && (i != mc->mype)){

      MPI_Isend(p+sdispl[i],mySendCount[i],mc->ParticleType,i,99,
		MPI_COMM_WORLD,&sreqs[nsends]);
      ++nsends;
    }
    if (myRecvCount[i] > 0 && (i != mc->mype)){
      MPI_Irecv(recvBuf+displ[i],myRecvCount[i],mc->ParticleType,i,MPI_ANY_TAG,
		MPI_COMM_WORLD,&rreqs[nrecvs]);
      ++nrecvs;
    }
  }
  MPI_Waitall(nsends,sreqs,MPI_STATUS_IGNORE);
  MPI_Waitall(nrecvs,rreqs,MPI_STATUS_IGNORE);
  /* Update particle count to include recvd particles in preparation for elim_sent() */
  mc->nparticles += isum(myRecvCount,mc->nprocs);
}

/* Use the MADRE library to distribute the particles. This technique is useful in memory tight situations
 * since each proc can receive the particles in place, rather than at the end of the array */
#ifdef INCLUDE_MADRE
void MADRE_exchange(MC* mc, int *myRecvCount, int *mySendCount){
  int i;
  Particle *p;
  p = mc->particles;
  //cache blockLength
  int blockLength = MADRE_BLOCK_LENGTH;

  /* MADRE_pack should have constructed an integer number of blocks */
  assert(mc->nparticles % (int)MADRE_BLOCK_LENGTH == 0);
  int liveBlocks = mc->nparticles/blockLength;
  for (i=0; i<liveBlocks; ++i) destRanks[i] = p[i*blockLength].proc;

  /* By default, this was set to zero */
  myRecvCount[mc->mype] = mySendCount[mc->mype];

  /* Organize destIndices by proc-rank order */
  displ[0] = 0; 
  for (i=1;i<(mc->nprocs);++i) displ[i] = displ[i-1] + myRecvCount[i-1]/blockLength;

  /* Alltoall where each proc can start receiving particles to get destIndices */
  MPI_Alltoall(displ, 1, MPI_INT, sdispl, 1, MPI_INT, MPI_COMM_WORLD);

  for (i=0; i<liveBlocks; ++i){
    destIndices[i]= sdispl[p[i*blockLength].proc];
    sdispl[p[i*blockLength].proc]++;
  }

  MADRE_redistribute(MADRE_particle, liveBlocks, destRanks, destIndices); 

  mc->nparticles = isum(myRecvCount, mc->nprocs);
  /* Each proc should have an integer number of blocks after exchanges */
  assert(mc->nparticles % (int)MADRE_BLOCK_LENGTH == 0);
}
#endif

/* 3D Cartesian ordered checkerboard blocking communication */
void blocking_exchange(MC* mc, int *myRecvCount, int *mySendCount){
  int *mycoords = mc->grid.proc_coords;
  int *nabes = mc->grid.nabes;
  MPI_Datatype ParticleType = mc->ParticleType;
  MPI_Status stat;
  int i;
  Particle *p;
  p = mc->particles;
  Particle *recvBuf;

  /* set the pointer for where incoming particles will be received */
  recvBuf = p+mc->nparticles;

  /*now set the recv pointers locally on each proc. */
  for (i=1;i<(mc->nprocs);++i) displ[i] = displ[i-1] + myRecvCount[i-1];

  /*and for convenience the send pointers locally on each proc. */
  for (i=1;i<(mc->nprocs);++i) sdispl[i] = sdispl[i-1] + mySendCount[i-1];

  /* Left/right ordered exchange */
  if (mycoords[0] % 2 == 0) { 
    MPI_Send(p+sdispl[nabes[0]], mySendCount[nabes[0]], ParticleType, nabes[0], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[1]], myRecvCount[nabes[1]], ParticleType, nabes[1], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[1]], mySendCount[nabes[1]], ParticleType, nabes[1], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[0]], myRecvCount[nabes[0]], ParticleType, nabes[0], 0, MPI_COMM_WORLD, &stat);
  }
  else {
    MPI_Recv(recvBuf+displ[nabes[1]], myRecvCount[nabes[1]], ParticleType, nabes[1], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[0]], mySendCount[nabes[0]], ParticleType, nabes[0], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[0]], myRecvCount[nabes[0]], ParticleType, nabes[0], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[1]], mySendCount[nabes[1]], ParticleType, nabes[1], 0, MPI_COMM_WORLD);
  }
  /* Up/down ordered exchange */
  if (mycoords[1] % 2 == 0) {   
    MPI_Send(p+sdispl[nabes[2]], mySendCount[nabes[2]], ParticleType, nabes[2], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[3]], myRecvCount[nabes[3]], ParticleType, nabes[3], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[3]], mySendCount[nabes[3]], ParticleType, nabes[3], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[2]], myRecvCount[nabes[2]], ParticleType, nabes[2], 0, MPI_COMM_WORLD, &stat);
  }
  else {
    MPI_Recv(recvBuf+displ[nabes[3]], myRecvCount[nabes[3]], ParticleType, nabes[3], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[2]], mySendCount[nabes[2]], ParticleType, nabes[2], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[2]], myRecvCount[nabes[2]], ParticleType, nabes[2], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[3]], mySendCount[nabes[3]], ParticleType, nabes[3], 0, MPI_COMM_WORLD);
    }
  /* Back/front ordered exchange */
  if (mycoords[2] % 2 == 0) { 
    MPI_Send(p+sdispl[nabes[4]], mySendCount[nabes[4]], ParticleType, nabes[4], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[5]], myRecvCount[nabes[5]], ParticleType, nabes[5], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[5]], mySendCount[nabes[5]], ParticleType, nabes[5], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[4]], myRecvCount[nabes[4]], ParticleType, nabes[4], 0, MPI_COMM_WORLD, &stat);
  }
  else {
    MPI_Recv(recvBuf+displ[nabes[5]], myRecvCount[nabes[5]], ParticleType, nabes[5], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[4]], mySendCount[nabes[4]], ParticleType, nabes[4], 0, MPI_COMM_WORLD);
    MPI_Recv(recvBuf+displ[nabes[4]], myRecvCount[nabes[4]], ParticleType, nabes[4], 0, MPI_COMM_WORLD, &stat);
    MPI_Send(p+sdispl[nabes[5]], mySendCount[nabes[5]], ParticleType, nabes[5], 0, MPI_COMM_WORLD);
  }

  /* Update particle count to include recvd particles in preparation for elim_sent() */
  mc->nparticles += isum(myRecvCount,mc->nprocs);
}
