X10RT = pami
X10FLAG = -O -NO_CHECKS -VERBOSE_CHECKS -x10rt ${X10RT} -report postcompile=1

ManagedX10BIN = MCCK.jar
NativeX10BIN = MCCK

NativeX10BINDIR = bin

APPFLAG = 20000000 0.2 -procs 1 -hostfile ~/hostfile

all:	build

build:	build-cpp build-java 

run:	run-cpp run-java 

build-java:
	x10c ${X10FLAG} -o ${ManagedX10BIN} src/Main.x10

build-cpp:
	x10c++ ${X10FLAG} -o ${NativeX10BINDIR}/${NativeX10BIN} -d ${NativeX10BINDIR} src/Main.x10

run-java:
	x10 -cp ${ManagedX10BIN} src.Main ${APPFLAG}

run-cpp:
	poe ${NativeX10BINDIR}/${NativeX10BIN} ${APPFLAG}

clean:
	rm -rf ${ManagedX10BIN} ${NativeX10BIN} ${NativeX10BINDIR}/*
