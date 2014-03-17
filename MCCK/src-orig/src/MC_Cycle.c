#include "MC.h"
#include <math.h>

static MC* mc;
static void update_particles();
static void update_particles_strict();
static int pack();
static int madre_pack();
static void debug_print();
static int elim_sent();
static int madre_unpack();
static void check_array_size(int comm_choice, int *myRecvCount);
static int fake_data_comparer(const void *pp1, const void *pp2);
static int compare_sent(const void *pp1, const void *pp2);

int MC_Cycle(MC* mcobj, MC_Diagnostic *diag, int comm_choice){
  int i;
  Particle *p; 
  int np_min, np_max;     /* minimum/maximum number of particles on a proc */
  int iter = 0;        /* stage */
  int *mySendCount;    /* how many particles sent to proc i at a stage */
  int *myRecvCount;    /* how many particles recv from proc i at a stage */
  int includingFakes; 
  /* cache local pointer so can be used across subroutines */
  mc = mcobj; 

  double time_strt, time_end, time_reduce=0.0, time_pack=0.0, time_unpack=0.0, time_update=0.0,
    time_allreduce=0.0, time_alltoall=0.0,
    time_exchange=0.0,time_tot=0.0;
  
  /* seed the random number generator for simlating data movement */
  srand(mc->seed);

  p           = mc->particles;
  mySendCount = (int *)      calloc(mc->nprocs,sizeof(int));
  myRecvCount = (int *)      calloc(mc->nprocs,sizeof(int));

  diag->p0 = mc->nparticles;

  /* initialize communication technique */
  void (*exchange)(MC* mc, int* myRecvCount, int* mySendCount);
  exchange = MC_Comm_init(mc, comm_choice);

  long long npg, npl; /*global and local particle counts */
  long npg_before =0; /*global particle count on previous iteration */

  while (1){
    ++iter;
    
    npl = mc->nparticles;

    MPI_Reduce(&npl,&npg,1,MPI_LONG_LONG, MPI_SUM, MASTERPE, MPI_COMM_WORLD);

    /* Perform load balancing related measurements */
    MPI_Reduce(&mc->nparticles, &np_min, 1, MPI_INT, MPI_MIN, MASTERPE, MPI_COMM_WORLD);
    MPI_Reduce(&mc->nparticles, &np_max, 1, MPI_INT, MPI_MAX, MASTERPE, MPI_COMM_WORLD);
    if (mc->mype == MASTERPE) {
      diag->np_min[iter] = np_min;
      diag->np_max[iter] = np_max;
    } 

    /* Compute and output stage statistics */
    if (mc->mype == MASTERPE){
      float np_mean, delta;
      /* If global nparticles is unchanged during first two cycles, quit */
      if (iter < 3) {
	if (npg == npg_before) {
	  printf("Global number of particles is constant...\n");
	  printf("aborting....... \n");	
	  MPI_Abort(MPI_COMM_WORLD,1);
	}
      }
      npg_before = npg;
      np_mean = (float) npg/(float) mc->nprocs;
      delta = np_max - np_mean;
      printf("stage %3d, %8lld total np ([min:%6d max:%6d mean:%6.2f  delta:%2.2f])\n", 
	     iter,npg,np_min,np_max,np_mean,delta);
    }

    /* pretend like particles moved and now some are absorbed
       and some are crossing to new procs. we do this probabilistically 
       for mc->strict=0, determinstically otherwise  */
    time_strt = MPI_Wtime();
    if (mc->strict)
      update_particles_strict();
    else
      update_particles();
    time_end = MPI_Wtime();
    time_update += (time_end - time_strt);

    /* now that we have updated list of particles, we want
       to remove all of the absorbed particles from the list
       and compress the particle array to its new size */
    time_strt = MPI_Wtime();
    if ((comm_choice == MC_NONBLOCK) || (comm_choice == MC_BLOCK))
      mc->nparticles = pack();
    else 
      /* includes fake data for madre. Preserves accuracy of mc->nparticles for statistics */
      includingFakes = madre_pack();

    time_end = MPI_Wtime();
    time_pack += (time_end - time_strt);

    /* check if any particles left. if none then we break main loop */
    MPI_Allreduce(&mc->nparticles,&np_max,1,MPI_INT,MPI_MAX,MPI_COMM_WORLD);

    if (np_max <= 1) break;

    /* Switch back to MADRE particle count if using MC_MADRE */
    if (comm_choice == MC_MADRE) mc->nparticles = includingFakes;

    /* count number of particles going to proc[i] */
    for (i=0;i<mc->nparticles;++i) ++mySendCount[p[i].proc];

    /* map this via Alltoall into number being recvd from proc i */
    MPI_Alltoall(mySendCount, 1, MPI_INT, myRecvCount, 1, MPI_INT, MPI_COMM_WORLD);

    /* need to be sure enough room was allocated to receive particles */
    check_array_size(comm_choice, myRecvCount);
    
    /* local processor doesn't send particles to itself, so remove its particles 
    * from the count at the end of the buffer to avoid holes in recv displs*/
    myRecvCount[mc->mype] = 0;

    MPI_Barrier(MPI_COMM_WORLD);
    time_strt = MPI_Wtime();
    /* now exchange the data */
    exchange(mc, myRecvCount, mySendCount);

    time_end = MPI_Wtime();
    time_exchange += (time_end - time_strt);

    /* update particle count and sort out sent particles */
    time_strt = MPI_Wtime();
    if ((comm_choice == MC_NONBLOCK) || (comm_choice == MC_BLOCK))
      mc->nparticles = elim_sent();
    else
      /* now we have the real number of particles again */
      mc->nparticles = madre_unpack();
    time_end = MPI_Wtime();
    time_unpack += (time_end - time_strt);

    /* clear mySendCount */
    for (i=0;i<mc->nprocs;++i) mySendCount[i]= 0;  
  }
  time_tot = time_exchange + time_allreduce + time_alltoall + time_reduce + time_pack + time_unpack;
  /*  
   if (diag){

  diag->nprocs = mc->nprocs;
  diag->nstages = iter;
  diag->time = time_tot;
  diag->time_allreduce = time_allreduce;
  diag->time_alltoall = time_alltoall;
  diag->time_exchange = time_exchange;
  diag->time_reduce = time_reduce;
   }
  */

  diag->time_pack = time_pack;
  diag->time_unpack = time_unpack;
  diag->time_update = time_update;


  /* Free allocated communication meta-data */
  MC_Comm_destroy(comm_choice);
  return iter;  
}

