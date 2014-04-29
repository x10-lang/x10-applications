/***********************************************************************************/
/* This version is an enhanced C code from advance_C_translated_by_ROSE.c with     */
/* simpler array subscripts.                                                       */
/* All arrays are linearized single-dimensional arrays in C                        */
/***********************************************************************************/

#define min(a,b) (((a)<(b))?(a):(b))
#define max(a,b) (((a)>(b))?(a):(b))
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <float.h>
void ctoprim_(int *lo,int *hi,int *ng, double *u,double *q,double *dx,double *courno)
{
  int i;
  int j;
  int k;
  double c;
  double eint;
  double courx;
  double coury;
  double courz;
  double courmx;
  double courmy;
  double courmz;
  double rhoinv;
  double dx1inv;
  double dx2inv;
  double dx3inv;
  double CVinv;
  double GAMMA = 1.4e0;
  double CV = 8.3333333333e6;
  //printf("Running ctoprim in C version !!\n");
/* !    type(bl_prof_timer), save :: bpt_ctoprim, bpt_ctoprim_loop1, bpt_ctoprim_loop2 */
/* !    call build(bpt_ctoprim, "bpt_ctoprim") */
  CVinv = 1.0e0 / CV;
  int iLowerBound = (lo[0] -  *ng);
  int jLowerBound = (lo[1] -  *ng);
  int kLowerBound = (lo[2] -  *ng);
  int iUpperBound = (hi[0] +  *ng);
  int jUpperBound = (hi[1] +  *ng);
  int kUpperBound = (hi[2] +  *ng);
  int iSize = (iUpperBound - iLowerBound + 1);
  int jSize = (jUpperBound - jLowerBound + 1);
  int kSize = (kUpperBound - kLowerBound + 1);
/* !    call build(bpt_ctoprim_loop1, "bpt_ctoprim_loop1") */
/*     !$OMP PARALLEL DO PRIVATE(i,j,k,eint,rhoinv) */
  for (k = lo[2] -  *ng; k <= hi[2] +  *ng; k = k + 1) {
    for (j = lo[1] -  *ng; j <= hi[1] +  *ng; j = j + 1) {
      for (i = lo[0] -  *ng; i <= hi[0] +  *ng; i = i + 1) {
        rhoinv = 1.0e0 / u[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (0)))];
        q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (0)))] = u[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (0)))];
        q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (1)))] = u[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (1)))] * rhoinv;
        q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (2)))] = u[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (2)))] * rhoinv;
        q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (3)))] = u[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (3)))] * rhoinv;
        eint = u[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (4)))] * rhoinv - 0.5e0 * (pow(q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (1)))],2.0) + pow(q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (2)))],2.0) + pow(q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (3)))],2.0));
        q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (4)))] = (GAMMA - 1.e0) * eint * u[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (0)))];
        q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] = eint * CVinv;
      }
    }
  }
/*     !$OMP END PARALLEL DO */
/* !    call destroy(bpt_ctoprim_loop1) */
//  if (present( *courno)) {
  if (*courno != 0.0) {
    courmx = -DBL_MAX;
    courmy = -DBL_MAX;
    courmz = -DBL_MAX;
    dx1inv = 1.0e0 / dx[0];
    dx2inv = 1.0e0 / dx[1];
    dx3inv = 1.0e0 / dx[2];
/* !       call build(bpt_ctoprim_loop2, "bpt_ctoprim_loop2") */
/*        !$OMP PARALLEL DO PRIVATE(i,j,k,c,courx,coury,courz) REDUCTION(max:courmx,courmy,courmz) */
    for (k = lo[2]; k <= hi[2]; k = k + 1) {
      for (j = lo[1]; j <= hi[1]; j = j + 1) {
        for (i = lo[0]; i <= hi[0]; i = i + 1) {
          c = sqrt(GAMMA * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (4)))] / q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (0)))]);
          courx = (c + fabs(q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (1)))])) * dx1inv;
          coury = (c + fabs(q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (2)))])) * dx2inv;
          courz = (c + fabs(q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (3)))])) * dx3inv;
          courmx = (courmx > courx?courmx : courx);
          courmy = (courmy > coury?courmy : coury);
          courmz = (courmz > courz?courmz : courz);
        }
      }
    }
