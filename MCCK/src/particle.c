#include "particle.h"
#include "mpi.h"
#include<stdlib.h>
#include<stdio.h>

void Particle_print(Particle *p, int np, int nprocs);

void Particle_init(Particle *p, double x, double y, double z, 
			double energy, double angle,
			int absorbed, int proc){
  p->x = x;
  p->y = y;
  p->z = z;
  p->energy = energy;
  p->angle = angle;
  p->absorbed = absorbed;
  p->proc = proc;
}

void Particle_free(Particle *p){
  free(p);
}


/*---------------------------------------*/
/* Particle_print                       */
/*---------------------------------------*/
void Particle_print(Particle *p, int np, int nprocs){
  int i,ii;
  for (ii=0;ii<nprocs;++ii){
    if (p->proc == ii){
      for (i=0;i<np;++i)
	printf("pe[%d]: %f %f %d %d\n",
	       p->proc,p[i].x,p[i].y,p[i].absorbed,p[i].proc);
    }
    MPI_Barrier(MPI_COMM_WORLD);
    fflush(stdout);
  }
  if (p->proc == 0) printf("----------------------\n");
  fflush(stdout);
}


// used with pack function
int Particle_comparer(const void *pp1, const void *pp2){
  Particle *p1 = (Particle *) pp1;
  Particle *p2 = (Particle *) pp2;

  if (p1->absorbed && !p2->absorbed)
    return 1;
  else if(p2->absorbed && !p1->absorbed)
    return -1;
  /* if they are both absorbed or neither absorbed sort by proc*/
  else if (p1->proc > p2->proc)
    return 1;
  else if (p2->proc > p1->proc)
    return -1;
  else
    /* if same proc and same absorbed status, they are tied */
    return 0;
}


