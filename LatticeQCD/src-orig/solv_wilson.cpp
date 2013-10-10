/* ****************************************************** */
/*    Wilson fermion solver                               */
/*                                                        */
/*    This program is written in C-like manner, but       */
/*   using C++ functions.  Please compile by g++, or      */
/*   other C++ compiler.  [18 Apr 2009 HM]                */
/*                                                        */
/*                     Copyright(c) Hideo Matsufuru 2009  */
/* ****************************************************** */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <time.h>
#include <sys/time.h>

# define Nszx     8
# define Nszy     8
# define Nszz     8
# define Ntime   16
# define Nx      Nszx
# define Ny      Nszy
# define Nz      Nszz
# define Nt      Ntime
# define Nst     (Nx*Ny*Nz*Nt)
# define Ncol     3
# define Nvc     (Ncol*2)
# define Ndf     (Ncol*Ncol*2)
# define Ncp     (Ncol*Ncol)
# define ND       4
# define ND2      2
# define Nvst    (Nvc*ND*Nst)

# define CKs     0.150

// generate input values
#define MYRAND_MAX 		32767
static unsigned long myrand_next;

//timer
static double mult_mean_time = 0;

static int myrand(void);
static void mysrand(unsigned seed);
void qcd_init_random_conf(double* pU,int* pLx,int* pLy,int* pLz,int* pLt,int* pIx,int* pIy,int* pIz,int* pIt,int* pNpx,int* pNpy,int* pNpz,int* pNpt);

void solve_CG(double enorm, int &nconv, double &diff,
               double *xq, double *u, double *b);
void solve_CG_init(double &rrp, double &rr, double *u,
     double *x, double *r, double *s, double *p, double *v);
void solve_CG_step(double &rrp, double &rr, double *u,
     double *x, double *r, double *s, double *p, double *v);

void opr_DdagD(double *v, double *u, double *w);
void opr_D(double *v, double *u, double *w);
void opr_H(double *v, double *u, double *w);
void mult_xp(double *v2, double *u, double *v1);
void mult_xm(double *v2, double *u, double *v1);
void mult_yp(double *v2, double *u, double *v1);
void mult_ym(double *v2, double *u, double *v1);
void mult_zp(double *v2, double *u, double *v1);
void mult_zm(double *v2, double *u, double *v1);
void mult_tp(double *v2, double *u, double *v1);
void mult_tm(double *v2, double *u, double *v1);

void setunit(int nv, double *u);
void uinit(int istart, double *u);

void set_src(int ic, int id,
             int ix, int iy, int iz, int it, double *v);

void setconst(int nv, double *v, double a);
void vecprd(int nv, double &a, double *v1, double *v2);
void normv(int nv, double &a, double *v);
void selfadd(int nv, double *v1, double *v2, double a);
void selfsprd(int nv, double *v, double a);
void spx(int nv, double *v,  double *w, double a);
void equate(int nv, double *v, double *w);

double gettimeofday_sec();

//debug
void write_vector(double *v, int len);

inline int idx(int ivc, int id,
               int ix, int iy, int iz, int it){
  return ivc + id*Nvc
         + Nvc*ND*(ix + iy*Nx + iz*Nx*Ny + it*Nx*Ny*Nz);
}


/* ****************************************************** */

main(){

  int nc2 = Ncol;

  printf("Simple Wilson solver\n\n");

  printf("Nx = %3d, Nx = %3d, Nx = %3d, Nx = %3d\n",
                                       Nx, Ny, Nz, Nt);
  printf("CKs = %10.6f\n", CKs);

  double enorm = 1.E-16;
  printf("enorm = %12.4e\n", enorm);
  double diff;
  int nconv;

  double corr[Nt];
  for(int it=0; it<Nt; it++){
    corr[it] = 0.0;
  }

  double xq[Nvst];
  double bq[Nvst];
  // spinor field

  double u[Ndf*Nst*4];
  // link variable

  int istart = 3;
  uinit(istart, u);

  int Nvt = Nvc*ND*Nx*Ny*Nz;

  printf("  ic  id   nconv      diff\n");

  double mean_time = 0;

  for(int ic=0; ic<Ncol; ic++){
    for(int id=0; id<ND; id++){

      set_src(ic,id,0,0,0,0,bq);

      double start_time = gettimeofday_sec();
      solve_CG(enorm,nconv,diff,xq,u,bq);
      printf("cg: %f sec.\n", gettimeofday_sec() - start_time);
      mean_time += gettimeofday_sec() - start_time;


      printf(" %3d %3d  %6d %12.4e\n", ic, id, nconv, diff);

      for(int it=0; it<Nt; it++){
	double corrF;
	normv(Nvt,corrF,&xq[Nvt*it]);
	corr[it] += corrF;
      }

    }
  }

  printf("Ps meson correlator:\n");
  for(int it=0; it<Nt; it++){
    printf(" %6d   %16.8e\n", it, corr[it]);
  }

  printf("SolveWilson: %f sec\n", mean_time / (Ncol * ND));

}

