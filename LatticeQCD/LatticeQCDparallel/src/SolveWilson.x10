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
import x10.lang.Math;
import x10.compiler.Inline;
import x10.compiler.Pragma;

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

  // generate input values
  static val MYRAND_MAX = 32767;

  // N.B. moved from solve_CG
  val x = new Rail[Double](Nvst);
  val s = new Rail[Double](Nvst);
  val r = new Rail[Double](Nvst);
  val p = new Rail[Double](Nvst);
  val v = new Rail[Double](Nvst);

  // N.B. moved from opr_DdagD
  val v2 = new Rail[Double](Nvst);

  // timers
  var mult_meanTime:Long = 0;
  var mult_x_meanTime:Long = 0;
  var mult_y_meanTime:Long = 0;
  var mult_z_meanTime:Long = 0;
  var mult_t_meanTime:Long = 0;

  /**
   * The main method for the SolveWilson class
   */
  public static def main(Rail[String]) {
    
    Console.OUT.println("X10_NTHREADS: " + Runtime.NTHREADS);
    Console.OUT.println("X10_NPLACES: " + Place.numPlaces());

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
    
    //TODO: constructor
    val qcd = new SolveWilson();
    
    try {
      
      qcd.uinit(istart, u, "../conf_08080816.txt");
      
      val Nvt = Nvc*ND*Nx*Ny*Nz;
      
      Console.OUT.println("  ic  id   nconv      diff");
      
      var meanTime:Long = 0;
      
      
      for(ic in 0..(Ncol-1)) {
	for(id in 0..(ND-1)) {
	  
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
      
      //timer
      meanTime /= Ncol * ND;
      Console.OUT.println("SolveWilson: " + meanTime + " ms");

    } catch (e:FileNotFoundException) {
      Console.OUT.println("file not found.");
    }
    
  }
  
  /* ****************************************************** */
  def solve_CG(enorm:Double, nconv:Cell[Long], diff:Cell[Double],
	       xq:Rail[Double], u:Rail[Double], b:Rail[Double]){
    
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
    
    //debug
    var step_meanTime:Long = 0;

    val step_startTime = System.currentTimeMillis();
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

    step_meanTime += System.currentTimeMillis() - step_startTime;
    
    equate(Nvst,xq,x);
    
    opr_DdagD(r,u,x);
    selfadd(Nvst,r,b,-1.0);
    diff() = normv(Nvst,r);
    
    //timer
    Console.OUT.println("step: " + step_meanTime);
    Console.OUT.println("mult: " + mult_meanTime);
    Console.OUT.println("mult_x: " + mult_x_meanTime);
    Console.OUT.println("mult_y: " + mult_y_meanTime);
    Console.OUT.println("mult_z: " + mult_z_meanTime);
    Console.OUT.println("mult_t: " + mult_t_meanTime);
    mult_meanTime = 0;
    mult_x_meanTime = 0;
    mult_y_meanTime = 0;
    mult_z_meanTime = 0;
    mult_t_meanTime = 0;

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

    // timers
    val mult_startTime = System.currentTimeMillis();
    mult_xp(v,u,w);
    mult_xm(v,u,w);
    mult_x_meanTime += System.currentTimeMillis() - mult_startTime;
    val mult_y_startTime = System.currentTimeMillis();
    mult_yp(v,u,w);
    mult_ym(v,u,w);
    mult_y_meanTime += System.currentTimeMillis() - mult_y_startTime;
    val mult_z_startTime = System.currentTimeMillis();
    mult_zp(v,u,w);
    mult_zm(v,u,w);
    mult_z_meanTime += System.currentTimeMillis() - mult_z_startTime;
    val mult_t_startTime = System.currentTimeMillis();
    mult_tp(v,u,w);
    mult_tm(v,u,w);
    mult_t_meanTime += System.currentTimeMillis() - mult_t_startTime;

    mult_meanTime += System.currentTimeMillis() - mult_startTime;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    parallel(0..(Nst-1), (r:LongRange)=> {
      for(ist in r){
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
    });

  }
  /* ****************************************************** */
  def mult_xp(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 0;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // boundary part 
    val ix = Nx-1;
    val nn = 0;
    // for(iyzt in 0..(Ny*Nz*Nt-1)){
    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {

	val iv = Nvc*ND*(ix + iyzt*Nx);
	val in_ = Nvc*ND*(nn + iyzt*Nx);
	val ig = Ndf*(ix + iyzt*Nx + idir*Nst);

	val vt1_0 = v1(   id1+in_) - v1(1 +id4+in_);
	val vt1_1 = v1(1 +id1+in_) + v1(   id4+in_);
	val vt2_0 = v1(   id2+in_) - v1(1 +id3+in_);
	val vt2_1 = v1(1 +id2+in_) + v1(   id3+in_);
	val vt1_2 = v1(2 +id1+in_) - v1(3 +id4+in_);
	val vt1_3 = v1(3 +id1+in_) + v1(2 +id4+in_);
	val vt2_2 = v1(2 +id2+in_) - v1(3 +id3+in_);
	val vt2_3 = v1(3 +id2+in_) + v1(2 +id3+in_);
	val vt1_4 = v1(4 +id1+in_) - v1(5 +id4+in_);
	val vt1_5 = v1(5 +id1+in_) + v1(4 +id4+in_);
	val vt2_4 = v1(4 +id2+in_) - v1(5 +id3+in_);
	val vt2_5 = v1(5 +id2+in_) + v1(4 +id3+in_);

	for(ic in 0..(Ncol-1)){
	  val ic2 = ic*Nvc;

	  val wt1r = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
	  + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
	  + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
	  val wt1i = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
	  + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
	  + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;

	  val wt2r = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
	  + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
	  + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
	  val wt2i = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
	  + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
	  + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;

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
    });

    // bulk part 
    // for(iyzt in 0..(Ny*Nz*Nt-1)) {
    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {
	for(ix_ in 0..(Nx-2)) {

	  val nn_ = ix_+1;

	  val iv = Nvc*ND*(ix_ + iyzt*Nx);
	  val in_ = Nvc*ND*(nn_ + iyzt*Nx);
	  val ig = Ndf*(ix_ + iyzt*Nx + idir*Nst);

	  val vt1_0 = v1(   id1+in_) - v1(1 +id4+in_);
	  val vt1_1 = v1(1 +id1+in_) + v1(   id4+in_);
	  val vt2_0 = v1(   id2+in_) - v1(1 +id3+in_);
	  val vt2_1 = v1(1 +id2+in_) + v1(   id3+in_);
	  val vt1_2 = v1(2 +id1+in_) - v1(3 +id4+in_);
	  val vt1_3 = v1(3 +id1+in_) + v1(2 +id4+in_);
	  val vt2_2 = v1(2 +id2+in_) - v1(3 +id3+in_);
	  val vt2_3 = v1(3 +id2+in_) + v1(2 +id3+in_);
	  val vt1_4 = v1(4 +id1+in_) - v1(5 +id4+in_);
	  val vt1_5 = v1(5 +id1+in_) + v1(4 +id4+in_);
	  val vt2_4 = v1(4 +id2+in_) - v1(5 +id3+in_);
	  val vt2_5 = v1(5 +id2+in_) + v1(4 +id3+in_);

	  for(ic in 0..(Ncol-1)){
	    val ic2 = ic*Nvc;

	    val wt1r = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
	    + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
	    + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
	    val wt1i = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
	    + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
	    + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;

	    val wt2r = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
	    + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
	    + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
	    val wt2i = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
	    + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
	    + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;

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
    });
  }

  /* ****************************************************** */
  def mult_xm(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 0;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // boundary part 
    val ix = 0;
    val nn = Nx-1;
    // for(iyzt in 0..(Ny*Nz*Nt-1)){
    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {

	val iv = Nvc*ND*(ix + iyzt*Nx);
	val in_ = Nvc*ND*(nn + iyzt*Nx);
	val ig = Ndf*(nn + iyzt*Nx + idir*Nst);

	val vt1_0 = v1(   id1+in_) + v1(1 +id4+in_);
	val vt1_1 = v1(1 +id1+in_) - v1(   id4+in_);
	val vt2_0 = v1(   id2+in_) + v1(1 +id3+in_);
	val vt2_1 = v1(1 +id2+in_) - v1(   id3+in_);
	val vt1_2 = v1(2 +id1+in_) + v1(3 +id4+in_);
	val vt1_3 = v1(3 +id1+in_) - v1(2 +id4+in_);
	val vt2_2 = v1(2 +id2+in_) + v1(3 +id3+in_);
	val vt2_3 = v1(3 +id2+in_) - v1(2 +id3+in_);
	val vt1_4 = v1(4 +id1+in_) + v1(5 +id4+in_);
	val vt1_5 = v1(5 +id1+in_) - v1(4 +id4+in_);
	val vt2_4 = v1(4 +id2+in_) + v1(5 +id3+in_);
	val vt2_5 = v1(5 +id2+in_) - v1(4 +id3+in_);

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;
	  val ic1 = 0;
	  val ic2 = Nvc;
	  val ic3 = 2*Nvc;

	  val wt1r = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
	  + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
	  + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
	  val wt1i = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
	  + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
	  + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

	  val wt2r = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
	  + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
	  + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
	  val wt2i = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
	  + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
	  + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;

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
    });

    // bulk part 
    // for(iyzt in 0..(Ny*Nz*Nt-1)){
    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {
	for(ix_ in 1..(Nx-1)){
	  val nn_ = ix_-1;

	  val iv = Nvc*ND*(ix_ + (iyzt)*Nx);
	  val in_ = Nvc*ND*(nn_ + (iyzt)*Nx);
	  val ig = Ndf*(nn_ + iyzt*Nx + idir*Nst);

	  val vt1_0 = v1(   id1+in_) + v1(1 +id4+in_);
	  val vt1_1 = v1(1 +id1+in_) - v1(   id4+in_);
	  val vt2_0 = v1(   id2+in_) + v1(1 +id3+in_);
	  val vt2_1 = v1(1 +id2+in_) - v1(   id3+in_);
	  val vt1_2 = v1(2 +id1+in_) + v1(3 +id4+in_);
	  val vt1_3 = v1(3 +id1+in_) - v1(2 +id4+in_);
	  val vt2_2 = v1(2 +id2+in_) + v1(3 +id3+in_);
	  val vt2_3 = v1(3 +id2+in_) - v1(2 +id3+in_);
	  val vt1_4 = v1(4 +id1+in_) + v1(5 +id4+in_);
	  val vt1_5 = v1(5 +id1+in_) - v1(4 +id4+in_);
	  val vt2_4 = v1(4 +id2+in_) + v1(5 +id3+in_);
	  val vt2_5 = v1(5 +id2+in_) - v1(4 +id3+in_);

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;
	    val ic1 = 0;
	    val ic2 = Nvc;
	    val ic3 = 2*Nvc;

	    val wt1r = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
	    + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
	    + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
	    val wt1i = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
	    + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
	    + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

	    val wt2r = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
	    + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
	    + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
	    val wt2i = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
	    + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
	    + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;

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
    });


  }
  /* ****************************************************** */
  def mult_yp(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 1;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // boundary part 
    val iy = Ny-1;
    val nn = 0;

    // for(izt in 0..(Nz*Nt-1)){
    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(ix in 0..(Nx-1)){

	  val iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
	  val in_ = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
	  val ig = Ndf*(ix + iy*Nx + izt*Nx*Ny + idir*Nst);

	  val vt1_0 = v1(   id1+in_) + v1(   id4+in_);
	  val vt1_1 = v1(1 +id1+in_) + v1(1 +id4+in_);
	  val vt2_0 = v1(   id2+in_) - v1(   id3+in_);
	  val vt2_1 = v1(1 +id2+in_) - v1(1 +id3+in_);
	  val vt1_2 = v1(2 +id1+in_) + v1(2 +id4+in_);
	  val vt1_3 = v1(3 +id1+in_) + v1(3 +id4+in_);
	  val vt2_2 = v1(2 +id2+in_) - v1(2 +id3+in_);
	  val vt2_3 = v1(3 +id2+in_) - v1(3 +id3+in_);
	  val vt1_4 = v1(4 +id1+in_) + v1(4 +id4+in_);
	  val vt1_5 = v1(5 +id1+in_) + v1(5 +id4+in_);
	  val vt2_4 = v1(4 +id2+in_) - v1(4 +id3+in_);
	  val vt2_5 = v1(5 +id2+in_) - v1(5 +id3+in_);

	  for(ic in 0..(Ncol-1)){
	    val ic2 = ic*Nvc;

	    val wt1r = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
	    + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
	    + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
	    val wt1i = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
	    + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
	    + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;

	    val wt2r = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
	    + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
	    + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
	    val wt2i = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
	    + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
	    + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;

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
    });

    // bulk part 
    // for(izt in 0..(Nz*Nt-1)){
    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(iy_ in 0..(Ny-2)){
	  val nn_ = iy_ + 1;
	  for(ix in 0..(Nx-1)){

	    val iv = Nvc*ND*(ix + iy_*Nx + izt*Nx*Ny);
	    val in_ = Nvc*ND*(ix + nn_*Nx + izt*Nx*Ny);
	    val ig = Ndf*(ix + iy_*Nx + izt*Nx*Ny + idir*Nst);

	    val vt1_0 = v1(   id1+in_) + v1(   id4+in_);
	    val vt1_1 = v1(1 +id1+in_) + v1(1 +id4+in_);
	    val vt2_0 = v1(   id2+in_) - v1(   id3+in_);
	    val vt2_1 = v1(1 +id2+in_) - v1(1 +id3+in_);
	    val vt1_2 = v1(2 +id1+in_) + v1(2 +id4+in_);
	    val vt1_3 = v1(3 +id1+in_) + v1(3 +id4+in_);
	    val vt2_2 = v1(2 +id2+in_) - v1(2 +id3+in_);
	    val vt2_3 = v1(3 +id2+in_) - v1(3 +id3+in_);
	    val vt1_4 = v1(4 +id1+in_) + v1(4 +id4+in_);
	    val vt1_5 = v1(5 +id1+in_) + v1(5 +id4+in_);
	    val vt2_4 = v1(4 +id2+in_) - v1(4 +id3+in_);
	    val vt2_5 = v1(5 +id2+in_) - v1(5 +id3+in_);

	    for(ic in 0..(Ncol-1)){
	      val ic2 = ic*Nvc;
	      val wt1r = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
	      + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
	      + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
	      val wt1i = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
	      + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
	      + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;

	      val wt2r = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
	      + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
	      + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
	      val wt2i = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
	      + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
	      + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;

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
    });
    //   }
    // }
  }

  /* ****************************************************** */
  def mult_ym(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 1;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // boundary part 
    val iy = 0;
    val nn = Ny-1;
    // for(izt in 0..(Nz*Nt-1)){
    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(ix in 0..(Nx-1)){

	  val iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
	  val in_ = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
	  val ig = Ndf*(ix + nn*Nx + izt*Nx*Ny + idir*Nst);

	  val vt1_0 = v1(   id1+in_) - v1(   id4+in_);
	  val vt1_1 = v1(1 +id1+in_) - v1(1 +id4+in_);
	  val vt2_0 = v1(   id2+in_) + v1(   id3+in_);
	  val vt2_1 = v1(1 +id2+in_) + v1(1 +id3+in_);
	  val vt1_2 = v1(2 +id1+in_) - v1(2 +id4+in_);
	  val vt1_3 = v1(3 +id1+in_) - v1(3 +id4+in_);
	  val vt2_2 = v1(2 +id2+in_) + v1(2 +id3+in_);
	  val vt2_3 = v1(3 +id2+in_) + v1(3 +id3+in_);
	  val vt1_4 = v1(4 +id1+in_) - v1(4 +id4+in_);
	  val vt1_5 = v1(5 +id1+in_) - v1(5 +id4+in_);
	  val vt2_4 = v1(4 +id2+in_) + v1(4 +id3+in_);
	  val vt2_5 = v1(5 +id2+in_) + v1(5 +id3+in_);

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;
	    val ic1 = 0;
	    val ic2 = Nvc;
	    val ic3 = 2*Nvc;

	    val wt1r = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
	    + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
	    + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
	    val wt1i = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
	    + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
	    + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

	    val wt2r = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
	    + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
	    + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
	    val wt2i = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
	    + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
	    + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;

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
    });

    // bulk part 
    // for(izt in 0..(Nz*Nt-1)){
    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(iy_ in 1..(Ny-1)){
	  val nn_ = iy_ - 1;
	  for(ix in 0..(Nx-1)){

	    val iv = Nvc*ND*(ix + iy_*Nx + izt*Nx*Ny);
	    val in_ = Nvc*ND*(ix + nn_*Nx + izt*Nx*Ny);
	    val ig = Ndf*(ix + nn_*Nx + izt*Nx*Ny + idir*Nst);

	    val vt1_0 = v1(   id1+in_) - v1(   id4+in_);
	    val vt1_1 = v1(1 +id1+in_) - v1(1 +id4+in_);
	    val vt2_0 = v1(   id2+in_) + v1(   id3+in_);
	    val vt2_1 = v1(1 +id2+in_) + v1(1 +id3+in_);
	    val vt1_2 = v1(2 +id1+in_) - v1(2 +id4+in_);
	    val vt1_3 = v1(3 +id1+in_) - v1(3 +id4+in_);
	    val vt2_2 = v1(2 +id2+in_) + v1(2 +id3+in_);
	    val vt2_3 = v1(3 +id2+in_) + v1(3 +id3+in_);
	    val vt1_4 = v1(4 +id1+in_) - v1(4 +id4+in_);
	    val vt1_5 = v1(5 +id1+in_) - v1(5 +id4+in_);
	    val vt2_4 = v1(4 +id2+in_) + v1(4 +id3+in_);
	    val vt2_5 = v1(5 +id2+in_) + v1(5 +id3+in_);

	    for(ic in 0..(Ncol-1)){
	      val icr = 2*ic;
	      val ici = 2*ic+1;
	      val ic1 = 0;
	      val ic2 = Nvc;
	      val ic3 = 2*Nvc;

	      val wt1r = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
	      + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
	      + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
	      val wt1i = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
	      + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
	      + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

	      val wt2r = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
	      + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
	      + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
	      val wt2i = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
	      + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
	      + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;

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
    });


  }
  /* ****************************************************** */
  def mult_zp(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 2;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // boundary part 
    val iz = Nz-1;
    val nn = 0;

    parallel(0..(Nt-1), (r:LongRange)=> {
      for(it in r){
	for(ixy in 0..(Nx*Ny-1)){

	  val iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
	  val in_ = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
	  val ig = Ndf*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

	  val vt1_0 = v1(   id1+in_) - v1(1 +id3+in_);
	  val vt1_1 = v1(1 +id1+in_) + v1(   id3+in_);
	  val vt2_0 = v1(   id2+in_) + v1(1 +id4+in_);
	  val vt2_1 = v1(1 +id2+in_) - v1(   id4+in_);
	  val vt1_2 = v1(2 +id1+in_) - v1(3 +id3+in_);
	  val vt1_3 = v1(3 +id1+in_) + v1(2 +id3+in_);
	  val vt2_2 = v1(2 +id2+in_) + v1(3 +id4+in_);
	  val vt2_3 = v1(3 +id2+in_) - v1(2 +id4+in_);
	  val vt1_4 = v1(4 +id1+in_) - v1(5 +id3+in_);
	  val vt1_5 = v1(5 +id1+in_) + v1(4 +id3+in_);
	  val vt2_4 = v1(4 +id2+in_) + v1(5 +id4+in_);
	  val vt2_5 = v1(5 +id2+in_) - v1(4 +id4+in_);

	  for(ic in 0..(Ncol-1)){
	    val ic2 = ic*Nvc;

	    val wt1r = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
	    + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
	    + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
	    val wt1i = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
	    + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
	    + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;

	    val wt2r = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
	    + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
	    + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
	    val wt2i = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
	    + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
	    + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;

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
    });

    // bulk part 
    // for(it in 0..(Nt-1)) async {
    parallel(0..(Nt-1), (r:LongRange)=> {
      for (it in r) {
	for(iz_ in 0..(Nz-2)){
	  val nn_ = iz_ + 1;
	  for(ixy in 0..(Nx*Ny-1)){

	    val iv = Nvc*ND*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz);
	    val in_ = Nvc*ND*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz);
	    val ig = Ndf*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

	    val vt1_0 = v1(   id1+in_) - v1(1 +id3+in_);
	    val vt1_1 = v1(1 +id1+in_) + v1(   id3+in_);
	    val vt2_0 = v1(   id2+in_) + v1(1 +id4+in_);
	    val vt2_1 = v1(1 +id2+in_) - v1(   id4+in_);
	    val vt1_2 = v1(2 +id1+in_) - v1(3 +id3+in_);
	    val vt1_3 = v1(3 +id1+in_) + v1(2 +id3+in_);
	    val vt2_2 = v1(2 +id2+in_) + v1(3 +id4+in_);
	    val vt2_3 = v1(3 +id2+in_) - v1(2 +id4+in_);
	    val vt1_4 = v1(4 +id1+in_) - v1(5 +id3+in_);
	    val vt1_5 = v1(5 +id1+in_) + v1(4 +id3+in_);
	    val vt2_4 = v1(4 +id2+in_) + v1(5 +id4+in_);
	    val vt2_5 = v1(5 +id2+in_) - v1(4 +id4+in_);

	    for(ic in 0..(Ncol-1)){
	      val ic2 = ic*Nvc;

	      val wt1r = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
	      + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
	      + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
	      val wt1i = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
	      + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
	      + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;

	      val wt2r = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
	      + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
	      + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
	      val wt2i = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
	      + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
	      + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;

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
    });
  }
  /* ****************************************************** */
  def mult_zm(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 2;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // boundary part 
    val iz = 0;
    val nn = Nz-1;
    // for(it in 0..(Nt-1)){
    parallel(0..(Nt-1), (r:LongRange)=> {
      for(it in r){
    	for(ixy in 0..(Nx*Ny-1)){

    	  val iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
    	  val in_ = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
    	  val ig = Ndf*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

    	  val vt1_0 = v1(   id1+in_) + v1(1 +id3+in_);
    	  val vt1_1 = v1(1 +id1+in_) - v1(   id3+in_);
    	  val vt2_0 = v1(   id2+in_) - v1(1 +id4+in_);
    	  val vt2_1 = v1(1 +id2+in_) + v1(   id4+in_);
    	  val vt1_2 = v1(2 +id1+in_) + v1(3 +id3+in_);
    	  val vt1_3 = v1(3 +id1+in_) - v1(2 +id3+in_);
    	  val vt2_2 = v1(2 +id2+in_) - v1(3 +id4+in_);
    	  val vt2_3 = v1(3 +id2+in_) + v1(2 +id4+in_);
    	  val vt1_4 = v1(4 +id1+in_) + v1(5 +id3+in_);
    	  val vt1_5 = v1(5 +id1+in_) - v1(4 +id3+in_);
    	  val vt2_4 = v1(4 +id2+in_) - v1(5 +id4+in_);
    	  val vt2_5 = v1(5 +id2+in_) + v1(4 +id4+in_);

    	  for(ic in 0..(Ncol-1)){
    	    val icr = 2*ic;
    	    val ici = 2*ic+1;
    	    val ic1 = 0;
    	    val ic2 = Nvc;
    	    val ic3 = 2*Nvc;

    	    val wt1r = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
    	    + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
    	    + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
    	    val wt1i = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
    	    + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
    	    + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

    	    val wt2r = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
    	    + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
    	    + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
    	    val wt2i = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
    	    + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
    	    + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;

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
    });

    // bulk part 
    // for(it in 0..(Nt-1)) async {
    parallel(0..(Nt-1), (r:LongRange)=> {
      for (it in r) {
    	for(iz_ in 1..(Nz-1)){
    	  val nn_ = iz_ - 1;
    	  for(ixy in 0..(Nx*Ny-1)){

    	    val iv = Nvc*ND*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz);
    	    val in_ = Nvc*ND*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz);
    	    val ig = Ndf*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

    	    val vt1_0 = v1(   id1+in_) + v1(1 +id3+in_);
    	    val vt1_1 = v1(1 +id1+in_) - v1(   id3+in_);
    	    val vt2_0 = v1(   id2+in_) - v1(1 +id4+in_);
    	    val vt2_1 = v1(1 +id2+in_) + v1(   id4+in_);
    	    val vt1_2 = v1(2 +id1+in_) + v1(3 +id3+in_);
    	    val vt1_3 = v1(3 +id1+in_) - v1(2 +id3+in_);
    	    val vt2_2 = v1(2 +id2+in_) - v1(3 +id4+in_);
    	    val vt2_3 = v1(3 +id2+in_) + v1(2 +id4+in_);
    	    val vt1_4 = v1(4 +id1+in_) + v1(5 +id3+in_);
    	    val vt1_5 = v1(5 +id1+in_) - v1(4 +id3+in_);
    	    val vt2_4 = v1(4 +id2+in_) - v1(5 +id4+in_);
    	    val vt2_5 = v1(5 +id2+in_) + v1(4 +id4+in_);

    	    for(ic in 0..(Ncol-1)){
    	      val icr = 2*ic;
    	      val ici = 2*ic+1;
    	      val ic1 = 0;
    	      val ic2 = Nvc;
    	      val ic3 = 2*Nvc;

    	      val wt1r = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
    	      + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
    	      + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
    	      val wt1i = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
    	      + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
    	      + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

    	      val wt2r = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
    	      + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
    	      + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
    	      val wt2i = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
    	      + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
    	      + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;

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
    });
  }

  /* ****************************************************** */
  def mult_tp(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 3;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // boundary part 
    val it = Nt-1;
    val nn = 0;

    // for(ixyz in 0..(Nx*Ny*Nz-1)){
    parallel(0..(Nx*Ny*Nz-1), (r:LongRange)=> {
      for (ixyz in r) {

	val iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
	val in_ = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
	val ig = Ndf*(ixyz + it*Nx*Ny*Nz + idir*Nst);

	val vt1_0 = 2.0 * v1(    id3+in_);
	val vt1_1 = 2.0 * v1(1 + id3+in_);
	val vt2_0 = 2.0 * v1(    id4+in_);
	val vt2_1 = 2.0 * v1(1 + id4+in_);
	val vt1_2 = 2.0 * v1(2 + id3+in_);
	val vt1_3 = 2.0 * v1(3 + id3+in_);
	val vt2_2 = 2.0 * v1(2 + id4+in_);
	val vt2_3 = 2.0 * v1(3 + id4+in_);
	val vt1_4 = 2.0 * v1(4 + id3+in_);
	val vt1_5 = 2.0 * v1(5 + id3+in_);
	val vt2_4 = 2.0 * v1(4 + id4+in_);
	val vt2_5 = 2.0 * v1(5 + id4+in_);

	for(ic in 0..(Ncol-1)){
	  val ic2 = ic*Nvc;

	  val wt1r = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
	  + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
	  + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
	  val wt1i = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
	  + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
	  + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;

	  val wt2r = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
	  + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
	  + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
	  val wt2i = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
	  + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
	  + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;

	  v2(2*ic   +id3+iv) +=  wt1r;
	  v2(2*ic+1 +id3+iv) +=  wt1i;
	  v2(2*ic   +id4+iv) +=  wt2r;
	  v2(2*ic+1 +id4+iv) +=  wt2i;
	}
      }
    });

    // bulk part 
    // for(it_ in 0..(Nt-2)) async {
    parallel(0..(Nt-2), (r:LongRange)=> {

      for (it_ in r) {
	val nn_ = it_ + 1;
	for(ixyz in 0..(Nx*Ny*Nz-1)) {

	  val iv = Nvc*ND*(ixyz + it_*Nx*Ny*Nz);
	  val in_ = Nvc*ND*(ixyz + nn_*Nx*Ny*Nz);
	  val ig = Ndf*(ixyz + it_*Nx*Ny*Nz + idir*Nst);

	  val vt1_0 = 2.0 * v1(    id3+in_);
	  val vt1_1 = 2.0 * v1(1 + id3+in_);
	  val vt2_0 = 2.0 * v1(    id4+in_);
	  val vt2_1 = 2.0 * v1(1 + id4+in_);
	  val vt1_2 = 2.0 * v1(2 + id3+in_);
	  val vt1_3 = 2.0 * v1(3 + id3+in_);
	  val vt2_2 = 2.0 * v1(2 + id4+in_);
	  val vt2_3 = 2.0 * v1(3 + id4+in_);
	  val vt1_4 = 2.0 * v1(4 + id3+in_);
	  val vt1_5 = 2.0 * v1(5 + id3+in_);
	  val vt2_4 = 2.0 * v1(4 + id4+in_);
	  val vt2_5 = 2.0 * v1(5 + id4+in_);

	  for (ic in 0..(Ncol-1)) {
	    val ic2 = ic*Nvc;

	    val wt1r = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
	    + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
	    + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
	    val wt1i = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
	    + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
	    + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;

	    val wt2r = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
	    + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
	    + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
	    val wt2i = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
	    + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
	    + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;

	    v2(2*ic   +id3+iv) +=  wt1r;
	    v2(2*ic+1 +id3+iv) +=  wt1i;
	    v2(2*ic   +id4+iv) +=  wt2r;
	    v2(2*ic+1 +id4+iv) +=  wt2i;

	  }
	}
      }
    });
  }

  /* ****************************************************** */
  def mult_tm(v2:Rail[Double], u:Rail[Double], v1:Rail[Double]){

    val idir = 3;

    val id1 = 0;
    val id2 = Nvc;
    val id3 = Nvc*2;
    val id4 = Nvc*3;

    // boundary part 
    val it = 0;
    val nn = Nt-1;

    parallel(0..(Nx*Ny*Nz-1), (r:LongRange)=> {
      for(ixyz in r) {

	val iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
	val in_ = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
	val ig = Ndf*(ixyz + nn*Nx*Ny*Nz + idir*Nst);

	val vt1_0 = 2.0 * v1(    id1+in_);
	val vt1_1 = 2.0 * v1(1 + id1+in_);
	val vt2_0 = 2.0 * v1(    id2+in_);
	val vt2_1 = 2.0 * v1(1 + id2+in_);
	val vt1_2 = 2.0 * v1(2 + id1+in_);
	val vt1_3 = 2.0 * v1(3 + id1+in_);
	val vt2_2 = 2.0 * v1(2 + id2+in_);
	val vt2_3 = 2.0 * v1(3 + id2+in_);
	val vt1_4 = 2.0 * v1(4 + id1+in_);
	val vt1_5 = 2.0 * v1(5 + id1+in_);
	val vt2_4 = 2.0 * v1(4 + id2+in_);
	val vt2_5 = 2.0 * v1(5 + id2+in_);

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;
	  val ic1 = 0;
	  val ic2 = Nvc;
	  val ic3 = 2*Nvc;

	  val wt1r = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
	  + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
	  + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
	  val wt1i = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
	  + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
	  + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

	  val wt2r = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
	  + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
	  + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
	  val wt2i = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
	  + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
	  + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;

	  v2(icr +id1+iv) +=  wt1r;
	  v2(ici +id1+iv) +=  wt1i;
	  v2(icr +id2+iv) +=  wt2r;
	  v2(ici +id2+iv) +=  wt2i;
	}
      }
    });

    // bulk part 
    parallel(1..(Nt-1), (r:LongRange)=> {
      for (it_ in r) {

	val nn_ = it_ - 1;
	for(ixyz in 0..(Nx*Ny*Nz-1)){

	  val iv = Nvc*ND*(ixyz + it_*Nx*Ny*Nz);
	  val in_ = Nvc*ND*(ixyz + nn_*Nx*Ny*Nz);
	  val ig = Ndf*(ixyz + nn_*Nx*Ny*Nz + idir*Nst);

	  val vt1_0 = 2.0 * v1(    id1+in_);
	  val vt1_1 = 2.0 * v1(1 + id1+in_);
	  val vt2_0 = 2.0 * v1(    id2+in_);
	  val vt2_1 = 2.0 * v1(1 + id2+in_);
	  val vt1_2 = 2.0 * v1(2 + id1+in_);
	  val vt1_3 = 2.0 * v1(3 + id1+in_);
	  val vt2_2 = 2.0 * v1(2 + id2+in_);
	  val vt2_3 = 2.0 * v1(3 + id2+in_);
	  val vt1_4 = 2.0 * v1(4 + id1+in_);
	  val vt1_5 = 2.0 * v1(5 + id1+in_);
	  val vt2_4 = 2.0 * v1(4 + id2+in_);
	  val vt2_5 = 2.0 * v1(5 + id2+in_);

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;
	    val ic1 = 0;
	    val ic2 = Nvc;
	    val ic3 = 2*Nvc;

	    val wt1r = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
	    + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
	    + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
	    val wt1i = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
	    + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
	    + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

	    val wt2r = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
	    + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
	    + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
	    val wt2i = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
	    + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
	    + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;

	    v2(icr +id1+iv) +=  wt1r;
	    v2(ici +id1+iv) +=  wt1i;
	    v2(icr +id2+iv) +=  wt2r;
	    v2(ici +id2+iv) +=  wt2i;
	  }
	}
      }
    });
  }

  /* ****************************************************** */
  static @Inline def mult_p(wt1r:Cell[Double], wt1i:Cell[Double], 
			    wt2r:Cell[Double], wt2i:Cell[Double], u:Rail[Double], 
			    vt1_0:Double, vt1_1:Double, vt1_2:Double, 
			    vt1_3:Double, vt1_4:Double, vt1_5:Double, 
			    vt2_0:Double, vt2_1:Double, vt2_2:Double, 
			    vt2_3:Double, vt2_4:Double, vt2_5:Double, 
			    ic:Long, ig:Long) { 	

    val ic2 = ic*Nvc;

    wt1r() = u(0+ic2+ig)*vt1_0 - u(1+ic2+ig)*vt1_1
    + u(2+ic2+ig)*vt1_2 - u(3+ic2+ig)*vt1_3
    + u(4+ic2+ig)*vt1_4 - u(5+ic2+ig)*vt1_5;
    wt1i() = u(0+ic2+ig)*vt1_1 + u(1+ic2+ig)*vt1_0
    + u(2+ic2+ig)*vt1_3 + u(3+ic2+ig)*vt1_2
    + u(4+ic2+ig)*vt1_5 + u(5+ic2+ig)*vt1_4;
    
    wt2r() = u(0+ic2+ig)*vt2_0 - u(1+ic2+ig)*vt2_1
    + u(2+ic2+ig)*vt2_2 - u(3+ic2+ig)*vt2_3
    + u(4+ic2+ig)*vt2_4 - u(5+ic2+ig)*vt2_5;
    wt2i() = u(0+ic2+ig)*vt2_1 + u(1+ic2+ig)*vt2_0
    + u(2+ic2+ig)*vt2_3 + u(3+ic2+ig)*vt2_2
    + u(4+ic2+ig)*vt2_5 + u(5+ic2+ig)*vt2_4;
  }

  /* ****************************************************** */
  static @Inline def mult_m(wt1r:Cell[Double], wt1i:Cell[Double], 
			    wt2r:Cell[Double], wt2i:Cell[Double], u:Rail[Double], 
			    vt1_0:Double, vt1_1:Double, vt1_2:Double, 
			    vt1_3:Double, vt1_4:Double, vt1_5:Double, 
			    vt2_0:Double, vt2_1:Double, vt2_2:Double, 
			    vt2_3:Double, vt2_4:Double, vt2_5:Double, 
			    icr:Long, ici:Long, ig:Long) {
    val ic1 = 0;
    val ic2 = Nvc;
    val ic3 = 2*Nvc;

    wt1r() = u(icr+ic1+ig)*vt1_0 + u(ici+ic1+ig)*vt1_1
    + u(icr+ic2+ig)*vt1_2 + u(ici+ic2+ig)*vt1_3
    + u(icr+ic3+ig)*vt1_4 + u(ici+ic3+ig)*vt1_5;
    wt1i() = u(icr+ic1+ig)*vt1_1 - u(ici+ic1+ig)*vt1_0
    + u(icr+ic2+ig)*vt1_3 - u(ici+ic2+ig)*vt1_2
    + u(icr+ic3+ig)*vt1_5 - u(ici+ic3+ig)*vt1_4;

    wt2r() = u(icr+ic1+ig)*vt2_0 + u(ici+ic1+ig)*vt2_1
    + u(icr+ic2+ig)*vt2_2 + u(ici+ic2+ig)*vt2_3
    + u(icr+ic3+ig)*vt2_4 + u(ici+ic3+ig)*vt2_5;
    wt2i() = u(icr+ic1+ig)*vt2_1 - u(ici+ic1+ig)*vt2_0
    + u(icr+ic2+ig)*vt2_3 - u(ici+ic2+ig)*vt2_2
    + u(icr+ic3+ig)*vt2_5 - u(ici+ic3+ig)*vt2_4;
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
    	    // qcd_init_random_conf(u, Nx, Ny, Nz, Nt, 0, 0, 0, 0, 1, 1, 1, 1);
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
    
    parallel(0..(nv-1), (r:LongRange)=> {
      for (i in r) {
	v(i) = a;
      }
    });

  }
  
  /* ****************************************************** */
  def vecprd(nv:Long, v1:Rail[Double], v2:Rail[Double]){

    return reduce(0..(nv-1), (i:Long, r:Double)=>(r + v1(i)*v2(i)), (x:Double, y:Double)=>(x+y));

  }
  
  /* ****************************************************** */
  def normv(nv:Long, v:Rail[Double], offset:Long){

    return reduce(offset..(offset+nv-1), (i:Long, r:Double)=>(r + v(i)*v(i)), 
  		  (x:Double, y:Double)=>(x+y));

  }
  
  def normv(nv:Long, v:Rail[Double]){

    return normv(nv, v, 0);

  }

  /* ****************************************************** */
  def selfadd(nv:Long, v:Rail[Double], w:Rail[Double], a:Double){

    parallel(0..(nv-1), (r:LongRange)=> {
      for (i in r) {
    	v(i) = v(i) + a * w(i);
      }
    });
    
  }
  /* ****************************************************** */
  def selfsprd(nv:Long, v:Rail[Double], a:Double){

    parallel(0..(nv-1), (r:LongRange)=> {
      for(i in r) {
	v(i) = a * v(i);
      }
    });

  }
  /* ****************************************************** */
  def spx(nv:Long, v:Rail[Double], w:Rail[Double], a:Double){

    parallel(0..(nv-1), (r:LongRange)=> {
      for(i in r){
	v(i) = a * v(i) + w(i);
      }
    });

  }
  /* ****************************************************** */
  def equate(nv:Long, v:Rail[Double],  w:Rail[Double]){

    parallel(0..(nv-1), (r:LongRange)=> {
      for(i in r){
	v(i) = w(i);
      }
    });

  }
  /* ****************************************************** */

  // for debug
  def write_vector(v:Rail[Double], len:Long){
    val file = new File("x10_vector");

    if(file.exists()){
      val p = file.printer();

      for (i in 0..(len-1)) {
	p.println(v(i));
      }
      p.flush();

    } else {
      Console.OUT.println("file does not exist.");
    }
  }

  
  static def myrand(myrand_next:Cell[ULong]){
    myrand_next() = myrand_next() * 1103515245U + 12345U;
    return (myrand_next()/65536U) % 32768U;
  }
  
  static def mysrand(myrand_next:Cell[ULong], seed:ULong){
    myrand_next() = seed;
  }
  
  // for generating input data
  def qcd_init_random_conf(pU:Rail[Double], pLx:Long, pLy:Long, pLz:Long, pLt:Long, 
			   pIx:Long, pIy:Long, pIz:Long, pIt:Long, pNpx:Long, pNpy:Long, pNpz:Long, pNpt:Long){
    val myrand_next = new Cell[ULong](0U);
    var dt:Double;
    
    val sx = (pIx * pLx) / pNpx;
    val ex = ((pIx + 1) * pLx) / pNpx;
    val sy = (pIy * pLy) / pNpy;
    val ey = ((pIy + 1) * pLy) / pNpy;
    val sz = (pIz * pLz) / pNpz;
    val ez = ((pIz + 1) * pLz) / pNpz;
    val st = (pIt * pLt) / pNpt;
    val et = ((pIt + 1) * pLt) / pNpt;
    
    mysrand(myrand_next, 100U);
    
    var d:ULong = 0U;
    var is:Long = 0;
    for(i in 0..3){
      for(t in 0..(pLt-1)){
	for(z in 0..(pLz-1)){
	  for(y in 0..(pLy-1)){
	    for(x in 0..(pLx-1)){
	      if((x >= sx && x < ex) && (y >= sy && y < ey) && (z >= sz && z < ez) && (t >= st && t < et)){
		for(j in 0..8){
		  dt = 2.0*myrand(myrand_next)/MYRAND_MAX;
		  pU(is) = dt - 1.0;
		  is++;
		  dt = 2.0*myrand(myrand_next)/MYRAND_MAX;
		  pU(is) = dt - 1.0;
		  is++;
		}
	      }
	      else{
		for(j in 0..8){
		  d += myrand(myrand_next);
		  d += myrand(myrand_next);
		}
	      }
	    }
	  }
	}
      }
    }
    
    mysrand(myrand_next, d);
  }

  static def parallel(range:LongRange, func:(LongRange)=>void) {

    val size = range.max - range.min + 1;
    if (size == 0) return;
    val nthreads = Math.min(Runtime.NTHREADS as Long, size);
    val chunk_size = Math.max((size + nthreads - 1) / nthreads, 1L);
    @Pragma(Pragma.FINISH_LOCAL) finish for (i in 0..(nthreads-1)) {
      val i_start = range.min + i*chunk_size;
      if (i_start > range.max) break;
      val i_range = i_start..Math.min(range.max, i_start + chunk_size - 1);
      async func(i_range);
    }

  }

  static def reduce[U](range:LongRange, func:(Long, U)=>U, op:(U,U)=>U) {U haszero}:U {

    val size = range.max - range.min + 1;
    val nthreads = Math.min(Runtime.NTHREADS as Long, size);
    val chunk_size = Math.max((size + nthreads - 1) / nthreads, 1L);

    var r:U = Zero.get[U]();
    @Pragma(Pragma.FINISH_LOCAL) finish for (i in 0..(nthreads-1)) {
      val idx = i;
      val i_start = range.min + i*chunk_size;
      val i_range = i_start..Math.min(range.max, i_start + chunk_size - 1);
      async {
	var intermid:U = Zero.get[U]();
	for (ii in i_range) intermid = func(ii, intermid);
	atomic r = op(r, intermid);
      }
    }
    return r;
  }

}
