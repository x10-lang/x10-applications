
import x10.compiler.Inline;

import x10.array.*;

public class DistHalfWilsonVector {
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

	@Inline def Store(v : DistArray_Block_1[Double], iw : Long)
	{
		val pos = v.localIndices().min(0) + iw*12;

		v(pos+0) = h0_0r;	v(pos+1) = h0_0i;
		v(pos+2) = h0_1r;	v(pos+3) = h0_1i;
		v(pos+4) = h0_2r;	v(pos+5) = h0_2i;

		v(pos+6) = h1_0r;	v(pos+7) = h1_0i;
		v(pos+8) = h1_1r;	v(pos+9) = h1_1i;
		v(pos+10)= h1_2r;	v(pos+11)= h1_2i;
	}

	@Inline def Load(v : DistArray_Block_1[Double], iw : Long)
	{
		val pos = v.localIndices().min(0) + iw*12;

		h0_0r = v(pos+0);	h0_0i = v(pos+1);
		h0_1r = v(pos+2);	h0_1i = v(pos+3);
		h0_2r = v(pos+4);	h0_2i = v(pos+5);

		h1_0r = v(pos+6);	h1_0i = v(pos+7);
		h1_1r = v(pos+8);	h1_1i = v(pos+9);
		h1_2r = v(pos+10);	h1_2i = v(pos+11);
	}


	@Inline def PackXP(v : DistArray_Block_1[Double], iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iw*24;

		//h0 = w0 + i*w3
		h0_0r = v(pos+0) - v(pos+19);		h0_0i = v(pos+1) + v(pos+18);
		h0_1r = v(pos+2) - v(pos+21);		h0_1i = v(pos+3) + v(pos+20);
		h0_2r = v(pos+4) - v(pos+23);		h0_2i = v(pos+5) + v(pos+22);

		//h1 = w1 + i*w2
		h1_0r = v(pos+6) - v(pos+13);		h1_0i = v(pos+7) + v(pos+12);
		h1_1r = v(pos+8) - v(pos+15);		h1_1i = v(pos+9) + v(pos+14);
		h1_2r = v(pos+10)- v(pos+17);		h1_2i = v(pos+11)+ v(pos+16);

		return this;
	}

	@Inline def PackXM(v : DistArray_Block_1[Double], iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iw*24;

		//h0 = w0 - i*w3
		h0_0r = v(pos+0) + v(pos+19);		h0_0i = v(pos+1) - v(pos+18);
		h0_1r = v(pos+2) + v(pos+21);		h0_1i = v(pos+3) - v(pos+20);
		h0_2r = v(pos+4) + v(pos+23);		h0_2i = v(pos+5) - v(pos+22);

		//h1 = w1 - i*w2
		h1_0r = v(pos+6) + v(pos+13);		h1_0i = v(pos+7) - v(pos+12);
		h1_1r = v(pos+8) + v(pos+15);		h1_1i = v(pos+9) - v(pos+14);
		h1_2r= v(pos+10)+ v(pos+17);		h1_2i= v(pos+11)- v(pos+16);

		return this;
	}

	@Inline def PackYP(v : DistArray_Block_1[Double], iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iw*24;
		//h0 = w0 + w3
		h0_0r = v(pos+0) + v(pos+18);		h0_0i = v(pos+1) + v(pos+19);
		h0_1r = v(pos+2) + v(pos+20);		h0_1i = v(pos+3) + v(pos+21);
		h0_2r = v(pos+4) + v(pos+22);		h0_2i = v(pos+5) + v(pos+23);

		//h1 = w1 - w2
		h1_0r = v(pos+6) - v(pos+12);		h1_0i = v(pos+7) - v(pos+13);
		h1_1r = v(pos+8) - v(pos+14);		h1_1i = v(pos+9) - v(pos+15);
		h1_2r= v(pos+10)- v(pos+16);		h1_2i= v(pos+11)- v(pos+17);

		return this;
	}

	@Inline def PackYM(v : DistArray_Block_1[Double], iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iw*24;
		//h0 = w0 - w3
		h0_0r = v(pos+0) - v(pos+18);		h0_0i = v(pos+1) - v(pos+19);
		h0_1r = v(pos+2) - v(pos+20);		h0_1i = v(pos+3) - v(pos+21);
		h0_2r = v(pos+4) - v(pos+22);		h0_2i = v(pos+5) - v(pos+23);

		//h1 = w1 + w2
		h1_0r = v(pos+6) + v(pos+12);		h1_0i = v(pos+7) + v(pos+13);
		h1_1r = v(pos+8) + v(pos+14);		h1_1i = v(pos+9) + v(pos+15);
		h1_2r= v(pos+10)+ v(pos+16);		h1_2i= v(pos+11)+ v(pos+17);

		return this;
	}

