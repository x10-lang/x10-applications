

import x10.array.Array_1;

import ComplexField;
import x10.compiler.Inline;
import x10.compiler.Pragma;

import HalfWilsonVector;


public class WilsonVectorField extends ComplexField {

	def this(x : Long,y : Long,z : Long,t : Long,nid : Long)
	{
		super(x,y,z,t,3,4,1,nid);
	}

	@Inline def PackXP(h : HalfWilsonVector, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + i*w3
		h.h0_0r = v(pos+0) - v(pos+19);		h.h0_0i = v(pos+1) + v(pos+18);
		h.h0_1r = v(pos+2) - v(pos+21);		h.h0_1i = v(pos+3) + v(pos+20);
		h.h0_2r = v(pos+4) - v(pos+23);		h.h0_2i = v(pos+5) + v(pos+22);

		//h1 = w1 + i*w2
		h.h1_0r = v(pos+6) - v(pos+13);		h.h1_0i = v(pos+7) + v(pos+12);
		h.h1_1r = v(pos+8) - v(pos+15);		h.h1_1i = v(pos+9) + v(pos+14);
		h.h1_2r= v(pos+10)- v(pos+17);		h.h1_2i= v(pos+11)+ v(pos+16);
	}

	@Inline def PackXM(h : HalfWilsonVector, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - i*w3
		h.h0_0r = v(pos+0) + v(pos+19);		h.h0_0i = v(pos+1) - v(pos+18);
		h.h0_1r = v(pos+2) + v(pos+21);		h.h0_1i = v(pos+3) - v(pos+20);
		h.h0_2r = v(pos+4) + v(pos+23);		h.h0_2i = v(pos+5) - v(pos+22);

		//h1 = w1 - i*w2
		h.h1_0r = v(pos+6) + v(pos+13);		h.h1_0i = v(pos+7) - v(pos+12);
		h.h1_1r = v(pos+8) + v(pos+15);		h.h1_1i = v(pos+9) - v(pos+14);
		h.h1_2r= v(pos+10)+ v(pos+17);		h.h1_2i= v(pos+11)- v(pos+16);
	}

	@Inline def PackYP(h : HalfWilsonVector, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + w3
		h.h0_0r = v(pos+0) + v(pos+18);		h.h0_0i = v(pos+1) + v(pos+19);
		h.h0_1r = v(pos+2) + v(pos+20);		h.h0_1i = v(pos+3) + v(pos+21);
		h.h0_2r = v(pos+4) + v(pos+22);		h.h0_2i = v(pos+5) + v(pos+23);

		//h1 = w1 - w2
		h.h1_0r = v(pos+6) - v(pos+12);		h.h1_0i = v(pos+7) - v(pos+13);
		h.h1_1r = v(pos+8) - v(pos+14);		h.h1_1i = v(pos+9) - v(pos+15);
		h.h1_2r= v(pos+10)- v(pos+16);		h.h1_2i= v(pos+11)- v(pos+17);
	}

	@Inline def PackYM(h : HalfWilsonVector, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - w3
		h.h0_0r = v(pos+0) - v(pos+18);		h.h0_0i = v(pos+1) - v(pos+19);
		h.h0_1r = v(pos+2) - v(pos+20);		h.h0_1i = v(pos+3) - v(pos+21);
		h.h0_2r = v(pos+4) - v(pos+22);		h.h0_2i = v(pos+5) - v(pos+23);

		//h1 = w1 + w2
		h.h1_0r = v(pos+6) + v(pos+12);		h.h1_0i = v(pos+7) + v(pos+13);
		h.h1_1r = v(pos+8) + v(pos+14);		h.h1_1i = v(pos+9) + v(pos+15);
		h.h1_2r= v(pos+10)+ v(pos+16);		h.h1_2i= v(pos+11)+ v(pos+17);
	}
	
