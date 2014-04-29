/***********************************************************************************/
/* This version is a directly translated from advance.f90                          */
/* Majority of the translation is done by the Fortran_to_C tool inside ROSE.       */
/* Minor manual translation is required to address features from Fortran 90.       */
/* All arrays are translated into multi-dimensional array in C                     */
/***********************************************************************************/


#define min(a,b) (((a)<(b))?(a):(b))
#define max(a,b) (((a)>(b))?(a):(b))
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <float.h>
void ctoprim_(int *lo,int *hi,int *ng, double (*u)[hi[2] +  *ng - (lo[2] -  *ng) + 1][hi[1] +  *ng - (lo[1] -  *ng) + 1][hi[0] +  *ng - (lo[0] -  *ng) + 1],double (*q)[hi[2] +  *ng - (lo[2] -  *ng) + 1][hi[1] +  *ng - (lo[1] -  *ng) + 1][hi[0] +  *ng - (lo[0] -  *ng) + 1],double *dx,double *courno)
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
  CVinv = 1.0e0 / CV;
  int iLowerBound = (lo[0] -  *ng);
  int jLowerBound = (lo[1] -  *ng);
  int kLowerBound = (lo[2] -  *ng);
  //printf("Running ctoprim in C version !!\n");
  for (k = lo[2] -  *ng; k <= hi[2] +  *ng; k = k + 1) {
    for (j = lo[1] -  *ng; j <= hi[1] +  *ng; j = j + 1) {
      for (i = lo[0] -  *ng; i <= hi[0] +  *ng; i = i + 1) {
        rhoinv = 1.0e0 / u[0][k - kLowerBound][j - jLowerBound][i - iLowerBound];
        q[0][k - kLowerBound][j - jLowerBound][i - iLowerBound] = u[0][k - kLowerBound][j - jLowerBound][i - iLowerBound];
        q[1][k - kLowerBound][j - jLowerBound][i - iLowerBound] = u[1][k - kLowerBound][j - jLowerBound][i - iLowerBound] * rhoinv;
        q[2][k - kLowerBound][j - jLowerBound][i - iLowerBound] = u[2][k - kLowerBound][j - jLowerBound][i - iLowerBound] * rhoinv;
        q[3][k - kLowerBound][j - jLowerBound][i - iLowerBound] = u[3][k - kLowerBound][j - jLowerBound][i - iLowerBound] * rhoinv;
        eint = u[4][k - kLowerBound][j - jLowerBound][i - iLowerBound] * rhoinv - 0.5e0 * (pow(q[1][k - kLowerBound][j - jLowerBound][i - iLowerBound],2) + pow(q[2][k - kLowerBound][j - jLowerBound][i - iLowerBound],2) + pow(q[3][k - kLowerBound][j - jLowerBound][i - iLowerBound],2));
        q[4][k - kLowerBound][j - jLowerBound][i - iLowerBound] = (GAMMA - 1.e0) * eint * u[0][k - kLowerBound][j - jLowerBound][i - iLowerBound];
        q[5][k - kLowerBound][j - jLowerBound][i - iLowerBound] = eint * CVinv;
      }
    }
  }
  if (*courno != 0.0) {
    courmx = -DBL_MAX;
    courmy = -DBL_MAX;
    courmz = -DBL_MAX;
    dx1inv = 1.0e0 / dx[0];
    dx2inv = 1.0e0 / dx[1];
    dx3inv = 1.0e0 / dx[2];
    for (k = lo[2]; k <= hi[2]; k = k + 1) {
      for (j = lo[1]; j <= hi[1]; j = j + 1) {
        for (i = lo[0]; i <= hi[0]; i = i + 1) {
          c = sqrt(GAMMA * q[4][k - kLowerBound][j - jLowerBound][i - iLowerBound] / q[0][k - kLowerBound][j - jLowerBound][i - iLowerBound]);
          courx = (c + abs(q[1][k - kLowerBound][j - jLowerBound][i - iLowerBound])) * dx1inv;
          coury = (c + abs(q[2][k - kLowerBound][j - jLowerBound][i - iLowerBound])) * dx2inv;
          courz = (c + abs(q[3][k - kLowerBound][j - jLowerBound][i - iLowerBound])) * dx3inv;
          courmx = (courmx > courx?courmx : courx);
          courmy = (courmy > coury?courmy : coury);
          courmz = (courmz > courz?courmz : courz);
        }
      }
    }
  *courno = max( max( max(courmx, courmy), courmz), *courno);
  }
  else {
  }
}

