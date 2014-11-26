LIB	= lib
EXTLIB = extlib
#OPT	?= -O # -NO_TRACES
#OPT	?= -O -VERBOSE_CHECKS
OPT	?= -O
# Due to X10 compiler's bug, currently assertion fails in compiler.
#ASSERT	?= -J-ea
ASSERT	?=
DEF	=
TMP	= tmp

M3RLITE_SOURCES	= \
src/com/ibm/m3rlite/Engine.x10 \
src/com/ibm/m3rlite/Job.x10 \
src/com/ibm/m3rlite/ResilientEngine.x10 

M3RLITE_EXAMPLE_SOURCES	= \
src/com/ibm/m3rlite/example/Histogram.x10 \
src/com/ibm/m3rlite/example/KMeansClustering.x10 \
src/com/ibm/m3rlite/example/ResilientKMeansM3R.x10 \
src/com/ibm/m3rlite/example/ResilientHMM.x10 \
src/com/ibm/m3rlite/example/HMMModel.x10 \
src/com/ibm/m3rlite/example/SortDistArrayJob.x10

all:	m3rlite m3rlite_example

m3rlite:${LIB}/m3rlite.jar
m3rlite_example:${LIB}/m3rlite.example.jar

${LIB}/m3rlite.jar: ${M3RLITE_SOURCES}
	x10c ${ASSERT} ${OPT} -buildx10lib ${LIB} -o $@ ${M3RLITE_SOURCES}

${LIB}/m3rlite.example.jar: ${LIB}/m3rlite.jar ${M3RLITE_EXAMPLE_SOURCES}
	x10c ${ASSERT} ${OPT} -x10lib ${LIB}/m3rlite.properties -buildx10lib ${LIB} -o $@ ${M3RLITE_EXAMPLE_SOURCES}

native:
	rm -rf ${TMP}
	x10c++ ${ASSERT} ${OPT} -d ${TMP} -o ResilientHMM -MAIN_CLASS=com.ibm.m3rlite.example.ResilientHMM ${M3RLITE_EXAMPLE_SOURCES} ${M3RLITE_SOURCES}

cleannative:
	rm -rf ResilientHMM ${TMP}

clean: cleannative
	rm -rf ${LIB}

help:
	@echo "------------------------------------------------------------------"
	@echo "make m3rlite -- make ${LIB}/m3rlite.{jar,properties}"
	@echo "make m3rlite_example -- make ${LIB}/m3rlite_example.{jar,properties}"
	@echo "make all    -- make all above"
	@echo "make clean  -- clean all above"
	@echo "------------------------------------------------------------------"

.PHONY:	all m3rlite m3rlite_example clean help

