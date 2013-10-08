#include "mpi.h"
#include<stdlib.h>
#include<stdio.h>
#include<assert.h>
#include "MC.h"

void init_particles(Particle *p, int np, double mycoords[],int mype);
void write_diagnostics(MC_Diagnostic *diags, double max_time_exchange, double max_time_pack,  double max_time_unpack,  double max_time_update, double t_tot, char *filename);

int main(int argc, char **argv){
  double domain_size[3] = {1.,1.,1.};
  double leakage = 0.5;
  const double bufsize = 0.5;
  double avg_time, max_time_exchange, avg_time_alltoall,
    avg_time_allreduce, avg_time_reduce, max_time_update, max_time_pack, max_time_unpack;
  int nprocs, np, mype,nstages;
  MC* mc;
  MC_Diagnostic diags;
  Particle *p;   
  FILE *file;
  MPI_Init(&argc,&argv);
  MPI_Comm_size(MPI_COMM_WORLD,&nprocs);
  MPI_Comm_rank(MPI_COMM_WORLD,&mype);

  /* output diagnostics file */
  double t_start, t_end, t_tot;
  t_start = MPI_Wtime();

  /* create an MC object and get command line parameters for each proc */
  mc = MC_Init(domain_size,argc,argv,MPI_COMM_WORLD);

  /* initialize memory for particle data */
  p  = (Particle *) malloc((1.0+bufsize)*(mc->nparticles)*sizeof(Particle));

  assert(p);
  
  /* initialize the particle properties */
  init_particles(p,mc->nparticles,mc->grid.coords,mype);

  /* pass particles to MC object */
  MC_Set_particles(mc,p,mc->nparticles,(1.0+bufsize)*(mc->nparticles));

  /* run single cycle, returning number of states and optional timing info */
  nstages = MC_Cycle(mc, &diags, MC_NONBLOCK);

  /* though all procs should be roughly equal, record slowest processor */
  MPI_Reduce(&diags.time_exchange, &max_time_exchange, 1, 
	     MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
  MPI_Reduce(&diags.time_pack, &max_time_pack, 1, 
	     MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
  MPI_Reduce(&diags.time_unpack, &max_time_unpack, 1, 
	     MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
  MPI_Reduce(&diags.time_update, &max_time_update, 1, 
	     MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

  t_end = MPI_Wtime();
  t_tot = t_end - t_start;

  if (mype == 0)
    write_diagnostics(&diags,max_time_exchange,max_time_pack,max_time_unpack,max_time_update,t_tot,"timings.txt");

  MPI_Finalize();

  return 0;
}


/*---------------------------------------*/
/* init_particles                        */
/*---------------------------------------*/

void init_particles(Particle *p, int np, double mycoords[],int mype){
  int i;
  double xc = (mycoords[0] + mycoords[1])/2.;
  double yc = (mycoords[2] + mycoords[3])/2.;
  double zc = (mycoords[4] + mycoords[5])/2.;
  for (i=0;i<np;++i){
    Particle_init(&p[i],xc,yc,zc,0.,0,0,p->proc);
    p[i].proc = mype;
  }
}

/*---------------------------------------*/
/* write_diagnostics                     */
/*---------------------------------------*/

void write_diagnostics(MC_Diagnostic *diags, double max_time_exchange, double max_time_pack,  double max_time_unpack,  double max_time_update, double t_tot, char *filename){
  int i;
  FILE *file = fopen(filename,"a");
  fprintf(file,"-----------------------------\n");
  fprintf(file,"nprocs:%d\n",diags->nprocs);
  fprintf(file,"p0:%d\n",diags->p0);
  fprintf(file,"nstages:%d\n",diags->nstages);
  fprintf(file,"Total Runtime:%f\n",t_tot);
  fprintf(file,"exchange-recv time:%f\n",max_time_exchange);
  fprintf(file,"pack time:%f unpack time:%f update time:%f\n",max_time_pack, max_time_unpack, max_time_update);
  for (i=1; i<diags->nstages; ++i) fprintf(file,"stage: %d np_max: %d np_min %d\n",i,diags->np_max[i],diags->np_min[i]);
  fclose(file);
}