void MC_Set_leakage(MC* mc, double new_leakage){
  mc->leakage = new_leakage;
}

/*---------------------------------------*/
/* update_particles_strict()             */
/*---------------------------------------*/
static void update_particles_strict(){
  int i,j, npa, npl, nabe;
  Particle *particles = mc->particles;
  int np = mc->nparticles;
  double leakage = mc->leakage;
  int boundary_flag = mc->boundary_flag;

  npa = round((1-leakage)*np);
  npl = np - npa;

  /* force npl to be divisble by 6 and subBlocks by tweaking absorption slightly */
  while ((npl % 6) != 0){
    --npl;
    ++npa;
  }

  /* set absorbed particles */
  for (i=0;i<npa;++i)
    particles[i].absorbed=1;

  /* set leaving particles equally */
  for (i=0,j=0;i<npl;++i,j=i%6){
    particles[npa+i].absorbed = 0;
    nabe = mc->grid.nabes[j];
    if (nabe == MPI_PROC_NULL){
      particles[npa+i].proc = mc->mype; /* bounce back boundary condition */
    }
    else{
      particles[npa+i].proc = nabe;
    }
  }
}

/*---------------------------------------*/
/* update_particles                      */
/*---------------------------------------*/
static void update_particles(){
  int i, random_nabe_index, random_nabe;
  double r;

  Particle *particles = mc->particles;
  int np = mc->nparticles;
  double leakage = mc->leakage;
  int boundary_flag = mc->boundary_flag;
  if (boundary_flag == BNDRY_REFLECT) {
    for (i=0;i<np;++i){
      r = rand()/((double)RAND_MAX + 1);
      if (r > leakage)
	particles[i].absorbed = 1;
      else {
	//give me a random int for 0 to 5
	random_nabe_index = (int)(rand() / (((double)RAND_MAX + 1)/ 6));
	random_nabe = mc->grid.nabes[random_nabe_index];
	particles[i].absorbed = 0;
	if (random_nabe != MPI_PROC_NULL)
	  particles[i].proc = random_nabe; 
	else 	/* Enforce Boundary Condition */
	  particles[i].proc = mc->mype; /* bounce back boundary condition */  
      }
    }
  }
  else if (boundary_flag == BNDRY_LEAK) {
    for (i=0;i<np;++i){
      r = rand()/((double)RAND_MAX + 1);
      if (r > leakage)
	particles[i].absorbed = 1;
      else {
	//give me a random int for 0 to 5
	random_nabe_index = (int)(rand() / (((double)RAND_MAX + 1)/ 6));
	random_nabe = mc->grid.nabes[random_nabe_index];
	particles[i].absorbed = 0;
	if (random_nabe != MPI_PROC_NULL)
	  particles[i].proc = random_nabe; 
	else { 	/* Enforce Boundary Condition */
	  r = rand()/((double)RAND_MAX + 1);
	  if (r > leakage) //leakage ratio through boundary is the same as leakage to neighbors
	    particles[i].absorbed = 1;
	  else 
	    particles[i].proc = mc->mype;
	}
      }
    }
  }
  else if (boundary_flag == BNDRY_PERIODIC) {
    for (i=0;i<np;++i){
      r = rand()/((double)RAND_MAX + 1);
      if (r > leakage)
	particles[i].absorbed = 1;
      else {
	random_nabe_index = (int)(rand() / (((double)RAND_MAX + 1)/ 6));
	random_nabe = mc->grid.nabes[random_nabe_index];
	particles[i].absorbed = 0;
	particles[i].proc = random_nabe; 
      }
    }
  }
}

