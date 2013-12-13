

import WilsonVectorField;
import SU3MatrixField;
import HalfWilsonVectorField;


import LatticeComm;


import x10.compiler.Inline;
import x10.compiler.Pragma;


import x10.util.Team;


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


class HalfWilsonMult {
	var h0_0r : Double;
	var h0_0i : Double;
	var h0_1r : Double;
	var h0_1i : Double;
	var h0_2r : Double;
	var h0_2i : Double;
	var h1_0r : Double;
	var h1_0i : Double;
	var h1_1r : Double;
	var h1_1i : Double;
	var h1_2r : Double;
	var h1_2i : Double;

	@Inline def Load(w : Rail[Double], iw : Long)
	{
		h0_0r  = w(iw*12+0);		h0_0i  = w(iw*12+1);
		h0_1r  = w(iw*12+2);		h0_1i  = w(iw*12+3);
		h0_2r  = w(iw*12+4);		h0_2i  = w(iw*12+5);

		h1_0r  = w(iw*12+6);		h1_0i  = w(iw*12+7);
		h1_1r  = w(iw*12+8);		h1_1i  = w(iw*12+9);
		h1_2r = w(iw*12+10);	h1_2i = w(iw*12+11);
	}

	@Inline def Store(w : Rail[Double], iw : Long)
	{
		w(iw*12+0) = h0_0r;		w(iw*12+1) = h0_0i;
		w(iw*12+2) = h0_1r;		w(iw*12+3) = h0_1i;
		w(iw*12+4) = h0_2r;		w(iw*12+5) = h0_2i;

		w(iw*12+6) = h1_0r;		w(iw*12+7) = h1_0i;
		w(iw*12+8) = h1_1r;		w(iw*12+9) = h1_1i;
		w(iw*12+10)= h1_2r;		w(iw*12+11)= h1_2i;
	}

	@Inline def PackXP(w : Rail[Double], iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + i*w3
		h0_0r = w(pos+0) - w(pos+19);		h0_0i = w(pos+1) + w(pos+18);
		h0_1r = w(pos+2) - w(pos+21);		h0_1i = w(pos+3) + w(pos+20);
		h0_2r = w(pos+4) - w(pos+23);		h0_2i = w(pos+5) + w(pos+22);

		//h1 = w1 + i*w2
		h1_0r = w(pos+6) - w(pos+13);		h1_0i = w(pos+7) + w(pos+12);
		h1_1r = w(pos+8) - w(pos+15);		h1_1i = w(pos+9) + w(pos+14);
		h1_2r= w(pos+10)- w(pos+17);		h1_2i= w(pos+11)+ w(pos+16);
	}

	@Inline def PackXM(w : Rail[Double], iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - i*w3
		h0_0r = w(pos+0) + w(pos+19);		h0_0i = w(pos+1) - w(pos+18);
		h0_1r = w(pos+2) + w(pos+21);		h0_1i = w(pos+3) - w(pos+20);
		h0_2r = w(pos+4) + w(pos+23);		h0_2i = w(pos+5) - w(pos+22);

		//h1 = w1 - i*w2
		h1_0r = w(pos+6) + w(pos+13);		h1_0i = w(pos+7) - w(pos+12);
		h1_1r = w(pos+8) + w(pos+15);		h1_1i = w(pos+9) - w(pos+14);
		h1_2r= w(pos+10)+ w(pos+17);		h1_2i= w(pos+11)- w(pos+16);
	}

	@Inline def PackYP(w : Rail[Double], iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + w3
		h0_0r = w(pos+0) + w(pos+18);		h0_0i = w(pos+1) + w(pos+19);
		h0_1r = w(pos+2) + w(pos+20);		h0_1i = w(pos+3) + w(pos+21);
		h0_2r = w(pos+4) + w(pos+22);		h0_2i = w(pos+5) + w(pos+23);

		//h1 = w1 - w2
		h1_0r = w(pos+6) - w(pos+12);		h1_0i = w(pos+7) - w(pos+13);
		h1_1r = w(pos+8) - w(pos+14);		h1_1i = w(pos+9) - w(pos+15);
		h1_2r= w(pos+10)- w(pos+16);		h1_2i= w(pos+11)- w(pos+17);
	}

