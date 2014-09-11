

import WilsonVectorField;
import SU3MatrixField;
import HalfWilsonVectorField;

import CUDAWilsonVectorField;
import CUDASU3MatrixField;
// import CUDAHalfWilsonVectorField;

import CUDALatticeComm;

//debug
import Lattice;

// import x10.compiler.Inline;
// import x10.compiler.Pragma;
import x10.compiler.*;

import x10.util.Team;
import x10.util.CUDAUtilities;


final class GetGCD {
	static def Do(a : Long, b: Long)
	{
		var i : Long;
		var j : Long;
		var t : Long;

		if(a == b){
			return a;
		}
		else if(a > b){
			t = b;
			j = a;
		}
		else{
			j = b;
			t = a;
		}
		i = j;
		j = t;
		t = j % i;
		while(t != 0){
			i = j;
			j = t;
			t = j % i;
		}
		return i;
	}
}


// class HalfWilsonMult {
//debug
class HalfWilsonMult extends Lattice {
	var h0_0r : Float;
	var h0_0i : Float;
	var h0_1r : Float;
	var h0_1i : Float;
	var h0_2r : Float;
	var h0_2i : Float;
	var h1_0r : Float;
	var h1_0i : Float;
	var h1_1r : Float;
	var h1_1i : Float;
	var h1_2r : Float;
	var h1_2i : Float;

//debug
	def this(x : Long,y : Long,z : Long,t : Long)
	{
		super(x,y,z,t);
	}

	@Inline def Load(w : Rail[Float], iw : Long)
	{
		h0_0r  = w(iw*12+0);		h0_0i  = w(iw*12+1);
		h0_1r  = w(iw*12+2);		h0_1i  = w(iw*12+3);
		h0_2r  = w(iw*12+4);		h0_2i  = w(iw*12+5);

		h1_0r  = w(iw*12+6);		h1_0i  = w(iw*12+7);
		h1_1r  = w(iw*12+8);		h1_1i  = w(iw*12+9);
		h1_2r = w(iw*12+10);	        h1_2i = w(iw*12+11);
	}

	@Inline def Store(w : Rail[Float], iw : Long)
	{
		w(iw*12+0) = h0_0r;		w(iw*12+1) = h0_0i;
		w(iw*12+2) = h0_1r;		w(iw*12+3) = h0_1i;
		w(iw*12+4) = h0_2r;		w(iw*12+5) = h0_2i;

		w(iw*12+6) = h1_0r;		w(iw*12+7) = h1_0i;
		w(iw*12+8) = h1_1r;		w(iw*12+9) = h1_1i;
		w(iw*12+10)= h1_2r;		w(iw*12+11)= h1_2i;
	}

	@Inline def PackXP(w : Rail[Float], iw : Long)
	{
		// val pos = iw*24;
	        val pos = iw;
		//h0 = w0 + i*w3
		h0_0r = w(pos  ) - w(pos+19*nsite);		h0_0i = w(pos+1*nsite) + w(pos+18*nsite);
		h0_1r = w(pos+2*nsite) - w(pos+21*nsite);		h0_1i = w(pos+3*nsite) + w(pos+20*nsite);
		h0_2r = w(pos+4*nsite) - w(pos+23*nsite);		h0_2i = w(pos+5*nsite) + w(pos+22*nsite);

		//h1 = w1 + i*w2
		h1_0r = w(pos+6*nsite) - w(pos+13*nsite);		h1_0i = w(pos+7*nsite) + w(pos+12*nsite);
		h1_1r = w(pos+8*nsite) - w(pos+15*nsite);		h1_1i = w(pos+9*nsite) + w(pos+14*nsite);
		h1_2r = w(pos+10*nsite)- w(pos+17*nsite);		h1_2i = w(pos+11*nsite)+ w(pos+16*nsite);
	}

	@Inline def PackXM(w : Rail[Float], iw : Long)
	{
	        val pos = iw;
		//h0 = w0 - i*w3
		h0_0r = w(pos+0*nsite) + w(pos+19*nsite);		h0_0i = w(pos+1*nsite) - w(pos+18*nsite);
		h0_1r = w(pos+2*nsite) + w(pos+21*nsite);		h0_1i = w(pos+3*nsite) - w(pos+20*nsite);
		h0_2r = w(pos+4*nsite) + w(pos+23*nsite);		h0_2i = w(pos+5*nsite) - w(pos+22*nsite);

		//h1 = w1 - i*w2
		h1_0r = w(pos+6*nsite) + w(pos+13*nsite);		h1_0i = w(pos+7*nsite) - w(pos+12*nsite);
		h1_1r = w(pos+8*nsite) + w(pos+15*nsite);		h1_1i = w(pos+9*nsite) - w(pos+14*nsite);
		h1_2r= w(pos+10*nsite)+ w(pos+17*nsite);		h1_2i= w(pos+11*nsite)- w(pos+16*nsite);
	}

	@Inline def PackYP(w : Rail[Float], iw : Long)
	{
		val pos = iw;
		//h0 = w0 + w3
		h0_0r = w(pos+0*nsite) + w(pos+18*nsite);		h0_0i = w(pos+1*nsite) + w(pos+19*nsite);
		h0_1r = w(pos+2*nsite) + w(pos+20*nsite);		h0_1i = w(pos+3*nsite) + w(pos+21*nsite);
		h0_2r = w(pos+4*nsite) + w(pos+22*nsite);		h0_2i = w(pos+5*nsite) + w(pos+23*nsite);

		//h1 = w1 - w2
		h1_0r = w(pos+6*nsite) - w(pos+12*nsite);		h1_0i = w(pos+7*nsite) - w(pos+13*nsite);
		h1_1r = w(pos+8*nsite) - w(pos+14*nsite);		h1_1i = w(pos+9*nsite) - w(pos+15*nsite);
		h1_2r= w(pos+10*nsite)- w(pos+16*nsite);		h1_2i= w(pos+11*nsite)- w(pos+17*nsite);
	}

	@Inline def PackYM(w : Rail[Float], iw : Long)
	{
		val pos = iw;
		//h0 = w0 - w3
		h0_0r = w(pos+0*nsite) - w(pos+18*nsite);		h0_0i = w(pos+1*nsite) - w(pos+19*nsite);
		h0_1r = w(pos+2*nsite) - w(pos+20*nsite);		h0_1i = w(pos+3*nsite) - w(pos+21*nsite);
		h0_2r = w(pos+4*nsite) - w(pos+22*nsite);		h0_2i = w(pos+5*nsite) - w(pos+23*nsite);

		//h1 = w1 + w2
		h1_0r = w(pos+6*nsite) + w(pos+12*nsite);		h1_0i = w(pos+7*nsite) + w(pos+13*nsite);
		h1_1r = w(pos+8*nsite) + w(pos+14*nsite);		h1_1i = w(pos+9*nsite) + w(pos+15*nsite);
		h1_2r= w(pos+10*nsite)+ w(pos+16*nsite);		h1_2i= w(pos+11*nsite)+ w(pos+17*nsite);
	}
	
	@Inline def PackZP(w : Rail[Float], iw : Long)
	{
		val pos = iw;
		//h0 = w0 + i*w2
		h0_0r = w(pos+0*nsite) - w(pos+13*nsite);		h0_0i = w(pos+1*nsite) + w(pos+12*nsite);
		h0_1r = w(pos+2*nsite) - w(pos+15*nsite);		h0_1i = w(pos+3*nsite) + w(pos+14*nsite);
		h0_2r = w(pos+4*nsite) - w(pos+17*nsite);		h0_2i = w(pos+5*nsite) + w(pos+16*nsite);

		//h1 = w1 - i*w3
		h1_0r = w(pos+6*nsite) + w(pos+19*nsite);		h1_0i = w(pos+7*nsite) - w(pos+18*nsite);
		h1_1r = w(pos+8*nsite) + w(pos+21*nsite);		h1_1i = w(pos+9*nsite) - w(pos+20*nsite);
		h1_2r= w(pos+10*nsite)+ w(pos+23*nsite);		h1_2i= w(pos+11*nsite)- w(pos+22*nsite);
	}

	@Inline def PackZM(w : Rail[Float], iw : Long)
	{
		val pos = iw;
		//h0 = w0 - i*w3
		h0_0r = w(pos+0*nsite) + w(pos+13*nsite);		h0_0i = w(pos+1*nsite) - w(pos+12*nsite);
		h0_1r = w(pos+2*nsite) + w(pos+15*nsite);		h0_1i = w(pos+3*nsite) - w(pos+14*nsite);
		h0_2r = w(pos+4*nsite) + w(pos+17*nsite);		h0_2i = w(pos+5*nsite) - w(pos+16*nsite);

		//h1 = w1 + i*w2
		h1_0r = w(pos+6*nsite) - w(pos+19*nsite);		h1_0i = w(pos+7*nsite) + w(pos+18*nsite);
		h1_1r = w(pos+8*nsite) - w(pos+21*nsite);		h1_1i = w(pos+9*nsite) + w(pos+20*nsite);
		h1_2r= w(pos+10*nsite)- w(pos+23*nsite);		h1_2i= w(pos+11*nsite)+ w(pos+22*nsite);
	}

	//Dirac representation
	@Inline def PackTP(w : Rail[Float], iw : Long)
	{
		val pos = iw;
		//h0 = 2.0*w2
		h0_0r = 2.0f*w(pos+12*nsite);		h0_0i = 2.0f*w(pos+13*nsite);
		h0_1r = 2.0f*w(pos+14*nsite);		h0_1i = 2.0f*w(pos+15*nsite);
		h0_2r = 2.0f*w(pos+16*nsite);		h0_2i = 2.0f*w(pos+17*nsite);

		//h1 = 2.0*w3
		h1_0r = 2.0f*w(pos+18*nsite);		h1_0i = 2.0f*w(pos+19*nsite);
		h1_1r = 2.0f*w(pos+20*nsite);		h1_1i = 2.0f*w(pos+21*nsite);
		h1_2r= 2.0f*w(pos+22*nsite);		h1_2i= 2.0f*w(pos+23*nsite);
	}

	//Dirac representation
	@Inline def PackTM(w : Rail[Float], iw : Long)
	{
		val pos = iw;
		//h0 = 2.0*w0
		h0_0r = 2.0f*w(pos+0*nsite);		h0_0i = 2.0f*w(pos+1*nsite);
		h0_1r = 2.0f*w(pos+2*nsite);		h0_1i = 2.0f*w(pos+3*nsite);
		h0_2r = 2.0f*w(pos+4*nsite);		h0_2i = 2.0f*w(pos+5*nsite);

		//h1 = 2.0*w1
		h1_0r = 2.0f*w(pos+6*nsite);		h1_0i = 2.0f*w(pos+7*nsite);
		h1_1r = 2.0f*w(pos+8*nsite);		h1_1i = 2.0f*w(pos+9*nsite);
		h1_2r= 2.0f*w(pos+10*nsite);		h1_2i= 2.0f*w(pos+11*nsite);
	}

	@Inline def MultU(u : Rail[Float],iu : Long, h : HalfWilsonMult)
	{
		// val pos = iu*18;
		val pos = iu;
		h0_0r = 	u(pos+0*Ndst)*h.h0_0r - u(pos+1*Ndst)*h.h0_0i + 
				u(pos+2*Ndst)*h.h0_1r - u(pos+3*Ndst)*h.h0_1i + 
				u(pos+4*Ndst)*h.h0_2r - u(pos+5*Ndst)*h.h0_2i;
		h0_0i = 	u(pos+0*Ndst)*h.h0_0i + u(pos+1*Ndst)*h.h0_0r + 
				u(pos+2*Ndst)*h.h0_1i + u(pos+3*Ndst)*h.h0_1r + 
				u(pos+4*Ndst)*h.h0_2i + u(pos+5*Ndst)*h.h0_2r;

		h1_0r = 	u(pos+0*Ndst)*h.h1_0r - u(pos+1*Ndst)*h.h1_0i + 
				u(pos+2*Ndst)*h.h1_1r - u(pos+3*Ndst)*h.h1_1i + 
				u(pos+4*Ndst)*h.h1_2r- u(pos+5*Ndst)*h.h1_2i;
		h1_0i = 	u(pos+0*Ndst)*h.h1_0i + u(pos+1*Ndst)*h.h1_0r + 
				u(pos+2*Ndst)*h.h1_1i + u(pos+3*Ndst)*h.h1_1r + 
				u(pos+4*Ndst)*h.h1_2i+ u(pos+5*Ndst)*h.h1_2r;

		h0_1r = 	u(pos+6*Ndst) *h.h0_0r - u(pos+7*Ndst) *h.h0_0i + 
				u(pos+8*Ndst) *h.h0_1r - u(pos+9*Ndst) *h.h0_1i + 
				u(pos+10*Ndst)*h.h0_2r - u(pos+11*Ndst)*h.h0_2i;
		h0_1i = 	u(pos+6*Ndst) *h.h0_0i + u(pos+7*Ndst) *h.h0_0r + 
				u(pos+8*Ndst) *h.h0_1i + u(pos+9*Ndst) *h.h0_1r + 
				u(pos+10*Ndst)*h.h0_2i + u(pos+11*Ndst)*h.h0_2r;

		h1_1r = 	u(pos+6*Ndst) *h.h1_0r - u(pos+7*Ndst) *h.h1_0i + 
				u(pos+8*Ndst) *h.h1_1r - u(pos+9*Ndst) *h.h1_1i + 
				u(pos+10*Ndst)*h.h1_2r- u(pos+11*Ndst)*h.h1_2i;
		h1_1i = 	u(pos+6*Ndst) *h.h1_0i + u(pos+7*Ndst) *h.h1_0r + 
				u(pos+8*Ndst) *h.h1_1i + u(pos+9*Ndst) *h.h1_1r + 
				u(pos+10*Ndst)*h.h1_2i+ u(pos+11*Ndst)*h.h1_2r;

		h0_2r = 	u(pos+12*Ndst)*h.h0_0r - u(pos+13*Ndst)*h.h0_0i + 
				u(pos+14*Ndst)*h.h0_1r - u(pos+15*Ndst)*h.h0_1i + 
				u(pos+16*Ndst)*h.h0_2r - u(pos+17*Ndst)*h.h0_2i;
		h0_2i = 	u(pos+12*Ndst)*h.h0_0i + u(pos+13*Ndst)*h.h0_0r + 
				u(pos+14*Ndst)*h.h0_1i + u(pos+15*Ndst)*h.h0_1r + 
				u(pos+16*Ndst)*h.h0_2i + u(pos+17*Ndst)*h.h0_2r;

		h1_2r= 	u(pos+12*Ndst)*h.h1_0r - u(pos+13*Ndst)*h.h1_0i + 
				u(pos+14*Ndst)*h.h1_1r - u(pos+15*Ndst)*h.h1_1i + 
				u(pos+16*Ndst)*h.h1_2r- u(pos+17*Ndst)*h.h1_2i;
		h1_2i= 	u(pos+12*Ndst)*h.h1_0i + u(pos+13*Ndst)*h.h1_0r + 
				u(pos+14*Ndst)*h.h1_1i + u(pos+15*Ndst)*h.h1_1r + 
				u(pos+16*Ndst)*h.h1_2i+ u(pos+17*Ndst)*h.h1_2r;
	}

	// ht2(tid).MultUt(u.v(),offset_ut + nsite-Nxyz + i,ht1(tid));
	@Inline def MultUt(u : Rail[Float],iu : Long, h : HalfWilsonMult)
	{
		// val pos = iu*18;
		val pos = iu;
		h0_0r = 	u(pos+0*Ndst) *h.h0_0r + u(pos+1*Ndst) *h.h0_0i + 
				u(pos+6*Ndst) *h.h0_1r + u(pos+7*Ndst) *h.h0_1i + 
				u(pos+12*Ndst)*h.h0_2r + u(pos+13*Ndst)*h.h0_2i;
		h0_0i = 	u(pos+0*Ndst) *h.h0_0i - u(pos+1*Ndst) *h.h0_0r + 
				u(pos+6*Ndst) *h.h0_1i - u(pos+7*Ndst) *h.h0_1r + 
				u(pos+12*Ndst)*h.h0_2i - u(pos+13*Ndst)*h.h0_2r;

		h1_0r = 	u(pos+0*Ndst) *h.h1_0r + u(pos+1*Ndst) *h.h1_0i + 
				u(pos+6*Ndst) *h.h1_1r + u(pos+7*Ndst) *h.h1_1i + 
				u(pos+12*Ndst)*h.h1_2r+ u(pos+13*Ndst)*h.h1_2i;
		h1_0i = 	u(pos+0*Ndst) *h.h1_0i - u(pos+1*Ndst) *h.h1_0r + 
				u(pos+6*Ndst) *h.h1_1i - u(pos+7*Ndst) *h.h1_1r + 
				u(pos+12*Ndst)*h.h1_2i- u(pos+13*Ndst)*h.h1_2r;

		h0_1r = 	u(pos+2*Ndst) *h.h0_0r + u(pos+3*Ndst) *h.h0_0i + 
				u(pos+8*Ndst) *h.h0_1r + u(pos+9*Ndst) *h.h0_1i + 
				u(pos+14*Ndst)*h.h0_2r + u(pos+15*Ndst)*h.h0_2i;
		h0_1i = 	u(pos+2*Ndst) *h.h0_0i - u(pos+3*Ndst) *h.h0_0r + 
				u(pos+8*Ndst) *h.h0_1i - u(pos+9*Ndst) *h.h0_1r + 
				u(pos+14*Ndst)*h.h0_2i - u(pos+15*Ndst)*h.h0_2r;

		h1_1r = 	u(pos+2*Ndst) *h.h1_0r + u(pos+3*Ndst) *h.h1_0i + 
				u(pos+8*Ndst) *h.h1_1r + u(pos+9*Ndst) *h.h1_1i + 
				u(pos+14*Ndst)*h.h1_2r+ u(pos+15*Ndst)*h.h1_2i;
		h1_1i = 	u(pos+2*Ndst) *h.h1_0i - u(pos+3*Ndst) *h.h1_0r + 
				u(pos+8*Ndst) *h.h1_1i - u(pos+9*Ndst) *h.h1_1r + 
				u(pos+14*Ndst)*h.h1_2i- u(pos+15*Ndst)*h.h1_2r;

		h0_2r = 	u(pos+4*Ndst) *h.h0_0r + u(pos+5*Ndst) *h.h0_0i + 
				u(pos+10*Ndst)*h.h0_1r + u(pos+11*Ndst)*h.h0_1i + 
				u(pos+16*Ndst)*h.h0_2r + u(pos+17*Ndst)*h.h0_2i;
		h0_2i = 	u(pos+4*Ndst) *h.h0_0i - u(pos+5*Ndst) *h.h0_0r + 
				u(pos+10*Ndst)*h.h0_1i - u(pos+11*Ndst)*h.h0_1r + 
				u(pos+16*Ndst)*h.h0_2i - u(pos+17*Ndst)*h.h0_2r;

		h1_2r= 	u(pos+4*Ndst) *h.h1_0r + u(pos+5*Ndst) *h.h1_0i + 
				u(pos+10*Ndst)*h.h1_1r + u(pos+11*Ndst)*h.h1_1i + 
				u(pos+16*Ndst)*h.h1_2r+ u(pos+17*Ndst)*h.h1_2i;
		h1_2i= 	u(pos+4*Ndst) *h.h1_0i - u(pos+5*Ndst) *h.h1_0r + 
				u(pos+10*Ndst)*h.h1_1i - u(pos+11*Ndst)*h.h1_1r + 
				u(pos+16*Ndst)*h.h1_2i- u(pos+17*Ndst)*h.h1_2r;
	}

	@Inline def UnpackXP(w : Rail[Float], iw : Long, cks : Float)
	{
		val pos = iw;

		w(pos+0*nsite) += cks*h0_0r;			w(pos+1*nsite) += cks*h0_0i;
		w(pos+2*nsite) += cks*h0_1r;			w(pos+3*nsite) += cks*h0_1i;
		w(pos+4*nsite) += cks*h0_2r;			w(pos+5*nsite) += cks*h0_2i;

		w(pos+6*nsite) += cks*h1_0r;			w(pos+7*nsite) += cks*h1_0i;
		w(pos+8*nsite) += cks*h1_1r;			w(pos+9*nsite) += cks*h1_1i;
		w(pos+10*nsite)+= cks*h1_2r;			w(pos+11*nsite)+= cks*h1_2i;

		//w3 += -i*h1
		w(pos+12*nsite) += cks*h1_0i;		w(pos+13*nsite) -= cks*h1_0r;
		w(pos+14*nsite) += cks*h1_1i;		w(pos+15*nsite) -= cks*h1_1r;
		w(pos+16*nsite) += cks*h1_2i;		w(pos+17*nsite) -= cks*h1_2r;

		//w4 += -i*h0
		w(pos+18*nsite) += cks*h0_0i;		w(pos+19*nsite) -= cks*h0_0r;
		w(pos+20*nsite) += cks*h0_1i;		w(pos+21*nsite) -= cks*h0_1r;
		w(pos+22*nsite) += cks*h0_2i;		w(pos+23*nsite) -= cks*h0_2r;
	}

	@Inline def UnpackXM(w : Rail[Float], iw : Long, cks : Float)
	{
		val pos = iw;
		w(pos+0*nsite) += cks*h0_0r;			w(pos+1*nsite) += cks*h0_0i;
		w(pos+2*nsite) += cks*h0_1r;			w(pos+3*nsite) += cks*h0_1i;
		w(pos+4*nsite) += cks*h0_2r;			w(pos+5*nsite) += cks*h0_2i;

		w(pos+6*nsite) += cks*h1_0r;			w(pos+7*nsite) += cks*h1_0i;
		w(pos+8*nsite) += cks*h1_1r;			w(pos+9*nsite) += cks*h1_1i;
		w(pos+10*nsite)+= cks*h1_2r;		w(pos+11*nsite)+= cks*h1_2i;

		//w3 += i*h1
		w(pos+12*nsite) -= cks*h1_0i;		w(pos+13*nsite) += cks*h1_0r;
		w(pos+14*nsite) -= cks*h1_1i;		w(pos+15*nsite) += cks*h1_1r;
		w(pos+16*nsite) -= cks*h1_2i;		w(pos+17*nsite) += cks*h1_2r;

		//w4 += i*h0
		w(pos+18*nsite) -= cks*h0_0i;		w(pos+19*nsite) += cks*h0_0r;
		w(pos+20*nsite) -= cks*h0_1i;		w(pos+21*nsite) += cks*h0_1r;
		w(pos+22*nsite) -= cks*h0_2i;		w(pos+23*nsite) += cks*h0_2r;
	}

	@Inline def UnpackYP(w : Rail[Float], iw : Long, cks : Float)
	{
		val pos = iw;
		w(pos+0*nsite) += cks*h0_0r;			w(pos+1*nsite) += cks*h0_0i;
		w(pos+2*nsite) += cks*h0_1r;			w(pos+3*nsite) += cks*h0_1i;
		w(pos+4*nsite) += cks*h0_2r;			w(pos+5*nsite) += cks*h0_2i;

		w(pos+6*nsite) += cks*h1_0r;			w(pos+7*nsite) += cks*h1_0i;
		w(pos+8*nsite) += cks*h1_1r;			w(pos+9*nsite) += cks*h1_1i;
		w(pos+10*nsite)+= cks*h1_2r;		w(pos+11*nsite)+= cks*h1_2i;

		//w3 += -h1
		w(pos+12*nsite) -= cks*h1_0r;		w(pos+13*nsite) -= cks*h1_0i;
		w(pos+14*nsite) -= cks*h1_1r;		w(pos+15*nsite) -= cks*h1_1i;
		w(pos+16*nsite) -= cks*h1_2r;		w(pos+17*nsite) -= cks*h1_2i;

		//w4 += cks*h0
		w(pos+18*nsite) += cks*h0_0r;		w(pos+19*nsite) += cks*h0_0i;
		w(pos+20*nsite) += cks*h0_1r;		w(pos+21*nsite) += cks*h0_1i;
		w(pos+22*nsite) += cks*h0_2r;		w(pos+23*nsite) += cks*h0_2i;
	}

	@Inline def UnpackYM(w : Rail[Float], iw : Long, cks : Float)
	{
		val pos = iw;
		w(pos+0*nsite) += cks*h0_0r;			w(pos+1*nsite) += cks*h0_0i;
		w(pos+2*nsite) += cks*h0_1r;			w(pos+3*nsite) += cks*h0_1i;
		w(pos+4*nsite) += cks*h0_2r;			w(pos+5*nsite) += cks*h0_2i;

		w(pos+6*nsite) += cks*h1_0r;			w(pos+7*nsite) += cks*h1_0i;
		w(pos+8*nsite) += cks*h1_1r;			w(pos+9*nsite) += cks*h1_1i;
		w(pos+10*nsite)+= cks*h1_2r;		w(pos+11*nsite)+= cks*h1_2i;

		//w3 += cks*h1
		w(pos+12*nsite) += cks*h1_0r;		w(pos+13*nsite) += cks*h1_0i;
		w(pos+14*nsite) += cks*h1_1r;		w(pos+15*nsite) += cks*h1_1i;
		w(pos+16*nsite) += cks*h1_2r;		w(pos+17*nsite) += cks*h1_2i;

		//w4 += -h0
		w(pos+18*nsite) -= cks*h0_0r;		w(pos+19*nsite) -= cks*h0_0i;
		w(pos+20*nsite) -= cks*h0_1r;		w(pos+21*nsite) -= cks*h0_1i;
		w(pos+22*nsite) -= cks*h0_2r;		w(pos+23*nsite) -= cks*h0_2i;
	}