	@Inline def PackZP(v : DistArray_Block_1[Double], iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iw*24;
		//h0 = w0 + i*w2
		h0_0r = v(pos+0) - v(pos+13);		h0_0i = v(pos+1) + v(pos+12);
		h0_1r = v(pos+2) - v(pos+15);		h0_1i = v(pos+3) + v(pos+14);
		h0_2r = v(pos+4) - v(pos+17);		h0_2i = v(pos+5) + v(pos+16);

		//h1 = w1 - i*w3
		h1_0r = v(pos+6) + v(pos+19);		h1_0i = v(pos+7) - v(pos+18);
		h1_1r = v(pos+8) + v(pos+21);		h1_1i = v(pos+9) - v(pos+20);
		h1_2r= v(pos+10)+ v(pos+23);		h1_2i= v(pos+11)- v(pos+22);

		return this;
	}

	@Inline def PackZM(v : DistArray_Block_1[Double], iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iw*24;
		//h0 = w0 - i*w3
		h0_0r = v(pos+0) + v(pos+13);		h0_0i = v(pos+1) - v(pos+12);
		h0_1r = v(pos+2) + v(pos+15);		h0_1i = v(pos+3) - v(pos+14);
		h0_2r = v(pos+4) + v(pos+17);		h0_2i = v(pos+5) - v(pos+16);

		//h1 = w1 + i*w2
		h1_0r = v(pos+6) - v(pos+19);		h1_0i = v(pos+7) + v(pos+18);
		h1_1r = v(pos+8) - v(pos+21);		h1_1i = v(pos+9) + v(pos+20);
		h1_2r= v(pos+10)- v(pos+23);		h1_2i= v(pos+11)+ v(pos+22);

		return this;
	}


	//Dirac representation
	@Inline def PackTP(v : DistArray_Block_1[Double], iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iw*24;
		//h0 = 2.0*w2
		h0_0r = 2.0*v(pos+12);		h0_0i = 2.0*v(pos+13);
		h0_1r = 2.0*v(pos+14);		h0_1i = 2.0*v(pos+15);
		h0_2r = 2.0*v(pos+16);		h0_2i = 2.0*v(pos+17);

		//h1 = 2.0*w3
		h1_0r = 2.0*v(pos+18);		h1_0i = 2.0*v(pos+19);
		h1_1r = 2.0*v(pos+20);		h1_1i = 2.0*v(pos+21);
		h1_2r= 2.0*v(pos+22);		h1_2i= 2.0*v(pos+23);

		return this;
	}

	//Dirac representation
	@Inline def PackTM(v : DistArray_Block_1[Double], iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iw*24;
		//h0 = 2.0*w0
		h0_0r = 2.0*v(pos+0);		h0_0i = 2.0*v(pos+1);
		h0_1r = 2.0*v(pos+2);		h0_1i = 2.0*v(pos+3);
		h0_2r = 2.0*v(pos+4);		h0_2i = 2.0*v(pos+5);

		//h1 = 2.0*w1
		h1_0r = 2.0*v(pos+6);		h1_0i = 2.0*v(pos+7);
		h1_1r = 2.0*v(pos+8);		h1_1i = 2.0*v(pos+9);
		h1_2r= 2.0*v(pos+10);		h1_2i= 2.0*v(pos+11);

		return this;
	}


	@Inline def UnpackXP(v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		val pos = v.localIndices().min(0) + iw*24;

		v(pos+0) += cks*h0_0r;			v(pos+1) += cks*h0_0i;
		v(pos+2) += cks*h0_1r;			v(pos+3) += cks*h0_1i;
		v(pos+4) += cks*h0_2r;			v(pos+5) += cks*h0_2i;

		v(pos+6) += cks*h1_0r;			v(pos+7) += cks*h1_0i;
		v(pos+8) += cks*h1_1r;			v(pos+9) += cks*h1_1i;
		v(pos+10)+= cks*h1_2r;			v(pos+11)+= cks*h1_2i;

		//w3 += -i*h1
		v(pos+12) += cks*h1_0i;		v(pos+13) -= cks*h1_0r;
		v(pos+14) += cks*h1_1i;		v(pos+15) -= cks*h1_1r;
		v(pos+16) += cks*h1_2i;		v(pos+17) -= cks*h1_2r;

		//w4 += -i*h0
		v(pos+18) += cks*h0_0i;		v(pos+19) -= cks*h0_0r;
		v(pos+20) += cks*h0_1i;		v(pos+21) -= cks*h0_1r;
		v(pos+22) += cks*h0_2i;		v(pos+23) -= cks*h0_2r;
	}

