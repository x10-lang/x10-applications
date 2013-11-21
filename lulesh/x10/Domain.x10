import luleshtest;

public class Domain {
	/**************/
	/* Allocation */
	/**************/

	public def AllocateNodalPersistent(var size:Index_t)
	{
		m_x = new Rail[Real_t](size) ;
		m_y = new Rail[Real_t](size) ;
		m_z = new Rail[Real_t](size) ;

		m_xd = new Rail[Real_t](size) ;
		m_yd = new Rail[Real_t](size) ;
		m_zd = new Rail[Real_t](size) ;

		m_xdd = new Rail[Real_t](size) ;
		m_ydd = new Rail[Real_t](size) ;
		m_zdd = new Rail[Real_t](size) ;

		m_fx = new Rail[Real_t](size) ;
		m_fy = new Rail[Real_t](size) ;
		m_fz = new Rail[Real_t](size) ;

		m_nodalMass = new Rail[Real_t](size) ;
                
	}

	public def AllocateElemPersistent(var size:Index_t)
	{
		m_matElemlist = new Rail[Index_t](size) ;
		m_nodelist = new Array[Index_t]((0..(size-1)) * (0..7)) ;

		m_lxim = new Rail[Index_t](size) ;
		m_lxip = new Rail[Index_t](size) ;
		m_letam = new Rail[Index_t](size) ;
		m_letap = new Rail[Index_t](size) ;
		m_lzetam = new Rail[Index_t](size) ;
		m_lzetap = new Rail[Index_t](size) ;

		m_elemBC = new Rail[Int_t](size) ;

		m_e = new Rail[Real_t](size) ;

		m_p = new Rail[Real_t](size) ;
		m_q = new Rail[Real_t](size) ;
		m_ql = new Rail[Real_t](size) ;
		m_qq = new Rail[Real_t](size) ;

		m_v = new Rail[Real_t](size, 1) ;		
		m_volo = new Rail[Real_t](size) ;
		m_delv = new Rail[Real_t](size) ;
		m_vdov = new Rail[Real_t](size) ;

		m_arealg = new Rail[Real_t](size) ;
		
		m_ss = new Rail[Real_t](size) ;

		m_elemMass = new Rail[Real_t](size) ;
	}

	/* Temporaries should not be initialized in bulk but */
	/* this is a runnable placeholder for now */
	public def AllocateElemTemporary(var size:Index_t)
	{
		m_dxx = new Rail[Real_t](size) ;
		m_dyy = new Rail[Real_t](size) ;
		m_dzz = new Rail[Real_t](size) ;

		m_delv_xi = new Rail[Real_t](size) ;
		m_delv_eta = new Rail[Real_t](size) ;
		m_delv_zeta = new Rail[Real_t](size) ;

		m_delx_xi = new Rail[Real_t](size) ;
		m_delx_eta = new Rail[Real_t](size) ;
		m_delx_zeta = new Rail[Real_t](size) ;

		m_vnew = new Rail[Real_t](size) ;
	}

	public def AllocateNodesets(var size:Index_t)
	{
		m_symmX = new Rail[Index_t](size) ;
		m_symmY = new Rail[Index_t](size) ;
		m_symmZ = new Rail[Index_t](size) ;
	}	
	
  /**********/
  /* Access */
  /**********/

  /* Node-centered */

  public def x(var idx:Index_t):Real_t    { return m_x(idx) ; }
  public def y(var idx:Index_t):Real_t    { return m_y(idx) ; }
  public def z(var idx:Index_t):Real_t    { return m_z(idx) ; }
  
  public def xd(var idx:Index_t):Real_t    { return m_xd(idx) ; }
  public def yd(var idx:Index_t):Real_t    { return m_yd(idx) ; }
  public def zd(var idx:Index_t):Real_t    { return m_zd(idx) ; }
  
  public def xdd(var idx:Index_t):Real_t    { return m_xdd(idx) ; }
  public def ydd(var idx:Index_t):Real_t    { return m_ydd(idx) ; }
  public def zdd(var idx:Index_t):Real_t    { return m_zdd(idx) ; }

  public def fx(var idx:Index_t):Real_t    { return m_fx(idx) ; }
  public def fy(var idx:Index_t):Real_t    { return m_fy(idx) ; }
  public def fz(var idx:Index_t):Real_t    { return m_fz(idx) ; }
  
  public def nodalMass(var idx:Index_t):Real_t    { return m_nodalMass(idx) ; }
  
  public def symmX(var idx:Index_t):Index_t    { return m_symmX(idx) ; }
  public def symmY(var idx:Index_t):Index_t    { return m_symmY(idx) ; }
  public def symmZ(var idx:Index_t):Index_t    { return m_symmZ(idx) ; }

  /* Element-centered */
  
  public def matElemlist(var idx:Index_t):Index_t    { return m_matElemlist(idx) ; }
  public def nodelist():Array[Index_t]    { return m_nodelist ; } 
  