	@Inline def UnpackZP(w : Rail[Float], iw : Long, cks : Float)
	{
		val pos = iw;
		w(pos+0*nsite) += cks*h0_0r;			w(pos+1*nsite) += cks*h0_0i;
		w(pos+2*nsite) += cks*h0_1r;			w(pos+3*nsite) += cks*h0_1i;
		w(pos+4*nsite) += cks*h0_2r;			w(pos+5*nsite) += cks*h0_2i;

		w(pos+6*nsite) += cks*h1_0r;			w(pos+7*nsite) += cks*h1_0i;
		w(pos+8*nsite) += cks*h1_1r;			w(pos+9*nsite) += cks*h1_1i;
		w(pos+10*nsite)+= cks*h1_2r;			w(pos+11*nsite)+= cks*h1_2i;

		//w3 += -i*h0
		w(pos+12*nsite) += cks*h0_0i;		w(pos+13*nsite) -= cks*h0_0r;
		w(pos+14*nsite) += cks*h0_1i;		w(pos+15*nsite) -= cks*h0_1r;
		w(pos+16*nsite) += cks*h0_2i;		w(pos+17*nsite) -= cks*h0_2r;

		//w4 += i*h1
		w(pos+18*nsite) -= cks*h1_0i;		w(pos+19*nsite) += cks*h1_0r;
		w(pos+20*nsite) -= cks*h1_1i;		w(pos+21*nsite) += cks*h1_1r;
		w(pos+22*nsite) -= cks*h1_2i;		w(pos+23*nsite) += cks*h1_2r;
	}

	@Inline def UnpackZM(w : Rail[Float], iw : Long, cks : Float)
	{
		val pos = iw;
		w(pos+0*nsite) += cks*h0_0r;			w(pos+1*nsite) += cks*h0_0i;
		w(pos+2*nsite) += cks*h0_1r;			w(pos+3*nsite) += cks*h0_1i;
		w(pos+4*nsite) += cks*h0_2r;			w(pos+5*nsite) += cks*h0_2i;

		w(pos+6*nsite) += cks*h1_0r;			w(pos+7*nsite) += cks*h1_0i;
		w(pos+8*nsite) += cks*h1_1r;			w(pos+9*nsite) += cks*h1_1i;
		w(pos+10*nsite)+= cks*h1_2r;			w(pos+11*nsite)+= cks*h1_2i;

		//w3 += i*h0
		w(pos+12*nsite) -= cks*h0_0i;		w(pos+13*nsite) += cks*h0_0r;
		w(pos+14*nsite) -= cks*h0_1i;		w(pos+15*nsite) += cks*h0_1r;
		w(pos+16*nsite) -= cks*h0_2i;		w(pos+17*nsite) += cks*h0_2r;

		//w4 += -i*h1
		w(pos+18*nsite) += cks*h1_0i;		w(pos+19*nsite) -= cks*h1_0r;
		w(pos+20*nsite) += cks*h1_1i;		w(pos+21*nsite) -= cks*h1_1r;
		w(pos+22*nsite) += cks*h1_2i;		w(pos+23*nsite) -= cks*h1_2r;
	}

	//Dirac representation
	@Inline def UnpackTP(w : Rail[Float], iw : Long, cks : Float)
	{
		val pos = iw;
		w(pos+12*nsite) += cks*h0_0r;		w(pos+13*nsite) += cks*h0_0i;
		w(pos+14*nsite) += cks*h0_1r;		w(pos+15*nsite) += cks*h0_1i;
		w(pos+16*nsite) += cks*h0_2r;		w(pos+17*nsite) += cks*h0_2i;

		w(pos+18*nsite) += cks*h1_0r;		w(pos+19*nsite) += cks*h1_0i;
		w(pos+20*nsite) += cks*h1_1r;		w(pos+21*nsite) += cks*h1_1i;
		w(pos+22*nsite) += cks*h1_2r;		w(pos+23*nsite) += cks*h1_2i;
	}

	//Dirac representation
	@Inline def UnpackTM(w : Rail[Float], iw : Long, cks : Float)
	{
		val pos = iw;
		w(pos+0*nsite) += cks*h0_0r;			w(pos+1*nsite) += cks*h0_0i;
		w(pos+2*nsite) += cks*h0_1r;			w(pos+3*nsite) += cks*h0_1i;
		w(pos+4*nsite) += cks*h0_2r;			w(pos+5*nsite) += cks*h0_2i;

		w(pos+6*nsite) += cks*h1_0r;			w(pos+7*nsite) += cks*h1_0i;
		w(pos+8*nsite) += cks*h1_1r;			w(pos+9*nsite) += cks*h1_1i;
		w(pos+10*nsite)+= cks*h1_2r;			w(pos+11*nsite)+= cks*h1_2i;
	}

}


class CUDAHalfWilsonMult {

//debug  
	static val gpu = CUDAEnv.getCUDAPlace();

	var h0_0r : Float;
	var h0_0i : Float;
	var h0_1r : Float;
	var h0_1i : Float;
	var h0_2r : Float;
	var h0_2i : Float;
	var h1_0r : Float;
	var h1_0i : Float;
	var h1_1r : Float;
	var h1_1i : Float;
	var h1_2r : Float;
	var h1_2i : Float;

/*
	@Inline def Load(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		h0_0r  = w(iw*12+0);		h0_0i  = w(iw*12+1);
		h0_1r  = w(iw*12+2);		h0_1i  = w(iw*12+3);
		h0_2r  = w(iw*12+4);		h0_2i  = w(iw*12+5);

		h1_0r  = w(iw*12+6);		h1_0i  = w(iw*12+7);
		h1_1r  = w(iw*12+8);		h1_1i  = w(iw*12+9);
		h1_2r = w(iw*12+10);	h1_2i = w(iw*12+11);
	}

	@Inline def Store(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		w(iw*12+0) = h0_0r;		w(iw*12+1) = h0_0i;
		w(iw*12+2) = h0_1r;		w(iw*12+3) = h0_1i;
		w(iw*12+4) = h0_2r;		w(iw*12+5) = h0_2i;

		w(iw*12+6) = h1_0r;		w(iw*12+7) = h1_0i;
		w(iw*12+8) = h1_1r;		w(iw*12+9) = h1_1i;
		w(iw*12+10)= h1_2r;		w(iw*12+11)= h1_2i;
	}

	@Inline def PackXP(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + i*w3
		h0_0r = w(pos+0) - w(pos+19);		h0_0i = w(pos+1) + w(pos+18);
		h0_1r = w(pos+2) - w(pos+21);		h0_1i = w(pos+3) + w(pos+20);
		h0_2r = w(pos+4) - w(pos+23);		h0_2i = w(pos+5) + w(pos+22);

		//h1 = w1 + i*w2
		h1_0r = w(pos+6) - w(pos+13);		h1_0i = w(pos+7) + w(pos+12);
		h1_1r = w(pos+8) - w(pos+15);		h1_1i = w(pos+9) + w(pos+14);
		h1_2r = w(pos+10)- w(pos+17);		h1_2i = w(pos+11)+ w(pos+16);
	}

	@Inline def PackXM(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - i*w3
		h0_0r = w(pos+0) + w(pos+19);		h0_0i = w(pos+1) - w(pos+18);
		h0_1r = w(pos+2) + w(pos+21);		h0_1i = w(pos+3) - w(pos+20);
		h0_2r = w(pos+4) + w(pos+23);		h0_2i = w(pos+5) - w(pos+22);

		//h1 = w1 - i*w2
		h1_0r = w(pos+6) + w(pos+13);		h1_0i = w(pos+7) - w(pos+12);
		h1_1r = w(pos+8) + w(pos+15);		h1_1i = w(pos+9) - w(pos+14);
		h1_2r = w(pos+10)+ w(pos+17);		h1_2i = w(pos+11)- w(pos+16);
	}

	@Inline def PackYP(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + w3
		h0_0r = w(pos+0) + w(pos+18);		h0_0i = w(pos+1) + w(pos+19);
		h0_1r = w(pos+2) + w(pos+20);		h0_1i = w(pos+3) + w(pos+21);
		h0_2r = w(pos+4) + w(pos+22);		h0_2i = w(pos+5) + w(pos+23);

		//h1 = w1 - w2
		h1_0r = w(pos+6) - w(pos+12);		h1_0i = w(pos+7) - w(pos+13);
		h1_1r = w(pos+8) - w(pos+14);		h1_1i = w(pos+9) - w(pos+15);
		h1_2r = w(pos+10)- w(pos+16);		h1_2i = w(pos+11)- w(pos+17);
	}

	@Inline def PackYM(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - w3
		h0_0r = w(pos+0) - w(pos+18);		h0_0i = w(pos+1) - w(pos+19);
		h0_1r = w(pos+2) - w(pos+20);		h0_1i = w(pos+3) - w(pos+21);
		h0_2r = w(pos+4) - w(pos+22);		h0_2i = w(pos+5) - w(pos+23);

		//h1 = w1 + w2
		h1_0r = w(pos+6) + w(pos+12);		h1_0i = w(pos+7) + w(pos+13);
		h1_1r = w(pos+8) + w(pos+14);		h1_1i = w(pos+9) + w(pos+15);
		h1_2r = w(pos+10)+ w(pos+16);		h1_2i = w(pos+11)+ w(pos+17);
	}
	
	@Inline def PackZP(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + i*w2
		h0_0r = w(pos+0) - w(pos+13);		h0_0i = w(pos+1) + w(pos+12);
		h0_1r = w(pos+2) - w(pos+15);		h0_1i = w(pos+3) + w(pos+14);
		h0_2r = w(pos+4) - w(pos+17);		h0_2i = w(pos+5) + w(pos+16);

		//h1 = w1 - i*w3
		h1_0r = w(pos+6) + w(pos+19);		h1_0i = w(pos+7) - w(pos+18);
		h1_1r = w(pos+8) + w(pos+21);		h1_1i = w(pos+9) - w(pos+20);
		h1_2r = w(pos+10)+ w(pos+23);		h1_2i = w(pos+11)- w(pos+22);
	}

	@Inline def PackZM(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - i*w3
		h0_0r = w(pos+0) + w(pos+13);		h0_0i = w(pos+1) - w(pos+12);
		h0_1r = w(pos+2) + w(pos+15);		h0_1i = w(pos+3) - w(pos+14);
		h0_2r = w(pos+4) + w(pos+17);		h0_2i = w(pos+5) - w(pos+16);

		//h1 = w1 + i*w2
		h1_0r = w(pos+6) - w(pos+19);		h1_0i = w(pos+7) + w(pos+18);
		h1_1r = w(pos+8) - w(pos+21);		h1_1i = w(pos+9) + w(pos+20);
		h1_2r = w(pos+10)- w(pos+23);		h1_2i = w(pos+11)+ w(pos+22);
	}

	//Dirac representation
	@Inline def PackTP(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		val pos = iw*24;
		//h0 = 2.0*w2
		h0_0r = 2.0*w(pos+12);		h0_0i = 2.0*w(pos+13);
		h0_1r = 2.0*w(pos+14);		h0_1i = 2.0*w(pos+15);
		h0_2r = 2.0*w(pos+16);		h0_2i = 2.0*w(pos+17);

		//h1 = 2.0*w3
		h1_0r = 2.0*w(pos+18);		h1_0i = 2.0*w(pos+19);
		h1_1r = 2.0*w(pos+20);		h1_1i = 2.0*w(pos+21);
		h1_2r = 2.0*w(pos+22);		h1_2i = 2.0*w(pos+23);
	}

	//Dirac representation
	@Inline def PackTM(w : GlobalRail[Float]{home==gpu}, iw : Long)
	{
		val pos = iw*24;
		//h0 = 2.0*w0
		h0_0r = 2.0*w(pos+0);		h0_0i = 2.0*w(pos+1);
		h0_1r = 2.0*w(pos+2);		h0_1i = 2.0*w(pos+3);
		h0_2r = 2.0*w(pos+4);		h0_2i = 2.0*w(pos+5);

		//h1 = 2.0*w1
		h1_0r = 2.0*w(pos+6);		h1_0i = 2.0*w(pos+7);
		h1_1r = 2.0*w(pos+8);		h1_1i = 2.0*w(pos+9);
		h1_2r = 2.0*w(pos+10);		h1_2i = 2.0*w(pos+11);
	}

	@Inline def MultU(u : GlobalRail[Float]{home==gpu},iu : Long, h : CUDAHalfWilsonMult)
	{
		val pos = iu*18;
		h0_0r = 	u(pos+0)*h.h0_0r - u(pos+1)*h.h0_0i + 
				u(pos+2)*h.h0_1r - u(pos+3)*h.h0_1i + 
				u(pos+4)*h.h0_2r - u(pos+5)*h.h0_2i;
		h0_0i = 	u(pos+0)*h.h0_0i + u(pos+1)*h.h0_0r + 
				u(pos+2)*h.h0_1i + u(pos+3)*h.h0_1r + 
				u(pos+4)*h.h0_2i + u(pos+5)*h.h0_2r;

		h1_0r = 	u(pos+0)*h.h1_0r - u(pos+1)*h.h1_0i + 
				u(pos+2)*h.h1_1r - u(pos+3)*h.h1_1i + 
				u(pos+4)*h.h1_2r - u(pos+5)*h.h1_2i;
		h1_0i = 	u(pos+0)*h.h1_0i + u(pos+1)*h.h1_0r + 
				u(pos+2)*h.h1_1i + u(pos+3)*h.h1_1r + 
				u(pos+4)*h.h1_2i + u(pos+5)*h.h1_2r;

		h0_1r = 	u(pos+6) *h.h0_0r - u(pos+7) *h.h0_0i + 
				u(pos+8) *h.h0_1r - u(pos+9) *h.h0_1i + 
				u(pos+10)*h.h0_2r - u(pos+11)*h.h0_2i;
		h0_1i = 	u(pos+6) *h.h0_0i + u(pos+7) *h.h0_0r + 
				u(pos+8) *h.h0_1i + u(pos+9) *h.h0_1r + 
				u(pos+10)*h.h0_2i + u(pos+11)*h.h0_2r;

		h1_1r = 	u(pos+6) *h.h1_0r - u(pos+7) *h.h1_0i + 
				u(pos+8) *h.h1_1r - u(pos+9) *h.h1_1i + 
				u(pos+10)*h.h1_2r - u(pos+11)*h.h1_2i;
		h1_1i = 	u(pos+6) *h.h1_0i + u(pos+7) *h.h1_0r + 
				u(pos+8) *h.h1_1i + u(pos+9) *h.h1_1r + 
				u(pos+10)*h.h1_2i + u(pos+11)*h.h1_2r;

		h0_2r = 	u(pos+12)*h.h0_0r - u(pos+13)*h.h0_0i + 
				u(pos+14)*h.h0_1r - u(pos+15)*h.h0_1i + 
				u(pos+16)*h.h0_2r - u(pos+17)*h.h0_2i;
		h0_2i = 	u(pos+12)*h.h0_0i + u(pos+13)*h.h0_0r + 
				u(pos+14)*h.h0_1i + u(pos+15)*h.h0_1r + 
				u(pos+16)*h.h0_2i + u(pos+17)*h.h0_2r;

		h1_2r = 	u(pos+12)*h.h1_0r - u(pos+13)*h.h1_0i + 
				u(pos+14)*h.h1_1r - u(pos+15)*h.h1_1i + 
				u(pos+16)*h.h1_2r - u(pos+17)*h.h1_2i;
		h1_2i = 	u(pos+12)*h.h1_0i + u(pos+13)*h.h1_0r + 
				u(pos+14)*h.h1_1i + u(pos+15)*h.h1_1r + 
				u(pos+16)*h.h1_2i + u(pos+17)*h.h1_2r;
	}

	@Inline def MultUt(u : GlobalRail[Float]{home==gpu},iu : Long, h : CUDAHalfWilsonMult)
	{
		val pos = iu*18;
		h0_0r = 	u(pos+0) *h.h0_0r + u(pos+1) *h.h0_0i + 
				u(pos+6) *h.h0_1r + u(pos+7) *h.h0_1i + 
				u(pos+12)*h.h0_2r + u(pos+13)*h.h0_2i;
		h0_0i = 	u(pos+0) *h.h0_0i - u(pos+1) *h.h0_0r + 
				u(pos+6) *h.h0_1i - u(pos+7) *h.h0_1r + 
				u(pos+12)*h.h0_2i - u(pos+13)*h.h0_2r;

		h1_0r = 	u(pos+0) *h.h1_0r + u(pos+1) *h.h1_0i + 
				u(pos+6) *h.h1_1r + u(pos+7) *h.h1_1i + 
				u(pos+12)*h.h1_2r + u(pos+13)*h.h1_2i;
		h1_0i = 	u(pos+0) *h.h1_0i - u(pos+1) *h.h1_0r + 
				u(pos+6) *h.h1_1i - u(pos+7) *h.h1_1r + 
				u(pos+12)*h.h1_2i - u(pos+13)*h.h1_2r;

		h0_1r = 	u(pos+2) *h.h0_0r + u(pos+3) *h.h0_0i + 
				u(pos+8) *h.h0_1r + u(pos+9) *h.h0_1i + 
				u(pos+14)*h.h0_2r + u(pos+15)*h.h0_2i;
		h0_1i = 	u(pos+2) *h.h0_0i - u(pos+3) *h.h0_0r + 
				u(pos+8) *h.h0_1i - u(pos+9) *h.h0_1r + 
				u(pos+14)*h.h0_2i - u(pos+15)*h.h0_2r;

		h1_1r = 	u(pos+2) *h.h1_0r + u(pos+3) *h.h1_0i + 
				u(pos+8) *h.h1_1r + u(pos+9) *h.h1_1i + 
				u(pos+14)*h.h1_2r + u(pos+15)*h.h1_2i;
		h1_1i = 	u(pos+2) *h.h1_0i - u(pos+3) *h.h1_0r + 
				u(pos+8) *h.h1_1i - u(pos+9) *h.h1_1r + 
				u(pos+14)*h.h1_2i - u(pos+15)*h.h1_2r;

		h0_2r = 	u(pos+4) *h.h0_0r + u(pos+5) *h.h0_0i + 
				u(pos+10)*h.h0_1r + u(pos+11)*h.h0_1i + 
				u(pos+16)*h.h0_2r + u(pos+17)*h.h0_2i;
		h0_2i = 	u(pos+4) *h.h0_0i - u(pos+5) *h.h0_0r + 
				u(pos+10)*h.h0_1i - u(pos+11)*h.h0_1r + 
				u(pos+16)*h.h0_2i - u(pos+17)*h.h0_2r;

		h1_2r = 	u(pos+4) *h.h1_0r + u(pos+5) *h.h1_0i + 
				u(pos+10)*h.h1_1r + u(pos+11)*h.h1_1i + 
				u(pos+16)*h.h1_2r + u(pos+17)*h.h1_2i;
		h1_2i = 	u(pos+4) *h.h1_0i - u(pos+5) *h.h1_0r + 
				u(pos+10)*h.h1_1i - u(pos+11)*h.h1_1r + 
				u(pos+16)*h.h1_2i - u(pos+17)*h.h1_2r;
	}

	@Inline def UnpackXP(w : GlobalRail[Float]{home==gpu}, iw : Long, cks : Float)
	{
		val pos = iw*24;

		w(pos+0) += cks*h0_0r;		w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;		w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;		w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;		w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;		w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;		w(pos+11)+= cks*h1_2i;

		//w3 += -i*h1
		w(pos+12) += cks*h1_0i;		w(pos+13) -= cks*h1_0r;
		w(pos+14) += cks*h1_1i;		w(pos+15) -= cks*h1_1r;
		w(pos+16) += cks*h1_2i;		w(pos+17) -= cks*h1_2r;

		//w4 += -i*h0
		w(pos+18) += cks*h0_0i;		w(pos+19) -= cks*h0_0r;
		w(pos+20) += cks*h0_1i;		w(pos+21) -= cks*h0_1r;
		w(pos+22) += cks*h0_2i;		w(pos+23) -= cks*h0_2r;
	}

	@Inline def UnpackXM(w : GlobalRail[Float]{home==gpu}, iw : Long, cks : Float)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;		w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;		w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;		w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;		w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;		w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;		w(pos+11)+= cks*h1_2i;

		//w3 += i*h1
		w(pos+12) -= cks*h1_0i;		w(pos+13) += cks*h1_0r;
		w(pos+14) -= cks*h1_1i;		w(pos+15) += cks*h1_1r;
		w(pos+16) -= cks*h1_2i;		w(pos+17) += cks*h1_2r;

		//w4 += i*h0
		w(pos+18) -= cks*h0_0i;		w(pos+19) += cks*h0_0r;
		w(pos+20) -= cks*h0_1i;		w(pos+21) += cks*h0_1r;
		w(pos+22) -= cks*h0_2i;		w(pos+23) += cks*h0_2r;
	}

	@Inline def UnpackYP(w : GlobalRail[Float]{home==gpu}, iw : Long, cks : Float)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;		w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;		w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;		w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;		w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;		w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;		w(pos+11)+= cks*h1_2i;

		//w3 += -h1
		w(pos+12) -= cks*h1_0r;		w(pos+13) -= cks*h1_0i;
		w(pos+14) -= cks*h1_1r;		w(pos+15) -= cks*h1_1i;
		w(pos+16) -= cks*h1_2r;		w(pos+17) -= cks*h1_2i;

		//w4 += cks*h0
		w(pos+18) += cks*h0_0r;		w(pos+19) += cks*h0_0i;
		w(pos+20) += cks*h0_1r;		w(pos+21) += cks*h0_1i;
		w(pos+22) += cks*h0_2r;		w(pos+23) += cks*h0_2i;
	}

	@Inline def UnpackYM(w : GlobalRail[Float]{home==gpu}, iw : Long, cks : Float)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;		w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;		w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;		w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;		w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;		w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;		w(pos+11)+= cks*h1_2i;

		//w3 += cks*h1
		w(pos+12) += cks*h1_0r;		w(pos+13) += cks*h1_0i;
		w(pos+14) += cks*h1_1r;		w(pos+15) += cks*h1_1i;
		w(pos+16) += cks*h1_2r;		w(pos+17) += cks*h1_2i;

		//w4 += -h0
		w(pos+18) -= cks*h0_0r;		w(pos+19) -= cks*h0_0i;
		w(pos+20) -= cks*h0_1r;		w(pos+21) -= cks*h0_1i;
		w(pos+22) -= cks*h0_2r;		w(pos+23) -= cks*h0_2i;
	}

	@Inline def UnpackZP(w : GlobalRail[Float]{home==gpu}, iw : Long, cks : Float)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;		w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;		w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;		w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;		w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;		w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;		w(pos+11)+= cks*h1_2i;

		//w3 += -i*h0
		w(pos+12) += cks*h0_0i;		w(pos+13) -= cks*h0_0r;
		w(pos+14) += cks*h0_1i;		w(pos+15) -= cks*h0_1r;
		w(pos+16) += cks*h0_2i;		w(pos+17) -= cks*h0_2r;

		//w4 += i*h1
		w(pos+18) -= cks*h1_0i;		w(pos+19) += cks*h1_0r;
		w(pos+20) -= cks*h1_1i;		w(pos+21) += cks*h1_1r;
		w(pos+22) -= cks*h1_2i;		w(pos+23) += cks*h1_2r;
	}

	@Inline def UnpackZM(w : GlobalRail[Float]{home==gpu}, iw : Long, cks : Float)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;		w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;		w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;		w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;		w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;		w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;		w(pos+11)+= cks*h1_2i;

		//w3 += i*h0
		w(pos+12) -= cks*h0_0i;		w(pos+13) += cks*h0_0r;
		w(pos+14) -= cks*h0_1i;		w(pos+15) += cks*h0_1r;
		w(pos+16) -= cks*h0_2i;		w(pos+17) += cks*h0_2r;

		//w4 += -i*h1
		w(pos+18) += cks*h1_0i;		w(pos+19) -= cks*h1_0r;
		w(pos+20) += cks*h1_1i;		w(pos+21) -= cks*h1_1r;
		w(pos+22) += cks*h1_2i;		w(pos+23) -= cks*h1_2r;
	}

	//Dirac representation
	@Inline def UnpackTP(w : GlobalRail[Float]{home==gpu}, iw : Long, cks : Float)
	{
		val pos = iw*24;
		w(pos+12) += cks*h0_0r;		w(pos+13) += cks*h0_0i;
		w(pos+14) += cks*h0_1r;		w(pos+15) += cks*h0_1i;
		w(pos+16) += cks*h0_2r;		w(pos+17) += cks*h0_2i;

		w(pos+18) += cks*h1_0r;		w(pos+19) += cks*h1_0i;
		w(pos+20) += cks*h1_1r;		w(pos+21) += cks*h1_1i;
		w(pos+22) += cks*h1_2r;		w(pos+23) += cks*h1_2i;
	}

	//Dirac representation
	@Inline def UnpackTM(w : GlobalRail[Float]{home==gpu}, iw : Long, cks : Float)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;		w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;		w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;		w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;		w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;		w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;		w(pos+11)+= cks*h1_2i;
	}
*/
}