	@Inline def PackYM(w : Rail[Double], iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - w3
		h0_0r = w(pos+0) - w(pos+18);		h0_0i = w(pos+1) - w(pos+19);
		h0_1r = w(pos+2) - w(pos+20);		h0_1i = w(pos+3) - w(pos+21);
		h0_2r = w(pos+4) - w(pos+22);		h0_2i = w(pos+5) - w(pos+23);

		//h1 = w1 + w2
		h1_0r = w(pos+6) + w(pos+12);		h1_0i = w(pos+7) + w(pos+13);
		h1_1r = w(pos+8) + w(pos+14);		h1_1i = w(pos+9) + w(pos+15);
		h1_2r= w(pos+10)+ w(pos+16);		h1_2i= w(pos+11)+ w(pos+17);
	}
	
	@Inline def PackZP(w : Rail[Double], iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + i*w2
		h0_0r = w(pos+0) - w(pos+13);		h0_0i = w(pos+1) + w(pos+12);
		h0_1r = w(pos+2) - w(pos+15);		h0_1i = w(pos+3) + w(pos+14);
		h0_2r = w(pos+4) - w(pos+17);		h0_2i = w(pos+5) + w(pos+16);

		//h1 = w1 - i*w3
		h1_0r = w(pos+6) + w(pos+19);		h1_0i = w(pos+7) - w(pos+18);
		h1_1r = w(pos+8) + w(pos+21);		h1_1i = w(pos+9) - w(pos+20);
		h1_2r= w(pos+10)+ w(pos+23);		h1_2i= w(pos+11)- w(pos+22);
	}

	@Inline def PackZM(w : Rail[Double], iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - i*w3
		h0_0r = w(pos+0) + w(pos+13);		h0_0i = w(pos+1) - w(pos+12);
		h0_1r = w(pos+2) + w(pos+15);		h0_1i = w(pos+3) - w(pos+14);
		h0_2r = w(pos+4) + w(pos+17);		h0_2i = w(pos+5) - w(pos+16);

		//h1 = w1 + i*w2
		h1_0r = w(pos+6) - w(pos+19);		h1_0i = w(pos+7) + w(pos+18);
		h1_1r = w(pos+8) - w(pos+21);		h1_1i = w(pos+9) + w(pos+20);
		h1_2r= w(pos+10)- w(pos+23);		h1_2i= w(pos+11)+ w(pos+22);
	}

	//Dirac representation
	@Inline def PackTP(w : Rail[Double], iw : Long)
	{
		val pos = iw*24;
		//h0 = 2.0*w2
		h0_0r = 2.0*w(pos+12);		h0_0i = 2.0*w(pos+13);
		h0_1r = 2.0*w(pos+14);		h0_1i = 2.0*w(pos+15);
		h0_2r = 2.0*w(pos+16);		h0_2i = 2.0*w(pos+17);

		//h1 = 2.0*w3
		h1_0r = 2.0*w(pos+18);		h1_0i = 2.0*w(pos+19);
		h1_1r = 2.0*w(pos+20);		h1_1i = 2.0*w(pos+21);
		h1_2r= 2.0*w(pos+22);		h1_2i= 2.0*w(pos+23);
	}

	//Dirac representation
	@Inline def PackTM(w : Rail[Double], iw : Long)
	{
		val pos = iw*24;
		//h0 = 2.0*w0
		h0_0r = 2.0*w(pos+0);		h0_0i = 2.0*w(pos+1);
		h0_1r = 2.0*w(pos+2);		h0_1i = 2.0*w(pos+3);
		h0_2r = 2.0*w(pos+4);		h0_2i = 2.0*w(pos+5);

		//h1 = 2.0*w1
		h1_0r = 2.0*w(pos+6);		h1_0i = 2.0*w(pos+7);
		h1_1r = 2.0*w(pos+8);		h1_1i = 2.0*w(pos+9);
		h1_2r= 2.0*w(pos+10);		h1_2i= 2.0*w(pos+11);
	}

	@Inline def MultU(u : Rail[Double],iu : Long, h : HalfWilsonMult)
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
				u(pos+4)*h.h1_2r- u(pos+5)*h.h1_2i;
		h1_0i = 	u(pos+0)*h.h1_0i + u(pos+1)*h.h1_0r + 
				u(pos+2)*h.h1_1i + u(pos+3)*h.h1_1r + 
				u(pos+4)*h.h1_2i+ u(pos+5)*h.h1_2r;

		h0_1r = 	u(pos+6) *h.h0_0r - u(pos+7) *h.h0_0i + 
				u(pos+8) *h.h0_1r - u(pos+9) *h.h0_1i + 
				u(pos+10)*h.h0_2r - u(pos+11)*h.h0_2i;
		h0_1i = 	u(pos+6) *h.h0_0i + u(pos+7) *h.h0_0r + 
				u(pos+8) *h.h0_1i + u(pos+9) *h.h0_1r + 
				u(pos+10)*h.h0_2i + u(pos+11)*h.h0_2r;

