#include<stdio.h>
#include<stdlib.h>
#include<malloc.h>
#include<math.h>
/*
  create an input file for use with MC communication kernel
  Usage: create_input nprocs p_bar p_max l_bar l_max
    nprocs: number of processors that will be used in subsquent simulation
    p_bar: average value of particle count that this program will produce in file
    p_max: maximum value of particle count (pbar = pmax implies all entries equal)
    l_bar: average value of leakage rate that this program will produce in file
    l_max: maximum value of leakage reate (lbar = lmax implies all entries equal)

    Note: entries are chosen with uniform distribution around pbar +- p_max

    output: write file input_file.txt with proper format for use with MC
*/

int main(int argc, char **argv){
    FILE  *file;
    char  *mode;
    int   nprocs, i;
    float p_bar, p_max, l_bar, l_max;
    float p_ratio, l_ratio;
    float ran;
    int    *parr;
    float  *larr;

    if (argc != 6){
	printf("create_input: Missing Args\n");
	printf("Usage: create_input nprocs p_bar p_max l_bar l_max\n");
	exit(1);
    }

    nprocs = atoi(argv[1]);
    p_bar = atof(argv[2]);
    p_max = atof(argv[3]);
    l_bar = atof(argv[4]);
    l_max = atof(argv[5]);

    mode="write";

    parr = (int *)    malloc(nprocs*sizeof(int));
    larr = (float *) malloc(nprocs*sizeof(float));

    /* even distribution */
    if (l_max == l_bar) 
	for (i=0;i<nprocs;++i) larr[i] = l_bar;
    /* uneven distribution */
    else{
	l_ratio = l_max/l_bar - 1;	
	for (i=0;i<nprocs;++i){
	    ran = 2.0*rand()/((double)RAND_MAX + 1) - 1.0;
	    larr[i] = l_bar + l_ratio*ran*l_max;
	}
    }

    /* even distribution */
    if (p_max == p_bar)
	for (i=0;i<nprocs;++i) parr[i] = p_bar;
    /* uneven distribution */
    else{
	p_ratio = p_max/p_bar - 1.0;
	printf("p_ratio:%f\n",p_ratio);
	for (i=0;i<nprocs;++i){
	    ran = 2.0*rand()/((double)RAND_MAX + 1) - 1.0;
	    parr[i] = p_bar + p_ratio*ran*p_bar;
	}
    }


    if (strcmp(mode,"write") == 0){
	file = fopen("input_data.txt","w");
	printf("writing %d entries file ...\n",nprocs);
	fprintf(file,"%d\n",nprocs);
	for (i=0;i<nprocs;++i)
	    fprintf(file,"%d %f\n",parr[i],larr[i]);
	
	fclose(file);
    }

    else if (strcmp(mode,"read") == 0){
	i = 0;
	file = fopen("input_data.txt","r");
	printf("reading %d entries file ...\n",nprocs);
	//fscanf(file, "%d %lf\n",&parr[0],&larr[0]);
	for (i=0;i<nprocs;++i)
	    fscanf(file, "%d %lf",&parr[i],&larr[i]);
	
	fclose(file);
	for (i=0;i<nprocs;++i)
	    printf("%d %f\n",parr[i],larr[i]);
    }
    
}