/*---------------------------------------*/
/* pack particles to remove holes        */
/* particles aligned as                  */
/* [not-absorbed staying,                */
/*  not-absorbed leaving,                */
/*  absorbed]                            */
/*---------------------------------------*/

static int pack(){
  Particle *p = mc->particles;
  int np = mc->nparticles;
  
  int count;
  
  int (*comp)(const void *, const void *);
  comp = Particle_comparer;
  qsort(p,np,sizeof(Particle),comp);
  
  for (count=0;count<np;++count){
    if (p[count].absorbed) break;
  }
  return count;
}

/*---------------------------------------*/
/* pack particles for use with madre     */
/* ensure that particles are grouped     */
/* in multiples of MADRE_BLOCK_LENGTH    */
/* if not, we force them to be by        */
/* adding fake data to remainder block   */
/*---------------------------------------*/
static int madre_pack(){
  int myParticleSendCount,totParticleSendCount=0;;
  int fakeSpots,totFakeSpots=0;
  int i,j,count;
  Particle *p = mc->particles;
  int np = mc->nparticles;
  int nprocs = mc->nprocs;
  int (*comp)(const void *, const void *);

  for (j=0;j<nprocs;++j){                                /* for each proc j */
    myParticleSendCount = 0;
    for (i=0;i<np;++i){                                  /* how much data is being sent to proc j */
      if (p[i].proc==j && p[i].absorbed==0)
	++myParticleSendCount;
    }
    
    if (myParticleSendCount == 0) continue;
    if (myParticleSendCount % MADRE_BLOCK_LENGTH == 0)
      fakeSpots = 0;
    else fakeSpots = MADRE_BLOCK_LENGTH - (myParticleSendCount % MADRE_BLOCK_LENGTH);            /* how big will remainder block be */
    
    totFakeSpots += fakeSpots;
    totParticleSendCount +=myParticleSendCount; 
    
    for (i=0; fakeSpots>0 && i<mc->sizep;++i){           /* use existing dead data to create remainder ...*/
      if (p[i].absorbed==1 || i >= np){                   /* fake data elements using p.x field */
	p[i].proc=j;
	p[i].absorbed = 0;
	p[i].x=MADRE_FAKE_DATA;
	if (i>=np) np++; //keep track of how far the fake spots are extending into the buffer
	--fakeSpots;
      }
    }
    if (i==mc->sizep){
      printf("error: can't find enough free blocks for madre_pack: pe[%d], toproc[%d]",mc->mype,j);
      printf("consider reducing madre block size or increasing sizep \n");
      MPI_Abort(MPI_COMM_WORLD,1);
    }
  }
  /* sort particles in regular way ... by proc with absorbed ones last
     fake data will be removed in madre_unpack() */
  comp = Particle_comparer;
  qsort(p,np,sizeof(Particle),comp);
  
  for (count=0;count<np;++count){
    if (p[count].absorbed) break;
  }
  mc->nparticles = totParticleSendCount; //only actual particles
  return count; //includes fake data
}