public class Dslash extends Lattice {

//debug
	static val gpu = CUDAEnv.getCUDAPlace();

	val nThreads : Long;
	val ht1 : Rail[HalfWilsonMult];
	val ht2 : Rail[HalfWilsonMult];
//debug
	// val dht1 : Rail[CUDAHalfWilsonMult];
	// val dht2 : Rail[CUDAHalfWilsonMult];
	// val dht1 : CUDAHalfWilsonMult;
	// val dht2 : CUDAHalfWilsonMult;
	
	// val dv:PlaceLocalHandle[Cell[GlobalRail[Float]]];
	// val dw:PlaceLocalHandle[Cell[GlobalRail[Float]]];
	// val dv : CUDAWilsonVectorField;
	// val dw : CUDAWilsonVectorField;
  
	val rngX : Rail[LongRange];
	val rngYOut : Rail[LongRange];
	val rngYInBnd : Rail[LongRange];
	val rngYIn : Rail[LongRange];
	val rngZOut : Rail[LongRange];
	val rngZInBnd : Rail[LongRange];
	val rngZIn : Rail[LongRange];
	val rngTBnd : Rail[LongRange];
	val rngT : Rail[LongRange];
	val rngYSnd : Rail[LongRange];
	val rngZSnd : Rail[LongRange];

	def this(x : Long,y : Long,z : Long,t : Long, nid : Long)
	{
		super(x,y,z,t);

		ht1 = new Rail[HalfWilsonMult](nid);
		ht2 = new Rail[HalfWilsonMult](nid);
//debug
		// dht1 = new Rail[CUDAHalfWilsonMult](nid);
		// dht2 = new Rail[CUDAHalfWilsonMult](nid);

		nThreads = nid;

		rngX = new Rail[LongRange](nThreads);
		rngYOut = new Rail[LongRange](nThreads);
		rngYInBnd = new Rail[LongRange](nThreads);
		rngYIn = new Rail[LongRange](nThreads);
		rngZOut = new Rail[LongRange](nThreads);
		rngZInBnd = new Rail[LongRange](nThreads);
		rngZIn = new Rail[LongRange](nThreads);
		rngTBnd = new Rail[LongRange](nThreads);
		rngT = new Rail[LongRange](nThreads);
		rngYSnd = new Rail[LongRange](nThreads);
		rngZSnd = new Rail[LongRange](nThreads);

//debug
		// dht1 = new CUDAHalfWilsonMult();
		// dht2 = new CUDAHalfWilsonMult();

		// Console.OUT.println("init: " + here.id());
		// dv = PlaceLocalHandle.make[Cell[GlobalRail[Float]]](Place.places(), ()=>new Cell(CUDAUtilities.makeGlobalRail(here.child(0), x*y*z*t*3*4*1*2, 0 as Float)));
		// dw = PlaceLocalHandle.make[Cell[GlobalRail[Float]]](Place.places(), ()=>new Cell(CUDAUtilities.makeGlobalRail(here.child(0), x*y*z*t*3*4*1*2, 0 as Float)));
		// dv = new CUDAWilsonVectorField(x,y,z,t,1);
		// dw = new CUDAWilsonVectorField(x,y,z,t,1);

		var no : Long;
		var ni : Long;
		var io : Long;
		var ii : Long;
		var g0 : Long;
		var g1 : Long;
		for(tid in 0..(nThreads - 1)){
			// ht1(tid) = new HalfWilsonMult();
			// ht2(tid) = new HalfWilsonMult();
//debug
			ht1(tid) = new HalfWilsonMult(x,y,z,t);
			ht2(tid) = new HalfWilsonMult(x,y,z,t);
			rngX(tid) = new LongRange(tid * Ny*Nz*Nt / nid,(tid + 1) * Ny*Nz*Nt / nid-1);

			no = GetGCD.Do(Nt*Nz,nid);
			ni = nid / no;
			ii = tid % ni;
			io = tid / ni;

			rngYOut(tid) = new LongRange(io * Nt*Nz / no,(io + 1) * Nt*Nz / no-1);
			rngYInBnd(tid)  = new LongRange(ii * Nx / ni,(ii + 1) * Nx / ni-1);
			rngYIn(tid)  = new LongRange(ii * (Nxy - Nx) / ni,(ii + 1) * (Nxy - Nx) / ni-1);
			rngYSnd(tid) = new LongRange(rngYOut(tid).min*Nx + rngYInBnd(tid).min,rngYOut(tid).max*Nx + rngYInBnd(tid).max);

			no = GetGCD.Do(Nt,nid);
			ni = nid / no;
			ii = tid % ni;
			io = tid / ni;

			rngZOut(tid) = new LongRange(io * Nt / no,(io + 1) * Nt / no-1);
			rngZInBnd(tid)  = new LongRange(ii * Nxy / ni,(ii + 1) * Nxy / ni-1);
			rngZIn(tid)  = new LongRange(ii * (Nxyz-Nxy) / ni,(ii + 1) * (Nxyz-Nxy) / ni-1);
			rngZSnd(tid) = new LongRange(rngZOut(tid).min*Nxy + rngZInBnd(tid).min,rngZOut(tid).max*Nxy + rngZInBnd(tid).max);

			rngTBnd(tid) = new LongRange(tid * Nxyz / nid, (tid + 1) * Nxyz / nid-1);
			rngT(tid) = new LongRange(tid * (nsite-Nxyz) / nid, (tid + 1) * (nsite-Nxyz) / nid-1);

			//Console.OUT.println("("+tid+") X :" +rngX(tid).min+" , "+rngX(tid).max);
			//Console.OUT.println("("+tid+") Y :" +rngYInBnd(tid).min+" , "+rngYInBnd(tid).max);
			//Console.OUT.println("("+tid+") Y :" +rngYIn(tid).min+" , "+rngYIn(tid).max);
			//Console.OUT.println("("+tid+") Y :" +rngYOut(tid).min+" , "+rngYOut(tid).max);
			//Console.OUT.println("("+tid+") Y :" +rngYSnd(tid).min+" , "+rngYSnd(tid).max);
			//Console.OUT.println("("+tid+") Z :" +rngZInBnd(tid).min+" , "+rngZInBnd(tid).max);
			//Console.OUT.println("("+tid+") Z :" +rngZIn(tid).min+" , "+rngZIn(tid).max);
			//Console.OUT.println("("+tid+") Z :" +rngZOut(tid).min+" , "+rngZOut(tid).max);
			//Console.OUT.println("("+tid+") Z :" +rngZSnd(tid).min+" , "+rngZSnd(tid).max);
			//Console.OUT.println("("+tid+") T :" +rngTBnd(tid).min+" , "+rngTBnd(tid).max);
			//Console.OUT.println("("+tid+") T :" +rngT(tid).min+" , "+rngT(tid).max);
		}
	}

	// def Delete() {
	//   CUDAUtilities.deleteGlobalRail(dv.v()());
	//   CUDAUtilities.deleteGlobalRail(dw.v()());	    
	// }

	def MakeXPBnd(bx : CUDALatticeComm, w : WilsonVectorField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				ht1(tid).PackXP(w.v(),i*Nx);
				ht1(tid).Store(bx.SendBuffer(bx.XP).v(),i);
			}
		}
	}

	def MakeXPBndKernel(bx : GlobalRail[Float]{home==gpu}, w : GlobalRail[Float]{home==gpu})
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
		// for(i in rngX(tid)){
	  	for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {

		  // ht1(tid).PackXP(w.v(),i*Nx);
	          var pos:Long = i*Nx_;

		  //h0 = w0 + i*w3
		  val h0_0r = w(pos  )        - w(pos+19*nsite_);		val h0_0i = w(pos+1*nsite_) + w(pos+18*nsite_);
		  val h0_1r = w(pos+2*nsite_) - w(pos+21*nsite_);		val h0_1i = w(pos+3*nsite_) + w(pos+20*nsite_);
		  val h0_2r = w(pos+4*nsite_) - w(pos+23*nsite_);		val h0_2i = w(pos+5*nsite_) + w(pos+22*nsite_);

		  //h1 = w1 + i*w2
		  val h1_0r = w(pos+6*nsite_) - w(pos+13*nsite_);		val h1_0i = w(pos+7*nsite_) + w(pos+12*nsite_);
		  val h1_1r = w(pos+8*nsite_) - w(pos+15*nsite_);		val h1_1i = w(pos+9*nsite_) + w(pos+14*nsite_);
		  val h1_2r = w(pos+10*nsite_)- w(pos+17*nsite_);		val h1_2i = w(pos+11*nsite_)+ w(pos+16*nsite_);

		  // ht1(tid).Store(bx.SendBuffer(bx.XP).v(),i);
		  bx(i*12+0) = h0_0r;		bx(i*12+1) = h0_0i;
		  bx(i*12+2) = h0_1r;		bx(i*12+3) = h0_1i;
		  bx(i*12+4) = h0_2r;		bx(i*12+5) = h0_2i;

		  bx(i*12+6) = h1_0r;		bx(i*12+7) = h1_0i;
		  bx(i*12+8) = h1_1r;		bx(i*12+9) = h1_1i;
		  bx(i*12+10)= h1_2r;		bx(i*12+11)= h1_2i;
		}
	      }
	    }
	  }
	}

	def MakeXMBnd(bx : CUDALatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				ht1(tid).PackXM(w.v(),i*Nx + Nx-1);
				ht2(tid).MultUt(u.v(),offset_ux + i*Nx + Nx-1,ht1(tid));
				ht2(tid).Store(bx.SendBuffer(bx.XM).v(),i);
			}
		}
	}

	def MakeXMBndKernel(bx : GlobalRail[Float]{home==gpu}, w : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu})
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
		// for(i in rngX(tid)){
	  	for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {

		  // ht1(tid).PackXM(w.v(),i*Nx + Nx-1);
	          var pos:Long = i*Nx_ + Nx_-1;

		  //h0 = w0 - i*w3
		  val h0_0r_t = w(pos+0*nsite_) + w(pos+19*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+18*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) + w(pos+21*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+20*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) + w(pos+23*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+22*nsite_);

		  //h1 = w1 - i*w2
		  val h1_0r_t = w(pos+6*nsite_) + w(pos+13*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+12*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) + w(pos+15*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+14*nsite_);
		  val h1_2r_t= w(pos+10*nsite_)+ w(pos+17*nsite_);		val h1_2i_t= w(pos+11*nsite_)- w(pos+16*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_ux + i*Nx + Nx-1,ht1(tid));
		  pos = offset_ux_ + i*Nx_ + Nx_-1;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t+ 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t+ 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).Store(bx.SendBuffer(bx.XM).v(),i);
		  bx(i*12+0) = h0_0r;		bx(i*12+1) = h0_0i;
		  bx(i*12+2) = h0_1r;		bx(i*12+3) = h0_1i;
		  bx(i*12+4) = h0_2r;		bx(i*12+5) = h0_2i;

		  bx(i*12+6) = h1_0r;		bx(i*12+7) = h1_0i;
		  bx(i*12+8) = h1_1r;		bx(i*12+9) = h1_1i;
		  bx(i*12+10)= h1_2r;		bx(i*12+11)= h1_2i;
		}
	      }
	    }
	  }
	}

	def MakeYPBnd(bx : CUDALatticeComm, w : WilsonVectorField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngYOut(tid)){
				for(j in rngYInBnd(tid)){
					ht1(tid).PackYP(w.v(),i*Nxy + j);
					ht1(tid).Store(bx.SendBuffer(bx.YP).v(),i*Nx + j);
				}
			}
		}
	}

	def MakeYPBndKernel(bx : GlobalRail[Float]{home==gpu}, w : GlobalRail[Float]{home==gpu})
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uy_ = offset_uy;

	  val threads = Int.operator_as(Nx_);
	  val blocks = Int.operator_as(Nz_*Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; {
		  // for(i in rngYInBnd(tid)){
		  val j = tid; {

		    // ht1(tid).PackYP(w.v(),i*Nxy + j);
		    var pos:Long = i*Nxy_ + j;

		    //h0 = w0 + w3
		    val h0_0r = w(pos+0*nsite_) + w(pos+18*nsite_);		val h0_0i = w(pos+1*nsite_) + w(pos+19*nsite_);
		    val h0_1r = w(pos+2*nsite_) + w(pos+20*nsite_);		val h0_1i = w(pos+3*nsite_) + w(pos+21*nsite_);
		    val h0_2r = w(pos+4*nsite_) + w(pos+22*nsite_);		val h0_2i = w(pos+5*nsite_) + w(pos+23*nsite_);

		    //h1 = w1 - w2
		    val h1_0r = w(pos+6*nsite_) - w(pos+12*nsite_);		val h1_0i = w(pos+7*nsite_) - w(pos+13*nsite_);
		    val h1_1r = w(pos+8*nsite_) - w(pos+14*nsite_);		val h1_1i = w(pos+9*nsite_) - w(pos+15*nsite_);
		    val h1_2r= w(pos+10*nsite_) - w(pos+16*nsite_);		val h1_2i= w(pos+11*nsite_) - w(pos+17*nsite_);

		    // ht1(tid).Store(bx.SendBuffer(bx.YP).v(),i*Nx + j);
		    pos = i*Nx_ + j;

		    bx(pos*12+0) = h0_0r;		bx(pos*12+1) = h0_0i;
		    bx(pos*12+2) = h0_1r;		bx(pos*12+3) = h0_1i;
		    bx(pos*12+4) = h0_2r;		bx(pos*12+5) = h0_2i;

		    bx(pos*12+6) = h1_0r;		bx(pos*12+7) = h1_0i;
		    bx(pos*12+8) = h1_1r;		bx(pos*12+9) = h1_1i;
		    bx(pos*12+10)= h1_2r;		bx(pos*12+11)= h1_2i;
		  }
		}
	      }
	    }
	  }
	}

	def MakeYMBnd(bx : CUDALatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngYOut(tid)){
				for(j in rngYInBnd(tid)){
					ht1(tid).PackYM(w.v(),i*Nxy + Nxy-Nx + j);
					ht2(tid).MultUt(u.v(),offset_uy + i*Nxy + Nxy-Nx + j,ht1(tid));
					ht2(tid).Store(bx.SendBuffer(bx.YM).v(),i*Nx + j);
				}
			}
		}
	}

	def MakeYMBndKernel(bx : GlobalRail[Float]{home==gpu}, w : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu})
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uy_ = offset_uy;

	  val threads = Int.operator_as(Nx_);
	  val blocks = Int.operator_as(Nz_*Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; {
		  // for(i in rngYInBnd(tid)){
		  val j = tid; {

		    // ht1(tid).PackYM(w.v(),i*Nxy + Nxy-Nx + j);
		    var pos:Long = i*Nxy_ + Nxy_-Nx_ + j;
		    //h0 = w0 - w3
		    val h0_0r_t = w(pos+0*nsite_) - w(pos+18*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+19*nsite_);
		    val h0_1r_t = w(pos+2*nsite_) - w(pos+20*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+21*nsite_);
		    val h0_2r_t = w(pos+4*nsite_) - w(pos+22*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+23*nsite_);

		    //h1 = w1 + w2
		    val h1_0r_t = w(pos+6*nsite_) + w(pos+12*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+13*nsite_);
		    val h1_1r_t = w(pos+8*nsite_) + w(pos+14*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+15*nsite_);
		    val h1_2r_t= w(pos+10*nsite_) + w(pos+16*nsite_);		val h1_2i_t= w(pos+11*nsite_) + w(pos+17*nsite_);

		    // ht2(tid).MultUt(u.v(),offset_uy + i*Nxy + Nxy-Nx + j,ht1(tid));
		    pos = offset_uy_ + i*Nxy_ + Nxy_-Nx_ + j;

		    val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		    u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		    u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t+ 
		    u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t+ 
		    u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		    u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		    u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		    u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		    u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		    u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		    u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		    u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i =	u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		    u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).Store(bx.SendBuffer(bx.YM).v(),i*Nx + j);
		    pos = i*Nx_ + j;

		    bx(pos*12+0) = h0_0r;		bx(pos*12+1) = h0_0i;
		    bx(pos*12+2) = h0_1r;		bx(pos*12+3) = h0_1i;
		    bx(pos*12+4) = h0_2r;		bx(pos*12+5) = h0_2i;

		    bx(pos*12+6) = h1_0r;		bx(pos*12+7) = h1_0i;
		    bx(pos*12+8) = h1_1r;		bx(pos*12+9) = h1_1i;
		    bx(pos*12+10)= h1_2r;		bx(pos*12+11)= h1_2i;
		  }
		}
	      }
	    }
	  }
	}

	def MakeZPBnd(bx : CUDALatticeComm, w : WilsonVectorField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngZOut(tid)){
				for(j in rngZInBnd(tid)){
					ht1(tid).PackZP(w.v(),i*Nxyz + j);
					ht1(tid).Store(bx.SendBuffer(bx.ZP).v(),i*Nxy + j);
				}
			}
		}
	}

	def MakeZPBndKernel(bx : GlobalRail[Float]{home==gpu}, w : GlobalRail[Float]{home==gpu})
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uz_ = offset_uz;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; {
		  // for(i in rngYInBnd(tid)){
		  val j = tid; {

		    // ht1(tid).PackZP(w.v(),i*Nxyz + j);
		    var pos:Long = i*Nxyz_ + j;
		    //h0 = w0 + i*w2
		    val h0_0r = w(pos+0*nsite_) - w(pos+13*nsite_);		val h0_0i = w(pos+1*nsite_) + w(pos+12*nsite_);
		    val h0_1r = w(pos+2*nsite_) - w(pos+15*nsite_);		val h0_1i = w(pos+3*nsite_) + w(pos+14*nsite_);
		    val h0_2r = w(pos+4*nsite_) - w(pos+17*nsite_);		val h0_2i = w(pos+5*nsite_) + w(pos+16*nsite_);

		    //h1 = w1 - i*w3
		    val h1_0r = w(pos+6*nsite_) + w(pos+19*nsite_);		val h1_0i = w(pos+7*nsite_) - w(pos+18*nsite_);
		    val h1_1r = w(pos+8*nsite_) + w(pos+21*nsite_);		val h1_1i = w(pos+9*nsite_) - w(pos+20*nsite_);
		    val h1_2r= w(pos+10*nsite_)+ w(pos+23*nsite_);		val h1_2i= w(pos+11*nsite_)- w(pos+22*nsite_);

		    // ht1(tid).Store(bx.SendBuffer(bx.ZP).v(),i*Nxy + j);
		    pos = i*Nxy_ + j;

		    bx(pos*12+0) = h0_0r;		bx(pos*12+1) = h0_0i;
		    bx(pos*12+2) = h0_1r;		bx(pos*12+3) = h0_1i;
		    bx(pos*12+4) = h0_2r;		bx(pos*12+5) = h0_2i;

		    bx(pos*12+6) = h1_0r;		bx(pos*12+7) = h1_0i;
		    bx(pos*12+8) = h1_1r;		bx(pos*12+9) = h1_1i;
		    bx(pos*12+10)= h1_2r;		bx(pos*12+11)= h1_2i;
		  }
		}
	      }
	    }
	  }
	}

	def MakeZMBnd(bx : CUDALatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngZOut(tid)){
				for(j in rngZInBnd(tid)){
					ht1(tid).PackZM(w.v(),i*Nxyz + Nxyz-Nxy + j);
					ht2(tid).MultUt(u.v(),offset_uz + i*Nxyz + Nxyz-Nxy + j,ht1(tid));
					ht2(tid).Store(bx.SendBuffer(bx.ZM).v(),i*Nxy + j);
				}
			}
		}
	}

	def MakeZMBndKernel(bx : GlobalRail[Float]{home==gpu}, w : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu})
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uz_ = offset_uz;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; {
		  // for(i in rngYInBnd(tid)){
		  val j = tid; {
		    // ht1(tid).PackZM(w.v(),i*Nxyz + Nxyz-Nxy + j);
		    var pos:Long = i*Nxyz_ + Nxyz_-Nxy_ + j;
		    //h0 = w0 - i*w3
		    val h0_0r_t = w(pos+0*nsite_) + w(pos+13*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+12*nsite_);
		    val h0_1r_t = w(pos+2*nsite_) + w(pos+15*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+14*nsite_);
		    val h0_2r_t = w(pos+4*nsite_) + w(pos+17*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+16*nsite_);

		    //h1 = w1 + i*w2
		    val h1_0r_t = w(pos+6*nsite_) - w(pos+19*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+18*nsite_);
		    val h1_1r_t = w(pos+8*nsite_) - w(pos+21*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+20*nsite_);
		    val h1_2r_t= w(pos+10*nsite_)- w(pos+23*nsite_);		val h1_2i_t= w(pos+11*nsite_)+ w(pos+22*nsite_);

		    // ht2(tid).MultUt(u.v(),offset_uz + i*Nxyz + Nxyz-Nxy + j,ht1(tid));
		    pos = offset_uz_ + i*Nxyz_ + Nxyz_-Nxy_ + j;

		    val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		    u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		    u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t+ 
		    u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t+ 
		    u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		    u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		    u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		    u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		    u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		    u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		    u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		    u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i =	u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		    u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).Store(bx.SendBuffer(bx.ZM).v(),i*Nxy + j);
		    pos = i*Nxy_ + j;

		    bx(pos*12+0) = h0_0r;		bx(pos*12+1) = h0_0i;
		    bx(pos*12+2) = h0_1r;		bx(pos*12+3) = h0_1i;
		    bx(pos*12+4) = h0_2r;		bx(pos*12+5) = h0_2i;

		    bx(pos*12+6) = h1_0r;		bx(pos*12+7) = h1_0i;
		    bx(pos*12+8) = h1_1r;		bx(pos*12+9) = h1_1i;
		    bx(pos*12+10)= h1_2r;		bx(pos*12+11)= h1_2i;
		  }
		}
	      }
	    }
	  }
	}

	def MakeTPBnd(bx : CUDALatticeComm, w : WilsonVectorField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngTBnd(tid)){
				ht1(tid).PackTP(w.v(),i);
				ht1(tid).Store(bx.SendBuffer(bx.TP).v(),i);
			}
		}
	}

	def MakeTPBndKernel(bx : GlobalRail[Float]{home==gpu}, w : GlobalRail[Float]{home==gpu})
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ut_ = offset_ut;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < Nxyz_; i += gids) {

		  // ht1(tid).PackTP(w.v(),i);
		  var pos:Long = i;

		  //h0 = 2.0*w2
		  val h0_0r = 2.0f*w(pos+12*nsite_);		val h0_0i = 2.0f*w(pos+13*nsite_);
		  val h0_1r = 2.0f*w(pos+14*nsite_);		val h0_1i = 2.0f*w(pos+15*nsite_);
		  val h0_2r = 2.0f*w(pos+16*nsite_);		val h0_2i = 2.0f*w(pos+17*nsite_);

		  //h1 = 2.0*w3
		  val h1_0r = 2.0f*w(pos+18*nsite_);		val h1_0i = 2.0f*w(pos+19*nsite_);
		  val h1_1r = 2.0f*w(pos+20*nsite_);		val h1_1i = 2.0f*w(pos+21*nsite_);
		  val h1_2r= 2.0f*w(pos+22*nsite_);		val h1_2i= 2.0f*w(pos+23*nsite_);

		  // ht1(tid).Store(bx.SendBuffer(bx.TP).v(),i);
		  bx(i*12+0) = h0_0r;		bx(i*12+1) = h0_0i;
		  bx(i*12+2) = h0_1r;		bx(i*12+3) = h0_1i;
		  bx(i*12+4) = h0_2r;		bx(i*12+5) = h0_2i;

		  bx(i*12+6) = h1_0r;		bx(i*12+7) = h1_0i;
		  bx(i*12+8) = h1_1r;		bx(i*12+9) = h1_1i;
		  bx(i*12+10)= h1_2r;		bx(i*12+11)= h1_2i;
		}
	      }
	    }
	  }
	}

	def MakeTMBnd(bx : CUDALatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngTBnd(tid)){
				ht1(tid).PackTM(w.v(),nsite-Nxyz + i);
				ht2(tid).MultUt(u.v(),offset_ut + nsite-Nxyz + i,ht1(tid));
				ht2(tid).Store(bx.SendBuffer(bx.TM).v(),i);
			}
		}
	}

	def MakeTMBndKernel(bx : GlobalRail[Float]{home==gpu}, w : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu})
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ut_ = offset_ut;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < Nxyz_; i += gids) {

		  // ht1(tid).PackTM(w.v(),nsite-Nxyz + i);
		  var pos:Long = nsite_-Nxyz_ + i;
		  //h0 = 2.0*w0
		  val h0_0r_t = 2.0f*w(pos+0*nsite_);		val h0_0i_t = 2.0f*w(pos+1*nsite_);
		  val h0_1r_t = 2.0f*w(pos+2*nsite_);		val h0_1i_t = 2.0f*w(pos+3*nsite_);
		  val h0_2r_t = 2.0f*w(pos+4*nsite_);		val h0_2i_t = 2.0f*w(pos+5*nsite_);

		  //h1 = 2.0*w1
		  val h1_0r_t = 2.0f*w(pos+6*nsite_);		val h1_0i_t = 2.0f*w(pos+7*nsite_);
		  val h1_1r_t = 2.0f*w(pos+8*nsite_);		val h1_1i_t = 2.0f*w(pos+9*nsite_);
		  val h1_2r_t= 2.0f*w(pos+10*nsite_);		val h1_2i_t= 2.0f*w(pos+11*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_ut + nsite-Nxyz + i,ht1(tid));
		  pos = offset_ut_ + nsite_-Nxyz_ + i;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t+ 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t+ 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).Store(bx.SendBuffer(bx.TM).v(),i);
		  bx(i*12+0) = h0_0r;		bx(i*12+1) = h0_0i;
		  bx(i*12+2) = h0_1r;		bx(i*12+3) = h0_1i;
		  bx(i*12+4) = h0_2r;		bx(i*12+5) = h0_2i;

		  bx(i*12+6) = h1_0r;		bx(i*12+7) = h1_0i;
		  bx(i*12+8) = h1_1r;		bx(i*12+9) = h1_1i;
		  bx(i*12+10)= h1_2r;		bx(i*12+11)= h1_2i;
		}
	      }
	    }
	  }
	}

	def SetXPBnd(bx : CUDALatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				ht1(tid).Load(bx.RecvBuffer(bx.XP).v(),i);
				ht2(tid).MultU(u.v(),offset_ux + i*Nx + Nx - 1,ht1(tid));
				ht2(tid).UnpackXP(v.v(),i*Nx + Nx - 1,cks);
			}
		}
	}