	@Inline def PackZP(h : HalfWilsonVector, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 + i*w2
		h.h0_0r = v(pos+0) - v(pos+13);		h.h0_0i = v(pos+1) + v(pos+12);
		h.h0_1r = v(pos+2) - v(pos+15);		h.h0_1i = v(pos+3) + v(pos+14);
		h.h0_2r = v(pos+4) - v(pos+17);		h.h0_2i = v(pos+5) + v(pos+16);

		//h1 = w1 - i*w3
		h.h1_0r = v(pos+6) + v(pos+19);		h.h1_0i = v(pos+7) - v(pos+18);
		h.h1_1r = v(pos+8) + v(pos+21);		h.h1_1i = v(pos+9) - v(pos+20);
		h.h1_2r= v(pos+10)+ v(pos+23);		h.h1_2i= v(pos+11)- v(pos+22);
	}

	@Inline def PackZM(h : HalfWilsonVector, iw : Long)
	{
		val pos = iw*24;
		//h0 = w0 - i*w3
		h.h0_0r = v(pos+0) + v(pos+13);		h.h0_0i = v(pos+1) - v(pos+12);
		h.h0_1r = v(pos+2) + v(pos+15);		h.h0_1i = v(pos+3) - v(pos+14);
		h.h0_2r = v(pos+4) + v(pos+17);		h.h0_2i = v(pos+5) - v(pos+16);

		//h1 = w1 + i*w2
		h.h1_0r = v(pos+6) - v(pos+19);		h.h1_0i = v(pos+7) + v(pos+18);
		h.h1_1r = v(pos+8) - v(pos+21);		h.h1_1i = v(pos+9) + v(pos+20);
		h.h1_2r= v(pos+10)- v(pos+23);		h.h1_2i= v(pos+11)+ v(pos+22);
	}

	//Dirac representation
	@Inline def PackTP(h : HalfWilsonVector, iw : Long)
	{
		val pos = iw*24;
		//h0 = 2.0*w2
		h.h0_0r = 2.0*v(pos+12);		h.h0_0i = 2.0*v(pos+13);
		h.h0_1r = 2.0*v(pos+14);		h.h0_1i = 2.0*v(pos+15);
		h.h0_2r = 2.0*v(pos+16);		h.h0_2i = 2.0*v(pos+17);

		//h1 = 2.0*w3
		h.h1_0r = 2.0*v(pos+18);		h.h1_0i = 2.0*v(pos+19);
		h.h1_1r = 2.0*v(pos+20);		h.h1_1i = 2.0*v(pos+21);
		h.h1_2r= 2.0*v(pos+22);		h.h1_2i= 2.0*v(pos+23);
	}

	//Dirac representation
	@Inline def PackTM(h : HalfWilsonVector, iw : Long)
	{
		val pos = iw*24;
		//h0 = 2.0*w0
		h.h0_0r = 2.0*v(pos+0);		h.h0_0i = 2.0*v(pos+1);
		h.h0_1r = 2.0*v(pos+2);		h.h0_1i = 2.0*v(pos+3);
		h.h0_2r = 2.0*v(pos+4);		h.h0_2i = 2.0*v(pos+5);

		//h1 = 2.0*w1
		h.h1_0r = 2.0*v(pos+6);		h.h1_0i = 2.0*v(pos+7);
		h.h1_1r = 2.0*v(pos+8);		h.h1_1i = 2.0*v(pos+9);
		h.h1_2r= 2.0*v(pos+10);		h.h1_2i= 2.0*v(pos+11);
	}

	@Inline def PackXP(iw : Long) : HalfWilsonVector
	{
		val pos = iw*24;
		val h = new HalfWilsonVector();

		//h0 = w0 + i*w3
		h.h0_0r = v(pos+0) - v(pos+19);		h.h0_0i = v(pos+1) + v(pos+18);
		h.h0_1r = v(pos+2) - v(pos+21);		h.h0_1i = v(pos+3) + v(pos+20);
		h.h0_2r = v(pos+4) - v(pos+23);		h.h0_2i = v(pos+5) + v(pos+22);

		//h1 = w1 + i*w2
		h.h1_0r = v(pos+6) - v(pos+13);		h.h1_0i = v(pos+7) + v(pos+12);
		h.h1_1r = v(pos+8) - v(pos+15);		h.h1_1i = v(pos+9) + v(pos+14);
		h.h1_2r= v(pos+10)- v(pos+17);		h.h1_2i= v(pos+11)+ v(pos+16);

		return h;
	}

