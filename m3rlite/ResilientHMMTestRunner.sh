#!/bin/bash

# configurations
#PLACES=(4 8 16 32 64)
PLACES=(64 32 16 8 4)
SCENARIO_DIR="./scenario"
SCENARIOS=("normal.scenario" "redfail.scenario" "mapfail.scenario")
#SCENARIOS=("mapfail.scenario")
#export X10_NPLACES=3
export X10_RESILIENT_MODE=1
export X10_HOSTFILE="${HOME}/x10host"
export X10_LOG_LEVEL="WARN"

LOG_DIR="${HOME}/hmmlog"
LOG_PROPERTIES="logging.properties"
LIBS="lib/m3rlite.jar:lib/m3rlite.example.jar"

if [ ! -e $LOG_DIR ]; then
	mkdir $LOG_DIR
fi

# HMM PAPRAMS
S=10
O=10
N=10000 # 10k lines
M=10    # iterations
INPUT="./testdata/10k.dat"

OPTS="-s ${S} -o ${O} -n ${N} -m ${M} -i -f ${INPUT}"

#--- managed
#CMD="x10 -logconf ${LOG_PROPERTIES} -cp ${LIBS} com.ibm.m3rlite.example.ResilientHMM ${OPTS}"
CMD="./ResilientHMM ${OPTS}"

#echo "---------------------------------------------------------"
#echo "- This program is used for executing various test cases -"
#echo "---------------------------------------------------------"

for ((i=0; i < ${#PLACES[@]}; i++))
do
	for ((j=0; j < ${#SCENARIOS[@]}; j++))
	do
		LOGNAME="${LOG_DIR}/${SCENARIOS[$j]%.*}_${PLACES[$i]}places.log"
		#echo ${SCENARIO[$j]#.}
		#echo $LOGNAME
		export X10_NPLACES=${PLACES[$i]}
		EXE="${CMD} -t ${SCENARIO_DIR}/${SCENARIOS[$j]}"
		${EXE} 1> ${LOGNAME} 2> ${LOGNAME}
	done
done