/*
	def SetBndKernel(bxp : GlobalRail[Float]{home==gpu}, bxm : GlobalRail[Float]{home==gpu}, 
			 byp : GlobalRail[Float]{home==gpu}, bym : GlobalRail[Float]{home==gpu}, 
			 bzp : GlobalRail[Float]{home==gpu}, bzm : GlobalRail[Float]{home==gpu}, 
			 btp : GlobalRail[Float]{home==gpu}, btm : GlobalRail[Float]{home==gpu}, 
			 v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;
	  val offset_uy_ = offset_ux;
	  val offset_uz_ = offset_ux;
	  val offset_ut_ = offset_ux;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;

		// SetXPBndKernel
	  	for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {

		  // ht1(tid).Load(bx.RecvBuffer(bx.XP).v(),i);
		  var pos:Long = i;

		  val h0_0r_t  = bxp(pos*12+0);		val h0_0i_t  = bxp(pos*12+1);
		  val h0_1r_t  = bxp(pos*12+2);		val h0_1i_t  = bxp(pos*12+3);
		  val h0_2r_t  = bxp(pos*12+4);		val h0_2i_t  = bxp(pos*12+5);

		  val h1_0r_t  = bxp(pos*12+6);		val h1_0i_t  = bxp(pos*12+7);
		  val h1_1r_t  = bxp(pos*12+8);		val h1_1i_t  = bxp(pos*12+9);
		  val h1_2r_t = bxp(pos*12+10);	        val h1_2i_t = bxp(pos*12+11);

		  // ht2(tid).MultU(u.v(),offset_ux + i*Nx + Nx - 1,ht1(tid));
		  pos = offset_ux_ + i*Nx_ + Nx_ - 1;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackXP(v.v(),i*Nx + Nx - 1,cks);
		  pos = i*Nx_ + Nx_ - 1;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -i*h1
		  v(pos+12*nsite_)= v(pos+12*nsite_)+ cks*h1_0i;		v(pos+13*nsite_)= v(pos+13*nsite_)- cks*h1_0r;
		  v(pos+14*nsite_)= v(pos+14*nsite_)+ cks*h1_1i;		v(pos+15*nsite_)= v(pos+15*nsite_)- cks*h1_1r;
		  v(pos+16*nsite_)= v(pos+16*nsite_)+ cks*h1_2i;		v(pos+17*nsite_)= v(pos+17*nsite_)- cks*h1_2r;

		  //w4 += -i*h0
		  v(pos+18*nsite_)= v(pos+18*nsite_)+ cks*h0_0i;		v(pos+19*nsite_)= v(pos+19*nsite_)- cks*h0_0r;
		  v(pos+20*nsite_)= v(pos+20*nsite_)+ cks*h0_1i;		v(pos+21*nsite_)= v(pos+21*nsite_)- cks*h0_1r;
		  v(pos+22*nsite_)= v(pos+22*nsite_)+ cks*h0_2i;		v(pos+23*nsite_)= v(pos+23*nsite_)- cks*h0_2r;
		}

		// SetXMBndKernel
	  	for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {
		  // ht1(tid).Load(bx.RecvBuffer(bx.XM).v(),i);
		  var pos:Long = i;

		  val h0_0r  = bxm(pos*12+0);		val h0_0i  = bxm(pos*12+1);
		  val h0_1r  = bxm(pos*12+2);		val h0_1i  = bxm(pos*12+3);
		  val h0_2r  = bxm(pos*12+4);		val h0_2i  = bxm(pos*12+5);

		  val h1_0r  = bxm(pos*12+6);		val h1_0i  = bxm(pos*12+7);
		  val h1_1r  = bxm(pos*12+8);		val h1_1i  = bxm(pos*12+9);
		  val h1_2r = bxm(pos*12+10);	        val h1_2i = bxm(pos*12+11);

		  // ht1(tid).UnpackXM(v.v(),i*Nx,cks);
		  pos = i*Nx_;  

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += i*h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2r;

		  //w4 += i*h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2r;
		}
	      }
	    }
	  }
	}
*/
	def SetXPBndKernel(bx : GlobalRail[Float]{home==gpu}, v : GlobalRail[Float]{home==gpu},
			   u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
		// for(i in rngX(tid)){
	  	for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {

		  // ht1(tid).Load(bx.RecvBuffer(bx.XP).v(),i);
		  var pos:Long = i;

		  val h0_0r_t  = bx(pos*12+0);		val h0_0i_t  = bx(pos*12+1);
		  val h0_1r_t  = bx(pos*12+2);		val h0_1i_t  = bx(pos*12+3);
		  val h0_2r_t  = bx(pos*12+4);		val h0_2i_t  = bx(pos*12+5);

		  val h1_0r_t  = bx(pos*12+6);		val h1_0i_t  = bx(pos*12+7);
		  val h1_1r_t  = bx(pos*12+8);		val h1_1i_t  = bx(pos*12+9);
		  val h1_2r_t = bx(pos*12+10);	        val h1_2i_t = bx(pos*12+11);

		  // ht2(tid).MultU(u.v(),offset_ux + i*Nx + Nx - 1,ht1(tid));
		  pos = offset_ux_ + i*Nx_ + Nx_ - 1;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackXP(v.v(),i*Nx + Nx - 1,cks);
		  pos = i*Nx_ + Nx_ - 1;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -i*h1
		  v(pos+12*nsite_)= v(pos+12*nsite_)+ cks*h1_0i;		v(pos+13*nsite_)= v(pos+13*nsite_)- cks*h1_0r;
		  v(pos+14*nsite_)= v(pos+14*nsite_)+ cks*h1_1i;		v(pos+15*nsite_)= v(pos+15*nsite_)- cks*h1_1r;
		  v(pos+16*nsite_)= v(pos+16*nsite_)+ cks*h1_2i;		v(pos+17*nsite_)= v(pos+17*nsite_)- cks*h1_2r;

		  //w4 += -i*h0
		  v(pos+18*nsite_)= v(pos+18*nsite_)+ cks*h0_0i;		v(pos+19*nsite_)= v(pos+19*nsite_)- cks*h0_0r;
		  v(pos+20*nsite_)= v(pos+20*nsite_)+ cks*h0_1i;		v(pos+21*nsite_)= v(pos+21*nsite_)- cks*h0_1r;
		  v(pos+22*nsite_)= v(pos+22*nsite_)+ cks*h0_2i;		v(pos+23*nsite_)= v(pos+23*nsite_)- cks*h0_2r;
		}
	      }
	    }
	  }
	}

	def SetXBndKernel(bxp : GlobalRail[Float]{home==gpu}, bxm : GlobalRail[Float]{home==gpu}, 
			 v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;

		// SetXPBndKernel
	  	for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {

		  // ht1(tid).Load(bx.RecvBuffer(bx.XP).v(),i);
		  var pos:Long = i;

		  val h0_0r_t  = bxp(pos*12+0);		val h0_0i_t  = bxp(pos*12+1);
		  val h0_1r_t  = bxp(pos*12+2);		val h0_1i_t  = bxp(pos*12+3);
		  val h0_2r_t  = bxp(pos*12+4);		val h0_2i_t  = bxp(pos*12+5);

		  val h1_0r_t  = bxp(pos*12+6);		val h1_0i_t  = bxp(pos*12+7);
		  val h1_1r_t  = bxp(pos*12+8);		val h1_1i_t  = bxp(pos*12+9);
		  val h1_2r_t = bxp(pos*12+10);	        val h1_2i_t = bxp(pos*12+11);

		  // ht2(tid).MultU(u.v(),offset_ux + i*Nx + Nx - 1,ht1(tid));
		  pos = offset_ux_ + i*Nx_ + Nx_ - 1;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackXP(v.v(),i*Nx + Nx - 1,cks);
		  pos = i*Nx_ + Nx_ - 1;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -i*h1
		  v(pos+12*nsite_)= v(pos+12*nsite_)+ cks*h1_0i;		v(pos+13*nsite_)= v(pos+13*nsite_)- cks*h1_0r;
		  v(pos+14*nsite_)= v(pos+14*nsite_)+ cks*h1_1i;		v(pos+15*nsite_)= v(pos+15*nsite_)- cks*h1_1r;
		  v(pos+16*nsite_)= v(pos+16*nsite_)+ cks*h1_2i;		v(pos+17*nsite_)= v(pos+17*nsite_)- cks*h1_2r;

		  //w4 += -i*h0
		  v(pos+18*nsite_)= v(pos+18*nsite_)+ cks*h0_0i;		v(pos+19*nsite_)= v(pos+19*nsite_)- cks*h0_0r;
		  v(pos+20*nsite_)= v(pos+20*nsite_)+ cks*h0_1i;		v(pos+21*nsite_)= v(pos+21*nsite_)- cks*h0_1r;
		  v(pos+22*nsite_)= v(pos+22*nsite_)+ cks*h0_2i;		v(pos+23*nsite_)= v(pos+23*nsite_)- cks*h0_2r;
		}

		// SetXMBndKernel
	  	for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {
		  // ht1(tid).Load(bx.RecvBuffer(bx.XM).v(),i);
		  var pos:Long = i;

		  val h0_0r  = bxm(pos*12+0);		val h0_0i  = bxm(pos*12+1);
		  val h0_1r  = bxm(pos*12+2);		val h0_1i  = bxm(pos*12+3);
		  val h0_2r  = bxm(pos*12+4);		val h0_2i  = bxm(pos*12+5);

		  val h1_0r  = bxm(pos*12+6);		val h1_0i  = bxm(pos*12+7);
		  val h1_1r  = bxm(pos*12+8);		val h1_1i  = bxm(pos*12+9);
		  val h1_2r = bxm(pos*12+10);	        val h1_2i = bxm(pos*12+11);

		  // ht1(tid).UnpackXM(v.v(),i*Nx,cks);
		  pos = i*Nx_;  

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += i*h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2r;

		  //w4 += i*h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2r;
		}
	      }
	    }
	  }
	}

	def SetXMBnd(bx : CUDALatticeComm, v : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				ht1(tid).Load(bx.RecvBuffer(bx.XM).v(),i);
				ht1(tid).UnpackXM(v.v(),i*Nx,cks);
			}
		}
	}

	def SetXMBndKernel(bx : GlobalRail[Float]{home==gpu}, v : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {
		  // ht1(tid).Load(bx.RecvBuffer(bx.XM).v(),i);
		  var pos:Long = i;

		  val h0_0r  = bx(pos*12+0);		val h0_0i  = bx(pos*12+1);
		  val h0_1r  = bx(pos*12+2);		val h0_1i  = bx(pos*12+3);
		  val h0_2r  = bx(pos*12+4);		val h0_2i  = bx(pos*12+5);

		  val h1_0r  = bx(pos*12+6);		val h1_0i  = bx(pos*12+7);
		  val h1_1r  = bx(pos*12+8);		val h1_1i  = bx(pos*12+9);
		  val h1_2r = bx(pos*12+10);	        val h1_2i = bx(pos*12+11);

		  // ht1(tid).UnpackXM(v.v(),i*Nx,cks);
		  pos = i*Nx_;  

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += i*h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2r;

		  //w4 += i*h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2r;
		}
	      }
	    }
	  }
	}

	def SetYPBnd(bx : CUDALatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngYOut(tid)){
				for(j in rngYInBnd(tid)){
					ht1(tid).Load(bx.RecvBuffer(bx.YP).v(),i*Nx + j);
					ht2(tid).MultU(u.v(),offset_uy + i*Nxy + Nxy-Nx + j,ht1(tid));
					ht2(tid).UnpackYP(v.v(),i*Nxy + Nxy-Nx + j,cks);
				}
			}
		}
	}

  // rngYOut(tid) = new LongRange(io * Nt*Nz / no,(io + 1) * Nt*Nz / no-1);
  // rngYInBnd(tid)  = new LongRange(ii * Nx / ni,(ii + 1) * Nx / ni-1);
	def SetYBndKernel(bxp : GlobalRail[Float]{home==gpu}, bxm : GlobalRail[Float]{home==gpu}, 
			   v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uy_ = offset_uy;

	  val threads = Int.operator_as(Nx_);
	  val blocks = Int.operator_as(Nz_*Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; 
		val j = tid; 
		{
		  // for(i in rngYInBnd(tid)){
// 		  val j = tid; {
		  // ht1(tid).Load(bx.RecvBuffer(bx.YP).v(),i*Nx + j);
		  var pos:Long = i*Nx_ + j;

		  val h0_0r_t  = bxp(pos*12+0);		val h0_0i_t  = bxp(pos*12+1);
		  val h0_1r_t  = bxp(pos*12+2);		val h0_1i_t  = bxp(pos*12+3);
		  val h0_2r_t  = bxp(pos*12+4);		val h0_2i_t  = bxp(pos*12+5);

		  val h1_0r_t  = bxp(pos*12+6);		val h1_0i_t  = bxp(pos*12+7);
		  val h1_1r_t  = bxp(pos*12+8);		val h1_1i_t  = bxp(pos*12+9);
		  val h1_2r_t = bxp(pos*12+10);	        val h1_2i_t = bxp(pos*12+11);

		  // ht2(tid).MultU(u.v(),offset_uy + i*Nxy + Nxy-Nx + j,ht1(tid));
		  pos = offset_uy_ + i*Nxy_ + Nxy_-Nx_ + j;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackYP(v.v(),i*Nxy + Nxy-Nx + j,cks);
		  pos = i*Nxy_ + Nxy_-Nx_ + j;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h1_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h1_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h1_2i;

		  //w4 += cks*h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2i;
		}
		{
		  // for(i in rngYInBnd(tid)){
// 		  val j = tid; {
// 		  {
		    // ht1(tid).Load(bx.RecvBuffer(bx.YM).v(),i*Nx + j);
		    var pos:Long = i*Nx_ + j;

		    val h0_0r  = bxm(pos*12+0);		val h0_0i  = bxm(pos*12+1);
		    val h0_1r  = bxm(pos*12+2);		val h0_1i  = bxm(pos*12+3);
		    val h0_2r  = bxm(pos*12+4);		val h0_2i  = bxm(pos*12+5);

		    val h1_0r  = bxm(pos*12+6);		val h1_0i  = bxm(pos*12+7);
		    val h1_1r  = bxm(pos*12+8);		val h1_1i  = bxm(pos*12+9);
		    val h1_2r = bxm(pos*12+10);	        val h1_2i = bxm(pos*12+11);

		    // ht1(tid).UnpackYM(v.v(),i*Nxy + j,cks);
		    pos = i*Nxy_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += cks*h1
		    v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0i;
		    v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1i;
		    v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2i;

		    //w4 += -h0
		    v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h0_0i;
		    v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h0_1i;
		    v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h0_2i;
// 		  }
		}
	      }
	    }
	  }
	}

	def SetYPBndKernel(bx : GlobalRail[Float]{home==gpu}, v : GlobalRail[Float]{home==gpu},
			   u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uy_ = offset_uy;

	  val threads = Int.operator_as(Nx_);
	  val blocks = Int.operator_as(Nz_*Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; {
		  // for(i in rngYInBnd(tid)){
		  val j = tid; {
		    // ht1(tid).Load(bx.RecvBuffer(bx.YP).v(),i*Nx + j);
		    var pos:Long = i*Nx_ + j;

		    val h0_0r_t  = bx(pos*12+0);		val h0_0i_t  = bx(pos*12+1);
		    val h0_1r_t  = bx(pos*12+2);		val h0_1i_t  = bx(pos*12+3);
		    val h0_2r_t  = bx(pos*12+4);		val h0_2i_t  = bx(pos*12+5);

		    val h1_0r_t  = bx(pos*12+6);		val h1_0i_t  = bx(pos*12+7);
		    val h1_1r_t  = bx(pos*12+8);		val h1_1i_t  = bx(pos*12+9);
		    val h1_2r_t = bx(pos*12+10);	        val h1_2i_t = bx(pos*12+11);

		    // ht2(tid).MultU(u.v(),offset_uy + i*Nxy + Nxy-Nx + j,ht1(tid));
		    pos = offset_uy_ + i*Nxy_ + Nxy_-Nx_ + j;

		    val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		    u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		    u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		    u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		    u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		    u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		    u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		    u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		    u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		    u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		    u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		    u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		    u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).UnpackYP(v.v(),i*Nxy + Nxy-Nx + j,cks);
		    pos = i*Nxy_ + Nxy_-Nx_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += -h1
		    v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h1_0i;
		    v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h1_1i;
		    v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h1_2i;

		    //w4 += cks*h0
		    v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0i;
		    v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1i;
		    v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2i;
		  }
		}
	      }
	    }
	  }
	}

	def SetYMBnd(bx : CUDALatticeComm, v : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngYOut(tid)){
				for(j in rngYInBnd(tid)){
					ht1(tid).Load(bx.RecvBuffer(bx.YM).v(),i*Nx + j);
					ht1(tid).UnpackYM(v.v(),i*Nxy + j,cks);
				}
			}
		}
	}

	def SetYMBndKernel(bx : GlobalRail[Float]{home==gpu}, v : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uy_ = offset_uy;

	  val threads = Int.operator_as(Nx_);
	  val blocks = Int.operator_as(Nz_*Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; {
		  // for(i in rngYInBnd(tid)){
		  val j = tid; {
		    // ht1(tid).Load(bx.RecvBuffer(bx.YM).v(),i*Nx + j);
		    var pos:Long = i*Nx_ + j;

		    val h0_0r  = bx(pos*12+0);		val h0_0i  = bx(pos*12+1);
		    val h0_1r  = bx(pos*12+2);		val h0_1i  = bx(pos*12+3);
		    val h0_2r  = bx(pos*12+4);		val h0_2i  = bx(pos*12+5);

		    val h1_0r  = bx(pos*12+6);		val h1_0i  = bx(pos*12+7);
		    val h1_1r  = bx(pos*12+8);		val h1_1i  = bx(pos*12+9);
		    val h1_2r = bx(pos*12+10);	        val h1_2i = bx(pos*12+11);

		    // ht1(tid).UnpackYM(v.v(),i*Nxy + j,cks);
		    pos = i*Nxy_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += cks*h1
		    v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0i;
		    v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1i;
		    v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2i;

		    //w4 += -h0
		    v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h0_0i;
		    v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h0_1i;
		    v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h0_2i;
		  }
		}
	      }
	    }
	  }
	}

	def SetZPBnd(bx : CUDALatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngZOut(tid)){
				for(j in rngZInBnd(tid)){
					ht1(tid).Load(bx.RecvBuffer(bx.ZP).v(),i*Nxy + j);
					ht2(tid).MultU(u.v(),offset_uz + i*Nxyz + Nxyz-Nxy + j,ht1(tid));
					ht2(tid).UnpackZP(v.v(),i*Nxyz + Nxyz-Nxy + j,cks);
				}
			}
		}
	}

	def SetZBndKernel(bxp : GlobalRail[Float]{home==gpu}, bxm : GlobalRail[Float]{home==gpu}, 
			  v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uz_ = offset_uz;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid;
		val j = tid; 
		{
		  // for(i in rngYInBnd(tid)){
// 		  val j = tid; {
		    // ht1(tid).Load(bx.RecvBuffer(bx.ZP).v(),i*Nxy + j);
		    var pos:Long = i*Nxy_ + j;

		    val h0_0r_t  = bxp(pos*12+0);		val h0_0i_t  = bxp(pos*12+1);
		    val h0_1r_t  = bxp(pos*12+2);		val h0_1i_t  = bxp(pos*12+3);
		    val h0_2r_t  = bxp(pos*12+4);		val h0_2i_t  = bxp(pos*12+5);

		    val h1_0r_t  = bxp(pos*12+6);		val h1_0i_t  = bxp(pos*12+7);
		    val h1_1r_t  = bxp(pos*12+8);		val h1_1i_t  = bxp(pos*12+9);
		    val h1_2r_t = bxp(pos*12+10);	        val h1_2i_t = bxp(pos*12+11);

		    // ht2(tid).MultU(u.v(),offset_uz + i*Nxyz + Nxyz-Nxy + j,ht1(tid));
		    pos = offset_uz_ + i*Nxyz_ + Nxyz_-Nxy_ + j;

		    val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		    u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		    u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		    u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		    u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		    u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		    u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		    u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		    u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		    u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		    u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		    u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		    u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).UnpackZP(v.v(),i*Nxyz + Nxyz-Nxy + j,cks);
		    pos = i*Nxyz_ + Nxyz_-Nxy_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += -i*h0
		    v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h0_0r;
		    v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h0_1r;
		    v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h0_2r;

		    //w4 += i*h1
		    v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0r;
		    v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1r;
		    v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2r;
		  }
		{
		  // for(i in rngYInBnd(tid)){
// 		  val j = tid; {
// 		  {
		    // ht1(tid).Load(bx.RecvBuffer(bx.ZM).v(),i*Nxy + j);
		    var pos:Long = i*Nxy_ + j;

		    val h0_0r  = bxm(pos*12+0);		val h0_0i  = bxm(pos*12+1);
		    val h0_1r  = bxm(pos*12+2);		val h0_1i  = bxm(pos*12+3);
		    val h0_2r  = bxm(pos*12+4);		val h0_2i  = bxm(pos*12+5);

		    val h1_0r  = bxm(pos*12+6);		val h1_0i  = bxm(pos*12+7);
		    val h1_1r  = bxm(pos*12+8);		val h1_1i  = bxm(pos*12+9);
		    val h1_2r = bxm(pos*12+10);	        val h1_2i = bxm(pos*12+11);

		    // ht1(tid).UnpackZM(v.v(),i*Nxyz + j,cks);
		    pos = i*Nxyz_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += i*h0
		    v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0r;
		    v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1r;
		    v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2r;

		    //w4 += -i*h1
		    v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h1_0r;
		    v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h1_1r;
		    v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h1_2r;
// 		  }
		}
	      }
	    }
	  }
	}		    

	def SetZPBndKernel(bx : GlobalRail[Float]{home==gpu}, v : GlobalRail[Float]{home==gpu},
			   u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uz_ = offset_uz;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; {
		  // for(i in rngYInBnd(tid)){
		  val j = tid; {
		    // ht1(tid).Load(bx.RecvBuffer(bx.ZP).v(),i*Nxy + j);
		    var pos:Long = i*Nxy_ + j;

		    val h0_0r_t  = bx(pos*12+0);		val h0_0i_t  = bx(pos*12+1);
		    val h0_1r_t  = bx(pos*12+2);		val h0_1i_t  = bx(pos*12+3);
		    val h0_2r_t  = bx(pos*12+4);		val h0_2i_t  = bx(pos*12+5);

		    val h1_0r_t  = bx(pos*12+6);		val h1_0i_t  = bx(pos*12+7);
		    val h1_1r_t  = bx(pos*12+8);		val h1_1i_t  = bx(pos*12+9);
		    val h1_2r_t = bx(pos*12+10);	        val h1_2i_t = bx(pos*12+11);

		    // ht2(tid).MultU(u.v(),offset_uz + i*Nxyz + Nxyz-Nxy + j,ht1(tid));
		    pos = offset_uz_ + i*Nxyz_ + Nxyz_-Nxy_ + j;

		    val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		    u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		    u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		    u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		    u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		    u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		    u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		    u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		    u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		    u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		    u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		    u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		    u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).UnpackZP(v.v(),i*Nxyz + Nxyz-Nxy + j,cks);
		    pos = i*Nxyz_ + Nxyz_-Nxy_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += -i*h0
		    v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h0_0r;
		    v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h0_1r;
		    v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h0_2r;

		    //w4 += i*h1
		    v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0r;
		    v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1r;
		    v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2r;
		  }
		}
	      }
	    }
	  }
	}		    

	def SetZMBnd(bx : CUDALatticeComm, v : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngZOut(tid)){
				for(j in rngZInBnd(tid)){
					ht1(tid).Load(bx.RecvBuffer(bx.ZM).v(),i*Nxy + j);
					ht1(tid).UnpackZM(v.v(),i*Nxyz + j,cks);
				}
			}
		}
	}

	def SetZMBndKernel(bx : GlobalRail[Float]{home==gpu}, v : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uz_ = offset_uz;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(Nt_);

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
		// for(i in rngYOut(tid)){
	  	// for (var i:Long = gid; i < Nz_*Nt_; i += gids) {
		val i = bid; {
		  // for(i in rngYInBnd(tid)){
		  val j = tid; {
		    // ht1(tid).Load(bx.RecvBuffer(bx.ZM).v(),i*Nxy + j);
		    var pos:Long = i*Nxy_ + j;

		    val h0_0r  = bx(pos*12+0);		val h0_0i  = bx(pos*12+1);
		    val h0_1r  = bx(pos*12+2);		val h0_1i  = bx(pos*12+3);
		    val h0_2r  = bx(pos*12+4);		val h0_2i  = bx(pos*12+5);

		    val h1_0r  = bx(pos*12+6);		val h1_0i  = bx(pos*12+7);
		    val h1_1r  = bx(pos*12+8);		val h1_1i  = bx(pos*12+9);
		    val h1_2r = bx(pos*12+10);	        val h1_2i = bx(pos*12+11);

		    // ht1(tid).UnpackZM(v.v(),i*Nxyz + j,cks);
		    pos = i*Nxyz_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += i*h0
		    v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0r;
		    v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1r;
		    v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2r;

		    //w4 += -i*h1
		    v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h1_0r;
		    v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h1_1r;
		    v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h1_2r;
		  }
		}
	      }
	    }
	  }
	}

	def SetTPBnd(bx : CUDALatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngTBnd(tid)){
				ht1(tid).Load(bx.RecvBuffer(bx.TP).v(),i);
				ht2(tid).MultU(u.v(),offset_ut + nsite-Nxyz + i,ht1(tid));
				ht2(tid).UnpackTP(v.v(),nsite-Nxyz + i,cks);
			}
		}
	}

	def SetTPBndKernel(bx : GlobalRail[Float]{home==gpu}, v : GlobalRail[Float]{home==gpu},
			   u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ut_ = offset_ut;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < Nxyz_; i += gids) {

		  // ht1(tid).Load(bx.RecvBuffer(bx.TP).v(),i);
		  var pos:Long = i;

		  val h0_0r_t  = bx(pos*12+0);		val h0_0i_t  = bx(pos*12+1);
		  val h0_1r_t  = bx(pos*12+2);		val h0_1i_t  = bx(pos*12+3);
		  val h0_2r_t  = bx(pos*12+4);		val h0_2i_t  = bx(pos*12+5);

		  val h1_0r_t  = bx(pos*12+6);		val h1_0i_t  = bx(pos*12+7);
		  val h1_1r_t  = bx(pos*12+8);		val h1_1i_t  = bx(pos*12+9);
		  val h1_2r_t = bx(pos*12+10);	        val h1_2i_t = bx(pos*12+11);

		  // ht2(tid).MultU(u.v(),offset_ut + nsite-Nxyz + i,ht1(tid));
		  pos = offset_ut_ + nsite_-Nxyz_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackTP(v.v(),nsite-Nxyz + i,cks);
		  pos = nsite_-Nxyz_ + i;

		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2i;

		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2i;
		}
	      }
	    }
	  }
	}

	def SetTMBnd(bx : CUDALatticeComm, v : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngTBnd(tid)){
				ht1(tid).Load(bx.RecvBuffer(bx.TM).v(),i);
				ht1(tid).UnpackTM(v.v(),i,cks);
			}
		}
	}

	def SetTMBndKernel(bx : GlobalRail[Float]{home==gpu}, v : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ut_ = offset_ut;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < Nxyz_; i += gids) {

		  // ht1(tid).Load(bx.RecvBuffer(bx.TM).v(),i);
		  var pos:Long = i;

		  val h0_0r  = bx(pos*12+0);		val h0_0i  = bx(pos*12+1);
		  val h0_1r  = bx(pos*12+2);		val h0_1i  = bx(pos*12+3);
		  val h0_2r  = bx(pos*12+4);		val h0_2i  = bx(pos*12+5);

		  val h1_0r  = bx(pos*12+6);		val h1_0i  = bx(pos*12+7);
		  val h1_1r  = bx(pos*12+8);		val h1_1i  = bx(pos*12+9);
		  val h1_2r = bx(pos*12+10);	        val h1_2i = bx(pos*12+11);

		  // ht1(tid).UnpackTM(v.v(),i,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;
		}
	      }
	    }
	  }
	}

        def SetTBndKernel(bxp : GlobalRail[Float]{home==gpu}, bxm : GlobalRail[Float]{home==gpu},
			  v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ut_ = offset_ut;

	  finish async at (gpu) @CUDA @CUDADirectParams {
	    val blocks = CUDAUtilities.autoBlocks();
	    val threads = CUDAUtilities.autoThreads();
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {
	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;
	  	for (var i:Long = gid; i < Nxyz_; i += gids) {

		  // ht1(tid).Load(bx.RecvBuffer(bx.TP).v(),i);
		  var pos:Long = i;

		  val h0_0r_t  = bxp(pos*12+0);		val h0_0i_t  = bxp(pos*12+1);
		  val h0_1r_t  = bxp(pos*12+2);		val h0_1i_t  = bxp(pos*12+3);
		  val h0_2r_t  = bxp(pos*12+4);		val h0_2i_t  = bxp(pos*12+5);

		  val h1_0r_t  = bxp(pos*12+6);		val h1_0i_t  = bxp(pos*12+7);
		  val h1_1r_t  = bxp(pos*12+8);		val h1_1i_t  = bxp(pos*12+9);
		  val h1_2r_t = bxp(pos*12+10);	        val h1_2i_t = bxp(pos*12+11);

		  // ht2(tid).MultU(u.v(),offset_ut + nsite-Nxyz + i,ht1(tid));
		  pos = offset_ut_ + nsite_-Nxyz_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i = u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackTP(v.v(),nsite-Nxyz + i,cks);
		  pos = nsite_-Nxyz_ + i;

		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2i;

		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2i;
		}

		// SetTMBndKernel
	  	for (var i:Long = gid; i < Nxyz_; i += gids) {

		  // ht1(tid).Load(bx.RecvBuffer(bx.TM).v(),i);
		  var pos:Long = i;

		  val h0_0r  = bxm(pos*12+0);		val h0_0i  = bxm(pos*12+1);
		  val h0_1r  = bxm(pos*12+2);		val h0_1i  = bxm(pos*12+3);
		  val h0_2r  = bxm(pos*12+4);		val h0_2i  = bxm(pos*12+5);

		  val h1_0r  = bxm(pos*12+6);		val h1_0i  = bxm(pos*12+7);
		  val h1_1r  = bxm(pos*12+8);		val h1_1i  = bxm(pos*12+9);
		  val h1_2r = bxm(pos*12+10);	        val h1_2i = bxm(pos*12+11);

		  // ht1(tid).UnpackTM(v.v(),i,cks);
// 		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;
		}
	      }
	    }
	  }
	}

	def MultKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val size = v.size;

	  val offset_ux_ = offset_ux;
	  val offset_uy_ = offset_uy;
	  val offset_uz_ = offset_uz;
	  val offset_ut_ = offset_ut;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  

		var i:Long;

	  	val gid = bid * threads + tid;
	  	val gids = blocks * threads;

		// Copy previous iteration result
	  	for (i = gid; i < size; i += gids) {
	  	  v(i) = w(i);
	  	}

		val tid_x = tid % Nx_;
		val tid_y = tid / Nx_;
		val bid_z = bid % Nz_;
		val bid_t = bid / Nz_;

		//MultTPKernel
		i = tid + bid*Nxy_; if (i < nsite_-Nxyz_) {
		  var pos:Long = i + Nxyz_;

		  //h0 = 2.0*w2
		  val h0_0r_t = 2.0f*w(pos+12*nsite_);		val h0_0i_t = 2.0f*w(pos+13*nsite_);
		  val h0_1r_t = 2.0f*w(pos+14*nsite_);		val h0_1i_t = 2.0f*w(pos+15*nsite_);
		  val h0_2r_t = 2.0f*w(pos+16*nsite_);		val h0_2i_t = 2.0f*w(pos+17*nsite_);

		  //h1 = 2.0*w3
		  val h1_0r_t = 2.0f*w(pos+18*nsite_);		val h1_0i_t = 2.0f*w(pos+19*nsite_);
		  val h1_1r_t = 2.0f*w(pos+20*nsite_);		val h1_1i_t = 2.0f*w(pos+21*nsite_);
		  val h1_2r_t = 2.0f*w(pos+22*nsite_);		val h1_2i_t = 2.0f*w(pos+23*nsite_);

		  // ht2(tid).MultU(u.v(),offset_ut + i,ht1(tid));
		  pos = offset_ut_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackTP(v.v(),i,cks);
		  pos = i;

		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2i;

		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2i;
		}

		//MultTMKernel
		if (i > Nxyz_) {
		  var pos:Long = i - Nxyz_;

		  //h0 = 2.0*w0
		  val h0_0r_t = 2.0f*w(pos+0*nsite_);		val h0_0i_t = 2.0f*w(pos+1*nsite_);
		  val h0_1r_t = 2.0f*w(pos+2*nsite_);		val h0_1i_t = 2.0f*w(pos+3*nsite_);
		  val h0_2r_t = 2.0f*w(pos+4*nsite_);		val h0_2i_t = 2.0f*w(pos+5*nsite_);

		  //h1 = 2.0*w1
		  val h1_0r_t = 2.0f*w(pos+6*nsite_);		val h1_0i_t = 2.0f*w(pos+7*nsite_);
		  val h1_1r_t = 2.0f*w(pos+8*nsite_);		val h1_1i_t = 2.0f*w(pos+9*nsite_);
		  val h1_2r_t = 2.0f*w(pos+10*nsite_);		val h1_2i_t = 2.0f*w(pos+11*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_ut + i,ht1(tid));
		  pos = offset_ut_ + i - Nxyz_;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackTM(v.v(),i + Nxyz,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;
		}

		// MultXPKernel
		i = tid + bid*Nxy_; if (tid_x < Nx_ - 1) {
                  // dht1.PackXP(w,i*Nx + j + 1);
		  var pos:Long = i + 1;

		  //h0 = w0 + i*w3
		  val h0_0r_t = w(pos+0*nsite_) - w(pos+19*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+18*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) - w(pos+21*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+20*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) - w(pos+23*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+22*nsite_);

		  //h1 = w1 + i*w2
		  val h1_0r_t = w(pos+6*nsite_) - w(pos+13*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+12*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) - w(pos+15*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+14*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)- w(pos+17*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+16*nsite_);

	          // dht2.MultU(v,offset_ux + i*Nx + j,dht1);
		  pos = offset_ux_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // dht2.UnpackXP(v,i*Nx + j,cks);		
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -i*h1
		  v(pos+12*nsite_)= v(pos+12*nsite_)+ cks*h1_0i;		v(pos+13*nsite_)= v(pos+13*nsite_)- cks*h1_0r;
		  v(pos+14*nsite_)= v(pos+14*nsite_)+ cks*h1_1i;		v(pos+15*nsite_)= v(pos+15*nsite_)- cks*h1_1r;
		  v(pos+16*nsite_)= v(pos+16*nsite_)+ cks*h1_2i;		v(pos+17*nsite_)= v(pos+17*nsite_)- cks*h1_2r;

		  //w4 += -i*h0
		  v(pos+18*nsite_)= v(pos+18*nsite_)+ cks*h0_0i;		v(pos+19*nsite_)= v(pos+19*nsite_)- cks*h0_0r;
		  v(pos+20*nsite_)= v(pos+20*nsite_)+ cks*h0_1i;		v(pos+21*nsite_)= v(pos+21*nsite_)- cks*h0_1r;
		  v(pos+22*nsite_)= v(pos+22*nsite_)+ cks*h0_2i;		v(pos+23*nsite_)= v(pos+23*nsite_)- cks*h0_2r;
		}


		//MultXMKernel
		if (tid_x > 0) {
		  // ht1(tid).PackXM(w.v(),i*Nx + j - 1);
		  var pos:Long = i - 1;

		  //h0 = w0 - i*w3
		  val h0_0r_t = w(pos+0*nsite_) + w(pos+19*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+18*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) + w(pos+21*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+20*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) + w(pos+23*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+22*nsite_);

		  //h1 = w1 - i*w2
		  val h1_0r_t = w(pos+6*nsite_) + w(pos+13*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+12*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) + w(pos+15*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+14*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)+ w(pos+17*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+16*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_ux + i*Nx + j - 1,ht1(tid));
		  pos = offset_ux_ + i - 1;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t+ 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t+ 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackXM(v.v(),i*Nx + j,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += i*h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2r;

		  //w4 += i*h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2r;
		}

		//MultYPKernel
		i = tid + bid*Nxy_; if (tid_y < Ny_ - 1) {
		  // ht1(tid).PackYP(w.v(),i*Nxy + j + Nx);
		  var pos:Long = i + Nx_;

		  //h0 = w0 + w3
		  val h0_0r_t = w(pos+0*nsite_) + w(pos+18*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+19*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) + w(pos+20*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+21*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) + w(pos+22*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+23*nsite_);

		  //h1 = w1 - w2
		  val h1_0r_t = w(pos+6*nsite_) - w(pos+12*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+13*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) - w(pos+14*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+15*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)- w(pos+16*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+17*nsite_);

		  // ht2(tid).MultU(u.v(),offset_uy + i*Nxy + j,ht1(tid));
		  pos = offset_uy_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackYP(v.v(),i*Nxy + j,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h1_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h1_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h1_2i;

		  //w4 += cks*h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2i;
		}

		//MultYMKernel
		if (tid_y > 0) {
		  // ht1(tid).PackYM(w.v(),i*Nxy + j);
		  var pos:Long = i - Nx_;

		  //h0 = w0 - w3
		  val h0_0r_t = w(pos+0*nsite_) - w(pos+18*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+19*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) - w(pos+20*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+21*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) - w(pos+22*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+23*nsite_);

		  //h1 = w1 + w2
		  val h1_0r_t = w(pos+6*nsite_) + w(pos+12*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+13*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) + w(pos+14*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+15*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)+ w(pos+16*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+17*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_uy + i*Nxy + j,ht1(tid));
		  pos = offset_uy_ + i - Nx_;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackYM(v.v(),i*Nxy + j + Nx,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += cks*h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2i;

		  //w4 += -h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h0_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h0_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h0_2i;
		}

		// MultZPKernel
		i = tid + bid*Nxy_; if (bid_z < Nz_ - 1) {
		  // ht1(tid).PackZP(w.v(),i*Nxyz + j + Nxy);
	          var pos:Long = i + Nxy_;

		  //h0 = w0 + i*w2
		  val h0_0r_t = w(pos+0*nsite_) - w(pos+13*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+12*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) - w(pos+15*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+14*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) - w(pos+17*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+16*nsite_);

		  //h1 = w1 - i*w3
		  val h1_0r_t = w(pos+6*nsite_) + w(pos+19*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+18*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) + w(pos+21*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+20*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)+ w(pos+23*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+22*nsite_);

		  // ht2(tid).MultU(u.v(),offset_uz + i*Nxyz + j,ht1(tid));
		  pos = offset_uz_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackZP(v.v(),i*Nxyz + j,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -i*h0
		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h0_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h0_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h0_2r;

		  //w4 += i*h1
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2r;
		}

 		//MultZMKernel
		if (bid_z > 0) {
		  // ht1(tid).PackZM(w.v(),i*Nxyz + j);
		  var pos:Long = i - Nxy_;

		  //h0 = w0 - i*w3
		  val h0_0r_t = w(pos+0*nsite_) + w(pos+13*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+12*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) + w(pos+15*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+14*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) + w(pos+17*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+16*nsite_);

		  //h1 = w1 + i*w2
		  val h1_0r_t = w(pos+6*nsite_) - w(pos+19*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+18*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) - w(pos+21*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+20*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)- w(pos+23*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+22*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_uz + i*Nxyz + j,ht1(tid));
		  pos = offset_uz_ + i - Nxy_;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackZM(v.v(),i*Nxyz + j + Nxy,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += i*h0
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2r;

		  //w4 += -i*h1
		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h1_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h1_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h1_2r;
		}
	      }
	    }
	  }
	}

	def MultXKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  

		var i:Long;

		val tid_x = tid % Nx_;
		val tid_y = tid / Nx_;
		val bid_z = bid % Nz_;
		val bid_t = bid / Nz_;

		// MultXPKernel
		i = tid + bid*Nxy_; if (tid_x < Nx_ - 1) {
                  // dht1.PackXP(w,i*Nx + j + 1);
		  var pos:Long = i + 1;

		  //h0 = w0 + i*w3
		  val h0_0r_t = w(pos+0*nsite_) - w(pos+19*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+18*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) - w(pos+21*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+20*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) - w(pos+23*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+22*nsite_);

		  //h1 = w1 + i*w2
		  val h1_0r_t = w(pos+6*nsite_) - w(pos+13*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+12*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) - w(pos+15*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+14*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)- w(pos+17*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+16*nsite_);

	          // dht2.MultU(v,offset_ux + i*Nx + j,dht1);
		  pos = offset_ux_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // dht2.UnpackXP(v,i*Nx + j,cks);		
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -i*h1
		  v(pos+12*nsite_)= v(pos+12*nsite_)+ cks*h1_0i;		v(pos+13*nsite_)= v(pos+13*nsite_)- cks*h1_0r;
		  v(pos+14*nsite_)= v(pos+14*nsite_)+ cks*h1_1i;		v(pos+15*nsite_)= v(pos+15*nsite_)- cks*h1_1r;
		  v(pos+16*nsite_)= v(pos+16*nsite_)+ cks*h1_2i;		v(pos+17*nsite_)= v(pos+17*nsite_)- cks*h1_2r;

		  //w4 += -i*h0
		  v(pos+18*nsite_)= v(pos+18*nsite_)+ cks*h0_0i;		v(pos+19*nsite_)= v(pos+19*nsite_)- cks*h0_0r;
		  v(pos+20*nsite_)= v(pos+20*nsite_)+ cks*h0_1i;		v(pos+21*nsite_)= v(pos+21*nsite_)- cks*h0_1r;
		  v(pos+22*nsite_)= v(pos+22*nsite_)+ cks*h0_2i;		v(pos+23*nsite_)= v(pos+23*nsite_)- cks*h0_2r;
		}


		//MultXMKernel
		if (tid_x > 0) {
		  // ht1(tid).PackXM(w.v(),i*Nx + j - 1);
		  var pos:Long = i - 1;

		  //h0 = w0 - i*w3
		  val h0_0r_t = w(pos+0*nsite_) + w(pos+19*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+18*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) + w(pos+21*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+20*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) + w(pos+23*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+22*nsite_);

		  //h1 = w1 - i*w2
		  val h1_0r_t = w(pos+6*nsite_) + w(pos+13*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+12*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) + w(pos+15*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+14*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)+ w(pos+17*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+16*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_ux + i*Nx + j - 1,ht1(tid));
		  pos = offset_ux_ + i - 1;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t+ 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t+ 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackXM(v.v(),i*Nx + j,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += i*h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2r;

		  //w4 += i*h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2r;
		}
	      }
	    }
	  }
	}

	def MultYKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uy_ = offset_uy;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  

		var i:Long;

		val tid_x = tid % Nx_;
		val tid_y = tid / Nx_;
		val bid_z = bid % Nz_;
		val bid_t = bid / Nz_;

		//MultYPKernel
		i = tid + bid*Nxy_; if (tid_y < Ny_ - 1) {
		  // ht1(tid).PackYP(w.v(),i*Nxy + j + Nx);
		  var pos:Long = i + Nx_;

		  //h0 = w0 + w3
		  val h0_0r_t = w(pos+0*nsite_) + w(pos+18*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+19*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) + w(pos+20*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+21*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) + w(pos+22*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+23*nsite_);

		  //h1 = w1 - w2
		  val h1_0r_t = w(pos+6*nsite_) - w(pos+12*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+13*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) - w(pos+14*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+15*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)- w(pos+16*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+17*nsite_);

		  // ht2(tid).MultU(u.v(),offset_uy + i*Nxy + j,ht1(tid));
		  pos = offset_uy_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackYP(v.v(),i*Nxy + j,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h1_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h1_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h1_2i;

		  //w4 += cks*h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2i;
		}

		//MultYMKernel
		if (tid_y > 0) {
		  // ht1(tid).PackYM(w.v(),i*Nxy + j);
		  var pos:Long = i - Nx_;

		  //h0 = w0 - w3
		  val h0_0r_t = w(pos+0*nsite_) - w(pos+18*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+19*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) - w(pos+20*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+21*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) - w(pos+22*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+23*nsite_);

		  //h1 = w1 + w2
		  val h1_0r_t = w(pos+6*nsite_) + w(pos+12*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+13*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) + w(pos+14*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+15*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)+ w(pos+16*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+17*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_uy + i*Nxy + j,ht1(tid));
		  pos = offset_uy_ + i - Nx_;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackYM(v.v(),i*Nxy + j + Nx,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += cks*h1
		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2i;

		  //w4 += -h0
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h0_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h0_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h0_2i;
		}
	      }
	    }
	  }
	}

	def MultZKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uz_ = offset_uz;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  

		var i:Long;

		val tid_x = tid % Nx_;
		val tid_y = tid / Nx_;
		val bid_z = bid % Nz_;
		val bid_t = bid / Nz_;

		// MultZPKernel
		i = tid + bid*Nxy_; if (bid_z < Nz_ - 1) {
		  // ht1(tid).PackZP(w.v(),i*Nxyz + j + Nxy);
	          var pos:Long = i + Nxy_;

		  //h0 = w0 + i*w2
		  val h0_0r_t = w(pos+0*nsite_) - w(pos+13*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+12*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) - w(pos+15*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+14*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) - w(pos+17*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+16*nsite_);

		  //h1 = w1 - i*w3
		  val h1_0r_t = w(pos+6*nsite_) + w(pos+19*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+18*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) + w(pos+21*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+20*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)+ w(pos+23*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+22*nsite_);

		  // ht2(tid).MultU(u.v(),offset_uz + i*Nxyz + j,ht1(tid));
		  pos = offset_uz_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackZP(v.v(),i*Nxyz + j,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += -i*h0
		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h0_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h0_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h0_2r;

		  //w4 += i*h1
		  v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2r;
		}

 		//MultZMKernel
		if (bid_z > 0) {
		  // ht1(tid).PackZM(w.v(),i*Nxyz + j);
		  var pos:Long = i - Nxy_;

		  //h0 = w0 - i*w3
		  val h0_0r_t = w(pos+0*nsite_) + w(pos+13*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+12*nsite_);
		  val h0_1r_t = w(pos+2*nsite_) + w(pos+15*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+14*nsite_);
		  val h0_2r_t = w(pos+4*nsite_) + w(pos+17*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+16*nsite_);

		  //h1 = w1 + i*w2
		  val h1_0r_t = w(pos+6*nsite_) - w(pos+19*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+18*nsite_);
		  val h1_1r_t = w(pos+8*nsite_) - w(pos+21*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+20*nsite_);
		  val h1_2r_t = w(pos+10*nsite_)- w(pos+23*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+22*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_uz + i*Nxyz + j,ht1(tid));
		  pos = offset_uz_ + i - Nxy_;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackZM(v.v(),i*Nxyz + j + Nxy,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		  //w3 += i*h0
		  v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0r;
		  v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1r;
		  v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2r;

		  //w4 += -i*h1
		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h1_0r;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h1_1r;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h1_2r;
		}
	      }
	    }
	  }
	}

	def MultTKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ut_ = offset_ut;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  

		var i:Long;

		val tid_x = tid % Nx_;
		val tid_y = tid / Nx_;
		val bid_z = bid % Nz_;
		val bid_t = bid / Nz_;

		//MultTPKernel
		i = tid + bid*Nxy_; if (i < nsite_-Nxyz_) {
		  var pos:Long = i + Nxyz_;

		  //h0 = 2.0*w2
		  val h0_0r_t = 2.0f*w(pos+12*nsite_);		val h0_0i_t = 2.0f*w(pos+13*nsite_);
		  val h0_1r_t = 2.0f*w(pos+14*nsite_);		val h0_1i_t = 2.0f*w(pos+15*nsite_);
		  val h0_2r_t = 2.0f*w(pos+16*nsite_);		val h0_2i_t = 2.0f*w(pos+17*nsite_);

		  //h1 = 2.0*w3
		  val h1_0r_t = 2.0f*w(pos+18*nsite_);		val h1_0i_t = 2.0f*w(pos+19*nsite_);
		  val h1_1r_t = 2.0f*w(pos+20*nsite_);		val h1_1i_t = 2.0f*w(pos+21*nsite_);
		  val h1_2r_t = 2.0f*w(pos+22*nsite_);		val h1_2i_t = 2.0f*w(pos+23*nsite_);

		  // ht2(tid).MultU(u.v(),offset_ut + i,ht1(tid));
		  pos = offset_ut_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackTP(v.v(),i,cks);
		  pos = i;

		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2i;

		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2i;
		}

		//MultTMKernel
		if (i > Nxyz_) {
		  var pos:Long = i - Nxyz_;

		  //h0 = 2.0*w0
		  val h0_0r_t = 2.0f*w(pos+0*nsite_);		val h0_0i_t = 2.0f*w(pos+1*nsite_);
		  val h0_1r_t = 2.0f*w(pos+2*nsite_);		val h0_1i_t = 2.0f*w(pos+3*nsite_);
		  val h0_2r_t = 2.0f*w(pos+4*nsite_);		val h0_2i_t = 2.0f*w(pos+5*nsite_);

		  //h1 = 2.0*w1
		  val h1_0r_t = 2.0f*w(pos+6*nsite_);		val h1_0i_t = 2.0f*w(pos+7*nsite_);
		  val h1_1r_t = 2.0f*w(pos+8*nsite_);		val h1_1i_t = 2.0f*w(pos+9*nsite_);
		  val h1_2r_t = 2.0f*w(pos+10*nsite_);		val h1_2i_t = 2.0f*w(pos+11*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_ut + i,ht1(tid));
		  pos = offset_ut_ + i - Nxyz_;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackTM(v.v(),i + Nxyz,cks);
		  pos = i;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;
		}
	      }
	    }
	  }
	}

	def MultXP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				for(j in 0..(Nx-2)){
					ht1(tid).PackXP(w.v(),i*Nx + j + 1);
					ht2(tid).MultU(u.v(),offset_ux + i*Nx + j,ht1(tid));
					ht2(tid).UnpackXP(v.v(),i*Nx + j,cks);
				}
			}
		}
	}
