// import x10.compiler.Inline;
// import x10.compiler.Pragma;
import x10.compiler.*;
import x10.util.CUDAUtilities;

import Lattice;

public class CUDAParallelComplexField extends Lattice {

//debug
	static val gpu = CUDAEnv.getCUDAPlace();

	// val v : PlaceLocalHandle[Rail[Double]];
	val v : PlaceLocalHandle[Cell[GlobalRail[Double]]];
	val Ncol : Long;
	val Ndim : Long;
	val Ncol2 : Long;
	val Nvec : Long;
	val Nfld : Long;
	val size : Long;
	val nThreads : Long;
	val rngLA : Rail[LongRange];

        val sum = new Rail[Double](1);
	val gsum : PlaceLocalHandle[Cell[GlobalRail[Double]]];
	val gsum_partial : PlaceLocalHandle[Cell[GlobalRail[Double]]];
	val gsum_partial_sub : PlaceLocalHandle[Cell[GlobalRail[Double]]];

	def this(x : Long,y : Long,z : Long,t : Long, nc : Long, nd : Long, nf : Long, nid : Long)
	{
		super(x,y,z,t);
		size = x*y*z*t*nc*nd*nf*2;
		// v = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](x*y*z*t*nc*nd*nf*2));
//debug
		// v = PlaceLocalHandle.make[Cell[GlobalRail[Double]]](Place.places(), ()=>new Cell(CUDAUtilities.makeGlobalRail(here.child(0), x*y*z*t*nc*nd*nf*2, 0 as Double)));
		v = PlaceLocalHandle.make[Cell[GlobalRail[Double]]](Place.places(), ()=>new Cell(CUDAUtilities.makeGlobalRail(CUDAEnv.getCUDAPlace(), x*y*z*t*nc*nd*nf*2, 0 as Double)));

		Ncol = nc;
		Ndim = nd;
		Ncol2 = nc*2;
		Nfld = nf;
		Nvec = nc*nd*2;

		nThreads = nid;
		rngLA = new Rail[LongRange](nThreads);
		for(tid in 0..(nThreads - 1)){
			rngLA(tid) = new LongRange(tid * size / nid,(tid + 1) * size / nid - 1);
		}
//debug
		val max_threads = 1024;
		val threads = Math.min(max_threads, size);
		val blocks = (size / threads) + ((size % threads > 0) ? 1 : 0);

		val blocks_pow:Long;
		// power of 2
		if ((blocks & (blocks - 1)) == 0) {
		  blocks_pow = blocks;
		} else {
		  var pow:Long = 0l;
		  for (var s:Long = blocks; s > 0; s>>=1) pow++;
		  blocks_pow = 1<<pow;
		}

		gsum = PlaceLocalHandle.make[Cell[GlobalRail[Double]]](Place.places(), ()=>new Cell(CUDAUtilities.makeGlobalRail(CUDAEnv.getCUDAPlace(), 1, 0 as Double)));
		gsum_partial = PlaceLocalHandle.make[Cell[GlobalRail[Double]]](Place.places(), ()=>new Cell(CUDAUtilities.makeGlobalRail(CUDAEnv.getCUDAPlace(), blocks_pow, 0 as Double)));
		gsum_partial_sub = PlaceLocalHandle.make[Cell[GlobalRail[Double]]](Place.places(), ()=>new Cell(CUDAUtilities.makeGlobalRail(CUDAEnv.getCUDAPlace(), blocks_pow / max_threads > 0 ? blocks_pow / max_threads : 1, 0 as Double)));
	}

	def Delete() {
	  finish for (h in Place.places()) at(h) async {
	    CUDAUtilities.deleteGlobalRail(v()());
	    CUDAUtilities.deleteGlobalRail(gsum()());
	    CUDAUtilities.deleteGlobalRail(gsum_partial()());
	    CUDAUtilities.deleteGlobalRail(gsum_partial_sub()());
	  }	  
	}

	// public operator this(i : Long) = v()(i);
	// public operator this(i : Long) = (t : Double) = {v()(i) = t;}

	// public operator this(ic : Long, id : Long, is : Long) = v()(is*Nvec + id*Ncol2 + ic);
	// public operator this(ic : Long, id : Long, is : Long) = (t : Double) = {v()(is*Nvec + id*Ncol2 + ic) = t;}