	@Inline def PackXM(iw : Long) : HalfWilsonVector
	{
		val pos = iw*24;
		val h = new HalfWilsonVector();
		//h0 = w0 - i*w3
		h.h0_0r = v(pos+0) + v(pos+19);		h.h0_0i = v(pos+1) - v(pos+18);
		h.h0_1r = v(pos+2) + v(pos+21);		h.h0_1i = v(pos+3) - v(pos+20);
		h.h0_2r = v(pos+4) + v(pos+23);		h.h0_2i = v(pos+5) - v(pos+22);

		//h1 = w1 - i*w2
		h.h1_0r = v(pos+6) + v(pos+13);		h.h1_0i = v(pos+7) - v(pos+12);
		h.h1_1r = v(pos+8) + v(pos+15);		h.h1_1i = v(pos+9) - v(pos+14);
		h.h1_2r= v(pos+10)+ v(pos+17);		h.h1_2i= v(pos+11)- v(pos+16);

		return h;
	}

	@Inline def PackYP(iw : Long) : HalfWilsonVector
	{
		val pos = iw*24;
		val h = new HalfWilsonVector();
		//h0 = w0 + w3
		h.h0_0r = v(pos+0) + v(pos+18);		h.h0_0i = v(pos+1) + v(pos+19);
		h.h0_1r = v(pos+2) + v(pos+20);		h.h0_1i = v(pos+3) + v(pos+21);
		h.h0_2r = v(pos+4) + v(pos+22);		h.h0_2i = v(pos+5) + v(pos+23);

		//h1 = w1 - w2
		h.h1_0r = v(pos+6) - v(pos+12);		h.h1_0i = v(pos+7) - v(pos+13);
		h.h1_1r = v(pos+8) - v(pos+14);		h.h1_1i = v(pos+9) - v(pos+15);
		h.h1_2r= v(pos+10)- v(pos+16);		h.h1_2i= v(pos+11)- v(pos+17);

		return h;
	}

	@Inline def PackYM(iw : Long) : HalfWilsonVector
	{
		val pos = iw*24;
		val h = new HalfWilsonVector();
		//h0 = w0 - w3
		h.h0_0r = v(pos+0) - v(pos+18);		h.h0_0i = v(pos+1) - v(pos+19);
		h.h0_1r = v(pos+2) - v(pos+20);		h.h0_1i = v(pos+3) - v(pos+21);
		h.h0_2r = v(pos+4) - v(pos+22);		h.h0_2i = v(pos+5) - v(pos+23);

		//h1 = w1 + w2
		h.h1_0r = v(pos+6) + v(pos+12);		h.h1_0i = v(pos+7) + v(pos+13);
		h.h1_1r = v(pos+8) + v(pos+14);		h.h1_1i = v(pos+9) + v(pos+15);
		h.h1_2r= v(pos+10)+ v(pos+16);		h.h1_2i= v(pos+11)+ v(pos+17);

		return h;
	}
	
	@Inline def PackZP(iw : Long) : HalfWilsonVector
	{
		val pos = iw*24;
		val h = new HalfWilsonVector();
		//h0 = w0 + i*w2
		h.h0_0r = v(pos+0) - v(pos+13);		h.h0_0i = v(pos+1) + v(pos+12);
		h.h0_1r = v(pos+2) - v(pos+15);		h.h0_1i = v(pos+3) + v(pos+14);
		h.h0_2r = v(pos+4) - v(pos+17);		h.h0_2i = v(pos+5) + v(pos+16);

		//h1 = w1 - i*w3
		h.h1_0r = v(pos+6) + v(pos+19);		h.h1_0i = v(pos+7) - v(pos+18);
		h.h1_1r = v(pos+8) + v(pos+21);		h.h1_1i = v(pos+9) - v(pos+20);
		h.h1_2r= v(pos+10)+ v(pos+23);		h.h1_2i= v(pos+11)- v(pos+22);

		return h;
	}

