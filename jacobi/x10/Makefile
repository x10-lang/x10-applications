all: jacobi jacobi_nochecks jacobi_cf jacobi_cf_nochecks jacobi_spmd jacobi_spmd_nochecks jacobi_spmd_barrier jacobi_spmd_barrier_nochecks jacobi_seq jacobi_seq_nochecks jacobi_omp jacobi_omp_nochecks

X10FLAG = -O
# enable CPU profiling with google-perftools
PROFILE ?=
ifdef PROFILE
  X10FLAG += -gpt
endif

jacobi:	Jacobi.x10
	x10c++ $(X10FLAG) -o $@ $<

jacobi_nochecks: Jacobi.x10
	x10c++ $(X10FLAG) -NO_CHECKS -o $@ $<

jacobi_seq: JacobiSeq.x10
	x10c++ $(X10FLAG) -o $@ JacobiSeq.x10

jacobi_seq_nochecks: JacobiSeq.x10
	x10c++ $(X10FLAG) -NO_CHECKS -o $@ $<

jacobi_cf: JacobiCF.x10
	x10c++ $(X10FLAG) -o $@ JacobiCF.x10

jacobi_cf_nochecks: JacobiCF.x10
	x10c++ $(X10FLAG) -NO_CHECKS -o $@ $<

jacobi_spmd: JacobiSPMD.x10
	x10c++ $(X10FLAG) -o $@ $<

jacobi_spmd_nochecks: JacobiSPMD.x10
	x10c++ $(X10FLAG) -NO_CHECKS -o $@ $<

jacobi_omp: JacobiOMP.x10 OMPBarrier.x10
	x10c++ $(X10FLAG) -o $@ $<

jacobi_omp_nochecks: JacobiOMP.x10 OMPBarrier.x10
	x10c++ $(X10FLAG) -NO_CHECKS -o $@ $<

jacobi_spmd_barrier: JacobiSPMD_Barrier.x10
	x10c++ $(X10FLAG) -o $@ $<

jacobi_spmd_barrier_nochecks: JacobiSPMD_Barrier.x10
	x10c++ $(X10FLAG) -NO_CHECKS -o $@ $<

clean:
	$(RM) jacobi jacobi_nochecks jacobi_seq jacobi_seq_nochecks \
	      jacobi_cf jacobi_cf_nochecks jacobi_spmd jacobi_spmd_nochecks
