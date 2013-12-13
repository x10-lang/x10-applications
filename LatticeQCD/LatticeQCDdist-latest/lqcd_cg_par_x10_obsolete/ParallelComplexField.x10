import x10.compiler.Inline;
import x10.compiler.Pragma;


import Lattice;

public class ParallelComplexField extends Lattice {
	val v : PlaceLocalHandle[Rail[Double]];
	val Ncol : Long;
	val Ndim : Long;
	val Ncol2 : Long;
	val Nvec : Long;
	val Nfld : Long;
	val size : Long;
	val nThreads : Long;
	val rngLA : Rail[LongRange];


	def this(x : Long,y : Long,z : Long,t : Long, nc : Long, nd : Long, nf : Long, nid : Long)
	{
		super(x,y,z,t);
		size = x*y*z*t*nc*nd*nf*2;
		v = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](x*y*z*t*nc*nd*nf*2));

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
	}

	public operator this(i : Long) = v()(i);
	public operator this(i : Long) = (t : Double) = {v()(i) = t;}

	public operator this(ic : Long, id : Long, is : Long) = v()(is*Nvec + id*Ncol2 + ic);
	public operator this(ic : Long, id : Long, is : Long) = (t : Double) = {v()(is*Nvec + id*Ncol2 + ic) = t;}


	def Set(t : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v()(i) = t;
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


}



