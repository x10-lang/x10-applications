import x10.io.File;
import x10.io.FileNotFoundException;
import x10.lang.Math;
import x10.compiler.Inline;

import WilsonVectorField;
import SU3MatrixField;

import SolverCG;
import Dslash;

import x10.util.Team;

public final class TestWilsonSolver {
	// constants
	// static val Lx = 8;
	// static val Ly = 8;
	// static val Lz = 8;
	// static val Lt = 16;
	static val Lx = 16;
	static val Ly = 16;
	static val Lz = 16;
	static val Lt = 32;
	// static val Npx = 1;
	// static val Npy = 1;
	// static val Npz = 2;
	// static val Npt = 2;
  static Np = Place.numPlaces();
  static val LD = 4;
  static val Npx = Math.pow2((    Math.log2(Np)) / LD);
  static val Npy = Math.pow2((1 + Math.log2(Np)) / LD);
  static val Npz = Math.pow2((2 + Math.log2(Np)) / LD);
  static val Npt = Math.pow2((3 + Math.log2(Np)) / LD);

	static val Nx = Lx/Npx;
	static val Ny = Ly/Npy;
	static val Nz = Lz/Npz;
	static val Nt = Lt/Npt;
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

//		for(i in 0..3){
//			latsize(i) = 0;
//			netsize(1) = 0;
//		}

//		for(i in 0..(args.size-1)){
//			if(args(i)(0) == 'L'){
//				var t = 0;
//				for(j in 1..(args(i).length()-1)){
//					if(args(i)(j) == 'x'){
//						t++;
//					}
//					else{
//						latsize(t) = 10*latsize(t) + (args(i)(j) - '0');
//					}
//				}
//			}
//			else if(args(i)(0) == 'P'){
//				var t = 0;
//				for(j in 1..(args(i).length()-1)){
//					if(args(i)(j) == 'x'){
//						t++;
//					}
//					else{
//						netsize(t) = 10*netsize(t) + (args(i)(j) - '0');
//					}
//				}
//			}
//		}
//		var chkL = 1;
//		var chkP = 1;
//		for(i in 0..3){
//			chkL *= latsize(i);
//			chkP *= netsize(i);
//		}
//		if(chkL != 0){
//			Lx = latsize(0);
//			Ly = latsize(1);
//			Lz = latsize(2);
//			Lt = latsize(3);
//		}
//		if(chkP == Place.numPlaces()){
//			Npx = netsize(0);
//			Npy = netsize(1);
//			Npz = netsize(2);
//			Npt = netsize(3);
//		}

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

		Console.OUT.println("\tic\tid\tnconv\tdiff");

		var meanTime:Long = 0;
		// for(ic in 0..(Ncol-1)) {
		// 	for(id in 0..(ND-1)) {
		for(ic in 0..0) {
			for(id in 0..0) {

				finish for(p in Place.places()) at(p) async {
					bq.Set(0.0);
					if(p.id == 0){
						bq.v()(2*ic + id*Nvc) = 1.0;
					}
				}

				val startTime = System.currentTimeMillis();
				solver.Solve(xq,u,bq,CKs);
				meanTime += System.currentTimeMillis() - startTime;

				Console.OUT.println("cg: " + (System.currentTimeMillis() - startTime));
				Console.OUT.println("\t" + ic + "\t" + id + "\t" + solver.nconv + "\t" + solver.diff);

				//reduction of meson correrator
				finish for(p in Place.places()) at(p) async {
					for(it in 0..(Lt-1)){
						val ipet = it / Nt;
						val is = it % Nt;
						if(ipet == parLat.netPos()(3)){
							val rng = new LongRange(is*Nx*Ny*Nz,(is+1)*Nx*Ny*Nz);
							val corrF : Double;
							corrF = xq.Norm(rng);
							at(corr) async atomic corr()(it) += corrF;
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
		// meanTime /= Ncol * ND;
		Console.OUT.println("SolveWilson: " + meanTime + " ms");
	}

}