	@Inline def UnpackXM(v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		val pos = v.localIndices().min(0) + iw*24;
		v(pos+0) += cks*h0_0r;			v(pos+1) += cks*h0_0i;
		v(pos+2) += cks*h0_1r;			v(pos+3) += cks*h0_1i;
		v(pos+4) += cks*h0_2r;			v(pos+5) += cks*h0_2i;

		v(pos+6) += cks*h1_0r;			v(pos+7) += cks*h1_0i;
		v(pos+8) += cks*h1_1r;			v(pos+9) += cks*h1_1i;
		v(pos+10)+= cks*h1_2r;		v(pos+11)+= cks*h1_2i;

		//w3 += i*h1
		v(pos+12) -= cks*h1_0i;		v(pos+13) += cks*h1_0r;
		v(pos+14) -= cks*h1_1i;		v(pos+15) += cks*h1_1r;
		v(pos+16) -= cks*h1_2i;		v(pos+17) += cks*h1_2r;

		//w4 += i*h0
		v(pos+18) -= cks*h0_0i;		v(pos+19) += cks*h0_0r;
		v(pos+20) -= cks*h0_1i;		v(pos+21) += cks*h0_1r;
		v(pos+22) -= cks*h0_2i;		v(pos+23) += cks*h0_2r;
	}

	@Inline def UnpackYP(v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		val pos = v.localIndices().min(0) + iw*24;
		v(pos+0) += cks*h0_0r;			v(pos+1) += cks*h0_0i;
		v(pos+2) += cks*h0_1r;			v(pos+3) += cks*h0_1i;
		v(pos+4) += cks*h0_2r;			v(pos+5) += cks*h0_2i;

		v(pos+6) += cks*h1_0r;			v(pos+7) += cks*h1_0i;
		v(pos+8) += cks*h1_1r;			v(pos+9) += cks*h1_1i;
		v(pos+10)+= cks*h1_2r;		v(pos+11)+= cks*h1_2i;

		//w3 += -h1
		v(pos+12) -= cks*h1_0r;		v(pos+13) -= cks*h1_0i;
		v(pos+14) -= cks*h1_1r;		v(pos+15) -= cks*h1_1i;
		v(pos+16) -= cks*h1_2r;		v(pos+17) -= cks*h1_2i;

		//w4 += cks*h0
		v(pos+18) += cks*h0_0r;		v(pos+19) += cks*h0_0i;
		v(pos+20) += cks*h0_1r;		v(pos+21) += cks*h0_1i;
		v(pos+22) += cks*h0_2r;		v(pos+23) += cks*h0_2i;
	}

	@Inline def UnpackYM(v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		val pos = v.localIndices().min(0) + iw*24;
		v(pos+0) += cks*h0_0r;			v(pos+1) += cks*h0_0i;
		v(pos+2) += cks*h0_1r;			v(pos+3) += cks*h0_1i;
		v(pos+4) += cks*h0_2r;			v(pos+5) += cks*h0_2i;

		v(pos+6) += cks*h1_0r;			v(pos+7) += cks*h1_0i;
		v(pos+8) += cks*h1_1r;			v(pos+9) += cks*h1_1i;
		v(pos+10)+= cks*h1_2r;		v(pos+11)+= cks*h1_2i;

		//w3 += cks*h1
		v(pos+12) += cks*h1_0r;		v(pos+13) += cks*h1_0i;
		v(pos+14) += cks*h1_1r;		v(pos+15) += cks*h1_1i;
		v(pos+16) += cks*h1_2r;		v(pos+17) += cks*h1_2i;

		//w4 += -h0
		v(pos+18) -= cks*h0_0r;		v(pos+19) -= cks*h0_0i;
		v(pos+20) -= cks*h0_1r;		v(pos+21) -= cks*h0_1i;
		v(pos+22) -= cks*h0_2r;		v(pos+23) -= cks*h0_2i;
	}

	@Inline def UnpackZP(v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		val pos = v.localIndices().min(0) + iw*24;
		v(pos+0) += cks*h0_0r;			v(pos+1) += cks*h0_0i;
		v(pos+2) += cks*h0_1r;			v(pos+3) += cks*h0_1i;
		v(pos+4) += cks*h0_2r;			v(pos+5) += cks*h0_2i;

		v(pos+6) += cks*h1_0r;			v(pos+7) += cks*h1_0i;
		v(pos+8) += cks*h1_1r;			v(pos+9) += cks*h1_1i;
		v(pos+10)+= cks*h1_2r;			v(pos+11)+= cks*h1_2i;

		//w3 += -i*h0
		v(pos+12) += cks*h0_0i;		v(pos+13) -= cks*h0_0r;
		v(pos+14) += cks*h0_1i;		v(pos+15) -= cks*h0_1r;
		v(pos+16) += cks*h0_2i;		v(pos+17) -= cks*h0_2r;

		//w4 += i*h1
		v(pos+18) -= cks*h1_0i;		v(pos+19) += cks*h1_0r;
		v(pos+20) -= cks*h1_1i;		v(pos+21) += cks*h1_1r;
		v(pos+22) -= cks*h1_2i;		v(pos+23) += cks*h1_2r;
	}