/*        !$OMP END PARALLEL DO */
/* !       call destroy(bpt_ctoprim_loop2) */
/*        ! */
/*        ! Compute running max of Courant number over grids. */
/*        ! */
/* !       courno = max( courmx, courmy, courmz , courno ) */
  *courno = max( max( max(courmx, courmy), courmz), *courno);
  }
  else {
  }
/* !    call destroy(bpt_ctoprim) */
}

void hypterm_(int *lo,int *hi,int *ng,double *dx,double *cons,double *q,double *flux)
{
  int irho = 1;
  int imx = 2;
  int imy = 3;
  int imz = 4;
  int iene = 5;
  int qu = 2;
  int qv = 3;
  int qw = 4;
  int qpres = 5;
  double ALP = 0.8e0;
  double BET = - 0.2e0;
  double GAM = 4.e0 / 105.e0;
  double DEL = -(1.e0 / 280.e0);
  int i;
  int j;
  int k;
  double unp1;
  double unp2;
  double unp3;
  double unp4;
  double unm1;
  double unm2;
  double unm3;
  double unm4;
  double dxinv[3];
  int iFluxLowerBound = (lo[0]);
  int jFluxLowerBound = (lo[1]);
  int kFluxLowerBound = (lo[2]);
  int iFluxUpperBound = (hi[0]);
  int jFluxUpperBound = (hi[1]);
  int kFluxUpperBound = (hi[2]);
  int iFluxSize = (iFluxUpperBound - iFluxLowerBound + 1);
  int jFluxSize = (jFluxUpperBound - jFluxLowerBound + 1);
  int kFluxSize = (kFluxUpperBound - kFluxLowerBound + 1);
  int iLowerBound = (lo[0] -  *ng);
  int jLowerBound = (lo[1] -  *ng);
  int kLowerBound = (lo[2] -  *ng);
  int iUpperBound = (hi[0] +  *ng);
  int jUpperBound = (hi[1] +  *ng);
  int kUpperBound = (hi[2] +  *ng);
  int iSize = (iUpperBound - iLowerBound + 1);
  int jSize = (jUpperBound - jLowerBound + 1);
  int kSize = (kUpperBound - kLowerBound + 1);
  //printf("Running hypterm in C version !!\n");
/* !    type(bl_prof_timer), save :: bpt_hypterm, bpt_hypterm_loop1, bpt_hypterm_loop2, bpt_hypterm_loop3 */
/* !    call build(bpt_hypterm, "bpt_hypterm") */
  for (i = 1; i <= 3; i = i + 1) {
    dxinv[i - 1] = 1.0e0 / dx[i - 1];
  }
/* !    call build(bpt_hypterm_loop1, "bpt_hypterm_loop1") */
/*     !$OMP PARALLEL DO PRIVATE(i,j,k,unp1,unp2,unp3,unp4,unm1,unm2,unm3,unm4) */
  for (k = kFluxLowerBound; k <= kFluxUpperBound; k = k + 1) {
    for (j = jFluxLowerBound; j <= jFluxUpperBound; j = j + 1) {
      for (i = iFluxLowerBound; i <= iFluxUpperBound; i = i + 1) {
        unp1 = q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))];
        unp2 = q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))];
        unp3 = q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))];
        unp4 = q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))];
        unm1 = q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))];
        unm2 = q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))];
        unm3 = q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))];
        unm4 = q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (irho - 1)))] = -((ALP * (cons[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] - cons[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))]) + BET * (cons[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] - cons[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))]) + GAM * (cons[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] - cons[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))]) + DEL * (cons[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] - cons[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))])) * dxinv[0]);
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imx - 1)))] = -((ALP * (cons[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unp1 - cons[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unm1 + (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] - q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))])) + BET * (cons[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unp2 - cons[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unm2 + (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] - q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))])) + GAM * (cons[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unp3 - cons[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unm3 + (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] - q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))])) + DEL * (cons[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unp4 - cons[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unm4 + (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] - q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))]))) * dxinv[0]);
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imy - 1)))] = -((ALP * (cons[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unp1 - cons[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unm1) + BET * (cons[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unp2 - cons[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unm2) + GAM * (cons[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unp3 - cons[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unm3) + DEL * (cons[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unp4 - cons[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unm4)) * dxinv[0]);
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imz - 1)))] = -((ALP * (cons[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unp1 - cons[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unm1) + BET * (cons[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unp2 - cons[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unm2) + GAM * (cons[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unp3 - cons[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unm3) + DEL * (cons[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unp4 - cons[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unm4)) * dxinv[0]);
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (iene - 1)))] = -((ALP * (cons[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unp1 - cons[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unm1 + (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unp1 - q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unm1)) + BET * (cons[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unp2 - cons[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unm2 + (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unp2 - q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unm2)) + GAM * (cons[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unp3 - cons[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unm3 + (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unp3 - q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unm3)) + DEL * (cons[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unp4 - cons[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unm4 + (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unp4 - q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unm4))) * dxinv[0]);
      }
    }
  }
/*     !$OMP END PARALLEL DO */
/* !    call destroy(bpt_hypterm_loop1) */
/* !    call build(bpt_hypterm_loop2, "bpt_hypterm_loop2") */
/*     !$OMP PARALLEL DO PRIVATE(i,j,k,unp1,unp2,unp3,unp4,unm1,unm2,unm3,unm4) */
  for (k = kFluxLowerBound; k <= kFluxUpperBound; k = k + 1) {
    for (j = jFluxLowerBound; j <= jFluxUpperBound; j = j + 1) {
      for (i = iFluxLowerBound; i <= iFluxUpperBound; i = i + 1) {
        unp1 = q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))];
        unp2 = q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))];
        unp3 = q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))];
        unp4 = q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))];
        unm1 = q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))];
        unm2 = q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))];
        unm3 = q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))];
        unm4 = q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (irho - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (irho - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] - cons[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))]) + BET * (cons[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] - cons[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))]) + GAM * (cons[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] - cons[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))]) + DEL * (cons[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] - cons[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))])) * dxinv[1];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imx - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imx - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unp1 - cons[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unm1) + BET * (cons[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unp2 - cons[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unm2) + GAM * (cons[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unp3 - cons[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unm3) + DEL * (cons[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unp4 - cons[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (imx - 1)))] * unm4)) * dxinv[1];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imy - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imy - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unp1 - cons[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unm1 + (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] - q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))])) + BET * (cons[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unp2 - cons[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unm2 + (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] - q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))])) + GAM * (cons[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unp3 - cons[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unm3 + (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] - q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))])) + DEL * (cons[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unp4 - cons[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (imy - 1)))] * unm4 + (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] - q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))]))) * dxinv[1];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imz - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imz - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unp1 - cons[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unm1) + BET * (cons[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unp2 - cons[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unm2) + GAM * (cons[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unp3 - cons[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unm3) + DEL * (cons[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unp4 - cons[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (imz - 1)))] * unm4)) * dxinv[1];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (iene - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (iene - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unp1 - cons[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unm1 + (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unp1 - q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unm1)) + BET * (cons[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unp2 - cons[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unm2 + (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unp2 - q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unm2)) + GAM * (cons[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unp3 - cons[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unm3 + (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unp3 - q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unm3)) + DEL * (cons[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unp4 - cons[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (iene - 1)))] * unm4 + (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unp4 - q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qpres - 1)))] * unm4))) * dxinv[1];
      }
    }
  }