	@Inline def PackZM(iw : Long) : HalfWilsonVector
	{
		val pos = iw*24;
		val h = new HalfWilsonVector();
		//h0 = w0 - i*w3
		h.h0_0r = v(pos+0) + v(pos+13);		h.h0_0i = v(pos+1) - v(pos+12);
		h.h0_1r = v(pos+2) + v(pos+15);		h.h0_1i = v(pos+3) - v(pos+14);
		h.h0_2r = v(pos+4) + v(pos+17);		h.h0_2i = v(pos+5) - v(pos+16);

		//h1 = w1 + i*w2
		h.h1_0r = v(pos+6) - v(pos+19);		h.h1_0i = v(pos+7) + v(pos+18);
		h.h1_1r = v(pos+8) - v(pos+21);		h.h1_1i = v(pos+9) + v(pos+20);
		h.h1_2r= v(pos+10)- v(pos+23);		h.h1_2i= v(pos+11)+ v(pos+22);

		return h;
	}

	//Dirac representation
	@Inline def PackTP(iw : Long) : HalfWilsonVector
	{
		val pos = iw*24;
		val h = new HalfWilsonVector();
		//h0 = 2.0*w2
		h.h0_0r = 2.0*v(pos+12);		h.h0_0i = 2.0*v(pos+13);
		h.h0_1r = 2.0*v(pos+14);		h.h0_1i = 2.0*v(pos+15);
		h.h0_2r = 2.0*v(pos+16);		h.h0_2i = 2.0*v(pos+17);

		//h1 = 2.0*w3
		h.h1_0r = 2.0*v(pos+18);		h.h1_0i = 2.0*v(pos+19);
		h.h1_1r = 2.0*v(pos+20);		h.h1_1i = 2.0*v(pos+21);
		h.h1_2r= 2.0*v(pos+22);		h.h1_2i= 2.0*v(pos+23);

		return h;
	}

	//Dirac representation
	@Inline def PackTM(iw : Long) : HalfWilsonVector
	{
		val pos = iw*24;
		val h = new HalfWilsonVector();
		//h0 = 2.0*w0
		h.h0_0r = 2.0*v(pos+0);		h.h0_0i = 2.0*v(pos+1);
		h.h0_1r = 2.0*v(pos+2);		h.h0_1i = 2.0*v(pos+3);
		h.h0_2r = 2.0*v(pos+4);		h.h0_2i = 2.0*v(pos+5);

		//h1 = 2.0*w1
		h.h1_0r = 2.0*v(pos+6);		h.h1_0i = 2.0*v(pos+7);
		h.h1_1r = 2.0*v(pos+8);		h.h1_1i = 2.0*v(pos+9);
		h.h1_2r= 2.0*v(pos+10);		h.h1_2i= 2.0*v(pos+11);

		return h;
	}

	@Inline def UnpackXP(h : HalfWilsonVector, iw : Long, cks : Double)
	{
		val pos = iw*24;

		v(pos+0) += cks*h.h0_0r;			v(pos+1) += cks*h.h0_0i;
		v(pos+2) += cks*h.h0_1r;			v(pos+3) += cks*h.h0_1i;
		v(pos+4) += cks*h.h0_2r;			v(pos+5) += cks*h.h0_2i;

		v(pos+6) += cks*h.h1_0r;			v(pos+7) += cks*h.h1_0i;
		v(pos+8) += cks*h.h1_1r;			v(pos+9) += cks*h.h1_1i;
		v(pos+10)+= cks*h.h1_2r;			v(pos+11)+= cks*h.h1_2i;

		//w3 += -i*h.h1
		v(pos+12) += cks*h.h1_0i;		v(pos+13) -= cks*h.h1_0r;
		v(pos+14) += cks*h.h1_1i;		v(pos+15) -= cks*h.h1_1r;
		v(pos+16) += cks*h.h1_2i;		v(pos+17) -= cks*h.h1_2r;

		//w4 += -i*h.h0
		v(pos+18) += cks*h.h0_0i;		v(pos+19) -= cks*h.h0_0r;
		v(pos+20) += cks*h.h0_1i;		v(pos+21) -= cks*h.h0_1r;
		v(pos+22) += cks*h.h0_2i;		v(pos+23) -= cks*h.h0_2r;
	}

