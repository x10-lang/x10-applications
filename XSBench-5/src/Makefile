X10FLAG = -O -NO_CHECKS
NX10TMP = tmp-x10c++

MX10BIN = XSBench.jar
NX10BIN = XSBench

APPFLAG ?= 1 small

all:	build

build:	build-java build-cpp

run:	run-java run-cpp

build-java:
	x10c ${X10FLAG} -o ${MX10BIN} xsbench/*.x10

build-cpp:
	x10c++ ${X10FLAG} -o ${NX10BIN} -d ${NX10TMP} xsbench/*.x10

run-java:
	x10 -cp ${MX10BIN} xsbench.Main ${APPFLAG}

run-cpp:
	./${NX10BIN} ${APPFLAG}

clean:
	rm -rf ${MX10BIN} ${NX10BIN} ${NX10TMP}