	@Inline def UnpackZM(v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		val pos = v.localIndices().min(0) + iw*24;
		v(pos+0) += cks*h0_0r;			v(pos+1) += cks*h0_0i;
		v(pos+2) += cks*h0_1r;			v(pos+3) += cks*h0_1i;
		v(pos+4) += cks*h0_2r;			v(pos+5) += cks*h0_2i;

		v(pos+6) += cks*h1_0r;			v(pos+7) += cks*h1_0i;
		v(pos+8) += cks*h1_1r;			v(pos+9) += cks*h1_1i;
		v(pos+10)+= cks*h1_2r;			v(pos+11)+= cks*h1_2i;

		//w3 += i*h0
		v(pos+12) -= cks*h0_0i;		v(pos+13) += cks*h0_0r;
		v(pos+14) -= cks*h0_1i;		v(pos+15) += cks*h0_1r;
		v(pos+16) -= cks*h0_2i;		v(pos+17) += cks*h0_2r;

		//w4 += -i*h1
		v(pos+18) += cks*h1_0i;		v(pos+19) -= cks*h1_0r;
		v(pos+20) += cks*h1_1i;		v(pos+21) -= cks*h1_1r;
		v(pos+22) += cks*h1_2i;		v(pos+23) -= cks*h1_2r;
	}

	//Dirac representation
	@Inline def UnpackTP(v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		val pos = v.localIndices().min(0) + iw*24;
		v(pos+12) += cks*h0_0r;		v(pos+13) += cks*h0_0i;
		v(pos+14) += cks*h0_1r;		v(pos+15) += cks*h0_1i;
		v(pos+16) += cks*h0_2r;		v(pos+17) += cks*h0_2i;

		v(pos+18) += cks*h1_0r;		v(pos+19) += cks*h1_0i;
		v(pos+20) += cks*h1_1r;		v(pos+21) += cks*h1_1i;
		v(pos+22) += cks*h1_2r;		v(pos+23) += cks*h1_2i;
	}

	//Dirac representation
	@Inline def UnpackTM(v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		val pos = v.localIndices().min(0) + iw*24;
		v(pos+0) += cks*h0_0r;			v(pos+1) += cks*h0_0i;
		v(pos+2) += cks*h0_1r;			v(pos+3) += cks*h0_1i;
		v(pos+4) += cks*h0_2r;			v(pos+5) += cks*h0_2i;

		v(pos+6) += cks*h1_0r;			v(pos+7) += cks*h1_0i;
		v(pos+8) += cks*h1_1r;			v(pos+9) += cks*h1_1i;
		v(pos+10)+= cks*h1_2r;			v(pos+11)+= cks*h1_2i;
	}
	@Inline def UnpackTMAt(p : Place, v : DistArray_Block_1[Double], iw : Long, cks : Double)
	{
		at(p){
			val pos = v.localIndices().min(0) + iw*24;
			v(pos+0) += cks*h0_0r;			v(pos+1) += cks*h0_0i;
			v(pos+2) += cks*h0_1r;			v(pos+3) += cks*h0_1i;
			v(pos+4) += cks*h0_2r;			v(pos+5) += cks*h0_2i;

			v(pos+6) += cks*h1_0r;			v(pos+7) += cks*h1_0i;
			v(pos+8) += cks*h1_1r;			v(pos+9) += cks*h1_1i;
			v(pos+10)+= cks*h1_2r;			v(pos+11)+= cks*h1_2i;
		}
	}


