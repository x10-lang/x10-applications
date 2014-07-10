
import x10.io.File;
import x10.io.FileNotFoundException;
import x10.lang.Math;
import x10.compiler.Inline;

import x10.array.*;

import SolverCG;


public final class TestWilsonSolver {
	// constants
	static val defLx = 16;
	static val defLy = 16;
	static val defLz = 16;
	static val defLt = 32;
	static val defNpx = 2;
	static val defNpy = 2;
	static val defNpz = 2;
	static val defNpt = 4;
	static val CKs = 0.150;
	static val Ncol = 3;
	static val Nvc = (Ncol*2);
	static val Ndf = (Ncol*Ncol*2);
	static val Ncp = (Ncol*Ncol);
	static val ND = 4;
	static val ND2 = 2;

	public static def main(args : Rail[String])
	{
		val latsize = new Rail[Long](4);
		val netsize = new Rail[Long](4);
		val nThreads = Runtime.NTHREADS;

		Console.OUT.println("X10_NTHREADS: " + Runtime.NTHREADS);
		Console.OUT.println("X10_NPLACES: " + Place.numPlaces());

		Console.OUT.println("Simple Wilson solver\n");

		for(i in 0..3){
			latsize(i) = 0;
			netsize(1) = 0;
		}
		for(i in 0..(args.size-1)){
			if(args(i).chars()(0) == 'L'){
				var t : Long;
				t = 0;
				for(j in 1..(args(i).length()-1)){
					if(args(i).chars()(j) == 'x'){
						t++;
					}
					else{
						latsize(t) = 10*latsize(t) + Long.parse(args(i).substring(j as Int, (j + 1) as Int));
					}
				}
			}
			else if(args(i).chars()(0) == 'P'){
				var t : Long;
				t = 0;
				for(j in 1..(args(i).length()-1)){
					if(args(i).chars()(j) == 'x'){
						t++;
					}
					else{
						netsize(t) = 10*netsize(t) + Long.parse(args(i).substring(j as Int, (j + 1) as Int));
					}
				}
			}
		}
		var chkL : Long;
		var chkP : Long;
		chkL = 1;
		chkP = 1;
		for(i in 0..3){
			chkL *= latsize(i);
			chkP *= netsize(i);
		}
		if(chkL == 0){
			latsize(0) = defLx;
			latsize(1) = defLy;
			latsize(2) = defLz;
			latsize(3) = defLt;
		}
		if(chkP != Place.numPlaces()){
			var np : Long;
			var id : Long;
			id = 3;
			np = Place.numPlaces();
			netsize(0) = 1;
			netsize(1) = 1;
			netsize(2) = 1;
			netsize(3) = 1;
			while((np % 2) == 0){
				netsize(id) *= 2;
				np /= 2;
				id -= 1;
				if(id < 0){
					id = 3;
				}
			}
			if(np > 1){
				netsize(id) *= np;
			}
		}
		val Lx = latsize(0);
		val Ly = latsize(1);
		val Lz = latsize(2);
		val Lt = latsize(3);
		val Npx = netsize(0);
		val Npy = netsize(1);
		val Npz = netsize(2);
		val Npt = netsize(3);
		val Nx = Lx / Npx;
		val Ny = Ly / Npy;
		val Nz = Lz / Npz;
		val Nt = Lt / Npt;

		Console.OUT.println("Lattice      : " + Lx + " x " + Ly + " x " + Lz + " x " + Lt);
		Console.OUT.println("Decomposing  : " + Npx + " x " + Npy + " x " + Npz + " x " + Npt);
		Console.OUT.println("Local lattice: " + Nx + " x " + Ny + " x " + Nz + " x " + Nt);
		Console.OUT.println("CKs = " + CKs);

		val solver = new SolverCG(Lx,Ly,Lz,Lt,Npx,Npy,Npz,Npt);

		solver.init();
		solver.setup();

		Console.OUT.println("enorm = " + solver.enorm);

		val u = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](2*3*3*Nx*Ny*Nz*Nt*4));
		val xq = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](2*4*3*Nx*Ny*Nz*Nt));
		val bq = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](2*4*3*Nx*Ny*Nz*Nt));

		val corr = new Rail[Double](Lt);

		solver.MakeRandomConf(u,100);

		Console.OUT.println("\tic\tid\tnconv\tdiff");

		var meanTime:Long = 0;
		for(ic in 0..(Ncol-1)) {
			for(id in 0..(ND-1)) {

				solver.Set(bq,0.0);

				Console.OUT.println("test0");
				finish{
					at(Place(0)){
						bq()(2*ic + id*Nvc) = 1.0;
					}
				}
				Console.OUT.println("test1");

				val startTime = System.currentTimeMillis();
				solver.Solve(xq,u,bq,CKs);
				meanTime += System.currentTimeMillis() - startTime;

				Console.OUT.println("cg: " + (System.currentTimeMillis() - startTime));
				Console.OUT.println("\t" + ic + "\t" + id + "\t" + solver.nconv + "\t" + solver.diff);

				//reduction of meson correrator
				for(it in 0..(Lt-1)){
					val ipet = it / Nt;
					val is = it % Nt;
				//	corr(it) += xq.Norm(LongRange(is*Nx*Ny*Nz,(is+1)*Nx*Ny*Nz));
				}
			}
		}

		Console.OUT.println("Ps meson correlator:");
		for(it in 0..(Lt-1)){
			Console.OUT.println("\t" + it + "\t" + corr(it));
		}

		//debug
		meanTime /= Ncol * ND;
		Console.OUT.println("SolveWilson: " + meanTime + " ms");
	}

}