	@Inline def UnpackXM(h : HalfWilsonVector, iw : Long, cks : Double)
	{
		val pos = iw*24;
		v(pos+0) += cks*h.h0_0r;			v(pos+1) += cks*h.h0_0i;
		v(pos+2) += cks*h.h0_1r;			v(pos+3) += cks*h.h0_1i;
		v(pos+4) += cks*h.h0_2r;			v(pos+5) += cks*h.h0_2i;

		v(pos+6) += cks*h.h1_0r;			v(pos+7) += cks*h.h1_0i;
		v(pos+8) += cks*h.h1_1r;			v(pos+9) += cks*h.h1_1i;
		v(pos+10)+= cks*h.h1_2r;		v(pos+11)+= cks*h.h1_2i;

		//w3 += i*h.h1
		v(pos+12) -= cks*h.h1_0i;		v(pos+13) += cks*h.h1_0r;
		v(pos+14) -= cks*h.h1_1i;		v(pos+15) += cks*h.h1_1r;
		v(pos+16) -= cks*h.h1_2i;		v(pos+17) += cks*h.h1_2r;

		//w4 += i*h.h0
		v(pos+18) -= cks*h.h0_0i;		v(pos+19) += cks*h.h0_0r;
		v(pos+20) -= cks*h.h0_1i;		v(pos+21) += cks*h.h0_1r;
		v(pos+22) -= cks*h.h0_2i;		v(pos+23) += cks*h.h0_2r;
	}

	@Inline def UnpackYP(h : HalfWilsonVector, iw : Long, cks : Double)
	{
		val pos = iw*24;
		v(pos+0) += cks*h.h0_0r;			v(pos+1) += cks*h.h0_0i;
		v(pos+2) += cks*h.h0_1r;			v(pos+3) += cks*h.h0_1i;
		v(pos+4) += cks*h.h0_2r;			v(pos+5) += cks*h.h0_2i;

		v(pos+6) += cks*h.h1_0r;			v(pos+7) += cks*h.h1_0i;
		v(pos+8) += cks*h.h1_1r;			v(pos+9) += cks*h.h1_1i;
		v(pos+10)+= cks*h.h1_2r;		v(pos+11)+= cks*h.h1_2i;

		//w3 += -h1
		v(pos+12) -= cks*h.h1_0r;		v(pos+13) -= cks*h.h1_0i;
		v(pos+14) -= cks*h.h1_1r;		v(pos+15) -= cks*h.h1_1i;
		v(pos+16) -= cks*h.h1_2r;		v(pos+17) -= cks*h.h1_2i;

		//w4 += cks*h.h0
		v(pos+18) += cks*h.h0_0r;		v(pos+19) += cks*h.h0_0i;
		v(pos+20) += cks*h.h0_1r;		v(pos+21) += cks*h.h0_1i;
		v(pos+22) += cks*h.h0_2r;		v(pos+23) += cks*h.h0_2i;
	}

	@Inline def UnpackYM(h : HalfWilsonVector, iw : Long, cks : Double)
	{
		val pos = iw*24;
		v(pos+0) += cks*h.h0_0r;			v(pos+1) += cks*h.h0_0i;
		v(pos+2) += cks*h.h0_1r;			v(pos+3) += cks*h.h0_1i;
		v(pos+4) += cks*h.h0_2r;			v(pos+5) += cks*h.h0_2i;

		v(pos+6) += cks*h.h1_0r;			v(pos+7) += cks*h.h1_0i;
		v(pos+8) += cks*h.h1_1r;			v(pos+9) += cks*h.h1_1i;
		v(pos+10)+= cks*h.h1_2r;		v(pos+11)+= cks*h.h1_2i;

		//w3 += cks*h.h1
		v(pos+12) += cks*h.h1_0r;		v(pos+13) += cks*h.h1_0i;
		v(pos+14) += cks*h.h1_1r;		v(pos+15) += cks*h.h1_1i;
		v(pos+16) += cks*h.h1_2r;		v(pos+17) += cks*h.h1_2i;

		//w4 += -h0
		v(pos+18) -= cks*h.h0_0r;		v(pos+19) -= cks*h.h0_0i;
		v(pos+20) -= cks*h.h0_1r;		v(pos+21) -= cks*h.h0_1i;
		v(pos+22) -= cks*h.h0_2r;		v(pos+23) -= cks*h.h0_2i;
	}

