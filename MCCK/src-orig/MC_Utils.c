#include "MC.h"

void MC_Debug_print(MC* mc){
  int i,j;
  for (j=0;j<mc->nprocs;++j){
    if (mc->mype == j){
      printf("PE %d\n",mc->mype);
      printf("nparticles: %d\n", mc->nparticles);
      printf("nprocs: %d\n", mc->nprocs);
      printf("mype: %d\n", mc->mype);
      printf("leakage: %f\n", mc->leakage);
      printf("grid.size[]: %f %f %f\n", mc->grid.size[0],mc->grid.size[1],mc->grid.size[2]);
      for (i=0;i<3;++i)
	printf("grid.coords[%d]: %f\n", i,mc->grid.coords[i]);
      for (i=0;i<6;++i)
	printf("grid.nabes[%d]: %d\n", i,mc->grid.nabes[i]);
      for (i=0;i<3;++i)
	printf("grid.proc_coords[%d]: %d\n", i,mc->grid.proc_coords[i]);
    }
    MPI_Barrier(MPI_COMM_WORLD);
  }

}
