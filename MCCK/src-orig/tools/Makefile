include ../Makefile.h

test: MADRE leakage1 leakage0
MADRE:
	./MADREtest $(MPIEXEC)
leakage1:
	./leakage1test $(MPIEXEC)
leakage0:
	./leakage0test $(MPIEXEC)
clean: 
	\rm -f *.o Main *~ *error *output 
program:
	make clean -C ..
	make libmc.a -C ..
	${MPICC} ${CFLAGS} -o test -I ${INC} test.c  -L../lib -lmc -lm
MADREprogram:
	make clean -C ..
	make libmc.a -C .. INCLUDE_MADRE=1
	${MPICC} ${CFLAGS} -o test -I ${INC} test.c  -L../lib -lmc -L$(MADRE_HOME)/lib -lmadre -lm