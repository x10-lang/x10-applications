import ParallelComplexField;


public class WilsonVectorField extends ParallelComplexField {

	def this(x : Long,y : Long,z : Long,t : Long,nid : Long)
	{
		super(x,y,z,t,3,4,1,nid);
	}

	def MultGamma5()
	{
		var t0r : Double;
		var t0i : Double;
		var t1r : Double;
		var t1i : Double;
		for(i in 0..(nsite-1)){
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
	def MultGamma5(rng : LongRange)
	{
		var t0r : Double;
		var t0i : Double;
		var t1r : Double;
		var t1i : Double;
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

}
