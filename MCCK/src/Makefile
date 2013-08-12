include ../Makefile.h
OBJS = MC_Init.o MC_Cycle.o MC_Set_particles.o MC_Utils.o particle.o MC_Comm.o

ifdef INCLUDE_MADRE
CFLAGS = -g -DINCLUDE_MADRE
MADRE_INC = ${MADRE_HOME}/include
define COMPILE_MC_COMM
@echo "Compiling MC_Comm.c with MADRE"
${MPICC} ${CFLAGS} -I${MADRE_INC} -I ${INC} -c MC_Comm.c	
endef
else	
CFLAGS = -g
define COMPILE_MC_COMM
@echo "Compiling MC_Comm.c without MADRE"
${MPICC} ${CFLAGS} -I ${INC} -c MC_Comm.c
endef
endif	

all: libmc.a
libmc.a: ${OBJS}
	ar -rv ../lib/libmc.a ${OBJS}
MC_Init.o: MC_Init.c ${INC}/MC.h
	${MPICC} ${CFLAGS} -I ${INC} -c MC_Init.c
MC_Cycle.o: MC_Cycle.c ${INC}/MC.h
	${MPICC} ${CFLAGS} -I ${INC} -c MC_Cycle.c
MC_Comm.o: MC_Comm.c ${INC}/MC.h
	${COMPILE_MC_COMM}
MC_Set_particles.o: MC_Set_particles.c ${INC}/MC.h
	${MPICC} ${CFLAGS} -I ${INC} -c MC_Set_particles.c
MC_Utils.o: MC_Utils.c ${INC}/MC.h
	${MPICC} ${CFLAGS} -I ${INC} -c MC_Utils.c
particle.o: particle.c ${INC}/particle.h
	${MPICC} ${CFLAGS} -I ${INC} -c particle.c
clean: 
	\rm -f *.o Main *~