void hypterm_(int *lo,int *hi,int *ng,double *dx,double (*cons)[hi[2] +  *ng - (-( *ng) + lo[2]) + 1][hi[1] +  *ng - (-( *ng) + lo[1]) + 1][hi[0] +  *ng - (-( *ng) + lo[0]) + 1],double (*q)[hi[2] +  *ng - (-( *ng) + lo[2]) + 1][hi[1] +  *ng - (-( *ng) + lo[1]) + 1][hi[0] +  *ng - (-( *ng) + lo[0]) + 1],double (*flux)[hi[2] - lo[2] + 1][hi[1] - lo[1] + 1][hi[0] - lo[0] + 1])
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
  int iLowerBound = (lo[0] -  *ng);
  int jLowerBound = (lo[1] -  *ng);
  int kLowerBound = (lo[2] -  *ng);
  //printf("Running hypterm in C version !!\n");
  for (i = 1; i <= 3; i = i + 1) {
    dxinv[i - 1] = 1.0e0 / dx[i - 1];
  }
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        unp1 = q[qu - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound];
        unp2 = q[qu - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound];
        unp3 = q[qu - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound];
        unp4 = q[qu - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound];
        unm1 = q[qu - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound];
        unm2 = q[qu - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound];
        unm3 = q[qu - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound];
        unm4 = q[qu - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound];
        flux[irho - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = -((ALP * (cons[imx - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] - cons[imx - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + BET * (cons[imx - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] - cons[imx - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + GAM * (cons[imx - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] - cons[imx - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + DEL * (cons[imx - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] - cons[imx - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * dxinv[0]);
        flux[imx - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = -((ALP * (cons[imx - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] * unp1 - cons[imx - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound] * unm1 + (q[qpres - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] - q[qpres - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound])) + BET * (cons[imx - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] * unp2 - cons[imx - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound] * unm2 + (q[qpres - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] - q[qpres - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound])) + GAM * (cons[imx - 1][k - kLowerBound][j - jLowerBound][i + 3 - (-( *ng) + lo[1 - 1])] * unp3 - cons[imx - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound] * unm3 + (q[qpres - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] - q[qpres - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound])) + DEL * (cons[imx - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] * unp4 - cons[imx - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound] * unm4 + (q[qpres - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] - q[qpres - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound]))) * dxinv[0]);
        flux[imy - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = -((ALP * (cons[imy - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] * unp1 - cons[imy - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound] * unm1) + BET * (cons[imy - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] * unp2 - cons[imy - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound] * unm2) + GAM * (cons[imy - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] * unp3 - cons[imy - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound] * unm3) + DEL * (cons[imy - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] * unp4 - cons[imy - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound] * unm4)) * dxinv[0]);
        flux[imz - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = -((ALP * (cons[imz - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] * unp1 - cons[imz - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound] * unm1) + BET * (cons[imz - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] * unp2 - cons[imz - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound] * unm2) + GAM * (cons[imz - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] * unp3 - cons[imz - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound] * unm3) + DEL * (cons[imz - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] * unp4 - cons[imz - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound] * unm4)) * dxinv[0]);
        flux[iene - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = -((ALP * (cons[iene - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] * unp1 - cons[iene - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound] * unm1 + (q[qpres - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] * unp1 - q[qpres - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound] * unm1)) + BET * (cons[iene - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] * unp2 - cons[iene - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound] * unm2 + (q[qpres - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] * unp2 - q[qpres - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound] * unm2)) + GAM * (cons[iene - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] * unp3 - cons[iene - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound] * unm3 + (q[qpres - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] * unp3 - q[qpres - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound] * unm3)) + DEL * (cons[iene - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] * unp4 - cons[iene - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound] * unm4 + (q[qpres - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] * unp4 - q[qpres - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound] * unm4))) * dxinv[0]);
      }
    }
  }
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        unp1 = q[qv - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound];
        unp2 = q[qv - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound];
        unp3 = q[qv - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound];
        unp4 = q[qv - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound];
        unm1 = q[qv - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound];
        unm2 = q[qv - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound];
        unm3 = q[qv - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound];
        unm4 = q[qv - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound];
        flux[irho - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[irho - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[imy - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] - cons[imy - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + BET * (cons[imy - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] - cons[imy - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + GAM * (cons[imy - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] - cons[imy - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + DEL * (cons[imy - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] - cons[imy - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * dxinv[1];
        flux[imx - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[imx - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[imx - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] * unp1 - cons[imx - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound] * unm1) + BET * (cons[imx - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] * unp2 - cons[imx - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound] * unm2) + GAM * (cons[imx - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] * unp3 - cons[imx - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound] * unm3) + DEL * (cons[imx - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] * unp4 - cons[imx - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound] * unm4)) * dxinv[1];
        flux[imy - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[imy - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[imy - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] * unp1 - cons[imy - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound] * unm1 + (q[qpres - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] - q[qpres - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound])) + BET * (cons[imy - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] * unp2 - cons[imy - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound] * unm2 + (q[qpres - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] - q[qpres - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound])) + GAM * (cons[imy - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] * unp3 - cons[imy - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound] * unm3 + (q[qpres - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] - q[qpres - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound])) + DEL * (cons[imy - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] * unp4 - cons[imy - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound] * unm4 + (q[qpres - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] - q[qpres - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound]))) * dxinv[1];
        flux[imz - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[imz - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[imz - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] * unp1 - cons[imz - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound] * unm1) + BET * (cons[imz - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] * unp2 - cons[imz - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound] * unm2) + GAM * (cons[imz - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] * unp3 - cons[imz - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound] * unm3) + DEL * (cons[imz - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] * unp4 - cons[imz - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound] * unm4)) * dxinv[1];
        flux[iene - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[iene - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[iene - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] * unp1 - cons[iene - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound] * unm1 + (q[qpres - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] * unp1 - q[qpres - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound] * unm1)) + BET * (cons[iene - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] * unp2 - cons[iene - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound] * unm2 + (q[qpres - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] * unp2 - q[qpres - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound] * unm2)) + GAM * (cons[iene - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] * unp3 - cons[iene - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound] * unm3 + (q[qpres - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] * unp3 - q[qpres - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound] * unm3)) + DEL * (cons[iene - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] * unp4 - cons[iene - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound] * unm4 + (q[qpres - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] * unp4 - q[qpres - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound] * unm4))) * dxinv[1];
      }
    }
  }
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        unp1 = q[qw - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound];
        unp2 = q[qw - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound];
        unp3 = q[qw - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound];
        unp4 = q[qw - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound];
        unm1 = q[qw - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound];
        unm2 = q[qw - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound];
        unm3 = q[qw - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound];
        unm4 = q[qw - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound];
        flux[irho - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[irho - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[imz - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] - cons[imz - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + BET * (cons[imz - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] - cons[imz - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + GAM * (cons[imz - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] - cons[imz - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + DEL * (cons[imz - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] - cons[imz - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * dxinv[2];
        flux[imx - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[imx - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[imx - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp1 - cons[imx - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm1) + BET * (cons[imx - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp2 - cons[imx - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm2) + GAM * (cons[imx - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp3 - cons[imx - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm3) + DEL * (cons[imx - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp4 - cons[imx - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm4)) * dxinv[2];
        flux[imy - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[imy - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[imy - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp1 - cons[imy - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm1) + BET * (cons[imy - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp2 - cons[imy - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm2) + GAM * (cons[imy - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp3 - cons[imy - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm3) + DEL * (cons[imy - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp4 - cons[imy - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm4)) * dxinv[2];
        flux[imz - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[imz - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[imz - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp1 - cons[imz - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm1 + (q[qpres - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qpres - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound])) + BET * (cons[imz - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp2 - cons[imz - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm2 + (q[qpres - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qpres - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound])) + GAM * (cons[imz - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp3 - cons[imz - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm3 + (q[qpres - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qpres - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound])) + DEL * (cons[imz - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp4 - cons[imz - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm4 + (q[qpres - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qpres - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound]))) * dxinv[2];
        flux[iene - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] = flux[iene - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] - (ALP * (cons[iene - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp1 - cons[iene - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm1 + (q[qpres - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp1 - q[qpres - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm1)) + BET * (cons[iene - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp2 - cons[iene - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm2 + (q[qpres - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp2 - q[qpres - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm2)) + GAM * (cons[iene - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp3 - cons[iene - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm3 + (q[qpres - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp3 - q[qpres - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm3)) + DEL * (cons[iene - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp4 - cons[iene - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm4 + (q[qpres - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unp4 - q[qpres - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound] * unm4))) * dxinv[2];
      }
    }
  }
}

void diffterm_(int *lo,int *hi,int *ng,double *dx,double (*q)[hi[2] +  *ng - (-( *ng) + lo[2]) + 1][hi[1] +  *ng - (-( *ng) + lo[1]) + 1][hi[0] +  *ng - (-( *ng) + lo[0]) + 1],double (*difflux)[hi[2] - lo[2] + 1][hi[1] - lo[1] + 1][hi[0] - lo[0] + 1],double *eta,double *alam)
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
/* !    double precision, allocatable, dimension(:,:,:) :: ux,uy,uz,vx,vy,vz,wx,wy,wz */
  double ux[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
  double uy[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
  double uz[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
  double vx[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
  double vy[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
  double vz[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
  double wx[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
  double wy[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
  double wz[(hi[1 - 1] + *ng - (-*ng + lo[1 - 1]) + 1)][(hi[2 - 1] + *ng - (-*ng + lo[2 - 1]) + 1)][(hi[3 - 1] + *ng - (-*ng + lo[3 - 1]) + 1)];
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
  int iLowerBound = (lo[0] -  *ng);
  int jLowerBound = (lo[1] -  *ng);
  int kLowerBound = (lo[2] -  *ng);
  //printf("Running diffterm in C version !!\n");
  for (k = lo[3 - 1]; k <= hi[3 - 1]; k = k + 1) 
    for (j = lo[2 - 1]; j <= hi[2 - 1]; j = j + 1) 
      for (i = lo[1 - 1]; i <= hi[1 - 1]; i = i + 1)
        difflux[irho - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] =  0.0e0;
  for (i = 1; i <= 3; i = i + 1) {
    dxinv[i - 1] = 1.0e0 / dx[i - 1];
  }
  for (k = lo[2] -  *ng; k <= hi[2] +  *ng; k = k + 1) {
    for (j = lo[1] -  *ng; j <= hi[1] +  *ng; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        ux[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qu - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] - q[qu - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + BET * (q[qu - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] - q[qu - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + GAM * (q[qu - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] - q[qu - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + DEL * (q[qu - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] - q[qu - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * dxinv[0];
        vx[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qv - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] - q[qv - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + BET * (q[qv - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] - q[qv - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + GAM * (q[qv - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] - q[qv - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + DEL * (q[qv - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] - q[qv - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * dxinv[0];
        wx[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qw - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] - q[qw - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + BET * (q[qw - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] - q[qw - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + GAM * (q[qw - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] - q[qw - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + DEL * (q[qw - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] - q[qw - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * dxinv[0];
      }
    }
  }
  for (k = lo[2] -  *ng; k <= hi[2] +  *ng; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0] -  *ng; i <= hi[0] +  *ng; i = i + 1) {
        uy[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qu - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] - q[qu - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + BET * (q[qu - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] - q[qu - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + GAM * (q[qu - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] - q[qu - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + DEL * (q[qu - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] - q[qu - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * dxinv[1];
        vy[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qv - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] - q[qv - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + BET * (q[qv - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] - q[qv - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + GAM * (q[qv - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] - q[qv - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + DEL * (q[qv - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] - q[qv - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * dxinv[1];
        wy[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qw - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] - q[qw - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + BET * (q[qw - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] - q[qw - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + GAM * (q[qw - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] - q[qw - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + DEL * (q[qw - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] - q[qw - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * dxinv[1];
      }
    }
  }
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1] -  *ng; j <= hi[1] +  *ng; j = j + 1) {
      for (i = lo[0] -  *ng; i <= hi[0] +  *ng; i = i + 1) {
        uz[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qu - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qu - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + BET * (q[qu - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qu - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + GAM * (q[qu - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qu - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + DEL * (q[qu - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qu - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * dxinv[2];
        vz[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qv - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qv - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + BET * (q[qv - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qv - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + GAM * (q[qv - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qv - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + DEL * (q[qv - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qv - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * dxinv[2];
        wz[k - kLowerBound][j - jLowerBound][i - iLowerBound] = (ALP * (q[qw - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qw - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + BET * (q[qw - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qw - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + GAM * (q[qw - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qw - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + DEL * (q[qw - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] - q[qw - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * dxinv[2];
      }
    }
  }
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        uxx = (CENTER * q[qu - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qu - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] + q[qu - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + OFF2 * (q[qu - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] + q[qu - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + OFF3 * (q[qu - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] + q[qu - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + OFF4 * (q[qu - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] + q[qu - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * pow(dxinv[0],2);
        uyy = (CENTER * q[qu - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qu - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] + q[qu - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + OFF2 * (q[qu - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] + q[qu - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + OFF3 * (q[qu - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] + q[qu - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + OFF4 * (q[qu - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] + q[qu - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * pow(dxinv[1],2);
        uzz = (CENTER * q[qu - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qu - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qu - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF2 * (q[qu - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qu - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF3 * (q[qu - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qu - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF4 * (q[qu - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qu - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * pow(dxinv[2],2);
        vyx = (ALP * (vy[k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] - vy[k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + BET * (vy[k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] - vy[k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + GAM * (vy[k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] - vy[k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + DEL * (vy[k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] - vy[k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * dxinv[0];
        wzx = (ALP * (wz[k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] - wz[k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + BET * (wz[k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] - wz[k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + GAM * (wz[k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] - wz[k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + DEL * (wz[k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] - wz[k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * dxinv[0];
        difflux[imx - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] =  *eta * (FourThirds * uxx + uyy + uzz + OneThird * (vyx + wzx));
      }
    }
  }
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        vxx = (CENTER * q[qv - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qv - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] + q[qv - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + OFF2 * (q[qv - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] + q[qv - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + OFF3 * (q[qv - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] + q[qv - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + OFF4 * (q[qv - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] + q[qv - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * pow(dxinv[0],2);
        vyy = (CENTER * q[qv - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qv - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] + q[qv - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + OFF2 * (q[qv - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] + q[qv - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + OFF3 * (q[qv - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] + q[qv - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + OFF4 * (q[qv - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] + q[qv - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * pow(dxinv[1],2);
        vzz = (CENTER * q[qv - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qv - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qv - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF2 * (q[qv - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qv - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF3 * (q[qv - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qv - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF4 * (q[qv - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qv - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * pow(dxinv[2],2);
        uxy = (ALP * (ux[k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] - ux[k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + BET * (ux[k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] - ux[k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + GAM * (ux[k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] - ux[k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + DEL * (ux[k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] - ux[k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * dxinv[1];
        wzy = (ALP * (wz[k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] - wz[k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + BET * (wz[k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] - wz[k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + GAM * (wz[k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] - wz[k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + DEL * (wz[k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] - wz[k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * dxinv[1];
        difflux[imy - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] =  *eta * (vxx + FourThirds * vyy + vzz + OneThird * (uxy + wzy));
      }
    }
  }
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        wxx = (CENTER * q[qw - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qw - 1][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] + q[qw - 1][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + OFF2 * (q[qw - 1][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] + q[qw - 1][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + OFF3 * (q[qw - 1][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] + q[qw - 1][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + OFF4 * (q[qw - 1][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] + q[qw - 1][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * pow(dxinv[0],2);
        wyy = (CENTER * q[qw - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qw - 1][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] + q[qw - 1][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + OFF2 * (q[qw - 1][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] + q[qw - 1][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + OFF3 * (q[qw - 1][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] + q[qw - 1][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + OFF4 * (q[qw - 1][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] + q[qw - 1][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * pow(dxinv[1],2);
        wzz = (CENTER * q[qw - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[qw - 1][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qw - 1][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF2 * (q[qw - 1][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qw - 1][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF3 * (q[qw - 1][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qw - 1][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF4 * (q[qw - 1][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[qw - 1][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * pow(dxinv[2],2);
        uxz = (ALP * (ux[k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] - ux[k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + BET * (ux[k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] - ux[k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + GAM * (ux[k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] - ux[k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + DEL * (ux[k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] - ux[k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * dxinv[2];
        vyz = (ALP * (vy[k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] - vy[k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + BET * (vy[k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] - vy[k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + GAM * (vy[k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] - vy[k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + DEL * (vy[k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] - vy[k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * dxinv[2];
        difflux[imz - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] =  *eta * (wxx + wyy + FourThirds * wzz + OneThird * (uxz + vyz));
      }
    }
  }
  for (k = lo[2]; k <= hi[2]; k = k + 1) {
    for (j = lo[1]; j <= hi[1]; j = j + 1) {
      for (i = lo[0]; i <= hi[0]; i = i + 1) {
        txx = (CENTER * q[5][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[5][k - kLowerBound][j - jLowerBound][i + 1 - iLowerBound] + q[5][k - kLowerBound][j - jLowerBound][i - 1 - iLowerBound]) + OFF2 * (q[5][k - kLowerBound][j - jLowerBound][i + 2 - iLowerBound] + q[5][k - kLowerBound][j - jLowerBound][i - 2 - iLowerBound]) + OFF3 * (q[5][k - kLowerBound][j - jLowerBound][i + 3 - iLowerBound] + q[5][k - kLowerBound][j - jLowerBound][i - 3 - iLowerBound]) + OFF4 * (q[5][k - kLowerBound][j - jLowerBound][i + 4 - iLowerBound] + q[5][k - kLowerBound][j - jLowerBound][i - 4 - iLowerBound])) * pow(dxinv[0],2);
        tyy = (CENTER * q[5][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[5][k - kLowerBound][j + 1 - jLowerBound][i - iLowerBound] + q[5][k - kLowerBound][j - 1 - jLowerBound][i - iLowerBound]) + OFF2 * (q[5][k - kLowerBound][j + 2 - jLowerBound][i - iLowerBound] + q[5][k - kLowerBound][j - 2 - jLowerBound][i - iLowerBound]) + OFF3 * (q[5][k - kLowerBound][j + 3 - jLowerBound][i - iLowerBound] + q[5][k - kLowerBound][j - 3 - jLowerBound][i - iLowerBound]) + OFF4 * (q[5][k - kLowerBound][j + 4 - jLowerBound][i - iLowerBound] + q[5][k - kLowerBound][j - 4 - jLowerBound][i - iLowerBound])) * pow(dxinv[1],2);
        tzz = (CENTER * q[5][k - kLowerBound][j - jLowerBound][i - iLowerBound] + OFF1 * (q[5][k + 1 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[5][k - 1 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF2 * (q[5][k + 2 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[5][k - 2 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF3 * (q[5][k + 3 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[5][k - 3 - kLowerBound][j - jLowerBound][i - iLowerBound]) + OFF4 * (q[5][k + 4 - kLowerBound][j - jLowerBound][i - iLowerBound] + q[5][k - 4 - kLowerBound][j - jLowerBound][i - iLowerBound])) * pow(dxinv[2],2);
        divu = TwoThirds * (ux[k - kLowerBound][j - jLowerBound][i - iLowerBound] + vy[k - kLowerBound][j - jLowerBound][i - iLowerBound] + wz[k - kLowerBound][j - jLowerBound][i - iLowerBound]);
        tauxx = 2.e0 * ux[k - kLowerBound][j - jLowerBound][i - iLowerBound] - divu;
        tauyy = 2.e0 * vy[k - kLowerBound][j - jLowerBound][i - iLowerBound] - divu;
        tauzz = 2.e0 * wz[k - kLowerBound][j - jLowerBound][i - iLowerBound] - divu;
        tauxy = uy[k - kLowerBound][j - jLowerBound][i - iLowerBound] + vx[k - kLowerBound][j - jLowerBound][i - iLowerBound];
        tauxz = uz[k - kLowerBound][j - jLowerBound][i - iLowerBound] + wx[k - kLowerBound][j - jLowerBound][i - iLowerBound];
        tauyz = vz[k - kLowerBound][j - jLowerBound][i - iLowerBound] + wy[k - kLowerBound][j - jLowerBound][i - iLowerBound];
        mechwork = tauxx * ux[k - kLowerBound][j - jLowerBound][i - iLowerBound] + tauyy * vy[k - kLowerBound][j - jLowerBound][i - iLowerBound] + tauzz * wz[k - kLowerBound][j - jLowerBound][i - iLowerBound] + pow(tauxy,2) + pow(tauxz,2) + pow(tauyz,2);
        mechwork =  *eta * mechwork + difflux[imx - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] * q[qu - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + difflux[imy - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] * q[qv - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound] + difflux[imz - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] * q[qw - 1][k - kLowerBound][j - jLowerBound][i - iLowerBound];
        difflux[iene - 1][k - kFluxLowerBound][j - jFluxLowerBound][i - iFluxLowerBound] =  *alam * (txx + tyy + tzz) + mechwork;
      }
    }
  }
}
