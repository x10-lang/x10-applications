
import Lattice;



public class ParallelLattice extends Lattice{
	val rank : PlaceLocalHandle[Cell[Long]];
	val nprocs : Long;
	val Lx : Long;
	val Ly : Long;
	val Lz : Long;
	val Lt : Long;
	val netSize = new Rail[Long](4);
	val netPos : PlaceLocalHandle[Rail[Long]];
	val neighbors : PlaceLocalHandle[Rail[Long]];
	val decomp = new Rail[Long](8);

	def this(x : Long,y : Long,z : Long,t : Long, px : Long, py : Long, pz : Long, pt : Long)
	{
		super(x,y,z,t);

		rank = PlaceLocalHandle.make[Cell[Long]](Place.places(), ()=>new Cell[Long](0));
		netSize(0) = px;
		netSize(1) = py;
		netSize(2) = pz;
		netSize(3) = pt;
		Lx = Nx*px;
		Ly = Ny*py;
		Lz = Nz*pz;
		Lt = Nt*pt;

		decomp(XP) = px;
		decomp(XM) = px;
		decomp(YP) = py;
		decomp(YM) = py;
		decomp(ZP) = pz;
		decomp(ZM) = pz;
		decomp(TP) = pt;
		decomp(TM) = pt;
		nprocs = px*py*pz*pt;

		netPos = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](4));
		neighbors = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8));
	}

	def init()
	{
		rank()() = here.id;
		netPos()(0) = here.id % netSize(0);
		netPos()(1) = (here.id / netSize(0)) % netSize(1);
		netPos()(2) = (here.id / netSize(0) / netSize(1)) % netSize(2);
		netPos()(3) = here.id / netSize(0) / netSize(1) / netSize(2);

	  //debug
	  // Console.OUT.println(here.id + ": " + netPos()(0) + "x" + netPos()(1) + "x" + netPos()(2) + "x" + netPos()(3));

		neighbors()(XP) = 	(netPos()(0) + 1) % netSize(0) + 
							(netPos()(1)) * netSize(0) + 
							(netPos()(2)) * netSize(0)*netSize(1) + 
							(netPos()(3)) * netSize(0)*netSize(1)*netSize(2);
		neighbors()(XM) = 	(netPos()(0) - 1 + netSize(0)) % netSize(0) + 
							(netPos()(1)) * netSize(0) + 
							(netPos()(2)) * netSize(0)*netSize(1) + 
							(netPos()(3)) * netSize(0)*netSize(1)*netSize(2);
		// neighbors()(YP) = 	(netPos()(0)) + 
		// 					((netPos()(1) + 1) % netSize(1)) * netSize(1) + 
		// 					(netPos()(2)) * netSize(0)*netSize(1) + 
		// 					(netPos()(3)) * netSize(0)*netSize(1)*netSize(2);
		neighbors()(YP) = 	(netPos()(0)) + 
							((netPos()(1) + 1) % netSize(1)) * netSize(0) + 
							(netPos()(2)) * netSize(0)*netSize(1) + 
							(netPos()(3)) * netSize(0)*netSize(1)*netSize(2);
		neighbors()(YM) = 	(netPos()(0)) + 
							((netPos()(1) - 1 + netSize(1)) % netSize(1)) * netSize(0) + 
							(netPos()(2)) * netSize(0)*netSize(1) + 
							(netPos()(3)) * netSize(0)*netSize(1)*netSize(2);
		neighbors()(ZP) = 	(netPos()(0)) + 
							(netPos()(1)) * netSize(0) + 
							((netPos()(2) + 1)  % netSize(2)) * netSize(0)*netSize(1) + 
							(netPos()(3)) * netSize(0)*netSize(1)*netSize(2);
		neighbors()(ZM) = 	(netPos()(0)) + 
							(netPos()(1)) * netSize(0) + 
							((netPos()(2) - 1 + netSize(2)) % netSize(2)) * netSize(0)*netSize(1) + 
							(netPos()(3)) * netSize(0)*netSize(1)*netSize(2);
		neighbors()(TP) = 	(netPos()(0)) + 
							(netPos()(1)) * netSize(0) + 
							(netPos()(2)) * netSize(0)*netSize(1) + 
							((netPos()(3) + 1) % netSize(3)) * netSize(0)*netSize(1)*netSize(2);
		neighbors()(TM) = 	(netPos()(0)) + 
							(netPos()(1)) * netSize(0) + 
							(netPos()(2)) * netSize(0)*netSize(1) + 
							((netPos()(3) - 1 + netSize(3)) % netSize(3)) * netSize(0)*netSize(1)*netSize(2);

	  //debug
	  // Console.OUT.println(here.id + ": " + neighbors()(XP) + "x" + neighbors()(XM) + "x"
			    // + neighbors()(YP) + "x" + neighbors()(YM) + "x"
			    // + neighbors()(ZP) + "x" + neighbors()(ZM) + "x"
			    // + neighbors()(TP) + "x" + neighbors()(TM));
	}

}






