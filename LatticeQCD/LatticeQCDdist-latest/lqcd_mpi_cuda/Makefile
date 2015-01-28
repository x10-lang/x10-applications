NVCC = nvcc
CC = mpicc
# CC = mpicxx
LD = $(CC)

DEBUG = -Xptxas=-v 

# LDFLAGS = -g -qsmp=omp -O3 -qhot -qsimd=auto -q64 
# LDFLAGS = -g -O3 -fopenmp
LDFLAGS = -g -O2 -finline-functions -fopenmp

LDLIBDIR = -L$(CUDA_HOME)/lib64

LDLIBS = -lpthread -lrt -lstdc++ -lcudart

INCLUDE = -I./ -I$(MPI_HOME)/include -I$(CUDA_HOME)/samples/common/inc

# QCDDEFS = -DQCD_SPINOR_3X4  

.SUFFIXES: 

.SUFFIXES: .cu .c .h .o

CFLAGS = -g -O2 -finline-functions -fopenmp $(QCDDEFS) $(INCLUDE)

NVCCFLAGS = $(DEBUG) -g -arch=sm_35 -O2 $(INCLUDE)

#// program ===================================================================

MODULE = cg_test

SRCSC = \
	cg_test.cu \
	dslash_base.cu \
	lib_vec.cu

OBJSC = ${SRCSC:.cu=.o}

#// rules =====================================================================

all:	$(MODULE) 

.f.o:
	$(F90) $(FFLAGS) $(LOGLIST) -c $<

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.cu.o:
	$(NVCC) $(NVCCFLAGS) -c $< -o $@

$(MODULE): $(OBJSC) 
	rm -f $(MODULE)
	$(LD)  $(OBJSC) $(LDLIBDIR) $(LDFLAGS) $(LIBC) $(LDLIBS) -o $@ 


clean:
	rm -f $(OBJSC) $(MODULE) *~ *.L *.log *.lst *.oo *.ipa




