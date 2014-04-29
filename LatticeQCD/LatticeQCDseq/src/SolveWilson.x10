/* ****************************************************** */
/*    Wilson fermion solver                               */
/*                                                        */
/*  This program is written in C-like manner, but         */
/*  using C++ functions.  Please compile by g++, or       */
/*  other C++ compiler.              [18 Apr 2009 HM]     */
/*                                                        */
/*  This program is licensed under the Eclipse Public     */
/*  License. You may obtain a copy of the License at      */
/*  http://www.opensource.org/licenses/eclipse-1.0.php    */
/*                                                        */
/*                Copyright(c) Hideo Matsufuru 2009-2013  */
/* ****************************************************** */

import x10.io.File;
import x10.io.FileNotFoundException;

import x10.compiler.Inline;

public final class SolveWilson {
  
  // constants
  static val Nszx = 8;
  static val Nszy = 8;
  static val Nszz = 8;
  static val Ntime = 16;
  static val Nx = Nszx;
  static val Ny = Nszy;
  static val Nz = Nszz;
  static val Nt = Ntime;
  static val Nst = (Nx*Ny*Nz*Nt);
  static val Ncol = 3;
  static val Nvc = (Ncol*2);
  static val Ndf = (Ncol*Ncol*2);
  static val Ncp = (Ncol*Ncol);
  static val ND = 4;
  static val ND2 = 2;
  static val Nvst = (Nvc*ND*Nst);
  
  static val CKs = 0.150;	


  // N.B. moved from solve_CG
  val x = new Rail[Double](Nvst);
  val s = new Rail[Double](Nvst);
  val r = new Rail[Double](Nvst);
  val p = new Rail[Double](Nvst);
  val v = new Rail[Double](Nvst);

  // N.B. moved from opr_DdagD
  val v2 = new Rail[Double](Nvst);

  // N.B. moved from mult_xp, mult_xm, mult_yp, mult_ym, mult_zp, mult_zm, mult_tp, mult_tm
  val vt1 = new Rail[Double](Nvc);
  val vt2 = new Rail[Double](Nvc);

  
  /**
   * The main method for the SolveWilson class
   */
  public static def main(Rail[String]) {
    
    val nc2 = Ncol;
    
    Console.OUT.println("Simple Wilson solver\n");

    Console.OUT.printf("Nx = %3d, Ny = %3d, Nz = %3d, Nt = %3d\n",
                                       Nx, Ny, Nz, Nt);
    Console.OUT.printf("CKs = %10.6f\n", CKs);
    
    val enorm = 1.E-16;
    Console.OUT.printf("enorm = %12.4e\n", enorm);
    
    val nconv = new Cell[Long](0);
    val diff = new Cell[Double](0);
    
    val corr = new Rail[Double](Nt,0);
    
    val xq = new Rail[Double](Nvst);
    val bq = new Rail[Double](Nvst);
    // spinor field
    
    val u = new Rail[Double](Ndf*Nst*4);
    // link variable
    
    val istart = 3;
    
    val qcd = new SolveWilson();
    
    try {
      
      qcd.uinit(istart, u, "../conf_08080816.txt");
      
      val Nvt = Nvc*ND*Nx*Ny*Nz;
      
      Console.OUT.println("  ic  id   nconv      diff");
      
      var meanTime:Long = 0;
      
      
      for(ic in 0..(Ncol-1)){
	for(id in 0..(ND-1)){
	  
	  qcd.set_src(ic,id,0,0,0,0,bq);

	  val startTime = System.currentTimeMillis();
	  qcd.solve_CG(enorm,nconv,diff,xq,u,bq);
      val cgTime = System.currentTimeMillis() - startTime;
      Console.OUT.printf("cg: %f sec.\n", cgTime/1000.0);
	  meanTime += cgTime;
	  
	  Console.OUT.printf(" %3d %3d  %6d %12.4e\n", ic, id, nconv(), diff());
	  
	  for(it in 0..(Nt-1)){
	    val corrF:Double;
	    corrF = qcd.normv(Nvt,xq,Nvt*it);
	    corr(it) += corrF;
	  }
	  
	}
      }
      
      Console.OUT.println("Ps meson correlator:");
      for(it in 0..(Nt-1)){
        Console.OUT.printf(" %6d   %16.8e\n", it, corr(it));
      }
      
      meanTime /= Ncol * ND;
      Console.OUT.println("SolveWilson: " + meanTime + " ms");

    } catch (e:FileNotFoundException) {
      Console.OUT.println("file not found.");
    }
    
  }
  