  public def lxim(var idx:Index_t):Index_t    { return m_lxim(idx) ; }
  public def lxip(var idx:Index_t):Index_t    { return m_lxip(idx) ; }
  public def letam(var idx:Index_t):Index_t    { return m_letam(idx) ; }
  public def letap(var idx:Index_t):Index_t    { return m_letap(idx) ; }
  public def lzetam(var idx:Index_t):Index_t    { return m_lzetam(idx) ; }
  public def lzetap(var idx:Index_t):Index_t    { return m_lzetap(idx) ; }
  
  public def elemBC(var idx:Index_t):Int_t    { return m_elemBC(idx) ; }
  
  public def dxx(var idx:Index_t):Real_t    { return m_dxx(idx) ; }
  public def dyy(var idx:Index_t):Real_t    { return m_dyy(idx) ; }
  public def dzz(var idx:Index_t):Real_t    { return m_dzz(idx) ; }
  
  public def delv_xi(var idx:Index_t):Real_t    { return m_delv_xi(idx) ; }
  public def delv_eta(var idx:Index_t):Real_t    { return m_delv_eta(idx) ; }
  public def delv_zeta(var idx:Index_t):Real_t    { return m_delv_zeta(idx) ; }
  
  public def delx_xi(var idx:Index_t):Real_t    { return m_delx_xi(idx) ; }
  public def delx_eta(var idx:Index_t):Real_t    { return m_delx_eta(idx) ; }
  public def delx_zeta(var idx:Index_t):Real_t    { return m_delx_zeta(idx) ; }
  
  public def e(var idx:Index_t):Real_t    { return m_e(idx) ; }
  
  public def p(var idx:Index_t):Real_t    { return m_p(idx) ; }
  public def q(var idx:Index_t):Real_t    { return m_q(idx) ; }
  public def ql(var idx:Index_t):Real_t    { return m_ql(idx) ; }
  public def qq(var idx:Index_t):Real_t    { return m_qq(idx) ; }
  
  public def v(var idx:Index_t):Real_t    { return m_v(idx) ; }
  public def volo(var idx:Index_t):Real_t    { return m_volo(idx) ; }
  public def vnew(var idx:Index_t):Real_t    { return m_vnew(idx) ; }
  public def delv(var idx:Index_t):Real_t    { return m_delv(idx) ; }
  public def vdov(var idx:Index_t):Real_t    { return m_vdov(idx) ; }
  
  public def arealg(var idx:Index_t):Real_t    { return m_arealg(idx) ; }
  
  public def ss(var idx:Index_t):Real_t    { return m_ss(idx) ; }
  
  public def elemMass(var idx:Index_t):Real_t    { return m_elemMass(idx) ; }

  /* Params */

  public def dtfixed():Real_t             { return m_dtfixed ; }
  public def time():Real_t                { return m_time ; }
  public def deltatime():Real_t           { return m_deltatime ; }
  public def deltatimemultlb():Real_t     { return m_deltatimemultlb ; }
  public def deltatimemultub():Real_t     { return m_deltatimemultub ; }
  public def stoptime():Real_t            { return m_stoptime ; }
  
  public def u_cut():Real_t               { return m_u_cut ; }
  public def hgcoef():Real_t              { return m_hgcoef ; }
  public def qstop():Real_t               { return m_qstop ; }
  public def monoq_max_slope():Real_t     { return m_monoq_max_slope ; }
  public def monoq_limiter_mult():Real_t  { return m_monoq_limiter_mult ; }
  public def e_cut():Real_t               { return m_e_cut ; }
  public def p_cut():Real_t               { return m_p_cut ; }
  public def ss4o3():Real_t               { return m_ss4o3 ; }
  public def q_cut():Real_t               { return m_q_cut ; }
  public def v_cut():Real_t               { return m_v_cut ; }
  public def qlc_monoq():Real_t           { return m_qlc_monoq ; }
  public def qqc_monoq():Real_t           { return m_qqc_monoq ; }
  public def qqc():Real_t                 { return m_qqc ; }
  public def eosvmax():Real_t             { return m_eosvmax ; }
  public def eosvmin():Real_t             { return m_eosvmin ; }
  public def pmin():Real_t                { return m_pmin ; }
  public def emin():Real_t                { return m_emin ; }
  public def dvovmax():Real_t             { return m_dvovmax ; }
  public def refdens():Real_t             { return m_refdens ; }
  
  public def dtcourant():Real_t           { return m_dtcourant ; }
  public def dthydro():Real_t             { return m_dthydro ; }
  public def dtmax():Real_t               { return m_dtmax ; }
  
  public def cycle():Int_t                { return m_cycle ; }
  
  public def sizeX():Index_t              { return m_sizeX ; }
  public def sizeY():Index_t              { return m_sizeY ; }
  public def sizeZ():Index_t              { return m_sizeZ ; }
  public def numElem():Index_t            { return m_numElem ; }
  public def numNode():Index_t            { return m_numNode ; }
  
  /******************/
  /* Implementation */
  /******************/