/*     !$OMP END PARALLEL DO */
/* !    call destroy(bpt_hypterm_loop2) */
/* !    call build(bpt_hypterm_loop3, "bpt_hypterm_loop3") */
/*     !$OMP PARALLEL DO PRIVATE(i,j,k,unp1,unp2,unp3,unp4,unm1,unm2,unm3,unm4) */
  for (k = kFluxLowerBound; k <= kFluxUpperBound; k = k + 1) {
    for (j = jFluxLowerBound; j <= jFluxUpperBound; j = j + 1) {
      for (i = iFluxLowerBound; i <= iFluxUpperBound; i = i + 1) {
        unp1 = q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qw - 1)))];
        unp2 = q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qw - 1)))];
        unp3 = q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qw - 1)))];
        unp4 = q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qw - 1)))];
        unm1 = q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qw - 1)))];
        unm2 = q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qw - 1)))];
        unm3 = q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qw - 1)))];
        unm4 = q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qw - 1)))];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (irho - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (irho - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (imz - 1)))] - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (imz - 1)))]) + BET * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (imz - 1)))] - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (imz - 1)))]) + GAM * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (imz - 1)))] - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (imz - 1)))]) + DEL * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (imz - 1)))] - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (imz - 1)))])) * dxinv[2];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imx - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imx - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (imx - 1)))] * unp1 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (imx - 1)))] * unm1) + BET * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (imx - 1)))] * unp2 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (imx - 1)))] * unm2) + GAM * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (imx - 1)))] * unp3 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (imx - 1)))] * unm3) + DEL * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (imx - 1)))] * unp4 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (imx - 1)))] * unm4)) * dxinv[2];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imy - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imy - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (imy - 1)))] * unp1 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (imy - 1)))] * unm1) + BET * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (imy - 1)))] * unp2 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (imy - 1)))] * unm2) + GAM * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (imy - 1)))] * unp3 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (imy - 1)))] * unm3) + DEL * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (imy - 1)))] * unp4 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (imy - 1)))] * unm4)) * dxinv[2];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imz - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imz - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (imz - 1)))] * unp1 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (imz - 1)))] * unm1 + (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qpres - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qpres - 1)))])) + BET * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (imz - 1)))] * unp2 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (imz - 1)))] * unm2 + (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qpres - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qpres - 1)))])) + GAM * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (imz - 1)))] * unp3 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (imz - 1)))] * unm3 + (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qpres - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qpres - 1)))])) + DEL * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (imz - 1)))] * unp4 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (imz - 1)))] * unm4 + (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qpres - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qpres - 1)))]))) * dxinv[2];
        flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (iene - 1)))] = flux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (iene - 1)))] - (ALP * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (iene - 1)))] * unp1 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (iene - 1)))] * unm1 + (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qpres - 1)))] * unp1 - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qpres - 1)))] * unm1)) + BET * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (iene - 1)))] * unp2 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (iene - 1)))] * unm2 + (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qpres - 1)))] * unp2 - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qpres - 1)))] * unm2)) + GAM * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (iene - 1)))] * unp3 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (iene - 1)))] * unm3 + (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qpres - 1)))] * unp3 - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qpres - 1)))] * unm3)) + DEL * (cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (iene - 1)))] * unp4 - cons[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (iene - 1)))] * unm4 + (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qpres - 1)))] * unp4 - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qpres - 1)))] * unm4))) * dxinv[2];
      }
    }
  }