  /* ****************************************************** */
  def solve_CG(enorm:Double, nconv:Cell[Long], diff:Cell[Double],
	       xq:Rail[Double], u:Rail[Double], b:Rail[Double]){
    
    // N.B. moved to instance field
    // // double x[Nvst], s[Nvst], r[Nvst], p[Nvst], v[Nvst];
    
    val niter = 1000;
    
    equate(Nvst, s, b);
    val snorm:Double;
    val sr:Double;
    sr = normv(Nvst, s);
    snorm = 1.0/sr;
    
    val rr = new Cell[Double](0);
    val rrp = new Cell[Double](0);
    
    nconv() = -1;
    
    solve_CG_init(rrp, rr, u, x, r, s, p, s);
    
    for(iter in 0..(niter-1)){
      
      solve_CG_step(rrp, rr, u, x, r, s, p, s);
      
      if(rr()*snorm < enorm){
	nconv() = iter;
	break;
      }
      
    }
    
    if(nconv() == -1){
      Console.OUT.println(" not converged");
    }
    
    equate(Nvst,xq,x);
    
    opr_DdagD(r,u,x);
    selfadd(Nvst,r,b,-1.0);
    diff() = normv(Nvst,r);
    
  }
  /* ****************************************************** */
  def solve_CG_init(rrp:Cell[Double], rr:Cell[Double], 
		    u:Rail[Double], x:Rail[Double], r:Rail[Double], 
		    s:Rail[Double], p:Rail[Double], v:Rail[Double]){

    equate(Nvst,r,s);
    equate(Nvst,x,s);

    opr_DdagD(s,u,x);

    selfadd(Nvst,r,s,-1.0);
    equate(Nvst,p,r);

    val rrt = normv(Nvst,r);
    rr() = rrt;
    rrp() = rr();

  }
  /* ****************************************************** */
  def solve_CG_step(rrp:Cell[Double], rr:Cell[Double], 
		    u:Rail[Double], x:Rail[Double], r:Rail[Double], 
		    s:Rail[Double], p:Rail[Double], v:Rail[Double]){
    
    opr_DdagD(v,u,p);

    // vecprd(Nvst,pap,v,p);
    val pap = vecprd(Nvst,v,p);
    val cr = rrp()/pap;

    selfadd(Nvst,x,p,cr);

    selfadd(Nvst,r,v,-cr);
    val rrt = normv(Nvst,r);
    rr()=rrt;
    val bk = rr()/rrp();

    selfsprd(Nvst,p,bk);
    selfadd(Nvst,p,r,1.0);

    rrp() = rr();		
    
  }
  /* ****************************************************** */
  def opr_DdagD(v:Rail[Double], u:Rail[Double], w:Rail[Double]){

    // N.B. moved to instance field
    //static double v2[Nvst];
    
    opr_H(v2,u,w );
    opr_H(v ,u,v2);
    
  }
  /* ****************************************************** */
  def opr_D(v:Rail[Double], u:Rail[Double], w:Rail[Double]){

    setconst(Nvst, v, 0.0);

    mult_xp(v,u,w);
    mult_xm(v,u,w);
    mult_yp(v,u,w);
    mult_ym(v,u,w);
    mult_zp(v,u,w);
    mult_zm(v,u,w);
    mult_tp(v,u,w);
    mult_tm(v,u,w);

    spx(Nvst,v,w,-CKs);

  }
  /* ****************************************************** */
  def opr_H(v:Rail[Double], u:Rail[Double], w:Rail[Double]){

    setconst(Nvst, v, 0.0);

    mult_xp(v,u,w);
    mult_xm(v,u,w);
    mult_yp(v,u,w);
    mult_ym(v,u,w);
    mult_zp(v,u,w);
    mult_zm(v,u,w);
    mult_tp(v,u,w);
    mult_tm(v,u,w);

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    for(ist in 0..(Nst-1)){
      val iv = ist*Nvc*ND;
      for(ivc in 0..(Nvc-1)){
	val v3 = v(ivc+id3+iv);
	val v4 = v(ivc+id4+iv);
	v(ivc+id3+iv) = w(ivc+id1+iv) - CKs * v(ivc+id1+iv);
	v(ivc+id4+iv) = w(ivc+id2+iv) - CKs * v(ivc+id2+iv);
	v(ivc+id1+iv) = w(ivc+id3+iv) - CKs * v3;
	v(ivc+id2+iv) = w(ivc+id4+iv) - CKs * v4;
      }
    }

  }
  /* ****************************************************** */
  def mult_xp(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 0;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // int ix, nn;

    // N.B. moved to instance field
    // static double vt1[Nvc], vt2[Nvc];

    // boundary part 
    val ix = Nx-1;
    val nn = 0;
    for(iyzt in 0..(Ny*Nz*Nt-1)){

      val iv = Nvc*ND*(ix + iyzt*Nx);
      val in_ = Nvc*ND*(nn + iyzt*Nx);
      val ig = Ndf*(ix + iyzt*Nx + idir*Nst);

      for(ic in 0..(Ncol-1)){
	vt1(2*ic  ) = v1(2*ic   +id1+in_) - v1(2*ic+1 +id4+in_);
	vt1(2*ic+1) = v1(2*ic+1 +id1+in_) + v1(2*ic   +id4+in_);
	vt2(2*ic  ) = v1(2*ic   +id2+in_) - v1(2*ic+1 +id3+in_);
	vt2(2*ic+1) = v1(2*ic+1 +id2+in_) + v1(2*ic   +id3+in_);
      }

      for(ic in 0..(Ncol-1)){
	val ic2 = ic*Nvc;

	val wt1r = mult_uv_r(u, vt1, ic2, ig);
	val wt1i = mult_uv_i(u, vt1, ic2, ig);
	val wt2r = mult_uv_r(u, vt2, ic2, ig);
	val wt2i = mult_uv_i(u, vt2, ic2, ig);

	v2(2*ic   +id1+iv) =  wt1r;
	v2(2*ic+1 +id1+iv) =  wt1i;
	v2(2*ic   +id2+iv) =  wt2r;
	v2(2*ic+1 +id2+iv) =  wt2i;
	v2(2*ic   +id3+iv) =  wt2i;
	v2(2*ic+1 +id3+iv) = -wt2r;
	v2(2*ic   +id4+iv) =  wt1i;
	v2(2*ic+1 +id4+iv) = -wt1r;
      }
    }

    // bulk part 
    for(iyzt in 0..(Ny*Nz*Nt-1)){
      for(ix_ in 0..(Nx-2)){
	val nn_ = ix_+1;

	val iv = Nvc*ND*(ix_ + iyzt*Nx);
	val in_ = Nvc*ND*(nn_ + iyzt*Nx);
	val ig = Ndf*(ix_ + iyzt*Nx + idir*Nst);

	for(ic in 0..(Ncol-1)){
	  vt1(2*ic  ) = v1(2*ic   +id1+in_) - v1(2*ic+1 +id4+in_);
	  vt1(2*ic+1) = v1(2*ic+1 +id1+in_) + v1(2*ic   +id4+in_);
	  vt2(2*ic  ) = v1(2*ic   +id2+in_) - v1(2*ic+1 +id3+in_);
	  vt2(2*ic+1) = v1(2*ic+1 +id2+in_) + v1(2*ic   +id3+in_);
	}

	for(ic in 0..(Ncol-1)){
	  val ic2 = ic*Nvc;

	  val wt1r = mult_uv_r(u, vt1, ic2, ig);
	  val wt1i = mult_uv_i(u, vt1, ic2, ig);
	  val wt2r = mult_uv_r(u, vt2, ic2, ig);
	  val wt2i = mult_uv_i(u, vt2, ic2, ig);

	  v2(2*ic   +id1+iv) =  wt1r;
	  v2(2*ic+1 +id1+iv) =  wt1i;
	  v2(2*ic   +id2+iv) =  wt2r;
	  v2(2*ic+1 +id2+iv) =  wt2i;
	  v2(2*ic   +id3+iv) =  wt2i;
	  v2(2*ic+1 +id3+iv) = -wt2r;
	  v2(2*ic   +id4+iv) =  wt1i;
	  v2(2*ic+1 +id4+iv) = -wt1r;
	}
      }
    }

  }

