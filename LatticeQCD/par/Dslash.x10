

import x10.compiler.Inline;
import x10.compiler.Pragma;


import x10.util.Team;

import Lattice;
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
	val rngLA : Rail[LongRange];

	val sendXP : PlaceLocalHandle[Rail[Double]];
	val sendXM : PlaceLocalHandle[Rail[Double]];
	val sendYP : PlaceLocalHandle[Rail[Double]];
	val sendYM : PlaceLocalHandle[Rail[Double]];
	val sendZP : PlaceLocalHandle[Rail[Double]];
	val sendZM : PlaceLocalHandle[Rail[Double]];
	val sendTP : PlaceLocalHandle[Rail[Double]];
	val sendTM : PlaceLocalHandle[Rail[Double]];

	val recvXP : PlaceLocalHandle[Rail[Double]];
	val recvXM : PlaceLocalHandle[Rail[Double]];
	val recvYP : PlaceLocalHandle[Rail[Double]];
	val recvYM : PlaceLocalHandle[Rail[Double]];
	val recvZP : PlaceLocalHandle[Rail[Double]];
	val recvZM : PlaceLocalHandle[Rail[Double]];
	val recvTP : PlaceLocalHandle[Rail[Double]];
	val recvTM : PlaceLocalHandle[Rail[Double]];

	val refBuffers : PlaceLocalHandle[Rail[GlobalRail[Double]]];	

	val sizeXBnd : Long;
	val sizeYBnd : Long;
	val sizeZBnd : Long;
	val sizeTBnd : Long;

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

		val sizeX = 2*3*2*Ny*Nz*Nt*2;
		val sizeY = 2*3*2*Nx*Nz*Nt*2;
		val sizeZ = 2*3*2*Nx*Ny*Nt*2;
		val sizeT = 2*3*2*Nx*Ny*Nz*2;
		sizeXBnd = sizeX;
		sizeYBnd = sizeY;
		sizeZBnd = sizeZ;
		sizeTBnd = sizeT;

		sendXP = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeX));
		sendXM = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeX));
		sendYP = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeY));
		sendYM = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeY));
		sendZP = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeZ));
		sendZM = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeZ));
		sendTP = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeT));
		sendTM = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeT));

		recvXP = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeX));
		recvXM = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeX));
		recvYP = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeY));
		recvYM = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeY));
		recvZP = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeZ));
		recvZM = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeZ));
		recvTP = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeT));
		recvTM = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](sizeT));

		refBuffers = PlaceLocalHandle.make[Rail[GlobalRail[Double]]](Place.places(), ()=>new Rail[GlobalRail[Double]](8));
	}

	def setup()
	{
		finish for(p in Place.places()){
			at(p) async {
				refBuffers()(XP) = at(Place(procNeighbors()(XM)))  GlobalRail[Double](recvXP());
				refBuffers()(XM) = at(Place(procNeighbors()(XP)))  GlobalRail[Double](recvXM());
				refBuffers()(YP) = at(Place(procNeighbors()(YM)))  GlobalRail[Double](recvYP());
				refBuffers()(YM) = at(Place(procNeighbors()(YP)))  GlobalRail[Double](recvYM());
				refBuffers()(ZP) = at(Place(procNeighbors()(ZM)))  GlobalRail[Double](recvZP());
				refBuffers()(ZM) = at(Place(procNeighbors()(ZP)))  GlobalRail[Double](recvZM());
				refBuffers()(TP) = at(Place(procNeighbors()(TM)))  GlobalRail[Double](recvTP());
				refBuffers()(TM) = at(Place(procNeighbors()(TP)))  GlobalRail[Double](recvTM());
			}
		}
	}

	def MakeXPBnd( w : Rail[Double])
	{
		if(Px == 1){
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				for(i in rngX(tid)){
					t1.PackXP(w,i*Nx);
					t1.Store(recvXP(),i);
				}
			}
		}
		else{
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				for(i in rngX(tid)){
					t1.PackXP(w,i*Nx);
					t1.Store(sendXP(),i);
				}
			}
			Rail.asyncCopy[Double](sendXP(),0,refBuffers()(XP),0,sizeXBnd);
		}
	}
	def SetXPBnd(v : Rail[Double], u : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngX(tid)){
				t1.Load(recvXP(),i);
				t2.Mult(u,t1,i*Nx + Nx - 1 + DIR_X*nsite);
				t2.UnpackXP(v,i*Nx + Nx - 1,cks);
			}
		}
	}

	def MakeXMBnd(u : Rail[Double], w : Rail[Double])
	{
		if(Px == 1){
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				val t2 = new HalfWilsonVector();
				for(i in rngX(tid)){
					t1.PackXM(w,i*Nx + Nx-1);
					t2.MultD(u,t1,i*Nx + Nx-1 + DIR_X*nsite);
					t2.Store(recvXM(),i);
				}
			}
		}
		else{
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				val t2 = new HalfWilsonVector();
				for(i in rngX(tid)){
					t1.PackXM(w,i*Nx + Nx-1);
					t2.MultD(u,t1,i*Nx + Nx-1 + DIR_X*nsite);
					t2.Store(sendXM(),i);
				}
			}
			Rail.asyncCopy[Double](sendXM(),0,refBuffers()(XM),0,sizeXBnd);
		}
	}
	def SetXMBnd(v : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			for(i in rngX(tid)){
				t1.Load(recvXM(),i);
				t1.UnpackXM(v,i*Nx,cks);
			}
		}
	}

	def MakeYPBnd( w : Rail[Double])
	{
		if(Py == 1){
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				for(i in rngYOut(tid)){
					for(j in rngYInBnd(tid)){
						t1.PackYP(w,i*Nxy + j);
						t1.Store(recvYP(),j + i*Nx);
					}
				}
			}
		}
		else{
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				for(i in rngYOut(tid)){
					for(j in rngYInBnd(tid)){
						t1.PackYP(w,i*Nxy + j);
						t1.Store(sendYP(),j + i*Nx);
					}
				}
			}
			Rail.asyncCopy[Double](sendYP(),0,refBuffers()(YP),0,sizeYBnd);
		}
	}
	def SetYPBnd(v : Rail[Double], u : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYInBnd(tid)){
					t1.Load(recvYP(),j + i*Nx);
					t2.Mult(u,t1,i*Nxy + Nxy-Nx + j + DIR_Y*nsite);
					t2.UnpackYP(v,i*Nxy + Nxy-Nx + j,cks);
				}
			}
		}
	}
	def MakeYMBnd(u : Rail[Double], w : Rail[Double])
	{
		if(Py == 1){
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				val t2 = new HalfWilsonVector();
				for(i in rngYOut(tid)){
					for(j in rngYInBnd(tid)){
						t1.PackYM(w,i*Nxy + Nxy-Nx + j);
						t2.MultD(u,t1,i*Nxy + Nxy-Nx + j + DIR_Y*nsite);
						t2.Store(recvYM(),j + i*Nx);
					}
				}
			}
		}
		else{
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				val t2 = new HalfWilsonVector();
				for(i in rngYOut(tid)){
					for(j in rngYInBnd(tid)){
						t1.PackYM(w,i*Nxy + Nxy-Nx + j);
						t2.MultD(u,t1,i*Nxy + Nxy-Nx + j + DIR_Y*nsite);
						t2.Store(sendYM(),j + i*Nx);
					}
				}
			}
			Rail.asyncCopy[Double](sendYM(),0,refBuffers()(YM),0,sizeYBnd);
		}
	}
	def SetYMBnd(v : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYInBnd(tid)){
					t1.Load(recvYM(),j + i*Nx);
					t1.UnpackYM(v,i*Nxy + j,cks);
				}
			}
		}
	}
	def MakeZPBnd(w : Rail[Double])
	{
		if(Pz == 1){
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				for(i in rngZOut(tid)){
					for(j in rngZInBnd(tid)){
						t1.PackZP(w,i*Nxyz + j);
						t1.Store(recvZP(),j + i*Nxy);
					}
				}
			}
		}
		else{
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				for(i in rngZOut(tid)){
					for(j in rngZInBnd(tid)){
						t1.PackZP(w,i*Nxyz + j);
						t1.Store(sendZP(),j + i*Nxy);
					}
				}
			}
			Rail.asyncCopy[Double](sendZP(),0,refBuffers()(ZP),0,sizeZBnd);
		}

	}
	def SetZPBnd(v : Rail[Double], u : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZInBnd(tid)){
					t1.Load(recvZP(),j + i*Nxy);
					t2.Mult(u,t1,i*Nxyz + Nxyz-Nxy + j + DIR_Z*nsite);
					t2.UnpackZP(v,i*Nxyz + Nxyz-Nxy + j,cks);
				}
			}
		}
	}
	
	def MakeZMBnd( u : Rail[Double], w : Rail[Double])
	{
		if(Pz == 1){
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				val t2 = new HalfWilsonVector();
				for(i in rngZOut(tid)){
					for(j in rngZInBnd(tid)){
						t1.PackZM(w,i*Nxyz + Nxyz-Nxy + j);
						t2.MultD(u,t1,i*Nxyz + Nxyz-Nxy + j + DIR_Z*nsite);
						t2.Store(recvZM(),j + i*Nxy);
					}
				}
			}
		}
		else{
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				val t2 = new HalfWilsonVector();
				for(i in rngZOut(tid)){
					for(j in rngZInBnd(tid)){
						t1.PackZM(w,i*Nxyz + Nxyz-Nxy + j);
						t2.MultD(u,t1,i*Nxyz + Nxyz-Nxy + j + DIR_Z*nsite);
						t2.Store(sendZM(),j + i*Nxy);
					}
				}
			}
			Rail.asyncCopy[Double](sendZM(),0,refBuffers()(ZM),0,sizeZBnd);
		}
	}
	def SetZMBnd(v : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZInBnd(tid)){
					t1.Load(recvZM(),j + i*Nxy);
					t1.UnpackZM(v,i*Nxyz + j,cks);
				}
			}
		}
	}

	def MakeTPBnd(w : Rail[Double])
	{
		if(Pt == 1){
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				for(i in rngTBnd(tid)){
					t1.PackTP(w,i);
					t1.Store(recvTP(),i);
				}
			}
		}
		else{
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				for(i in rngTBnd(tid)){
					t1.PackTP(w,i);
					t1.Store(sendTP(),i);
				}
			}
			Rail.asyncCopy[Double](sendTP(),0,refBuffers()(TP),0,sizeTBnd);
		}
	}
	def SetTPBnd(v : Rail[Double], u : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngTBnd(tid)){
				t1.Load(recvTP(),i);
				t2.Mult(u,t1,nsite-Nxyz + i + DIR_T*nsite);
				t2.UnpackTP(v,nsite-Nxyz + i,cks);
			}
		}
	}


	def MakeTMBnd(u : Rail[Double], w : Rail[Double])
	{
		if(Pt == 1){
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				val t2 = new HalfWilsonVector();
				for(i in rngTBnd(tid)){
					t1.PackTM(w,nsite-Nxyz + i);
					t2.MultD(u,t1,nsite-Nxyz + i + DIR_T*nsite);
					t2.Store(recvTM(),i);
				}
			}
		}
		else{
			@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
				val t1 = new HalfWilsonVector();
				val t2 = new HalfWilsonVector();
				for(i in rngTBnd(tid)){
					t1.PackTM(w,nsite-Nxyz + i);
					t2.MultD(u,t1,nsite-Nxyz + i + DIR_T*nsite);
					t2.Store(sendTM(),i);
				}
			}
			Rail.asyncCopy[Double](sendTM(),0,refBuffers()(TM),0,sizeTBnd);
		}
	}
	def SetTMBnd(v : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			for(i in rngTBnd(tid)){
				t1.Load(recvTM(),i);
				t1.UnpackTM(v,i,cks);
			}
		}
	}

	def MultXP(v : Rail[Double], u : Rail[Double], w : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngX(tid)){
				for(j in 0..(Nx-2)){
					t1.PackXP(w,i*Nx + j + 1);
					t2.Mult(u,t1,i*Nx + j + DIR_X*nsite);
					t2.UnpackXP(v,i*Nx + j,cks);
				}
			}
		}
	}
	def MultXM(v : Rail[Double], u : Rail[Double], w : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngX(tid)){
				for(j in 1..(Nx-1)){
					t1.PackXM(w,i*Nx + j - 1);
					t2.MultD(u,t1,i*Nx + j - 1 + DIR_X*nsite);
					t2.UnpackXM(v,i*Nx + j,cks);
				}
			}
		}
	}

	def MultYP(v : Rail[Double], u : Rail[Double], w : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYIn(tid)){
					t1.PackYP(w,i*Nxy + j + Nx);
					t2.Mult(u,t1,i*Nxy + j + DIR_Y*nsite);
					t2.UnpackYP(v,i*Nxy + j,cks);
				}
			}
		}
	}
	def MultYM(v : Rail[Double], u : Rail[Double], w : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngYOut(tid)){
				for(j in rngYIn(tid)){
					t1.PackYM(w,i*Nxy + j);
					t2.MultD(u,t1,i*Nxy + j + DIR_Y*nsite);
					t2.UnpackYM(v,i*Nxy + j + Nx,cks);
				}
			}
		}
	}

	def MultZP(v : Rail[Double], u : Rail[Double], w : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZIn(tid)){
					t1.PackZP(w,i*Nxyz + j + Nxy);
					t2.Mult(u,t1,i*Nxyz + j + DIR_Z*nsite);
					t2.UnpackZP(v,i*Nxyz + j,cks);
				}
			}
		}
	}
	def MultZM(v : Rail[Double], u : Rail[Double], w : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngZOut(tid)){
				for(j in rngZIn(tid)){
					t1.PackZM(w,i*Nxyz + j);
					t2.MultD(u,t1,i*Nxyz + j + DIR_Z*nsite);
					t2.UnpackZM(v,i*Nxyz + j + Nxy,cks);
				}
			}
		}
	}

	def MultTP(v : Rail[Double], u : Rail[Double], w : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngT(tid)){
				t1.PackTP(w,i + Nxyz);
				t2.Mult(u,t1,i + DIR_T*nsite);
				t2.UnpackTP(v,i,cks);
			}
		}
	}
	def MultTM(v : Rail[Double], u : Rail[Double], w : Rail[Double], cks : Double)
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			val t1 = new HalfWilsonVector();
			val t2 = new HalfWilsonVector();
			for(i in rngT(tid)){
				t1.PackTM(w,i);
				t2.MultD(u,t1,i + DIR_T*nsite);
				t2.UnpackTM(v,i + Nxyz,cks);
			}
		}
	}

	def Copy(v : Rail[Double], w : Rail[Double])
	{
		@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
			for(i in rngLA(tid)){
				v(i) = w(i);
			}
		}
	}

	def Dopr(v : PlaceLocalHandle[Rail[Double]], u : PlaceLocalHandle[Rail[Double]], w : PlaceLocalHandle[Rail[Double]],cks : Double)
	{

		finish for(p in Place.places()) at(p) async {

			MakeTPBnd(w());
			MakeTMBnd(u(),w());

			MakeXPBnd(w());
			MakeXMBnd(u(),w());

			MakeYPBnd(w());
			MakeYMBnd(u(),w());

			MakeZPBnd(w());
			MakeZMBnd(u(),w());

			Copy(v(),w());

			//local calculations
			MultTP(v(),u(),w(),-cks);
			MultTM(v(),u(),w(),-cks);

			MultXP(v(),u(),w(),-cks);
			MultXM(v(),u(),w(),-cks);

			MultYP(v(),u(),w(),-cks);
			MultYM(v(),u(),w(),-cks);

			MultZP(v(),u(),w(),-cks);
			MultZM(v(),u(),w(),-cks);
		}

		finish for(p in Place.places()) at(p) async {		//boundary part

			SetTPBnd(v(),u(),-cks);
			SetTMBnd(v(),-cks);

			SetXPBnd(v(),u(),-cks);
			SetXMBnd(v(),-cks);

			SetYPBnd(v(),u(),-cks);
			SetYMBnd(v(),-cks);

			SetZPBnd(v(),u(),-cks);
			SetZMBnd(v(),-cks);
		}
	}


	def DoprH(v : PlaceLocalHandle[Rail[Double]], u : PlaceLocalHandle[Rail[Double]], w : PlaceLocalHandle[Rail[Double]],cks : Double)
	{
		Dopr(v,u,w,cks);

		finish for(p in Place.places()){
			at(p) async {
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					val is = tid * nsite / nThreads;
					val ie = (tid + 1) * nsite / nThreads;

					var t0r : Double;
					var t0i : Double;
					var t1r : Double;
					var t1i : Double;
					var pos : Long = is*24;

					for(i in is..(ie-1)){
						t0r = v()(pos);
						t0i = v()(pos + 1);
						t1r = v()(pos + 6);
						t1i = v()(pos + 7);
						v()(pos    ) = v()(pos + 12);
						v()(pos + 1) = v()(pos + 13);
						v()(pos + 6) = v()(pos + 18);
						v()(pos + 7) = v()(pos + 19);
						v()(pos +12) = t0r;
						v()(pos +13) = t0i;
						v()(pos +18) = t1r;
						v()(pos +19) = t1i;

						t0r = v()(pos + 2);
						t0i = v()(pos + 3);
						t1r = v()(pos + 8);
						t1i = v()(pos + 9);
						v()(pos + 2) = v()(pos + 14);
						v()(pos + 3) = v()(pos + 15);
						v()(pos + 8) = v()(pos + 20);
						v()(pos + 9) = v()(pos + 21);
						v()(pos +14) = t0r;
						v()(pos +15) = t0i;
						v()(pos +20) = t1r;
						v()(pos +21) = t1i;

						t0r = v()(pos + 4);
						t0i = v()(pos + 5);
						t1r = v()(pos +10);
						t1i = v()(pos +11);
						v()(pos + 4) = v()(pos + 16);
						v()(pos + 5) = v()(pos + 17);
						v()(pos +10) = v()(pos + 22);
						v()(pos +11) = v()(pos + 23);
						v()(pos +16) = t0r;
						v()(pos +17) = t0i;
						v()(pos +22) = t1r;
						v()(pos +23) = t1i;
						pos = pos + 24;
					}
				}
			}
		}
	}



}