/*     !$OMP END PARALLEL DO */
/* !    call destroy(bpt_hypterm_loop3) */
/* !    call destroy(bpt_hypterm) */
}

void diffterm_(int *lo,int *hi,int *ng,double *dx,double *q,double *difflux,double *eta,double *alam)
{
  int irho = 1;
  int imx = 2;
  int imy = 3;
  int imz = 4;
  int iene = 5;
  int qu = 2;
  int qv = 3;
  int qw = 4;
  double ALP = 0.8e0;
  double BET = - 0.2e0;
  double GAM = 4.e0 / 105.e0;
  double DEL = -(1.e0 / 280.e0);
  double dxinv[3];
  double tauxx;
  double tauyy;
  double tauzz;
  double tauxy;
  double tauxz;
  double tauyz;
  double divu;
  double uxx;
  double uyy;
  double uzz;
  double vxx;
  double vyy;
  double vzz;
  double wxx;
  double wyy;
  double wzz;
  double txx;
  double tyy;
  double tzz;
  double mechwork;
  double uxy;
  double uxz;
  double vyz;
  double wzx;
  double wzy;
  double vyx;
  int i;
  int j;
  int k;
  double OneThird = 1.0e0 / 3.0e0;
  double TwoThirds = 2.0e0 / 3.0e0;
  double FourThirds = 4.0e0 / 3.0e0;
  double CENTER = -(205.e0 / 72.e0);
  double OFF1 = 8.e0 / 5.e0;
  double OFF2 = - 0.2e0;
  double OFF3 = 8.e0 / 315.e0;
  double OFF4 = -(1.e0 / 560.e0);
  int iFluxLowerBound = (lo[0]);
  int jFluxLowerBound = (lo[1]);
  int kFluxLowerBound = (lo[2]);
  int iFluxUpperBound = (hi[0]);
  int jFluxUpperBound = (hi[1]);
  int kFluxUpperBound = (hi[2]);
  int iFluxSize = (iFluxUpperBound - iFluxLowerBound + 1);
  int jFluxSize = (jFluxUpperBound - jFluxLowerBound + 1);
  int kFluxSize = (kFluxUpperBound - kFluxLowerBound + 1);
  int iLowerBound = (lo[0] -  *ng);
  int jLowerBound = (lo[1] -  *ng);
  int kLowerBound = (lo[2] -  *ng);
  int iUpperBound = (hi[0] +  *ng);
  int jUpperBound = (hi[1] +  *ng);
  int kUpperBound = (hi[2] +  *ng);
  int iSize = (iUpperBound - iLowerBound + 1);
  int jSize = (jUpperBound - jLowerBound + 1);
  int kSize = (kUpperBound - kLowerBound + 1);
/* !    double precision, allocatable, dimension(:,:,:) :: ux,uy,uz,vx,vy,vz,wx,wy,wz */
  double *ux = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  double *uy = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  double *uz = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  double *vx = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  double *vy = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  double *vz = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  double *wx = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  double *wy = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  double *wz = (double*) malloc(sizeof(double)*iSize * jSize * kSize);
  //printf("Running diffterm in C version !!\n");
/* !    type(bl_prof_timer), save :: bpt_hypterm, bpt_hypterm_loop1, bpt_hypterm_loop2, bpt_hypterm_loop3 */
/* !    type(bl_prof_timer), save :: bpt_diffterm, bpt_diffterm_loop123, bpt_diffterm_loop4 */
/* !    type(bl_prof_timer), save :: bpt_diffterm_loop5, bpt_diffterm_loop6, bpt_diffterm_loop7 */
/* !    call build(bpt_diffterm, "bpt_diffterm") */
/* !    difflux(:,:,:,irho) = 0.0d0 */
  for (k = lo[2]; k <= hi[2]; k = k + 1) 
    for (j = lo[1]; j <= hi[1]; j = j + 1) 
      for (i = lo[0]; i <= hi[0]; i = i + 1)
        difflux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (irho - 1)))] =  0.0e0;
 
  for (i = 1; i <= 3; i = i + 1) {
    dxinv[i - 1] = 1.0e0 / dx[i - 1];
  }
