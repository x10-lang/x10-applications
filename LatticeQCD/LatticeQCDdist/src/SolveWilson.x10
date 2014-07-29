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
  static val places = Place.places();
  static val Np = Place.numPlaces();
  
  // static val Lszx = 4;
  // static val Lszy = 4;
  // static val Lszz = 4;
  // static val Ltime = 8;
  static val Lszx = 8;
  static val Lszy = 8;
  static val Lszz = 8;
  static val Ltime = 16;
  // static val Lszx = 16;
  // static val Lszy = 16;
  // static val Lszz = 16;
  // static val Ltime = 32;
  // static val Lszx = 32;
  // static val Lszy = 32;
  // static val Lszz = 32;
  // static val Ltime = 64;
  static val Lx = Lszx;
  static val Ly = Lszy;
  static val Lz = Lszz;
  static val Lt = Ltime;
  static val Lst = Lx*Ly*Lz*Lt;
  static val Lcol = 3;
  static val Lvc = Lcol*2;
  static val Ldf = Lcol*Lcol*2;
  static val Lcp = Lcol*Lcol;
  static val LD = 4;
  static val LD2 = 2;
  static val Lvst = Lvc*LD*Lst;
  
  static val Npx = Math.pow2((    Math.log2(Np)) / LD);
  static val Npy = Math.pow2((1 + Math.log2(Np)) / LD);
  static val Npz = Math.pow2((2 + Math.log2(Np)) / LD);
  static val Npt = Math.pow2((3 + Math.log2(Np)) / LD);

  static val Nszx = Lszx / Npx;
  static val Nszy = Lszy / Npy;
  static val Nszz = Lszz / Npz;
  static val Ntime = Ltime / Npt;
  static val Nx = Nszx;
  static val Ny = Nszy;
  static val Nz = Nszz;
  static val Nt = Ntime;
  static val Nst = Nx*Ny*Nz*Nt;
  static val Ncol = 3;
  static val Nvc = Ncol*2;
  static val Ndf = Ncol*Ncol*2;
  static val Ncp = Ncol*Ncol;
  static val ND = 4;
  static val ND2 = 2;
  static val Nvst = Nvc*ND*Nst;
  
  static val id1 = 0;
  static val id2 = Nvc;
  static val id3 = Nvc*2;
  static val id4 = Nvc*3;

  static val Ix = here.id % Npx;
  static val Iy = (here.id / Npx) % Npy;
  static val Iz = (here.id / (Npx * Npy)) % Npz;
  static val It = (here.id / (Npx * Npy * Npz)) % Npt;

  static val Sx = (Ix * Lx) / Npx;
  static val Ex = ((Ix + 1) * Lx) / Npx;
  static val Sy = (Iy * Ly) / Npy;
  static val Ey = ((Iy + 1) * Ly) / Npy;
  static val Sz = (Iz * Lz) / Npz;
  static val Ez = ((Iz + 1) * Lz) / Npz;
  static val St = (It * Lt) / Npt;
  static val Et = ((It + 1) * Lt) / Npt;

  static val Ixp = (Sx == 0) ? here.id - 1 + Npx : here.id - 1;
  static val Iyp = (Sy == 0) ? here.id - Npx + (Npx * Npy) : here.id - Npx;
  static val Izp = (Sz == 0) ? here.id - (Npx * Npy) + (Npx * Npy * Npz) 
			     : here.id - (Npx * Npy);
  static val Itp = (St == 0) ? here.id - (Npx * Npy * Npz) + (Npx * Npy * Npz * Npt)
			     : here.id - (Npx * Npy * Npz);

  static val Ixm = (Ex == Lx) ? here.id + 1 - Npx : here.id + 1;
  static val Iym = (Ey == Ly) ? here.id + Npx - (Npx * Npy) : here.id + Npx;
  static val Izm = (Ez == Lz) ? here.id + (Npx * Npy) - (Npx * Npy * Npz) 
			      : here.id + (Npx * Npy);
  static val Itm = (Et == Lt) ? here.id + (Npx * Npy * Npz) - (Npx * Npy * Npz * Npt)
			      : here.id + (Npx * Npy * Npz);  

  static val CKs = 0.150;	

  // generate input values
  static val MYRAND_MAX = 32767;

  // N.B. moved from solve_CG
  val x = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvst));
  val s = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvst));
  val r = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvst));
  val p = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvst));
  val v = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvst));

  // N.B. moved from opr_DdagD
  val v2 = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvst));

  // for boundary exchange
  val vcp1_xp = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Ny * Nz * Nt));
  val vcp1_xm = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Ny * Nz * Nt));
  val vcp1_yp = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Nz * Nt));
  val vcp1_ym = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Nz * Nt));
  val vcp1_zp = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Ny * Nt));
  val vcp1_zm = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Ny * Nt));
  val vcp1_tp = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Ny * Nz));
  val vcp1_tm = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Ny * Nz));

  val vcp2_xp = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Ny * Nz * Nt));
  val vcp2_xm = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Ny * Nz * Nt));
  val vcp2_yp = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Nz * Nt));
  val vcp2_ym = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Nz * Nt));
  val vcp2_zp = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Ny * Nt));
  val vcp2_zm = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Ny * Nt));
  val vcp2_tp = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Ny * Nz));
  val vcp2_tm = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvc * 2 * Nx * Ny * Nz));

  // timers
  var mult_meanTime:Long = 0;
  var mult_x_meanTime:Long = 0;
  var mult_y_meanTime:Long = 0;
  var mult_z_meanTime:Long = 0;
  var mult_t_meanTime:Long = 0;

  var send_x_meanTime:Long = 0;
  var send_y_meanTime:Long = 0;
  var send_z_meanTime:Long = 0;
  var send_t_meanTime:Long = 0;

  /**
   * The main method for the SolveWilson class
   */
  public static def main(Rail[String]) {
    
    Console.OUT.println("X10_NTHREADS: " + Runtime.NTHREADS);
    Console.OUT.println("X10_NPLACES: " + Place.numPlaces());

    Console.OUT.println("Npx: " + Npx + ", Npy: " + Npy + ", Npz: " + Npz 
    			+ ", Npt: " + Npt);

    // for (p in Place.places()) at(p) {
    //   Console.OUT.println(here.id + ": (Ix, Iy, Iz, It): (" + Ix + ", " + Iy 
    // 			  + ", " + Iz + ", " + It + ")");
    // }

    // for (p in Place.places()) at(p) {
    //   Console.OUT.println(here.id + ": (Ixp, Iyp, Izp, Itp): (" + Ixp + ", " + Iyp 
    // 			  + ", " + Izp + ", " + Itp + ")");
    // }

    // for (p in Place.places()) at(p) {
    //   Console.OUT.println(here.id + ": (Ixm, Iym, Izm, Itm): (" + Ixm + ", " + Iym 
    // 			  + ", " + Izm + ", " + Itm + ")");
    // }

    // for (p in Place.places()) at(p) {
    //   Console.OUT.println(here.id + ": [" + Sx + ", " + Ex + "], [" + Sy + ", " + Ey + "], ["
    // 			  + Sz + ", " + Ez + "], [" + St + ", " + Et + "]");
    // }

    val nc2 = Ncol;
    
    Console.OUT.println("Simple Wilson solver\n");
    
    Console.OUT.printf("Lx = %3d, Ly = %3d, Lz = %3d, Lt = %3d\n",
                                       Lx, Ly, Lz, Lt);
    Console.OUT.printf("Nx = %3d, Ny = %3d, Nz = %3d, Nt = %3d\n",
                                       Nx, Ny, Nz, Nt);
    Console.OUT.printf("CKs = %10.6f\n", CKs);
    
    val enorm = 1.E-16;
    Console.OUT.printf("enorm = %12.4e\n", enorm);
    
    val nconv = new Cell[Long](0);
    val diff = new Cell[Double](0);
    
    val corr = GlobalRef[Rail[Double]](new Rail[Double](Lt,0));

    val xq = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvst));
    val bq = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Nvst));
    // spinor field
    
    val u = PlaceLocalHandle.make[Rail[Double]](places, ()=>new Rail[Double](Ndf*Nst*4));
    // link variable
    
    val istart = 3;
    
    //TODO: constructor
    val qcd = new SolveWilson();
    
    try {
      
      // qcd.uinit(istart, u, "../conf_08080816.txt");
      qcd.uinit(istart, u, "");
      
      val Nvt = Nvc*ND*Nx*Ny*Nz;
      
      Console.OUT.println("  ic  id   nconv      diff");;
      
      var meanTime:Long = 0;
      
      var send_meanTime:Long = 0;

      
      for(ic in 0..(Ncol-1)) {
      	for(id in 0..(ND-1)) {
      // for (ic in 0..0) {
      // 	for (id in 0..0) {
	  
      	  qcd.set_src(ic,id,0,0,0,0,bq);

      	  val startTime = System.currentTimeMillis();
      	  send_meanTime += qcd.solve_CG(enorm,nconv,diff,xq,u,bq);
          val cgTime = System.currentTimeMillis() - startTime;
          Console.OUT.printf("cg: %f sec.\n", cgTime/1000.0);
	      meanTime += cgTime;

	      Console.OUT.printf(" %3d %3d  %6d %12.4e\n", ic, id, nconv(), diff());
	  
      	  for (p in places) at(p) {

      	    for(it in 0..(Lt-1)){
      	      if (it >= St && it < Et) {
      	  	val corrF:Double;
      	  	val int = it - St;

      	  	corrF = qcd.normv(Nvt,xq(),Nvt*int); 

      	  	at(corr.home) {
      	  	  corr()(it) += corrF;
      	  	}

      	      }
      	    }
      	  }
      	}
      }
      
      Console.OUT.println("Ps meson correlator:");

      at (corr.home) {
      	for(it in 0..(Lt-1)){
          Console.OUT.printf(" %6d   %16.8e\n", it, corr()(it));
      	}
      }
      
      //timer
      meanTime /= Ncol * ND;
      // Console.OUT.println("SolveWilson: " + meanTime + " ms");

      send_meanTime /= Ncol * ND;
      // Console.OUT.println("send: " + send_meanTime + " ms");
      

    } catch (e:FileNotFoundException) {
      Console.OUT.println("file not found.");
    }
    
  }
  
  /* ****************************************************** */
  def solve_CG(enorm:Double, nconv:Cell[Long], diff:Cell[Double],
	       xq:PlaceLocalHandle[Rail[Double]], u:PlaceLocalHandle[Rail[Double]], 
	       b:PlaceLocalHandle[Rail[Double]]){
    
    val niter = 1000;
    // val niter = 1;

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
      
      //debug
      // Console.OUT.println("iter: " + iter);

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
    // Console.OUT.println("mult_x: " + mult_x_meanTime);
    // Console.OUT.println("mult_y: " + mult_y_meanTime);
    // Console.OUT.println("mult_z: " + mult_z_meanTime);
    // Console.OUT.println("mult_t: " + mult_t_meanTime);
    // Console.OUT.println("send_x: " + send_x_meanTime);
    // Console.OUT.println("send_y: " + send_y_meanTime);
    // Console.OUT.println("send_z: " + send_z_meanTime);
    // Console.OUT.println("send_t: " + send_t_meanTime);

    val send_time = send_x_meanTime + send_y_meanTime 
    + send_z_meanTime + send_t_meanTime;

    mult_meanTime = 0;
    mult_x_meanTime = 0;
    mult_y_meanTime = 0;
    mult_z_meanTime = 0;
    mult_t_meanTime = 0;
    send_x_meanTime = 0;
    send_y_meanTime = 0;
    send_z_meanTime = 0;
    send_t_meanTime = 0;

    //debug
    return send_time;

  }
  /* ****************************************************** */
  def solve_CG_init(rrp:Cell[Double], rr:Cell[Double], u:PlaceLocalHandle[Rail[Double]], 
		    x:PlaceLocalHandle[Rail[Double]], r:PlaceLocalHandle[Rail[Double]], 
		    s:PlaceLocalHandle[Rail[Double]], p:PlaceLocalHandle[Rail[Double]], 
		    v:PlaceLocalHandle[Rail[Double]]){

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
		    u:PlaceLocalHandle[Rail[Double]], x:PlaceLocalHandle[Rail[Double]], 
		    r:PlaceLocalHandle[Rail[Double]], s:PlaceLocalHandle[Rail[Double]],
		    p:PlaceLocalHandle[Rail[Double]], v:PlaceLocalHandle[Rail[Double]]){
    
    opr_DdagD(v,u,p);

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
  def opr_DdagD(v:PlaceLocalHandle[Rail[Double]], u:PlaceLocalHandle[Rail[Double]], 
		w:PlaceLocalHandle[Rail[Double]]){

    opr_H(v2,u,w );
    opr_H(v ,u,v2);

  }
  /* ****************************************************** */
  // def opr_D(v:Rail[Double], u:Rail[Double], w:Rail[Double]){

  //   setconst(Nvst, v, 0.0);

  //   mult_xp(v,u,w);
  //   mult_xm(v,u,w);
  //   mult_yp(v,u,w);
  //   mult_ym(v,u,w);
  //   mult_zp(v,u,w);
  //   mult_zm(v,u,w);
  //   mult_tp(v,u,w);
  //   mult_tm(v,u,w);

  //   spx(Nvst,v,w,-CKs);

  // }
  /* ****************************************************** */
  def opr_H(v:PlaceLocalHandle[Rail[Double]], u:PlaceLocalHandle[Rail[Double]], 
	    w:PlaceLocalHandle[Rail[Double]]){

    setconst(Nvst, v, 0.0);

    // timers
    val mult_startTime = System.currentTimeMillis();

    finish for (p in places) at(p) async {

      // make and send boundary data
      make_tp_bnd(vcp1_tp, w);
      send(vcp1_tp, vcp2_tp, Itp, 0..(Nvc*2*Nx*Ny*Nz-1));
      make_tm_bnd(vcp1_tm, u, w);
      send(vcp1_tm, vcp2_tm, Itm, 0..(Nvc*2*Nx*Ny*Nz-1));
      make_xp_bnd(vcp1_xp, w);
      send(vcp1_xp, vcp2_xp, Ixp, 0..(Nvc*2*Ny*Nz*Nt-1));
      make_xm_bnd(vcp1_xm, u, w);
      send(vcp1_xm, vcp2_xm, Ixm, 0..(Nvc*2*Ny*Nz*Nt-1));
      make_yp_bnd(vcp1_yp, w);
      send(vcp1_yp, vcp2_yp, Iyp, 0..(Nvc*2*Nx*Nz*Nt-1));
      make_ym_bnd(vcp1_ym, u, w);
      send(vcp1_ym, vcp2_ym, Iym, 0..(Nvc*2*Nx*Nz*Nt-1));
      make_zp_bnd(vcp1_zp, w);
      send(vcp1_zp, vcp2_zp, Izp, 0..(Nvc*2*Nx*Ny*Nt-1));
      make_zm_bnd(vcp1_zm, u, w);
      send(vcp1_zm, vcp2_zm, Izm, 0..(Nvc*2*Nx*Ny*Nt-1));

      // calculate bulk part in local 
      mult_tp_bulk(v, u, w);
      mult_tm_bulk(v, u, w);
      mult_xp_bulk(v, u, w);
      mult_xm_bulk(v, u, w);
      mult_yp_bulk(v, u, w);
      mult_ym_bulk(v, u, w);
      mult_zp_bulk(v, u, w);
      mult_zm_bulk(v, u, w);

    }

    finish for (p in places) at(p) async {

      // set boundary part
      set_tp_bnd(vcp2_tp, u, v);
      set_tm_bnd(vcp2_tm, v);
      set_xp_bnd(vcp2_xp, u, v);
      set_xm_bnd(vcp2_xm, v);
      set_yp_bnd(vcp2_yp, u, v);
      set_ym_bnd(vcp2_ym, v);
      set_zp_bnd(vcp2_zp, u, v);
      set_zm_bnd(vcp2_zm, v);
    }

    mult_meanTime += System.currentTimeMillis() - mult_startTime;

    finish for (p in places) at(p) async {
      parallel(0..(Nst-1), (r:LongRange)=> {
	for(ist in r){
	  val iv = ist*Nvc*ND;
	  for(ivc in 0..(Nvc-1)){
	    val v3 = v()(ivc+id3+iv);
	    val v4 = v()(ivc+id4+iv);
	    v()(ivc+id3+iv) = w()(ivc+id1+iv) - CKs * v()(ivc+id1+iv);
	    v()(ivc+id4+iv) = w()(ivc+id2+iv) - CKs * v()(ivc+id2+iv);
	    v()(ivc+id1+iv) = w()(ivc+id3+iv) - CKs * v3;
	    v()(ivc+id2+iv) = w()(ivc+id4+iv) - CKs * v4;
	  }
	}
      });
    }

  }
  /* ****************************************************** */
  static @Inline def mult_uv_r(u:Rail[Double], v:Rail[Double], ic2:Long, ig:Long, ix:Long) {
    val u_0 = u(ic2 + ig   );
    val u_1 = u(ic2 + ig + 1);
    val u_2 = u(ic2 + ig + 2);
    val u_3 = u(ic2 + ig + 3);
    val u_4 = u(ic2 + ig + 4);
    val u_5 = u(ic2 + ig + 5);
    val v_0 = v(ix    );
    val v_1 = v(ix + 1);
    val v_2 = v(ix + 2);
    val v_3 = v(ix + 3);
    val v_4 = v(ix + 4);
    val v_5 = v(ix + 5);

    return u_0 * v_0 - u_1 * v_1
         + u_2 * v_2 - u_3 * v_3
         + u_4 * v_4 - u_5 * v_5;
  }

  static @Inline def mult_uv_i(u:Rail[Double], v:Rail[Double], ic2:Long, ig:Long, ix:Long) {
    val u_0 = u(ic2 + ig   );
    val u_1 = u(ic2 + ig + 1);
    val u_2 = u(ic2 + ig + 2);
    val u_3 = u(ic2 + ig + 3);
    val u_4 = u(ic2 + ig + 4);
    val u_5 = u(ic2 + ig + 5);
    val v_0 = v(ix    );
    val v_1 = v(ix + 1);
    val v_2 = v(ix + 2);
    val v_3 = v(ix + 3);
    val v_4 = v(ix + 4);
    val v_5 = v(ix + 5);

    return u_0 * v_1 + u_1 * v_0
         + u_2 * v_3 + u_3 * v_2
         + u_4 * v_5 + u_5 * v_4;
  }
  
  /* ****************************************************** */
  def set_src(ic:Long, id:Long,
	      ix:Long, iy:Long, iz:Long, it:Long, v:PlaceLocalHandle[Rail[Double]]) { 

    setconst(Nvst, v, 0.0);

    for (p in places) at(p) {

      if((ix >= Sx && ix < Ex) && (iy >= Sy && iy < Ey) &&
	 (iz >= Sz && iz < Ez) && (it >= St && it < Et)) {
	   
	   val ixp = ix - Sx;
	   val iyp = iy - Sy;
	   val izp = iz - Sz;
	   val itp = it - St;

	   val i = 2*ic + id*Nvc + Nvc*ND*(ixp + iyp*Nszx
	 				   + izp*Nszx*Nszy + itp*Nszx*Nszy*Nszz);
	   v()(i)=1.0;

	   //debug
	   // Console.OUT.println("set src at " + here.id + ": v(" + i + "): " + v()(i));
	 }
    }
  }
  
  /* ****************************************************** */
  // def uinit(istart:Long, u:Rail[Double], fileName:String) throws FileNotFoundException { 
  def uinit(istart:Long, u:PlaceLocalHandle[Rail[Double]], fileName:String)
  throws FileNotFoundException { 
    
    if(istart > 2){  // read from file
      
      // val file = new File(fileName);
      // val reader = file.openRead();				
      // for (ist in 0..(Nst-1)) {
      // 	for (idir in 0..3) {
      // 	  for(idf in 0..(Ndf-1)){
      // 	    val i = idf + ist*Ndf + idir*Ndf*Nst;
      // 	    u(i) = Double.parseDouble(reader.readLine().trim());
      // 	  }
      // 	}
      // }
      // reader.close();
      
      // qcd_init_random_conf(u, Nx, Ny, Nz, Nt, 0, 0, 0, 0, 1, 1, 1, 1);
      
      //debug
      // Console.OUT.println("qcd_init_random_conf");
      for (p in places) at(p) {
	qcd_init_random_conf(u, Lx, Ly, Lz, Lt, Ix, Iy, Iz, It, Npx, Npy, Npz, Npt);
      }

    }else{  // free field

      // TODO: compatiblility with PLH
      // setunit(Nst*4,u);

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
  def setconst(nv:Long, v:PlaceLocalHandle[Rail[Double]], a:Double){
    
    finish for (p in places) at(p) async {
      parallel(0..(nv-1), (r:LongRange)=> {
	for (i in r) {
	  v()(i) = a;
	}
      });
    }
  }

  /* ****************************************************** */
  def vecprd(nv:Long, v1:PlaceLocalHandle[Rail[Double]], v2:PlaceLocalHandle[Rail[Double]]){

    val sum = finish(Reducible.SumReducer[Double]()) {
      for (p in places) at(p) async {
	val localSum = reduce(0..(nv-1), 
			      (i:Long, r:Double)=>(r + v1()(i)*v2()(i)), 
			      (x:Double, y:Double)=>(x+y));
	offer localSum;
      }
    };
    return sum;

  }
  /* ****************************************************** */
  //debug
  def normv(nv:Long, v:GlobalRail[Double], offset:Long){

    return reduce(offset..(offset+nv-1), (i:Long, r:Double)=>(r + v(i)*v(i)), 
  		  (x:Double, y:Double)=>(x+y));

  }
  
  def normv(nv:Long, v:GlobalRail[Double]){

    return normv(nv, v, 0);

  }

  // for single place
  def normv(nv:Long, v:Rail[Double], offset:Long){

    return reduce(offset..(offset+nv-1), (i:Long, r:Double)=>(r + v(i)*v(i)), 
  		  (x:Double, y:Double)=>(x+y));

  }
  
  // for single place
  def normv(nv:Long, v:Rail[Double]){

    return normv(nv, v, 0);

  }

  // for multi-place
  def normv(nv:Long, v:PlaceLocalHandle[Rail[Double]], offset:Long){
    
    val sum = finish(Reducible.SumReducer[Double]()) {
      for (p in places) at(p) async {
	val localSum = reduce(offset..(offset+nv-1), 
			      (i:Long, r:Double)=>(r + v()(i)*v()(i)), 
  			      (x:Double, y:Double)=>(x+y));
	offer localSum;
      }
    };
    return sum;

  }

  // for multi-place
  def normv(nv:Long, v:PlaceLocalHandle[Rail[Double]]){

    return normv(nv, v, 0);

  }
  /* ****************************************************** */
  def selfadd(nv:Long, v:PlaceLocalHandle[Rail[Double]], 
	      w:PlaceLocalHandle[Rail[Double]], a:Double){

    finish for (p in places) at(p) async {
      parallel(0..(nv-1), (r:LongRange)=> {
	for (i in r) {
    	  v()(i) = v()(i) + a * w()(i);
	}
      });
    }
    
  }
  /* ****************************************************** */
  def selfsprd(nv:Long, v:PlaceLocalHandle[Rail[Double]], a:Double){

    finish for (p in places) at(p) async {
      parallel(0..(nv-1), (r:LongRange)=> {
	for(i in r) {
	  v()(i) = a * v()(i);
	}
      });
    }

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
  def equate(nv:Long, v:PlaceLocalHandle[Rail[Double]],  
	     w:PlaceLocalHandle[Rail[Double]]){

    finish for (p in places) at(p) async {
      parallel(0..(nv-1), (r:LongRange)=> {
	for(i in r){
	  v()(i) = w()(i);
	}
      });
    }

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
  def qcd_init_random_conf(pU:PlaceLocalHandle[Rail[Double]], 
			   pLx:Long, pLy:Long, pLz:Long, pLt:Long, 
			   pIx:Long, pIy:Long, pIz:Long, pIt:Long, 
			   pNpx:Long, pNpy:Long, pNpz:Long, pNpt:Long){

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
		  pU()(is) = dt - 1.0;
		  is++;
		  dt = 2.0*myrand(myrand_next)/MYRAND_MAX;
		  pU()(is) = dt - 1.0;
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

  // parallelize threads in a place
  static def parallel(range:LongRange, func:(LongRange)=>void) {

    val size = range.max - range.min + 1;
    if (size == 0) return;
    val nthreads = Math.min(Runtime.NTHREADS as Long, size);
    val chunk_size = Math.max((size + nthreads - 1) / nthreads, 1L);

    @Pragma(Pragma.FINISH_LOCAL) finish {
      for (i in 0..(nthreads-2)) {
    	val i_start = range.min + i*chunk_size;
    	if (i_start > range.max) break;
    	val i_range = i_start..Math.min(range.max, i_start + chunk_size - 1);
    	async func(i_range);
      }
      val i_start = range.min + (nthreads-1)*chunk_size;
      if (i_start > range.max) return;
      val i_range = i_start..Math.min(range.max, i_start + chunk_size - 1);
      func(i_range);
    }
  }

  // parallelize threads in a place
  static def reduce[U](range:LongRange, func:(Long, U)=>U, op:(U,U)=>U) {U haszero}:U {

    val size = range.max - range.min + 1;
    val nthreads = Math.min(Runtime.NTHREADS as Long, size);
    val chunk_size = Math.max((size + nthreads - 1) / nthreads, 1L);

    var r:U = Zero.get[U]();

    @Pragma(Pragma.FINISH_LOCAL) finish {
      for (i in 0..(nthreads-2)) {
    	val i_start = range.min + i*chunk_size;
    	val i_range = i_start..Math.min(range.max, i_start + chunk_size - 1);
    	async {
    	  var intermid:U = Zero.get[U]();
    	  for (ii in i_range) intermid = func(ii, intermid);
    	  atomic r = op(r, intermid);
    	}
      }
      val i_start = range.min + (nthreads-1)*chunk_size;
      val i_range = i_start..Math.min(range.max, i_start + chunk_size - 1);
      var intermid:U = Zero.get[U]();
      for (ii in i_range) intermid = func(ii, intermid);
      atomic r = op(r, intermid);
      
    }
    return r;
  }

  static def send(vcp1:PlaceLocalHandle[Rail[Double]], 
		      vcp2:PlaceLocalHandle[Rail[Double]],
		      dst:Long,	range:LongRange) {

    // val vcp_local = vcp1();
    val gref_vcp1 = GlobalRail(vcp1());
    at(Place(dst)) async {
      // for (i in range) {
      // 	vcp2()(i) = vcp_local(i);
      // } 
      Rail.asyncCopy[Double](gref_vcp1, range.min, vcp2(), range.min, 
      			     range.max + 1);
    }

  }

  static def make_xp_bnd(vcp1_xp:PlaceLocalHandle[Rail[Double]],
		       v1:PlaceLocalHandle[Rail[Double]]) {

    val nn = 0;

    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {

	val in_ = Nvc*ND*(nn + iyzt*Nx);
	val ix1 = Nvc * 2 * iyzt;
	val ix2 = ix1 + Nvc;

	for (ic in 0..(Ncol-1)) {
	  vcp1_xp()(2*ic+  ix1) = v1()(2*ic  +id1+in_) - v1()(2*ic+1+id4+in_);
	  vcp1_xp()(2*ic+1+ix1) = v1()(2*ic+1+id1+in_) + v1()(2*ic  +id4+in_);
	  vcp1_xp()(2*ic  +ix2) = v1()(2*ic  +id2+in_) - v1()(2*ic+1+id3+in_);
	  vcp1_xp()(2*ic+1+ix2) = v1()(2*ic+1+id2+in_) + v1()(2*ic  +id3+in_);	  
	}

      }
    });

  }

  static def make_xm_bnd(vcp1_xm:PlaceLocalHandle[Rail[Double]],
			 u:PlaceLocalHandle[Rail[Double]], 
			 v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 0;
    val nn = Nx-1;

    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {
	val in_ = Nvc*ND*(nn + iyzt*Nx);
	val ig = Ndf*(nn + iyzt*Nx + idir*Nst);
	val ix1 = Nvc * 2 * iyzt;
	val ix2 = ix1 + Nvc;

	val vt1_0 = v1()(   id1+in_) + v1()(1 +id4+in_);
	val vt1_1 = v1()(1 +id1+in_) - v1()(   id4+in_);
	val vt2_0 = v1()(   id2+in_) + v1()(1 +id3+in_);
	val vt2_1 = v1()(1 +id2+in_) - v1()(   id3+in_);
	val vt1_2 = v1()(2 +id1+in_) + v1()(3 +id4+in_);
	val vt1_3 = v1()(3 +id1+in_) - v1()(2 +id4+in_);
	val vt2_2 = v1()(2 +id2+in_) + v1()(3 +id3+in_);
	val vt2_3 = v1()(3 +id2+in_) - v1()(2 +id3+in_);
	val vt1_4 = v1()(4 +id1+in_) + v1()(5 +id4+in_);
	val vt1_5 = v1()(5 +id1+in_) - v1()(4 +id4+in_);
	val vt2_4 = v1()(4 +id2+in_) + v1()(5 +id3+in_);
	val vt2_5 = v1()(5 +id2+in_) - v1()(4 +id3+in_);

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;
	  val ic1 = 0;
	  val ic2 = Nvc;
	  val ic3 = 2*Nvc;

	  vcp1_xm()(icr  +ix1) = u()(icr+ic1+ig)*vt1_0 + u()(ici+ic1+ig)*vt1_1
	  + u()(icr+ic2+ig)*vt1_2 + u()(ici+ic2+ig)*vt1_3
	  + u()(icr+ic3+ig)*vt1_4 + u()(ici+ic3+ig)*vt1_5;
	  vcp1_xm()(icr+1+ix1) = u()(icr+ic1+ig)*vt1_1 - u()(ici+ic1+ig)*vt1_0
	  + u()(icr+ic2+ig)*vt1_3 - u()(ici+ic2+ig)*vt1_2
	  + u()(icr+ic3+ig)*vt1_5 - u()(ici+ic3+ig)*vt1_4;

	  vcp1_xm()(icr  +ix2) = u()(icr+ic1+ig)*vt2_0 + u()(ici+ic1+ig)*vt2_1
	  + u()(icr+ic2+ig)*vt2_2 + u()(ici+ic2+ig)*vt2_3
	  + u()(icr+ic3+ig)*vt2_4 + u()(ici+ic3+ig)*vt2_5;
	  vcp1_xm()(icr+1+ix2) = u()(icr+ic1+ig)*vt2_1 - u()(ici+ic1+ig)*vt2_0
	  + u()(icr+ic2+ig)*vt2_3 - u()(ici+ic2+ig)*vt2_2
	  + u()(icr+ic3+ig)*vt2_5 - u()(ici+ic3+ig)*vt2_4;

	}
      }
    });
  }

  static def make_yp_bnd(vcp1_yp:PlaceLocalHandle[Rail[Double]],
			 v1:PlaceLocalHandle[Rail[Double]]) {

    val nn = 0;

    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(ix in 0..(Nx-1)){

	  val in_ = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
	  val ix1 = Nvc * 2 * (ix + izt * Nx);
	  val ix2 = ix1 + Nvc;

	  for (ic in 0..(Ncol-1)) {
	    vcp1_yp()(2*ic  +ix1) = v1()(2*ic  +id1+in_) + v1()(2*ic  +id4+in_);
	    vcp1_yp()(2*ic+1+ix1) = v1()(2*ic+1+id1+in_) + v1()(2*ic+1+id4+in_);
	    vcp1_yp()(2*ic  +ix2) = v1()(2*ic  +id2+in_) - v1()(2*ic  +id3+in_);
	    vcp1_yp()(2*ic+1+ix2) = v1()(2*ic+1+id2+in_) - v1()(2*ic+1+id3+in_);
	  }
	}
      }
    });
  }

  static def make_ym_bnd(vcp1_ym:PlaceLocalHandle[Rail[Double]],
			 u:PlaceLocalHandle[Rail[Double]], 
			 v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 1;
    val nn = Ny-1;

    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(ix in 0..(Nx-1)){
	  val in_ = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
	  val ig = Ndf*(ix + nn*Nx + izt*Nx*Ny + idir*Nst);
	  val ix1 = Nvc * 2 * (ix + izt * Nx);
	  val ix2 = ix1 + Nvc;

	  val vt1_0 = v1()(   id1+in_) - v1()(   id4+in_);
	  val vt1_1 = v1()(1 +id1+in_) - v1()(1 +id4+in_);
	  val vt2_0 = v1()(   id2+in_) + v1()(   id3+in_);
	  val vt2_1 = v1()(1 +id2+in_) + v1()(1 +id3+in_);
	  val vt1_2 = v1()(2 +id1+in_) - v1()(2 +id4+in_);
	  val vt1_3 = v1()(3 +id1+in_) - v1()(3 +id4+in_);
	  val vt2_2 = v1()(2 +id2+in_) + v1()(2 +id3+in_);
	  val vt2_3 = v1()(3 +id2+in_) + v1()(3 +id3+in_);
	  val vt1_4 = v1()(4 +id1+in_) - v1()(4 +id4+in_);
	  val vt1_5 = v1()(5 +id1+in_) - v1()(5 +id4+in_);
	  val vt2_4 = v1()(4 +id2+in_) + v1()(4 +id3+in_);
	  val vt2_5 = v1()(5 +id2+in_) + v1()(5 +id3+in_);

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;
	    val ic1 = 0;
	    val ic2 = Nvc;
	    val ic3 = 2*Nvc;

	    vcp1_ym()(icr+ix1) = u()(icr+ic1+ig)*vt1_0 + u()(ici+ic1+ig)*vt1_1
	    + u()(icr+ic2+ig)*vt1_2 + u()(ici+ic2+ig)*vt1_3
	    + u()(icr+ic3+ig)*vt1_4 + u()(ici+ic3+ig)*vt1_5;
	    vcp1_ym()(ici+ix1) = u()(icr+ic1+ig)*vt1_1 - u()(ici+ic1+ig)*vt1_0
	    + u()(icr+ic2+ig)*vt1_3 - u()(ici+ic2+ig)*vt1_2
	    + u()(icr+ic3+ig)*vt1_5 - u()(ici+ic3+ig)*vt1_4;

	    vcp1_ym()(icr+ix2) = u()(icr+ic1+ig)*vt2_0 + u()(ici+ic1+ig)*vt2_1
	    + u()(icr+ic2+ig)*vt2_2 + u()(ici+ic2+ig)*vt2_3
	    + u()(icr+ic3+ig)*vt2_4 + u()(ici+ic3+ig)*vt2_5;
	    vcp1_ym()(ici+ix2) = u()(icr+ic1+ig)*vt2_1 - u()(ici+ic1+ig)*vt2_0
	    + u()(icr+ic2+ig)*vt2_3 - u()(ici+ic2+ig)*vt2_2
	    + u()(icr+ic3+ig)*vt2_5 - u()(ici+ic3+ig)*vt2_4;

	  }
	}
      }
    });
  }

  static def make_zp_bnd(vcp1_zp:PlaceLocalHandle[Rail[Double]],
			 v1:PlaceLocalHandle[Rail[Double]]) {

    val nn = 0;

    parallel(0..(Nt-1), (r:LongRange)=> {
      for(it in r){
	for(ixy in 0..(Nx*Ny-1)){

	  val in_ = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
	  val ix1 = Nvc * 2 * (ixy + it * Nx * Ny);
	  val ix2 = ix1 + Nvc;

	  for (ic in 0..(Ncol-1)) {
	    vcp1_zp()(2*ic  +ix1) = v1()(2*ic  +id1+in_) - v1()(2*ic+1+id3+in_);
	    vcp1_zp()(2*ic+1+ix1) = v1()(2*ic+1+id1+in_) + v1()(2*ic  +id3+in_);
	    vcp1_zp()(2*ic  +ix2) = v1()(2*ic  +id2+in_) + v1()(2*ic+1+id4+in_);
	    vcp1_zp()(2*ic+1+ix2) = v1()(2*ic+1+id2+in_) - v1()(2*ic  +id4+in_);
	  }

	}
      }
    });

  }

  static def make_zm_bnd(vcp1_zm:PlaceLocalHandle[Rail[Double]],
			 u:PlaceLocalHandle[Rail[Double]], 
			 v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 2;
    val nn = Nz-1;

    parallel(0..(Nt-1), (r:LongRange)=> {
      for(it in r){
    	for(ixy in 0..(Nx*Ny-1)){
    	  val in_ = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
    	  val ig = Ndf*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);
	  val ix1 = Nvc * 2 * (ixy + it * Nx * Ny);
	  val ix2 = ix1 + Nvc;

    	  val vt1_0 = v1()(   id1+in_) + v1()(1 +id3+in_);
    	  val vt1_1 = v1()(1 +id1+in_) - v1()(   id3+in_);
    	  val vt2_0 = v1()(   id2+in_) - v1()(1 +id4+in_);
    	  val vt2_1 = v1()(1 +id2+in_) + v1()(   id4+in_);
    	  val vt1_2 = v1()(2 +id1+in_) + v1()(3 +id3+in_);
    	  val vt1_3 = v1()(3 +id1+in_) - v1()(2 +id3+in_);
    	  val vt2_2 = v1()(2 +id2+in_) - v1()(3 +id4+in_);
    	  val vt2_3 = v1()(3 +id2+in_) + v1()(2 +id4+in_);
    	  val vt1_4 = v1()(4 +id1+in_) + v1()(5 +id3+in_);
    	  val vt1_5 = v1()(5 +id1+in_) - v1()(4 +id3+in_);
    	  val vt2_4 = v1()(4 +id2+in_) - v1()(5 +id4+in_);
    	  val vt2_5 = v1()(5 +id2+in_) + v1()(4 +id4+in_);

    	  for(ic in 0..(Ncol-1)){
    	    val icr = 2*ic;
    	    val ici = 2*ic+1;
    	    val ic1 = 0;
    	    val ic2 = Nvc;
    	    val ic3 = 2*Nvc;

    	    vcp1_zm()(icr+ix1) = u()(icr+ic1+ig)*vt1_0 + u()(ici+ic1+ig)*vt1_1
    	    + u()(icr+ic2+ig)*vt1_2 + u()(ici+ic2+ig)*vt1_3
    	    + u()(icr+ic3+ig)*vt1_4 + u()(ici+ic3+ig)*vt1_5;
    	    vcp1_zm()(ici+ix1) = u()(icr+ic1+ig)*vt1_1 - u()(ici+ic1+ig)*vt1_0
    	    + u()(icr+ic2+ig)*vt1_3 - u()(ici+ic2+ig)*vt1_2
    	    + u()(icr+ic3+ig)*vt1_5 - u()(ici+ic3+ig)*vt1_4;

    	    vcp1_zm()(icr+ix2) = u()(icr+ic1+ig)*vt2_0 + u()(ici+ic1+ig)*vt2_1
    	    + u()(icr+ic2+ig)*vt2_2 + u()(ici+ic2+ig)*vt2_3
    	    + u()(icr+ic3+ig)*vt2_4 + u()(ici+ic3+ig)*vt2_5;
    	    vcp1_zm()(ici+ix2) = u()(icr+ic1+ig)*vt2_1 - u()(ici+ic1+ig)*vt2_0
    	    + u()(icr+ic2+ig)*vt2_3 - u()(ici+ic2+ig)*vt2_2
    	    + u()(icr+ic3+ig)*vt2_5 - u()(ici+ic3+ig)*vt2_4;
	  }
	}
      }
    });

  }

  static def make_tp_bnd(vcp1_tp:PlaceLocalHandle[Rail[Double]],
			 v1:PlaceLocalHandle[Rail[Double]]) {

    val nn = 0;

    parallel(0..(Nx*Ny*Nz-1), (r:LongRange)=> {
      for (ixyz in r) {

	val in_ = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
	val ix1 = Nvc * 2 * ixyz;
	val ix2 = ix1 + Nvc;

	for (ic in 0..(Ncol-1)) {
	  vcp1_tp()(2*ic  +ix1) = 2.0 * v1()(2*ic  +id3+in_);
	  vcp1_tp()(2*ic+1+ix1) = 2.0 * v1()(2*ic+1+id3+in_);
	  vcp1_tp()(2*ic  +ix2) = 2.0 * v1()(2*ic  +id4+in_);
	  vcp1_tp()(2*ic+1+ix2) = 2.0 * v1()(2*ic+1+id4+in_);
	}

      }
    });

  }

  static def make_tm_bnd(vcp1_tm:PlaceLocalHandle[Rail[Double]],
			 u:PlaceLocalHandle[Rail[Double]], 
			 v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 3;
    val nn = Nt-1;

    parallel(0..(Nx*Ny*Nz-1), (r:LongRange)=> {
      for(ixyz in r) {
	val in_ = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
	val ig = Ndf*(ixyz + nn*Nx*Ny*Nz + idir*Nst);
	val ix1 = Nvc * 2 * ixyz;
	val ix2 = ix1 + Nvc;

	val vt1_0 = 2.0 * v1()(    id1+in_);
	val vt1_1 = 2.0 * v1()(1 + id1+in_);
	val vt2_0 = 2.0 * v1()(    id2+in_);
	val vt2_1 = 2.0 * v1()(1 + id2+in_);
	val vt1_2 = 2.0 * v1()(2 + id1+in_);
	val vt1_3 = 2.0 * v1()(3 + id1+in_);
	val vt2_2 = 2.0 * v1()(2 + id2+in_);
	val vt2_3 = 2.0 * v1()(3 + id2+in_);
	val vt1_4 = 2.0 * v1()(4 + id1+in_);
	val vt1_5 = 2.0 * v1()(5 + id1+in_);
	val vt2_4 = 2.0 * v1()(4 + id2+in_);
	val vt2_5 = 2.0 * v1()(5 + id2+in_);

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;
	  val ic1 = 0;
	  val ic2 = Nvc;
	  val ic3 = 2*Nvc;

	  vcp1_tm()(icr+ix1) = u()(icr+ic1+ig)*vt1_0 + u()(ici+ic1+ig)*vt1_1
	  + u()(icr+ic2+ig)*vt1_2 + u()(ici+ic2+ig)*vt1_3
	  + u()(icr+ic3+ig)*vt1_4 + u()(ici+ic3+ig)*vt1_5;
	  vcp1_tm()(ici+ix1) = u()(icr+ic1+ig)*vt1_1 - u()(ici+ic1+ig)*vt1_0
	  + u()(icr+ic2+ig)*vt1_3 - u()(ici+ic2+ig)*vt1_2
	  + u()(icr+ic3+ig)*vt1_5 - u()(ici+ic3+ig)*vt1_4;

	  vcp1_tm()(icr+ix2) = u()(icr+ic1+ig)*vt2_0 + u()(ici+ic1+ig)*vt2_1
	  + u()(icr+ic2+ig)*vt2_2 + u()(ici+ic2+ig)*vt2_3
	  + u()(icr+ic3+ig)*vt2_4 + u()(ici+ic3+ig)*vt2_5;
	  vcp1_tm()(ici+ix2) = u()(icr+ic1+ig)*vt2_1 - u()(ici+ic1+ig)*vt2_0
	  + u()(icr+ic2+ig)*vt2_3 - u()(ici+ic2+ig)*vt2_2
	  + u()(icr+ic3+ig)*vt2_5 - u()(ici+ic3+ig)*vt2_4;

	}
      }
    });

  }

  static def set_xp_bnd(vcp2_xp:PlaceLocalHandle[Rail[Double]], 
			u:PlaceLocalHandle[Rail[Double]],
			v2:PlaceLocalHandle[Rail[Double]]) {

    val idir = 0;
    val ix = Nx-1;

    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {

	val iv = Nvc*ND*(ix + iyzt*Nx);
	val ig = Ndf*(ix + iyzt*Nx + idir*Nst);
	val ix1 = Nvc * 2 * iyzt;
	val ix2 = ix1 + Nvc;

	for(ic in 0..(Ncol-1)){
	  val ic2 = ic*Nvc;

	  val wt1r = mult_uv_r(u(), vcp2_xp(), ic2, ig, ix1);
	  val wt1i = mult_uv_i(u(), vcp2_xp(), ic2, ig, ix1);
	  val wt2r = mult_uv_r(u(), vcp2_xp(), ic2, ig, ix2);
	  val wt2i = mult_uv_i(u(), vcp2_xp(), ic2, ig, ix2);

	  v2()(2*ic   +id1+iv) +=  wt1r;
	  v2()(2*ic+1 +id1+iv) +=  wt1i;
	  v2()(2*ic   +id2+iv) +=  wt2r;
	  v2()(2*ic+1 +id2+iv) +=  wt2i;
	  v2()(2*ic   +id3+iv) +=  wt2i;
	  v2()(2*ic+1 +id3+iv) += -wt2r;
	  v2()(2*ic   +id4+iv) +=  wt1i;
	  v2()(2*ic+1 +id4+iv) += -wt1r;
	}
      }
    });

  }

  static def set_xm_bnd(vcp2_xm:PlaceLocalHandle[Rail[Double]], 
			v2:PlaceLocalHandle[Rail[Double]]) {

    val ix = 0;

    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {
	val iv = Nvc*ND*(ix + iyzt*Nx);
	val ix1 = Nvc * 2 * iyzt;
	val ix2 = ix1 + Nvc;

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;

	  v2()(icr +id1+iv) +=  vcp2_xm()(icr+ix1);
	  v2()(ici +id1+iv) +=  vcp2_xm()(ici+ix1);
	  v2()(icr +id2+iv) +=  vcp2_xm()(icr+ix2);
	  v2()(ici +id2+iv) +=  vcp2_xm()(ici+ix2);
	  v2()(icr +id3+iv) += -vcp2_xm()(ici+ix2);
	  v2()(ici +id3+iv) += +vcp2_xm()(icr+ix2);
	  v2()(icr +id4+iv) += -vcp2_xm()(ici+ix1);
	  v2()(ici +id4+iv) += +vcp2_xm()(icr+ix1);
	}
      }
    });
  }

  static def set_yp_bnd(vcp2_yp:PlaceLocalHandle[Rail[Double]], 
			u:PlaceLocalHandle[Rail[Double]],
			v2:PlaceLocalHandle[Rail[Double]]) {

    val idir = 1;
    val iy = Ny-1;

    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(ix in 0..(Nx-1)){

	  val iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
	  val ig = Ndf*(ix + iy*Nx + izt*Nx*Ny + idir*Nst);
	  val ix1 = Nvc * 2 * (ix + izt * Nx);
	  val ix2 = ix1 + Nvc;

	  for(ic in 0..(Ncol-1)){
	    val ic2 = ic*Nvc;

	    val wt1r = mult_uv_r(u(), vcp2_yp(), ic2, ig, ix1);
	    val wt1i = mult_uv_i(u(), vcp2_yp(), ic2, ig, ix1);
	    val wt2r = mult_uv_r(u(), vcp2_yp(), ic2, ig, ix2);
	    val wt2i = mult_uv_i(u(), vcp2_yp(), ic2, ig, ix2);

	    v2()(2*ic   +id1+iv) +=  wt1r;
	    v2()(2*ic+1 +id1+iv) +=  wt1i;
	    v2()(2*ic   +id2+iv) +=  wt2r;
	    v2()(2*ic+1 +id2+iv) +=  wt2i;
	    v2()(2*ic   +id3+iv) += -wt2r;
	    v2()(2*ic+1 +id3+iv) += -wt2i;
	    v2()(2*ic   +id4+iv) +=  wt1r;
	    v2()(2*ic+1 +id4+iv) +=  wt1i;
	  }
	}
      }
    });
  }

  static def set_ym_bnd(vcp2_ym:PlaceLocalHandle[Rail[Double]], 
			v2:PlaceLocalHandle[Rail[Double]]) {

    val iy = 0;

    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(ix in 0..(Nx-1)){
	  val iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
	  val ix1 = Nvc * 2 * (ix + izt * Nx);
	  val ix2 = ix1 + Nvc;

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;

	    v2()(icr +id1+iv) +=  vcp2_ym()(icr+ix1);
	    v2()(ici +id1+iv) +=  vcp2_ym()(ici+ix1);
	    v2()(icr +id2+iv) +=  vcp2_ym()(icr+ix2);
	    v2()(ici +id2+iv) +=  vcp2_ym()(ici+ix2);
	    v2()(icr +id3+iv) +=  vcp2_ym()(icr+ix2);
	    v2()(ici +id3+iv) +=  vcp2_ym()(ici+ix2);
	    v2()(icr +id4+iv) += -vcp2_ym()(icr+ix1);
	    v2()(ici +id4+iv) += -vcp2_ym()(ici+ix1);
	  }
	}
      }
    });
  }

  static def set_zp_bnd(vcp2_zp:PlaceLocalHandle[Rail[Double]], 
			u:PlaceLocalHandle[Rail[Double]],
			v2:PlaceLocalHandle[Rail[Double]]) {

    val idir = 2;
    val iz = Nz-1;

    parallel(0..(Nt-1), (r:LongRange)=> {
      for(it in r){
	for(ixy in 0..(Nx*Ny-1)){

	  val iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
	  val ig = Ndf*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);
	  val ix1 = Nvc * 2 * (ixy + it * Nx * Ny);
	  val ix2 = ix1 + Nvc;

	  for(ic in 0..(Ncol-1)){
	    val ic2 = ic*Nvc;

	    val wt1r = mult_uv_r(u(), vcp2_zp(), ic2, ig, ix1);
	    val wt1i = mult_uv_i(u(), vcp2_zp(), ic2, ig, ix1);
	    val wt2r = mult_uv_r(u(), vcp2_zp(), ic2, ig, ix2);
	    val wt2i = mult_uv_i(u(), vcp2_zp(), ic2, ig, ix2);

	    v2()(2*ic   +id1+iv) +=  wt1r;
	    v2()(2*ic+1 +id1+iv) +=  wt1i;
	    v2()(2*ic   +id2+iv) +=  wt2r;
	    v2()(2*ic+1 +id2+iv) +=  wt2i;
	    v2()(2*ic   +id3+iv) +=  wt1i;
	    v2()(2*ic+1 +id3+iv) += -wt1r;
	    v2()(2*ic   +id4+iv) += -wt2i;
	    v2()(2*ic+1 +id4+iv) +=  wt2r;
	  }
	}
      }
    });

  }

  static def set_zm_bnd(vcp2_zm:PlaceLocalHandle[Rail[Double]], 
			v2:PlaceLocalHandle[Rail[Double]]) {

    val iz = 0;

    parallel(0..(Nt-1), (r:LongRange)=> {
      for(it in r){
    	for(ixy in 0..(Nx*Ny-1)){
    	  val iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
	  val ix1 = Nvc * 2 * (ixy + it * Nx * Ny);
	  val ix2 = ix1 + Nvc;

    	  for(ic in 0..(Ncol-1)){
    	    val icr = 2*ic;
    	    val ici = 2*ic+1;

    	    v2()(icr +id1+iv) +=  vcp2_zm()(icr+ix1);
    	    v2()(ici +id1+iv) +=  vcp2_zm()(ici+ix1);
    	    v2()(icr +id2+iv) +=  vcp2_zm()(icr+ix2);
    	    v2()(ici +id2+iv) +=  vcp2_zm()(ici+ix2);
    	    v2()(icr +id3+iv) += -vcp2_zm()(ici+ix1);
    	    v2()(ici +id3+iv) +=  vcp2_zm()(icr+ix1);
    	    v2()(icr +id4+iv) +=  vcp2_zm()(ici+ix2);
    	    v2()(ici +id4+iv) += -vcp2_zm()(icr+ix2);
    	  }
    	}
      }
    });

  }

  static def set_tp_bnd(vcp2_tp:PlaceLocalHandle[Rail[Double]], 
			u:PlaceLocalHandle[Rail[Double]],
			v2:PlaceLocalHandle[Rail[Double]]) {

    val idir = 3;
    val it = Nt-1;

    parallel(0..(Nx*Ny*Nz-1), (r:LongRange)=> {
      for (ixyz in r) {

    	val iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
    	val ig = Ndf*(ixyz + it*Nx*Ny*Nz + idir*Nst);
    	val ix1 = Nvc * 2 * ixyz;
    	val ix2 = ix1 + Nvc;

	for(ic in 0..(Ncol-1)){
	  val ic2 = ic*Nvc;

	  val wt1r = mult_uv_r(u(), vcp2_tp(), ic2, ig, ix1);
	  val wt1i = mult_uv_i(u(), vcp2_tp(), ic2, ig, ix1);
	  val wt2r = mult_uv_r(u(), vcp2_tp(), ic2, ig, ix2);
	  val wt2i = mult_uv_i(u(), vcp2_tp(), ic2, ig, ix2);

	  v2()(2*ic   +id3+iv) +=  wt1r;
	  v2()(2*ic+1 +id3+iv) +=  wt1i;
	  v2()(2*ic   +id4+iv) +=  wt2r;
	  v2()(2*ic+1 +id4+iv) +=  wt2i;
	}
      }
    });

  }

  static def set_tm_bnd(vcp2_tm:PlaceLocalHandle[Rail[Double]], 
			v2:PlaceLocalHandle[Rail[Double]]) {

    val it = 0;

    parallel(0..(Nx*Ny*Nz-1), (r:LongRange)=> {
      for(ixyz in r) {
	val iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
	val ix1 = Nvc * 2 * ixyz;
	val ix2 = ix1 + Nvc;

	for(ic in 0..(Ncol-1)){
	  val icr = 2*ic;
	  val ici = 2*ic+1;

	  v2()(icr +id1+iv) +=  vcp2_tm()(icr+ix1);
	  v2()(ici +id1+iv) +=  vcp2_tm()(ici+ix1);
	  v2()(icr +id2+iv) +=  vcp2_tm()(icr+ix2);
	  v2()(ici +id2+iv) +=  vcp2_tm()(ici+ix2);
	}
      }
    });

  }

  static def mult_xp_bulk(v2:PlaceLocalHandle[Rail[Double]], 
			  u:PlaceLocalHandle[Rail[Double]], 
			  v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 0;

    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {
	for(ix_ in 0..(Nx-2)) {

	  val nn_ = ix_+1;

	  val iv = Nvc*ND*(ix_ + iyzt*Nx);
	  val in_ = Nvc*ND*(nn_ + iyzt*Nx);
	  val ig = Ndf*(ix_ + iyzt*Nx + idir*Nst);

	  val vt1_0 = v1()(   id1+in_) - v1()(1 +id4+in_);
	  val vt1_1 = v1()(1 +id1+in_) + v1()(   id4+in_);
	  val vt2_0 = v1()(   id2+in_) - v1()(1 +id3+in_);
	  val vt2_1 = v1()(1 +id2+in_) + v1()(   id3+in_);
	  val vt1_2 = v1()(2 +id1+in_) - v1()(3 +id4+in_);
	  val vt1_3 = v1()(3 +id1+in_) + v1()(2 +id4+in_);
	  val vt2_2 = v1()(2 +id2+in_) - v1()(3 +id3+in_);
	  val vt2_3 = v1()(3 +id2+in_) + v1()(2 +id3+in_);
	  val vt1_4 = v1()(4 +id1+in_) - v1()(5 +id4+in_);
	  val vt1_5 = v1()(5 +id1+in_) + v1()(4 +id4+in_);
	  val vt2_4 = v1()(4 +id2+in_) - v1()(5 +id3+in_);
	  val vt2_5 = v1()(5 +id2+in_) + v1()(4 +id3+in_);

	  for(ic in 0..(Ncol-1)){
	    val ic2 = ic*Nvc;

	    val wt1r = u()(0+ic2+ig)*vt1_0 - u()(1+ic2+ig)*vt1_1
	    + u()(2+ic2+ig)*vt1_2 - u()(3+ic2+ig)*vt1_3
	    + u()(4+ic2+ig)*vt1_4 - u()(5+ic2+ig)*vt1_5;
	    val wt1i = u()(0+ic2+ig)*vt1_1 + u()(1+ic2+ig)*vt1_0
	    + u()(2+ic2+ig)*vt1_3 + u()(3+ic2+ig)*vt1_2
	    + u()(4+ic2+ig)*vt1_5 + u()(5+ic2+ig)*vt1_4;

	    val wt2r = u()(0+ic2+ig)*vt2_0 - u()(1+ic2+ig)*vt2_1
	    + u()(2+ic2+ig)*vt2_2 - u()(3+ic2+ig)*vt2_3
	    + u()(4+ic2+ig)*vt2_4 - u()(5+ic2+ig)*vt2_5;
	    val wt2i = u()(0+ic2+ig)*vt2_1 + u()(1+ic2+ig)*vt2_0
	    + u()(2+ic2+ig)*vt2_3 + u()(3+ic2+ig)*vt2_2
	    + u()(4+ic2+ig)*vt2_5 + u()(5+ic2+ig)*vt2_4;

	    v2()(2*ic   +id1+iv) +=  wt1r;
	    v2()(2*ic+1 +id1+iv) +=  wt1i;
	    v2()(2*ic   +id2+iv) +=  wt2r;
	    v2()(2*ic+1 +id2+iv) +=  wt2i;
	    v2()(2*ic   +id3+iv) +=  wt2i;
	    v2()(2*ic+1 +id3+iv) += -wt2r;
	    v2()(2*ic   +id4+iv) +=  wt1i;
	    v2()(2*ic+1 +id4+iv) += -wt1r;
	  }
	}
      }
    });
  }

  static def mult_xm_bulk(v2:PlaceLocalHandle[Rail[Double]], 
			  u:PlaceLocalHandle[Rail[Double]], 
			  v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 0;

    parallel(0..(Ny*Nz*Nt-1), (r:LongRange)=> {
      for (iyzt in r) {
	for(ix_ in 1..(Nx-1)){
	  val nn_ = ix_-1;

	  val iv = Nvc*ND*(ix_ + (iyzt)*Nx);
	  val in_ = Nvc*ND*(nn_ + (iyzt)*Nx);
	  val ig = Ndf*(nn_ + iyzt*Nx + idir*Nst);

	  val vt1_0 = v1()(   id1+in_) + v1()(1 +id4+in_);
	  val vt1_1 = v1()(1 +id1+in_) - v1()(   id4+in_);
	  val vt2_0 = v1()(   id2+in_) + v1()(1 +id3+in_);
	  val vt2_1 = v1()(1 +id2+in_) - v1()(   id3+in_);
	  val vt1_2 = v1()(2 +id1+in_) + v1()(3 +id4+in_);
	  val vt1_3 = v1()(3 +id1+in_) - v1()(2 +id4+in_);
	  val vt2_2 = v1()(2 +id2+in_) + v1()(3 +id3+in_);
	  val vt2_3 = v1()(3 +id2+in_) - v1()(2 +id3+in_);
	  val vt1_4 = v1()(4 +id1+in_) + v1()(5 +id4+in_);
	  val vt1_5 = v1()(5 +id1+in_) - v1()(4 +id4+in_);
	  val vt2_4 = v1()(4 +id2+in_) + v1()(5 +id3+in_);
	  val vt2_5 = v1()(5 +id2+in_) - v1()(4 +id3+in_);

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;
	    val ic1 = 0;
	    val ic2 = Nvc;
	    val ic3 = 2*Nvc;

	    val wt1r = u()(icr+ic1+ig)*vt1_0 + u()(ici+ic1+ig)*vt1_1
	    + u()(icr+ic2+ig)*vt1_2 + u()(ici+ic2+ig)*vt1_3
	    + u()(icr+ic3+ig)*vt1_4 + u()(ici+ic3+ig)*vt1_5;
	    val wt1i = u()(icr+ic1+ig)*vt1_1 - u()(ici+ic1+ig)*vt1_0
	    + u()(icr+ic2+ig)*vt1_3 - u()(ici+ic2+ig)*vt1_2
	    + u()(icr+ic3+ig)*vt1_5 - u()(ici+ic3+ig)*vt1_4;

	    val wt2r = u()(icr+ic1+ig)*vt2_0 + u()(ici+ic1+ig)*vt2_1
	    + u()(icr+ic2+ig)*vt2_2 + u()(ici+ic2+ig)*vt2_3
	    + u()(icr+ic3+ig)*vt2_4 + u()(ici+ic3+ig)*vt2_5;
	    val wt2i = u()(icr+ic1+ig)*vt2_1 - u()(ici+ic1+ig)*vt2_0
	    + u()(icr+ic2+ig)*vt2_3 - u()(ici+ic2+ig)*vt2_2
	    + u()(icr+ic3+ig)*vt2_5 - u()(ici+ic3+ig)*vt2_4;

	    v2()(icr +id1+iv) +=  wt1r;
	    v2()(ici +id1+iv) +=  wt1i;
	    v2()(icr +id2+iv) +=  wt2r;
	    v2()(ici +id2+iv) +=  wt2i;
	    v2()(icr +id3+iv) += -wt2i;
	    v2()(ici +id3+iv) += +wt2r;
	    v2()(icr +id4+iv) += -wt1i;
	    v2()(ici +id4+iv) += +wt1r;
	  }
	}
      }
    });
  }

  static def mult_yp_bulk(v2:PlaceLocalHandle[Rail[Double]], 
			  u:PlaceLocalHandle[Rail[Double]], 
			  v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 1;

    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(iy_ in 0..(Ny-2)){
	  val nn_ = iy_ + 1;
	  for(ix in 0..(Nx-1)){

	    val iv = Nvc*ND*(ix + iy_*Nx + izt*Nx*Ny);
	    val in_ = Nvc*ND*(ix + nn_*Nx + izt*Nx*Ny);
	    val ig = Ndf*(ix + iy_*Nx + izt*Nx*Ny + idir*Nst);

	    val vt1_0 = v1()(   id1+in_) + v1()(   id4+in_);
	    val vt1_1 = v1()(1 +id1+in_) + v1()(1 +id4+in_);
	    val vt2_0 = v1()(   id2+in_) - v1()(   id3+in_);
	    val vt2_1 = v1()(1 +id2+in_) - v1()(1 +id3+in_);
	    val vt1_2 = v1()(2 +id1+in_) + v1()(2 +id4+in_);
	    val vt1_3 = v1()(3 +id1+in_) + v1()(3 +id4+in_);
	    val vt2_2 = v1()(2 +id2+in_) - v1()(2 +id3+in_);
	    val vt2_3 = v1()(3 +id2+in_) - v1()(3 +id3+in_);
	    val vt1_4 = v1()(4 +id1+in_) + v1()(4 +id4+in_);
	    val vt1_5 = v1()(5 +id1+in_) + v1()(5 +id4+in_);
	    val vt2_4 = v1()(4 +id2+in_) - v1()(4 +id3+in_);
	    val vt2_5 = v1()(5 +id2+in_) - v1()(5 +id3+in_);

	    for(ic in 0..(Ncol-1)){
	      val ic2 = ic*Nvc;
	      val wt1r = u()(0+ic2+ig)*vt1_0 - u()(1+ic2+ig)*vt1_1
	      + u()(2+ic2+ig)*vt1_2 - u()(3+ic2+ig)*vt1_3
	      + u()(4+ic2+ig)*vt1_4 - u()(5+ic2+ig)*vt1_5;
	      val wt1i = u()(0+ic2+ig)*vt1_1 + u()(1+ic2+ig)*vt1_0
	      + u()(2+ic2+ig)*vt1_3 + u()(3+ic2+ig)*vt1_2
	      + u()(4+ic2+ig)*vt1_5 + u()(5+ic2+ig)*vt1_4;

	      val wt2r = u()(0+ic2+ig)*vt2_0 - u()(1+ic2+ig)*vt2_1
	      + u()(2+ic2+ig)*vt2_2 - u()(3+ic2+ig)*vt2_3
	      + u()(4+ic2+ig)*vt2_4 - u()(5+ic2+ig)*vt2_5;
	      val wt2i = u()(0+ic2+ig)*vt2_1 + u()(1+ic2+ig)*vt2_0
	      + u()(2+ic2+ig)*vt2_3 + u()(3+ic2+ig)*vt2_2
	      + u()(4+ic2+ig)*vt2_5 + u()(5+ic2+ig)*vt2_4;

	      v2()(2*ic   +id1+iv) +=  wt1r;
	      v2()(2*ic+1 +id1+iv) +=  wt1i;
	      v2()(2*ic   +id2+iv) +=  wt2r;
	      v2()(2*ic+1 +id2+iv) +=  wt2i;
	      v2()(2*ic   +id3+iv) += -wt2r;
	      v2()(2*ic+1 +id3+iv) += -wt2i;
	      v2()(2*ic   +id4+iv) +=  wt1r;
	      v2()(2*ic+1 +id4+iv) +=  wt1i;
	    }
	  }
	}
      }
    });
  }

  static def mult_ym_bulk(v2:PlaceLocalHandle[Rail[Double]], 
			  u:PlaceLocalHandle[Rail[Double]], 
			  v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 1;

    parallel(0..(Nz*Nt-1), (r:LongRange)=> {
      for (izt in r) {
	for(iy_ in 1..(Ny-1)){
	  val nn_ = iy_ - 1;
	  for(ix in 0..(Nx-1)){

	    val iv = Nvc*ND*(ix + iy_*Nx + izt*Nx*Ny);
	    val in_ = Nvc*ND*(ix + nn_*Nx + izt*Nx*Ny);
	    val ig = Ndf*(ix + nn_*Nx + izt*Nx*Ny + idir*Nst);

	    val vt1_0 = v1()(   id1+in_) - v1()(   id4+in_);
	    val vt1_1 = v1()(1 +id1+in_) - v1()(1 +id4+in_);
	    val vt2_0 = v1()(   id2+in_) + v1()(   id3+in_);
	    val vt2_1 = v1()(1 +id2+in_) + v1()(1 +id3+in_);
	    val vt1_2 = v1()(2 +id1+in_) - v1()(2 +id4+in_);
	    val vt1_3 = v1()(3 +id1+in_) - v1()(3 +id4+in_);
	    val vt2_2 = v1()(2 +id2+in_) + v1()(2 +id3+in_);
	    val vt2_3 = v1()(3 +id2+in_) + v1()(3 +id3+in_);
	    val vt1_4 = v1()(4 +id1+in_) - v1()(4 +id4+in_);
	    val vt1_5 = v1()(5 +id1+in_) - v1()(5 +id4+in_);
	    val vt2_4 = v1()(4 +id2+in_) + v1()(4 +id3+in_);
	    val vt2_5 = v1()(5 +id2+in_) + v1()(5 +id3+in_);

	    for(ic in 0..(Ncol-1)){
	      val icr = 2*ic;
	      val ici = 2*ic+1;
	      val ic1 = 0;
	      val ic2 = Nvc;
	      val ic3 = 2*Nvc;

	      val wt1r = u()(icr+ic1+ig)*vt1_0 + u()(ici+ic1+ig)*vt1_1
	      + u()(icr+ic2+ig)*vt1_2 + u()(ici+ic2+ig)*vt1_3
	      + u()(icr+ic3+ig)*vt1_4 + u()(ici+ic3+ig)*vt1_5;
	      val wt1i = u()(icr+ic1+ig)*vt1_1 - u()(ici+ic1+ig)*vt1_0
	      + u()(icr+ic2+ig)*vt1_3 - u()(ici+ic2+ig)*vt1_2
	      + u()(icr+ic3+ig)*vt1_5 - u()(ici+ic3+ig)*vt1_4;

	      val wt2r = u()(icr+ic1+ig)*vt2_0 + u()(ici+ic1+ig)*vt2_1
	      + u()(icr+ic2+ig)*vt2_2 + u()(ici+ic2+ig)*vt2_3
	      + u()(icr+ic3+ig)*vt2_4 + u()(ici+ic3+ig)*vt2_5;
	      val wt2i = u()(icr+ic1+ig)*vt2_1 - u()(ici+ic1+ig)*vt2_0
	      + u()(icr+ic2+ig)*vt2_3 - u()(ici+ic2+ig)*vt2_2
	      + u()(icr+ic3+ig)*vt2_5 - u()(ici+ic3+ig)*vt2_4;

	      v2()(icr +id1+iv) +=  wt1r;
	      v2()(ici +id1+iv) +=  wt1i;
	      v2()(icr +id2+iv) +=  wt2r;
	      v2()(ici +id2+iv) +=  wt2i;
	      v2()(icr +id3+iv) +=  wt2r;
	      v2()(ici +id3+iv) +=  wt2i;
	      v2()(icr +id4+iv) += -wt1r;
	      v2()(ici +id4+iv) += -wt1i;
	    }
	  }
	}
      }
    });

  }

  static def mult_zp_bulk(v2:PlaceLocalHandle[Rail[Double]], 
			  u:PlaceLocalHandle[Rail[Double]], 
			  v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 2;

    parallel(0..(Nt-1), (r:LongRange)=> {
      for (it in r) {
	for(iz_ in 0..(Nz-2)){
	  val nn_ = iz_ + 1;
	  for(ixy in 0..(Nx*Ny-1)){

	    val iv = Nvc*ND*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz);
	    val in_ = Nvc*ND*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz);
	    val ig = Ndf*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

	    val vt1_0 = v1()(   id1+in_) - v1()(1 +id3+in_);
	    val vt1_1 = v1()(1 +id1+in_) + v1()(   id3+in_);
	    val vt2_0 = v1()(   id2+in_) + v1()(1 +id4+in_);
	    val vt2_1 = v1()(1 +id2+in_) - v1()(   id4+in_);
	    val vt1_2 = v1()(2 +id1+in_) - v1()(3 +id3+in_);
	    val vt1_3 = v1()(3 +id1+in_) + v1()(2 +id3+in_);
	    val vt2_2 = v1()(2 +id2+in_) + v1()(3 +id4+in_);
	    val vt2_3 = v1()(3 +id2+in_) - v1()(2 +id4+in_);
	    val vt1_4 = v1()(4 +id1+in_) - v1()(5 +id3+in_);
	    val vt1_5 = v1()(5 +id1+in_) + v1()(4 +id3+in_);
	    val vt2_4 = v1()(4 +id2+in_) + v1()(5 +id4+in_);
	    val vt2_5 = v1()(5 +id2+in_) - v1()(4 +id4+in_);

	    for(ic in 0..(Ncol-1)){
	      val ic2 = ic*Nvc;

	      val wt1r = u()(0+ic2+ig)*vt1_0 - u()(1+ic2+ig)*vt1_1
	      + u()(2+ic2+ig)*vt1_2 - u()(3+ic2+ig)*vt1_3
	      + u()(4+ic2+ig)*vt1_4 - u()(5+ic2+ig)*vt1_5;
	      val wt1i = u()(0+ic2+ig)*vt1_1 + u()(1+ic2+ig)*vt1_0
	      + u()(2+ic2+ig)*vt1_3 + u()(3+ic2+ig)*vt1_2
	      + u()(4+ic2+ig)*vt1_5 + u()(5+ic2+ig)*vt1_4;

	      val wt2r = u()(0+ic2+ig)*vt2_0 - u()(1+ic2+ig)*vt2_1
	      + u()(2+ic2+ig)*vt2_2 - u()(3+ic2+ig)*vt2_3
	      + u()(4+ic2+ig)*vt2_4 - u()(5+ic2+ig)*vt2_5;
	      val wt2i = u()(0+ic2+ig)*vt2_1 + u()(1+ic2+ig)*vt2_0
	      + u()(2+ic2+ig)*vt2_3 + u()(3+ic2+ig)*vt2_2
	      + u()(4+ic2+ig)*vt2_5 + u()(5+ic2+ig)*vt2_4;

	      v2()(2*ic   +id1+iv) +=  wt1r;
	      v2()(2*ic+1 +id1+iv) +=  wt1i;
	      v2()(2*ic   +id2+iv) +=  wt2r;
	      v2()(2*ic+1 +id2+iv) +=  wt2i;
	      v2()(2*ic   +id3+iv) +=  wt1i;
	      v2()(2*ic+1 +id3+iv) += -wt1r;
	      v2()(2*ic   +id4+iv) += -wt2i;
	      v2()(2*ic+1 +id4+iv) +=  wt2r;
	    }
	  }
	}
      }
    });

  }

  static def mult_zm_bulk(v2:PlaceLocalHandle[Rail[Double]], 
			  u:PlaceLocalHandle[Rail[Double]], 
			  v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 2;

    parallel(0..(Nt-1), (r:LongRange)=> {
      for (it in r) {
    	for(iz_ in 1..(Nz-1)){
    	  val nn_ = iz_ - 1;
    	  for(ixy in 0..(Nx*Ny-1)){

    	    val iv = Nvc*ND*(ixy + iz_*Nx*Ny + it*Nx*Ny*Nz);
    	    val in_ = Nvc*ND*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz);
    	    val ig = Ndf*(ixy + nn_*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

    	    val vt1_0 = v1()(   id1+in_) + v1()(1 +id3+in_);
    	    val vt1_1 = v1()(1 +id1+in_) - v1()(   id3+in_);
    	    val vt2_0 = v1()(   id2+in_) - v1()(1 +id4+in_);
    	    val vt2_1 = v1()(1 +id2+in_) + v1()(   id4+in_);
    	    val vt1_2 = v1()(2 +id1+in_) + v1()(3 +id3+in_);
    	    val vt1_3 = v1()(3 +id1+in_) - v1()(2 +id3+in_);
    	    val vt2_2 = v1()(2 +id2+in_) - v1()(3 +id4+in_);
    	    val vt2_3 = v1()(3 +id2+in_) + v1()(2 +id4+in_);
    	    val vt1_4 = v1()(4 +id1+in_) + v1()(5 +id3+in_);
    	    val vt1_5 = v1()(5 +id1+in_) - v1()(4 +id3+in_);
    	    val vt2_4 = v1()(4 +id2+in_) - v1()(5 +id4+in_);
    	    val vt2_5 = v1()(5 +id2+in_) + v1()(4 +id4+in_);

    	    for(ic in 0..(Ncol-1)){
    	      val icr = 2*ic;
    	      val ici = 2*ic+1;
    	      val ic1 = 0;
    	      val ic2 = Nvc;
    	      val ic3 = 2*Nvc;

    	      val wt1r = u()(icr+ic1+ig)*vt1_0 + u()(ici+ic1+ig)*vt1_1
    	      + u()(icr+ic2+ig)*vt1_2 + u()(ici+ic2+ig)*vt1_3
    	      + u()(icr+ic3+ig)*vt1_4 + u()(ici+ic3+ig)*vt1_5;
    	      val wt1i = u()(icr+ic1+ig)*vt1_1 - u()(ici+ic1+ig)*vt1_0
    	      + u()(icr+ic2+ig)*vt1_3 - u()(ici+ic2+ig)*vt1_2
    	      + u()(icr+ic3+ig)*vt1_5 - u()(ici+ic3+ig)*vt1_4;

    	      val wt2r = u()(icr+ic1+ig)*vt2_0 + u()(ici+ic1+ig)*vt2_1
    	      + u()(icr+ic2+ig)*vt2_2 + u()(ici+ic2+ig)*vt2_3
    	      + u()(icr+ic3+ig)*vt2_4 + u()(ici+ic3+ig)*vt2_5;
    	      val wt2i = u()(icr+ic1+ig)*vt2_1 - u()(ici+ic1+ig)*vt2_0
    	      + u()(icr+ic2+ig)*vt2_3 - u()(ici+ic2+ig)*vt2_2
    	      + u()(icr+ic3+ig)*vt2_5 - u()(ici+ic3+ig)*vt2_4;

    	      v2()(icr +id1+iv) +=  wt1r;
    	      v2()(ici +id1+iv) +=  wt1i;
    	      v2()(icr +id2+iv) +=  wt2r;
    	      v2()(ici +id2+iv) +=  wt2i;
    	      v2()(icr +id3+iv) += -wt1i;
    	      v2()(ici +id3+iv) +=  wt1r;
    	      v2()(icr +id4+iv) +=  wt2i;
    	      v2()(ici +id4+iv) += -wt2r;
    	    }
    	  }
    	}
      }
    });

  }

  static def mult_tp_bulk(v2:PlaceLocalHandle[Rail[Double]], 
			  u:PlaceLocalHandle[Rail[Double]], 
			  v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 3;

    parallel(0..(Nt-2), (r:LongRange)=> {
      for (it_ in r) {
	val nn_ = it_ + 1;
	for(ixyz in 0..(Nx*Ny*Nz-1)) {

	  val iv = Nvc*ND*(ixyz + it_*Nx*Ny*Nz);
	  val in_ = Nvc*ND*(ixyz + nn_*Nx*Ny*Nz);
	  val ig = Ndf*(ixyz + it_*Nx*Ny*Nz + idir*Nst);

	  val vt1_0 = 2.0 * v1()(    id3+in_);
	  val vt1_1 = 2.0 * v1()(1 + id3+in_);
	  val vt2_0 = 2.0 * v1()(    id4+in_);
	  val vt2_1 = 2.0 * v1()(1 + id4+in_);
	  val vt1_2 = 2.0 * v1()(2 + id3+in_);
	  val vt1_3 = 2.0 * v1()(3 + id3+in_);
	  val vt2_2 = 2.0 * v1()(2 + id4+in_);
	  val vt2_3 = 2.0 * v1()(3 + id4+in_);
	  val vt1_4 = 2.0 * v1()(4 + id3+in_);
	  val vt1_5 = 2.0 * v1()(5 + id3+in_);
	  val vt2_4 = 2.0 * v1()(4 + id4+in_);
	  val vt2_5 = 2.0 * v1()(5 + id4+in_);

	  for (ic in 0..(Ncol-1)) {
	    val ic2 = ic*Nvc;

	    val wt1r = u()(0+ic2+ig)*vt1_0 - u()(1+ic2+ig)*vt1_1
	    + u()(2+ic2+ig)*vt1_2 - u()(3+ic2+ig)*vt1_3
	    + u()(4+ic2+ig)*vt1_4 - u()(5+ic2+ig)*vt1_5;
	    val wt1i = u()(0+ic2+ig)*vt1_1 + u()(1+ic2+ig)*vt1_0
	    + u()(2+ic2+ig)*vt1_3 + u()(3+ic2+ig)*vt1_2
	    + u()(4+ic2+ig)*vt1_5 + u()(5+ic2+ig)*vt1_4;

	    val wt2r = u()(0+ic2+ig)*vt2_0 - u()(1+ic2+ig)*vt2_1
	    + u()(2+ic2+ig)*vt2_2 - u()(3+ic2+ig)*vt2_3
	    + u()(4+ic2+ig)*vt2_4 - u()(5+ic2+ig)*vt2_5;
	    val wt2i = u()(0+ic2+ig)*vt2_1 + u()(1+ic2+ig)*vt2_0
	    + u()(2+ic2+ig)*vt2_3 + u()(3+ic2+ig)*vt2_2
	    + u()(4+ic2+ig)*vt2_5 + u()(5+ic2+ig)*vt2_4;

	    v2()(2*ic   +id3+iv) +=  wt1r;
	    v2()(2*ic+1 +id3+iv) +=  wt1i;
	    v2()(2*ic   +id4+iv) +=  wt2r;
	    v2()(2*ic+1 +id4+iv) +=  wt2i;

	  }
	}
      }
    });

  }

  static def mult_tm_bulk(v2:PlaceLocalHandle[Rail[Double]], 
			  u:PlaceLocalHandle[Rail[Double]], 
			  v1:PlaceLocalHandle[Rail[Double]]) {

    val idir = 3;

    parallel(1..(Nt-1), (r:LongRange)=> {
      for (it_ in r) {

	val nn_ = it_ - 1;
	for(ixyz in 0..(Nx*Ny*Nz-1)){

	  val iv = Nvc*ND*(ixyz + it_*Nx*Ny*Nz);
	  val in_ = Nvc*ND*(ixyz + nn_*Nx*Ny*Nz);
	  val ig = Ndf*(ixyz + nn_*Nx*Ny*Nz + idir*Nst);

	  val vt1_0 = 2.0 * v1()(    id1+in_);
	  val vt1_1 = 2.0 * v1()(1 + id1+in_);
	  val vt2_0 = 2.0 * v1()(    id2+in_);
	  val vt2_1 = 2.0 * v1()(1 + id2+in_);
	  val vt1_2 = 2.0 * v1()(2 + id1+in_);
	  val vt1_3 = 2.0 * v1()(3 + id1+in_);
	  val vt2_2 = 2.0 * v1()(2 + id2+in_);
	  val vt2_3 = 2.0 * v1()(3 + id2+in_);
	  val vt1_4 = 2.0 * v1()(4 + id1+in_);
	  val vt1_5 = 2.0 * v1()(5 + id1+in_);
	  val vt2_4 = 2.0 * v1()(4 + id2+in_);
	  val vt2_5 = 2.0 * v1()(5 + id2+in_);

	  for(ic in 0..(Ncol-1)){
	    val icr = 2*ic;
	    val ici = 2*ic+1;
	    val ic1 = 0;
	    val ic2 = Nvc;
	    val ic3 = 2*Nvc;

	    val wt1r = u()(icr+ic1+ig)*vt1_0 + u()(ici+ic1+ig)*vt1_1
	    + u()(icr+ic2+ig)*vt1_2 + u()(ici+ic2+ig)*vt1_3
	    + u()(icr+ic3+ig)*vt1_4 + u()(ici+ic3+ig)*vt1_5;
	    val wt1i = u()(icr+ic1+ig)*vt1_1 - u()(ici+ic1+ig)*vt1_0
	    + u()(icr+ic2+ig)*vt1_3 - u()(ici+ic2+ig)*vt1_2
	    + u()(icr+ic3+ig)*vt1_5 - u()(ici+ic3+ig)*vt1_4;

	    val wt2r = u()(icr+ic1+ig)*vt2_0 + u()(ici+ic1+ig)*vt2_1
	    + u()(icr+ic2+ig)*vt2_2 + u()(ici+ic2+ig)*vt2_3
	    + u()(icr+ic3+ig)*vt2_4 + u()(ici+ic3+ig)*vt2_5;
	    val wt2i = u()(icr+ic1+ig)*vt2_1 - u()(ici+ic1+ig)*vt2_0
	    + u()(icr+ic2+ig)*vt2_3 - u()(ici+ic2+ig)*vt2_2
	    + u()(icr+ic3+ig)*vt2_5 - u()(ici+ic3+ig)*vt2_4;

	    v2()(icr +id1+iv) +=  wt1r;
	    v2()(ici +id1+iv) +=  wt1i;
	    v2()(icr +id2+iv) +=  wt2r;
	    v2()(ici +id2+iv) +=  wt2i;
	  }
	}
      }
    });

  }

}
