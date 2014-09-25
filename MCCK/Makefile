X10FLAG = -O -NO_CHECKS -VERBOSE_CHECKS -report postcompile=1

X10RTIMPL ?=  # sockets, mpi, pami, etc.
ifdef X10RTIMPL
  X10FLAG += -x10rt ${X10RTIMPL}
endif

BUILDDIR = build
ManagedX10BIN = MCCK.jar
NativeX10BIN = MCCK

APPFLAG = 20000000 0.2 -procs 1 -hostfile ~/hostfile

all:	build

build:	build-cpp build-java 

run:	run-cpp run-java 

build-java:
	x10c ${X10FLAG} -o ${ManagedX10BIN} -d ${BUILDDIR} src/Main.x10

build-cpp:
	x10c++ ${X10FLAG} -o ${NativeX10BIN} -d ${BUILDDIR} src/Main.x10

run-java:
	x10 -cp ${ManagedX10BIN} src.Main ${APPFLAG}

run-cpp:
	poe ${NativeX10BIN} ${APPFLAG}

clean:
	rm -rf ${ManagedX10BIN} ${NativeX10BIN} ${BUILDDIR}