	@Inline def Mult(v : DistArray_Block_1[Double], wIn : DistHalfWilsonVector, iu : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iu*18;
		h0_0r = 	v(pos+0)*wIn.h0_0r - v(pos+1)*wIn.h0_0i + 
						v(pos+2)*wIn.h0_1r - v(pos+3)*wIn.h0_1i + 
						v(pos+4)*wIn.h0_2r - v(pos+5)*wIn.h0_2i;
		h0_0i = 	v(pos+0)*wIn.h0_0i + v(pos+1)*wIn.h0_0r + 
						v(pos+2)*wIn.h0_1i + v(pos+3)*wIn.h0_1r + 
						v(pos+4)*wIn.h0_2i + v(pos+5)*wIn.h0_2r;

		h1_0r = 	v(pos+0)*wIn.h1_0r - v(pos+1)*wIn.h1_0i + 
						v(pos+2)*wIn.h1_1r - v(pos+3)*wIn.h1_1i + 
						v(pos+4)*wIn.h1_2r- v(pos+5)*wIn.h1_2i;
		h1_0i = 	v(pos+0)*wIn.h1_0i + v(pos+1)*wIn.h1_0r + 
						v(pos+2)*wIn.h1_1i + v(pos+3)*wIn.h1_1r + 
						v(pos+4)*wIn.h1_2i+ v(pos+5)*wIn.h1_2r;

		h0_1r = 	v(pos+6) *wIn.h0_0r - v(pos+7) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r - v(pos+9) *wIn.h0_1i + 
						v(pos+10)*wIn.h0_2r - v(pos+11)*wIn.h0_2i;
		h0_1i = 	v(pos+6) *wIn.h0_0i + v(pos+7) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i + v(pos+9) *wIn.h0_1r + 
						v(pos+10)*wIn.h0_2i + v(pos+11)*wIn.h0_2r;

		h1_1r = 	v(pos+6) *wIn.h1_0r - v(pos+7) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r - v(pos+9) *wIn.h1_1i + 
						v(pos+10)*wIn.h1_2r- v(pos+11)*wIn.h1_2i;
		h1_1i = 	v(pos+6) *wIn.h1_0i + v(pos+7) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i + v(pos+9) *wIn.h1_1r + 
						v(pos+10)*wIn.h1_2i+ v(pos+11)*wIn.h1_2r;

		h0_2r = 	v(pos+12)*wIn.h0_0r - v(pos+13)*wIn.h0_0i + 
						v(pos+14)*wIn.h0_1r - v(pos+15)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r - v(pos+17)*wIn.h0_2i;
		h0_2i = 	v(pos+12)*wIn.h0_0i + v(pos+13)*wIn.h0_0r + 
						v(pos+14)*wIn.h0_1i + v(pos+15)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i + v(pos+17)*wIn.h0_2r;

		h1_2r= 	v(pos+12)*wIn.h1_0r - v(pos+13)*wIn.h1_0i + 
						v(pos+14)*wIn.h1_1r - v(pos+15)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r- v(pos+17)*wIn.h1_2i;
		h1_2i= 	v(pos+12)*wIn.h1_0i + v(pos+13)*wIn.h1_0r + 
						v(pos+14)*wIn.h1_1i + v(pos+15)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i+ v(pos+17)*wIn.h1_2r;

		return this;
	}


	@Inline def MultD(v : DistArray_Block_1[Double], wIn : DistHalfWilsonVector, iu : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iu*18;
		h0_0r = 	v(pos+0) *wIn.h0_0r + v(pos+1) *wIn.h0_0i + 
						v(pos+6) *wIn.h0_1r + v(pos+7) *wIn.h0_1i + 
						v(pos+12)*wIn.h0_2r + v(pos+13)*wIn.h0_2i;
		h0_0i = 	v(pos+0) *wIn.h0_0i - v(pos+1) *wIn.h0_0r + 
						v(pos+6) *wIn.h0_1i - v(pos+7) *wIn.h0_1r + 
						v(pos+12)*wIn.h0_2i - v(pos+13)*wIn.h0_2r;

		h1_0r = 	v(pos+0) *wIn.h1_0r + v(pos+1) *wIn.h1_0i + 
						v(pos+6) *wIn.h1_1r + v(pos+7) *wIn.h1_1i + 
						v(pos+12)*wIn.h1_2r+ v(pos+13)*wIn.h1_2i;
		h1_0i = 	v(pos+0) *wIn.h1_0i - v(pos+1) *wIn.h1_0r + 
						v(pos+6) *wIn.h1_1i - v(pos+7) *wIn.h1_1r + 
						v(pos+12)*wIn.h1_2i- v(pos+13)*wIn.h1_2r;

		h0_1r = 	v(pos+2) *wIn.h0_0r + v(pos+3) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r + v(pos+9) *wIn.h0_1i + 
						v(pos+14)*wIn.h0_2r + v(pos+15)*wIn.h0_2i;
		h0_1i = 	v(pos+2) *wIn.h0_0i - v(pos+3) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i - v(pos+9) *wIn.h0_1r + 
						v(pos+14)*wIn.h0_2i - v(pos+15)*wIn.h0_2r;

		h1_1r = 	v(pos+2) *wIn.h1_0r + v(pos+3) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r + v(pos+9) *wIn.h1_1i + 
						v(pos+14)*wIn.h1_2r+ v(pos+15)*wIn.h1_2i;
		h1_1i = 	v(pos+2) *wIn.h1_0i - v(pos+3) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i - v(pos+9) *wIn.h1_1r + 
						v(pos+14)*wIn.h1_2i- v(pos+15)*wIn.h1_2r;

		h0_2r = 	v(pos+4) *wIn.h0_0r + v(pos+5) *wIn.h0_0i + 
						v(pos+10)*wIn.h0_1r + v(pos+11)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r + v(pos+17)*wIn.h0_2i;
		h0_2i = 	v(pos+4) *wIn.h0_0i - v(pos+5) *wIn.h0_0r + 
						v(pos+10)*wIn.h0_1i - v(pos+11)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i - v(pos+17)*wIn.h0_2r;

		h1_2r= 	v(pos+4) *wIn.h1_0r + v(pos+5) *wIn.h1_0i + 
						v(pos+10)*wIn.h1_1r + v(pos+11)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r+ v(pos+17)*wIn.h1_2i;
		h1_2i= 	v(pos+4) *wIn.h1_0i - v(pos+5) *wIn.h1_0r + 
						v(pos+10)*wIn.h1_1i - v(pos+11)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i- v(pos+17)*wIn.h1_2r;

		return this;
	}


