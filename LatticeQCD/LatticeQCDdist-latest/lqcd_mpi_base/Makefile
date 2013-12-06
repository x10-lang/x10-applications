
DRIVER = /bgsys/drivers/ppcfloor

QCD_KERNEL_DIR=bgq_kernels

# CC = $(DRIVER)/comm/xl/bin/mpixlc_r
CC = mpicc
# CC = mpicxx
LD = $(CC)

# LDFLAGS = -g -qsmp=omp -O3 -qhot -qsimd=auto -q64 
# LDFLAGS = -g -O3 -fopenmp
LDFLAGS = -g -O2 -finline-functions -fopenmp

LDLIBS = -lpthread -lrt -lstdc++


# QCDDEFS = -DQCD_SPINOR_3X4  

# # CFLAGS = -g -qsmp=omp -O3 -qsimd=auto  $(QCDDEFS) -q64 -qsource -qlist -I./ -I$(DRIVER) -I$(DRIVER)/comm/xl/include 
# CFLAGS = -g -O3 $(QCDDEFS) -I./ -I$(DRIVER) -I$(DRIVER)/comm/xl/include 
CFLAGS = -g -O2 -finline-functions -fopenmp $(QCDDEFS) -I./ -I$(DRIVER) -I$(DRIVER)/comm/xl/include 


#// program ===================================================================

MODULE = cg_test

SRCSC = \
	cg_test.c \
	dslash_base.c \
	lib_vec.c 

OBJSC = ${SRCSC:.c=.o}

#// rules =====================================================================

all:	$(MODULE) 

.f.o:
	$(F90) $(FFLAGS) $(LOGLIST) -c $<

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@


$(MODULE): $(OBJSC) 
	rm -f $(MODULE)
	$(LD)  $(OBJSC) $(LDFLAGS) $(LIBC) $(LDLIBS) -o $@ 


clean:
	rm -f $(OBJSC) $(MODULE) *~ *.L *.log *.lst *.oo *.ipa