static void check_array_size(int comm_choice, int *myRecvCount) {
  Particle *p = mc->particles;
  Particle *tmp;
  int total_np;
 
  if (comm_choice != MC_MADRE) total_np = (mc->nparticles + isum(myRecvCount,mc->nprocs) - myRecvCount[mc->mype]);
  else total_np = isum(myRecvCount,mc->nprocs);
  if (mc->sizep < total_np){
    printf("WARNING: not enough space to hold: %d particles while receiving: %d particles on proc: %d\n",
	   total_np,(isum(myRecvCount,mc->nprocs) - myRecvCount[mc->mype]),mc->mype);
    printf("reallocating....... \n");
    tmp = (Particle *) realloc(p, sizeof(Particle)*(total_np + 1));
    if (tmp != NULL) {
      mc->particles = tmp;
      mc->sizep = total_np + 1;
    }
    else {
      printf("ERROR: resizing reallocation of particle array failed on proc: %d\n", mc->mype);
      printf("aborting....... \n");	
      MPI_Abort(MPI_COMM_WORLD,1);
    }
  }
}


static void debug_print(){
  int i,j;
  Particle *p = mc->particles;
  for (i=0;i<mc->nprocs;++i){
    if (mc->mype == i){
      printf("PE[%d]:(%d) ",mc->mype,mc->nparticles);
      for (j=0;j<mc->nparticles;++j){
	printf("%d,%d : ",p[j].absorbed,p[j].proc);
      }
      printf("\n");
    }
    MPI_Barrier(MPI_COMM_WORLD);
  }
}
      
int isum(int f[], int n){
  int i,sum=0;
  for (i=0;i<n;++i)
    sum+=f[i];
  return sum;
}

/* After exchanges, eliminate the sent particles and 
 * update the nparticles count */
static int elim_sent(){
  Particle *p = mc->particles;
  int np = mc->nparticles;
  int mype = mc->mype;
  int i, count=0;

  qsort(p,np,sizeof(Particle),compare_sent);
  for (i=0,count=0;i<np;++i){
    if (p[i].proc == mype && p[i].absorbed == 0){
      ++count;
    }
  }
  return count;
}

/* comparison function for elim_sent qsort call */
int compare_sent(const void *pp1, const void *pp2){
  Particle *p1 = (Particle *) pp1;
  Particle *p2 = (Particle *) pp2;
  int p1_proc_match=2, p2_proc_match=2;
  if (p1->proc == mc->mype) p1_proc_match =1;
  if (p2->proc == mc->mype) p2_proc_match =1;
  if (p1_proc_match > p2_proc_match)
    return 1;
  else if (p1_proc_match < p2_proc_match)
    return -1;
  else
    return 0;
}

/* -----------------------------------------------
  this allows sorting the particle array so that it remains
  in proc order but all fake data is moved to the end
  for use only with madre_unpack
  -----------------------------------------------*/
static int fake_data_comparer(const void *pp1, const void *pp2){
  Particle *p1 = (Particle *) pp1;
  Particle *p2 = (Particle *) pp2;
  
  if (p1->x == MADRE_FAKE_DATA)
    return 1;
  else if (p2->x == MADRE_FAKE_DATA)
    return -1;
  else if (p1->proc > p2->proc)
    return 1;
  else if (p1->proc < p2->proc)
    return -1;
  else
    return 0;
}

/*
 after data redistributed by madre, need
 to remove "fake data" that was included
 to ensure that number of particles going
 to a given proc is a multiple of
 MADRE_BLOCK_LENGTH. These fake particles
 are identified as p.x=MADRE_FAKE_DATA
*/
static int madre_unpack(){
  int myParticleSendCount,remainder;
  int i,j,count;
  Particle *p = mc->particles;
  int np = mc->nparticles;
  int nprocs = mc->nprocs;
  int (*comp)(const void *, const void *);

  comp = fake_data_comparer;
  qsort(p,np,sizeof(Particle),comp);

  for (count=0;count<np;++count){
    if (p[count].x == MADRE_FAKE_DATA) break;
  }
  return count;
}
