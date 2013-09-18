all: jacobi jacobi_nochecks jacobi_cf jacobi_cf_nochecks jacobi_spmd jacobi_spmd_nochecks jacobi_spmd_barrier jacobi_spmd_barrier_nochecks

jacobi:	Jacobi.x10
	x10c++ -O -o $@ $<

jacobi_nochecks: Jacobi.x10
	x10c++ -O -NO_CHECKS -o $@ $<

jacobi_seq: JacobiSeq.x10
	x10c++ -O -o $@ JacobiSeq.x10

jacobi_seq_nochecks: JacobiSeq.x10
	x10c++ -O -NO_CHECKS -o $@ $<

jacobi_cf: JacobiCF.x10
	x10c++ -O -o $@ JacobiCF.x10

jacobi_cf_nochecks: JacobiCF.x10
	x10c++ -O -NO_CHECKS -o $@ $<

jacobi_spmd: JacobiSPMD.x10
	x10c++ -O -o $@ $<

jacobi_spmd_nochecks: JacobiSPMD.x10
	x10c++ -O -NO_CHECKS -o $@ $<

jacobi_spmd_barrier: JacobiSPMD_Barrier.x10
	x10c++ -O -o $@ $<

jacobi_spmd_barrier_nochecks: JacobiSPMD_Barrier.x10
	x10c++ -O -NO_CHECKS -o $@ $<

clean:
	$(RM) jacobi jacobi_nochecks jacobi_seq jacobi_seq_nochecks \
	      jacobi_cf jacobi_cf_nochecks jacobi_spmd jacobi_spmd_nochecks
