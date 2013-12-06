

import ThreadParallelLattice;
import WilsonVectorField;
import SU3MatrixField;
import HalfWilsonVectorField;


import LatticeComm;


import x10.compiler.Inline;

//debug
import x10.util.Team;

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








public class Dslash extends ThreadParallelLattice {

	val ht1 : HalfWilsonMult;
	val ht2 : HalfWilsonMult;

	def this(x : Long,y : Long,z : Long,t : Long, i : Long, n : Long)
	{
		super(x,y,z,t,i,n);
		ht1 = new HalfWilsonMult();
		ht2 = new HalfWilsonMult();
	}

	def MakeXPBnd(bx : LatticeComm, w : WilsonVectorField)
	{
		for(i in rngX){
			ht1.PackXP(w.v(),i*Nx);
			ht1.Store(bx.SendBuffer(bx.XP).v(),i);
		}
	}
	def MakeXMBnd(bx : LatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		for(i in rngX){
			ht1.PackXM(w.v(),i*Nx + Nx-1);
			ht2.MultUt(u.v(),offset_ux + i*Nx + Nx-1,ht1);
			ht2.Store(bx.SendBuffer(bx.XM).v(),i);
		}
	}

	def MakeYPBnd(bx : LatticeComm, w : WilsonVectorField)
	{
		for(i in rngYOut){
			for(j in rngYInBnd){
				ht1.PackYP(w.v(),i*Nxy + j);
				ht1.Store(bx.SendBuffer(bx.YP).v(),i*Nx + j);
			}
		}
	}
	def MakeYMBnd(bx : LatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		for(i in rngYOut){
			for(j in rngYInBnd){
				ht1.PackYM(w.v(),i*Nxy + Nxy-Nx + j);
				ht2.MultUt(u.v(),offset_uy + i*Nxy + Nxy-Nx + j,ht1);
				ht2.Store(bx.SendBuffer(bx.YM).v(),i*Nx + j);
			}
		}
	}

	def MakeZPBnd(bx : LatticeComm, w : WilsonVectorField)
	{
		for(i in rngZOut){
			for(j in rngZInBnd){
				ht1.PackZP(w.v(),i*Nxyz + j);
				ht1.Store(bx.SendBuffer(bx.ZP).v(),i*Nxy + j);
			}
		}
	}
	def MakeZMBnd(bx : LatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		for(i in rngZOut){
			for(j in rngZInBnd){
				ht1.PackZM(w.v(),i*Nxyz + Nxyz-Nxy + j);
				ht2.MultUt(u.v(),offset_uz + i*Nxyz + Nxyz-Nxy + j,ht1);
				ht2.Store(bx.SendBuffer(bx.ZM).v(),i*Nxy + j);
			}
		}
	}

	def MakeTPBnd(bx : LatticeComm, w : WilsonVectorField)
	{
		for(i in rngTBnd){
			ht1.PackTP(w.v(),i);
			ht1.Store(bx.SendBuffer(bx.TP).v(),i);
		}
	}
	def MakeTMBnd(bx : LatticeComm, w : WilsonVectorField, u : SU3MatrixField)
	{
		for(i in rngTBnd){
			ht1.PackTM(w.v(),nsite-Nxyz + i);
			ht2.MultUt(u.v(),offset_ut + nsite-Nxyz + i,ht1);
			ht2.Store(bx.SendBuffer(bx.TM).v(),i);
		}
	}

	def SetXPBnd(bx : LatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Double)
	{
		for(i in rngX){
			ht1.Load(bx.RecvBuffer(bx.XP).v(),i);
			ht2.MultU(u.v(),offset_ux + i*Nx + Nx - 1,ht1);
			ht2.UnpackXP(v.v(),i*Nx + Nx - 1,cks);
		}
	}
	def SetXMBnd(bx : LatticeComm, v : WilsonVectorField, cks : Double)
	{
		for(i in rngX){
			ht1.Load(bx.RecvBuffer(bx.XM).v(),i);
			ht1.UnpackXM(v.v(),i*Nx,cks);
		}
	}

