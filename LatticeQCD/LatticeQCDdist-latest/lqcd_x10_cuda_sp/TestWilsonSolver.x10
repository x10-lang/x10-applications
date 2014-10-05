import x10.io.File;
import x10.io.FileNotFoundException;
import x10.lang.Math;
import x10.compiler.*;

import x10.util.CUDAUtilities;


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
	static val CKs = 0.150f;
	static val Ncol = 3;
	static val Nvc = (Ncol*2);
	static val Ndf = (Ncol*Ncol*2);
	static val Ncp = (Ncol*Ncol);
	static val ND = 4;
	static val ND2 = 2;

	public static def main(args:Rail[String])
	{
		val latsize = new Rail[Long](4);
		val netsize = new Rail[Long](4);
		val nThreads = Runtime.NTHREADS;

		Console.OUT.println("X10_NTHREADS: " + Runtime.NTHREADS);
		Console.OUT.println("X10_NPLACES: " + Place.numPlaces());
		Console.OUT.println("ALL_PLACES: " + Place.numAllPlaces());
		Console.OUT.println("NUM_ACCELS: " + (Place.numAllPlaces() - Place.numPlaces()));

		Console.OUT.println("Simple Wilson solver\n");

		/*
		latsize.clear();
		netsize.clear();
		*/
		for(i in 0..(args.size-1)){
			if(args(i).chars()(0) == 'L'){
				var t:Long;
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
				var t:Long;
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
		var chkL:Long;
		var chkP:Long;
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
			var np:Long;
			var id:Long;
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

		val solver = new SolverCG(Nx,Ny,Nz,Nt,Npx,Npy,Npz,Npt,nThreads);
		val parLat = new ParallelLattice(Nx,Ny,Nz,Nt,Npx,Npy,Npz,Npt);

		Console.OUT.println("enorm = " + solver.enorm);

		val u = new SU3MatrixField(Nx,Ny,Nz,Nt,nThreads);
		val xq = new WilsonVectorField(Nx,Ny,Nz,Nt,nThreads);
		val bq = new WilsonVectorField(Nx,Ny,Nz,Nt,nThreads);

		val du = new CUDASU3MatrixField(Nx,Ny,Nz,Nt,1);
		val dbq = new CUDAWilsonVectorField(Nx,Ny,Nz,Nt);

		val corr = new GlobalRef[Rail[Double]](new Rail[Double](Lt,0));

		finish for(p in Place.places()) at(p) async {
			parLat.init();

//			if(Lx == 8 && Ly == 8 && Lz == 8 && Lt == 16){
//				u.LoadConf("conf_08080816.txt",parLat);
//			}
//			else{
				u.RandomConf(100,parLat);
//			}
		}

//debug
		// H2D
		finish for (h in Place.places()) at(h) async {
		  finish {
		    Rail.asyncCopy(u.v(), 0, du.v()(), 0, u.size);
		  }
		}

		Console.OUT.println("\tic\tid\tnconv\tdiff");

		var meanTime:Long = 0;
		// for(ic in 0..(Ncol-1)) {
		// 	for(id in 0..(ND-1)) {
		for(ic in 0..0) {
		  for(id in 0..0) {

		    finish for(p in Place.places()) at(p) async {
		      bq.Set(0.0f);
		      if(p.id == 0){
			// bq.v()(2*ic + id*Nvc) = 1.0;
			//debug					  
			bq.v()((2*ic + id*Nvc)*Nx*Ny*Nz*Nt) = 1.0f;
		      }
		    }

		    // H2D
		    finish {
		      Rail.asyncCopy(bq.v(), 0, dbq.v()(), 0, bq.size);
		    }

		    val startTime = System.currentTimeMillis();
		    // solver.Solve(xq,u,bq,CKs);
		    // solver.Solve(xq,u,du,bq,CKs);
		    solver.Solve(xq,du,dbq,CKs);
		    meanTime += System.currentTimeMillis() - startTime;

		    Console.OUT.println("cg: " + (System.currentTimeMillis() - startTime));
		    Console.OUT.println("\t" + ic + "\t" + id + "\t" + solver.nconv + "\t" + solver.diff);

		    //reduction of meson correrator
		    finish for(p in Place.places()) at(p) async {
		      for(it in 0..(Lt-1)){
			val ipet = it / Nt;
			val is = it % Nt;
			if(ipet == parLat.netPos()(3)){
			  for (iv in 0..(Nvc*ND-1)) {
			    val rng = new LongRange(is*Nx*Ny*Nz + iv*Nx*Ny*Nz*Nt,(is+1)*Nx*Ny*Nz + iv*Nx*Ny*Nz*Nt);
			    val corrF:Double;
			    corrF = xq.Norm_SoA(rng);
			    at(corr) async atomic corr()(it) += corrF;
			  }
			}
		      }
		    }
		  }
		}

		Console.OUT.println("Ps meson correlator:");
		for(it in 0..(Lt-1)){
			Console.OUT.println("\t" + it + "\t" + corr()(it));
		}

		//debug
		meanTime /= Ncol * ND;
		Console.OUT.println("SolveWilson: " + meanTime + " ms");

		// delete
		finish for (h in Place.places()) at(h) async {
		  CUDAUtilities.deleteGlobalRail(du.v()());
		}
	        solver.Delete();
	}

}
