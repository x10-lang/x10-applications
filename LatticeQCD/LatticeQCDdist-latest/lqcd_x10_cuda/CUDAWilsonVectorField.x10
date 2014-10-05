import x10.compiler.*;
import x10.util.CUDAUtilities;

import CUDAParallelComplexField;


public class CUDAWilsonVectorField extends CUDAParallelComplexField {

	def this(x : Long,y : Long,z : Long,t : Long)
	{
		super(x,y,z,t,3,4,1,1);
	}

	def MultGamma5(dv : GlobalRail[Double]{home==gpu})
	{
	  val nsite_ = nsite;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
	      clocked finish for (tid in 0n..(threads-1n)) clocked async {
		val gid = bid * threads + tid;
		val gids = blocks * threads;

		var t0r : Double;
		var t0i : Double;
		var t1r : Double;
		var t1i : Double;

		for (var i:Long = gid; i < nsite_; i += gids) {
		  // for(i in 0..(nsite-1)){
		  t0r = dv(i);
		  t0i = dv(i + 1*nsite_);
		  t1r = dv(i + 6*nsite_);
		  t1i = dv(i + 7*nsite_);
		  dv(i          ) = dv(i + 12*nsite_);
		  dv(i + 1*nsite_) = dv(i + 13*nsite_);
		  dv(i + 6*nsite_) = dv(i + 18*nsite_);
		  dv(i + 7*nsite_) = dv(i + 19*nsite_);
		  dv(i +12*nsite_) = t0r;
		  dv(i +13*nsite_) = t0i;
		  dv(i +18*nsite_) = t1r;
		  dv(i +19*nsite_) = t1i;

		  t0r = dv(i + 2*nsite_);
		  t0i = dv(i + 3*nsite_);
		  t1r = dv(i + 8*nsite_);
		  t1i = dv(i + 9*nsite_);
		  dv(i + 2*nsite_) = dv(i + 14*nsite_);
		  dv(i + 3*nsite_) = dv(i + 15*nsite_);
		  dv(i + 8*nsite_) = dv(i + 20*nsite_);
		  dv(i + 9*nsite_) = dv(i + 21*nsite_);
		  dv(i +14*nsite_) = t0r;
		  dv(i +15*nsite_) = t0i;
		  dv(i +20*nsite_) = t1r;
		  dv(i +21*nsite_) = t1i;

		  t0r = dv(i + 4*nsite_);
		  t0i = dv(i + 5*nsite_);
		  t1r = dv(i +10*nsite_);
		  t1i = dv(i +11*nsite_);
		  dv(i + 4*nsite_) = dv(i + 16*nsite_);
		  dv(i + 5*nsite_) = dv(i + 17*nsite_);
		  dv(i +10*nsite_) = dv(i + 22*nsite_);
		  dv(i +11*nsite_) = dv(i + 23*nsite_);
		  dv(i +16*nsite_) = t0r;
		  dv(i +17*nsite_) = t0i;
		  dv(i +22*nsite_) = t1r;
		  dv(i +23*nsite_) = t1i;
		}
	      }
	    }
	  }
	}

/*
	def MultGamma5(rng : LongRange)
	{
		var t0r : Double;
		var t0i : Double;
		var t1r : Double;
		var t1i : Double;
		for(i in (rng.min)..(rng.max-1)){
			t0r = v()(i*24);
			t0i = v()(i*24 + 1);
			t1r = v()(i*24 + 6);
			t1i = v()(i*24 + 7);
			v()(i*24    ) = v()(i*24 + 12);
			v()(i*24 + 1) = v()(i*24 + 13);
			v()(i*24 + 6) = v()(i*24 + 18);
			v()(i*24 + 7) = v()(i*24 + 19);
			v()(i*24 +12) = t0r;
			v()(i*24 +13) = t0i;
			v()(i*24 +18) = t1r;
			v()(i*24 +19) = t1i;

			t0r = v()(i*24 + 2);
			t0i = v()(i*24 + 3);
			t1r = v()(i*24 + 8);
			t1i = v()(i*24 + 9);
			v()(i*24 + 2) = v()(i*24 + 14);
			v()(i*24 + 3) = v()(i*24 + 15);
			v()(i*24 + 8) = v()(i*24 + 20);
			v()(i*24 + 9) = v()(i*24 + 21);
			v()(i*24 +14) = t0r;
			v()(i*24 +15) = t0i;
			v()(i*24 +20) = t1r;
			v()(i*24 +21) = t1i;

			t0r = v()(i*24 + 4);
			t0i = v()(i*24 + 5);
			t1r = v()(i*24 +10);
			t1i = v()(i*24 +11);
			v()(i*24 + 4) = v()(i*24 + 16);
			v()(i*24 + 5) = v()(i*24 + 17);
			v()(i*24 +10) = v()(i*24 + 22);
			v()(i*24 +11) = v()(i*24 + 23);
			v()(i*24 +16) = t0r;
			v()(i*24 +17) = t0i;
			v()(i*24 +22) = t1r;
			v()(i*24 +23) = t1i;
		}
	}
*/
}
