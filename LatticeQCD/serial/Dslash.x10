

import WilsonVectorField;
import SU3MatrixField;


import x10.compiler.Inline;
import x10.compiler.Pragma;


import x10.util.Team;

import HalfWilsonVector;


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



public class Dslash extends Lattice {
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

	def this(x : Long,y : Long,z : Long,t : Long, nid : Long)
	{
		super(x,y,z,t);

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
		}
	}

	def MultXPBnd(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngX(tid)){
				w.PackXP(t1,i*Nx);
				u.Mult(t2,t1,i*Nx + Nx - 1,DIR_X);
				v.UnpackXP(t2,i*Nx + Nx - 1,cks);
			}
		}
	}
	def MultXMBnd(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngX(tid)){
				w.PackXM(t1,i*Nx + Nx-1);
				u.MultD(t2,t1,i*Nx + Nx-1,DIR_X);
				v.UnpackXM(t2,i*Nx,cks);
			}
		}
	}

	def MultYPBnd(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYInBnd(tid)){
					w.PackYP(t1,i*Nxy + j);
					u.Mult(t2,t1,i*Nxy + Nxy-Nx + j,DIR_Y);
					v.UnpackYP(t2,i*Nxy + Nxy-Nx + j,cks);
				}
			}
		}
	}
	def MultYMBnd(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYInBnd(tid)){
					w.PackYM(t1,i*Nxy + Nxy-Nx + j);
					u.MultD(t2,t1,i*Nxy + Nxy-Nx + j,DIR_Y);
					v.UnpackYM(t2,i*Nxy + j,cks);
				}
			}
		}
	}

	def MultZPBnd(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZInBnd(tid)){
					w.PackZP(t1,i*Nxyz + j);
					u.Mult(t2,t1,i*Nxyz + Nxyz-Nxy + j,DIR_Z);
					v.UnpackZP(t2,i*Nxyz + Nxyz-Nxy + j,cks);
				}
			}
		}
	}
	def MultZMBnd(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZInBnd(tid)){
					w.PackZM(t1,i*Nxyz + Nxyz-Nxy + j);
					u.MultD(t2,t1,i*Nxyz + Nxyz-Nxy + j,DIR_Z);
					v.UnpackZM(t2,i*Nxyz + j,cks);
				}
			}
		}
	}

	def MultTPBnd(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngTBnd(tid)){
				w.PackTP(t1,i);
				u.Mult(t2,t1,nsite-Nxyz + i,DIR_T);
				v.UnpackTP(t2,nsite-Nxyz + i,cks);
			}
		}
	}
	def MultTMBnd(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngTBnd(tid)){
				w.PackTM(t1,nsite-Nxyz + i);
				u.MultD(t2,t1,nsite-Nxyz + i,DIR_T);
				v.UnpackTM(t2,i,cks);
			}
		}
	}

	def MultXP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngX(tid)){
				for(j in 0..(Nx-2)){
					w.PackXP(t1,i*Nx + j + 1);
					u.Mult(t2,t1,i*Nx + j,DIR_X);
					v.UnpackXP(t2,i*Nx + j,cks);
				}
			}
		}
	}
	def MultXM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngX(tid)){
				for(j in 1..(Nx-1)){
					w.PackXM(t1,i*Nx + j - 1);
					u.MultD(t2,t1,i*Nx + j - 1,DIR_X);
					v.UnpackXM(t2,i*Nx + j,cks);
				}
			}
		}
	}

	def MultYP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYIn(tid)){
					w.PackYP(t1,i*Nxy + j + Nx);
					u.Mult(t2,t1,i*Nxy + j,DIR_Y);
					v.UnpackYP(t2,i*Nxy + j,cks);
				}
			}
		}
	}
	def MultYM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYIn(tid)){
					w.PackYM(t1,i*Nxy + j);
					u.MultD(t2,t1,i*Nxy + j,DIR_Y);
					v.UnpackYM(t2,i*Nxy + j + Nx,cks);
				}
			}
		}
	}

	def MultZP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZIn(tid)){
					w.PackZP(t1,i*Nxyz + j + Nxy);
					u.Mult(t2,t1,i*Nxyz + j,DIR_Z);
					v.UnpackZP(t2,i*Nxyz + j,cks);
				}
			}
		}
	}
	def MultZM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZIn(tid)){
					w.PackZM(t1,i*Nxyz + j);
					u.MultD(t2,t1,i*Nxyz + j,DIR_Z);
					v.UnpackZM(t2,i*Nxyz + j + Nxy,cks);
				}
			}
		}
	}

	def MultTP(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngT(tid)){
				w.PackTP(t1,i + Nxyz);
				u.Mult(t2,t1,i,DIR_T);
				v.UnpackTP(t2,i,cks);
			}
		}
	}
	def MultTM(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField, cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngT(tid)){
				w.PackTM(t1,i);
				u.MultD(t2,t1,i,DIR_T);
				v.UnpackTM(t2,i + Nxyz,cks);
			}
		}
	}

	def Dopr(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double)
	{
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

		//boundary part
		MultTPBnd(v,u,w,-cks);
		MultTMBnd(v,u,w,-cks);

		MultXPBnd(v,u,w,-cks);
		MultXMBnd(v,u,w,-cks);

		MultYPBnd(v,u,w,-cks);
		MultYMBnd(v,u,w,-cks);

		MultZPBnd(v,u,w,-cks);
		MultZMBnd(v,u,w,-cks);
	}

	def DoprH(v : WilsonVectorField, u : SU3MatrixField, w : WilsonVectorField,cks : Double)
	{
		Dopr(v,u,w,cks);

		v.MultGamma5();
	}



}