	def SetYPBnd(bx : LatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Double)
	{
		for(i in rngYOut){
			for(j in rngYInBnd){
				ht1.Load(bx.RecvBuffer(bx.YP).v(),i*Nx + j);
				ht2.MultU(u.v(),offset_uy + i*Nxy + Nxy-Nx + j,ht1);
				ht2.UnpackYP(v.v(),i*Nxy + Nxy-Nx + j,cks);
			}
		}
	}
	def SetYMBnd(bx : LatticeComm, v : WilsonVectorField, cks : Double)
	{
		for(i in rngYOut){
			for(j in rngYInBnd){
				ht1.Load(bx.RecvBuffer(bx.YM).v(),i*Nx + j);
				ht1.UnpackYM(v.v(),i*Nxy + j,cks);
			}
		}
	}

	def SetZPBnd(bx : LatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Double)
	{
		for(i in rngZOut){
			for(j in rngZInBnd){
				ht1.Load(bx.RecvBuffer(bx.ZP).v(),i*Nxy + j);
				ht2.MultU(u.v(),offset_uz + i*Nxyz + Nxyz-Nxy + j,ht1);
				ht2.UnpackZP(v.v(),i*Nxyz + Nxyz-Nxy + j,cks);
			}
		}
	}
	def SetZMBnd(bx : LatticeComm, v : WilsonVectorField, cks : Double)
	{
		for(i in rngZOut){
			for(j in rngZInBnd){
				ht1.Load(bx.RecvBuffer(bx.ZM).v(),i*Nxy + j);
				ht1.UnpackZM(v.v(),i*Nxyz + j,cks);
			}
		}
	}

	def SetTPBnd(bx : LatticeComm, v : WilsonVectorField, u : SU3MatrixField, cks : Double)
	{
		for(i in rngTBnd){
			ht1.Load(bx.RecvBuffer(bx.TP).v(),i);
			ht2.MultU(u.v(),offset_ut + nsite-Nxyz + i,ht1);
			ht2.UnpackTP(v.v(),nsite-Nxyz + i,cks);
		}
	}
	def SetTMBnd(bx : LatticeComm, v : WilsonVectorField, cks : Double)
	{
		for(i in rngTBnd){
			ht1.Load(bx.RecvBuffer(bx.TM).v(),i);
			ht1.UnpackTM(v.v(),i,cks);
		}
	}