		h1_1r = 	u(pos+6) *h.h1_0r - u(pos+7) *h.h1_0i + 
				u(pos+8) *h.h1_1r - u(pos+9) *h.h1_1i + 
				u(pos+10)*h.h1_2r- u(pos+11)*h.h1_2i;
		h1_1i = 	u(pos+6) *h.h1_0i + u(pos+7) *h.h1_0r + 
				u(pos+8) *h.h1_1i + u(pos+9) *h.h1_1r + 
				u(pos+10)*h.h1_2i+ u(pos+11)*h.h1_2r;

		h0_2r = 	u(pos+12)*h.h0_0r - u(pos+13)*h.h0_0i + 
				u(pos+14)*h.h0_1r - u(pos+15)*h.h0_1i + 
				u(pos+16)*h.h0_2r - u(pos+17)*h.h0_2i;
		h0_2i = 	u(pos+12)*h.h0_0i + u(pos+13)*h.h0_0r + 
				u(pos+14)*h.h0_1i + u(pos+15)*h.h0_1r + 
				u(pos+16)*h.h0_2i + u(pos+17)*h.h0_2r;

		h1_2r= 	u(pos+12)*h.h1_0r - u(pos+13)*h.h1_0i + 
				u(pos+14)*h.h1_1r - u(pos+15)*h.h1_1i + 
				u(pos+16)*h.h1_2r- u(pos+17)*h.h1_2i;
		h1_2i= 	u(pos+12)*h.h1_0i + u(pos+13)*h.h1_0r + 
				u(pos+14)*h.h1_1i + u(pos+15)*h.h1_1r + 
				u(pos+16)*h.h1_2i+ u(pos+17)*h.h1_2r;
	}

	@Inline def MultUt(u : Rail[Double],iu : Long, h : HalfWilsonMult)
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
				u(pos+12)*h.h1_2r+ u(pos+13)*h.h1_2i;
		h1_0i = 	u(pos+0) *h.h1_0i - u(pos+1) *h.h1_0r + 
				u(pos+6) *h.h1_1i - u(pos+7) *h.h1_1r + 
				u(pos+12)*h.h1_2i- u(pos+13)*h.h1_2r;

		h0_1r = 	u(pos+2) *h.h0_0r + u(pos+3) *h.h0_0i + 
				u(pos+8) *h.h0_1r + u(pos+9) *h.h0_1i + 
				u(pos+14)*h.h0_2r + u(pos+15)*h.h0_2i;
		h0_1i = 	u(pos+2) *h.h0_0i - u(pos+3) *h.h0_0r + 
				u(pos+8) *h.h0_1i - u(pos+9) *h.h0_1r + 
				u(pos+14)*h.h0_2i - u(pos+15)*h.h0_2r;

		h1_1r = 	u(pos+2) *h.h1_0r + u(pos+3) *h.h1_0i + 
				u(pos+8) *h.h1_1r + u(pos+9) *h.h1_1i + 
				u(pos+14)*h.h1_2r+ u(pos+15)*h.h1_2i;
		h1_1i = 	u(pos+2) *h.h1_0i - u(pos+3) *h.h1_0r + 
				u(pos+8) *h.h1_1i - u(pos+9) *h.h1_1r + 
				u(pos+14)*h.h1_2i- u(pos+15)*h.h1_2r;

		h0_2r = 	u(pos+4) *h.h0_0r + u(pos+5) *h.h0_0i + 
				u(pos+10)*h.h0_1r + u(pos+11)*h.h0_1i + 
				u(pos+16)*h.h0_2r + u(pos+17)*h.h0_2i;
		h0_2i = 	u(pos+4) *h.h0_0i - u(pos+5) *h.h0_0r + 
				u(pos+10)*h.h0_1i - u(pos+11)*h.h0_1r + 
				u(pos+16)*h.h0_2i - u(pos+17)*h.h0_2r;

		h1_2r= 	u(pos+4) *h.h1_0r + u(pos+5) *h.h1_0i + 
				u(pos+10)*h.h1_1r + u(pos+11)*h.h1_1i + 
				u(pos+16)*h.h1_2r+ u(pos+17)*h.h1_2i;
		h1_2i= 	u(pos+4) *h.h1_0i - u(pos+5) *h.h1_0r + 
				u(pos+10)*h.h1_1i - u(pos+11)*h.h1_1r + 
				u(pos+16)*h.h1_2i- u(pos+17)*h.h1_2r;
	}

	@Inline def UnpackXP(w : Rail[Double], iw : Long, cks : Double)
	{
		val pos = iw*24;

		w(pos+0) += cks*h0_0r;			w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;			w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;			w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;			w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;			w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;			w(pos+11)+= cks*h1_2i;

		//w3 += -i*h1
		w(pos+12) += cks*h1_0i;		w(pos+13) -= cks*h1_0r;
		w(pos+14) += cks*h1_1i;		w(pos+15) -= cks*h1_1r;
		w(pos+16) += cks*h1_2i;		w(pos+17) -= cks*h1_2r;

		//w4 += -i*h0
		w(pos+18) += cks*h0_0i;		w(pos+19) -= cks*h0_0r;
		w(pos+20) += cks*h0_1i;		w(pos+21) -= cks*h0_1r;
		w(pos+22) += cks*h0_2i;		w(pos+23) -= cks*h0_2r;
	}

	@Inline def UnpackXM(w : Rail[Double], iw : Long, cks : Double)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;			w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;			w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;			w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;			w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;			w(pos+9) += cks*h1_1i;
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

	@Inline def UnpackYP(w : Rail[Double], iw : Long, cks : Double)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;			w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;			w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;			w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;			w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;			w(pos+9) += cks*h1_1i;
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

	@Inline def UnpackYM(w : Rail[Double], iw : Long, cks : Double)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;			w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;			w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;			w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;			w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;			w(pos+9) += cks*h1_1i;
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

	@Inline def UnpackZP(w : Rail[Double], iw : Long, cks : Double)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;			w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;			w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;			w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;			w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;			w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;			w(pos+11)+= cks*h1_2i;

		//w3 += -i*h0
		w(pos+12) += cks*h0_0i;		w(pos+13) -= cks*h0_0r;
		w(pos+14) += cks*h0_1i;		w(pos+15) -= cks*h0_1r;
		w(pos+16) += cks*h0_2i;		w(pos+17) -= cks*h0_2r;

		//w4 += i*h1
		w(pos+18) -= cks*h1_0i;		w(pos+19) += cks*h1_0r;
		w(pos+20) -= cks*h1_1i;		w(pos+21) += cks*h1_1r;
		w(pos+22) -= cks*h1_2i;		w(pos+23) += cks*h1_2r;
	}

	@Inline def UnpackZM(w : Rail[Double], iw : Long, cks : Double)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;			w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;			w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;			w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;			w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;			w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;			w(pos+11)+= cks*h1_2i;

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
	@Inline def UnpackTP(w : Rail[Double], iw : Long, cks : Double)
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
	@Inline def UnpackTM(w : Rail[Double], iw : Long, cks : Double)
	{
		val pos = iw*24;
		w(pos+0) += cks*h0_0r;			w(pos+1) += cks*h0_0i;
		w(pos+2) += cks*h0_1r;			w(pos+3) += cks*h0_1i;
		w(pos+4) += cks*h0_2r;			w(pos+5) += cks*h0_2i;

		w(pos+6) += cks*h1_0r;			w(pos+7) += cks*h1_0i;
		w(pos+8) += cks*h1_1r;			w(pos+9) += cks*h1_1i;
		w(pos+10)+= cks*h1_2r;			w(pos+11)+= cks*h1_2i;
	}

}








