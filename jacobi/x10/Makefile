all: jacobi jacobi_nochecks

jacobi:	Jacobi.x10
	x10c++ -O -o $@ Jacobi.x10

jacobi_nochecks: Jacobi.x10
	x10c++ -O -NO_CHECKS -o $@ Jacobi.x10

clean:
	$(RM) jacobi jacobi_nochecks