// rngX(tid) = new LongRange(tid * Ny*Nz*Nt / nid,(tid + 1) * Ny*Nz*Nt / nid-1);
	// def MultXPKernel(v : CUDAWilsonVectorField, u : CUDASU3MatrixField, w : CUDAWilsonVectorField, cks : Float)
	def MultXPKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  
		// val gid = bid * threads + tid;
		// val gids = blocks * threads;
		val tid_x = tid % Nx_;
		val tid_y = tid / Nx_;
		// for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {		
		val i = tid_y + bid*Ny_; {
		  // for (j in 0..(Nx_-2)) {
		  val j = tid_x; if (j != Nx_-1) {

                    // dht1.PackXP(w,i*Nx + j + 1);
		    // val pos = (i*Nx_ + j + 1)*24;
		    // var pos:Long = (i*Nx_ + j + 1)*24;
		    var pos:Long = i*Nx_ + j + 1;
		    //h0 = w0 + i*w3
		    val h0_0r_t = w(pos+0*nsite_) - w(pos+19*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+18*nsite_);
		    val h0_1r_t = w(pos+2*nsite_) - w(pos+21*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+20*nsite_);
		    val h0_2r_t = w(pos+4*nsite_) - w(pos+23*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+22*nsite_);

		    //h1 = w1 + i*w2
		    val h1_0r_t = w(pos+6*nsite_) - w(pos+13*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+12*nsite_);
		    val h1_1r_t = w(pos+8*nsite_) - w(pos+15*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+14*nsite_);
		    val h1_2r_t = w(pos+10*nsite_)- w(pos+17*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+16*nsite_);

	            // dht2.MultU(v,offset_ux + i*Nx + j,dht1);
		    pos = offset_ux_ + i*Nx_ + j;

		    val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		    u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		    u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		    u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		    u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		    u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		    u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		    u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		    u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		    u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		    u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r= 	u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		    u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i= 	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		    u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		    // dht2.UnpackXP(v,i*Nx + j,cks);		
		    // val pos = iw*24;
		    // pos = (i*Nx_ + j)*24;
		    pos = i*Nx_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += -i*h1
		    v(pos+12*nsite_)= v(pos+12*nsite_)+ cks*h1_0i;		v(pos+13*nsite_)= v(pos+13*nsite_)- cks*h1_0r;
		    v(pos+14*nsite_)= v(pos+14*nsite_)+ cks*h1_1i;		v(pos+15*nsite_)= v(pos+15*nsite_)- cks*h1_1r;
		    v(pos+16*nsite_)= v(pos+16*nsite_)+ cks*h1_2i;		v(pos+17*nsite_)= v(pos+17*nsite_)- cks*h1_2r;

		    //w4 += -i*h0
		    v(pos+18*nsite_)= v(pos+18*nsite_)+ cks*h0_0i;		v(pos+19*nsite_)= v(pos+19*nsite_)- cks*h0_0r;
		    v(pos+20*nsite_)= v(pos+20*nsite_)+ cks*h0_1i;		v(pos+21*nsite_)= v(pos+21*nsite_)- cks*h0_1r;
		    v(pos+22*nsite_)= v(pos+22*nsite_)+ cks*h0_2i;		v(pos+23*nsite_)= v(pos+23*nsite_)- cks*h0_2r;
		  }
		}
	      }
	    }
	  }
	}

	def MultXM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				for(j in 1..(Nx-1)){
					ht1(tid).PackXM(w.v(),i*Nx + j - 1);
					ht2(tid).MultUt(u.v(),offset_ux + i*Nx + j - 1,ht1(tid));
					ht2(tid).UnpackXM(v.v(),i*Nx + j,cks);
				}
			}
		}
	}

	def MultXMKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ux_ = offset_ux;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  
		val tid_x = tid % Nx_;
		val tid_y = tid / Nx_;
		// for (var i:Long = gid; i < Ny_*Nz_*Nt_; i += gids) {		
		val i = tid_y + bid*Ny_; {
		  // for (j in 1..(Nx_-1)) {
// 		  val j = tid_x; if (j != 0) {
		  val j = tid_x; if (j != Nx_-1) {

		    // ht1(tid).PackXM(w.v(),i*Nx + j - 1);
		    // var pos:Long = (i*Nx_ + j - 1)*24;
// 		    var pos:Long = i*Nx_ + j - 1;
		    var pos:Long = i*Nx_ + j;
		    //h0 = w0 - i*w3
		    val h0_0r_t = w(pos+0*nsite_) + w(pos+19*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+18*nsite_);
		    val h0_1r_t = w(pos+2*nsite_) + w(pos+21*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+20*nsite_);
		    val h0_2r_t = w(pos+4*nsite_) + w(pos+23*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+22*nsite_);

		    //h1 = w1 - i*w2
		    val h1_0r_t = w(pos+6*nsite_) + w(pos+13*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+12*nsite_);
		    val h1_1r_t = w(pos+8*nsite_) + w(pos+15*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+14*nsite_);
		    val h1_2r_t = w(pos+10*nsite_)+ w(pos+17*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+16*nsite_);

		    // ht2(tid).MultUt(u.v(),offset_ux + i*Nx + j - 1,ht1(tid));
		    // pos = (offset_ux_ + i*Nx_ + j - 1)*18;
// 		    pos = offset_ux_ + i*Nx_ + j - 1;
		    pos = offset_ux_ + i*Nx_ + j;

		    val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		    u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		    u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t+ 
		    u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t+ 
		    u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		    u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		    u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		    u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		    u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		    u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		    u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		    u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i =	u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		    u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).UnpackXM(v.v(),i*Nx + j,cks);
		    // pos = (i*Nx_ + j)*24;
// 		    pos = i*Nx_ + j;  
		    pos = i*Nx_ + j + 1;  

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += i*h1
		    v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0r;
		    v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1r;
		    v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2r;

		    //w4 += i*h0
		    v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0r;
		    v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1r;
		    v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2r;
		  }
		}
	      }
	    }
	  }
	}

	def MultYP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngYOut(tid)){
				for(j in rngYIn(tid)){
					ht1(tid).PackYP(w.v(),i*Nxy + j + Nx);
					ht2(tid).MultU(u.v(),offset_uy + i*Nxy + j,ht1(tid));
					ht2(tid).UnpackYP(v.v(),i*Nxy + j,cks);
				}
			}
		}
	}

  // rngYOut(tid) = new LongRange(io * Nt*Nz / no,(io + 1) * Nt*Nz / no-1);
  // rngYIn(tid)  = new LongRange(ii * (Nxy - Nx) / ni,(ii + 1) * (Nxy - Nx) / ni-1);
	def MultYPKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uy_ = offset_uy;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  
		// for (var i:Long = gid; i < Nt_*Nz_; i += gids) {
		val i = bid; {
		  // for (j in 0..(Nxy_-Nx_-1)) {
		  val j = tid; if (j < Nxy_-Nx_) {
		    // ht1(tid).PackYP(w.v(),i*Nxy + j + Nx);
		    // var pos:Long = (i*Nxy_ + j + Nx_)*24;
		    var pos:Long = i*Nxy_ + j + Nx_;

		    //h0 = w0 + w3
		    val h0_0r_t = w(pos+0*nsite_) + w(pos+18*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+19*nsite_);
		    val h0_1r_t = w(pos+2*nsite_) + w(pos+20*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+21*nsite_);
		    val h0_2r_t = w(pos+4*nsite_) + w(pos+22*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+23*nsite_);

		    //h1 = w1 - w2
		    val h1_0r_t = w(pos+6*nsite_) - w(pos+12*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+13*nsite_);
		    val h1_1r_t = w(pos+8*nsite_) - w(pos+14*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+15*nsite_);
		    val h1_2r_t = w(pos+10*nsite_)- w(pos+16*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+17*nsite_);

		    // ht2(tid).MultU(u.v(),offset_uy + i*Nxy + j,ht1(tid));
		    // pos = (offset_uy_ + i*Nxy_ + j)*18;
		    pos = offset_uy_ + i*Nxy_ + j;

		    val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		    u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		    u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		    u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		    u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		    u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		    u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		    u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		    u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		    u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		    u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		    u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		    u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).UnpackYP(v.v(),i*Nxy + j,cks);
		    // pos = (i*Nxy_ + j)*24;
		    pos = i*Nxy_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += -h1
		    v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h1_0i;
		    v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h1_1i;
		    v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h1_2i;

		    //w4 += cks*h0
		    v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h0_0i;
		    v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h0_1i;
		    v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h0_2i;
		  }
		}
	      }
	    }
	  }
	}		    

	def MultYM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngYOut(tid)){
				for(j in rngYIn(tid)){
					ht1(tid).PackYM(w.v(),i*Nxy + j);
					ht2(tid).MultUt(u.v(),offset_uy + i*Nxy + j,ht1(tid));
					ht2(tid).UnpackYM(v.v(),i*Nxy + j + Nx,cks);
				}
			}
		}
	}

  // rngYOut(tid) = new LongRange(io * Nt*Nz / no,(io + 1) * Nt*Nz / no-1);
  // rngYIn(tid)  = new LongRange(ii * (Nxy - Nx) / ni,(ii + 1) * (Nxy - Nx) / ni-1);
	def MultYMKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uy_ = offset_uy;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  
		// for (var i:Long = gid; i < Nt_*Nz_; i += gids) {		
		val i = bid; {
		//   for (j in 0..(Nxy_-Nx_-1)) {
		  // val j = tid_y; if (j != 0) {
		  val j = tid; if (j < Nxy_-Nx_) {

		    // ht1(tid).PackYM(w.v(),i*Nxy + j);
		    // var pos:Long = (i*Nxy_ + j)*24;
		    var pos:Long = i*Nxy_ + j;

		    //h0 = w0 - w3
		    val h0_0r_t = w(pos+0*nsite_) - w(pos+18*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+19*nsite_);
		    val h0_1r_t = w(pos+2*nsite_) - w(pos+20*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+21*nsite_);
		    val h0_2r_t = w(pos+4*nsite_) - w(pos+22*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+23*nsite_);

		    //h1 = w1 + w2
		    val h1_0r_t = w(pos+6*nsite_) + w(pos+12*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+13*nsite_);
		    val h1_1r_t = w(pos+8*nsite_) + w(pos+14*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+15*nsite_);
		    val h1_2r_t = w(pos+10*nsite_)+ w(pos+16*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+17*nsite_);

		    // ht2(tid).MultUt(u.v(),offset_uy + i*Nxy + j,ht1(tid));
		    // pos = (offset_uy_ + i*Nxy_ + j)*18;
		    pos = offset_uy_ + i*Nxy_ + j;

		    val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		    u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		    u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		    u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		    u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		    u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		    u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		    u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		    u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		    u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		    u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		    u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		    u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).UnpackYM(v.v(),i*Nxy + j + Nx,cks);
		    // pos = (i*Nxy_ + j + Nx_)*24;
		    pos = i*Nxy_ + j + Nx_;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += cks*h1
		    v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h1_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h1_0i;
		    v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h1_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h1_1i;
		    v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h1_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h1_2i;

		    //w4 += -h0
		    v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h0_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h0_0i;
		    v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h0_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h0_1i;
		    v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h0_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h0_2i;
		  }
		}
	      }
	    }
	  }
	}

	def MultZP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngZOut(tid)){
				for(j in rngZIn(tid)){
					ht1(tid).PackZP(w.v(),i*Nxyz + j + Nxy);
					ht2(tid).MultU(u.v(),offset_uz + i*Nxyz + j,ht1(tid));
					ht2(tid).UnpackZP(v.v(),i*Nxyz + j,cks);
				}
			}
		}
	}

  // rngZOut(tid) = new LongRange(io * Nt / no,(io + 1) * Nt / no-1);
  // rngZIn(tid)  = new LongRange(ii * (Nxyz-Nxy) / ni,(ii + 1) * (Nxyz-Nxy) / ni-1);
	def MultZPKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uz_ = offset_uz;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  
		val bid_z = bid % Nz_;
		val bid_t = bid / Nz_;
		// for (var i:Long = gid; i < Nt_; i += gids) {
		val i = bid_t; {
		  // for (j in 0..(Nxyz_-Nxy_-1)) {
		  val j = tid + bid_z*Nxy_; if (j < Nxyz_-Nxy_) {

		    // ht1(tid).PackZP(w.v(),i*Nxyz + j + Nxy);
		    // var pos:Long = (i*Nxyz_ + j + Nxy_)*24;
		    var pos:Long = i*Nxyz_ + j + Nxy_;

		    //h0 = w0 + i*w2
		    val h0_0r_t = w(pos+0*nsite_) - w(pos+13*nsite_);		val h0_0i_t = w(pos+1*nsite_) + w(pos+12*nsite_);
		    val h0_1r_t = w(pos+2*nsite_) - w(pos+15*nsite_);		val h0_1i_t = w(pos+3*nsite_) + w(pos+14*nsite_);
		    val h0_2r_t = w(pos+4*nsite_) - w(pos+17*nsite_);		val h0_2i_t = w(pos+5*nsite_) + w(pos+16*nsite_);

		    //h1 = w1 - i*w3
		    val h1_0r_t = w(pos+6*nsite_) + w(pos+19*nsite_);		val h1_0i_t = w(pos+7*nsite_) - w(pos+18*nsite_);
		    val h1_1r_t = w(pos+8*nsite_) + w(pos+21*nsite_);		val h1_1i_t = w(pos+9*nsite_) - w(pos+20*nsite_);
		    val h1_2r_t = w(pos+10*nsite_)+ w(pos+23*nsite_);		val h1_2i_t = w(pos+11*nsite_)- w(pos+22*nsite_);

		    // ht2(tid).MultU(u.v(),offset_uz + i*Nxyz + j,ht1(tid));
		    // pos = (offset_uz_ + i*Nxyz_ + j)*18;
		    pos = offset_uz_ + i*Nxyz_ + j;

		    val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		    u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		    u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		    u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		    u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		    u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		    u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		    u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		    u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		    u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		    u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		    u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		    u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).UnpackZP(v.v(),i*Nxyz + j,cks);
		    // pos = (i*Nxyz_ + j)*24;
		    pos = i*Nxyz_ + j;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += -i*h0
		    v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) - cks*h0_0r;
		    v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) - cks*h0_1r;
		    v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) - cks*h0_2r;

		    //w4 += i*h1
		    v(pos+18*nsite_) = v(pos+18*nsite_) - cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0r;
		    v(pos+20*nsite_) = v(pos+20*nsite_) - cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1r;
		    v(pos+22*nsite_) = v(pos+22*nsite_) - cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2r;
		  }
		}
	      }
	    }
	  }
	}

	def MultZM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngZOut(tid)){
				for(j in rngZIn(tid)){
					ht1(tid).PackZM(w.v(),i*Nxyz + j);
					ht2(tid).MultUt(u.v(),offset_uz + i*Nxyz + j,ht1(tid));
					ht2(tid).UnpackZM(v.v(),i*Nxyz + j + Nxy,cks);
				}
			}
		}
	}

	def MultZMKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_uz_ = offset_uz;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  
		val bid_z = bid % Nz_;
		val bid_t = bid / Nz_;
		// for (var i:Long = gid; i < Nt_; i += gids) {
		val i = bid_t; {
		  // for (j in 0..(Nxyz_-Nxy_-1)) {
		  val j = tid + bid_z*Nxy_; if (j < Nxyz_-Nxy_) {

		    // ht1(tid).PackZM(w.v(),i*Nxyz + j);
		    // var pos:Long = (i*Nxyz_ + j)*24;
		    var pos:Long = i*Nxyz_ + j;

		    //h0 = w0 - i*w3
		    val h0_0r_t = w(pos+0*nsite_) + w(pos+13*nsite_);		val h0_0i_t = w(pos+1*nsite_) - w(pos+12*nsite_);
		    val h0_1r_t = w(pos+2*nsite_) + w(pos+15*nsite_);		val h0_1i_t = w(pos+3*nsite_) - w(pos+14*nsite_);
		    val h0_2r_t = w(pos+4*nsite_) + w(pos+17*nsite_);		val h0_2i_t = w(pos+5*nsite_) - w(pos+16*nsite_);

		    //h1 = w1 + i*w2
		    val h1_0r_t = w(pos+6*nsite_) - w(pos+19*nsite_);		val h1_0i_t = w(pos+7*nsite_) + w(pos+18*nsite_);
		    val h1_1r_t = w(pos+8*nsite_) - w(pos+21*nsite_);		val h1_1i_t = w(pos+9*nsite_) + w(pos+20*nsite_);
		    val h1_2r_t = w(pos+10*nsite_)- w(pos+23*nsite_);		val h1_2i_t = w(pos+11*nsite_)+ w(pos+22*nsite_);

		    // ht2(tid).MultUt(u.v(),offset_uz + i*Nxyz + j,ht1(tid));
		    // pos = (offset_uz_ + i*Nxyz_ + j)*18;
		    pos = offset_uz_ + i*Nxyz_ + j;

		    val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		    u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		    u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		    val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		    u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		    u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		    val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		    u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		    u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		    val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		    u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		    u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		    val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		    u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		    u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		    val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		    u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		    u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		    val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		    u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		    u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		    val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		    u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		    u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		    val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		    u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		    u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		    val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		    u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		    u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		    val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		    u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		    u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		    val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		    u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		    u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		    // ht2(tid).UnpackZM(v.v(),i*Nxyz + j + Nxy,cks);
		    // pos = (i*Nxyz_ + j + Nxy_)*24;
		    pos = i*Nxyz_ + j + Nxy_;

		    v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		    v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		    v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		    v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		    v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		    v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;

		    //w3 += i*h0
		    v(pos+12*nsite_) = v(pos+12*nsite_) - cks*h0_0i;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0r;
		    v(pos+14*nsite_) = v(pos+14*nsite_) - cks*h0_1i;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1r;
		    v(pos+16*nsite_) = v(pos+16*nsite_) - cks*h0_2i;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2r;

		    //w4 += -i*h1
		    v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0i;		v(pos+19*nsite_) = v(pos+19*nsite_) - cks*h1_0r;
		    v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1i;		v(pos+21*nsite_) = v(pos+21*nsite_) - cks*h1_1r;
		    v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2i;		v(pos+23*nsite_) = v(pos+23*nsite_) - cks*h1_2r;
		  }
		}
	      }
	    }
	  }
	}

	def MultTP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngT(tid)){
				ht1(tid).PackTP(w.v(),i + Nxyz);
				ht2(tid).MultU(u.v(),offset_ut + i,ht1(tid));
				ht2(tid).UnpackTP(v.v(),i,cks);
			}
		}
	}

	def MultTPKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ut_ = offset_ut;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  
		// for (var i:Long = gid; i < nsite_-Nxyz_; i += gids) {
		val i = tid + bid*Nxy_; if (i < nsite_-Nxyz_) {

		  // ht1(tid).PackTP(w.v(),i + Nxyz);
		  // var pos:Long = (i + Nxyz_)*24;
		  var pos:Long = i + Nxyz_;

		  //h0 = 2.0*w2
		  val h0_0r_t = 2.0f*w(pos+12*nsite_);		val h0_0i_t = 2.0f*w(pos+13*nsite_);
		  val h0_1r_t = 2.0f*w(pos+14*nsite_);		val h0_1i_t = 2.0f*w(pos+15*nsite_);
		  val h0_2r_t = 2.0f*w(pos+16*nsite_);		val h0_2i_t = 2.0f*w(pos+17*nsite_);

		  //h1 = 2.0*w3
		  val h1_0r_t = 2.0f*w(pos+18*nsite_);		val h1_0i_t = 2.0f*w(pos+19*nsite_);
		  val h1_1r_t = 2.0f*w(pos+20*nsite_);		val h1_1i_t = 2.0f*w(pos+21*nsite_);
		  val h1_2r_t = 2.0f*w(pos+22*nsite_);		val h1_2i_t = 2.0f*w(pos+23*nsite_);

		  // ht2(tid).MultU(u.v(),offset_ut + i,ht1(tid));
		  // pos = (offset_ut_ + i)*18;
		  pos = offset_ut_ + i;

		  val h0_0r = u(pos+0*Ndst_)*h0_0r_t - u(pos+1*Ndst_)*h0_0i_t + 
		  u(pos+2*Ndst_)*h0_1r_t - u(pos+3*Ndst_)*h0_1i_t + 
		  u(pos+4*Ndst_)*h0_2r_t - u(pos+5*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_)*h0_0i_t + u(pos+1*Ndst_)*h0_0r_t + 
		  u(pos+2*Ndst_)*h0_1i_t + u(pos+3*Ndst_)*h0_1r_t + 
		  u(pos+4*Ndst_)*h0_2i_t + u(pos+5*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_)*h1_0r_t - u(pos+1*Ndst_)*h1_0i_t + 
		  u(pos+2*Ndst_)*h1_1r_t - u(pos+3*Ndst_)*h1_1i_t + 
		  u(pos+4*Ndst_)*h1_2r_t - u(pos+5*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_)*h1_0i_t + u(pos+1*Ndst_)*h1_0r_t + 
		  u(pos+2*Ndst_)*h1_1i_t + u(pos+3*Ndst_)*h1_1r_t + 
		  u(pos+4*Ndst_)*h1_2i_t + u(pos+5*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+6*Ndst_) *h0_0r_t - u(pos+7*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t - u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+10*Ndst_)*h0_2r_t - u(pos+11*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+6*Ndst_) *h0_0i_t + u(pos+7*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t + u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+10*Ndst_)*h0_2i_t + u(pos+11*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+6*Ndst_) *h1_0r_t - u(pos+7*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t - u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+10*Ndst_)*h1_2r_t - u(pos+11*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+6*Ndst_) *h1_0i_t + u(pos+7*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t + u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+10*Ndst_)*h1_2i_t + u(pos+11*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+12*Ndst_)*h0_0r_t - u(pos+13*Ndst_)*h0_0i_t + 
		  u(pos+14*Ndst_)*h0_1r_t - u(pos+15*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t - u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+12*Ndst_)*h0_0i_t + u(pos+13*Ndst_)*h0_0r_t + 
		  u(pos+14*Ndst_)*h0_1i_t + u(pos+15*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t + u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+12*Ndst_)*h1_0r_t - u(pos+13*Ndst_)*h1_0i_t + 
		  u(pos+14*Ndst_)*h1_1r_t - u(pos+15*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t - u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i =	u(pos+12*Ndst_)*h1_0i_t + u(pos+13*Ndst_)*h1_0r_t + 
		  u(pos+14*Ndst_)*h1_1i_t + u(pos+15*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t + u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackTP(v.v(),i,cks);
		  // pos = i*24;
		  pos = i;

		  v(pos+12*nsite_) = v(pos+12*nsite_) + cks*h0_0r;		v(pos+13*nsite_) = v(pos+13*nsite_) + cks*h0_0i;
		  v(pos+14*nsite_) = v(pos+14*nsite_) + cks*h0_1r;		v(pos+15*nsite_) = v(pos+15*nsite_) + cks*h0_1i;
		  v(pos+16*nsite_) = v(pos+16*nsite_) + cks*h0_2r;		v(pos+17*nsite_) = v(pos+17*nsite_) + cks*h0_2i;

		  v(pos+18*nsite_) = v(pos+18*nsite_) + cks*h1_0r;		v(pos+19*nsite_) = v(pos+19*nsite_) + cks*h1_0i;
		  v(pos+20*nsite_) = v(pos+20*nsite_) + cks*h1_1r;		v(pos+21*nsite_) = v(pos+21*nsite_) + cks*h1_1i;
		  v(pos+22*nsite_) = v(pos+22*nsite_) + cks*h1_2r;		v(pos+23*nsite_) = v(pos+23*nsite_) + cks*h1_2i;
		}
	      }
	    }
	  }
	}

	def MultTM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Float)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngT(tid)){
				ht1(tid).PackTM(w.v(),i);
				ht2(tid).MultUt(u.v(),offset_ut + i,ht1(tid));
				ht2(tid).UnpackTM(v.v(),i + Nxyz,cks);
			}
		}
	}

	def MultTMKernel(v : GlobalRail[Float]{home==gpu}, u : GlobalRail[Float]{home==gpu}, 
			 w : GlobalRail[Float]{home==gpu}, cks : Float)
	{
	  val Nx_ = Nx;
	  val Ny_ = Ny;
	  val Nz_ = Nz;
	  val Nt_ = Nt;
	  val Nxy_ = Nxy;
	  val Nxyz_ = Nxyz;
	  val nsite_ = nsite;
	  val Ndst_ = Ndst;

	  val offset_ut_ = offset_ut;

	  val threads = Int.operator_as(Nxy_);
	  val blocks = Int.operator_as(nsite_ / threads) + ((nsite_ % threads > 0) ? 1n : 0n);

	  finish async at (gpu) @CUDA @CUDADirectParams{
	    finish for (bid in 0n..(blocks-1n)) async {
              clocked finish for (tid in 0n..(threads-1n)) clocked async {	  
		// for (var i:Long = gid; i < nsite_-Nxyz_; i += gids) {
		val i = tid + bid*Nxy_; if (i < nsite_-Nxyz_) {

		  // ht1(tid).PackTM(w.v(),i);
		  // var pos:Long = i*24;
		  var pos:Long = i;

		  //h0 = 2.0*w0
		  val h0_0r_t = 2.0f*w(pos+0*nsite_);		val h0_0i_t = 2.0f*w(pos+1*nsite_);
		  val h0_1r_t = 2.0f*w(pos+2*nsite_);		val h0_1i_t = 2.0f*w(pos+3*nsite_);
		  val h0_2r_t = 2.0f*w(pos+4*nsite_);		val h0_2i_t = 2.0f*w(pos+5*nsite_);

		  //h1 = 2.0*w1
		  val h1_0r_t = 2.0f*w(pos+6*nsite_);		val h1_0i_t = 2.0f*w(pos+7*nsite_);
		  val h1_1r_t = 2.0f*w(pos+8*nsite_);		val h1_1i_t = 2.0f*w(pos+9*nsite_);
		  val h1_2r_t = 2.0f*w(pos+10*nsite_);		val h1_2i_t = 2.0f*w(pos+11*nsite_);

		  // ht2(tid).MultUt(u.v(),offset_ut + i,ht1(tid));
		  // pos = (offset_ut_ + i)*18;
		  pos = offset_ut_ + i;

		  val h0_0r = u(pos+0*Ndst_) *h0_0r_t + u(pos+1*Ndst_) *h0_0i_t + 
		  u(pos+6*Ndst_) *h0_1r_t + u(pos+7*Ndst_) *h0_1i_t + 
		  u(pos+12*Ndst_)*h0_2r_t + u(pos+13*Ndst_)*h0_2i_t;
		  val h0_0i = u(pos+0*Ndst_) *h0_0i_t - u(pos+1*Ndst_) *h0_0r_t + 
		  u(pos+6*Ndst_) *h0_1i_t - u(pos+7*Ndst_) *h0_1r_t + 
		  u(pos+12*Ndst_)*h0_2i_t - u(pos+13*Ndst_)*h0_2r_t;

		  val h1_0r = u(pos+0*Ndst_) *h1_0r_t + u(pos+1*Ndst_) *h1_0i_t + 
		  u(pos+6*Ndst_) *h1_1r_t + u(pos+7*Ndst_) *h1_1i_t + 
		  u(pos+12*Ndst_)*h1_2r_t + u(pos+13*Ndst_)*h1_2i_t;
		  val h1_0i = u(pos+0*Ndst_) *h1_0i_t - u(pos+1*Ndst_) *h1_0r_t + 
		  u(pos+6*Ndst_) *h1_1i_t - u(pos+7*Ndst_) *h1_1r_t + 
		  u(pos+12*Ndst_)*h1_2i_t - u(pos+13*Ndst_)*h1_2r_t;

		  val h0_1r = u(pos+2*Ndst_) *h0_0r_t + u(pos+3*Ndst_) *h0_0i_t + 
		  u(pos+8*Ndst_) *h0_1r_t + u(pos+9*Ndst_) *h0_1i_t + 
		  u(pos+14*Ndst_)*h0_2r_t + u(pos+15*Ndst_)*h0_2i_t;
		  val h0_1i = u(pos+2*Ndst_) *h0_0i_t - u(pos+3*Ndst_) *h0_0r_t + 
		  u(pos+8*Ndst_) *h0_1i_t - u(pos+9*Ndst_) *h0_1r_t + 
		  u(pos+14*Ndst_)*h0_2i_t - u(pos+15*Ndst_)*h0_2r_t;

		  val h1_1r = u(pos+2*Ndst_) *h1_0r_t + u(pos+3*Ndst_) *h1_0i_t + 
		  u(pos+8*Ndst_) *h1_1r_t + u(pos+9*Ndst_) *h1_1i_t + 
		  u(pos+14*Ndst_)*h1_2r_t + u(pos+15*Ndst_)*h1_2i_t;
		  val h1_1i = u(pos+2*Ndst_) *h1_0i_t - u(pos+3*Ndst_) *h1_0r_t + 
		  u(pos+8*Ndst_) *h1_1i_t - u(pos+9*Ndst_) *h1_1r_t + 
		  u(pos+14*Ndst_)*h1_2i_t - u(pos+15*Ndst_)*h1_2r_t;

		  val h0_2r = u(pos+4*Ndst_) *h0_0r_t + u(pos+5*Ndst_) *h0_0i_t + 
		  u(pos+10*Ndst_)*h0_1r_t + u(pos+11*Ndst_)*h0_1i_t + 
		  u(pos+16*Ndst_)*h0_2r_t + u(pos+17*Ndst_)*h0_2i_t;
		  val h0_2i = u(pos+4*Ndst_) *h0_0i_t - u(pos+5*Ndst_) *h0_0r_t + 
		  u(pos+10*Ndst_)*h0_1i_t - u(pos+11*Ndst_)*h0_1r_t + 
		  u(pos+16*Ndst_)*h0_2i_t - u(pos+17*Ndst_)*h0_2r_t;

		  val h1_2r = u(pos+4*Ndst_) *h1_0r_t + u(pos+5*Ndst_) *h1_0i_t + 
		  u(pos+10*Ndst_)*h1_1r_t + u(pos+11*Ndst_)*h1_1i_t + 
		  u(pos+16*Ndst_)*h1_2r_t + u(pos+17*Ndst_)*h1_2i_t;
		  val h1_2i = u(pos+4*Ndst_) *h1_0i_t - u(pos+5*Ndst_) *h1_0r_t + 
		  u(pos+10*Ndst_)*h1_1i_t - u(pos+11*Ndst_)*h1_1r_t + 
		  u(pos+16*Ndst_)*h1_2i_t - u(pos+17*Ndst_)*h1_2r_t;

		  // ht2(tid).UnpackTM(v.v(),i + Nxyz,cks);
		  // pos = (i + Nxyz_)*24;
		  pos = i + Nxyz_;

		  v(pos+0*nsite_) = v(pos+0*nsite_) + cks*h0_0r;		v(pos+1*nsite_) = v(pos+1*nsite_) + cks*h0_0i;
		  v(pos+2*nsite_) = v(pos+2*nsite_) + cks*h0_1r;		v(pos+3*nsite_) = v(pos+3*nsite_) + cks*h0_1i;
		  v(pos+4*nsite_) = v(pos+4*nsite_) + cks*h0_2r;		v(pos+5*nsite_) = v(pos+5*nsite_) + cks*h0_2i;

		  v(pos+6*nsite_) = v(pos+6*nsite_) + cks*h1_0r;		v(pos+7*nsite_) = v(pos+7*nsite_) + cks*h1_0i;
		  v(pos+8*nsite_) = v(pos+8*nsite_) + cks*h1_1r;		v(pos+9*nsite_) = v(pos+9*nsite_) + cks*h1_1i;
		  v(pos+10*nsite_)= v(pos+10*nsite_)+ cks*h1_2r;		v(pos+11*nsite_)= v(pos+11*nsite_)+ cks*h1_2i;
		}
	      }
	    }
	  }
	}

	def Dopr_Get(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Float, bx : CUDALatticeComm)
	{
		Team.WORLD.barrier();

		//finish is placed for asyncronous copy
//		finish {
			//make boundary data
			MakeTPBnd(bx,w);
			bx.Send(bx.TP);

			MakeTMBnd(bx,w,u);
			bx.Send(bx.TM);

			MakeXPBnd(bx,w);
			bx.Send(bx.XP);

			MakeXMBnd(bx,w,u);
			bx.Send(bx.XM);

			MakeYPBnd(bx,w);
			bx.Send(bx.YP);

			MakeYMBnd(bx,w,u);
			bx.Send(bx.YM);

			MakeZPBnd(bx,w);
			bx.Send(bx.ZP);

			MakeZMBnd(bx,w,u);
			bx.Send(bx.ZM);

			v.Copy(w);

			//local calculations
			MultTP(v,u,w,-cks);
			MultTM(v,u,w,-cks);

			MultXP(v,u,w,-cks);
			MultXM(v,u,w,-cks);

			MultYP(v,u,w,-cks);
			MultYM(v,u,w,-cks);

			MultZP(v,u,w,-cks);
			MultZM(v,u,w,-cks);

//		}

		//global barrier is needed to make sure boundary exchange finished (I dont know why this is needed????)
		Team.WORLD.barrier();

		//set boundary part
		bx.WaitRecv(bx.TP);
		SetTPBnd(bx,v,u,-cks);

		bx.WaitRecv(bx.TM);
		SetTMBnd(bx,v,-cks);

		bx.WaitRecv(bx.XP);
		SetXPBnd(bx,v,u,-cks);

		bx.WaitRecv(bx.XM);
		SetXMBnd(bx,v,-cks);

		bx.WaitRecv(bx.YP);
		SetYPBnd(bx,v,u,-cks);

		bx.WaitRecv(bx.YM);
		SetYMBnd(bx,v,-cks);

		bx.WaitRecv(bx.ZP);
		SetZPBnd(bx,v,u,-cks);

		bx.WaitRecv(bx.ZM);
		SetZMBnd(bx,v,-cks);

		Team.WORLD.barrier();
	}

	def Dopr_Get_overlap(dv : CUDAWilsonVectorField, du : CUDASU3MatrixField, 
			     dw : CUDAWilsonVectorField, cks : Float, bx : CUDALatticeComm)
	{
		// Team.WORLD.barrier();
		//finish is placed for asyncronous copy
		finish {
		  //make boundary data
		  MakeTPBndKernel(bx.SendDeviceBuffer(bx.TP).v()(), dw.v()());
		  bx.SendDevice(bx.TP);

		  MakeTMBndKernel(bx.SendDeviceBuffer(bx.TM).v()(), dw.v()(), du.v()());
		  bx.SendDevice(bx.TM);

		  MakeXPBndKernel(bx.SendDeviceBuffer(bx.XP).v()(), dw.v()());
		  bx.SendDevice(bx.XP);

		  MakeXMBndKernel(bx.SendDeviceBuffer(bx.XM).v()(), dw.v()(), du.v()());
		  bx.SendDevice(bx.XM);

		  MakeYPBndKernel(bx.SendDeviceBuffer(bx.YP).v()(), dw.v()());
		  bx.SendDevice(bx.YP);

		  MakeYMBndKernel(bx.SendDeviceBuffer(bx.YM).v()(), dw.v()(), du.v()());
		  bx.SendDevice(bx.YM);

		  MakeZPBndKernel(bx.SendDeviceBuffer(bx.ZP).v()(), dw.v()());
		  bx.SendDevice(bx.ZP);

		  MakeZMBndKernel(bx.SendDeviceBuffer(bx.ZM).v()(), dw.v()(), du.v()());
		  bx.SendDevice(bx.ZM);

		  val startTime = System.nanoTime();

		  // finish {
		  //   Rail.asyncCopy(w.v(), 0, dw.v()(), 0, w.size);
		  // }

		  dv.Copy(dv.v()(), dw.v()());

		  //local calculations
		  MultTPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
		  MultTMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

		  MultXPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
		  MultXMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

		  MultYPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
		  MultYMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

		  MultZPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
		  MultZMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

		  // finish {
		  //   Rail.asyncCopy(dv.v()(), 0, v.v(), 0, w.size);
		  // }

		  val finishTime = System.nanoTime() - startTime; 
		  // if (here.id() == 0) Console.OUT.println("bulk :" + finishTime / 1000 + " usec.");

		}

		//global barrier is needed to make sure boundary exchange finished (I dont know why this is needed????)
		Team.WORLD.barrier();

		val startTime = System.nanoTime();

//debug
		// bx.RecvToDevice();


		bx.WaitDeviceRecv(bx.TP);
		SetTPBndKernel(bx.RecvDeviceBuffer(bx.TP).v()(), dv.v()(), du.v()(), -cks);
		bx.WaitDeviceRecv(bx.TM);
		SetTMBndKernel(bx.RecvDeviceBuffer(bx.TM).v()(), dv.v()(), -cks);
		bx.WaitDeviceRecv(bx.XP);
		SetXPBndKernel(bx.RecvDeviceBuffer(bx.XP).v()(), dv.v()(), du.v()(), -cks);
		bx.WaitDeviceRecv(bx.XM);
		SetXMBndKernel(bx.RecvDeviceBuffer(bx.XM).v()(), dv.v()(), -cks);
		bx.WaitDeviceRecv(bx.YP);
		SetYPBndKernel(bx.RecvDeviceBuffer(bx.YP).v()(), dv.v()(), du.v()(), -cks);
		bx.WaitDeviceRecv(bx.YM);
		SetYMBndKernel(bx.RecvDeviceBuffer(bx.YM).v()(), dv.v()(), -cks);
		bx.WaitDeviceRecv(bx.ZP);
		SetZPBndKernel(bx.RecvDeviceBuffer(bx.ZP).v()(), dv.v()(), du.v()(), -cks);
		bx.WaitDeviceRecv(bx.ZM);
		SetZMBndKernel(bx.RecvDeviceBuffer(bx.ZM).v()(), dv.v()(), -cks);

		// D2H
		// finish {
		//   Rail.asyncCopy(dv.v()(), 0, v.v(), 0, w.size);
		// }

		//set boundary part
		// bx.WaitRecv(bx.TP);
		// SetTPBnd(bx,v,u,-cks);

		// bx.WaitRecv(bx.TM);
		// SetTMBnd(bx,v,-cks);

		// bx.WaitRecv(bx.XP);
	        // SetXPBnd(bx,v,u,-cks);
	        // ht1(tid).Load(bx.RecvBuffer(bx.XP).v(),i);

		// bx.WaitRecv(bx.XM);
		// SetXMBnd(bx,v,-cks);

		// bx.WaitRecv(bx.YP);
		// SetYPBnd(bx,v,u,-cks);

		// bx.WaitRecv(bx.YM);
		// SetYMBnd(bx,v,-cks);

		// bx.WaitRecv(bx.ZP);
		// SetZPBnd(bx,v,u,-cks);

		// bx.WaitRecv(bx.ZM);
		// SetZMBnd(bx,v,-cks);

		// Team.WORLD.barrier();

		val finishTime = System.nanoTime() - startTime;
		// if (here.id() == 0) Console.OUT.println("set :" + finishTime / 1000 + " usec.");
	}

	// def DoprH(dv : CUDAWilsonVectorField, du : CUDASU3MatrixField,
	// 	  dw : CUDAWilsonVectorField, cks : Float, bx : CUDALatticeComm)
	def Dopr_Put_overlap_uc_direct(dv : CUDAWilsonVectorField, du : CUDASU3MatrixField, 
			     dw : CUDAWilsonVectorField, cks : Float, bx : CUDALatticeComm)
	{
		// Team.WORLD.barrier();
	  //finish is placed for asyncronous copy
	  finish {
	    //make boundary data
	    if(bx.decomp(bx.TP) > 1){
	      async {
		MakeTPBndKernel(bx.SendDeviceBuffer(bx.TP).v()(), dw.v()());
		bx.PutDevice(bx.TP);

		MakeTMBndKernel(bx.SendDeviceBuffer(bx.TM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.TM);
	      }
	    } else {
	      MakeTPBndKernel(bx.SendDeviceBuffer(bx.TP).v()(), dw.v()());
	      MakeTMBndKernel(bx.SendDeviceBuffer(bx.TM).v()(), dw.v()(), du.v()());
	    }
	    if(bx.decomp(bx.XP) > 1){
	      async { 
		MakeXPBndKernel(bx.SendDeviceBuffer(bx.XP).v()(), dw.v()());
		bx.PutDevice(bx.XP);

		MakeXMBndKernel(bx.SendDeviceBuffer(bx.XM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.XM);
	      }
	    } else {
	      MakeXPBndKernel(bx.SendDeviceBuffer(bx.XP).v()(), dw.v()());
	      MakeXMBndKernel(bx.SendDeviceBuffer(bx.XM).v()(), dw.v()(), du.v()());
	    }
	    if(bx.decomp(bx.YP) > 1){
	      async {
		MakeYPBndKernel(bx.SendDeviceBuffer(bx.YP).v()(), dw.v()());
		bx.PutDevice(bx.YP);

		MakeYMBndKernel(bx.SendDeviceBuffer(bx.YM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.YM);
	      }
	    } else {
	      MakeYPBndKernel(bx.SendDeviceBuffer(bx.YP).v()(), dw.v()());
	      MakeYMBndKernel(bx.SendDeviceBuffer(bx.YM).v()(), dw.v()(), du.v()());
	    }
	    if(bx.decomp(bx.ZP) > 1){
	      async {
		MakeZPBndKernel(bx.SendDeviceBuffer(bx.ZP).v()(), dw.v()());
		bx.PutDevice(bx.ZP);

		MakeZMBndKernel(bx.SendDeviceBuffer(bx.ZM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.ZM);
	      }
	    } else {
	      MakeZPBndKernel(bx.SendDeviceBuffer(bx.ZP).v()(), dw.v()());
	      MakeZMBndKernel(bx.SendDeviceBuffer(bx.ZM).v()(), dw.v()(), du.v()());
	    }

	    //local calculations
// 	    MultKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultTPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultTMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	    MultXPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultXMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	    MultYPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultYMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	    MultZPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultZMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	  }

	  //global barrier is needed to make sure boundary exchange finished (I dont know why this is needed????)
	  Team.WORLD.barrier();

	  //debug
	  bx.RecvToDevice();

	  // bx.WaitDeviceRecv(bx.TP);
	  // bx.WaitDeviceRecv(bx.TM);
	  // SetTBndKernel(bx.RecvDeviceBuffer(bx.TP).v()(), bx.RecvDeviceBuffer(bx.TM).v()(), dv.v()(), du.v()(), -cks);

	  // bx.WaitDeviceRecv(bx.XP);
	  // bx.WaitDeviceRecv(bx.XM);
	  // SetXBndKernel(bx.RecvDeviceBuffer(bx.XP).v()(), bx.RecvDeviceBuffer(bx.XM).v()(), dv.v()(), du.v()(), -cks);

	  // bx.WaitDeviceRecv(bx.YP);
	  // bx.WaitDeviceRecv(bx.YM);
	  // SetYBndKernel(bx.RecvDeviceBuffer(bx.YP).v()(), bx.RecvDeviceBuffer(bx.YM).v()(), dv.v()(), du.v()(), -cks);

	  // bx.WaitDeviceRecv(bx.ZP);
	  // bx.WaitDeviceRecv(bx.ZM);
	  SetTBndKernel(bx.RecvDeviceBuffer(bx.TP).v()(), bx.RecvDeviceBuffer(bx.TM).v()(), dv.v()(), du.v()(), -cks);
	  SetXBndKernel(bx.RecvDeviceBuffer(bx.XP).v()(), bx.RecvDeviceBuffer(bx.XM).v()(), dv.v()(), du.v()(), -cks);
	  SetYBndKernel(bx.RecvDeviceBuffer(bx.YP).v()(), bx.RecvDeviceBuffer(bx.YM).v()(), dv.v()(), du.v()(), -cks);
	  SetZBndKernel(bx.RecvDeviceBuffer(bx.ZP).v()(), bx.RecvDeviceBuffer(bx.ZM).v()(), dv.v()(), du.v()(), -cks);

	  // bx.WaitSend(bx.TP);
	  // bx.WaitSend(bx.TM);
	  // bx.WaitSend(bx.XP);
	  // bx.WaitSend(bx.XM);
	  // bx.WaitSend(bx.YP);
	  // bx.WaitSend(bx.YM);
	  // bx.WaitSend(bx.ZP);
	  // bx.WaitSend(bx.ZM);

	  // Team.WORLD.barrier();

	  dv.MultGamma5(dv.v()());

	}

	def Dopr_Put_overlap(dv : CUDAWilsonVectorField, du : CUDASU3MatrixField, 
			     dw : CUDAWilsonVectorField, cks : Float, bx : CUDALatticeComm)
	{
	  // Team.WORLD.barrier();

	  //finish is placed for asyncronous copy
	  finish {
	    //make boundary data
	    if(bx.decomp(bx.TP) > 1){
	      val iTP = bx.neighbors()(bx.TP);
	      at (Place(iTP)) async {

		MakeTPBndKernel(bx.SendDeviceBuffer(bx.TP).v()(), dw.v()());
		bx.PutDevice(bx.TP);
	      }
	      val iTM = bx.neighbors()(bx.TM);
	      at (Place(iTM)) async {
		MakeTMBndKernel(bx.SendDeviceBuffer(bx.TM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.TM);
	      }
	    } else {
	      MakeTPBndKernel(bx.SendDeviceBuffer(bx.TP).v()(), dw.v()());
	      MakeTMBndKernel(bx.SendDeviceBuffer(bx.TM).v()(), dw.v()(), du.v()());
	    }
	    if(bx.decomp(bx.XP) > 1){
	      val iXP = bx.neighbors()(bx.XP);
	      at (Place(iXP)) async {
		MakeXPBndKernel(bx.SendDeviceBuffer(bx.XP).v()(), dw.v()());
		bx.PutDevice(bx.XP);
	      }
	      val iXM = bx.neighbors()(bx.XM);
	      at (Place(iXM)) async {
		MakeXMBndKernel(bx.SendDeviceBuffer(bx.XM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.XM);
	      }
	    } else {
	      MakeXPBndKernel(bx.SendDeviceBuffer(bx.XP).v()(), dw.v()());
	      MakeXMBndKernel(bx.SendDeviceBuffer(bx.XM).v()(), dw.v()(), du.v()());
	    }
	    if(bx.decomp(bx.YP) > 1){
	      val iYP = bx.neighbors()(bx.YP);
	      at (Place(iYP)) async {
		MakeYPBndKernel(bx.SendDeviceBuffer(bx.YP).v()(), dw.v()());
		bx.PutDevice(bx.YP);
	      }
	      val iYM = bx.neighbors()(bx.YM);
	      at (Place(iYM)) async {
		MakeYMBndKernel(bx.SendDeviceBuffer(bx.YM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.YM);
	      }
	    } else {
	      MakeYPBndKernel(bx.SendDeviceBuffer(bx.YP).v()(), dw.v()());
	      MakeYMBndKernel(bx.SendDeviceBuffer(bx.YM).v()(), dw.v()(), du.v()());
	    }
	    if(bx.decomp(bx.ZP) > 1){
	      val iZP = bx.neighbors()(bx.ZP);
	      at (Place(iZP)) async {
		MakeZPBndKernel(bx.SendDeviceBuffer(bx.ZP).v()(), dw.v()());
		bx.PutDevice(bx.ZP);
	      }
	      val iZM = bx.neighbors()(bx.ZM);
	      at (Place(iZM)) async {
		MakeZMBndKernel(bx.SendDeviceBuffer(bx.ZM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.ZM);
	      }
	    } else {
	      MakeZPBndKernel(bx.SendDeviceBuffer(bx.ZP).v()(), dw.v()());
	      MakeZMBndKernel(bx.SendDeviceBuffer(bx.ZM).v()(), dw.v()(), du.v()());
	    }

	    //local calculations
// 	    MultKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	    dv.Copy(dv.v()(), dw.v()());

	    // MultTKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    // MultXKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    // MultYKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    // MultZKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	    MultTPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultTMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	    MultXPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultXMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	    MultYPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultYMKernel(dv.v()(),du.v()(),dw.v()(),-cks);

	    MultZPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultZMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	  }

	  //global barrier is needed to make sure boundary exchange finished (I dont know why this is needed????)
	  // Team.WORLD.barrier();

	  //debug
	  bx.RecvToDevice();

	  //set boundary part
	  SetTBndKernel(bx.RecvDeviceBuffer(bx.TP).v()(), bx.RecvDeviceBuffer(bx.TM).v()(), dv.v()(), du.v()(), -cks);
	  SetXBndKernel(bx.RecvDeviceBuffer(bx.XP).v()(), bx.RecvDeviceBuffer(bx.XM).v()(), dv.v()(), du.v()(), -cks);
	  SetYBndKernel(bx.RecvDeviceBuffer(bx.YP).v()(), bx.RecvDeviceBuffer(bx.YM).v()(), dv.v()(), du.v()(), -cks);
	  SetZBndKernel(bx.RecvDeviceBuffer(bx.ZP).v()(), bx.RecvDeviceBuffer(bx.ZM).v()(), dv.v()(), du.v()(), -cks);
// 	  SetTPBndKernel(bx.RecvDeviceBuffer(bx.TP).v()(), dv.v()(), du.v()(), -cks);
// 	  SetTMBndKernel(bx.RecvDeviceBuffer(bx.TM).v()(), dv.v()(), -cks);
// 	  SetXPBndKernel(bx.RecvDeviceBuffer(bx.XP).v()(), dv.v()(), du.v()(), -cks);
// 	  SetXMBndKernel(bx.RecvDeviceBuffer(bx.XM).v()(), dv.v()(), -cks);
// 	  SetYPBndKernel(bx.RecvDeviceBuffer(bx.YP).v()(), dv.v()(), du.v()(), -cks);
// 	  SetYMBndKernel(bx.RecvDeviceBuffer(bx.YM).v()(), dv.v()(), -cks);
// 	  SetZPBndKernel(bx.RecvDeviceBuffer(bx.ZP).v()(), dv.v()(), du.v()(), -cks);
// 	  SetZMBndKernel(bx.RecvDeviceBuffer(bx.ZM).v()(), dv.v()(), -cks);

	  // Team.WORLD.barrier();

	}

	def Dopr_Put(dv : CUDAWilsonVectorField, du : CUDASU3MatrixField, 
		     dw : CUDAWilsonVectorField, cks : Float, bx : CUDALatticeComm)
	{
	  Team.WORLD.barrier();

	  if(bx.decomp(bx.TP) > 1){
	    finish {
	      //make boundary data
	      val iTP = bx.neighbors()(bx.TP);
	      at (Place(iTP)) async {
		// MakeTPBnd(bx,w);
		// bx.Put(bx.TP);
		MakeTPBndKernel(bx.SendDeviceBuffer(bx.TP).v()(), dw.v()());
		bx.PutDevice(bx.TP);
	      }
	      // v.Copy(w);
	      // MultTP(v,u,w,-cks);
	      dv.Copy(dv.v()(), dw.v()());
	      MultTPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    }

	    finish {
	      val iTM = bx.neighbors()(bx.TM);
	      at (Place(iTM)) async {
		// MakeTMBnd(bx,w,u);
		// bx.Put(bx.TM);
		MakeTMBndKernel(bx.SendDeviceBuffer(bx.TM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.TM);
	      }
	      // MultTM(v,u,w,-cks);
	      // SetTPBnd(bx,v,u,-cks);
	      MultTMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	      // bx.WaitDeviceRecv(bx.TP);
	      // SetTPBndKernel(bx.RecvDeviceBuffer(bx.TP).v()(), dv.v()(), du.v()(), -cks);
	    }
	  }
	  else{
	    // MakeTPBnd(bx,w);
	    // MakeTMBnd(bx,w,u);
	    // v.Copy(w);
	    // MultTP(v,u,w,-cks);
	    // MultTM(v,u,w,-cks);
	    // SetTPBnd(bx,v,u,-cks);
	    MakeTPBndKernel(bx.SendDeviceBuffer(bx.TP).v()(), dw.v()());
	    MakeTMBndKernel(bx.SendDeviceBuffer(bx.TM).v()(), dw.v()(), du.v()());
	    dv.Copy(dv.v()(), dw.v()());
	    MultTPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultTMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	    // bx.WaitDeviceRecv(bx.TP);
	    // SetTPBndKernel(bx.RecvDeviceBuffer(bx.TP).v()(), dv.v()(), du.v()(), -cks);
	  }

	  if(bx.decomp(bx.XP) > 1){
	    finish {
	      val iXP = bx.neighbors()(bx.XP);
	      at (Place(iXP)) async {
		// MakeXPBnd(bx,w);
		// bx.Put(bx.XP);
		MakeXPBndKernel(bx.SendDeviceBuffer(bx.XP).v()(), dw.v()());
		bx.PutDevice(bx.XP);
	      }
	      // MultXP(v,u,w,-cks);
	      // SetTMBnd(bx,v,-cks);
	      MultXPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	      bx.WaitDeviceRecv(bx.TM);
	      SetTMBndKernel(bx.RecvDeviceBuffer(bx.TM).v()(), dv.v()(), -cks);
	    }

	    finish {
	      val iXM = bx.neighbors()(bx.XM);
	      at (Place(iXM)) async {
		// MakeXMBnd(bx,w,u);
		// bx.Put(bx.XM);
		MakeXMBndKernel(bx.SendDeviceBuffer(bx.XM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.XM);
	      }
	      // MultXM(v,u,w,-cks);
	      // SetXPBnd(bx,v,u,-cks);
	      MultXMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	      // bx.WaitDeviceRecv(bx.XP);
	      // SetXPBndKernel(bx.RecvDeviceBuffer(bx.XP).v()(), dv.v()(), du.v()(), -cks);
	    }
	  }
	  else{
	    // MakeXPBnd(bx,w);
	    // MakeXMBnd(bx,w,u);
	    // SetTMBnd(bx,v,-cks);
	    // MultXP(v,u,w,-cks);
	    // MultXM(v,u,w,-cks);
	    // SetXPBnd(bx,v,u,-cks);
	    MakeXPBndKernel(bx.SendDeviceBuffer(bx.XP).v()(), dw.v()());
	    MakeXMBndKernel(bx.SendDeviceBuffer(bx.XM).v()(), dw.v()(), du.v()());
//debug
	    // bx.WaitDeviceRecv(bx.TM);
	    // SetTMBndKernel(bx.RecvDeviceBuffer(bx.TM).v()(), dv.v()(), -cks);
	    MultXPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultXMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	    // bx.WaitDeviceRecv(bx.XP);
	    // SetXPBndKernel(bx.RecvDeviceBuffer(bx.XP).v()(), dv.v()(), du.v()(), -cks);
	  }

	  if(bx.decomp(bx.YP) > 1){
	    finish {
	      val iYP = bx.neighbors()(bx.YP);
	      at (Place(iYP)) async {
		// MakeYPBnd(bx,w);
		// bx.Put(bx.YP);
		MakeYPBndKernel(bx.SendDeviceBuffer(bx.YP).v()(), dw.v()());
		bx.PutDevice(bx.YP);
	      }
	      // MultYP(v,u,w,-cks);
	      // SetXMBnd(bx,v,-cks);
	      MultYPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	      // bx.WaitDeviceRecv(bx.XM);
	      // SetXMBndKernel(bx.RecvDeviceBuffer(bx.XM).v()(), dv.v()(), -cks);
	    }

	    finish {
	      val iYM = bx.neighbors()(bx.YM);
	      at (Place(iYM)) async {
		// MakeYMBnd(bx,w,u);
		// bx.Put(bx.YM);
		MakeYMBndKernel(bx.SendDeviceBuffer(bx.YM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.YM);
	      }
	      // MultYM(v,u,w,-cks);
	      // SetYPBnd(bx,v,u,-cks);
	      MultYMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	      // bx.WaitDeviceRecv(bx.YP);
	      // SetYPBndKernel(bx.RecvDeviceBuffer(bx.YP).v()(), dv.v()(), du.v()(), -cks);
	    }
	  }
	  else{
	    // MakeYPBnd(bx,w);
	    // MakeYMBnd(bx,w,u);
	    // SetXMBnd(bx,v,-cks);
	    // MultYP(v,u,w,-cks);
	    // MultYM(v,u,w,-cks);
	    // SetYPBnd(bx,v,u,-cks);
	    MakeYPBndKernel(bx.SendDeviceBuffer(bx.YP).v()(), dw.v()());
	    MakeYMBndKernel(bx.SendDeviceBuffer(bx.YM).v()(), dw.v()(), du.v()());
//debug
	    // bx.WaitDeviceRecv(bx.XM);
	    // SetXMBndKernel(bx.RecvDeviceBuffer(bx.XM).v()(), dv.v()(), -cks);
	    MultYPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultYMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	    // bx.WaitDeviceRecv(bx.YP);
	    // SetYPBndKernel(bx.RecvDeviceBuffer(bx.YP).v()(), dv.v()(), du.v()(), -cks);
	  }

	  if(bx.decomp(bx.ZP) > 1){
	    finish {
	      val iZP = bx.neighbors()(bx.ZP);
	      at (Place(iZP)) async {
		// MakeZPBnd(bx,w);
		// bx.Put(bx.ZP);
		MakeZPBndKernel(bx.SendDeviceBuffer(bx.ZP).v()(), dw.v()());
		bx.PutDevice(bx.ZP);
	      }
	      // MultZP(v,u,w,-cks);
	      // SetYMBnd(bx,v,-cks);
	      MultZPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	      // bx.WaitDeviceRecv(bx.YM);
	      // SetYMBndKernel(bx.RecvDeviceBuffer(bx.YM).v()(), dv.v()(), -cks);
	    }

	    finish {
	      val iZM = bx.neighbors()(bx.ZM);
	      at (Place(iZM)) async {
		// MakeZMBnd(bx,w,u);
		// bx.Put(bx.ZM);
		MakeZMBndKernel(bx.SendDeviceBuffer(bx.ZM).v()(), dw.v()(), du.v()());
		bx.PutDevice(bx.ZM);
	      }
	      // MultZM(v,u,w,-cks);
	      // SetZPBnd(bx,v,u,-cks);
	      MultZMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	      // bx.WaitDeviceRecv(bx.ZP);
	      // SetZPBndKernel(bx.RecvDeviceBuffer(bx.ZP).v()(), dv.v()(), du.v()(), -cks);
	    }
	  }
	  else{
	    // MakeZPBnd(bx,w);
	    // MakeZMBnd(bx,w,u);
	    // MultZP(v,u,w,-cks);
	    // MultZM(v,u,w,-cks);
	    // SetYMBnd(bx,v,-cks);
	    // SetZPBnd(bx,v,u,-cks);
	    MakeZPBndKernel(bx.SendDeviceBuffer(bx.ZP).v()(), dw.v()());
	    MakeZMBndKernel(bx.SendDeviceBuffer(bx.ZM).v()(), dw.v()(), du.v()());
	    MultZPKernel(dv.v()(),du.v()(),dw.v()(),-cks);
	    MultZMKernel(dv.v()(),du.v()(),dw.v()(),-cks);
//debug
	    // bx.WaitDeviceRecv(bx.YM);
	    // SetYMBndKernel(bx.RecvDeviceBuffer(bx.YM).v()(), dv.v()(), -cks);
	    // bx.WaitDeviceRecv(bx.ZP);
	    // SetZPBndKernel(bx.RecvDeviceBuffer(bx.ZP).v()(), dv.v()(), du.v()(), -cks);
	  }
	  // bx.WaitDeviceRecv(bx.ZM);
	  // SetZMBnd(bx,v,-cks);
//debug	
	  // bx.RecvToDevice();
	  bx.WaitDeviceRecv(bx.TP);
	  bx.WaitDeviceRecv(bx.TM);
	  bx.WaitDeviceRecv(bx.XP);
	  bx.WaitDeviceRecv(bx.XM);
	  bx.WaitDeviceRecv(bx.YP);
	  bx.WaitDeviceRecv(bx.YM);
	  bx.WaitDeviceRecv(bx.ZP);
	  bx.WaitDeviceRecv(bx.ZM);

	  SetTPBndKernel(bx.RecvDeviceBuffer(bx.TP).v()(), dv.v()(), du.v()(), -cks);
	  SetTMBndKernel(bx.RecvDeviceBuffer(bx.TM).v()(), dv.v()(), -cks);
	  SetXPBndKernel(bx.RecvDeviceBuffer(bx.XP).v()(), dv.v()(), du.v()(), -cks);
	  SetXMBndKernel(bx.RecvDeviceBuffer(bx.XM).v()(), dv.v()(), -cks);
	  SetYPBndKernel(bx.RecvDeviceBuffer(bx.YP).v()(), dv.v()(), du.v()(), -cks);
	  SetYMBndKernel(bx.RecvDeviceBuffer(bx.YM).v()(), dv.v()(), -cks);
	  SetZPBndKernel(bx.RecvDeviceBuffer(bx.ZP).v()(), dv.v()(), du.v()(), -cks);
	  SetZMBndKernel(bx.RecvDeviceBuffer(bx.ZM).v()(), dv.v()(), -cks);

	  Team.WORLD.barrier();
	}

	def Dopr_Put(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Float, bx : CUDALatticeComm)
	{
		Team.WORLD.barrier();

		if(bx.decomp(bx.TP) > 1){
			finish {
				//make boundary data
				val iTP = bx.neighbors()(bx.TP);
				at (Place(iTP)) async {
					MakeTPBnd(bx,w);

					bx.Put(bx.TP);
				}
				v.Copy(w);
				MultTP(v,u,w,-cks);
			}

			finish {
				val iTM = bx.neighbors()(bx.TM);
				at (Place(iTM)) async {
					MakeTMBnd(bx,w,u);

					bx.Put(bx.TM);
				}
				MultTM(v,u,w,-cks);
				SetTPBnd(bx,v,u,-cks);
			}
		}
		else{
			MakeTPBnd(bx,w);
			MakeTMBnd(bx,w,u);
			v.Copy(w);
			MultTP(v,u,w,-cks);
			MultTM(v,u,w,-cks);
			SetTPBnd(bx,v,u,-cks);
		}

		if(bx.decomp(bx.XP) > 1){
			finish {
				val iXP = bx.neighbors()(bx.XP);
				at (Place(iXP)) async {
					MakeXPBnd(bx,w);

					bx.Put(bx.XP);
				}
				MultXP(v,u,w,-cks);
				SetTMBnd(bx,v,-cks);
			}

			finish {
				val iXM = bx.neighbors()(bx.XM);
				at (Place(iXM)) async {
					MakeXMBnd(bx,w,u);

					bx.Put(bx.XM);
				}
				MultXM(v,u,w,-cks);
				SetXPBnd(bx,v,u,-cks);
			}
		}
		else{
			MakeXPBnd(bx,w);
			MakeXMBnd(bx,w,u);
			SetTMBnd(bx,v,-cks);
			MultXP(v,u,w,-cks);
			MultXM(v,u,w,-cks);
			SetXPBnd(bx,v,u,-cks);
		}

		if(bx.decomp(bx.YP) > 1){
			finish {
				val iYP = bx.neighbors()(bx.YP);
				at (Place(iYP)) async {
					MakeYPBnd(bx,w);

					bx.Put(bx.YP);
				}
				MultYP(v,u,w,-cks);
				SetXMBnd(bx,v,-cks);
			}

			finish {
				val iYM = bx.neighbors()(bx.YM);
				at (Place(iYM)) async {
					MakeYMBnd(bx,w,u);

					bx.Put(bx.YM);
				}
				MultYM(v,u,w,-cks);
				SetYPBnd(bx,v,u,-cks);
			}
		}
		else{
			MakeYPBnd(bx,w);
			MakeYMBnd(bx,w,u);
			SetXMBnd(bx,v,-cks);
			MultYP(v,u,w,-cks);
			MultYM(v,u,w,-cks);
			SetYPBnd(bx,v,u,-cks);
		}

		if(bx.decomp(bx.ZP) > 1){
			finish {
				val iZP = bx.neighbors()(bx.ZP);
				at (Place(iZP)) async {
					MakeZPBnd(bx,w);

					bx.Put(bx.ZP);
				}
				MultZP(v,u,w,-cks);
				SetYMBnd(bx,v,-cks);
			}

			finish {
				val iZM = bx.neighbors()(bx.ZM);
				at (Place(iZM)) async {
					MakeZMBnd(bx,w,u);

					bx.Put(bx.ZM);
				}
				MultZM(v,u,w,-cks);
				SetZPBnd(bx,v,u,-cks);
			}
		}
		else{
			MakeZPBnd(bx,w);
			MakeZMBnd(bx,w,u);
			MultZP(v,u,w,-cks);
			MultZM(v,u,w,-cks);
			SetYMBnd(bx,v,-cks);
			SetZPBnd(bx,v,u,-cks);
		}
		SetZMBnd(bx,v,-cks);

		Team.WORLD.barrier();
	}

	def Dopr_Put_uc(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Float, bx : CUDALatticeComm)
	{
		val flagRef = GlobalRail(bx.recvFlag());

		for(i in 0..7){
			bx.recvFlag()(i) = 0;
		}
		Team.WORLD.barrier();

		//make boundary data
		val iTP = bx.neighbors()(bx.TP);
		val bufTP = GlobalRail(bx.RecvBuffer(bx.TP).v());
		at (Place(iTP)) async {
			val size = bx.SendBuffer(bx.TP).size;
			MakeTPBnd(bx,w);

			Rail.uncountedCopy[Float](bx.SendBuffer(bx.TP).v(),0,bufTP,0,size,()=>{flagRef()(bx.TP)=size;});
		}

		val iTM = bx.neighbors()(bx.TM);
		val bufTM = GlobalRail(bx.RecvBuffer(bx.TM).v());
		at (Place(iTM)) async {
			val size = bx.SendBuffer(bx.TM).size;
			MakeTMBnd(bx,w,u);

			Rail.uncountedCopy[Float](bx.SendBuffer(bx.TM).v(),0,bufTM,0,size,()=>{flagRef()(bx.TM)=size;});
		}

		val iXP = bx.neighbors()(bx.XP);
		val bufXP = GlobalRail(bx.RecvBuffer(bx.XP).v());
		at (Place(iXP)) async {
			val size = bx.SendBuffer(bx.XP).size;
			MakeXPBnd(bx,w);

			Rail.uncountedCopy[Float](bx.SendBuffer(bx.XP).v(),0,bufXP,0,size,()=>{flagRef()(bx.XP)=size;});
		}
		val iXM = bx.neighbors()(bx.XM);
		val bufXM = GlobalRail(bx.RecvBuffer(bx.XM).v());
		at (Place(iXM)) async {
			val size = bx.SendBuffer(bx.XM).size;
			MakeXMBnd(bx,w,u);

			Rail.uncountedCopy[Float](bx.SendBuffer(bx.XM).v(),0,bufXM,0,size,()=>{flagRef()(bx.XM)=size;});
		}

		val iYP = bx.neighbors()(bx.YP);
		val bufYP = GlobalRail(bx.RecvBuffer(bx.YP).v());
		at (Place(iYP)) async {
			val size = bx.SendBuffer(bx.YP).size;
			MakeYPBnd(bx,w);

			Rail.uncountedCopy[Float](bx.SendBuffer(bx.YP).v(),0,bufYP,0,size,()=>{flagRef()(bx.YP)=size;});
		}

		val iYM = bx.neighbors()(bx.YM);
		val bufYM = GlobalRail(bx.RecvBuffer(bx.YM).v());
		at (Place(iYM)) async {
			val size = bx.SendBuffer(bx.YM).size;
			MakeYMBnd(bx,w,u);

			Rail.uncountedCopy[Float](bx.SendBuffer(bx.YM).v(),0,bufYM,0,size,()=>{flagRef()(bx.YM)=size;});
		}

		val iZP = bx.neighbors()(bx.ZP);
		val bufZP = GlobalRail(bx.RecvBuffer(bx.ZP).v());
		at (Place(iZP)) async {
			val size = bx.SendBuffer(bx.ZP).size;
			MakeZPBnd(bx,w);

			Rail.uncountedCopy[Float](bx.SendBuffer(bx.ZP).v(),0,bufZP,0,size,()=>{flagRef()(bx.ZP)=size;});
		}

		val iZM = bx.neighbors()(bx.ZM);
		val bufZM = GlobalRail(bx.RecvBuffer(bx.ZM).v());
		at (Place(iZM)) async {
			val size = bx.SendBuffer(bx.ZM).size;
			MakeZMBnd(bx,w,u);

			Rail.uncountedCopy[Float](bx.SendBuffer(bx.ZM).v(),0,bufZM,0,size,()=>{flagRef()(bx.ZM)=size;});
		}

		v.Copy(w);

		//local calculations
		MultTP(v,u,w,-cks);
		MultTM(v,u,w,-cks);

		MultXP(v,u,w,-cks);
		MultXM(v,u,w,-cks);

		MultYP(v,u,w,-cks);
		MultYM(v,u,w,-cks);

		MultZP(v,u,w,-cks);
		MultZM(v,u,w,-cks);

		//global barrier is needed to make sure boundary exchange finished (I dont know why this is needed????)
//		Team.WORLD.barrier();

		//set boundary part
		while(bx.recvFlag()(bx.TP) == 0);
		SetTPBnd(bx,v,u,-cks);

		while(bx.recvFlag()(bx.TM) == 0);
		SetTMBnd(bx,v,-cks);

		while(bx.recvFlag()(bx.XP) == 0);
		SetXPBnd(bx,v,u,-cks);

		while(bx.recvFlag()(bx.XM) == 0);
		SetXMBnd(bx,v,-cks);

		while(bx.recvFlag()(bx.YP) == 0);
		SetYPBnd(bx,v,u,-cks);

		while(bx.recvFlag()(bx.YM) == 0);
		SetYMBnd(bx,v,-cks);

		while(bx.recvFlag()(bx.ZP) == 0);
		SetZPBnd(bx,v,u,-cks);

		while(bx.recvFlag()(bx.ZM) == 0);
		SetZMBnd(bx,v,-cks);

		// Team.WORLD.barrier();

	}


	def DoprH(v : WilsonVectorField, u : SU3MatrixField,
		  w : WilsonVectorField, cks : Float, bx : CUDALatticeComm)
	{
	  Dopr_Put(v,u,w,cks,bx);
	  v.MultGamma5();
	}

	def DoprH(dv : CUDAWilsonVectorField, du : CUDASU3MatrixField,
		  dw : CUDAWilsonVectorField, cks : Float, bx : CUDALatticeComm)
	{
	  // val startTime = System.nanoTime();
	  // Dopr_Get_overlap(dv,du,dw,cks,bx);
	  // Dopr_Put_overlap_uc_direct(dv,du,dw,cks,bx);
	  Dopr_Put_overlap(dv,du,dw,cks,bx);

	  dv.MultGamma5(dv.v()());
	}
}


