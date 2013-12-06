
import x10.array.Array_1;

import x10.compiler.Inline;


public class HalfWilsonVector {
//	public val v = new Array_1[Double](12);
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

	@Inline def Set(t : Double)
	{
		h0_0r  = t;	h0_0i  = t;
		h0_1r  = t;	h0_1i  = t;
		h0_2r  = t;	h0_2i  = t;

		h1_0r  = t;	h1_0i  = t;
		h1_1r  = t;	h1_1i  = t;
		h1_2r = t;	h1_2i = t;
	}

	@Inline def Copy(w : HalfWilsonVector)
	{
		h0_0r  = w.h0_0r;		h0_0i  = w.h0_0i;
		h0_1r  = w.h0_1r;		h0_1i  = w.h0_1i;
		h0_2r  = w.h0_2r;		h0_2i  = w.h0_2i;

		h1_0r  = w.h1_0r;		h1_0i  = w.h1_0i;
		h1_1r  = w.h1_1r;		h1_1i  = w.h1_1i;
		h1_2r = w.h1_2r;	h1_2i = w.h1_2i;
	}

	@Inline def Load(w : Array_1[Double], iw : Long)
	{
		h0_0r  = w(iw*12+0);		h0_0i  = w(iw*12+1);
		h0_1r  = w(iw*12+2);		h0_1i  = w(iw*12+3);
		h0_2r  = w(iw*12+4);		h0_2i  = w(iw*12+5);

		h1_0r  = w(iw*12+6);		h1_0i  = w(iw*12+7);
		h1_1r  = w(iw*12+8);		h1_1i  = w(iw*12+9);
		h1_2r = w(iw*12+10);	h1_2i = w(iw*12+11);
	}

	@Inline def Store(w : Array_1[Double], iw : Long)
	{
		w(iw*12+0) = h0_0r;		w(iw*12+1) = h0_0i;
		w(iw*12+2) = h0_1r;		w(iw*12+3) = h0_1i;
		w(iw*12+4) = h0_2r;		w(iw*12+5) = h0_2i;

		w(iw*12+6) = h1_0r;		w(iw*12+7) = h1_0i;
		w(iw*12+8) = h1_1r;		w(iw*12+9) = h1_1i;
		w(iw*12+10)= h1_2r;		w(iw*12+11)= h1_2i;
	}
	

	@Inline def Add(w : HalfWilsonVector)
	{
		h0_0r  += w.h0_0r;		h0_0i  += w.h0_0i;
		h0_1r  += w.h0_1r;		h0_1i  += w.h0_1i;
		h0_2r  += w.h0_2r;		h0_2i  += w.h0_2i;

		h1_0r  += w.h1_0r;		h1_0i  += w.h1_0i;
		h1_1r  += w.h1_1r;		h1_1i  += w.h1_1i;
		h1_2r += w.h1_2r;		h1_2i += w.h1_2i;
	}

	@Inline def Sub(w : HalfWilsonVector)
	{
		h0_0r  -= w.h0_0r;		h0_0i  -= w.h0_0i;
		h0_1r  -= w.h0_1r;		h0_1i  -= w.h0_1i;
		h0_2r  -= w.h0_2r;		h0_2i  -= w.h0_2i;

		h1_0r  -= w.h1_0r;		h1_0i  -= w.h1_0i;
		h1_1r  -= w.h1_1r;		h1_1i  -= w.h1_1i;
		h1_2r -= w.h1_2r;		h1_2i -= w.h1_2i;
	}

	@Inline def MultAdd(a : Double, w : HalfWilsonVector)
	{
		h0_0r  += a*w.h0_0r;		h0_0i  += a*w.h0_0i;
		h0_1r  += a*w.h0_1r;		h0_1i  += a*w.h0_1i;
		h0_2r  += a*w.h0_2r;		h0_2i  += a*w.h0_2i;

		h1_0r  += a*w.h1_0r;		h1_0i  += a*w.h1_0i;
		h1_1r  += a*w.h1_1r;		h1_1i  += a*w.h1_1i;
		h1_2r += a*w.h1_2r;		h1_2i += a*w.h1_2i;
	}

	@Inline def Mult(a : Double)
	{
		h0_0r  = a*h0_0r;		h0_0i  = a*h0_0i;
		h0_1r  = a*h0_1r;		h0_1i  = a*h0_1i;
		h0_2r  = a*h0_2r;		h0_2i  = a*h0_2i;

		h1_0r  = a*h1_0r;		h1_0i  = a*h1_0i;
		h1_1r  = a*h1_1r;		h1_1i  = a*h1_1i;
		h1_2r = a*h1_2r;	h1_2i = a*h1_2i;
	}


	@Inline def PackXP(w : Array_1[Double], iw : Long)
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

	@Inline def PackXM(w : Array_1[Double], iw : Long)
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

	@Inline def PackYP(w : Array_1[Double], iw : Long)
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

	@Inline def PackYM(w : Array_1[Double], iw : Long)
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
	
	@Inline def PackZP(w : Array_1[Double], iw : Long)
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

	@Inline def PackZM(w : Array_1[Double], iw : Long)
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
	@Inline def PackTP(w : Array_1[Double], iw : Long)
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
	@Inline def PackTM(w : Array_1[Double], iw : Long)
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

	@Inline def MultU(u : Array_1[Double],iu : Long, h : HalfWilsonVector)
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

	@Inline def MultUt(u : Array_1[Double],iu : Long, h : HalfWilsonVector)
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

	@Inline def UnpackXP(w : Array_1[Double], iw : Long, cks : Double)
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

	@Inline def UnpackXM(w : Array_1[Double], iw : Long, cks : Double)
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

	@Inline def UnpackYP(w : Array_1[Double], iw : Long, cks : Double)
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

	@Inline def UnpackYM(w : Array_1[Double], iw : Long, cks : Double)
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

	@Inline def UnpackZP(w : Array_1[Double], iw : Long, cks : Double)
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

	@Inline def UnpackZM(w : Array_1[Double], iw : Long, cks : Double)
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
	@Inline def UnpackTP(w : Array_1[Double], iw : Long, cks : Double)
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
	@Inline def UnpackTM(w : Array_1[Double], iw : Long, cks : Double)
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





