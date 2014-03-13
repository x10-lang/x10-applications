
import x10.compiler.Inline;
import x10.compiler.Pragma;

import x10.array.*;

import Lattice;
import Dslash;

import MyRand;


//import x10.util.Team;

public class SolverCG extends Lattice {
	val X : PlaceLocalHandle[Rail[Double]];
	val S : PlaceLocalHandle[Rail[Double]];
	val R : PlaceLocalHandle[Rail[Double]];
	val P : PlaceLocalHandle[Rail[Double]];
	val V2 : PlaceLocalHandle[Rail[Double]];
	val niter = 1000;
	val enorm = 1.E-16;
	var nconv : Long;
	var diff : Double;
	val nThreads : Long;
	val opr : Dslash;
	val rngLA : Rail[LongRange];


	def this(nx : Long,ny : Long,nz : Long,nt : Long, npx : Long, npy : Long, npz : Long, npt : Long)
	{
		super(nx,ny,nz,nt,npx,npy,npz,npt);

		val size = nsite;

		X = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](2*4*3*size));
		S = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](2*4*3*size));
		R = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](2*4*3*size));
		P = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](2*4*3*size));
		V2= PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](2*4*3*size));

		nThreads = Runtime.NTHREADS;

		rngLA = new Rail[LongRange](nThreads);
		for(tid in 0..(nThreads - 1)){
			rngLA(tid) = new LongRange(tid * nsite*24 / nThreads,(tid + 1) * nsite*24 / nThreads - 1);
		}

		opr = new Dslash(nx,ny,nz,nt,npx,npy,npz,npt);
	}

	def setup()
	{
		opr.init();

		opr.setup();
	}

	def Set(v : PlaceLocalHandle[Rail[Double]], t : Double)
	{
		finish for(p in Place.places()){
			at(p) async {
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					for(i in rngLA(tid)){
						v()(i) = t;
					}
				}
			}
		}
	}

	def Mult(v : PlaceLocalHandle[Rail[Double]], a : Double)
	{
		finish for(p in Place.places()){
			at(p) async {
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					for(i in rngLA(tid)){
						v()(i) = a*v()(i);
					}
				}
			}
		}
	}

	def Copy(v : PlaceLocalHandle[Rail[Double]], w : PlaceLocalHandle[Rail[Double]])
	{
		finish for(p in Place.places()){
			at(p) async {
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					for(i in rngLA(tid)){
						v()(i) = w()(i);
					}
				}
			}
		}
	}

	def Add(v : PlaceLocalHandle[Rail[Double]], w : PlaceLocalHandle[Rail[Double]])
	{
		finish for(p in Place.places()){
			at(p) async {
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					for(i in rngLA(tid)){
						v()(i) = v()(i) + w()(i);
					}
				}
			}
		}
	}

	def Sub(v : PlaceLocalHandle[Rail[Double]], w : PlaceLocalHandle[Rail[Double]])
	{
		finish for(p in Place.places()){
			at(p) async {
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					for(i in rngLA(tid)){
						v()(i) = v()(i) - w()(i);
					}
				}
			}
		}
	}

	def MultAdd(v : PlaceLocalHandle[Rail[Double]], a : Double, w : PlaceLocalHandle[Rail[Double]])
	{
		finish for(p in Place.places()){
			at(p) async {
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					for(i in rngLA(tid)){
						v()(i) = v()(i) + a * w()(i);
					}
				}
			}
		}
	}

	def SPX(v : PlaceLocalHandle[Rail[Double]], a : Double, w : PlaceLocalHandle[Rail[Double]])
	{
		finish for(p in Place.places()){
			at(p) async {
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					for(i in rngLA(tid)){
						v()(i) = a*v()(i) + w()(i);
					}
				}
			}
		}
	}

	def Dot(v : PlaceLocalHandle[Rail[Double]], w : PlaceLocalHandle[Rail[Double]]) : Double
	{
		val r_dot = finish(Reducible.SumReducer[Double]()){
			for(p in Place.places()) at(p) async {
				var ret : Double = 0.0;
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					var t : Double = 0.0;
					for(i in rngLA(tid)){
						t = t + v()(i) * w()(i);
					}
					atomic ret += t;
				}

				offer ret;
			}
		};
		return r_dot;
	}

	def Norm(v : PlaceLocalHandle[Rail[Double]]) : Double
	{
		val r_norm = finish(Reducible.SumReducer[Double]()){
			for(p in Place.places()) at(p) async {
				var ret : Double = 0.0;
				@Pragma(Pragma.FINISH_LOCAL) finish for(tid in 0..(nThreads-1)) async {
					var t : Double = 0.0;
					for(i in rngLA(tid)){
						t = t + v()(i) * v()(i);
					}
					atomic ret += t;
				}
				offer ret;
			}
		};
		return r_norm;
	}




	def Solve(XQ:PlaceLocalHandle[Rail[Double]], U:PlaceLocalHandle[Rail[Double]], B:PlaceLocalHandle[Rail[Double]], cks : Double)
	{
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
		Copy(S,B);

		sr = Norm(S);
		snorm = 1.0/sr;

		Copy(R,S);
		Copy(X,S);

			Console.OUT.println("   test0");

		opr.DoprH(V2,U,X,cks);
			Console.OUT.println("   test1");

		opr.DoprH(S,U,V2,cks);
			Console.OUT.println("   test2");

		Sub(R,S);
		Copy(P,R);

		rr = Norm(R);
		rrp = rr;

		//CG iteration
		for(iter in 0..(niter-1)){

				tstart = System.nanoTime();
			opr.DoprH(V2,U,P,cks);
			opr.DoprH(S,U,V2,cks);
				tend = System.nanoTime() - tstart;

			pap = Dot(S,P);
			cr = rrp / pap;

			MultAdd(X,cr,P);
			MultAdd(R,-cr,S);

			rr = Norm(R);
			bk = rr/rrp;

			Mult(P,bk);
			Add(P,R);

			rrp = rr;

			Console.OUT.println("  iter = "+iter+"  rr = "+rr+ " Dopr[ns] = "+ tend/2);

			//convergence check
			if(rr*snorm < enorm){
				nconv = iter;
				break;
			}
		}

		Copy(XQ,X);

		opr.DoprH(V2,U,X,cks);
		opr.DoprH(R,U,V2,cks);

		Sub(R,B);

		diff = Norm(R);
		if(nconv < 0){
			Console.OUT.println(" not converged");
		}
	}

	def MakeRandomConf(v : PlaceLocalHandle[Rail[Double]], s : Long)
	{
		finish for(p in Place.places()){
			at(p) async {
				val myrand : MyRand = new MyRand(s);
				var d : Double;
				var is : Long;
				val pos  = new Rail[Long](4);

				pos(0) = here.id() % Px;
				pos(1) = (here.id() / Px) % Py;
				pos(2) = (here.id() / Px/Py) % Pz;
				pos(3) = (here.id() / Px/Py/Pz);

				val sx = pos(0) * Nx;
				val ex = pos(0) * Nx + Nx - 1;
				val sy = pos(1) * Ny;
				val ey = pos(1) * Ny + Ny - 1;
				val sz = pos(2) * Nz;
				val ez = pos(2) * Nz + Nz - 1;
				val st = pos(3) * Nt;
				val et = pos(3) * Nt + Nt - 1;

				is = 0;
				for(i in 0..3){
					for(t in 0..(Lt-1)){
						for(z in 0..(Lz-1)){
							for(y in 0..(Ly-1)){
								for(x in 0..(Lx-1)){
									if(x >= sx && x <= ex && y >= sy && y <= ey && z >= sz && z <= ez && t >= st && t <= et){
										for(idf in 0..17){
											d = myrand.get_double();
											v()(is) = d*2.0 - 1;
											is = is + 1;
										}
									}
									else{
										for(idf in 0..17){
											d = myrand.get_double();
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

}







