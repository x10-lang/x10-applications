
import x10.compiler.Inline;


public class HalfWilsonVector {
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

}




