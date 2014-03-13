import x10.io.File;
import x10.io.FileNotFoundException;
import x10.array.Array_1;

import ComplexField;

import Lattice;

import MyRand;


import HalfWilsonVector;

import x10.compiler.Inline;



public class SU3MatrixField extends ComplexField {
	def this(x : Long,y : Long,z : Long,t : Long,nid : Long)
	{
		super(x,y,z,t,3,3,4,nid);
	}

	def SetUnit()
	{
		for(i in 0..(nsite*Nfld-1)){
			v(i*18     ) = 1.0;			v(i*18 + 1 ) = 0.0;
			v(i*18 + 2 ) = 0.0;			v(i*18 + 3 ) = 0.0;
			v(i*18 + 4 ) = 0.0;			v(i*18 + 5 ) = 0.0;

			v(i*18 + 6 ) = 0.0;			v(i*18 + 7 ) = 0.0;
			v(i*18 + 8 ) = 1.0;			v(i*18 + 9 ) = 0.0;
			v(i*18 + 10) = 0.0;			v(i*18 + 11) = 0.0;

			v(i*18 + 12) = 0.0;			v(i*18 + 13) = 0.0;
			v(i*18 + 14) = 0.0;			v(i*18 + 15) = 0.0;
			v(i*18 + 16) = 1.0;			v(i*18 + 17) = 0.0;
		}
	}

	def RandomConf(s : Long)
	{
		var myrand : MyRand = new MyRand(s);
		var d : Double;
		var is : Long;

		is = 0;
		for(i in 0..3){
			for(t in 0..(Nt-1)){
				for(z in 0..(Nz-1)){
					for(y in 0..(Ny-1)){
						for(x in 0..(Nx-1)){
							for(idf in 0..17){
								d = myrand.get_double();
								v(is) = d*2.0 - 1;
								is = is + 1;
							}
						}
					}
				}
			}
		}
	}

	@Inline def Mult(wOut : HalfWilsonVector, wIn : HalfWilsonVector, iu : Long, dir : Long)
	{
		val pos = iu*18 + offsetFld(dir);
		wOut.h0_0r = 	v(pos+0)*wIn.h0_0r - v(pos+1)*wIn.h0_0i + 
						v(pos+2)*wIn.h0_1r - v(pos+3)*wIn.h0_1i + 
						v(pos+4)*wIn.h0_2r - v(pos+5)*wIn.h0_2i;
		wOut.h0_0i = 	v(pos+0)*wIn.h0_0i + v(pos+1)*wIn.h0_0r + 
						v(pos+2)*wIn.h0_1i + v(pos+3)*wIn.h0_1r + 
						v(pos+4)*wIn.h0_2i + v(pos+5)*wIn.h0_2r;

		wOut.h1_0r = 	v(pos+0)*wIn.h1_0r - v(pos+1)*wIn.h1_0i + 
						v(pos+2)*wIn.h1_1r - v(pos+3)*wIn.h1_1i + 
						v(pos+4)*wIn.h1_2r- v(pos+5)*wIn.h1_2i;
		wOut.h1_0i = 	v(pos+0)*wIn.h1_0i + v(pos+1)*wIn.h1_0r + 
						v(pos+2)*wIn.h1_1i + v(pos+3)*wIn.h1_1r + 
						v(pos+4)*wIn.h1_2i+ v(pos+5)*wIn.h1_2r;

		wOut.h0_1r = 	v(pos+6) *wIn.h0_0r - v(pos+7) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r - v(pos+9) *wIn.h0_1i + 
						v(pos+10)*wIn.h0_2r - v(pos+11)*wIn.h0_2i;
		wOut.h0_1i = 	v(pos+6) *wIn.h0_0i + v(pos+7) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i + v(pos+9) *wIn.h0_1r + 
						v(pos+10)*wIn.h0_2i + v(pos+11)*wIn.h0_2r;

		wOut.h1_1r = 	v(pos+6) *wIn.h1_0r - v(pos+7) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r - v(pos+9) *wIn.h1_1i + 
						v(pos+10)*wIn.h1_2r- v(pos+11)*wIn.h1_2i;
		wOut.h1_1i = 	v(pos+6) *wIn.h1_0i + v(pos+7) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i + v(pos+9) *wIn.h1_1r + 
						v(pos+10)*wIn.h1_2i+ v(pos+11)*wIn.h1_2r;

		wOut.h0_2r = 	v(pos+12)*wIn.h0_0r - v(pos+13)*wIn.h0_0i + 
						v(pos+14)*wIn.h0_1r - v(pos+15)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r - v(pos+17)*wIn.h0_2i;
		wOut.h0_2i = 	v(pos+12)*wIn.h0_0i + v(pos+13)*wIn.h0_0r + 
						v(pos+14)*wIn.h0_1i + v(pos+15)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i + v(pos+17)*wIn.h0_2r;

		wOut.h1_2r= 	v(pos+12)*wIn.h1_0r - v(pos+13)*wIn.h1_0i + 
						v(pos+14)*wIn.h1_1r - v(pos+15)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r- v(pos+17)*wIn.h1_2i;
		wOut.h1_2i= 	v(pos+12)*wIn.h1_0i + v(pos+13)*wIn.h1_0r + 
						v(pos+14)*wIn.h1_1i + v(pos+15)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i+ v(pos+17)*wIn.h1_2r;
	}

