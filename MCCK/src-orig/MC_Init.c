#include "MC.h"
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

static MC* mc;
static MPI_Datatype create_mpi_particle_type();
static MPI_Comm setup_grid();
static void Get_parameters(MC* mc, int argc, char **argv);

MC* MC_Init(double size[], int argc, char **argv, MPI_Comm comm){
    int i;
    mc = (MC *) malloc(sizeof(MC));

    MPI_Comm_size(comm,&mc->nprocs);
    MPI_Comm_rank(comm,&mc->mype);

    mc->particles = NULL;
    mc->boundary_flag = BNDRY_REFLECT; //default boundary condition is reflective
    mc->strict = 0; //default is to use random number generator for stochastic particle passing
    mc->seed = time(NULL)*mc->mype; //default seed for random number generator is time-dependent, not constant
    Get_parameters(mc, argc, argv);

    mc->ParticleType = create_mpi_particle_type();
    for (i=0;i<3;++i) mc->grid.size[i] = size[i];
    mc->cartComm = setup_grid();
    return mc;

}

/*---------------------------------------*/
/* create MPI type                       */
/*---------------------------------------*/
MPI_Datatype create_mpi_particle_type(){
    int blocklengths[2]={5,2};
    MPI_Datatype types[2]={MPI_DOUBLE,MPI_INT};
    MPI_Aint disp[2];
    MPI_Datatype ParticleType;
    MPI_Aint int_ex, double_ex;
    MPI_Type_extent(MPI_DOUBLE, &double_ex);
    MPI_Type_extent(MPI_INT, &int_ex);
    disp[0] = (MPI_Aint) 0; disp[1] = 5*double_ex;
    MPI_Type_struct(2, blocklengths, disp, types, &ParticleType);
    MPI_Type_commit(&ParticleType);
    return ParticleType;
}

/*---------------------------------------*/
/* setup_grid                            */
/*---------------------------------------*/
static MPI_Comm setup_grid(){
    MPI_Comm cart_comm;
    int reorder = 0;
    int dims[3] = {0,0,0};
    int periods[3];
    int dx,dy,dz;
    int i;

    if (mc->boundary_flag == BNDRY_PERIODIC) for (i=0; i<3; ++i) periods[i] = 1;
    else for (i=0; i<3; ++i) periods[i] = 0;

    MPI_Dims_create(mc->nprocs, 3, dims);
    MPI_Cart_create(MPI_COMM_WORLD, 3, dims, periods, reorder, &cart_comm);

    MPI_Cart_shift(cart_comm, 0,+1, &mc->grid.nabes[1], &mc->grid.nabes[0]);
    MPI_Cart_shift(cart_comm, 1,+1, &mc->grid.nabes[3], &mc->grid.nabes[2]);
    MPI_Cart_shift(cart_comm, 2,+1, &mc->grid.nabes[5], &mc->grid.nabes[4]);
    MPI_Cart_coords(cart_comm,mc->mype,3,mc->grid.proc_coords);
  
    dx = mc->grid.size[0]/dims[0];
    dy = mc->grid.size[1]/dims[1];
    dz = mc->grid.size[2]/dims[2];
  
    mc->grid.coords[0] = mc->grid.proc_coords[0]*dx;
    mc->grid.coords[1] = mc->grid.coords[0]+dx;
  
    mc->grid.coords[2] = mc->grid.proc_coords[1]*dy;
    mc->grid.coords[3] = mc->grid.coords[2]+dy;
  
    mc->grid.coords[4] = mc->grid.proc_coords[2]*dz;
    mc->grid.coords[5] = mc->grid.coords[4]+dz;
  
    return cart_comm;

}

/* Parses the command line to set leakage rate and p0 for each proc. Also checks for options */
void Get_parameters(MC* mc, int argc, char **argv){
    int c;
    int errflg;
    char *ifile;
    int np;
    double leakage;
    FILE *file;
    int *np_array;
    double *leakage_array;
    extern char *optarg;
    extern int optind, optopt;
    int read_flag = 0;
    char *bndry_string;
    char *mode;

    while ((c = getopt(argc, argv, "M:m:B:b:RrF:f:")) != -1) {
      switch(c) {
	/* OPTION: Strict operation creates perfect load balancing. Nostrict uses standard random passing 
	 * to nearest neighbors */
      case 'm':
      case 'M':
	mode = optarg; 
	if (strcmp(mode,"strict") == 0)
	  mc->strict = 1;
	else if (strcmp(mode,"nostrict") == 0)
	  mc->strict = 0;
	break;
	/* OPTION: Various boundary conditions. Default is reflective */                
      case 'b':
      case 'B':
	bndry_string = optarg;
      if (strcmp(bndry_string, "reflect") == 0)
	mc->boundary_flag = BNDRY_REFLECT;
      if (strcmp(bndry_string, "leak") == 0)
	mc->boundary_flag = BNDRY_LEAK;
      if (strcmp(bndry_string, "periodic") == 0)
	mc->boundary_flag = BNDRY_PERIODIC;
      break;
	/* OPTION: Seed the random number generator with a constant to reproduce results */
      case 'r':
      case 'R':
	mc->seed = 3333.3;
	break;
	/* OPTION: Use an input file to read the leakage rate and p0 for each proc */
      case 'f':
      case'F': 
	ifile = optarg;
	if (mc->mype == MASTERPE) {
	  leakage_array = (double *) malloc(mc->nprocs*sizeof(double));
	  np_array = (int *) malloc(mc->nprocs*sizeof(int));
	  file = fopen(ifile,"r");
	  if ( file == 0 ) {
	    printf( "Could not open file\n" );
	    exit(EXIT_FAILURE);
	  }
	  else {
	    int i,header,stat;
	    printf("reading input file: %s\n", ifile);
	    fscanf(file,"%d",&header);
	    if (header != mc->nprocs){
	      printf("Error reading input file: %s. header value != nprocs\n", ifile);
	      MPI_Abort(MPI_COMM_WORLD,1);
	    }
	    for (i=0;i<mc->nprocs;++i){
	      stat = fscanf(file, "%d %lf",&np_array[i],&leakage_array[i]);
	      if (stat == EOF){
		printf("Error reading input file: %s. unexpected EOF encountered\n", ifile);
		MPI_Abort(MPI_COMM_WORLD,1);
	      }
	    }  
	    fclose(file);  
	  }
	}
	MPI_Scatter(leakage_array, 1, MPI_DOUBLE, &(mc->leakage), 1, MPI_DOUBLE, MASTERPE, MPI_COMM_WORLD);
	MPI_Scatter(np_array, 1, MPI_INT, &(mc->nparticles), 1, MPI_INT, MASTERPE, MPI_COMM_WORLD);  
	read_flag = 1;
	break;
      default: /* '?' */
	fprintf(stderr, 
		"Usage: mpiexec [-np NUM_PROC] %s NPARTICLES GLOBAL_LEAKAGE [-f INPUT FILE] [-r] [-b BOUNDARY CONDITION] [-m STRICT]\n",argv[0]);
	exit(EXIT_FAILURE);
	break;
      }
    }
    if (read_flag == 0) {
      mc->nparticles = atoi(argv[optind]);
      mc->leakage = atof(argv[optind+1]);	
    }
}