  /* ****************************************************** */
  def mult_xm(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 0;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // int ix, nn;

    // N.B. moved to instance field
    // double vt1[Nvc], vt2[Nvc];

    // boundary part 
    val ix = 0;
    val nn = Nx-1;
    for(iyzt in 0..(Ny*Nz*Nt-1)){

      val iv = Nvc*ND*(ix + iyzt*Nx);
      val in_ = Nvc*ND*(nn + iyzt*Nx);
      val ig = Ndf*(nn + iyzt*Nx + idir*Nst);

      for(ic in 0..(Ncol-1)){
	vt1(2*ic  ) = v1(2*ic   +id1+in_) + v1(2*ic+1 +id4+in_);
	vt1(2*ic+1) = v1(2*ic+1 +id1+in_) - v1(2*ic   +id4+in_);

	vt2(2*ic  ) = v1(2*ic   +id2+in_) + v1(2*ic+1 +id3+in_);
	vt2(2*ic+1) = v1(2*ic+1 +id2+in_) - v1(2*ic   +id3+in_);
      }

      for(ic in 0..(Ncol-1)){
	val icr = 2*ic;
	val ici = 2*ic+1;
	val ic1 = 0;
	val ic2 = Nvc;
	val ic3 = 2*Nvc;

	val wt1r = mult_udagv_r(u, vt1, icr, ig);
	val wt1i = mult_udagv_i(u, vt1, icr, ig);
	val wt2r = mult_udagv_r(u, vt2, icr, ig);
	val wt2i = mult_udagv_i(u, vt2, icr, ig);

	v2(icr +id1+iv) +=  wt1r;
	v2(ici +id1+iv) +=  wt1i;
	v2(icr +id2+iv) +=  wt2r;
	v2(ici +id2+iv) +=  wt2i;
	v2(icr +id3+iv) += -wt2i;
	v2(ici +id3+iv) += +wt2r;
	v2(icr +id4+iv) += -wt1i;
	v2(ici +id4+iv) += +wt1r;
      }
    }

    // bulk part 
    for(iyzt in 0..(Ny*Nz*Nt-1)){
      for(ix_ in 1..(Nx-1)){
	val nn_ = ix_-1;

	val iv = Nvc*ND*(ix_ + (iyzt)*Nx);
	val in_ = Nvc*ND*(nn_ + (iyzt)*Nx);
	val ig = Ndf*(nn_ + iyzt*Nx + idir*Nst);

	for(ic in 0..(Ncol-1)){
	  vt1(2*ic  ) = v1(2*ic   +id1+in_) + v1(2*ic+1 +id4+in_);
	  vt1(2*ic+1) = v1(2*ic+1 +id1+in_) - v1(2*ic   +id4+in_);

	  vt2(2*ic  ) = v1(2*ic   +id2+in_) + v1(2*ic+1 +id3+in_);
	  vt2(2*ic+1) = v1(2*ic+1 +id2+in_) - v1(2*ic   +id3+in_);
	}

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;
	  val ic1 = 0;
	  val ic2 = Nvc;
	  val ic3 = 2*Nvc;

	  val wt1r = mult_udagv_r(u, vt1, icr, ig);
	  val wt1i = mult_udagv_i(u, vt1, icr, ig);
	  val wt2r = mult_udagv_r(u, vt2, icr, ig);
	  val wt2i = mult_udagv_i(u, vt2, icr, ig);

	  v2(icr +id1+iv) +=  wt1r;
	  v2(ici +id1+iv) +=  wt1i;
	  v2(icr +id2+iv) +=  wt2r;
	  v2(ici +id2+iv) +=  wt2i;
	  v2(icr +id3+iv) += -wt2i;
	  v2(ici +id3+iv) += +wt2r;
	  v2(icr +id4+iv) += -wt1i;
	  v2(ici +id4+iv) += +wt1r;
	}
      }
    }


  }
  /* ****************************************************** */
  def mult_yp(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 1;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // N.B. moved to instance field
    // static double vt1[Nvc], vt2[Nvc];

    // boundary part 
    val iy = Ny-1;
    val nn = 0;
    for(izt in 0..(Nz*Nt-1)){
      for(ix in 0..(Nx-1)){

	val iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
	val in_ = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
	val ig = Ndf*(ix + iy*Nx + izt*Nx*Ny + idir*Nst);

	for(ic in 0..(Ncol-1)){
	  vt1(2*ic  ) = v1(2*ic   +id1+in_) + v1(2*ic   +id4+in_);
	  vt1(2*ic+1) = v1(2*ic+1 +id1+in_) + v1(2*ic+1 +id4+in_);
	  vt2(2*ic  ) = v1(2*ic   +id2+in_) - v1(2*ic   +id3+in_);
	  vt2(2*ic+1) = v1(2*ic+1 +id2+in_) - v1(2*ic+1 +id3+in_);
	}

	for(ic in 0..(Ncol-1)){
	  val ic2 = ic*Nvc;

	  val wt1r = mult_uv_r(u, vt1, ic2, ig);
	  val wt1i = mult_uv_i(u, vt1, ic2, ig);
	  val wt2r = mult_uv_r(u, vt2, ic2, ig);
	  val wt2i = mult_uv_i(u, vt2, ic2, ig);

	  v2(2*ic   +id1+iv) +=  wt1r;
	  v2(2*ic+1 +id1+iv) +=  wt1i;
	  v2(2*ic   +id2+iv) +=  wt2r;
	  v2(2*ic+1 +id2+iv) +=  wt2i;
	  v2(2*ic   +id3+iv) += -wt2r;
	  v2(2*ic+1 +id3+iv) += -wt2i;
	  v2(2*ic   +id4+iv) +=  wt1r;
	  v2(2*ic+1 +id4+iv) +=  wt1i;
	}
      }
    }

    // bulk part 
    for(izt in 0..(Nz*Nt-1)){
      for(iy_ in 0..(Ny-2)){
	val nn_ = iy_ + 1;
	for(ix in 0..(Nx-1)){

	  val iv = Nvc*ND*(ix + iy_*Nx + izt*Nx*Ny);
	  val in_ = Nvc*ND*(ix + nn_*Nx + izt*Nx*Ny);
	  val ig = Ndf*(ix + iy_*Nx + izt*Nx*Ny + idir*Nst);

	  for(ic in 0..(Ncol-1)){
	    vt1(2*ic  ) = v1(2*ic   +id1+in_) + v1(2*ic   +id4+in_);
	    vt1(2*ic+1) = v1(2*ic+1 +id1+in_) + v1(2*ic+1 +id4+in_);
	    vt2(2*ic  ) = v1(2*ic   +id2+in_) - v1(2*ic   +id3+in_);
	    vt2(2*ic+1) = v1(2*ic+1 +id2+in_) - v1(2*ic+1 +id3+in_);
	  }

	  for(ic in 0..(Ncol-1)){
	    val ic2 = ic*Nvc;

	    val wt1r = mult_uv_r(u, vt1, ic2, ig);
	    val wt1i = mult_uv_i(u, vt1, ic2, ig);
	    val wt2r = mult_uv_r(u, vt2, ic2, ig);
	    val wt2i = mult_uv_i(u, vt2, ic2, ig);

	    v2(2*ic   +id1+iv) +=  wt1r;
	    v2(2*ic+1 +id1+iv) +=  wt1i;
	    v2(2*ic   +id2+iv) +=  wt2r;
	    v2(2*ic+1 +id2+iv) +=  wt2i;
	    v2(2*ic   +id3+iv) += -wt2r;
	    v2(2*ic+1 +id3+iv) += -wt2i;
	    v2(2*ic   +id4+iv) +=  wt1r;
	    v2(2*ic+1 +id4+iv) +=  wt1i;
	  }
	}
      }
    }

  }

  /* ****************************************************** */
  def mult_ym(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 1;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // N.B. moved to instance field
    // double vt1[Nvc], vt2[Nvc];

    // boundary part 
    val iy = 0;
    val nn = Ny-1;
    for(izt in 0..(Nz*Nt-1)){
      for(ix in 0..(Nx-1)){

	val iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
	val in_ = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
	val ig = Ndf*(ix + nn*Nx + izt*Nx*Ny + idir*Nst);

	for(ic in 0..(Ncol-1)){
	  vt1(2*ic  ) = v1(2*ic   +id1+in_) - v1(2*ic   +id4+in_);
	  vt1(2*ic+1) = v1(2*ic+1 +id1+in_) - v1(2*ic+1 +id4+in_);

	  vt2(2*ic  ) = v1(2*ic   +id2+in_) + v1(2*ic   +id3+in_);
	  vt2(2*ic+1) = v1(2*ic+1 +id2+in_) + v1(2*ic+1 +id3+in_);
	}

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;
	  val ic1 = 0;
	  val ic2 = Nvc;
	  val ic3 = 2*Nvc;

	  val wt1r = mult_udagv_r(u, vt1, icr, ig);
	  val wt1i = mult_udagv_i(u, vt1, icr, ig);
	  val wt2r = mult_udagv_r(u, vt2, icr, ig);
	  val wt2i = mult_udagv_i(u, vt2, icr, ig);

	  v2(icr +id1+iv) +=  wt1r;
	  v2(ici +id1+iv) +=  wt1i;
	  v2(icr +id2+iv) +=  wt2r;
	  v2(ici +id2+iv) +=  wt2i;
	  v2(icr +id3+iv) +=  wt2r;
	  v2(ici +id3+iv) +=  wt2i;
	  v2(icr +id4+iv) += -wt1r;
	  v2(ici +id4+iv) += -wt1i;
	}
      }
    }

    // bulk part 
    for(izt in 0..(Nz*Nt-1)){
      for(iy_ in 1..(Ny-1)){
	val nn_ = iy_ - 1;
	for(ix in 0..(Nx-1)){

	  val iv = Nvc*ND*(ix + iy_*Nx + izt*Nx*Ny);
	  val in_ = Nvc*ND*(ix + nn_*Nx + izt*Nx*Ny);
	  val ig = Ndf*(ix + nn_*Nx + izt*Nx*Ny + idir*Nst);

	  for(ic in 0..(Ncol-1)){
	    vt1(2*ic  ) = v1(2*ic   +id1+in_) - v1(2*ic   +id4+in_);
	    vt1(2*ic+1) = v1(2*ic+1 +id1+in_) - v1(2*ic+1 +id4+in_);

	    vt2(2*ic  ) = v1(2*ic   +id2+in_) + v1(2*ic   +id3+in_);
	    vt2(2*ic+1) = v1(2*ic+1 +id2+in_) + v1(2*ic+1 +id3+in_);
	  }

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;
	    val ic1 = 0;
	    val ic2 = Nvc;
	    val ic3 = 2*Nvc;

	    val wt1r = mult_udagv_r(u, vt1, icr, ig);
	    val wt1i = mult_udagv_i(u, vt1, icr, ig);
	    val wt2r = mult_udagv_r(u, vt2, icr, ig);
	    val wt2i = mult_udagv_i(u, vt2, icr, ig);

	    v2(icr +id1+iv) +=  wt1r;
	    v2(ici +id1+iv) +=  wt1i;
	    v2(icr +id2+iv) +=  wt2r;
	    v2(ici +id2+iv) +=  wt2i;
	    v2(icr +id3+iv) +=  wt2r;
	    v2(ici +id3+iv) +=  wt2i;
	    v2(icr +id4+iv) += -wt1r;
	    v2(ici +id4+iv) += -wt1i;
	  }
	}
      }
    }


  }
  /* ****************************************************** */
  def mult_zp(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 2;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // N.B. moved to instance field
    //static double vt1[Nvc], vt2[Nvc];

    // boundary part 
    val iz = Nz-1;
    val nn = 0;
    for(it in 0..(Nt-1)){
      for(ixy in 0..(Nx*Ny-1)){

	val iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
	val in_ = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
	val ig = Ndf*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

	for(ic in 0..(Ncol-1)){
	  vt1(2*ic  ) = v1(2*ic   +id1+in_) - v1(2*ic+1 +id3+in_);
	  vt1(2*ic+1) = v1(2*ic+1 +id1+in_) + v1(2*ic   +id3+in_);
	  vt2(2*ic  ) = v1(2*ic   +id2+in_) + v1(2*ic+1 +id4+in_);
	  vt2(2*ic+1) = v1(2*ic+1 +id2+in_) - v1(2*ic   +id4+in_);
	}

	for(ic in 0..(Ncol-1)){
	  val ic2 = ic*Nvc;

	  val wt1r = mult_uv_r(u, vt1, ic2, ig);
	  val wt1i = mult_uv_i(u, vt1, ic2, ig);
	  val wt2r = mult_uv_r(u, vt2, ic2, ig);
	  val wt2i = mult_uv_i(u, vt2, ic2, ig);

	  v2(2*ic   +id1+iv) +=  wt1r;
	  v2(2*ic+1 +id1+iv) +=  wt1i;
	  v2(2*ic   +id2+iv) +=  wt2r;
	  v2(2*ic+1 +id2+iv) +=  wt2i;
	  v2(2*ic   +id3+iv) +=  wt1i;
	  v2(2*ic+1 +id3+iv) += -wt1r;
	  v2(2*ic   +id4+iv) += -wt2i;
	  v2(2*ic+1 +id4+iv) +=  wt2r;
	}
      }
    }

    // bulk part 
    for(it in 0..(Nt-1)){
      for(iz_ in 0..(Nz-2)){
	val nn_ = iz_ + 1;
	for(ixy in 0..(Nx*Ny-1)){

	  val iv = Nvc*ND*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz);
	  val in_ = Nvc*ND*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz);
	  val ig = Ndf*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

	  for(ic in 0..(Ncol-1)){
	    vt1(2*ic  ) = v1(2*ic   +id1+in_) - v1(2*ic+1 +id3+in_);
	    vt1(2*ic+1) = v1(2*ic+1 +id1+in_) + v1(2*ic   +id3+in_);
	    vt2(2*ic  ) = v1(2*ic   +id2+in_) + v1(2*ic+1 +id4+in_);
	    vt2(2*ic+1) = v1(2*ic+1 +id2+in_) - v1(2*ic   +id4+in_);
	  }

	  for(ic in 0..(Ncol-1)){
	    val ic2 = ic*Nvc;

	    val wt1r = mult_uv_r(u, vt1, ic2, ig);
	    val wt1i = mult_uv_i(u, vt1, ic2, ig);
	    val wt2r = mult_uv_r(u, vt2, ic2, ig);
	    val wt2i = mult_uv_i(u, vt2, ic2, ig);

	    v2(2*ic   +id1+iv) +=  wt1r;
	    v2(2*ic+1 +id1+iv) +=  wt1i;
	    v2(2*ic   +id2+iv) +=  wt2r;
	    v2(2*ic+1 +id2+iv) +=  wt2i;
	    v2(2*ic   +id3+iv) +=  wt1i;
	    v2(2*ic+1 +id3+iv) += -wt1r;
	    v2(2*ic   +id4+iv) += -wt2i;
	    v2(2*ic+1 +id4+iv) +=  wt2r;
	  }
	}
      }
    }

  }
  /* ****************************************************** */
  def mult_zm(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 2;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // N.B. moved to instance field
    // double vt1[Nvc], vt2[Nvc];

    // boundary part 
    val iz = 0;
    val nn = Nz-1;
    for(it in 0..(Nt-1)){
      for(ixy in 0..(Nx*Ny-1)){

	val iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
	val in_ = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
	val ig = Ndf*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

	for(ic in 0..(Ncol-1)){
	  vt1(2*ic  ) = v1(2*ic   +id1+in_) + v1(2*ic+1 +id3+in_);
	  vt1(2*ic+1) = v1(2*ic+1 +id1+in_) - v1(2*ic   +id3+in_);
	  vt2(2*ic  ) = v1(2*ic   +id2+in_) - v1(2*ic+1 +id4+in_);
	  vt2(2*ic+1) = v1(2*ic+1 +id2+in_) + v1(2*ic   +id4+in_);
	}

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;
	  val ic1 = 0;
	  val ic2 = Nvc;
	  val ic3 = 2*Nvc;

	  val wt1r = mult_udagv_r(u, vt1, icr, ig);
	  val wt1i = mult_udagv_i(u, vt1, icr, ig);
	  val wt2r = mult_udagv_r(u, vt2, icr, ig);
	  val wt2i = mult_udagv_i(u, vt2, icr, ig);

	  v2(icr +id1+iv) +=  wt1r;
	  v2(ici +id1+iv) +=  wt1i;
	  v2(icr +id2+iv) +=  wt2r;
	  v2(ici +id2+iv) +=  wt2i;
	  v2(icr +id3+iv) += -wt1i;
	  v2(ici +id3+iv) +=  wt1r;
	  v2(icr +id4+iv) +=  wt2i;
	  v2(ici +id4+iv) += -wt2r;
	}
      }
    }

    // bulk part 
    for(it in 0..(Nt-1)){
      for(iz_ in 1..(Nz-1)){
	val nn_ = iz_ - 1;
	for(ixy in 0..(Nx*Ny-1)){

	  val iv = Nvc*ND*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz);
	  val in_ = Nvc*ND*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz);
	  val ig = Ndf*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

	  for(ic in 0..(Ncol-1)){
	    vt1(2*ic  ) = v1(2*ic   +id1+in_) + v1(2*ic+1 +id3+in_);
	    vt1(2*ic+1) = v1(2*ic+1 +id1+in_) - v1(2*ic   +id3+in_);
	    vt2(2*ic  ) = v1(2*ic   +id2+in_) - v1(2*ic+1 +id4+in_);
	    vt2(2*ic+1) = v1(2*ic+1 +id2+in_) + v1(2*ic   +id4+in_);
	  }

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;
	    val ic1 = 0;
	    val ic2 = Nvc;
	    val ic3 = 2*Nvc;

	    val wt1r = mult_udagv_r(u, vt1, icr, ig);
	    val wt1i = mult_udagv_i(u, vt1, icr, ig);
	    val wt2r = mult_udagv_r(u, vt2, icr, ig);
	    val wt2i = mult_udagv_i(u, vt2, icr, ig);

	    v2(icr +id1+iv) +=  wt1r;
	    v2(ici +id1+iv) +=  wt1i;
	    v2(icr +id2+iv) +=  wt2r;
	    v2(ici +id2+iv) +=  wt2i;
	    v2(icr +id3+iv) += -wt1i;
	    v2(ici +id3+iv) +=  wt1r;
	    v2(icr +id4+iv) +=  wt2i;
	    v2(ici +id4+iv) += -wt2r;
	  }
	}
      }
    }

  }
  /* ****************************************************** */
  def mult_tp(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 3;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // N.B. moved to instance field
    // static double vt1[Nvc], vt2[Nvc];

    // boundary part 
    val it = Nt-1;
    val nn = 0;
    for(ixyz in 0..(Nx*Ny*Nz-1)){

      val iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
      val in_ = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
      val ig = Ndf*(ixyz + it*Nx*Ny*Nz + idir*Nst);

      for(ic in 0..(Ncol-1)){
	vt1(2*ic  ) = 2.0 * v1(2*ic   +id3+in_);
	vt1(2*ic+1) = 2.0 * v1(2*ic+1 +id3+in_);
	vt2(2*ic  ) = 2.0 * v1(2*ic   +id4+in_);
	vt2(2*ic+1) = 2.0 * v1(2*ic+1 +id4+in_);
      }

      for(ic in 0..(Ncol-1)){
	val ic2 = ic*Nvc;

	val wt1r = mult_uv_r(u, vt1, ic2, ig);
	val wt1i = mult_uv_i(u, vt1, ic2, ig);
	val wt2r = mult_uv_r(u, vt2, ic2, ig);
	val wt2i = mult_uv_i(u, vt2, ic2, ig);

	v2(2*ic   +id3+iv) +=  wt1r;
	v2(2*ic+1 +id3+iv) +=  wt1i;
	v2(2*ic   +id4+iv) +=  wt2r;
	v2(2*ic+1 +id4+iv) +=  wt2i;
      }
    }

    // bulk part 
    for(it_ in 0..(Nt-2)){
      val nn_ = it_ + 1;
      for(ixyz in 0..(Nx*Ny*Nz-1)){

	val iv = Nvc*ND*(ixyz + it_*Nx*Ny*Nz);
	val in_ = Nvc*ND*(ixyz + nn_*Nx*Ny*Nz);
	val ig = Ndf*(ixyz + it_*Nx*Ny*Nz + idir*Nst);

	for(ic in 0..(Ncol-1)){
	  vt1(2*ic  ) = 2.0 * v1(2*ic   +id3+in_);
	  vt1(2*ic+1) = 2.0 * v1(2*ic+1 +id3+in_);
	  vt2(2*ic  ) = 2.0 * v1(2*ic   +id4+in_);
	  vt2(2*ic+1) = 2.0 * v1(2*ic+1 +id4+in_);
	}

	for(ic in 0..(Ncol-1)){
	  val ic2 = ic*Nvc;

	  val wt1r = mult_uv_r(u, vt1, ic2, ig);
	  val wt1i = mult_uv_i(u, vt1, ic2, ig);
	  val wt2r = mult_uv_r(u, vt2, ic2, ig);
	  val wt2i = mult_uv_i(u, vt2, ic2, ig);

	  v2(2*ic   +id3+iv) +=  wt1r;
	  v2(2*ic+1 +id3+iv) +=  wt1i;
	  v2(2*ic   +id4+iv) +=  wt2r;
	  v2(2*ic+1 +id4+iv) +=  wt2i;
	}
      }
    }

  }
  /* ****************************************************** */
  def mult_tm(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 3;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // N.B. moved to instance field
    // double vt1[Nvc], vt2[Nvc];

    // boundary part 
    val it = 0;
    val nn = Nt-1;
    for(ixyz in 0..(Nx*Ny*Nz-1)){

      val iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
      val in_ = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
      val ig = Ndf*(ixyz + nn*Nx*Ny*Nz + idir*Nst);

      for(ic in 0..(Ncol-1)){
	vt1(2*ic  ) = 2.0 * v1(2*ic   +id1+in_);
	vt1(2*ic+1) = 2.0 * v1(2*ic+1 +id1+in_);
	vt2(2*ic  ) = 2.0 * v1(2*ic   +id2+in_);
	vt2(2*ic+1) = 2.0 * v1(2*ic+1 +id2+in_);
      }

      for(ic in 0..(Ncol-1)){
	val icr = 2*ic;
	val ici = 2*ic+1;
	val ic1 = 0;
	val ic2 = Nvc;
	val ic3 = 2*Nvc;

	val wt1r = mult_udagv_r(u, vt1, icr, ig);
	val wt1i = mult_udagv_i(u, vt1, icr, ig);
	val wt2r = mult_udagv_r(u, vt2, icr, ig);
	val wt2i = mult_udagv_i(u, vt2, icr, ig);

	v2(icr +id1+iv) +=  wt1r;
	v2(ici +id1+iv) +=  wt1i;
	v2(icr +id2+iv) +=  wt2r;
	v2(ici +id2+iv) +=  wt2i;
      }
    }

    // bulk part 
    for(it_ in 1..(Nt-1)){
      val nn_ = it_ - 1;
      for(ixyz in 0..(Nx*Ny*Nz-1)){

	val iv = Nvc*ND*(ixyz + it_*Nx*Ny*Nz);
	val in_ = Nvc*ND*(ixyz + nn_*Nx*Ny*Nz);
	val ig = Ndf*(ixyz + nn_*Nx*Ny*Nz + idir*Nst);

	for(ic in 0..(Ncol-1)){
	  vt1(2*ic  ) = 2.0 * v1(2*ic   +id1+in_);
	  vt1(2*ic+1) = 2.0 * v1(2*ic+1 +id1+in_);
	  vt2(2*ic  ) = 2.0 * v1(2*ic   +id2+in_);
	  vt2(2*ic+1) = 2.0 * v1(2*ic+1 +id2+in_);
	}

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;
	  val ic1 = 0;
	  val ic2 = Nvc;
	  val ic3 = 2*Nvc;

	  val wt1r = mult_udagv_r(u, vt1, icr, ig);
	  val wt1i = mult_udagv_i(u, vt1, icr, ig);
	  val wt2r = mult_udagv_r(u, vt2, icr, ig);
	  val wt2i = mult_udagv_i(u, vt2, icr, ig);

	  v2(icr +id1+iv) +=  wt1r;
	  v2(ici +id1+iv) +=  wt1i;
	  v2(icr +id2+iv) +=  wt2r;
	  v2(ici +id2+iv) +=  wt2i;
	}
      }
    }

  }

  /* ****************************************************** */
  static @Inline def mult_uv_r(u:Rail[Double], v:Rail[Double], ic2:Long, ig:Long) {
    return u(0+ic2+ig)*v(0) - u(1+ic2+ig)*v(1)
    + u(2+ic2+ig)*v(2) - u(3+ic2+ig)*v(3)
    + u(4+ic2+ig)*v(4) - u(5+ic2+ig)*v(5);
  }

  /* ****************************************************** */
  static @Inline def mult_uv_i(u:Rail[Double], v:Rail[Double], ic2:Long, ig:Long) {
    return u(0+ic2+ig)*v(1) + u(1+ic2+ig)*v(0)
    + u(2+ic2+ig)*v(3) + u(3+ic2+ig)*v(2)
    + u(4+ic2+ig)*v(5) + u(5+ic2+ig)*v(4);
  }

  /* ****************************************************** */
  static @Inline def mult_udagv_r(u:Rail[Double], v:Rail[Double], icr:Long, ig:Long) {
    val ici = icr+1;
    val ic1 = 0;
    val ic2 = Nvc;
    val ic3 = 2*Nvc;

    return u(icr+ic1+ig)*v(0) + u(ici+ic1+ig)*v(1)
    + u(icr+ic2+ig)*v(2) + u(ici+ic2+ig)*v(3)
    + u(icr+ic3+ig)*v(4) + u(ici+ic3+ig)*v(5);
  }

  /* ****************************************************** */
  static @Inline def mult_udagv_i(u:Rail[Double], v:Rail[Double], icr:Long, ig:Long) {
    val ici = icr+1;
    val ic1 = 0;
    val ic2 = Nvc;
    val ic3 = 2*Nvc;

    return u(icr+ic1+ig)*v(1) - u(ici+ic1+ig)*v(0)
    + u(icr+ic2+ig)*v(3) - u(ici+ic2+ig)*v(2)
    + u(icr+ic3+ig)*v(5) - u(ici+ic3+ig)*v(4);
  }

  /* ****************************************************** */
  def set_src(ic:Long, id:Long,
	      ix:Long, iy:Long, iz:Long, it:Long, v:Rail[Double]){

    setconst(Nvst, v, 0.0);

    val i = 2*ic + id*Nvc + Nvc*ND*(ix + iy*Nszx
				    + iz*Nszx*Nszy + it*Nszx*Nszy*Nszz);

    v(i)=1.0;

  }
  
  /* ****************************************************** */
  def uinit(istart:Long, u:Rail[Double], fileName:String) throws FileNotFoundException { 
    
    if(istart > 2){  // read from file
      
      val file = new File(fileName);
      val reader = file.openRead();				
      for (ist in 0..(Nst-1)) {
	for (idir in 0..3) {
	  for(idf in 0..(Ndf-1)){
	    val i = idf + ist*Ndf + idir*Ndf*Nst;
	    u(i) = Double.parseDouble(reader.readLine().trim());
	  }
	}
      }
      reader.close();
      
      
      
    }else{  // free field

      setunit(Nst*4,u);

    }

  }	


  /* ****************************************************** */
  def setunit(nv:Long, u:Rail[Double]) {
    
    for(i in 0..(nv-1)){

      val is = Ndf*i;

      u(   is) = 1.0;   u( 1+is) = 0.0;
      u( 2+is) = 0.0;   u( 3+is) = 0.0;
      u( 4+is) = 0.0;   u( 5+is) = 0.0;

      u( 6+is) = 0.0;   u( 7+is) = 0.0;
      u( 8+is) = 1.0;   u( 9+is) = 0.0;
      u(10+is) = 0.0;   u(11+is) = 0.0;

      u(12+is) = 0.0;   u(13+is) = 0.0;
      u(14+is) = 0.0;   u(15+is) = 0.0;
      u(16+is) = 1.0;   u(17+is) = 0.0;

    }

  }	
  
  /* ****************************************************** */
  def setconst(nv:Long, v:Rail[Double], a:Double){

    for(i in 0..(nv-1)){
      v(i) = a;
    }

  }
  
  /* ****************************************************** */
  def vecprd(nv:Long, v1:Rail[Double], v2:Rail[Double]){
    var a:Double = 0.0;
    for(i in 0..(nv-1)){
      a = a + v1(i)*v2(i);
    }
    
    return a;
  }
  
  /* ****************************************************** */
  def normv(nv:Long, v:Rail[Double], offset:Long){
    var a:Double = 0.0;
    for(i in offset..(offset+nv-1)){
      a = a + v(i)*v(i);
    }

    return a; 
  }
  
  def normv(nv:Long, v:Rail[Double]){
    return normv(nv, v, 0);
  }

  /* ****************************************************** */
  def selfadd(nv:Long, v:Rail[Double], w:Rail[Double], a:Double){

    for(i in 0..(nv-1)){
      v(i) = v(i) + a * w(i);
    }

  }
  /* ****************************************************** */
  def selfsprd(nv:Long, v:Rail[Double], a:Double){

    for(i in 0..(nv-1)){
      v(i) = a * v(i);
    }

  }
  /* ****************************************************** */
  def spx(nv:Long, v:Rail[Double], w:Rail[Double], a:Double){

    for(i in 0..(nv-1)){
      v(i) = a * v(i) + w(i);
    }

  }
  /* ****************************************************** */
  def equate(nv:Long, v:Rail[Double],  w:Rail[Double]){

    for(i in 0..(nv-1)){
      v(i) = w(i);
    }

  }
  /* ****************************************************** */

  // for debug
  def write_vector(v:Rail[Double], len:Long){
    val file = new File("x10_vector");

    if(file.exists()){
      // val writer = file.openWrite();
      
      val p = file.printer();

      for (i in 0..(len-1)) {
	p.println(v(i));
      }
      p.flush();

    } else {
      Console.OUT.println("file does not exist.");
      // TODO: error handling
    }

  }


}