	@Inline def MultD(wOut : HalfWilsonVector, wIn : HalfWilsonVector, iu : Long, dir : Long)
	{
		val pos = iu*18 + offsetFld(dir);
		wOut.h0_0r = 	v(pos+0) *wIn.h0_0r + v(pos+1) *wIn.h0_0i + 
						v(pos+6) *wIn.h0_1r + v(pos+7) *wIn.h0_1i + 
						v(pos+12)*wIn.h0_2r + v(pos+13)*wIn.h0_2i;
		wOut.h0_0i = 	v(pos+0) *wIn.h0_0i - v(pos+1) *wIn.h0_0r + 
						v(pos+6) *wIn.h0_1i - v(pos+7) *wIn.h0_1r + 
						v(pos+12)*wIn.h0_2i - v(pos+13)*wIn.h0_2r;

		wOut.h1_0r = 	v(pos+0) *wIn.h1_0r + v(pos+1) *wIn.h1_0i + 
						v(pos+6) *wIn.h1_1r + v(pos+7) *wIn.h1_1i + 
						v(pos+12)*wIn.h1_2r+ v(pos+13)*wIn.h1_2i;
		wOut.h1_0i = 	v(pos+0) *wIn.h1_0i - v(pos+1) *wIn.h1_0r + 
						v(pos+6) *wIn.h1_1i - v(pos+7) *wIn.h1_1r + 
						v(pos+12)*wIn.h1_2i- v(pos+13)*wIn.h1_2r;

		wOut.h0_1r = 	v(pos+2) *wIn.h0_0r + v(pos+3) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r + v(pos+9) *wIn.h0_1i + 
						v(pos+14)*wIn.h0_2r + v(pos+15)*wIn.h0_2i;
		wOut.h0_1i = 	v(pos+2) *wIn.h0_0i - v(pos+3) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i - v(pos+9) *wIn.h0_1r + 
						v(pos+14)*wIn.h0_2i - v(pos+15)*wIn.h0_2r;

		wOut.h1_1r = 	v(pos+2) *wIn.h1_0r + v(pos+3) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r + v(pos+9) *wIn.h1_1i + 
						v(pos+14)*wIn.h1_2r+ v(pos+15)*wIn.h1_2i;
		wOut.h1_1i = 	v(pos+2) *wIn.h1_0i - v(pos+3) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i - v(pos+9) *wIn.h1_1r + 
						v(pos+14)*wIn.h1_2i- v(pos+15)*wIn.h1_2r;

		wOut.h0_2r = 	v(pos+4) *wIn.h0_0r + v(pos+5) *wIn.h0_0i + 
						v(pos+10)*wIn.h0_1r + v(pos+11)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r + v(pos+17)*wIn.h0_2i;
		wOut.h0_2i = 	v(pos+4) *wIn.h0_0i - v(pos+5) *wIn.h0_0r + 
						v(pos+10)*wIn.h0_1i - v(pos+11)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i - v(pos+17)*wIn.h0_2r;

		wOut.h1_2r= 	v(pos+4) *wIn.h1_0r + v(pos+5) *wIn.h1_0i + 
						v(pos+10)*wIn.h1_1r + v(pos+11)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r+ v(pos+17)*wIn.h1_2i;
		wOut.h1_2i= 	v(pos+4) *wIn.h1_0i - v(pos+5) *wIn.h1_0r + 
						v(pos+10)*wIn.h1_1i - v(pos+11)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i- v(pos+17)*wIn.h1_2r;
	}