/* ****************************************************** */
void solve_CG(double enorm, int &nconv, double &diff,
                       double *xq, double *u, double *b){

  static double x[Nvst], s[Nvst], r[Nvst], p[Nvst], v[Nvst];
  // double x[Nvst], s[Nvst], r[Nvst], p[Nvst], v[Nvst];

  int niter = 1000;

  equate(Nvst, s, b);
  double snorm, sr;
  normv(Nvst, sr, s);
  snorm = 1.0/sr;

  double rr, rrp;
  nconv = -1;

  solve_CG_init(rrp, rr, u, x, r, s, p, s);
  //  printf("  init: %22.15e\n", rr*snorm);

  for(int iter=0; iter < niter; iter++){

    solve_CG_step(rrp, rr, u, x, r, s, p, s);

    //    printf("%6d  %22.15e\n", iter, rr*snorm);

    if(rr*snorm < enorm){
      nconv = iter;
      break;
    }

  }

  if(nconv == -1){
    printf(" not converged\n");
  }

  printf("mult: %f sec\n", mult_mean_time);
  mult_mean_time = 0;

  //  printf("converged:\n");
  //  printf("  nconv = %d\n", nconv);

  equate(Nvst,xq,x);

  opr_DdagD(r,u,x);
  selfadd(Nvst,r,b,-1.0);
  normv(Nvst,diff,r);
  
}
/* ****************************************************** */
void solve_CG_init(double &rrp, double &rr, double *u,
     double *x, double *r, double *s, double *p, double *v){

  equate(Nvst,r,s);
  equate(Nvst,x,s);

  opr_DdagD(s,u,x);

  selfadd(Nvst,r,s,-1.0);
  equate(Nvst,p,r);

  double rrt;
  normv(Nvst,rrt,r);
  rr = rrt;
  rrp = rr;

}
/* ****************************************************** */
void solve_CG_step(double &rrp, double &rr, double *u,
     double *x, double *r, double *s, double *p, double *v){

  double cr, bk, pap;

  opr_DdagD(v,u,p);

  vecprd(Nvst,pap,v,p);
  cr = rrp/pap;

  selfadd(Nvst,x,p,cr);

  selfadd(Nvst,r,v,-cr);
  double rrt;
  normv(Nvst,rrt,r);
  rr=rrt;
  bk = rr/rrp;

  selfsprd(Nvst,p,bk);
  selfadd(Nvst,p,r,1.0);

  rrp = rr;

}
/* ****************************************************** */
void opr_DdagD(double *v, double *u, double *w){

  static double v2[Nvst];

  opr_H(v2,u,w );
  opr_H(v ,u,v2);

}
/* ****************************************************** */
void opr_D(double *v, double *u, double *w){

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
void opr_H(double *v, double *u, double *w){

  setconst(Nvst, v, 0.0);

  double start_time = gettimeofday_sec();
  mult_xp(v,u,w);
  mult_xm(v,u,w);
  mult_yp(v,u,w);
  mult_ym(v,u,w);
  mult_zp(v,u,w);
  mult_zm(v,u,w);
  mult_tp(v,u,w);
  mult_tm(v,u,w);
  mult_mean_time += gettimeofday_sec() - start_time;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;
 
  for(int ist=0; ist < Nst; ist++){
    int iv = ist*Nvc*ND;
   for(int ivc=0; ivc < Nvc; ivc++){
     double v3 = v[ivc+id3+iv];
     double v4 = v[ivc+id4+iv];
     v[ivc+id3+iv] = w[ivc+id1+iv] - CKs * v[ivc+id1+iv];
     v[ivc+id4+iv] = w[ivc+id2+iv] - CKs * v[ivc+id2+iv];
     v[ivc+id1+iv] = w[ivc+id3+iv] - CKs * v3;
     v[ivc+id2+iv] = w[ivc+id4+iv] - CKs * v4;
   }
  }

}
/* ****************************************************** */
void mult_xp(double *v2, double *u, double *v1){

  int idir = 0;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;

  int ix, nn;

  static double vt1[Nvc], vt2[Nvc];
  double wt1r, wt1i, wt2r, wt2i;

  // boundary part 
    ix = Nx-1;
    nn = 0;
    for(int iyzt=0; iyzt < (Ny*Nz*Nt); iyzt++){

    int iv = Nvc*ND*(ix + iyzt*Nx);
    int in = Nvc*ND*(nn + iyzt*Nx);
    int ig = Ndf*(ix + iyzt*Nx + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] - v1[2*ic+1 +id4+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] + v1[2*ic   +id4+in];
      vt2[2*ic  ] = v1[2*ic   +id2+in] - v1[2*ic+1 +id3+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] + v1[2*ic   +id3+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int ic2 = ic*Nvc;

      wt1r = u[0+ic2+ig]*vt1[0] - u[1+ic2+ig]*vt1[1]
           + u[2+ic2+ig]*vt1[2] - u[3+ic2+ig]*vt1[3]
           + u[4+ic2+ig]*vt1[4] - u[5+ic2+ig]*vt1[5];
      wt1i = u[0+ic2+ig]*vt1[1] + u[1+ic2+ig]*vt1[0]
           + u[2+ic2+ig]*vt1[3] + u[3+ic2+ig]*vt1[2]
           + u[4+ic2+ig]*vt1[5] + u[5+ic2+ig]*vt1[4];

      wt2r = u[0+ic2+ig]*vt2[0] - u[1+ic2+ig]*vt2[1]
           + u[2+ic2+ig]*vt2[2] - u[3+ic2+ig]*vt2[3]
           + u[4+ic2+ig]*vt2[4] - u[5+ic2+ig]*vt2[5];
      wt2i = u[0+ic2+ig]*vt2[1] + u[1+ic2+ig]*vt2[0]
           + u[2+ic2+ig]*vt2[3] + u[3+ic2+ig]*vt2[2]
           + u[4+ic2+ig]*vt2[5] + u[5+ic2+ig]*vt2[4];

      v2[2*ic   +id1+iv] =  wt1r;
      v2[2*ic+1 +id1+iv] =  wt1i;
      v2[2*ic   +id2+iv] =  wt2r;
      v2[2*ic+1 +id2+iv] =  wt2i;
      v2[2*ic   +id3+iv] =  wt2i;
      v2[2*ic+1 +id3+iv] = -wt2r;
      v2[2*ic   +id4+iv] =  wt1i;
      v2[2*ic+1 +id4+iv] = -wt1r;
    }
  }

  // bulk part 
  for(int iyzt=0; iyzt < (Ny*Nz*Nt); iyzt++){
   for(int ix=0; ix < (Nx-1); ix++){
      nn = ix+1;

    int iv = Nvc*ND*(ix + iyzt*Nx);
    int in = Nvc*ND*(nn + iyzt*Nx);
    int ig = Ndf*(ix + iyzt*Nx + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] - v1[2*ic+1 +id4+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] + v1[2*ic   +id4+in];
      vt2[2*ic  ] = v1[2*ic   +id2+in] - v1[2*ic+1 +id3+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] + v1[2*ic   +id3+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int ic2 = ic*Nvc;

      wt1r = u[0+ic2+ig]*vt1[0] - u[1+ic2+ig]*vt1[1]
           + u[2+ic2+ig]*vt1[2] - u[3+ic2+ig]*vt1[3]
           + u[4+ic2+ig]*vt1[4] - u[5+ic2+ig]*vt1[5];
      wt1i = u[0+ic2+ig]*vt1[1] + u[1+ic2+ig]*vt1[0]
           + u[2+ic2+ig]*vt1[3] + u[3+ic2+ig]*vt1[2]
           + u[4+ic2+ig]*vt1[5] + u[5+ic2+ig]*vt1[4];

      wt2r = u[0+ic2+ig]*vt2[0] - u[1+ic2+ig]*vt2[1]
           + u[2+ic2+ig]*vt2[2] - u[3+ic2+ig]*vt2[3]
           + u[4+ic2+ig]*vt2[4] - u[5+ic2+ig]*vt2[5];
      wt2i = u[0+ic2+ig]*vt2[1] + u[1+ic2+ig]*vt2[0]
           + u[2+ic2+ig]*vt2[3] + u[3+ic2+ig]*vt2[2]
           + u[4+ic2+ig]*vt2[5] + u[5+ic2+ig]*vt2[4];

      v2[2*ic   +id1+iv] =  wt1r;
      v2[2*ic+1 +id1+iv] =  wt1i;
      v2[2*ic   +id2+iv] =  wt2r;
      v2[2*ic+1 +id2+iv] =  wt2i;
      v2[2*ic   +id3+iv] =  wt2i;
      v2[2*ic+1 +id3+iv] = -wt2r;
      v2[2*ic   +id4+iv] =  wt1i;
      v2[2*ic+1 +id4+iv] = -wt1r;
    }
   }
  }

}

/* ****************************************************** */
void mult_xm(double *v2, double *u, double *v1){

  int idir = 0;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;

  int ix, nn;

  double vt1[Nvc], vt2[Nvc];
  double wt1r, wt1i, wt2r, wt2i;


  // boundary part 
    ix = 0;
    nn = Nx-1;
    for(int iyzt=0; iyzt<(Ny*Nz*Nt); iyzt++){

    int iv = Nvc*ND*(ix + iyzt*Nx);
    int in = Nvc*ND*(nn + iyzt*Nx);
    int ig = Ndf*(nn + iyzt*Nx + idir*Nst);

    for(int ic=0; ic<Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] + v1[2*ic+1 +id4+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] - v1[2*ic   +id4+in];

      vt2[2*ic  ] = v1[2*ic   +id2+in] + v1[2*ic+1 +id3+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] - v1[2*ic   +id3+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int icr = 2*ic;
      int ici = 2*ic+1;
      int ic1 = 0;
      int ic2 = Nvc;
      int ic3 = 2*Nvc;

      wt1r = u[icr+ic1+ig]*vt1[0] + u[ici+ic1+ig]*vt1[1]
           + u[icr+ic2+ig]*vt1[2] + u[ici+ic2+ig]*vt1[3]
           + u[icr+ic3+ig]*vt1[4] + u[ici+ic3+ig]*vt1[5];
      wt1i = u[icr+ic1+ig]*vt1[1] - u[ici+ic1+ig]*vt1[0]
           + u[icr+ic2+ig]*vt1[3] - u[ici+ic2+ig]*vt1[2]
           + u[icr+ic3+ig]*vt1[5] - u[ici+ic3+ig]*vt1[4];

      wt2r = u[icr+ic1+ig]*vt2[0] + u[ici+ic1+ig]*vt2[1]
           + u[icr+ic2+ig]*vt2[2] + u[ici+ic2+ig]*vt2[3]
           + u[icr+ic3+ig]*vt2[4] + u[ici+ic3+ig]*vt2[5];
      wt2i = u[icr+ic1+ig]*vt2[1] - u[ici+ic1+ig]*vt2[0]
           + u[icr+ic2+ig]*vt2[3] - u[ici+ic2+ig]*vt2[2]
           + u[icr+ic3+ig]*vt2[5] - u[ici+ic3+ig]*vt2[4];

      v2[icr +id1+iv] +=  wt1r;
      v2[ici +id1+iv] +=  wt1i;
      v2[icr +id2+iv] +=  wt2r;
      v2[ici +id2+iv] +=  wt2i;
      v2[icr +id3+iv] += -wt2i;
      v2[ici +id3+iv] += +wt2r;
      v2[icr +id4+iv] += -wt1i;
      v2[ici +id4+iv] += +wt1r;
    }
  }

  // bulk part 
  for(int iyzt=0; iyzt<Ny*Nz*Nt; iyzt++){
   for(int ix=1; ix<Nx; ix++){
      nn = ix-1;

    int iv = Nvc*ND*(ix + (iyzt)*Nx);
    int in = Nvc*ND*(nn + (iyzt)*Nx);
    int ig = Ndf*(nn + iyzt*Nx + idir*Nst);

    for(int ic=0; ic<Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] + v1[2*ic+1 +id4+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] - v1[2*ic   +id4+in];

      vt2[2*ic  ] = v1[2*ic   +id2+in] + v1[2*ic+1 +id3+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] - v1[2*ic   +id3+in];
    }

    for(int ic=0; ic<Ncol; ic++){
      int icr = 2*ic;
      int ici = 2*ic+1;
      int ic1 = 0;
      int ic2 = Nvc;
      int ic3 = 2*Nvc;

      wt1r = u[icr+ic1+ig]*vt1[0] + u[ici+ic1+ig]*vt1[1]
           + u[icr+ic2+ig]*vt1[2] + u[ici+ic2+ig]*vt1[3]
           + u[icr+ic3+ig]*vt1[4] + u[ici+ic3+ig]*vt1[5];
      wt1i = u[icr+ic1+ig]*vt1[1] - u[ici+ic1+ig]*vt1[0]
           + u[icr+ic2+ig]*vt1[3] - u[ici+ic2+ig]*vt1[2]
           + u[icr+ic3+ig]*vt1[5] - u[ici+ic3+ig]*vt1[4];

      wt2r = u[icr+ic1+ig]*vt2[0] + u[ici+ic1+ig]*vt2[1]
           + u[icr+ic2+ig]*vt2[2] + u[ici+ic2+ig]*vt2[3]
           + u[icr+ic3+ig]*vt2[4] + u[ici+ic3+ig]*vt2[5];
      wt2i = u[icr+ic1+ig]*vt2[1] - u[ici+ic1+ig]*vt2[0]
           + u[icr+ic2+ig]*vt2[3] - u[ici+ic2+ig]*vt2[2]
           + u[icr+ic3+ig]*vt2[5] - u[ici+ic3+ig]*vt2[4];

      v2[icr +id1+iv] +=  wt1r;
      v2[ici +id1+iv] +=  wt1i;
      v2[icr +id2+iv] +=  wt2r;
      v2[ici +id2+iv] +=  wt2i;
      v2[icr +id3+iv] += -wt2i;
      v2[ici +id3+iv] += +wt2r;
      v2[icr +id4+iv] += -wt1i;
      v2[ici +id4+iv] += +wt1r;
    }
   }
  }


}
/* ****************************************************** */
void mult_yp(double *v2, double *u, double *v1){

  int idir = 1;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;

  static double vt1[Nvc], vt2[Nvc];
  double wt1r, wt1i, wt2r, wt2i;

  // boundary part 
    int iy = Ny-1;
    int nn = 0;
   for(int izt=0; izt < (Nz*Nt); izt++){
    for(int ix=0; ix < Nx; ix++){

    int iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
    int in = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
    int ig = Ndf*(ix + iy*Nx + izt*Nx*Ny + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] + v1[2*ic   +id4+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] + v1[2*ic+1 +id4+in];
      vt2[2*ic  ] = v1[2*ic   +id2+in] - v1[2*ic   +id3+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] - v1[2*ic+1 +id3+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int ic2 = ic*Nvc;

      wt1r = u[0+ic2+ig]*vt1[0] - u[1+ic2+ig]*vt1[1]
           + u[2+ic2+ig]*vt1[2] - u[3+ic2+ig]*vt1[3]
           + u[4+ic2+ig]*vt1[4] - u[5+ic2+ig]*vt1[5];
      wt1i = u[0+ic2+ig]*vt1[1] + u[1+ic2+ig]*vt1[0]
           + u[2+ic2+ig]*vt1[3] + u[3+ic2+ig]*vt1[2]
           + u[4+ic2+ig]*vt1[5] + u[5+ic2+ig]*vt1[4];

      wt2r = u[0+ic2+ig]*vt2[0] - u[1+ic2+ig]*vt2[1]
           + u[2+ic2+ig]*vt2[2] - u[3+ic2+ig]*vt2[3]
           + u[4+ic2+ig]*vt2[4] - u[5+ic2+ig]*vt2[5];
      wt2i = u[0+ic2+ig]*vt2[1] + u[1+ic2+ig]*vt2[0]
           + u[2+ic2+ig]*vt2[3] + u[3+ic2+ig]*vt2[2]
           + u[4+ic2+ig]*vt2[5] + u[5+ic2+ig]*vt2[4];

      v2[2*ic   +id1+iv] +=  wt1r;
      v2[2*ic+1 +id1+iv] +=  wt1i;
      v2[2*ic   +id2+iv] +=  wt2r;
      v2[2*ic+1 +id2+iv] +=  wt2i;
      v2[2*ic   +id3+iv] += -wt2r;
      v2[2*ic+1 +id3+iv] += -wt2i;
      v2[2*ic   +id4+iv] +=  wt1r;
      v2[2*ic+1 +id4+iv] +=  wt1i;
    }
   }
  }

  // bulk part 
  for(int izt=0; izt < (Nz*Nt); izt++){
   for(int iy=0; iy < (Ny-1); iy++){
     int nn = iy + 1;
    for(int ix=0; ix < Nx; ix++){

    int iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
    int in = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
    int ig = Ndf*(ix + iy*Nx + izt*Nx*Ny + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] + v1[2*ic   +id4+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] + v1[2*ic+1 +id4+in];
      vt2[2*ic  ] = v1[2*ic   +id2+in] - v1[2*ic   +id3+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] - v1[2*ic+1 +id3+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int ic2 = ic*Nvc;

      wt1r = u[0+ic2+ig]*vt1[0] - u[1+ic2+ig]*vt1[1]
           + u[2+ic2+ig]*vt1[2] - u[3+ic2+ig]*vt1[3]
           + u[4+ic2+ig]*vt1[4] - u[5+ic2+ig]*vt1[5];
      wt1i = u[0+ic2+ig]*vt1[1] + u[1+ic2+ig]*vt1[0]
           + u[2+ic2+ig]*vt1[3] + u[3+ic2+ig]*vt1[2]
           + u[4+ic2+ig]*vt1[5] + u[5+ic2+ig]*vt1[4];

      wt2r = u[0+ic2+ig]*vt2[0] - u[1+ic2+ig]*vt2[1]
           + u[2+ic2+ig]*vt2[2] - u[3+ic2+ig]*vt2[3]
           + u[4+ic2+ig]*vt2[4] - u[5+ic2+ig]*vt2[5];
      wt2i = u[0+ic2+ig]*vt2[1] + u[1+ic2+ig]*vt2[0]
           + u[2+ic2+ig]*vt2[3] + u[3+ic2+ig]*vt2[2]
           + u[4+ic2+ig]*vt2[5] + u[5+ic2+ig]*vt2[4];

      v2[2*ic   +id1+iv] +=  wt1r;
      v2[2*ic+1 +id1+iv] +=  wt1i;
      v2[2*ic   +id2+iv] +=  wt2r;
      v2[2*ic+1 +id2+iv] +=  wt2i;
      v2[2*ic   +id3+iv] += -wt2r;
      v2[2*ic+1 +id3+iv] += -wt2i;
      v2[2*ic   +id4+iv] +=  wt1r;
      v2[2*ic+1 +id4+iv] +=  wt1i;
     }
    }
   }
  }

}