	def Set(v : GlobalRail[Double]{home==gpu}, t : Double)
	{
	  val size = v.size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		val gid = bid * threads + tid;
		val gids = blocks * threads;
		for (var i:Long = gid; i < size; i += gids) {
		  v(i) = t;
		}
              }
	    }
	  }
	}

	def Mult(v : GlobalRail[Double]{home==gpu}, a : Double)
	{
	  val size = v.size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < size; i += gids) {
	  	  v(i) = a * v(i);
	  	}
              }
	    }
	  }
	}

	def Copy(v : GlobalRail[Double]{home==gpu}, w : GlobalRail[Double]{home==gpu})
	{
	  val size = v.size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < size; i += gids) {
	  	  v(i) = w(i);
	  	}
              }
	    }
	  }
	}

	def Add(v : GlobalRail[Double]{home==gpu}, w : GlobalRail[Double]{home==gpu})
	{
	  val size = v.size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < size; i += gids) {
	  	  v(i) = v(i) + w(i);
	  	}
              }
	    }
	  }
	}

	def Sub(v : GlobalRail[Double]{home==gpu}, w : GlobalRail[Double]{home==gpu})
	{
	  val size = v.size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < size; i += gids) {
	  	  v(i) = v(i) - w(i);
	  	}
              }
	    }
	  }
	}

	def MultAdd(a : Double, v:GlobalRail[Double]{home==gpu}, w:GlobalRail[Double]{home==gpu})
	{
	  val size = v.size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
	      clocked finish for (tid in 0n..(threads-1n)) clocked async {
		val gid = bid * threads + tid;
		val gids = blocks * threads;
		for (var i:Long = gid; i < size; i += gids) {
		  v(i) = v(i) + a * w(i);
		}
	      }
	    }
	  }
	}

	def MultAdd2(a : Double, v:GlobalRail[Double]{home==gpu}, w:GlobalRail[Double]{home==gpu}, a2 : Double, v2:GlobalRail[Double]{home==gpu}, w2:GlobalRail[Double]{home==gpu})
	{
	  val size = v.size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
	      clocked finish for (tid in 0n..(threads-1n)) clocked async {
		val gid = bid * threads + tid;
		val gids = blocks * threads;
		for (var i:Long = gid; i < size; i += gids) {
		  v(i) = v(i) + a * w(i);
		}
		for (var i:Long = gid; i < size; i += gids) {
		  v2(i) = v2(i) + a2 * w2(i);
		}
	      }
	    }
	  }
	}

	def MultAndAdd(a : Double, v:GlobalRail[Double]{home==gpu}, w:GlobalRail[Double]{home==gpu})
	{
	  val size = v.size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
	      clocked finish for (tid in 0n..(threads-1n)) clocked async {
		val gid = bid * threads + tid;
		val gids = blocks * threads;
		for (var i:Long = gid; i < size; i += gids) {
		  v(i) = a * v(i) + w(i);
		}
	      }
	    }
	  }
	}

	def Dot(v : GlobalRail[Double]{home==gpu}, w : GlobalRail[Double]{home==gpu}) : Double
	{
	  val size = v.size;
	  return ReductionKernel(v, w, size, 0);
	}

	def Norm(v : GlobalRail[Double]{home==gpu}) : Double
	{
	  val size = v.size;
	  return ReductionKernel(v, v, size, 0);
	}

        def ReductionKernel(v1:GlobalRail[Double]{home==gpu}, v2:GlobalRail[Double]{home==gpu}, size:Long, offset:Long) : Double {

	  //debug
	  val max_threads = 1024;
	  val threads = Math.min(max_threads, size);
	  val blocks = (size / threads) + ((size % threads > 0) ? 1 : 0);

	  val blocks_pow:Long;
	  // power of 2
	  if ((blocks & (blocks - 1)) == 0) {
	    blocks_pow = blocks;
	  } else {
	    var pow:Long = 0l;
	    for (var s:Long = blocks; s > 0; s>>=1) pow++;
	    blocks_pow = 1<<pow;
	  }

	  // val gsum_partial = CUDAUtilities.makeGlobalRail[Double](gpu, blocks_pow, 0 as Double);
	  // val gsum = CUDAUtilities.makeGlobalRail[Double](gpu, 1, 0 as Double);
	  val gsum_partial_ = gsum_partial()();
	  val gsum_ = gsum()();

	  // Console.OUT.println("Reduce2<<<" + blocks + ", " + threads + ">>>");
	  // Reduce2(gsum_partial, blocks, threads, v1, v2, size, offset);
	  Reduce2(gsum_partial_, blocks, threads/2, v1, v2, size, offset);

	  if (blocks_pow > max_threads) {
	    val threads_sub = max_threads;
	    val blocks_sub = blocks_pow / threads_sub;
	    // val gsum_partial_sub = CUDAUtilities.makeGlobalRail[Double](gpu, blocks_sub, 0 as Double);
	    val gsum_partial_sub_ = gsum_partial_sub()();

	    // Console.OUT.println("Reduce<<<" + blocks_sub + ", " + threads_sub + ">>>");
	    Reduce(gsum_partial_sub_, blocks_sub, threads_sub/2, gsum_partial_, blocks_pow, 0);
	    // Console.OUT.println("Reduce<<<" + 1 + ", " + blocks_sub + ">>>");
	    Reduce(gsum_, 1, blocks_sub/2, gsum_partial_sub_, blocks_sub, 0);
	  } else {
	    // Console.OUT.println("Reduce<<<" + 1 + ", " + blocks_pow + ">>>");
	    Reduce(gsum_, 1, blocks_pow/2, gsum_partial_, blocks, 0);
	  }

	  // val sum = new Rail[Double](1);
	  val sum_ = sum;

	  // D2H
	  finish {
	    Rail.asyncCopy(gsum_, 0l, sum_, 0l, 1); 
	  }

	  // CUDAUtilities.deleteGlobalRail(gsum_partial);
	  // CUDAUtilities.deleteGlobalRail(gsum);

	  return sum_(0);
	}

        def Reduce(gsum:GlobalRail[Double]{home==gpu},
		   blocks:Long, 
		   threads:Long, 
		   v:GlobalRail[Double]{home==gpu}, 
		   size:Long, 
		   offset:Long) {
	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..Int.operator_as(blocks-1n)) async {
	      var ssum : Rail[Double] = new Rail[Double](threads, 0);
	      clocked finish for (tid in 0n..Int.operator_as(threads-1n)) clocked async {
		val gid = bid * (2 * threads) + tid;
		val gids = blocks * (2 * threads);
		// val gid = bid * threads + tid;
		// val gids = blocks * threads;
		ssum(tid) = 0;

		for (var i:Long = gid + offset; i < size + offset; i += gids) {
		  ssum(tid) = ssum(tid) + v(i) + v(i + threads);
		  // ssum(tid) = ssum(tid) + v(i);
		}
		Clock.advanceAll();

		// if (threads >= 1024) { if (tid < 512) { ssum(tid) = ssum(tid) + ssum(tid + 512); } Clock.advanceAll(); }
		if (threads >=  512) { if (tid < 256) { ssum(tid) = ssum(tid) + ssum(tid + 256); } Clock.advanceAll(); }
		if (threads >=  256) { if (tid < 128) { ssum(tid) = ssum(tid) + ssum(tid + 128); } Clock.advanceAll(); }
		if (threads >=  128) { if (tid <  64) { ssum(tid) = ssum(tid) + ssum(tid +  64); } Clock.advanceAll(); }

		if (tid < 32) {
		  if (threads >= 64) ssum(tid) = ssum(tid) + ssum(tid + 32);
		  if (threads >= 32) ssum(tid) = ssum(tid) + ssum(tid + 16);
		  if (threads >= 16) ssum(tid) = ssum(tid) + ssum(tid +  8);
		  if (threads >=  8) ssum(tid) = ssum(tid) + ssum(tid +  4);
		  if (threads >=  4) ssum(tid) = ssum(tid) + ssum(tid +  2);
		  if (threads >=  2) ssum(tid) = ssum(tid) + ssum(tid +  1);
		}

		//error sm_10	  
		//debug
		if (tid == 0n) gsum(bid) = ssum(0);
		// if (tid == 0n) gsum(tid) = ssum(tid);
	      }
	    }
	  }
	}

        def Reduce2(gsum:GlobalRail[Double]{home==gpu},
		    blocks:Long, 
		    threads:Long, 
		    v1:GlobalRail[Double]{home==gpu}, 
		    v2:GlobalRail[Double]{home==gpu}, 
		    size:Long, 
		    offset:Long) {
	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..Int.operator_as(blocks-1n)) async {
	      var ssum : Rail[Double] = new Rail[Double](threads, 0);
	      clocked finish for (tid in 0n..Int.operator_as(threads-1n)) clocked async {
		val gid = bid * (2 * threads) + tid;
		val gids = blocks * (2 * threads);
		// val gid = bid * threads + tid;
		// val gids = blocks * threads;
		ssum(tid) = 0;
		
		for (var i:Long = gid + offset; i < size + offset; i += gids) {
		  ssum(tid) = ssum(tid) + (v1(i) * v2(i)) + (v1(i + threads) * v2(i + threads));
		  // ssum(tid) = ssum(tid) + (v1(i) * v2(i));
		}
		Clock.advanceAll();

		// if (threads >= 1024) { if (tid < 512) { ssum(tid) = ssum(tid) + ssum(tid + 512); } Clock.advanceAll(); }
		if (threads >=  512) { if (tid < 256) { ssum(tid) = ssum(tid) + ssum(tid + 256); } Clock.advanceAll(); }
		if (threads >=  256) { if (tid < 128) { ssum(tid) = ssum(tid) + ssum(tid + 128); } Clock.advanceAll(); }
		if (threads >=  128) { if (tid <  64) { ssum(tid) = ssum(tid) + ssum(tid +  64); } Clock.advanceAll(); }

		if (tid < 32) {
		  if (threads >= 64) ssum(tid) = ssum(tid) + ssum(tid + 32);
		  if (threads >= 32) ssum(tid) = ssum(tid) + ssum(tid + 16);
		  if (threads >= 16) ssum(tid) = ssum(tid) + ssum(tid +  8);
		  if (threads >=  8) ssum(tid) = ssum(tid) + ssum(tid +  4);
		  if (threads >=  4) ssum(tid) = ssum(tid) + ssum(tid +  2);
		  if (threads >=  2) ssum(tid) = ssum(tid) + ssum(tid +  1);
		}

		//error sm_10	  
		//debug
		if (tid == 0n) gsum(bid) = ssum(0);
		// if (tid == 0n) gsum(tid) = ssum(tid);
	      }
	    }
	  }
	}