	@Inline def Mult(wIn : HalfWilsonVector, iu : Long, dir : Long) : HalfWilsonVector
	{
		val wOut = new HalfWilsonVector();
		val pos = iu*18 + offsetFld(dir);
		wOut.h0_0r = 	v(pos+0)*wIn.h0_0r - v(pos+1)*wIn.h0_0i + 
						v(pos+2)*wIn.h0_1r - v(pos+3)*wIn.h0_1i + 
						v(pos+4)*wIn.h0_2r - v(pos+5)*wIn.h0_2i;
		wOut.h0_0i = 	v(pos+0)*wIn.h0_0i + v(pos+1)*wIn.h0_0r + 
						v(pos+2)*wIn.h0_1i + v(pos+3)*wIn.h0_1r + 
						v(pos+4)*wIn.h0_2i + v(pos+5)*wIn.h0_2r;

		wOut.h1_0r = 	v(pos+0)*wIn.h1_0r - v(pos+1)*wIn.h1_0i + 
						v(pos+2)*wIn.h1_1r - v(pos+3)*wIn.h1_1i + 
						v(pos+4)*wIn.h1_2r- v(pos+5)*wIn.h1_2i;
		wOut.h1_0i = 	v(pos+0)*wIn.h1_0i + v(pos+1)*wIn.h1_0r + 
						v(pos+2)*wIn.h1_1i + v(pos+3)*wIn.h1_1r + 
						v(pos+4)*wIn.h1_2i+ v(pos+5)*wIn.h1_2r;

		wOut.h0_1r = 	v(pos+6) *wIn.h0_0r - v(pos+7) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r - v(pos+9) *wIn.h0_1i + 
						v(pos+10)*wIn.h0_2r - v(pos+11)*wIn.h0_2i;
		wOut.h0_1i = 	v(pos+6) *wIn.h0_0i + v(pos+7) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i + v(pos+9) *wIn.h0_1r + 
						v(pos+10)*wIn.h0_2i + v(pos+11)*wIn.h0_2r;

		wOut.h1_1r = 	v(pos+6) *wIn.h1_0r - v(pos+7) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r - v(pos+9) *wIn.h1_1i + 
						v(pos+10)*wIn.h1_2r- v(pos+11)*wIn.h1_2i;
		wOut.h1_1i = 	v(pos+6) *wIn.h1_0i + v(pos+7) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i + v(pos+9) *wIn.h1_1r + 
						v(pos+10)*wIn.h1_2i+ v(pos+11)*wIn.h1_2r;

		wOut.h0_2r = 	v(pos+12)*wIn.h0_0r - v(pos+13)*wIn.h0_0i + 
						v(pos+14)*wIn.h0_1r - v(pos+15)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r - v(pos+17)*wIn.h0_2i;
		wOut.h0_2i = 	v(pos+12)*wIn.h0_0i + v(pos+13)*wIn.h0_0r + 
						v(pos+14)*wIn.h0_1i + v(pos+15)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i + v(pos+17)*wIn.h0_2r;

		wOut.h1_2r= 	v(pos+12)*wIn.h1_0r - v(pos+13)*wIn.h1_0i + 
						v(pos+14)*wIn.h1_1r - v(pos+15)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r- v(pos+17)*wIn.h1_2i;
		wOut.h1_2i= 	v(pos+12)*wIn.h1_0i + v(pos+13)*wIn.h1_0r + 
						v(pos+14)*wIn.h1_1i + v(pos+15)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i+ v(pos+17)*wIn.h1_2r;
		return wOut;
	}

