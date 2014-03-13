

import x10.compiler.Inline;
import x10.compiler.Pragma;

import x10.array.*;


import x10.util.Team;

import DistHalfWilsonVector;



final class GetGCD {
	static def Do(ia : Long, ib: Long)
	{
		var a : Long;
		var b : Long;
		var r : Long;

		if(ia == ib){
			return ia;
		}
		else if(ia > ib){
			a = ia;
			b = ib;
		}
		else{
			b = ia;
			a = ib;
		}

		do{
			r = a % b;
			a = b;
			b = r;
		}while(r > 0);

		return a;
	}
}



public class DistDslash extends DistLattice {
	val nThreads : Long;
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
	val rngLA : Rail[LongRange];


	def this(x : Long,y : Long,z : Long,t : Long, npx : Long, npy : Long, npz : Long, npt : Long)
	{
		super(x,y,z,t,npx,npy,npz,npt);

		nThreads = Runtime.NTHREADS;

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
		rngLA = new Rail[LongRange](nThreads);

		var no : Long;
		var ni : Long;
		var io : Long;
		var ii : Long;
		var g0 : Long;
		var g1 : Long;
		for(tid in 0..(nThreads - 1)){
			rngX(tid) = new LongRange(tid * Ny*Nz*Nt / nThreads,(tid + 1) * Ny*Nz*Nt / nThreads-1);

			no = GetGCD.Do(Nt*Nz,nThreads);
			ni = nThreads / no;
			ii = tid % ni;
			io = tid / ni;

			rngYOut(tid) = new LongRange(io * Nt*Nz / no,(io + 1) * Nt*Nz / no-1);
			rngYInBnd(tid)  = new LongRange(ii * Nx / ni,(ii + 1) * Nx / ni-1);
			rngYIn(tid)  = new LongRange(ii * (Nxy - Nx) / ni,(ii + 1) * (Nxy - Nx) / ni-1);
			rngYSnd(tid) = new LongRange(rngYOut(tid).min*Nx + rngYInBnd(tid).min,rngYOut(tid).max*Nx + rngYInBnd(tid).max);

			no = GetGCD.Do(Nt,nThreads);
			ni = nThreads / no;
			ii = tid % ni;
			io = tid / ni;

			rngZOut(tid) = new LongRange(io * Nt / no,(io + 1) * Nt / no-1);
			rngZInBnd(tid)  = new LongRange(ii * Nxy / ni,(ii + 1) * Nxy / ni-1);
			rngZIn(tid)  = new LongRange(ii * (Nxyz-Nxy) / ni,(ii + 1) * (Nxyz-Nxy) / ni-1);
			rngZSnd(tid) = new LongRange(rngZOut(tid).min*Nxy + rngZInBnd(tid).min,rngZOut(tid).max*Nxy + rngZInBnd(tid).max);

			rngTBnd(tid) = new LongRange(tid * Nxyz / nThreads, (tid + 1) * Nxyz / nThreads-1);
			rngT(tid) = new LongRange(tid * (nsite-Nxyz) / nThreads, (tid + 1) * (nsite-Nxyz) / nThreads-1);

			rngLA(tid) = new LongRange(tid * nsite*24 / nThreads,(tid + 1) * nsite*24 / nThreads - 1);
		}

	}

	def setup()
	{
	}