/* !    call build(bpt_diffterm_loop123, "bpt_diffterm_loop123") */
/*     !$OMP PARALLEL PRIVATE(i,j,k) */
/*     !$OMP DO */
  for (k = lo[2] -  *ng; k <= hi[2] +  *ng; k = k + 1) {
    for (j = lo[1] -  *ng; j <= hi[1] +  *ng; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] - q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + BET * (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] - q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + GAM * (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] - q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + DEL * (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] - q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))])) * dxinv[0];
        vx[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] - q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + BET * (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] - q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + GAM * (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] - q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + DEL * (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] - q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))])) * dxinv[0];
        wx[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] - q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + BET * (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] - q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + GAM * (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] - q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + DEL * (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] - q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))])) * dxinv[0];
      }
    }
  }
/*     !$OMP END DO NOWAIT */
/*     !$OMP DO */
  for (k = lo[2] -  *ng; k <= hi[2] +  *ng; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0] -  *ng; i <= hi[0] +  *ng; i = i + 1) {
        uy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] - q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + BET * (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] - q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + GAM * (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] - q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + DEL * (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] - q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))])) * dxinv[1];
        vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] - q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + BET * (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] - q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + GAM * (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] - q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + DEL * (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] - q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))])) * dxinv[1];
        wy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] - q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + BET * (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] - q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + GAM * (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] - q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + DEL * (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] - q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))])) * dxinv[1];
      }
    }
  }
/*     !$OMP END DO NOWAIT */
/*     !$OMP DO */
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1] -  *ng; j <= hi[1] +  *ng; j = j + 1) {
      for (i = lo[0] -  *ng; i <= hi[0] +  *ng; i = i + 1) {
        uz[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qu - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qu - 1)))]) + BET * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qu - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qu - 1)))]) + GAM * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qu - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qu - 1)))]) + DEL * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qu - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qu - 1)))])) * dxinv[2];
        vz[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qv - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qv - 1)))]) + BET * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qv - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qv - 1)))]) + GAM * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qv - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qv - 1)))]) + DEL * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qv - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qv - 1)))])) * dxinv[2];
        wz[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] = (ALP * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qw - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qw - 1)))]) + BET * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qw - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qw - 1)))]) + GAM * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qw - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qw - 1)))]) + DEL * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qw - 1)))] - q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qw - 1)))])) * dxinv[2];
      }
    }
  }
