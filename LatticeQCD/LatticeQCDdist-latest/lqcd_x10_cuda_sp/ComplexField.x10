

import Lattice;

public class ComplexField extends Lattice {
	public val v : Rail[Float];
	val Ncol : Long;
	val Ndim : Long;
	val Ncol2 : Long;
	val Nvec : Long;
	val Nfld : Long;

	def this(x : Long,y : Long,z : Long,t : Long, nc : Long, nd : Long, nf : Long)
	{
		super(x,y,z,t);
		v = new Rail[Float](x*y*z*t*nc*nd*nf*2);

		Ncol = nc;
		Ndim = nd;
		Ncol2 = nc*2;
		Nfld = nf;
		Nvec = nc*nd*2;
	}

	public operator this(i : Long) = v(i);
	public operator this(i : Long) = (t : Float) {v(i) = t;}

	public operator this(ic : Long, id : Long, is : Long) = v(is*Nvec + id*Ncol2 + ic);
	public operator this(ic : Long, id : Long, is : Long) = (t : Float) {v(is*Nvec + id*Ncol2 + ic) = t;}


	def Set(t : Float)
	{
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v(i) = t;
		}
	}
	def Set(t : Float, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v(i) = t;
		}
	}

	def Mult(a : Float)
	{
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v(i) = a*v(i);
		}
	}
	def Mult(a : Float, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v(i) = a*v(i);
		}
	}

	def Copy(w : ComplexField)
	{
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v(i) = w.v(i);
		}
	}
	def Copy(w : ComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v(i) = w.v(i);
		}
	}

	def Add(w : ComplexField)
	{
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v(i) = v(i) + w.v(i);
		}
	}
	def Add(w : ComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v(i) = v(i) + w.v(i);
		}
	}

	def Sub(w : ComplexField)
	{
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v(i) = v(i) - w.v(i);
		}
	}
	def Sub(w : ComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v(i) = v(i) - w.v(i);
		}
	}

	def MultAdd(a : Float, w : ComplexField)
	{
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v(i) = v(i) + a * w.v(i);
		}
	}
	def MultAdd(a : Float, w : ComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v(i) = v(i) + a * w.v(i);
		}
	}

	def SPX(a : Float, w : ComplexField)
	{
		for(i in 0..(Nfld*nsite*Nvec-1)){
			v(i) = a*v(i) + w.v(i);
		}
	}
	def SPX(a : Float, w : ComplexField, rng : LongRange)
	{
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			v(i) = a*v(i) + w.v(i);
		}
	}

	def Dot(w : ComplexField) : Float
	{
		var t : Float = 0.0f;
		for(i in 0..(Nfld*nsite*Nvec-1)){
			t = t + v(i) * w.v(i);
		}
		return t;
	}
	def Dot(w : ComplexField, rng : LongRange) : Float
	{
		var t : Float = 0.0f;
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			t = t + v(i) * w.v(i);
		}
		return t;
	}

	def Norm() : Float
	{
		var t : Float = 0.0f;
		for(i in 0..(Nfld*nsite*Nvec-1)){
			t = t + v(i) * v(i);
		}
		return t;
	}
	def Norm(rng : LongRange) : Float
	{
		var t : Float = 0.0f;
		for(i in (rng.min*Nvec)..(rng.max*Nvec-1)){
			t = t + v(i) * v(i);
		}
		return t;
	}


}



