

import Lattice;

final class GetGCD {
	static def Do(a : Long, b: Long)
	{
		var i : Long;
		var j : Long;
		var t : Long;

		if(a == b){
			return a;
		}
		else if(a > b){
			t = b;
			j = a;
		}
		else{
			j = b;
			t = a;
		}
		i = j;
		j = t;
		t = j % i;
		while(t != 0){
			i = j;
			j = t;
			t = j % i;
		}
		return i;
	}
}


public class ThreadParallelLattice extends Lattice {
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

		var no : Long;
		var ni : Long;
		var io : Long;
		var ii : Long;
		var g0 : Long;
		var g1 : Long;

		nThreads = nid;

		rngLA = new Rail[LongRange](nThreads);
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
			rngZSnd(tid) = new LongRange(rngZOut(tid).min*Nxy + rngZInBnd(tid).min,rngZOut.max*Nxy + rngZInBnd(tid).max);

			rngTBnd(tid) = new LongRange(tid * Nxyz / nid, (tid + 1) * Nxyz / nid-1);
			rngT(tid) = new LongRange(tid * (nsite-Nxyz) / nid, (tid + 1) * (nsite-Nxyz) / nid-1);
		}
	}


}





