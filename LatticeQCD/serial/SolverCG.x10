
import x10.array.Array_1;

import Lattice;
import WilsonVectorField;
import SU3MatrixField;
import Dslash;

//import x10.util.Team;

public class SolverCG extends Lattice{
	val X : WilsonVectorField;
	val S : WilsonVectorField;
	val R : WilsonVectorField;
	val P : WilsonVectorField;
	val V2 : WilsonVectorField;
	val niter = 1000;
	val enorm = 1.E-16;
	var nconv : Long;
	var diff : Double;
	val Npx : Long;
	val Npy : Long;
	val Npz : Long;
	val Npt : Long;
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



		opr = new Dslash(Nx,Ny,Nz,Nt,nid);

		Npx = npx;
		Npy = npy;
		Npz = npz;
		Npt = npt;
	}

	def Solve(XQ:WilsonVectorField, U:SU3MatrixField, B:WilsonVectorField, cks : Double)
	{
//		val retDiff = GlobalRef[Cell[Double]](new Cell[Double](0));
//		val retNconv = GlobalRef[Cell[Long]](new Cell[Long](-1));

		diff = 0.0;
		nconv = -1;


		var sr : Double = 0.0;
		var rr : Double = 0.0;
		var pap : Double = 0.0;
		var snorm : Double = 0.0;
		var rrp : Double = 0.0;
		var cr : Double = 0.0;
		var bk : Double = 0.0;
		var nconv_loc : Long = -1;

		var tstart : Long;
		var tend : Long;


		//Init
		S.Copy(B);

		sr = S.Norm();
//			sr = Team.WORLD.allreduce(sr,Team.ADD);
		snorm = 1.0/sr;

		R.Copy(S);
		X.Copy(S);

		opr.DoprH(V2,U,X,cks);
		opr.DoprH(S,U,V2,cks);

		R.Sub(S);
		P.Copy(R);

		rr = R.Norm();
//			rr = Team.WORLD.allreduce(rr,Team.ADD);
		rrp = rr;

		//CG iteration
		for(iter in 0..(niter-1)){
				tstart = System.nanoTime();
			opr.DoprH(V2,U,P,cks);
			opr.DoprH(S,U,V2,cks);
				tend = System.nanoTime() - tstart;

			pap = S.Dot(P);
//				pap = Team.WORLD.allreduce(pap,Team.ADD);
			cr = rrp / pap;

			X.MultAdd(cr,P);
			R.MultAdd(-cr,S);

			rr = R.Norm();
//				rr = Team.WORLD.allreduce(rr,Team.ADD);
			bk = rr/rrp;

			P.Mult(bk);
			P.Add(R);

			rrp = rr;

			Console.OUT.println("  iter = "+iter+"  rr = "+rr+ " Dopr[ns] = "+ tend/2);

			//convergence check
			if(rr*snorm < enorm){
				nconv = iter;
				break;
			}
		}

		XQ.Copy(X);

		opr.DoprH(V2,U,X,cks);
		opr.DoprH(R,U,V2,cks);

		R.Sub(B);

		diff = R.Norm();
		if(nconv < 0){
			Console.OUT.println(" not converged");
		}
	}

}