	def MultXPBnd(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		if(Px == 1){
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();

				for(i in rngX(tid)){
					t1.PackXP(w,i*Nx);
					t2.Mult(u,t1,i*Nx + Nx - 1 + DIR_X*nsite);
					t2.UnpackXP(v,i*Nx + Nx - 1,cks);
				}
			}
		}
		else{
			val nep = Place(procNeighbors(here.id()*8 + XP));
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();

				for(i in rngX(tid)){
					at(nep) t1.PackXP(v,i*Nx);
					t2.Mult(u,t1,i*Nx + Nx - 1 + DIR_X*nsite);
					t2.UnpackXP(v,i*Nx + Nx - 1,cks);
				}
			}
		}
	}

	
	def MultXMBnd(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		if(Px == 1){
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngX(tid)){
					t1.PackXM(w,i*Nx + Nx-1);
					t2.MultD(u,t1,i*Nx + Nx-1 + DIR_X*nsite);
					t2.UnpackXM(v,i*Nx,cks);
				}
			}
		}
		else{
			val nep = Place(procNeighbors(here.id()*8 + XM));
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngX(tid)){
					at(nep) t2.MultD(u,t1.PackXM(w,i*Nx + Nx-1),i*Nx + Nx-1 + DIR_X*nsite);
					t2.UnpackXM(v,i*Nx,cks);
				}
			}
		}
	}

	def MultYPBnd(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		if(Py == 1){
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngYOut(tid)){
					for(j in rngYInBnd(tid)){
						t1.PackYP(w,i*Nxy + j);
						t2.Mult(u,t1,i*Nxy + Nxy-Nx + j + DIR_Y*nsite);
						t2.UnpackYP(v,i*Nxy + Nxy-Nx + j,cks);
					}
				}
			}
		}
		else{
			val nep = Place(procNeighbors(here.id()*8 + YP));
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngYOut(tid)){
					for(j in rngYInBnd(tid)){
						at(nep) t1.PackYP(w,i*Nxy + j);
						t2.Mult(u,t1,i*Nxy + Nxy-Nx + j + DIR_Y*nsite);
						t2.UnpackYP(v,i*Nxy + Nxy-Nx + j,cks);
					}
				}
			}
		}
	}
	def MultYMBnd(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		if(Py == 1){
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngYOut(tid)){
					for(j in rngYInBnd(tid)){
						t1.PackYM(w,i*Nxy + Nxy-Nx + j);
						t2.MultD(u,t1,i*Nxy + Nxy-Nx + j + DIR_Y*nsite);
						t2.UnpackYM(v,i*Nxy + j,cks);
					}
				}
			}
		}
		else{
			val nep = Place(procNeighbors(here.id()*8 + YM));
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngYOut(tid)){
					for(j in rngYInBnd(tid)){
						at(nep) t2.MultD(u,t1.PackYM(w,i*Nxy + Nxy-Nx + j),i*Nxy + Nxy-Nx + j + DIR_Y*nsite);
						t2.UnpackYM(v,i*Nxy + j,cks);
					}
				}
			}
		}
	}
	def MultZPBnd(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		if(Pz == 1){
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngZOut(tid)){
					for(j in rngZInBnd(tid)){
						t1.PackZP(w,i*Nxyz + j);
						t2.Mult(u,t1,i*Nxyz + Nxyz-Nxy + j + DIR_Z*nsite);
						t2.UnpackZP(v,i*Nxyz + Nxyz-Nxy + j,cks);
					}
				}
			}
		}
		else{
			val nep = Place(procNeighbors(here.id()*8 + ZP));
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngZOut(tid)){
					for(j in rngZInBnd(tid)){
						at(nep) t1.PackZP(w,i*Nxyz + j);
						t2.Mult(u,t1,i*Nxyz + Nxyz-Nxy + j + DIR_Z*nsite);
						t2.UnpackZP(v,i*Nxyz + Nxyz-Nxy + j,cks);
					}
				}
			}
		}
	}
	
	def MultZMBnd(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		if(Pz == 1){
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngZOut(tid)){
					for(j in rngZInBnd(tid)){
						t1.PackZM(w,i*Nxyz + Nxyz-Nxy + j);
						t2.MultD(u,t1,i*Nxyz + Nxyz-Nxy + j + DIR_Z*nsite);
						t2.UnpackZM(v,i*Nxyz + j,cks);
					}
				}
			}
		}
		else{
			val nep = Place(procNeighbors(here.id()*8 + ZM));
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngZOut(tid)){
					for(j in rngZInBnd(tid)){
						at(nep) t2.MultD(u,t1.PackZM(w,i*Nxyz + Nxyz-Nxy + j),i*Nxyz + Nxyz-Nxy + j + DIR_Z*nsite);
						t2.UnpackZM(v,i*Nxyz + j,cks);
					}
				}
			}
		}
	}

	def MultTPBnd(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		if(Pt == 1){
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngTBnd(tid)){
					t1.PackTP(w,i);
					t2.Mult(u,t1,nsite-Nxyz + i + DIR_T*nsite);
					t2.UnpackTP(v,nsite-Nxyz + i,cks);
				}
			}
		}
		else{
			val nep = Place(procNeighbors(here.id()*8 + TP));
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				var tr : DistHalfWilsonVector;
				for(i in rngTBnd(tid)){
					tr = at(nep) t1.PackTP(w,i);
					t2.Mult(u,tr,nsite-Nxyz + i + DIR_T*nsite);
					t2.UnpackTP(v,nsite-Nxyz + i,cks);
				}
			}
		}
	}

	
	def MultTMBnd(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		if(Pt == 1){
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				for(i in rngTBnd(tid)){
					t1.PackTM(w,nsite-Nxyz + i);
					t2.MultD(u,t1,nsite-Nxyz + i + DIR_T*nsite);
					t2.UnpackTM(v,i,cks);
				}
			}
		}
		else{
			val nep = Place(procNeighbors(here.id()*8 + TM));
			@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
				val t1 = new DistHalfWilsonVector();
				val t2 = new DistHalfWilsonVector();
				var tr : DistHalfWilsonVector;
				for(i in rngTBnd(tid)){
					tr = at(nep) t2.PackTMultD(u,w,nsite-Nxyz + i + DIR_T*nsite,nsite-Nxyz + i);
					tr.UnpackTM(v,i,cks);
				}
			}
		}
	}

	def MultXP(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
			val t1 = new DistHalfWilsonVector();
			val t2 = new DistHalfWilsonVector();
			for(i in rngX(tid)){
				for(j in 0..(Nx-2)){
					t1.PackXP(w,i*Nx + j + 1);
					t2.Mult(u,t1,i*Nx + j + DIR_X*nsite);
					t2.UnpackXP(v,i*Nx + j,cks);
				}
			}
		}
	}
	def MultXM(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
			val t1 = new DistHalfWilsonVector();
			val t2 = new DistHalfWilsonVector();
			for(i in rngX(tid)){
				for(j in 1..(Nx-1)){
					t1.PackXM(w,i*Nx + j - 1);
					t2.MultD(u,t1,i*Nx + j - 1 + DIR_X*nsite);
					t2.UnpackXM(v,i*Nx + j,cks);
				}
			}
		}
	}

	def MultYP(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
			val t1 = new DistHalfWilsonVector();
			val t2 = new DistHalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYIn(tid)){
					t1.PackYP(w,i*Nxy + j + Nx);
					t2.Mult(u,t1,i*Nxy + j + DIR_Y*nsite);
					t2.UnpackYP(v,i*Nxy + j,cks);
				}
			}
		}
	}
	def MultYM(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
			val t1 = new DistHalfWilsonVector();
			val t2 = new DistHalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYIn(tid)){
					t1.PackYM(w,i*Nxy + j);
					t2.MultD(u,t1,i*Nxy + j + DIR_Y*nsite);
					t2.UnpackYM(v,i*Nxy + j + Nx,cks);
				}
			}
		}
	}

	def MultZP(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
			val t1 = new DistHalfWilsonVector();
			val t2 = new DistHalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZIn(tid)){
					t1.PackZP(w,i*Nxyz + j + Nxy);
					t2.Mult(u,t1,i*Nxyz + j + DIR_Z*nsite);
					t2.UnpackZP(v,i*Nxyz + j,cks);
				}
			}
		}
	}
	def MultZM(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
			val t1 = new DistHalfWilsonVector();
			val t2 = new DistHalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZIn(tid)){
					t1.PackZM(w,i*Nxyz + j);
					t2.MultD(u,t1,i*Nxyz + j + DIR_Z*nsite);
					t2.UnpackZM(v,i*Nxyz + j + Nxy,cks);
				}
			}
		}
	}

	def MultTP(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
			val t1 = new DistHalfWilsonVector();
			val t2 = new DistHalfWilsonVector();
			for(i in rngT(tid)){
				t1.PackTP(w,i + Nxyz);
				t2.Mult(u,t1,i + DIR_T*nsite);
				t2.UnpackTP(v,i,cks);
			}
		}
	}
	def MultTM(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) for(tid in 0..(nThreads-1)) async {
			val t1 = new DistHalfWilsonVector();
			val t2 = new DistHalfWilsonVector();
			for(i in rngT(tid)){
				t1.PackTM(w,i);
				t2.MultD(u,t1,i + DIR_T*nsite);
				t2.UnpackTM(v,i + Nxyz,cks);
			}
		}
	}

	def Dopr(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double],cks : Double)
	{
		finish for(p in v.placeGroup()){
			finish at(p) async {
				val offset = v.localIndices().min(0);
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					for(i in rngLA(tid)){
						v(offset + i) = w(offset + i);
					}
				}
			}

			finish at(p) async {
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

				//boundary part
			finish at(p) async {
				MultTPBnd(v,u,w,-cks);
				MultTMBnd(v,u,w,-cks);
			}

			finish at(p) async {
				MultXPBnd(v,u,w,-cks);
				MultXMBnd(v,u,w,-cks);
			}

			finish at(p) async {
				MultYPBnd(v,u,w,-cks);
				MultYMBnd(v,u,w,-cks);
			}

			finish at(p) async {
				MultZPBnd(v,u,w,-cks);
				MultZMBnd(v,u,w,-cks);
			}
		}
	}


	def DoprH(v : DistArray_Block_1[Double], u : DistArray_Block_1[Double], w : DistArray_Block_1[Double],cks : Double)
	{
		Dopr(v,u,w,cks);

		//v.MultGamma5();

		finish for(p in v.placeGroup()){
			at(p) async {
				val offset = v.localIndices().min(0);
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					val is = tid * nsite / nThreads;
					val ie = (tid + 1) * nsite / nThreads;

					var t0r : Double;
					var t0i : Double;
					var t1r : Double;
					var t1i : Double;
					var pos : Long = offset + is*24;

					for(i in is..(ie-1)){
						t0r = v(pos);
						t0i = v(pos + 1);
						t1r = v(pos + 6);
						t1i = v(pos + 7);
						v(pos    ) = v(pos + 12);
						v(pos + 1) = v(pos + 13);
						v(pos + 6) = v(pos + 18);
						v(pos + 7) = v(pos + 19);
						v(pos +12) = t0r;
						v(pos +13) = t0i;
						v(pos +18) = t1r;
						v(pos +19) = t1i;

						t0r = v(pos + 2);
						t0i = v(pos + 3);
						t1r = v(pos + 8);
						t1i = v(pos + 9);
						v(pos + 2) = v(pos + 14);
						v(pos + 3) = v(pos + 15);
						v(pos + 8) = v(pos + 20);
						v(pos + 9) = v(pos + 21);
						v(pos +14) = t0r;
						v(pos +15) = t0i;
						v(pos +20) = t1r;
						v(pos +21) = t1i;

						t0r = v(pos + 4);
						t0i = v(pos + 5);
						t1r = v(pos +10);
						t1i = v(pos +11);
						v(pos + 4) = v(pos + 16);
						v(pos + 5) = v(pos + 17);
						v(pos +10) = v(pos + 22);
						v(pos +11) = v(pos + 23);
						v(pos +16) = t0r;
						v(pos +17) = t0i;
						v(pos +22) = t1r;
						v(pos +23) = t1i;
						pos = pos + 24;
					}
				}
			}
		}
		
	}



}


