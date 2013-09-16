all: jacobi jacobi_nochecks jacobi_cf jacobi_cf_nochecks jacobi_spmd jacobi_spmd_nochecks

jacobi:	Jacobi.x10
	x10c++ -O -o $@ Jacobi.x10

jacobi_nochecks: Jacobi.x10
	x10c++ -O -NO_CHECKS -o $@ Jacobi.x10

jacobi_cf: JacobiCF.x10
	x10c++ -O -o $@ JacobiCF.x10

jacobi_cf_nochecks: JacobiCF.x10
	x10c++ -O -NO_CHECKS -o $@ JacobiCF.x10

jacobi_spmd: JacobiSPMD.x10
	x10c++ -O -o $@ JacobiSPMD.x10

jacobi_spmd_nochecks: JacobiSPMD.x10
	x10c++ -O -NO_CHECKS -o $@ JacobiSPMD.x10

clean:
	$(RM) jacobi jacobi_nochecks jacobi_cf jacobi_cf_nochecks \
	      jacobi_spmd jacobi_spmd_nochecks