  /* Node-centered */
  
  var m_x:Rail[Real_t]; /* coordinates */
  var m_y:Rail[Real_t];
  var m_z:Rail[Real_t];
  
  var m_xd:Rail[Real_t]; /* velocities */
  var m_yd:Rail[Real_t];
  var m_zd:Rail[Real_t];
  
  var m_xdd:Rail[Real_t]; /* accelerations */
  var m_ydd:Rail[Real_t];
  var m_zdd:Rail[Real_t];
  
  var m_fx:Rail[Real_t]; /* forces */
  var m_fy:Rail[Real_t];
  var m_fz:Rail[Real_t];
  
  var m_nodalMass:Rail[Real_t]; /* mass */
  
  var m_symmX:Rail[Index_t]; /* symmetry plane nodesets */
  var m_symmY:Rail[Index_t];
  var m_symmZ:Rail[Index_t];

  /* Element-centered */
  
  var m_matElemlist:Rail[Index_t]; /* material indexset */
  var m_nodelist:Array[Index_t]; /* elemToNode connectivity */
  
  var m_lxim:Rail[Index_t]; /* element connectivity across each face */
  var m_lxip:Rail[Index_t];
  var m_letam:Rail[Index_t];
  var m_letap:Rail[Index_t];
  var m_lzetam:Rail[Index_t];
  var m_lzetap:Rail[Index_t];
  
  var m_elemBC:Rail[Int_t]; /* symmetry/free-surface flags for each elem face */
  
  var m_dxx:Rail[Real_t]; /* principal strains -- temporary */
  var m_dyy:Rail[Real_t];
  var m_dzz:Rail[Real_t];
  
  var m_delv_xi:Rail[Real_t]; /* velocity gradient -- temporary */
  var m_delv_eta:Rail[Real_t];
  var m_delv_zeta:Rail[Real_t];
  
  var m_delx_xi:Rail[Real_t]; /* coordinate gradient -- temporary */
  var m_delx_eta:Rail[Real_t];
  var m_delx_zeta:Rail[Real_t];
  
  var m_e:Rail[Real_t]; /* energy */
  
  var m_p:Rail[Real_t]; /* pressure */
  var m_q:Rail[Real_t]; /* q */
  var m_ql:Rail[Real_t]; /* linear term for q */
  var m_qq:Rail[Real_t]; /* quadratic term for q */
  
  var m_v:Rail[Real_t]; /* relative volume */
  var m_volo:Rail[Real_t]; /* reference volume */
  var m_vnew:Rail[Real_t]; /* new relative volume -- temporary */
  var m_delv:Rail[Real_t]; /* m_vnew - m_v */
  var m_vdov:Rail[Real_t]; /* volume derivative over volume */
  
  var m_arealg:Rail[Real_t]; /* characteristic length of an element */
  
  var m_ss:Rail[Real_t]; /* "sound speed" */
  
  var m_elemMass:Rail[Real_t]; /* mass */

  /* Parameters */
  var  m_dtfixed:Real_t;           /* fixed time increment */
  var  m_time:Real_t;              /* current time */
  var  m_deltatime:Real_t;         /* variable time increment */
  var  m_deltatimemultlb:Real_t;
  var  m_deltatimemultub:Real_t;
  var  m_stoptime:Real_t;          /* end time for simulation */

  var  m_u_cut:Real_t;             /* velocity tolerance */
  var  m_hgcoef:Real_t;            /* hourglass control */
  var  m_qstop:Real_t;             /* excessive q indicator */
  var  m_monoq_max_slope:Real_t;
  var  m_monoq_limiter_mult:Real_t;
  var  m_e_cut:Real_t;             /* energy tolerance */
  var  m_p_cut:Real_t;             /* pressure tolerance */
  var  m_ss4o3:Real_t;
  var  m_q_cut:Real_t;             /* q tolerance */
  var  m_v_cut:Real_t;             /* relative volume tolerance */
  var  m_qlc_monoq:Real_t;         /* linear term coef for q */
  var  m_qqc_monoq:Real_t;         /* quadratic term coef for q */
  var  m_qqc:Real_t;
  var  m_eosvmax:Real_t;
  var  m_eosvmin:Real_t;
  var  m_pmin:Real_t;              /* pressure floor */
  var  m_emin:Real_t;              /* energy floor */
  var  m_dvovmax:Real_t;           /* maximum allowable volume change */
  var  m_refdens:Real_t;           /* reference density */

  var  m_dtcourant:Real_t;         /* courant constraint */
  var  m_dthydro:Real_t;           /* volume change constraint */
  var  m_dtmax:Real_t;             /* maximum allowable time increment */

  var   m_cycle:Int_t;             /* iteration count for simulation */

  var   m_sizeX:Index_t;           /* X,Y,Z extent of this block */
  var   m_sizeY:Index_t;
  var   m_sizeZ:Index_t;

  var   m_numElem:Index_t;         /* Elements/Nodes in this domain */
  var   m_numNode:Index_t;
}
