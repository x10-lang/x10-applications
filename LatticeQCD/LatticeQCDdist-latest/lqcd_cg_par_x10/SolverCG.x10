


import x10.array.Array_1;

import ParallelLattice;
import WilsonVectorField;
import SU3MatrixField;
import Dslash;
import LatticeComm;

import x10.util.Team;

public class SolverCG extends Lattice{
	val X : WilsonVectorField;
	val S : WilsonVectorField;
	val R : WilsonVectorField;
	val P : WilsonVectorField;
	val V2 : WilsonVectorField;
	val niter = 1000;
	// val niter = 1;
	val enorm = 1.E-16;
	var nconv : Long;
	var diff : Double;
	val Npx : Long;
	val Npy : Long;
	val Npz : Long;
	val Npt : Long;
	val bEx : LatticeComm;


	def this(nx : Long,ny : Long,nz : Long,nt : Long, npx : Long, npy : Long, npz : Long, npt : Long)
	{
		super(nx,ny,nz,nt);

		X = new WilsonVectorField(nx,ny,nz,nt);
		S = new WilsonVectorField(nx,ny,nz,nt);
		R = new WilsonVectorField(nx,ny,nz,nt);
		P = new WilsonVectorField(nx,ny,nz,nt);
		V2 = new WilsonVectorField(nx,ny,nz,nt);

		bEx = new LatticeComm(Nx,Ny,Nz,Nt,npx,npy,npz,npt);

		Npx = npx;
		Npy = npy;
		Npz = npz;
		Npt = npt;
	}

	def Solve(XQ:WilsonVectorField, U:SU3MatrixField, B:WilsonVectorField, cks : Double, nthreads : Long)
	{
		val retDiff = GlobalRef[Cell[Double]](new Cell[Double](0));
		val retNconv = GlobalRef[Cell[Long]](new Cell[Long](-1));

		diff = 0.0;
		nconv = -1;

		finish for (p in Place.places()) at(p) async {
			var sr : Double = 0.0;
			var rr : Double = 0.0;
			var pap : Double = 0.0;
			var localDiff : Double = 0.0;
		  
			bEx.init();

			clocked finish for (tid in 0..(nthreads - 1)) clocked async {
		        // val tid = 0;
				var ret_l : Double;
				var snorm : Double = 0.0;
				var rrp : Double = 0.0;
				var cr : Double = 0.0;
				var bk : Double = 0.0;

				//operator class
				val opr = new Dslash(Nx,Ny,Nz,Nt,tid,nthreads);

				//Init
				S.Copy(B,opr.rngLA);

				ret_l = S.Norm(opr.rngLA);

				atomic sr += ret_l;
				Clock.advanceAll();
		  // Team.WORLD.barrier();

				if(tid == 0){
				  sr = Team.WORLD.allreduce(sr,Team.ADD);
				}
				Clock.advanceAll();
		  // Team.WORLD.barrier();

		  //debug
		  // Console.OUT.println(here.id + ": sr == " + sr);



				snorm = 1.0/sr;

				R.Copy(S,opr.rngLA);
		  //debug
		  // Console.OUT.println(here.id + ": xxx");
				X.Copy(S,opr.rngLA);

		  //debug
		  // Console.OUT.println(here.id + ": xxx");
		  
				opr.DoprH(V2,U,X,cks,bEx);
				opr.DoprH(S,U,V2,cks,bEx);

				R.Sub(S,opr.rngLA);
				P.Copy(R,opr.rngLA);

				if(tid == 0){
					rr = 0.0;
				}
				Clock.advanceAll();
		  // Team.WORLD.barrier();
				ret_l = R.Norm(opr.rngLA);
				atomic rr += ret_l;
				Clock.advanceAll();
		  // Team.WORLD.barrier();
				if(tid == 0){
					rr = Team.WORLD.allreduce(rr,Team.ADD);
				}
				Clock.advanceAll();
		  // Team.WORLD.barrier();
				rrp = rr;

		  //debug
		  // Console.OUT.println(here.id + ": rr == " + rr);


				//CG iteration
				for(iter in 0..(niter-1)){

				  //debug
				  if (here.id == 0 && tid == 0 && iter % 100 == 0)
				  Console.OUT.println(iter);



					opr.DoprH(V2,U,P,cks,bEx);
					opr.DoprH(S,U,V2,cks,bEx);

					if(tid == 0){
						pap = 0.0;
					}
					Clock.advanceAll();
		  // Team.WORLD.barrier();
					ret_l = S.Dot(P,opr.rngLA);
					atomic pap += ret_l;
					Clock.advanceAll();
		  // Team.WORLD.barrier();
					if(tid == 0){
						pap = Team.WORLD.allreduce(pap,Team.ADD);
					}
					Clock.advanceAll();
		  // Team.WORLD.barrier();
		  //debug
		  // Console.OUT.println(here.id + ": pap == " + pap);
					cr = rrp / pap;

					X.MultAdd(cr,P,opr.rngLA);
					R.MultAdd(-cr,S,opr.rngLA);

					if(tid == 0){
						rr = 0.0;
					}
				  Clock.advanceAll();
		  // Team.WORLD.barrier();
					ret_l = R.Norm(opr.rngLA);
					atomic rr += ret_l;
					Clock.advanceAll();
		  // Team.WORLD.barrier();
					if(tid == 0){
						rr = Team.WORLD.allreduce(rr,Team.ADD);
					}
					Clock.advanceAll();
		  // Team.WORLD.barrier();
					bk = rr/rrp;

					P.Mult(bk,opr.rngLA);
					P.Add(R,opr.rngLA);

					rrp = rr;

					//convergence check
					if(rr*snorm < enorm){
						if(p.id == 0 && tid == 0){
							val tNc = iter;
							at(retNconv) async atomic retNconv()() = tNc;
						}
						break;
					}

				}

				XQ.Copy(X,opr.rngLA);

				opr.DoprH(V2,U,X,cks,bEx);
				opr.DoprH(R,U,V2,cks,bEx);

				R.Sub(B,opr.rngLA);

				ret_l = R.Norm(opr.rngLA);
				atomic localDiff += ret_l;
				Clock.advanceAll();
		  // Team.WORLD.barrier();
			} // clocked finish
			val ldt = localDiff;
			at(retDiff) async atomic retDiff()() += ldt;
		} // finish

		diff = retDiff()();
		nconv = retNconv()();
		if(nconv < 0){
			Console.OUT.println(" not converged");
		}
	}

}