	@Inline def PackXMultD(v : DistArray_Block_1[Double],w : DistArray_Block_1[Double], iu : Long, iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iu*18;
		val wIn = new DistHalfWilsonVector();
		wIn.PackXM(w,iw);

		h0_0r = 	v(pos+0) *wIn.h0_0r + v(pos+1) *wIn.h0_0i + 
						v(pos+6) *wIn.h0_1r + v(pos+7) *wIn.h0_1i + 
						v(pos+12)*wIn.h0_2r + v(pos+13)*wIn.h0_2i;
		h0_0i = 	v(pos+0) *wIn.h0_0i - v(pos+1) *wIn.h0_0r + 
						v(pos+6) *wIn.h0_1i - v(pos+7) *wIn.h0_1r + 
						v(pos+12)*wIn.h0_2i - v(pos+13)*wIn.h0_2r;

		h1_0r = 	v(pos+0) *wIn.h1_0r + v(pos+1) *wIn.h1_0i + 
						v(pos+6) *wIn.h1_1r + v(pos+7) *wIn.h1_1i + 
						v(pos+12)*wIn.h1_2r+ v(pos+13)*wIn.h1_2i;
		h1_0i = 	v(pos+0) *wIn.h1_0i - v(pos+1) *wIn.h1_0r + 
						v(pos+6) *wIn.h1_1i - v(pos+7) *wIn.h1_1r + 
						v(pos+12)*wIn.h1_2i- v(pos+13)*wIn.h1_2r;

		h0_1r = 	v(pos+2) *wIn.h0_0r + v(pos+3) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r + v(pos+9) *wIn.h0_1i + 
						v(pos+14)*wIn.h0_2r + v(pos+15)*wIn.h0_2i;
		h0_1i = 	v(pos+2) *wIn.h0_0i - v(pos+3) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i - v(pos+9) *wIn.h0_1r + 
						v(pos+14)*wIn.h0_2i - v(pos+15)*wIn.h0_2r;

		h1_1r = 	v(pos+2) *wIn.h1_0r + v(pos+3) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r + v(pos+9) *wIn.h1_1i + 
						v(pos+14)*wIn.h1_2r+ v(pos+15)*wIn.h1_2i;
		h1_1i = 	v(pos+2) *wIn.h1_0i - v(pos+3) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i - v(pos+9) *wIn.h1_1r + 
						v(pos+14)*wIn.h1_2i- v(pos+15)*wIn.h1_2r;

		h0_2r = 	v(pos+4) *wIn.h0_0r + v(pos+5) *wIn.h0_0i + 
						v(pos+10)*wIn.h0_1r + v(pos+11)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r + v(pos+17)*wIn.h0_2i;
		h0_2i = 	v(pos+4) *wIn.h0_0i - v(pos+5) *wIn.h0_0r + 
						v(pos+10)*wIn.h0_1i - v(pos+11)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i - v(pos+17)*wIn.h0_2r;

		h1_2r= 	v(pos+4) *wIn.h1_0r + v(pos+5) *wIn.h1_0i + 
						v(pos+10)*wIn.h1_1r + v(pos+11)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r+ v(pos+17)*wIn.h1_2i;
		h1_2i= 	v(pos+4) *wIn.h1_0i - v(pos+5) *wIn.h1_0r + 
						v(pos+10)*wIn.h1_1i - v(pos+11)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i- v(pos+17)*wIn.h1_2r;
		return this;
	}