public class Dslash extends Lattice {
	val nThreads : Long;
	val ht1 : Rail[HalfWilsonMult];
	val ht2 : Rail[HalfWilsonMult];
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

		var no : Long;
		var ni : Long;
		var io : Long;
		var ii : Long;
		var g0 : Long;
		var g1 : Long;
		for(tid in 0..(nThreads - 1)){
			ht1(tid) = new HalfWilsonMult();
			ht2(tid) = new HalfWilsonMult();
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

	def MakeXPBnd(bx : LatticeComm, w : WilsonVectorField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				ht1(tid).PackXP(w.v(),i*Nx);
				ht1(tid).Store(bx.SendBuffer(bx.XP).v(),i);
			}
		}
	}
	def MakeXMBnd(bx : LatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				ht1(tid).PackXM(w.v(),i*Nx + Nx-1);
				ht2(tid).MultUt(u.v(),offset_ux + i*Nx + Nx-1,ht1(tid));
				ht2(tid).Store(bx.SendBuffer(bx.XM).v(),i);
			}
		}
	}

	def MakeYPBnd(bx : LatticeComm, w : WilsonVectorField)
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
	def MakeYMBnd(bx : LatticeComm, w : WilsonVectorField, u : SU3MatrixField)
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

	def MakeZPBnd(bx : LatticeComm, w : WilsonVectorField)
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
	def MakeZMBnd(bx : LatticeComm, w : WilsonVectorField, u : SU3MatrixField)
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

	def MakeTPBnd(bx : LatticeComm, w : WilsonVectorField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngTBnd(tid)){
				ht1(tid).PackTP(w.v(),i);
				ht1(tid).Store(bx.SendBuffer(bx.TP).v(),i);
			}
		}
	}
	def MakeTMBnd(bx : LatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngTBnd(tid)){
				ht1(tid).PackTM(w.v(),nsite-Nxyz + i);
				ht2(tid).MultUt(u.v(),offset_ut + nsite-Nxyz + i,ht1(tid));
				ht2(tid).Store(bx.SendBuffer(bx.TM).v(),i);
			}
		}
	}

	def SetXPBnd(bx : LatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				ht1(tid).Load(bx.RecvBuffer(bx.XP).v(),i);
				ht2(tid).MultU(u.v(),offset_ux + i*Nx + Nx - 1,ht1(tid));
				ht2(tid).UnpackXP(v.v(),i*Nx + Nx - 1,cks);
			}
		}
	}
	def SetXMBnd(bx : LatticeComm, v : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngX(tid)){
				ht1(tid).Load(bx.RecvBuffer(bx.XM).v(),i);
				ht1(tid).UnpackXM(v.v(),i*Nx,cks);
			}
		}
	}

	def SetYPBnd(bx : LatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Double)
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
	def SetYMBnd(bx : LatticeComm, v : WilsonVectorField, cks : Double)
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

	def SetZPBnd(bx : LatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Double)
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
	def SetZMBnd(bx : LatticeComm, v : WilsonVectorField, cks : Double)
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

	def SetTPBnd(bx : LatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngTBnd(tid)){
				ht1(tid).Load(bx.RecvBuffer(bx.TP).v(),i);
				ht2(tid).MultU(u.v(),offset_ut + nsite-Nxyz + i,ht1(tid));
				ht2(tid).UnpackTP(v.v(),nsite-Nxyz + i,cks);
			}
		}
	}
	def SetTMBnd(bx : LatticeComm, v : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngTBnd(tid)){
				ht1(tid).Load(bx.RecvBuffer(bx.TM).v(),i);
				ht1(tid).UnpackTM(v.v(),i,cks);
			}
		}
	}


	def MultXP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
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
	def MultXM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
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

	def MultYP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
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
	def MultYM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
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

	def MultZP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
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
	def MultZM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
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

	def MultTP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngT(tid)){
				ht1(tid).PackTP(w.v(),i + Nxyz);
				ht2(tid).MultU(u.v(),offset_ut + i,ht1(tid));
				ht2(tid).UnpackTP(v.v(),i,cks);
			}
		}
	}
	def MultTM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngT(tid)){
				ht1(tid).PackTM(w.v(),i);
				ht2(tid).MultUt(u.v(),offset_ut + i,ht1(tid));
				ht2(tid).UnpackTM(v.v(),i + Nxyz,cks);
			}
		}
	}

	def Dopr_Get(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double, bx : LatticeComm)
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

	def Dopr_Put_overlap(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double, bx : LatticeComm)
	{
		Team.WORLD.barrier();

		//finish is placed for asyncronous copy
		finish {
			//make boundary data
			val iTP = bx.neighbors()(bx.TP);
			at (Place(iTP)) async {
				MakeTPBnd(bx,w);

				bx.Put(bx.TP);
			}

			val iTM = bx.neighbors()(bx.TM);
			at (Place(iTM)) async {
				MakeTMBnd(bx,w,u);

				bx.Put(bx.TM);
			}

			val iXP = bx.neighbors()(bx.XP);
			at (Place(iXP)) async {
				MakeXPBnd(bx,w);

				bx.Put(bx.XP);
			}

			val iXM = bx.neighbors()(bx.XM);
			at (Place(iXM)) async {
				MakeXMBnd(bx,w,u);

				bx.Put(bx.XM);
			}

			val iYP = bx.neighbors()(bx.YP);
			at (Place(iYP)) async {
				MakeYPBnd(bx,w);

				bx.Put(bx.YP);
			}

			val iYM = bx.neighbors()(bx.YM);
			at (Place(iYM)) async {
				MakeYMBnd(bx,w,u);

				bx.Put(bx.YM);
			}

			val iZP = bx.neighbors()(bx.ZP);
			at (Place(iZP)) async {
				MakeZPBnd(bx,w);

				bx.Put(bx.ZP);
			}

			val iZM = bx.neighbors()(bx.ZM);
			at (Place(iZM)) async {
				MakeZMBnd(bx,w,u);

				bx.Put(bx.ZM);
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
		}

		//global barrier is needed to make sure boundary exchange finished (I dont know why this is needed????)
//		Team.WORLD.barrier();

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

	def Dopr_Put(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double, bx : LatticeComm)
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

	def Dopr_Put_uc(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double, bx : LatticeComm)
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

			Rail.uncountedCopy[Double](bx.SendBuffer(bx.TP).v(),0,bufTP,0,size,()=>{flagRef()(bx.TP)=size;});
		}

		val iTM = bx.neighbors()(bx.TM);
		val bufTM = GlobalRail(bx.RecvBuffer(bx.TM).v());
		at (Place(iTM)) async {
			val size = bx.SendBuffer(bx.TM).size;
			MakeTMBnd(bx,w,u);

			Rail.uncountedCopy[Double](bx.SendBuffer(bx.TM).v(),0,bufTM,0,size,()=>{flagRef()(bx.TM)=size;});
		}

		val iXP = bx.neighbors()(bx.XP);
		val bufXP = GlobalRail(bx.RecvBuffer(bx.XP).v());
		at (Place(iXP)) async {
			val size = bx.SendBuffer(bx.XP).size;
			MakeXPBnd(bx,w);

			Rail.uncountedCopy[Double](bx.SendBuffer(bx.XP).v(),0,bufXP,0,size,()=>{flagRef()(bx.XP)=size;});
		}

		val iXM = bx.neighbors()(bx.XM);
		val bufXM = GlobalRail(bx.RecvBuffer(bx.XM).v());
		at (Place(iXM)) async {
			val size = bx.SendBuffer(bx.XM).size;
			MakeXMBnd(bx,w,u);

			Rail.uncountedCopy[Double](bx.SendBuffer(bx.XM).v(),0,bufXM,0,size,()=>{flagRef()(bx.XM)=size;});
		}

		val iYP = bx.neighbors()(bx.YP);
		val bufYP = GlobalRail(bx.RecvBuffer(bx.YP).v());
		at (Place(iYP)) async {
			val size = bx.SendBuffer(bx.YP).size;
			MakeYPBnd(bx,w);

			Rail.uncountedCopy[Double](bx.SendBuffer(bx.YP).v(),0,bufYP,0,size,()=>{flagRef()(bx.YP)=size;});
		}

		val iYM = bx.neighbors()(bx.YM);
		val bufYM = GlobalRail(bx.RecvBuffer(bx.YM).v());
		at (Place(iYM)) async {
			val size = bx.SendBuffer(bx.YM).size;
			MakeYMBnd(bx,w,u);

			Rail.uncountedCopy[Double](bx.SendBuffer(bx.YM).v(),0,bufYM,0,size,()=>{flagRef()(bx.YM)=size;});
		}

		val iZP = bx.neighbors()(bx.ZP);
		val bufZP = GlobalRail(bx.RecvBuffer(bx.ZP).v());
		at (Place(iZP)) async {
			val size = bx.SendBuffer(bx.ZP).size;
			MakeZPBnd(bx,w);

			Rail.uncountedCopy[Double](bx.SendBuffer(bx.ZP).v(),0,bufZP,0,size,()=>{flagRef()(bx.ZP)=size;});
		}

		val iZM = bx.neighbors()(bx.ZM);
		val bufZM = GlobalRail(bx.RecvBuffer(bx.ZM).v());
		at (Place(iZM)) async {
			val size = bx.SendBuffer(bx.ZM).size;
			MakeZMBnd(bx,w,u);

			Rail.uncountedCopy[Double](bx.SendBuffer(bx.ZM).v(),0,bufZM,0,size,()=>{flagRef()(bx.ZM)=size;});
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

//		Team.WORLD.barrier();
	}


	def DoprH(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double, bx : LatticeComm)
	{
		Dopr_Put(v,u,w,cks,bx);

		v.MultGamma5();
	}



}