	def MultXP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		for(i in rngX){
			for(j in 0..(Nx-2)){
				ht1.PackXP(w.v(),i*Nx + j + 1);
				ht2.MultU(u.v(),offset_ux + i*Nx + j,ht1);
				ht2.UnpackXP(v.v(),i*Nx + j,cks);
			}
		}
	}
	def MultXM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		for(i in rngX){
			for(j in 1..(Nx-1)){
				ht1.PackXM(w.v(),i*Nx + j - 1);
				ht2.MultUt(u.v(),offset_ux + i*Nx + j - 1,ht1);
				ht2.UnpackXM(v.v(),i*Nx + j,cks);
			}
		}
	}

	def MultYP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		for(i in rngYOut){
			for(j in rngYIn){
				ht1.PackYP(w.v(),i*Nxy + j + Nx);
				ht2.MultU(u.v(),offset_uy + i*Nxy + j,ht1);
				ht2.UnpackYP(v.v(),i*Nxy + j,cks);
			}
		}
	}
	def MultYM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		for(i in rngYOut){
			for(j in rngYIn){
				ht1.PackYM(w.v(),i*Nxy + j);
				ht2.MultUt(u.v(),offset_uy + i*Nxy + j,ht1);
				ht2.UnpackYM(v.v(),i*Nxy + j + Nx,cks);
			}
		}
	}

	def MultZP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		for(i in rngZOut){
			for(j in rngZIn){
				ht1.PackZP(w.v(),i*Nxyz + j + Nxy);
				ht2.MultU(u.v(),offset_uz + i*Nxyz + j,ht1);
				ht2.UnpackZP(v.v(),i*Nxyz + j,cks);
			}
		}
	}
	def MultZM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		for(i in rngZOut){
			for(j in rngZIn){
				ht1.PackZM(w.v(),i*Nxyz + j);
				ht2.MultUt(u.v(),offset_uz + i*Nxyz + j,ht1);
				ht2.UnpackZM(v.v(),i*Nxyz + j + Nxy,cks);
			}
		}
	}

	def MultTP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		for(i in rngT){
			ht1.PackTP(w.v(),i + Nxyz);
			ht2.MultU(u.v(),offset_ut + i,ht1);
			ht2.UnpackTP(v.v(),i,cks);
		}
	}
	def MultTM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		for(i in rngT){
			ht1.PackTM(w.v(),i);
			ht2.MultUt(u.v(),offset_ut + i,ht1);
			ht2.UnpackTM(v.v(),i + Nxyz,cks);
		}
	}

	def Dopr(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double, bx : LatticeComm)
	{
	  //debug
	  // Console.OUT.println("yyy");
		Clock.advanceAll();
	  if(tid == 0) {
	    Team.WORLD.barrier();
	  }
	  
	  //debug
	  // Console.OUT.println("zzz");

		//finish is placed for asyncronous copy
		finish {
			//make boundary data
			MakeTPBnd(bx,w);
			Clock.advanceAll();
	  // Team.WORLD.barrier();

			if(tid == 0){
				bx.Send(bx.TP);
			}

			MakeTMBnd(bx,w,u);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			if(tid == 0){
				bx.Send(bx.TM);
			}

			MakeXPBnd(bx,w);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			if(tid == 0){
				bx.Send(bx.XP);
			}

			MakeXMBnd(bx,w,u);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			if(tid == 0){
				bx.Send(bx.XM);
			}

			MakeYPBnd(bx,w);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			if(tid == 0){
				bx.Send(bx.YP);
			}

			MakeYMBnd(bx,w,u);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			if(tid == 0){
				bx.Send(bx.YM);
			}

			MakeZPBnd(bx,w);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			if(tid == 0){
				bx.Send(bx.ZP);
			}

			MakeZMBnd(bx,w,u);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			if(tid == 0){
				bx.Send(bx.ZM);
			}

	  // Team.WORLD.barrier();
			v.Copy(w,rngLA);
		  Clock.advanceAll();
			//local calculations
			MultTP(v,u,w,-cks);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			MultTM(v,u,w,-cks);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			MultXP(v,u,w,-cks);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			MultXM(v,u,w,-cks);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			MultYP(v,u,w,-cks);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			MultYM(v,u,w,-cks);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			MultZP(v,u,w,-cks);
			Clock.advanceAll();
	  // Team.WORLD.barrier();
			MultZM(v,u,w,-cks);
			Clock.advanceAll();
		  //debug
		  // Console.OUT.println(here.id + ": xxx");

		  //debug
		  // Console.OUT.println(tid + ": x2");
		}
	  if(tid == 0) {
	    Team.WORLD.barrier();
	  }
		  //debug
		  // Console.OUT.println(here.id + ": yyy");


		//set boundary part
		SetTPBnd(bx,v,u,-cks);
		Clock.advanceAll();
	  // Team.WORLD.barrier();

		SetTMBnd(bx,v,-cks);
		Clock.advanceAll();
	  // Team.WORLD.barrier();

		SetXPBnd(bx,v,u,-cks);
		Clock.advanceAll();
	  // Team.WORLD.barrier();

		SetXMBnd(bx,v,-cks);
		Clock.advanceAll();
	  // Team.WORLD.barrier();

		SetYPBnd(bx,v,u,-cks);
		Clock.advanceAll();
	  // Team.WORLD.barrier();

		SetYMBnd(bx,v,-cks);
		Clock.advanceAll();
	  // Team.WORLD.barrier();

		SetZPBnd(bx,v,u,-cks);
		Clock.advanceAll();
	  // Team.WORLD.barrier();

		SetZMBnd(bx,v,-cks);
		Clock.advanceAll();
	  if(tid == 0) {
	    Team.WORLD.barrier();
	  }
	}

	def DoprH(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double, bx : LatticeComm)
	{
	  // Team.WORLD.barrier();
		Dopr(v,u,w,cks,bx);
	  // Team.WORLD.barrier();

		v.MultGamma5(rngLA);
	  // Team.WORLD.barrier();
		Clock.advanceAll();
	}
}


