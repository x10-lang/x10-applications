import ParallelComplexField;


public class WilsonVectorField extends ParallelComplexField {

	def this(x : Long,y : Long,z : Long,t : Long,nid : Long)
	{
		super(x,y,z,t,3,4,1,nid);
	}

	def MultGamma5()
	{
		var t0r : Float;
		var t0i : Float;
		var t1r : Float;
		var t1i : Float;
		for(i in 0..(nsite-1)){
			// t0r = v()(i*24);
			// t0i = v()(i*24 + 1);
			// t1r = v()(i*24 + 6);
			// t1i = v()(i*24 + 7);
			// v()(i*24    ) = v()(i*24 + 12);
			// v()(i*24 + 1) = v()(i*24 + 13);
			// v()(i*24 + 6) = v()(i*24 + 18);
			// v()(i*24 + 7) = v()(i*24 + 19);
			// v()(i*24 +12) = t0r;
			// v()(i*24 +13) = t0i;
			// v()(i*24 +18) = t1r;
			// v()(i*24 +19) = t1i;
			t0r = v()(i);
			t0i = v()(i + 1*nsite);
			t1r = v()(i + 6*nsite);
			t1i = v()(i + 7*nsite);
			v()(i          ) = v()(i + 12*nsite);
			v()(i + 1*nsite) = v()(i + 13*nsite);
			v()(i + 6*nsite) = v()(i + 18*nsite);
			v()(i + 7*nsite) = v()(i + 19*nsite);
			v()(i +12*nsite) = t0r;
			v()(i +13*nsite) = t0i;
			v()(i +18*nsite) = t1r;
			v()(i +19*nsite) = t1i;

			t0r = v()(i + 2*nsite);
			t0i = v()(i + 3*nsite);
			t1r = v()(i + 8*nsite);
			t1i = v()(i + 9*nsite);
			v()(i + 2*nsite) = v()(i + 14*nsite);
			v()(i + 3*nsite) = v()(i + 15*nsite);
			v()(i + 8*nsite) = v()(i + 20*nsite);
			v()(i + 9*nsite) = v()(i + 21*nsite);
			v()(i +14*nsite) = t0r;
			v()(i +15*nsite) = t0i;
			v()(i +20*nsite) = t1r;
			v()(i +21*nsite) = t1i;

			t0r = v()(i + 4*nsite);
			t0i = v()(i + 5*nsite);
			t1r = v()(i +10*nsite);
			t1i = v()(i +11*nsite);
			v()(i + 4*nsite) = v()(i + 16*nsite);
			v()(i + 5*nsite) = v()(i + 17*nsite);
			v()(i +10*nsite) = v()(i + 22*nsite);
			v()(i +11*nsite) = v()(i + 23*nsite);
			v()(i +16*nsite) = t0r;
			v()(i +17*nsite) = t0i;
			v()(i +22*nsite) = t1r;
			v()(i +23*nsite) = t1i;
		}
	}

/*
	def MultGamma5(rng : LongRange)
	{
		var t0r : Float;
		var t0i : Float;
		var t1r : Float;
		var t1i : Float;
		for(i in (rng.min)..(rng.max-1)){
			t0r = v()(i*24);
			t0i = v()(i*24 + 1);
			t1r = v()(i*24 + 6);
			t1i = v()(i*24 + 7);
			v()(i*24    ) = v()(i*24 + 12);
			v()(i*24 + 1) = v()(i*24 + 13);
			v()(i*24 + 6) = v()(i*24 + 18);
			v()(i*24 + 7) = v()(i*24 + 19);
			v()(i*24 +12) = t0r;
			v()(i*24 +13) = t0i;
			v()(i*24 +18) = t1r;
			v()(i*24 +19) = t1i;

			t0r = v()(i*24 + 2);
			t0i = v()(i*24 + 3);
			t1r = v()(i*24 + 8);
			t1i = v()(i*24 + 9);
			v()(i*24 + 2) = v()(i*24 + 14);
			v()(i*24 + 3) = v()(i*24 + 15);
			v()(i*24 + 8) = v()(i*24 + 20);
			v()(i*24 + 9) = v()(i*24 + 21);
			v()(i*24 +14) = t0r;
			v()(i*24 +15) = t0i;
			v()(i*24 +20) = t1r;
			v()(i*24 +21) = t1i;

			t0r = v()(i*24 + 4);
			t0i = v()(i*24 + 5);
			t1r = v()(i*24 +10);
			t1i = v()(i*24 +11);
			v()(i*24 + 4) = v()(i*24 + 16);
			v()(i*24 + 5) = v()(i*24 + 17);
			v()(i*24 +10) = v()(i*24 + 22);
			v()(i*24 +11) = v()(i*24 + 23);
			v()(i*24 +16) = t0r;
			v()(i*24 +17) = t0i;
			v()(i*24 +22) = t1r;
			v()(i*24 +23) = t1i;
		}
	}
*/

}
