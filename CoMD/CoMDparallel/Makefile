# Makefile for X10 version of CoMD benchmark
# for command-line options see http://exmatex.github.io/CoMD/doxygen-mpi/index.html

X10RT = mpi
X10FLAG = -O -NO_CHECKS -VERBOSE_CHECKS -x10rt ${X10RT} -report postcompile=1

BINDIR = bin
BUILDDIR = build
ManagedX10BIN = bin/CoMD.jar
NativeX10BIN = bin/CoMD

all:	build

build:	${NativeX10BIN} ${ManagedX10BIN}

run:	run-cpp run-java 

${ManagedX10BIN}:	src/comd/*.x10
	cd src && x10c ${X10FLAG} -o ../${ManagedX10BIN} -d ../${BUILDDIR} comd/CoMD.x10

${NativeX10BIN}:	src/comd/*.x10
	cd src && x10c++ ${X10FLAG} -o ../${NativeX10BIN} -d ../${BUILDDIR} comd/CoMD.x10

run-java:	${ManagedX10BIN}
	x10 -cp ${ManagedX10BIN} comd.CoMD ${APPFLAG}

run-cpp:	${NativeX10BIN}
	mpiexec -n 2 ${NativeX10BIN} -i 2 

# larger test run with Lennard-Jones potential
run-lj:	${NativeX10BIN}
	mpiexec -n 2 ${NativeX10BIN} -i 2 -j 1 -k 1 -x 40 -y 20 -z 20

# larger test run with Adams EAM potential
run-eam:	${NativeX10BIN}
	mpiexec -n 2 ${NativeX10BIN} -e -i 2 -j 1 -k 1 -x 40 -y 20 -z 20

.PHONY: clean
clean:
	rm -rf ${BUILDDIR} ${ManagedX10BIN} ${NativeX10BIN}

