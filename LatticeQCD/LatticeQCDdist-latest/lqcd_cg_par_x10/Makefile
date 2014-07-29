
# X10C = ../../bin/x10c++
X10C = x10c++
LD = $(X10C)

# X10FLAGS = -O -x10rt pami -NO_CHECKS
X10FLAGS = -O -x10rt mpi -NO_CHECKS
# X10FLAGS = -O -x10rt mpi 
LDFLAGS = $(X10FLAGS)


#// program ===================================================================

MODULE = cg_test

SRCSX10 = \
	ComplexField.x10 \
	ParallelComplexField.x10 \
	WilsonVectorField.x10 \
	SU3MatrixField.x10 \
	Lattice.x10 \
	ParallelLattice.x10 \
	Dslash.x10 \
	SolverCG.x10 \
	LatticeComm.x10 \
	ThreadParallelLattice.x10 \
	HalfWilsonVectorField.x10 \
	TestWilsonSolver.x10 \
	MyRand.x10 \


SRCSCC = ${SRCSX10:.x10=.cc}
SRCSH = ${SRCSX10:.x10=.h}

#// rules =====================================================================

all:	$(MODULE) 

$(MODULE): $(SRCSX10) 
	rm -f $(MODULE)
	$(LD) $(SRCSX10) $(LDFLAGS) -o $@ 


clean:
	rm -f $(SRCSCC) $(SRCSH) $(MODULE) HalfWilsonMult.h GetGCD.h xxx_main_xxx.cc




