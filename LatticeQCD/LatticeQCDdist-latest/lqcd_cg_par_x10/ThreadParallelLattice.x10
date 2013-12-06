

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
	val tid : Long;
	val nid : Long;
	val rngLA : LongRange;
	val rngX : LongRange;
	val rngYOut : LongRange;
	val rngYInBnd : LongRange;
	val rngYIn : LongRange;
	val rngZOut : LongRange;
	val rngZInBnd : LongRange;
	val rngZIn : LongRange;
	val rngTBnd : LongRange;
	val rngT : LongRange;
	val rngYSnd : LongRange;
	val rngZSnd : LongRange;

	def this(x : Long,y : Long,z : Long,t : Long, i : Long, n : Long)
	{
		super(x,y,z,t);

		var no : Long;
		var ni : Long;
		var io : Long;
		var ii : Long;
		var g0 : Long;
		var g1 : Long;

		tid = i;
		nid = n;

			//we do not max-1 for the range of linear algebra
		rngLA = new LongRange(tid * nsite / nid,(tid + 1) * nsite / nid);

		rngX = new LongRange(tid * Ny*Nz*Nt / nid,(tid + 1) * Ny*Nz*Nt / nid-1);

		no = GetGCD.Do(Nt*Nz,nid);
		ni = nid / no;
		ii = tid % ni;
		io = tid / ni;

		rngYOut = new LongRange(io * Nt*Nz / no,(io + 1) * Nt*Nz / no-1);
		rngYInBnd  = new LongRange(ii * Nx / ni,(ii + 1) * Nx / ni-1);
		rngYIn  = new LongRange(ii * (Nxy - Nx) / ni,(ii + 1) * (Nxy - Nx) / ni-1);
		rngYSnd = new LongRange(rngYOut.min*Nx + rngYInBnd.min,rngYOut.max*Nx + rngYInBnd.max);

		no = GetGCD.Do(Nt,nid);
		ni = nid / no;
		ii = tid % ni;
		io = tid / ni;

		rngZOut = new LongRange(io * Nt / no,(io + 1) * Nt / no-1);
		rngZInBnd  = new LongRange(ii * Nxy / ni,(ii + 1) * Nxy / ni-1);
		rngZIn  = new LongRange(ii * (Nxyz-Nxy) / ni,(ii + 1) * (Nxyz-Nxy) / ni-1);
		rngZSnd = new LongRange(rngZOut.min*Nxy + rngZInBnd.min,rngZOut.max*Nxy + rngZInBnd.max);

		rngTBnd = new LongRange(tid * Nxyz / nid, (tid + 1) * Nxyz / nid-1);
		rngT = new LongRange(tid * (nsite-Nxyz) / nid, (tid + 1) * (nsite-Nxyz) / nid-1);

	}


}





