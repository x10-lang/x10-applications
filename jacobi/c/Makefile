ifdef USE_XLC
	CC = xlc
	CCFLAGS += -O3 -qinline -qarch=auto -qtune=auto -qhot
	CCFLAGS_OMP +=  -qsmp -qthreaded
else
	CC = gcc
	CCFLAGS = -O3
	CCFLAGS_OMP = -fopenmp 
endif

all: jacobi_seq jacobi_omp

jacobi_seq: jacobi.c
	$(CC) $(CCFLAGS) jacobi.c -lm -o $@

jacobi_omp: jacobi.c
	$(CC) $(CCFLAGS) $(CCFLAGS_OMP) jacobi.c -lm -o $@

clean:
	$(RM) jacobi_seq jacobi_omp