	@Inline def UnpackZP(h : HalfWilsonVector, iw : Long, cks : Double)
	{
		val pos = iw*24;
		v(pos+0) += cks*h.h0_0r;			v(pos+1) += cks*h.h0_0i;
		v(pos+2) += cks*h.h0_1r;			v(pos+3) += cks*h.h0_1i;
		v(pos+4) += cks*h.h0_2r;			v(pos+5) += cks*h.h0_2i;

		v(pos+6) += cks*h.h1_0r;			v(pos+7) += cks*h.h1_0i;
		v(pos+8) += cks*h.h1_1r;			v(pos+9) += cks*h.h1_1i;
		v(pos+10)+= cks*h.h1_2r;			v(pos+11)+= cks*h.h1_2i;

		//w3 += -i*h.h0
		v(pos+12) += cks*h.h0_0i;		v(pos+13) -= cks*h.h0_0r;
		v(pos+14) += cks*h.h0_1i;		v(pos+15) -= cks*h.h0_1r;
		v(pos+16) += cks*h.h0_2i;		v(pos+17) -= cks*h.h0_2r;

		//w4 += i*h.h1
		v(pos+18) -= cks*h.h1_0i;		v(pos+19) += cks*h.h1_0r;
		v(pos+20) -= cks*h.h1_1i;		v(pos+21) += cks*h.h1_1r;
		v(pos+22) -= cks*h.h1_2i;		v(pos+23) += cks*h.h1_2r;
	}

	@Inline def UnpackZM(h : HalfWilsonVector, iw : Long, cks : Double)
	{
		val pos = iw*24;
		v(pos+0) += cks*h.h0_0r;			v(pos+1) += cks*h.h0_0i;
		v(pos+2) += cks*h.h0_1r;			v(pos+3) += cks*h.h0_1i;
		v(pos+4) += cks*h.h0_2r;			v(pos+5) += cks*h.h0_2i;

		v(pos+6) += cks*h.h1_0r;			v(pos+7) += cks*h.h1_0i;
		v(pos+8) += cks*h.h1_1r;			v(pos+9) += cks*h.h1_1i;
		v(pos+10)+= cks*h.h1_2r;			v(pos+11)+= cks*h.h1_2i;

		//w3 += i*h.h0
		v(pos+12) -= cks*h.h0_0i;		v(pos+13) += cks*h.h0_0r;
		v(pos+14) -= cks*h.h0_1i;		v(pos+15) += cks*h.h0_1r;
		v(pos+16) -= cks*h.h0_2i;		v(pos+17) += cks*h.h0_2r;

		//w4 += -i*h.h1
		v(pos+18) += cks*h.h1_0i;		v(pos+19) -= cks*h.h1_0r;
		v(pos+20) += cks*h.h1_1i;		v(pos+21) -= cks*h.h1_1r;
		v(pos+22) += cks*h.h1_2i;		v(pos+23) -= cks*h.h1_2r;
	}

	//Dirac representation
	@Inline def UnpackTP(h : HalfWilsonVector, iw : Long, cks : Double)
	{
		val pos = iw*24;
		v(pos+12) += cks*h.h0_0r;		v(pos+13) += cks*h.h0_0i;
		v(pos+14) += cks*h.h0_1r;		v(pos+15) += cks*h.h0_1i;
		v(pos+16) += cks*h.h0_2r;		v(pos+17) += cks*h.h0_2i;

		v(pos+18) += cks*h.h1_0r;		v(pos+19) += cks*h.h1_0i;
		v(pos+20) += cks*h.h1_1r;		v(pos+21) += cks*h.h1_1i;
		v(pos+22) += cks*h.h1_2r;		v(pos+23) += cks*h.h1_2i;
	}

	//Dirac representation
	@Inline def UnpackTM(h : HalfWilsonVector, iw : Long, cks : Double)
	{
		val pos = iw*24;
		v(pos+0) += cks*h.h0_0r;			v(pos+1) += cks*h.h0_0i;
		v(pos+2) += cks*h.h0_1r;			v(pos+3) += cks*h.h0_1i;
		v(pos+4) += cks*h.h0_2r;			v(pos+5) += cks*h.h0_2i;

		v(pos+6) += cks*h.h1_0r;			v(pos+7) += cks*h.h1_0i;
		v(pos+8) += cks*h.h1_1r;			v(pos+9) += cks*h.h1_1i;
		v(pos+10)+= cks*h.h1_2r;			v(pos+11)+= cks*h.h1_2i;
	}
	



