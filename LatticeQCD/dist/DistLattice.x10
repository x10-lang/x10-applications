
import x10.array.*;

public class DistLattice {
	static val XP = 0;
	static val XM = 1;
	static val YP = 2;
	static val YM = 3;
	static val ZP = 4;
	static val ZM = 5;
	static val TP = 6;
	static val TM = 7;
	static val DIR_X = 0;
	static val DIR_Y = 1;
	static val DIR_Z = 2;
	static val DIR_T = 3;
	val Nx : Long;
	val Ny : Long;
	val Nz : Long;
	val Nt : Long;
	val Lx : Long;
	val Ly : Long;
	val Lz : Long;
	val Lt : Long;
	val Px : Long;
	val Py : Long;
	val Pz : Long;
	val Pt : Long;
	val nprocs : Long;
	val nsite : Long;
	val Nxy : Long;
	val Nxyz : Long;
	val Nyzt : Long;
	val Nxzt : Long;
	val Nxyt : Long;
	val procPos : DistArray_Block_1[Long];
	val procNeighbors : DistArray_Block_1[Long];

	def this(x : Long,y : Long,z : Long,t : Long, npx : Long, npy : Long, npz : Long, npt : Long)
	{
		Lx = x;
		Ly = y;
		Lz = z;
		Lt = t;

		Nx = x/npx;
		Ny = y/npy;
		Nz = z/npz;
		Nt = t/npt;

		Px = npx;
		Py = npy;
		Pz = npz;
		Pt = npt;

		nprocs = npx*npy*npz*npt;

		nsite = Nx*Ny*Nz*Nt;

		Nxy = Nx*Ny;
		Nxyz = Nx*Ny*Nz;
		Nyzt = Ny*Nz*Nt;
		Nxzt = Nx*Nz*Nt;
		Nxyt = Nx*Ny*Nt;

		procPos = new DistArray_Block_1[Long](nprocs*4);
		procNeighbors = new DistArray_Block_1[Long](nprocs*8);
	}

	def GetNeighbor(dir : Long) : Long
	{
		val i = here.id();
		val pos  = new Rail[Long](4);
		val size  = new Rail[Long](4);

		pos(0) = i % Px;
		pos(1) = (i / Px) % Py;
		pos(2) = (i / Px/Py) % Pz;
		pos(3) = (i / Px/Py/Pz);

		size(0) = Px;
		size(1) = Py;
		size(2) = Pz;
		size(3) = Pt;
		pos(dir/2) = (pos(dir/2) + (1 - 2*(dir % 2)) + size(dir/2)) % size(dir/2);

		val ret = pos(0) + pos(1)*Px + pos(2)*Px*Py + pos(3)*Px*Py*Pz;
		return ret;
	}


	def init()
	{
		finish for(p in procPos.placeGroup()){
			at(p) async {
				val i = p.id();

				procPos(i*4 + 0) = i % Px;
				procPos(i*4 + 1) = (i / Px) % Py;
				procPos(i*4 + 2) = (i / Px/Py) % Pz;
				procPos(i*4 + 3) = (i / Px/Py/Pz);

				procNeighbors(i*8 + XP) = 	(procPos(i*4 + 0) + 1) % Px + 
										(procPos(i*4 + 1)) * Px +
										(procPos(i*4 + 2)) * Px * Py +
										(procPos(i*4 + 3)) * Px * Py * Pz;
				procNeighbors(i*8 + XM) = 	(procPos(i*4 + 0) - 1 + Px) % Px + 
										(procPos(i*4 + 1)) * Px +
										(procPos(i*4 + 2)) * Px * Py +
										(procPos(i*4 + 3)) * Px * Py * Pz;
				procNeighbors(i*8 + YP) = 	(procPos(i*4 + 0)) + 
										((procPos(i*4 + 1) + 1) % Py) * Px +
										(procPos(i*4 + 2)) * Px * Py +
										(procPos(i*4 + 3)) * Px * Py * Pz;
				procNeighbors(i*8 + YM) = 	(procPos(i*4 + 0)) + 
										((procPos(i*4 + 1) - 1 + Py) % Py) * Px +
										(procPos(i*4 + 2)) * Px * Py +
										(procPos(i*4 + 3)) * Px * Py * Pz;
				procNeighbors(i*8 + ZP) = 	(procPos(i*4 + 0)) + 
										(procPos(i*4 + 1)) * Px +
										((procPos(i*4 + 2) + 1) % Pz) * Px * Py +
										(procPos(i*4 + 3)) * Px * Py * Pz;
				procNeighbors(i*8 + ZM) = 	(procPos(i*4 + 0)) + 
										(procPos(i*4 + 1)) * Px +
										((procPos(i*4 + 2) - 1 + Pz) % Pz) * Px * Py +
										(procPos(i*4 + 3)) * Px * Py * Pz;
				procNeighbors(i*8 + TP) = 	(procPos(i*4 + 0)) + 
										(procPos(i*4 + 1)) * Px +
										(procPos(i*4 + 2)) * Px * Py +
										((procPos(i*4 + 3) + 1) % Pt) * Px * Py * Pz;
				procNeighbors(i*8 + TM) = 	(procPos(i*4 + 0)) + 
										(procPos(i*4 + 1)) * Px +
										(procPos(i*4 + 2)) * Px * Py +
										((procPos(i*4 + 3) - 1 + Pt) % Pt) * Px * Py * Pz;


//				for(j in 0..7){
//					offsetNeighbors(i,j) = (procNeighbors(i,j) - i) * nsite;
//				}
			}
		}

//		Console.OUT.println("------------------------------------");
//		finish for(p in procPos.placeGroup()){
//			at(p) {
//				val i = p.id();
//
//				Console.OUT.println("["+i+"] : ("+procPos(i*4+0)+","+procPos(i*4+1)+","+procPos(i*4+2)+","+procPos(i*4+3)+") - "+
//					procNeighbors(i*8+0)+","+procNeighbors(i*8+1)+","+procNeighbors(i*8+2)+","+procNeighbors(i*8+3)+","+
//					procNeighbors(i*8+4)+","+procNeighbors(i*8+5)+","+procNeighbors(i*8+6)+","+procNeighbors(i*8+7));
//			}
//		}
//		Console.OUT.println("------------------------------------");

	}

}






