#include<stdlib.h>
#include<stdio.h>
#include "mpi.h"
#include "particle.h"
#include <assert.h>

#define MASTERPE 0
/* Maximum number of stages in a cycle that MCLib will record statistics */
#define MAX_STAGES 1000
/* Block length for MADRE exchange. If insuff data to fill length, will fill with fake data */ 
#define MADRE_BLOCK_LENGTH 1000
#define MADRE_FAKE_DATA 1.e10


/* Three options for communication mechanism (found in MC_Comm.c)
 * used as an argument of MC_Cycle.c. This allows different communication
 * methods to be used each cycle */
static int MC_NONBLOCK = -1;
static int MC_MADRE = -2;
static int  MC_BLOCK = -3;

/* Available Boundary Conditions */
static int BNDRY_REFLECT = -1;
static int BNDRY_PERIODIC = -2;
static int BNDRY_LEAK = -3;

typedef struct Grid_Type{
  double size[3];
  double coords[6];
  int nabes[6];
  int proc_coords[3];
} Grid;

typedef struct MC_Type{
  Particle *particles;
  int nparticles;
  int sizep;
  int nprocs;
  int mype;
  int boundary_flag;
  int strict;
  double leakage;
  double seed;
  MPI_Datatype ParticleType;
  MPI_Comm cartComm;
  Grid grid;
  void (*debug_print)(struct MC_Type *);
} MC;

typedef struct MC_Diagnostic_Type{
  int nprocs, p0;
  int nstages;
  double time, time_allreduce, time_exchange,
    time_reduce, time_alltoall, time_pack, time_unpack, time_update;
  int nparticles_average;
  int nparticles_stddev;
  int np_min[MAX_STAGES], np_max[MAX_STAGES];
} MC_Diagnostic;

MC* MC_Init(double size[], int argc, char **argv, MPI_Comm comm);
void MC_Set_particles(MC* mc, Particle* p, int np,int sizep);
void MC_Set_leakage(MC* mc, double leakage);
int  MC_Cycle(MC* mc, MC_Diagnostic* diag, int comm_choice);
void MC_Debug_print(MC* mc);
void (*MC_Comm_init(MC* mc, int comm_choice))(MC* mc, int* myRecvCount, int* mySendCount);
void MC_Comm_destroy(int comm_choice);
int isum(int f[],int n);


