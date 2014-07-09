
X10C = x10c++
LD = $(X10C)

X10FLAGS = -O -x10rt mpi -NO_CHECKS
LDFLAGS = $(X10FLAGS)


#// program ===================================================================

MODULE = cg_test

SRCSX10 = \
	ComplexField.x10 \
	ParallelComplexField.x10 \
	CUDAParallelComplexField.x10 \
	WilsonVectorField.x10 \
	CUDAWilsonVectorField.x10 \
	SU3MatrixField.x10 \
	CUDASU3MatrixField.x10 \
	Lattice.x10 \
	ParallelLattice.x10 \
	Dslash.x10 \
	SolverCG.x10 \
	LatticeComm.x10 \
	CUDALatticeComm.x10 \
	HalfWilsonVectorField.x10 \
	CUDAHalfWilsonVectorField.x10 \
	TestWilsonSolver.x10 \
	MyRand.x10 \
	CUDAEnv.x10 \

SRCSCC = ${SRCSX10:.x10=.cc}
SRCSCU = ${SRCSX10:.x10=.cu}
SRCSH = ${SRCSX10:.x10=.h}
SRCSH += GetGCD.h HalfWilsonMult.h CUDAHalfWilsonMult.h
SRCSCC += xxx_main_xxx.cc
CUBIN = *.cubin

#// rules =====================================================================

all:	$(MODULE) 

$(MODULE): $(SRCSX10) 
	rm -f $(MODULE)
	$(LD) $(SRCSX10) $(LDFLAGS) -o $@ 


clean:
	rm -f $(SRCSCC) $(SRCSCU) $(SRCSH) $(CUBIN) $(MODULE)