/*     !$OMP END DO */
/*     !$OMP END PARALLEL */
/* !    call destroy(bpt_diffterm_loop123) */
/* !    call build(bpt_diffterm_loop4, "bpt_diffterm_loop4") */
/*     !$OMP PARALLEL DO PRIVATE(i,j,k,uxx,uyy,uzz,vyx,wzx) */
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        uxx = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + OFF1 * (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + OFF2 * (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + OFF3 * (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + OFF4 * (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))])) * pow(dxinv[0],2.0);
        uyy = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + OFF1 * (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + OFF2 * (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + OFF3 * (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))]) + OFF4 * (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))])) * pow(dxinv[1],2.0);
        uzz = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + OFF1 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qu - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qu - 1)))]) + OFF2 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qu - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qu - 1)))]) + OFF3 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qu - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qu - 1)))]) + OFF4 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qu - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qu - 1)))])) * pow(dxinv[2],2.0);
        vyx = (ALP * (vy[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - vy[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))]) + BET * (vy[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - vy[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))]) + GAM * (vy[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - vy[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))]) + DEL * (vy[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - vy[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))])) * dxinv[0];
        wzx = (ALP * (wz[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - wz[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))]) + BET * (wz[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - wz[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))]) + GAM * (wz[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - wz[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))]) + DEL * (wz[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - wz[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))])) * dxinv[0];
        difflux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imx - 1)))] =  *eta * (FourThirds * uxx + uyy + uzz + OneThird * (vyx + wzx));
      }
    }
  }
/*     !$OMP END PARALLEL DO */
/* !    call destroy(bpt_diffterm_loop4) */
/* ! */
/* !    call build(bpt_diffterm_loop5, "bpt_diffterm_loop5") */
/*     !$OMP PARALLEL DO PRIVATE(i,j,k,vxx,vyy,vzz,uxy,wzy) */
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        vxx = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + OFF1 * (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + OFF2 * (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + OFF3 * (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + OFF4 * (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))])) * pow(dxinv[0],2.0);
        vyy = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + OFF1 * (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + OFF2 * (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + OFF3 * (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))]) + OFF4 * (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))])) * pow(dxinv[1],2.0);
        vzz = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + OFF1 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qv - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qv - 1)))]) + OFF2 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qv - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qv - 1)))]) + OFF3 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qv - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qv - 1)))]) + OFF4 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qv - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qv - 1)))])) * pow(dxinv[2],2.0);
        uxy = (ALP * (ux[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound))] - ux[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound))]) + BET * (ux[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound))] - ux[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound))]) + GAM * (ux[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound))] - ux[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound))]) + DEL * (ux[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound))] - ux[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound))])) * dxinv[1];
        wzy = (ALP * (wz[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound))] - wz[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound))]) + BET * (wz[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound))] - wz[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound))]) + GAM * (wz[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound))] - wz[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound))]) + DEL * (wz[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound))] - wz[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound))])) * dxinv[1];
        difflux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imy - 1)))] =  *eta * (vxx + FourThirds * vyy + vzz + OneThird * (uxy + wzy));
      }
    }
  }
