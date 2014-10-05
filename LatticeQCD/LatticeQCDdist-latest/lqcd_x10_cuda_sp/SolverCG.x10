import ParallelLattice;
import WilsonVectorField;
import SU3MatrixField;
import Dslash;
import CUDAWilsonVectorField;
import CUDALatticeComm;

import x10.util.Team;
import x10.util.CUDAUtilities;

import x10.compiler.*;

public class SolverCG extends Lattice{

	val X : WilsonVectorField;
	val S : WilsonVectorField;
	val R : WilsonVectorField;
	val P : WilsonVectorField;
	val V2 : WilsonVectorField;

	val dX : CUDAWilsonVectorField;
	val dS : CUDAWilsonVectorField;
	val dR : CUDAWilsonVectorField;
	val dV2 : CUDAWilsonVectorField;
	val dP : CUDAWilsonVectorField;
	
        val niter = 1000;
        // val niter = 10;
	val enorm = 1.E-16;
	var nconv : Long;
	var diff : Float;
	val Npx : Long;
	val Npy : Long;
	val Npz : Long;
	val Npt : Long;
	// val bEx : LatticeComm;
	val bEx : CUDALatticeComm;
	val nThreads : Long;
	val opr : Dslash;

	def this(nx : Long,ny : Long,nz : Long,nt : Long, npx : Long, npy : Long, npz : Long, npt : Long,nid : Long)
	{
		super(nx,ny,nz,nt);

		nThreads = nid;

		X = new WilsonVectorField(nx,ny,nz,nt,nid);
		S = new WilsonVectorField(nx,ny,nz,nt,nid);
		R = new WilsonVectorField(nx,ny,nz,nt,nid);
		P = new WilsonVectorField(nx,ny,nz,nt,nid);
		V2 = new WilsonVectorField(nx,ny,nz,nt,nid);

		dX = new CUDAWilsonVectorField(nx,ny,nz,nt);
		dS = new CUDAWilsonVectorField(nx,ny,nz,nt);
		dR = new CUDAWilsonVectorField(nx,ny,nz,nt);
		dP = new CUDAWilsonVectorField(nx,ny,nz,nt);
		dV2 = new CUDAWilsonVectorField(nx,ny,nz,nt);

		// bEx = new LatticeComm(Nx,Ny,Nz,Nt,npx,npy,npz,npt,nid);
		bEx = new CUDALatticeComm(Nx,Ny,Nz,Nt,npx,npy,npz,npt,nid);

		opr = new Dslash(Nx,Ny,Nz,Nt,nid);

		Npx = npx;
		Npy = npy;
		Npz = npz;
		Npt = npt;
	}

	def Delete() 
	{
	  // finish for (h in Place.places()) at(h) async {
	    // CUDAUtilities.deleteGlobalRail(dX.v()());
	    // CUDAUtilities.deleteGlobalRail(dS.v()());
	    // CUDAUtilities.deleteGlobalRail(dR.v()());
	    // CUDAUtilities.deleteGlobalRail(dP.v()());
	    // CUDAUtilities.deleteGlobalRail(dV2.v()());
	    dX.Delete();
	    dS.Delete();
	    dR.Delete();
	    dP.Delete();
	    dV2.Delete();
	  // }
	}

	def Solve(XQ:WilsonVectorField, dU:CUDASU3MatrixField, dB:CUDAWilsonVectorField, cks : Float)
	{
		val retDiff = GlobalRef[Cell[Float]](new Cell[Float](0));
		val retNconv = GlobalRef[Cell[Long]](new Cell[Long](-1));

		diff = 0.0f;
		nconv = -1;

		finish for (p in Place.places()) at(p) async {
			var sr : Float = 0.0f;
			var rr : Float = 0.0f;
			var pap : Float = 0.0f;
			var snorm : Float = 0.0f;
			var rrp : Float = 0.0f;
			var cr : Float = 0.0f;
			var bk : Float = 0.0f;
			var nconv_loc : Long = -1;

			bEx.init();
			bEx.initRef();

			//Init
			dS.Copy(dS.v()(), dB.v()());

			sr = dS.Norm(dS.v()());
			sr = Team.WORLD.allreduce(sr,Team.ADD);
			snorm = 1.0f/sr;

			dR.Copy(dR.v()(), dS.v()());
			dX.Copy(dX.v()(), dS.v()());

			opr.DoprH(dV2,dU,dX,cks,bEx);
			Team.WORLD.barrier();
			opr.DoprH(dS,dU,dV2,cks,bEx);

			dR.Sub(dR.v()(), dS.v()());
			dP.Copy(dP.v()(), dR.v()());

			rr = dR.Norm(dR.v()());
			rr = Team.WORLD.allreduce(rr,Team.ADD);
			rrp = rr;

			if (here.id() == 0) Console.OUT.println("rr == " + rr);

			//CG iteration
			for(iter in 0..(niter-1)){
				val startTime = System.nanoTime();

				opr.DoprH(dV2,dU,dP,cks,bEx);
				Team.WORLD.barrier();
				opr.DoprH(dS,dU,dV2,cks,bEx);
				pap = dS.Dot(dS.v()(), dP.v()());
				pap = Team.WORLD.allreduce(pap,Team.ADD);
				cr = rrp / pap;

// 				dX.MultAdd(cr,dX.v()(),dP.v()());
// 				dR.MultAdd(-cr,dR.v()(),dS.v()());
				dX.MultAdd2(cr,dX.v()(),dP.v()(),-cr,dR.v()(),dS.v()());

				rr = dR.Norm(dR.v()());
				rr = Team.WORLD.allreduce(rr,Team.ADD);
				bk = rr/rrp;

// 				dP.Mult(dP.v()(), bk);
// 				dP.Add(dP.v()(), dR.v()());
				dP.MultAndAdd(bk, dP.v()(), dR.v()());

				rrp = rr;
				val finishTime = System.nanoTime() - startTime;
				if (here.id() == 0) Console.OUT.println("rr == " + rr + ", " + finishTime / 1000 + " usec.");
				// if (here.id() == 0) Console.OUT.println("rr == " + rr);

				//convergence check
				if(rr*snorm < enorm){
					nconv_loc = iter;
					break;
				}
			}

		        // D2H
		        finish {
			  Rail.asyncCopy(dX.v()(), 0, X.v(), 0, X.size);
			}

			XQ.Copy(X);

			opr.DoprH(dV2,dU,dX,cks,bEx);
			Team.WORLD.barrier();
			opr.DoprH(dR,dU,dV2,cks,bEx);

			dR.Sub(dR.v()(), dB.v()());

			if(p.id == 0){
				val tNc = nconv_loc;
				at(retNconv) async atomic retNconv()() = tNc;
			}
			val ldt = dR.Norm(dR.v()());
			at(retDiff) async atomic retDiff()() += ldt;

		}

		diff = retDiff()();
		nconv = retNconv()();
		if(nconv < 0){
			Console.OUT.println(" not converged");
		}

	}

}