	@Inline def MultD(wIn : HalfWilsonVector, iu : Long, dir : Long) : HalfWilsonVector
	{
		val wOut = new HalfWilsonVector();
		val pos = iu*18 + offsetFld(dir);
		wOut.h0_0r = 	v(pos+0) *wIn.h0_0r + v(pos+1) *wIn.h0_0i + 
						v(pos+6) *wIn.h0_1r + v(pos+7) *wIn.h0_1i + 
						v(pos+12)*wIn.h0_2r + v(pos+13)*wIn.h0_2i;
		wOut.h0_0i = 	v(pos+0) *wIn.h0_0i - v(pos+1) *wIn.h0_0r + 
						v(pos+6) *wIn.h0_1i - v(pos+7) *wIn.h0_1r + 
						v(pos+12)*wIn.h0_2i - v(pos+13)*wIn.h0_2r;

		wOut.h1_0r = 	v(pos+0) *wIn.h1_0r + v(pos+1) *wIn.h1_0i + 
						v(pos+6) *wIn.h1_1r + v(pos+7) *wIn.h1_1i + 
						v(pos+12)*wIn.h1_2r+ v(pos+13)*wIn.h1_2i;
		wOut.h1_0i = 	v(pos+0) *wIn.h1_0i - v(pos+1) *wIn.h1_0r + 
						v(pos+6) *wIn.h1_1i - v(pos+7) *wIn.h1_1r + 
						v(pos+12)*wIn.h1_2i- v(pos+13)*wIn.h1_2r;

		wOut.h0_1r = 	v(pos+2) *wIn.h0_0r + v(pos+3) *wIn.h0_0i + 
						v(pos+8) *wIn.h0_1r + v(pos+9) *wIn.h0_1i + 
						v(pos+14)*wIn.h0_2r + v(pos+15)*wIn.h0_2i;
		wOut.h0_1i = 	v(pos+2) *wIn.h0_0i - v(pos+3) *wIn.h0_0r + 
						v(pos+8) *wIn.h0_1i - v(pos+9) *wIn.h0_1r + 
						v(pos+14)*wIn.h0_2i - v(pos+15)*wIn.h0_2r;

		wOut.h1_1r = 	v(pos+2) *wIn.h1_0r + v(pos+3) *wIn.h1_0i + 
						v(pos+8) *wIn.h1_1r + v(pos+9) *wIn.h1_1i + 
						v(pos+14)*wIn.h1_2r+ v(pos+15)*wIn.h1_2i;
		wOut.h1_1i = 	v(pos+2) *wIn.h1_0i - v(pos+3) *wIn.h1_0r + 
						v(pos+8) *wIn.h1_1i - v(pos+9) *wIn.h1_1r + 
						v(pos+14)*wIn.h1_2i- v(pos+15)*wIn.h1_2r;

		wOut.h0_2r = 	v(pos+4) *wIn.h0_0r + v(pos+5) *wIn.h0_0i + 
						v(pos+10)*wIn.h0_1r + v(pos+11)*wIn.h0_1i + 
						v(pos+16)*wIn.h0_2r + v(pos+17)*wIn.h0_2i;
		wOut.h0_2i = 	v(pos+4) *wIn.h0_0i - v(pos+5) *wIn.h0_0r + 
						v(pos+10)*wIn.h0_1i - v(pos+11)*wIn.h0_1r + 
						v(pos+16)*wIn.h0_2i - v(pos+17)*wIn.h0_2r;

		wOut.h1_2r= 	v(pos+4) *wIn.h1_0r + v(pos+5) *wIn.h1_0i + 
						v(pos+10)*wIn.h1_1r + v(pos+11)*wIn.h1_1i + 
						v(pos+16)*wIn.h1_2r+ v(pos+17)*wIn.h1_2i;
		wOut.h1_2i= 	v(pos+4) *wIn.h1_0i - v(pos+5) *wIn.h1_0r + 
						v(pos+10)*wIn.h1_1i - v(pos+11)*wIn.h1_1r + 
						v(pos+16)*wIn.h1_2i- v(pos+17)*wIn.h1_2r;
		return wOut;
	}


}