/*     !$OMP END PARALLEL DO */
/* !    call destroy(bpt_diffterm_loop5) */
/* ! */
/* !    call build(bpt_diffterm_loop6, "bpt_diffterm_loop6") */
/*     !$OMP PARALLEL DO PRIVATE(i,j,k,wxx,wyy,wzz,uxz,vyz) */
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        wxx = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + OFF1 * (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + OFF2 * (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + OFF3 * (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + OFF4 * (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))])) * pow(dxinv[0],2.0);
        wyy = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + OFF1 * (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + OFF2 * (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + OFF3 * (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))]) + OFF4 * (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))])) * pow(dxinv[1],2.0);
        wzz = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))] + OFF1 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (qw - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (qw - 1)))]) + OFF2 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (qw - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (qw - 1)))]) + OFF3 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (qw - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (qw - 1)))]) + OFF4 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (qw - 1)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (qw - 1)))])) * pow(dxinv[2],2.0);
        uxz = (ALP * (ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound))] - ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound))]) + BET * (ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound))] - ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound))]) + GAM * (ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound))] - ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound))]) + DEL * (ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound))] - ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound))])) * dxinv[2];
        vyz = (ALP * (vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound))] - vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound))]) + BET * (vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound))] - vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound))]) + GAM * (vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound))] - vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound))]) + DEL * (vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound))] - vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound))])) * dxinv[2];
        difflux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imz - 1)))] =  *eta * (wxx + wyy + FourThirds * wzz + OneThird * (uxz + vyz));
      }
    }
  }
/*     !$OMP END PARALLEL DO */
/* !    call destroy(bpt_diffterm_loop6) */
/* ! */
/* !    call build(bpt_diffterm_loop7, "bpt_diffterm_loop7") */
/*     !$OMP PARALLEL DO PRIVATE(i,j,k,txx,tyy,tzz) \ */
/*     !$OMP PRIVATE(divu,tauxx,tauyy,tauzz,tauxy,tauxz,tauyz,mechwork) */
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        txx = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + OFF1 * (q[i + 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + q[i - 1 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))]) + OFF2 * (q[i + 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + q[i - 2 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))]) + OFF3 * (q[i + 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + q[i - 3 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))]) + OFF4 * (q[i + 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + q[i - 4 - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))])) * pow(dxinv[0],2.0);
        tyy = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + OFF1 * (q[i - iLowerBound + iSize * (j + 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + q[i - iLowerBound + iSize * (j - 1 - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))]) + OFF2 * (q[i - iLowerBound + iSize * (j + 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + q[i - iLowerBound + iSize * (j - 2 - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))]) + OFF3 * (q[i - iLowerBound + iSize * (j + 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + q[i - iLowerBound + iSize * (j - 3 - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))]) + OFF4 * (q[i - iLowerBound + iSize * (j + 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + q[i - iLowerBound + iSize * (j - 4 - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))])) * pow(dxinv[1],2.0);
        tzz = (CENTER * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (5)))] + OFF1 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 1 - kLowerBound + kSize * (5)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 1 - kLowerBound + kSize * (5)))]) + OFF2 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 2 - kLowerBound + kSize * (5)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 2 - kLowerBound + kSize * (5)))]) + OFF3 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 3 - kLowerBound + kSize * (5)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 3 - kLowerBound + kSize * (5)))]) + OFF4 * (q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k + 4 - kLowerBound + kSize * (5)))] + q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - 4 - kLowerBound + kSize * (5)))])) * pow(dxinv[2],2.0);
        divu = TwoThirds * (ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] + vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] + wz[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))]);
        tauxx = 2.e0 * ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - divu;
        tauyy = 2.e0 * vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - divu;
        tauzz = 2.e0 * wz[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] - divu;
        tauxy = uy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] + vx[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))];
        tauxz = uz[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] + wx[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))];
        tauyz = vz[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] + wy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))];
        mechwork = tauxx * ux[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] + tauyy * vy[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] + tauzz * wz[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound))] + pow(tauxy,2.0) + pow(tauxz,2.0) + pow(tauyz,2.0);
        mechwork =  *eta * mechwork + difflux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imx - 1)))] * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qu - 1)))] + difflux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imy - 1)))] * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qv - 1)))] + difflux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (imz - 1)))] * q[i - iLowerBound + iSize * (j - jLowerBound + jSize * (k - kLowerBound + kSize * (qw - 1)))];
        difflux[i - iFluxLowerBound + iFluxSize * (j - jFluxLowerBound + jFluxSize * (k - kFluxLowerBound + kFluxSize * (iene - 1)))] =  *alam * (txx + tyy + tzz) + mechwork;
      }
    }
  }
/*     !$OMP END PARALLEL DO */
/* !    call destroy(bpt_diffterm_loop7) */
/* ! */
/* !    call destroy(bpt_diffterm) */
}
/* !end module advance_module */
/* !end module advance_module */