/*
	def Set(t : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v()(i) = t;
			}
		}
	}
// unknown error
	def Set(t : Double)
	{
	  val size_ = size;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		val gid = bid * threads + tid;
		val gids = blocks * threads;
		for (var i:Long = gid; i < size_; i += gids) {
		  v()()(i) = t;
		}
              }
	    }
	  }
	}

	def Set(t : Double, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v()(i) = t;
		}
	}

	def Mult(a : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v()(i) = a*v()(i);
			}
		}
	}
	def Mult(a : Double, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v()(i) = a*v()(i);
		}
	}

	def Copy(w : ParallelComplexField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v()(i) = w.v()(i);
			}
		}
	}
	def Copy(w : ParallelComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v()(i) = w.v()(i);
		}
	}

	def Add(w : WilsonVectorField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v()(i) = v()(i) + w.v()(i);
			}
		}
	}
	def Add(w : ParallelComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v()(i) = v()(i) + w.v()(i);
		}
	}

	def Sub(w : ParallelComplexField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v()(i) = v()(i) - w.v()(i);
			}
		}
	}
	def Sub(w : ParallelComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v()(i) = v()(i) - w.v()(i);
		}
	}

	def MultAdd(a : Double, w : ParallelComplexField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v()(i) = v()(i) + a * w.v()(i);
			}
		}
	}
	def MultAdd(a : Double, w : ParallelComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v()(i) = v()(i) + a * w.v()(i);
		}
	}

	def SPX(a : Double, w : ParallelComplexField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v()(i) = a*v()(i) + w.v()(i);
			}
		}
	}
	def SPX(a : Double, w : ParallelComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v()(i) = a*v()(i) + w.v()(i);
		}
	}

	def Dot(w : ParallelComplexField) : Double
	{
		var ret : Double = 0.0;
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			var t : Double = 0.0;
			for(i in rngLA(tid)){
				t = t + v()(i) * w.v()(i);
			}
			atomic ret += t;
		}
		return ret;
	}
	def Dot(w : ParallelComplexField, rng : LongRange) : Double
	{
		var t : Double = 0.0;
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			t = t + v()(i) * w.v()(i);
		}
		return t;
	}

	def Norm() : Double
	{
		var ret : Double = 0.0;
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			var t : Double = 0.0;
			for(i in rngLA(tid)){
				t = t + v()(i) * v()(i);
			}
			atomic ret += t;
		}
		return ret;
	}
	def Norm(rng : LongRange) : Double
	{
		var t : Double = 0.0;
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			t = t + v()(i) * v()(i);
		}
		return t;
	}
*/

}