/* ****************************************************** */
void mult_ym(double *v2, double *u, double *v1){

  int idir = 1;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;

  double vt1[Nvc], vt2[Nvc];
  double wt1r, wt1i, wt2r, wt2i;


  // boundary part 
    int iy = 0;
    int nn = Ny-1;
   for(int izt=0; izt < (Nz*Nt); izt++){
    for(int ix=0; ix < Nx; ix++){

    int iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
    int in = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
    int ig = Ndf*(ix + nn*Nx + izt*Nx*Ny + idir*Nst);

    for(int ic=0; ic<Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] - v1[2*ic   +id4+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] - v1[2*ic+1 +id4+in];

      vt2[2*ic  ] = v1[2*ic   +id2+in] + v1[2*ic   +id3+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] + v1[2*ic+1 +id3+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int icr = 2*ic;
      int ici = 2*ic+1;
      int ic1 = 0;
      int ic2 = Nvc;
      int ic3 = 2*Nvc;

      wt1r = u[icr+ic1+ig]*vt1[0] + u[ici+ic1+ig]*vt1[1]
           + u[icr+ic2+ig]*vt1[2] + u[ici+ic2+ig]*vt1[3]
           + u[icr+ic3+ig]*vt1[4] + u[ici+ic3+ig]*vt1[5];
      wt1i = u[icr+ic1+ig]*vt1[1] - u[ici+ic1+ig]*vt1[0]
           + u[icr+ic2+ig]*vt1[3] - u[ici+ic2+ig]*vt1[2]
           + u[icr+ic3+ig]*vt1[5] - u[ici+ic3+ig]*vt1[4];

      wt2r = u[icr+ic1+ig]*vt2[0] + u[ici+ic1+ig]*vt2[1]
           + u[icr+ic2+ig]*vt2[2] + u[ici+ic2+ig]*vt2[3]
           + u[icr+ic3+ig]*vt2[4] + u[ici+ic3+ig]*vt2[5];
      wt2i = u[icr+ic1+ig]*vt2[1] - u[ici+ic1+ig]*vt2[0]
           + u[icr+ic2+ig]*vt2[3] - u[ici+ic2+ig]*vt2[2]
           + u[icr+ic3+ig]*vt2[5] - u[ici+ic3+ig]*vt2[4];

      v2[icr +id1+iv] +=  wt1r;
      v2[ici +id1+iv] +=  wt1i;
      v2[icr +id2+iv] +=  wt2r;
      v2[ici +id2+iv] +=  wt2i;
      v2[icr +id3+iv] +=  wt2r;
      v2[ici +id3+iv] +=  wt2i;
      v2[icr +id4+iv] += -wt1r;
      v2[ici +id4+iv] += -wt1i;
    }
   }
  }

  // bulk part 
  for(int izt=0; izt < (Nz*Nt); izt++){
   for(int iy=1; iy < Ny; iy++){
     int nn = iy - 1;
    for(int ix=0; ix < Nx; ix++){

    int iv = Nvc*ND*(ix + iy*Nx + izt*Nx*Ny);
    int in = Nvc*ND*(ix + nn*Nx + izt*Nx*Ny);
    int ig = Ndf*(ix + nn*Nx + izt*Nx*Ny + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] - v1[2*ic   +id4+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] - v1[2*ic+1 +id4+in];

      vt2[2*ic  ] = v1[2*ic   +id2+in] + v1[2*ic   +id3+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] + v1[2*ic+1 +id3+in];
    }

    for(int ic=0; ic<Ncol; ic++){
      int icr = 2*ic;
      int ici = 2*ic+1;
      int ic1 = 0;
      int ic2 = Nvc;
      int ic3 = 2*Nvc;

      wt1r = u[icr+ic1+ig]*vt1[0] + u[ici+ic1+ig]*vt1[1]
           + u[icr+ic2+ig]*vt1[2] + u[ici+ic2+ig]*vt1[3]
           + u[icr+ic3+ig]*vt1[4] + u[ici+ic3+ig]*vt1[5];
      wt1i = u[icr+ic1+ig]*vt1[1] - u[ici+ic1+ig]*vt1[0]
           + u[icr+ic2+ig]*vt1[3] - u[ici+ic2+ig]*vt1[2]
           + u[icr+ic3+ig]*vt1[5] - u[ici+ic3+ig]*vt1[4];

      wt2r = u[icr+ic1+ig]*vt2[0] + u[ici+ic1+ig]*vt2[1]
           + u[icr+ic2+ig]*vt2[2] + u[ici+ic2+ig]*vt2[3]
           + u[icr+ic3+ig]*vt2[4] + u[ici+ic3+ig]*vt2[5];
      wt2i = u[icr+ic1+ig]*vt2[1] - u[ici+ic1+ig]*vt2[0]
           + u[icr+ic2+ig]*vt2[3] - u[ici+ic2+ig]*vt2[2]
           + u[icr+ic3+ig]*vt2[5] - u[ici+ic3+ig]*vt2[4];

      v2[icr +id1+iv] +=  wt1r;
      v2[ici +id1+iv] +=  wt1i;
      v2[icr +id2+iv] +=  wt2r;
      v2[ici +id2+iv] +=  wt2i;
      v2[icr +id3+iv] +=  wt2r;
      v2[ici +id3+iv] +=  wt2i;
      v2[icr +id4+iv] += -wt1r;
      v2[ici +id4+iv] += -wt1i;
     }
    }
   }
  }


}
/* ****************************************************** */
void mult_zp(double *v2, double *u, double *v1){

  int idir = 2;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;

  static double vt1[Nvc], vt2[Nvc];
  double wt1r, wt1i, wt2r, wt2i;

  // boundary part 
    int iz = Nz-1;
    int nn = 0;
   for(int it=0; it < Nt; it++){
     for(int ixy=0; ixy < (Nx*Ny); ixy++){

    int iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
    int in = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
    int ig = Ndf*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] - v1[2*ic+1 +id3+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] + v1[2*ic   +id3+in];
      vt2[2*ic  ] = v1[2*ic   +id2+in] + v1[2*ic+1 +id4+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] - v1[2*ic   +id4+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int ic2 = ic*Nvc;

      wt1r = u[0+ic2+ig]*vt1[0] - u[1+ic2+ig]*vt1[1]
           + u[2+ic2+ig]*vt1[2] - u[3+ic2+ig]*vt1[3]
           + u[4+ic2+ig]*vt1[4] - u[5+ic2+ig]*vt1[5];
      wt1i = u[0+ic2+ig]*vt1[1] + u[1+ic2+ig]*vt1[0]
           + u[2+ic2+ig]*vt1[3] + u[3+ic2+ig]*vt1[2]
           + u[4+ic2+ig]*vt1[5] + u[5+ic2+ig]*vt1[4];

      wt2r = u[0+ic2+ig]*vt2[0] - u[1+ic2+ig]*vt2[1]
           + u[2+ic2+ig]*vt2[2] - u[3+ic2+ig]*vt2[3]
           + u[4+ic2+ig]*vt2[4] - u[5+ic2+ig]*vt2[5];
      wt2i = u[0+ic2+ig]*vt2[1] + u[1+ic2+ig]*vt2[0]
           + u[2+ic2+ig]*vt2[3] + u[3+ic2+ig]*vt2[2]
           + u[4+ic2+ig]*vt2[5] + u[5+ic2+ig]*vt2[4];

      v2[2*ic   +id1+iv] +=  wt1r;
      v2[2*ic+1 +id1+iv] +=  wt1i;
      v2[2*ic   +id2+iv] +=  wt2r;
      v2[2*ic+1 +id2+iv] +=  wt2i;
      v2[2*ic   +id3+iv] +=  wt1i;
      v2[2*ic+1 +id3+iv] += -wt1r;
      v2[2*ic   +id4+iv] += -wt2i;
      v2[2*ic+1 +id4+iv] +=  wt2r;
    }
   }
  }

  // bulk part 
  for(int it=0; it < Nt; it++){
   for(int iz=0; iz < (Nz-1); iz++){
      int nn = iz + 1;
    for(int ixy=0; ixy < (Nx*Ny); ixy++){

    int iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
    int in = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
    int ig = Ndf*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] - v1[2*ic+1 +id3+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] + v1[2*ic   +id3+in];
      vt2[2*ic  ] = v1[2*ic   +id2+in] + v1[2*ic+1 +id4+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] - v1[2*ic   +id4+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int ic2 = ic*Nvc;

      wt1r = u[0+ic2+ig]*vt1[0] - u[1+ic2+ig]*vt1[1]
           + u[2+ic2+ig]*vt1[2] - u[3+ic2+ig]*vt1[3]
           + u[4+ic2+ig]*vt1[4] - u[5+ic2+ig]*vt1[5];
      wt1i = u[0+ic2+ig]*vt1[1] + u[1+ic2+ig]*vt1[0]
           + u[2+ic2+ig]*vt1[3] + u[3+ic2+ig]*vt1[2]
           + u[4+ic2+ig]*vt1[5] + u[5+ic2+ig]*vt1[4];

      wt2r = u[0+ic2+ig]*vt2[0] - u[1+ic2+ig]*vt2[1]
           + u[2+ic2+ig]*vt2[2] - u[3+ic2+ig]*vt2[3]
           + u[4+ic2+ig]*vt2[4] - u[5+ic2+ig]*vt2[5];
      wt2i = u[0+ic2+ig]*vt2[1] + u[1+ic2+ig]*vt2[0]
           + u[2+ic2+ig]*vt2[3] + u[3+ic2+ig]*vt2[2]
           + u[4+ic2+ig]*vt2[5] + u[5+ic2+ig]*vt2[4];

      v2[2*ic   +id1+iv] +=  wt1r;
      v2[2*ic+1 +id1+iv] +=  wt1i;
      v2[2*ic   +id2+iv] +=  wt2r;
      v2[2*ic+1 +id2+iv] +=  wt2i;
      v2[2*ic   +id3+iv] +=  wt1i;
      v2[2*ic+1 +id3+iv] += -wt1r;
      v2[2*ic   +id4+iv] += -wt2i;
      v2[2*ic+1 +id4+iv] +=  wt2r;
     }
    }
   }
  }

}
/* ****************************************************** */
void mult_zm(double *v2, double *u, double *v1){

  int idir = 2;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;

  double vt1[Nvc], vt2[Nvc];
  double wt1r, wt1i, wt2r, wt2i;


  // boundary part 
    int iz = 0;
    int nn = Nz-1;
   for(int it=0; it < Nt; it++){
    for(int ixy=0; ixy < (Nx*Ny); ixy++){

    int iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
    int in = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
    int ig = Ndf*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] + v1[2*ic+1 +id3+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] - v1[2*ic   +id3+in];
      vt2[2*ic  ] = v1[2*ic   +id2+in] - v1[2*ic+1 +id4+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] + v1[2*ic   +id4+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int icr = 2*ic;
      int ici = 2*ic+1;
      int ic1 = 0;
      int ic2 = Nvc;
      int ic3 = 2*Nvc;

      wt1r = u[icr+ic1+ig]*vt1[0] + u[ici+ic1+ig]*vt1[1]
           + u[icr+ic2+ig]*vt1[2] + u[ici+ic2+ig]*vt1[3]
           + u[icr+ic3+ig]*vt1[4] + u[ici+ic3+ig]*vt1[5];
      wt1i = u[icr+ic1+ig]*vt1[1] - u[ici+ic1+ig]*vt1[0]
           + u[icr+ic2+ig]*vt1[3] - u[ici+ic2+ig]*vt1[2]
           + u[icr+ic3+ig]*vt1[5] - u[ici+ic3+ig]*vt1[4];

      wt2r = u[icr+ic1+ig]*vt2[0] + u[ici+ic1+ig]*vt2[1]
           + u[icr+ic2+ig]*vt2[2] + u[ici+ic2+ig]*vt2[3]
           + u[icr+ic3+ig]*vt2[4] + u[ici+ic3+ig]*vt2[5];
      wt2i = u[icr+ic1+ig]*vt2[1] - u[ici+ic1+ig]*vt2[0]
           + u[icr+ic2+ig]*vt2[3] - u[ici+ic2+ig]*vt2[2]
           + u[icr+ic3+ig]*vt2[5] - u[ici+ic3+ig]*vt2[4];

      v2[icr +id1+iv] +=  wt1r;
      v2[ici +id1+iv] +=  wt1i;
      v2[icr +id2+iv] +=  wt2r;
      v2[ici +id2+iv] +=  wt2i;
      v2[icr +id3+iv] += -wt1i;
      v2[ici +id3+iv] +=  wt1r;
      v2[icr +id4+iv] +=  wt2i;
      v2[ici +id4+iv] += -wt2r;
    }
   }
  }

  // bulk part 
  for(int it=0; it < Nt; it++){
   for(int iz=1; iz < Nz; iz++){
      int nn = iz - 1;
    for(int ixy=0; ixy < (Nx*Ny); ixy++){

    int iv = Nvc*ND*(ixy + iz*Nx*Ny + it*Nx*Ny*Nz);
    int in = Nvc*ND*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz);
    int ig = Ndf*(ixy + nn*Nx*Ny + it*Nx*Ny*Nz + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = v1[2*ic   +id1+in] + v1[2*ic+1 +id3+in];
      vt1[2*ic+1] = v1[2*ic+1 +id1+in] - v1[2*ic   +id3+in];
      vt2[2*ic  ] = v1[2*ic   +id2+in] - v1[2*ic+1 +id4+in];
      vt2[2*ic+1] = v1[2*ic+1 +id2+in] + v1[2*ic   +id4+in];
    }

    for(int ic=0; ic<Ncol; ic++){
      int icr = 2*ic;
      int ici = 2*ic+1;
      int ic1 = 0;
      int ic2 = Nvc;
      int ic3 = 2*Nvc;

      wt1r = u[icr+ic1+ig]*vt1[0] + u[ici+ic1+ig]*vt1[1]
           + u[icr+ic2+ig]*vt1[2] + u[ici+ic2+ig]*vt1[3]
           + u[icr+ic3+ig]*vt1[4] + u[ici+ic3+ig]*vt1[5];
      wt1i = u[icr+ic1+ig]*vt1[1] - u[ici+ic1+ig]*vt1[0]
           + u[icr+ic2+ig]*vt1[3] - u[ici+ic2+ig]*vt1[2]
           + u[icr+ic3+ig]*vt1[5] - u[ici+ic3+ig]*vt1[4];

      wt2r = u[icr+ic1+ig]*vt2[0] + u[ici+ic1+ig]*vt2[1]
           + u[icr+ic2+ig]*vt2[2] + u[ici+ic2+ig]*vt2[3]
           + u[icr+ic3+ig]*vt2[4] + u[ici+ic3+ig]*vt2[5];
      wt2i = u[icr+ic1+ig]*vt2[1] - u[ici+ic1+ig]*vt2[0]
           + u[icr+ic2+ig]*vt2[3] - u[ici+ic2+ig]*vt2[2]
           + u[icr+ic3+ig]*vt2[5] - u[ici+ic3+ig]*vt2[4];

      v2[icr +id1+iv] +=  wt1r;
      v2[ici +id1+iv] +=  wt1i;
      v2[icr +id2+iv] +=  wt2r;
      v2[ici +id2+iv] +=  wt2i;
      v2[icr +id3+iv] += -wt1i;
      v2[ici +id3+iv] +=  wt1r;
      v2[icr +id4+iv] +=  wt2i;
      v2[ici +id4+iv] += -wt2r;
     }
    }
   }
  }

}
/* ****************************************************** */
void mult_tp(double *v2, double *u, double *v1){

  int idir = 3;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;

  static double vt1[Nvc], vt2[Nvc];
  double wt1r, wt1i, wt2r, wt2i;

  // boundary part 
    int it = Nt-1;
    int nn = 0;
   for(int ixyz=0; ixyz < (Nx*Ny*Nz); ixyz++){

    int iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
    int in = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
    int ig = Ndf*(ixyz + it*Nx*Ny*Nz + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = 2.0 * v1[2*ic   +id3+in];
      vt1[2*ic+1] = 2.0 * v1[2*ic+1 +id3+in];
      vt2[2*ic  ] = 2.0 * v1[2*ic   +id4+in];
      vt2[2*ic+1] = 2.0 * v1[2*ic+1 +id4+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int ic2 = ic*Nvc;

      wt1r = u[0+ic2+ig]*vt1[0] - u[1+ic2+ig]*vt1[1]
           + u[2+ic2+ig]*vt1[2] - u[3+ic2+ig]*vt1[3]
           + u[4+ic2+ig]*vt1[4] - u[5+ic2+ig]*vt1[5];
      wt1i = u[0+ic2+ig]*vt1[1] + u[1+ic2+ig]*vt1[0]
           + u[2+ic2+ig]*vt1[3] + u[3+ic2+ig]*vt1[2]
           + u[4+ic2+ig]*vt1[5] + u[5+ic2+ig]*vt1[4];

      wt2r = u[0+ic2+ig]*vt2[0] - u[1+ic2+ig]*vt2[1]
           + u[2+ic2+ig]*vt2[2] - u[3+ic2+ig]*vt2[3]
           + u[4+ic2+ig]*vt2[4] - u[5+ic2+ig]*vt2[5];
      wt2i = u[0+ic2+ig]*vt2[1] + u[1+ic2+ig]*vt2[0]
           + u[2+ic2+ig]*vt2[3] + u[3+ic2+ig]*vt2[2]
           + u[4+ic2+ig]*vt2[5] + u[5+ic2+ig]*vt2[4];

      v2[2*ic   +id3+iv] +=  wt1r;
      v2[2*ic+1 +id3+iv] +=  wt1i;
      v2[2*ic   +id4+iv] +=  wt2r;
      v2[2*ic+1 +id4+iv] +=  wt2i;
    }
  }

  // bulk part 
  for(int it=0; it < (Nt-1); it++){
      int nn = it + 1;
   for(int ixyz=0; ixyz < (Nx*Ny*Nz); ixyz++){

    int iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
    int in = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
    int ig = Ndf*(ixyz + it*Nx*Ny*Nz + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = 2.0 * v1[2*ic   +id3+in];
      vt1[2*ic+1] = 2.0 * v1[2*ic+1 +id3+in];
      vt2[2*ic  ] = 2.0 * v1[2*ic   +id4+in];
      vt2[2*ic+1] = 2.0 * v1[2*ic+1 +id4+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int ic2 = ic*Nvc;

      wt1r = u[0+ic2+ig]*vt1[0] - u[1+ic2+ig]*vt1[1]
           + u[2+ic2+ig]*vt1[2] - u[3+ic2+ig]*vt1[3]
           + u[4+ic2+ig]*vt1[4] - u[5+ic2+ig]*vt1[5];
      wt1i = u[0+ic2+ig]*vt1[1] + u[1+ic2+ig]*vt1[0]
           + u[2+ic2+ig]*vt1[3] + u[3+ic2+ig]*vt1[2]
           + u[4+ic2+ig]*vt1[5] + u[5+ic2+ig]*vt1[4];

      wt2r = u[0+ic2+ig]*vt2[0] - u[1+ic2+ig]*vt2[1]
           + u[2+ic2+ig]*vt2[2] - u[3+ic2+ig]*vt2[3]
           + u[4+ic2+ig]*vt2[4] - u[5+ic2+ig]*vt2[5];
      wt2i = u[0+ic2+ig]*vt2[1] + u[1+ic2+ig]*vt2[0]
           + u[2+ic2+ig]*vt2[3] + u[3+ic2+ig]*vt2[2]
           + u[4+ic2+ig]*vt2[5] + u[5+ic2+ig]*vt2[4];

      v2[2*ic   +id3+iv] +=  wt1r;
      v2[2*ic+1 +id3+iv] +=  wt1i;
      v2[2*ic   +id4+iv] +=  wt2r;
      v2[2*ic+1 +id4+iv] +=  wt2i;
    }
   }
  }

}
/* ****************************************************** */
void mult_tm(double *v2, double *u, double *v1){

  int idir = 3;

  int id1 = 0;
  int id2 = Nvc;
  int id3 = Nvc*2;
  int id4 = Nvc*3;

  double vt1[Nvc], vt2[Nvc];
  double wt1r, wt1i, wt2r, wt2i;


  // boundary part 
    int it = 0;
    int nn = Nt-1;
   for(int ixyz=0; ixyz < (Nx*Ny*Nz); ixyz++){

    int iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
    int in = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
    int ig = Ndf*(ixyz + nn*Nx*Ny*Nz + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = 2.0 * v1[2*ic   +id1+in];
      vt1[2*ic+1] = 2.0 * v1[2*ic+1 +id1+in];
      vt2[2*ic  ] = 2.0 * v1[2*ic   +id2+in];
      vt2[2*ic+1] = 2.0 * v1[2*ic+1 +id2+in];
    }

    for(int ic=0; ic < Ncol; ic++){
      int icr = 2*ic;
      int ici = 2*ic+1;
      int ic1 = 0;
      int ic2 = Nvc;
      int ic3 = 2*Nvc;

      wt1r = u[icr+ic1+ig]*vt1[0] + u[ici+ic1+ig]*vt1[1]
           + u[icr+ic2+ig]*vt1[2] + u[ici+ic2+ig]*vt1[3]
           + u[icr+ic3+ig]*vt1[4] + u[ici+ic3+ig]*vt1[5];
      wt1i = u[icr+ic1+ig]*vt1[1] - u[ici+ic1+ig]*vt1[0]
           + u[icr+ic2+ig]*vt1[3] - u[ici+ic2+ig]*vt1[2]
           + u[icr+ic3+ig]*vt1[5] - u[ici+ic3+ig]*vt1[4];

      wt2r = u[icr+ic1+ig]*vt2[0] + u[ici+ic1+ig]*vt2[1]
           + u[icr+ic2+ig]*vt2[2] + u[ici+ic2+ig]*vt2[3]
           + u[icr+ic3+ig]*vt2[4] + u[ici+ic3+ig]*vt2[5];
      wt2i = u[icr+ic1+ig]*vt2[1] - u[ici+ic1+ig]*vt2[0]
           + u[icr+ic2+ig]*vt2[3] - u[ici+ic2+ig]*vt2[2]
           + u[icr+ic3+ig]*vt2[5] - u[ici+ic3+ig]*vt2[4];

      v2[icr +id1+iv] +=  wt1r;
      v2[ici +id1+iv] +=  wt1i;
      v2[icr +id2+iv] +=  wt2r;
      v2[ici +id2+iv] +=  wt2i;
    }
  }

  // bulk part 
  for(int it=1; it < Nt; it++){
      int nn = it - 1;
   for(int ixyz=0; ixyz < (Nx*Ny*Nz); ixyz++){

    int iv = Nvc*ND*(ixyz + it*Nx*Ny*Nz);
    int in = Nvc*ND*(ixyz + nn*Nx*Ny*Nz);
    int ig = Ndf*(ixyz + nn*Nx*Ny*Nz + idir*Nst);

    for(int ic=0; ic < Ncol; ic++){
      vt1[2*ic  ] = 2.0 * v1[2*ic   +id1+in];
      vt1[2*ic+1] = 2.0 * v1[2*ic+1 +id1+in];
      vt2[2*ic  ] = 2.0 * v1[2*ic   +id2+in];
      vt2[2*ic+1] = 2.0 * v1[2*ic+1 +id2+in];
    }

    for(int ic=0; ic<Ncol; ic++){
      int icr = 2*ic;
      int ici = 2*ic+1;
      int ic1 = 0;
      int ic2 = Nvc;
      int ic3 = 2*Nvc;

      wt1r = u[icr+ic1+ig]*vt1[0] + u[ici+ic1+ig]*vt1[1]
           + u[icr+ic2+ig]*vt1[2] + u[ici+ic2+ig]*vt1[3]
           + u[icr+ic3+ig]*vt1[4] + u[ici+ic3+ig]*vt1[5];
      wt1i = u[icr+ic1+ig]*vt1[1] - u[ici+ic1+ig]*vt1[0]
           + u[icr+ic2+ig]*vt1[3] - u[ici+ic2+ig]*vt1[2]
           + u[icr+ic3+ig]*vt1[5] - u[ici+ic3+ig]*vt1[4];

      wt2r = u[icr+ic1+ig]*vt2[0] + u[ici+ic1+ig]*vt2[1]
           + u[icr+ic2+ig]*vt2[2] + u[ici+ic2+ig]*vt2[3]
           + u[icr+ic3+ig]*vt2[4] + u[ici+ic3+ig]*vt2[5];
      wt2i = u[icr+ic1+ig]*vt2[1] - u[ici+ic1+ig]*vt2[0]
           + u[icr+ic2+ig]*vt2[3] - u[ici+ic2+ig]*vt2[2]
           + u[icr+ic3+ig]*vt2[5] - u[ici+ic3+ig]*vt2[4];

      v2[icr +id1+iv] +=  wt1r;
      v2[ici +id1+iv] +=  wt1i;
      v2[icr +id2+iv] +=  wt2r;
      v2[ici +id2+iv] +=  wt2i;
     }
   }
  }

}
/* ****************************************************** */
void set_src(int ic, int id,
              int ix, int iy, int iz, int it, double *v){

  setconst(Nvst, v, 0.0);

  int i = 2*ic + id*Nvc + Nvc*ND*(ix + iy*Nszx
                        + iz*Nszx*Nszy + it*Nszx*Nszy*Nszz);

  v[i]=1.0;

}
/* ****************************************************** */
void uinit(int istart, double *u){


 if(istart > 2){  // read from file

  FILE *fp;
  fp = fopen("../conf_08080816.txt","r");

  //    for(int i=0; i < Ndf*Nst*4; i++){
  //    fscanf(fp, "%lf",&u[i]);
  //    }

  for(int ist=0; ist < Nst; ist++){
   for(int idir=0; idir < 4; idir++){
    for(int idf=0; idf < Ndf; idf++){
      int i = idf + ist*Ndf + idir*Ndf*Nst;
      fscanf(fp, "%lf",&u[i]);

    }
   }
  }

  fclose(fp);

#if 0
  int nx = Nx;
  int ny = Ny;
  int nz = Nz;
  int nt = Nt;
  int ix = 0;
  int iy = 0;
  int iz = 0;
  int it = 0;
  int npx = 1;
  int npy = 1;
  int npz = 1;
  int npt = 1;

  qcd_init_random_conf(u, &nx, &ny, &nz, &nt, &ix, &iy, &iz, &it, &npx, &npy, &npz, &npt);
#endif

 }else{  // free field

   setunit(Nst*4,u);

 }

}
/* ****************************************************** */
void setunit(int nv, double *u){

  int is;

  for(int i=0; i < nv; i++){

    is = Ndf*i;

    u[   is] = 1.0;   u[ 1+is] = 0.0;
    u[ 2+is] = 0.0;   u[ 3+is] = 0.0;
    u[ 4+is] = 0.0;   u[ 5+is] = 0.0;

    u[ 6+is] = 0.0;   u[ 7+is] = 0.0;
    u[ 8+is] = 1.0;   u[ 9+is] = 0.0;
    u[10+is] = 0.0;   u[11+is] = 0.0;

    u[12+is] = 0.0;   u[13+is] = 0.0;
    u[14+is] = 0.0;   u[15+is] = 0.0;
    u[16+is] = 1.0;   u[17+is] = 0.0;

  }

}
/* ****************************************************** */
void setconst(int nv, double *v, double a){

  for(int i=0; i < nv; i++){
    v[i] = a;
  }

}
/* ****************************************************** */
void vecprd(int nv, double &a, double *v1, double *v2){

  a = 0.0;
  for(int i=0; i < nv; i++){
    a = a + v1[i]*v2[i];
  }

}
/* ****************************************************** */
void normv(int nv, double &a, double *v){

  a = 0.0;
  for(int i=0; i < nv; i++){
    a = a + v[i]*v[i];
  }

}
/* ****************************************************** */
void selfadd(int nv, double *v, double *w, double a){

  for(int i=0; i < nv; i++){
    v[i] = v[i] + a * w[i];
  }

}
/* ****************************************************** */
void selfsprd(int nv, double *v, double a){

  for(int i=0; i < nv; i++){
    v[i] = a * v[i];
  }

}
/* ****************************************************** */
void spx(int nv, double *v,  double *w, double a){

  for(int i=0; i < nv; i++){
    v[i] = a * v[i] + w[i];
  }

}
/* ****************************************************** */
void equate(int nv, double *v,  double *w){

  for(int i=0; i < nv; i++){
    v[i] = w[i];
  }

}
/* ****************************************************** */

double gettimeofday_sec()
{
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec + tv.tv_usec * 1e-6;
}

/* ****************************************************** */

// for debug
void write_vector(double *v, int len){

  FILE *fp;
  int i;
  if((fp = fopen("c_vector", "w")) != NULL){
    for (i = 0; i < len; i++) {
      if (fprintf(fp, "%E\n", v[i]) < 0){
	break;
      }
    }
    fclose(fp);
  }else {
    printf("error in opening file.\n");
    exit(1);
  }

}

static int myrand(void)
{
	myrand_next = myrand_next * 1103515245 + 12345;
	return((unsigned)(myrand_next/65536) % 32768);
}

static void mysrand(unsigned seed) 
{
	myrand_next = seed;
}



void qcd_init_random_conf(double* pU,int* pLx,int* pLy,int* pLz,int* pLt,int* pIx,int* pIy,int* pIz,int* pIt,int* pNpx,int* pNpy,int* pNpz,int* pNpt)
{
	int i,j,x,y,z,t,is,d;
	int sx,sy,sz,st;
	int ex,ey,ez,et;
	double dt;

	sx = ((*pIx) * (*pLx)) / (*pNpx);
	ex = ((*pIx + 1) * (*pLx)) / (*pNpx);
	sy = ((*pIy) * (*pLy)) / (*pNpy);
	ey = ((*pIy + 1) * (*pLy)) / (*pNpy);
	sz = ((*pIz) * (*pLz)) / (*pNpz);
	ez = ((*pIz + 1) * (*pLz)) / (*pNpz);
	st = ((*pIt) * (*pLt)) / (*pNpt);
	et = ((*pIt + 1) * (*pLt)) / (*pNpt);

	mysrand(100);

	d = 0;
	is = 0;
	for(i=0;i<4;i++){
		for(t=0;t<*pLt;t++){
			for(z=0;z<*pLz;z++){
				for(y=0;y<*pLy;y++){
					for(x=0;x<*pLx;x++){
						if((x >= sx && x < ex) && (y >= sy && y < ey) && (z >= sz && z < ez) && (t >= st && t < et)){
							for(j=0;j<9;j++){
//								pU[is++] = 			 (1.0*(QCDReal)myrand()/(QCDReal)MYRAND_MAX - 0.5) +
//										_Complex_I * (1.0*(QCDReal)myrand()/(QCDReal)MYRAND_MAX - 0.5);
								//pU[is] = (1.0*(QCDReal)myrand()/(QCDReal)MYRAND_MAX - 0.5);
								//is++;
								dt = 2.0*(double)myrand()/(double)MYRAND_MAX;
								pU[is++] = dt - 1.0;
								dt = 2.0*(double)myrand()/(double)MYRAND_MAX;
								pU[is++] = dt - 1.0;
							}
						}
						else{
							for(j=0;j<9;j++){
								d += myrand();
								d += myrand();
							}
						}
					}
				}
			}
		}
	}

	mysrand(d);
}