	def MultGamma5()
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val is = tid * nsite / nThreads;
			val ie = (tid + 1) * nsite / nThreads;

			var t0r : Double;
			var t0i : Double;
			var t1r : Double;
			var t1i : Double;

			for(i in is..(ie-1)){
				t0r = v(i*24);
				t0i = v(i*24 + 1);
				t1r = v(i*24 + 6);
				t1i = v(i*24 + 7);
				v(i*24    ) = v(i*24 + 12);
				v(i*24 + 1) = v(i*24 + 13);
				v(i*24 + 6) = v(i*24 + 18);
				v(i*24 + 7) = v(i*24 + 19);
				v(i*24 +12) = t0r;
				v(i*24 +13) = t0i;
				v(i*24 +18) = t1r;
				v(i*24 +19) = t1i;

				t0r = v(i*24 + 2);
				t0i = v(i*24 + 3);
				t1r = v(i*24 + 8);
				t1i = v(i*24 + 9);
				v(i*24 + 2) = v(i*24 + 14);
				v(i*24 + 3) = v(i*24 + 15);
				v(i*24 + 8) = v(i*24 + 20);
				v(i*24 + 9) = v(i*24 + 21);
				v(i*24 +14) = t0r;
				v(i*24 +15) = t0i;
				v(i*24 +20) = t1r;
				v(i*24 +21) = t1i;

				t0r = v(i*24 + 4);
				t0i = v(i*24 + 5);
				t1r = v(i*24 +10);
				t1i = v(i*24 +11);
				v(i*24 + 4) = v(i*24 + 16);
				v(i*24 + 5) = v(i*24 + 17);
				v(i*24 +10) = v(i*24 + 22);
				v(i*24 +11) = v(i*24 + 23);
				v(i*24 +16) = t0r;
				v(i*24 +17) = t0i;
				v(i*24 +22) = t1r;
				v(i*24 +23) = t1i;
			}
		}
	}
	def MultGamma5(rng : LongRange)
	{
		var t0r : Double;
		var t0i : Double;
		var t1r : Double;
		var t1i : Double;
		for(i in (rng.min)..(rng.max-1)){
			t0r = v(i*24);
			t0i = v(i*24 + 1);
			t1r = v(i*24 + 6);
			t1i = v(i*24 + 7);
			v(i*24    ) = v(i*24 + 12);
			v(i*24 + 1) = v(i*24 + 13);
			v(i*24 + 6) = v(i*24 + 18);
			v(i*24 + 7) = v(i*24 + 19);
			v(i*24 +12) = t0r;
			v(i*24 +13) = t0i;
			v(i*24 +18) = t1r;
			v(i*24 +19) = t1i;

			t0r = v(i*24 + 2);
			t0i = v(i*24 + 3);
			t1r = v(i*24 + 8);
			t1i = v(i*24 + 9);
			v(i*24 + 2) = v(i*24 + 14);
			v(i*24 + 3) = v(i*24 + 15);
			v(i*24 + 8) = v(i*24 + 20);
			v(i*24 + 9) = v(i*24 + 21);
			v(i*24 +14) = t0r;
			v(i*24 +15) = t0i;
			v(i*24 +20) = t1r;
			v(i*24 +21) = t1i;

			t0r = v(i*24 + 4);
			t0i = v(i*24 + 5);
			t1r = v(i*24 +10);
			t1i = v(i*24 +11);
			v(i*24 + 4) = v(i*24 + 16);
			v(i*24 + 5) = v(i*24 + 17);
			v(i*24 +10) = v(i*24 + 22);
			v(i*24 +11) = v(i*24 + 23);
			v(i*24 +16) = t0r;
			v(i*24 +17) = t0i;
			v(i*24 +22) = t1r;
			v(i*24 +23) = t1i;
		}
	}

}




