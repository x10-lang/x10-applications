

public class Lattice {
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
	val procPos : PlaceLocalHandle[Rail[Long]];
	val procNeighbors : PlaceLocalHandle[Rail[Long]];

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

		procPos = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](4));
		procNeighbors = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8));
	}

	def init()
	{
		finish for(p in Place.places()){
			at(p) async {
				val i = p.id();

				procPos()(0) = i % Px;
				procPos()(1) = (i / Px) % Py;
				procPos()(2) = (i / Px/Py) % Pz;
				procPos()(3) = (i / Px/Py/Pz);

				procNeighbors()(XP) = 	(procPos()(0) + 1) % Px + 
										(procPos()(1)) * Px +
										(procPos()(2)) * Px * Py +
										(procPos()(3)) * Px * Py * Pz;
				procNeighbors()(XM) = 	(procPos()(0) - 1 + Px) % Px + 
										(procPos()(1)) * Px +
										(procPos()(2)) * Px * Py +
										(procPos()(3)) * Px * Py * Pz;
				procNeighbors()(YP) = 	(procPos()(0)) + 
										((procPos()(1) + 1) % Py) * Px +
										(procPos()(2)) * Px * Py +
										(procPos()(3)) * Px * Py * Pz;
				procNeighbors()(YM) = 	(procPos()(0)) + 
										((procPos()(1) - 1 + Py) % Py) * Px +
										(procPos()(2)) * Px * Py +
										(procPos()(3)) * Px * Py * Pz;
				procNeighbors()(ZP) = 	(procPos()(0)) + 
										(procPos()(1)) * Px +
										((procPos()(2) + 1) % Pz) * Px * Py +
										(procPos()(3)) * Px * Py * Pz;
				procNeighbors()(ZM) = 	(procPos()(0)) + 
										(procPos()(1)) * Px +
										((procPos()(2) - 1 + Pz) % Pz) * Px * Py +
										(procPos()(3)) * Px * Py * Pz;
				procNeighbors()(TP) = 	(procPos()(0)) + 
										(procPos()(1)) * Px +
										(procPos()(2)) * Px * Py +
										((procPos()(3) + 1) % Pt) * Px * Py * Pz;
				procNeighbors()(TM) = 	(procPos()(0)) + 
										(procPos()(1)) * Px +
										(procPos()(2)) * Px * Py +
										((procPos()(3) - 1 + Pt) % Pt) * Px * Py * Pz;
			}
		}
	}

}