	@Inline def PackYMultD(v : DistArray_Block_1[Double],w : DistArray_Block_1[Double], iu : Long, iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iu*18;
		val wIn = new DistHalfWilsonVector();
		wIn.PackYM(w,iw);

		h0_0r = 	v(pos+0) *wIn.h0_0r + v(pos+1) *wIn.h0_0i + 
						v(pos+6) *wIn.h0_1r + v(pos+7) *wIn.h0_1i + 
						v(pos+12)*wIn.h0_2r + v(pos+13)*wIn.h0_2i;
		h0_0i = 	v(pos+0) *wIn.h0_0i - v(pos+1) *wIn.h0_0r + 
						v(pos+6) *wIn.h0_1i - v(pos+7) *wIn.h0_1r + 
						v(pos+12)*wIn.h0_2i - v(pos+13)*wIn.h0_2r;

		h1_0r = 	v(pos+0) *wIn.h1_0r + v(pos+1) *wIn.h1_0i + 
						v(pos+6) *wIn.h1_1r + v(pos+7) *wIn.h1_1i + 
						v(pos+12)*wIn.h1_2r+ v(pos+13)*wIn.h1_2i;
		h1_0i = 	v(pos+0) *wIn.h1_0i - v(pos+1) *wIn.h1_0r + 
						v(pos+6) *wIn.h1_1i - v(pos+7) *wIn.h1_1r + 
						v(pos+12)*wIn.h1_2i- v(pos+13)*wIn.h1_2r;

		h0_1r = 	v(pos+2) *wIn.h0_0r + v(pos+3) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r + v(pos+9) *wIn.h0_1i + 
						v(pos+14)*wIn.h0_2r + v(pos+15)*wIn.h0_2i;
		h0_1i = 	v(pos+2) *wIn.h0_0i - v(pos+3) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i - v(pos+9) *wIn.h0_1r + 
						v(pos+14)*wIn.h0_2i - v(pos+15)*wIn.h0_2r;

		h1_1r = 	v(pos+2) *wIn.h1_0r + v(pos+3) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r + v(pos+9) *wIn.h1_1i + 
						v(pos+14)*wIn.h1_2r+ v(pos+15)*wIn.h1_2i;
		h1_1i = 	v(pos+2) *wIn.h1_0i - v(pos+3) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i - v(pos+9) *wIn.h1_1r + 
						v(pos+14)*wIn.h1_2i- v(pos+15)*wIn.h1_2r;

		h0_2r = 	v(pos+4) *wIn.h0_0r + v(pos+5) *wIn.h0_0i + 
						v(pos+10)*wIn.h0_1r + v(pos+11)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r + v(pos+17)*wIn.h0_2i;
		h0_2i = 	v(pos+4) *wIn.h0_0i - v(pos+5) *wIn.h0_0r + 
						v(pos+10)*wIn.h0_1i - v(pos+11)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i - v(pos+17)*wIn.h0_2r;

		h1_2r= 	v(pos+4) *wIn.h1_0r + v(pos+5) *wIn.h1_0i + 
						v(pos+10)*wIn.h1_1r + v(pos+11)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r+ v(pos+17)*wIn.h1_2i;
		h1_2i= 	v(pos+4) *wIn.h1_0i - v(pos+5) *wIn.h1_0r + 
						v(pos+10)*wIn.h1_1i - v(pos+11)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i- v(pos+17)*wIn.h1_2r;
		return this;
	}

	@Inline def PackZMultD(v : DistArray_Block_1[Double],w : DistArray_Block_1[Double], iu : Long, iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iu*18;
		val wIn = new DistHalfWilsonVector();
		wIn.PackZM(w,iw);

		h0_0r = 	v(pos+0) *wIn.h0_0r + v(pos+1) *wIn.h0_0i + 
						v(pos+6) *wIn.h0_1r + v(pos+7) *wIn.h0_1i + 
						v(pos+12)*wIn.h0_2r + v(pos+13)*wIn.h0_2i;
		h0_0i = 	v(pos+0) *wIn.h0_0i - v(pos+1) *wIn.h0_0r + 
						v(pos+6) *wIn.h0_1i - v(pos+7) *wIn.h0_1r + 
						v(pos+12)*wIn.h0_2i - v(pos+13)*wIn.h0_2r;

		h1_0r = 	v(pos+0) *wIn.h1_0r + v(pos+1) *wIn.h1_0i + 
						v(pos+6) *wIn.h1_1r + v(pos+7) *wIn.h1_1i + 
						v(pos+12)*wIn.h1_2r+ v(pos+13)*wIn.h1_2i;
		h1_0i = 	v(pos+0) *wIn.h1_0i - v(pos+1) *wIn.h1_0r + 
						v(pos+6) *wIn.h1_1i - v(pos+7) *wIn.h1_1r + 
						v(pos+12)*wIn.h1_2i- v(pos+13)*wIn.h1_2r;

		h0_1r = 	v(pos+2) *wIn.h0_0r + v(pos+3) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r + v(pos+9) *wIn.h0_1i + 
						v(pos+14)*wIn.h0_2r + v(pos+15)*wIn.h0_2i;
		h0_1i = 	v(pos+2) *wIn.h0_0i - v(pos+3) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i - v(pos+9) *wIn.h0_1r + 
						v(pos+14)*wIn.h0_2i - v(pos+15)*wIn.h0_2r;

		h1_1r = 	v(pos+2) *wIn.h1_0r + v(pos+3) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r + v(pos+9) *wIn.h1_1i + 
						v(pos+14)*wIn.h1_2r+ v(pos+15)*wIn.h1_2i;
		h1_1i = 	v(pos+2) *wIn.h1_0i - v(pos+3) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i - v(pos+9) *wIn.h1_1r + 
						v(pos+14)*wIn.h1_2i- v(pos+15)*wIn.h1_2r;

		h0_2r = 	v(pos+4) *wIn.h0_0r + v(pos+5) *wIn.h0_0i + 
						v(pos+10)*wIn.h0_1r + v(pos+11)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r + v(pos+17)*wIn.h0_2i;
		h0_2i = 	v(pos+4) *wIn.h0_0i - v(pos+5) *wIn.h0_0r + 
						v(pos+10)*wIn.h0_1i - v(pos+11)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i - v(pos+17)*wIn.h0_2r;

		h1_2r= 	v(pos+4) *wIn.h1_0r + v(pos+5) *wIn.h1_0i + 
						v(pos+10)*wIn.h1_1r + v(pos+11)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r+ v(pos+17)*wIn.h1_2i;
		h1_2i= 	v(pos+4) *wIn.h1_0i - v(pos+5) *wIn.h1_0r + 
						v(pos+10)*wIn.h1_1i - v(pos+11)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i- v(pos+17)*wIn.h1_2r;
		return this;
	}

