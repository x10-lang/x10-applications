

import Lattice;

public class ParallelComplexField extends Lattice {
	public val v : PlaceLocalHandle[Rail[Double]];
	val Ncol : Long;
	val Ndim : Long;
	val Ncol2 : Long;
	val Nvec : Long;
	val Nfld : Long;
	val size : Long;

	def this(x : Long,y : Long,z : Long,t : Long, nc : Long, nd : Long, nf : Long)
	{
		super(x,y,z,t);
		v = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](x*y*z*t*nc*nd*nf*2));

		size = x*y*z*t*nc*nd*nf*2;
		Ncol = nc;
		Ndim = nd;
		Ncol2 = nc*2;
		Nfld = nf;
		Nvec = nc*nd*2;
	}

	public operator this(i : Long) = v()(i);
	public operator this(i : Long) = (t : Double) = {v()(i) = t;}

	public operator this(ic : Long, id : Long, is : Long) = v()(is*Nvec + id*Ncol2 + ic);
	public operator this(ic : Long, id : Long, is : Long) = (t : Double) = {v()(is*Nvec + id*Ncol2 + ic) = t;}


	def Set(t : Double)
	{
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v()(i) = t;
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
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v()(i) = a*v()(i);
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
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v()(i) = w.v()(i);
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
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v()(i) = v()(i) + w.v()(i);
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
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v()(i) = v()(i) - w.v()(i);
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
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v()(i) = v()(i) + a * w.v()(i);
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
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v()(i) = a*v()(i) + w.v()(i);
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
		var t : Double = 0.0;
		for(i in 0..(Nfld*nsite*Nvec-1)){
			t = t + v()(i) * w.v()(i);
		}
		return t;
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
		var t : Double = 0.0;
		for(i in 0..(Nfld*nsite*Nvec-1)){
			t = t + v()(i) * v()(i);
		}
		return t;
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



