X10RT ?= mpi

# for compilation define exactly one of the following three variables:
# SEDOV_SYNC_POS_VEL_NONE
# SEDOV_SYNC_POS_VEL_EARLY
# SEDOV_SYNC_POS_VEL_LATE
SYNCFLAG = -define SEDOV_SYNC_POS_VEL_EARLY

X10FLAG = -g -x10rt ${X10RT} -VERBOSE_CHECKS ${SYNCFLAG} #-O -NO_CHECKS -report postcompile=1

BINDIR = bin
ManagedX10BIN = ${BINDIR}/Lulesh2.0.jar
NativeX10BIN = ${BINDIR}/lulesh2.0

SRCPATH = src
DOCPATH = doc

APPFLAG = -i 10 # current version runs all cycles

default:	run-cpp

build:	${NativeX10BIN} ${ManagedX10BIN}

run:	run-cpp run-java 

${ManagedX10BIN}:	${SRCPATH}/*.x10
	x10c ${X10FLAG} -o ${ManagedX10BIN} ${SRCPATH}/Lulesh.x10

${NativeX10BIN}:	${SRCPATH}/*.x10
	x10c++ ${X10FLAG} -o ${NativeX10BIN} -d ${BINDIR} ${SRCPATH}/Lulesh.x10

run-java:	${ManagedX10BIN}
	x10 -cp ${ManagedX10BIN} Lulesh ${APPFLAG}

run-cpp:	${NativeX10BIN}
	${NativeX10BIN} ${APPFLAG}

run-poe:	${NativeX10BIN}
	poe ${NativeX10BIN} ${APPFLAG}

run-mpi:	${NativeX10BIN}
	mpiexec -n 8 ${NativeX10BIN} ${APPFLAG}

DOCSRC=$(shell find ${SRCPATH} -type f -iname '*.x10')

doc		: ${DOCSRC}
		x10doc -d ${DOCPATH} $^

.PHONY: clean
clean:
	rm -rf ${ManagedX10BIN} ${NativeX10BIN} ${BINDIR} ${DOCPATH} 
