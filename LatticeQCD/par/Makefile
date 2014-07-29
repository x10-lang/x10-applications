
#X10C = ../../bin/x10c++
X10C = x10c++
LD = $(X10C)

X10FLAGS = -O -x10rt pami -NO_CHECKS
LDFLAGS = $(X10FLAGS)


#// program ===================================================================

MODULE = cg_test

SRCSX10 = \
	HalfWilsonVector.x10 \
	Lattice.x10 \
	Dslash.x10 \
	SolverCG.x10 \
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
	rm -f $(SRCSCC) $(SRCSH) $(MODULE) GetGCD.h xxx_main_xxx.cc