	@Inline def PackTMultD(v : DistArray_Block_1[Double],w : DistArray_Block_1[Double], iu : Long, iw : Long) : DistHalfWilsonVector
	{
		val pos = v.localIndices().min(0) + iu*18;
		val wIn = new DistHalfWilsonVector();
		wIn.PackTM(w,iw);

		h0_0r = 	v(pos+0) *wIn.h0_0r + v(pos+1) *wIn.h0_0i + 
						v(pos+6) *wIn.h0_1r + v(pos+7) *wIn.h0_1i + 
						v(pos+12)*wIn.h0_2r + v(pos+13)*wIn.h0_2i;
		h0_0i = 	v(pos+0) *wIn.h0_0i - v(pos+1) *wIn.h0_0r + 
						v(pos+6) *wIn.h0_1i - v(pos+7) *wIn.h0_1r + 
						v(pos+12)*wIn.h0_2i - v(pos+13)*wIn.h0_2r;

		h1_0r = 	v(pos+0) *wIn.h1_0r + v(pos+1) *wIn.h1_0i + 
						v(pos+6) *wIn.h1_1r + v(pos+7) *wIn.h1_1i + 
						v(pos+12)*wIn.h1_2r+ v(pos+13)*wIn.h1_2i;
		h1_0i = 	v(pos+0) *wIn.h1_0i - v(pos+1) *wIn.h1_0r + 
						v(pos+6) *wIn.h1_1i - v(pos+7) *wIn.h1_1r + 
						v(pos+12)*wIn.h1_2i- v(pos+13)*wIn.h1_2r;

		h0_1r = 	v(pos+2) *wIn.h0_0r + v(pos+3) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r + v(pos+9) *wIn.h0_1i + 
						v(pos+14)*wIn.h0_2r + v(pos+15)*wIn.h0_2i;
		h0_1i = 	v(pos+2) *wIn.h0_0i - v(pos+3) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i - v(pos+9) *wIn.h0_1r + 
						v(pos+14)*wIn.h0_2i - v(pos+15)*wIn.h0_2r;

		h1_1r = 	v(pos+2) *wIn.h1_0r + v(pos+3) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r + v(pos+9) *wIn.h1_1i + 
						v(pos+14)*wIn.h1_2r+ v(pos+15)*wIn.h1_2i;
		h1_1i = 	v(pos+2) *wIn.h1_0i - v(pos+3) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i - v(pos+9) *wIn.h1_1r + 
						v(pos+14)*wIn.h1_2i- v(pos+15)*wIn.h1_2r;

		h0_2r = 	v(pos+4) *wIn.h0_0r + v(pos+5) *wIn.h0_0i + 
						v(pos+10)*wIn.h0_1r + v(pos+11)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r + v(pos+17)*wIn.h0_2i;
		h0_2i = 	v(pos+4) *wIn.h0_0i - v(pos+5) *wIn.h0_0r + 
						v(pos+10)*wIn.h0_1i - v(pos+11)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i - v(pos+17)*wIn.h0_2r;

		h1_2r= 	v(pos+4) *wIn.h1_0r + v(pos+5) *wIn.h1_0i + 
						v(pos+10)*wIn.h1_1r + v(pos+11)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r+ v(pos+17)*wIn.h1_2i;
		h1_2i= 	v(pos+4) *wIn.h1_0i - v(pos+5) *wIn.h1_0r + 
						v(pos+10)*wIn.h1_1i - v(pos+11)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i- v(pos+17)*wIn.h1_2r;
		return this;
	}

}




