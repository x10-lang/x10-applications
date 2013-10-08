include ../Makefile.h

ifdef INCLUDE_MADRE
MADRE_LIB = ${MADRE_HOME}/lib 
LINK_MAIN = ${MPICC} ${CFLAGS} -o $@ -I ${INC} Main.c  -L../lib -lmc -L${MADRE_LIB} -lmadre -lm
else
LINK_MAIN = ${MPICC} ${CFLAGS} -o $@ -I ${INC} Main.c  -L../lib -lmc -lm
endif

Main: Main.c ../lib/libmc.a
ifdef LOG_FPMPI
	$(LINK_MAIN) -L${FPMPIDIR} -lfpmpi
else
ifdef LOG_MPE
	$(LINK_MAIN) -mpe=mpilog
else
	$(LINK_MAIN) 
endif
endif

clean: 
	\rm -f *.o Main *~ *error *output *cobaltlog
