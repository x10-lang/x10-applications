/*--------------------------------------------------------------------
	Lattice QCD linear algebra routines using CUDA

	Copyright 2015 Koichi Shirahata

	Written by
		Koichi Shirahata

--------------------------------------------------------------------*/

#ifndef __LIB_VEC_H__
#define __LIB_VEC_H__

#include "qcd.h"

void cuQCDLA_Init(int ns);
__global__ void cuQCDLA_Equate(QCDComplex* pV,QCDComplex* pW,int ns);
void cuQCDLA_Norm(double* AV, double* pV,int ns);
__global__ void cuQCDLA_MultAddScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns);
void cuQCDLA_DotProd(double* AV,double* pV,double* pW,int ns);
__global__ void cuQCDLA_MultScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns);

void QCDLA_SetConst(QCDComplex* pV,QCDReal a,int ns);
void QCDLA_Equate(QCDComplex* pV,QCDComplex* pW,int ns);
void QCDLA_MultScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns);
void QCDLA_MultAddScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns);
void QCDLA_Add_MultAddScalar(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double PRF,int ns);
void QCDLA_Add(QCDComplex* pV,QCDComplex* pW,int ns);
void QCDLA_Sub(QCDComplex* pV,QCDComplex* pW,int ns);
void QCDLA_Norm(double* AV,double* pV,int ns);
void QCDLA_Norm_Simple(double* AV,double* pV,int ns);
void QCDLA_DotProd(double* AV,double* pV,double* pW,int ns);
void QCDLA_MultScalar_Add(QCDComplex* pV,QCDComplex* pW,double PRF,int ns);
void QCDLA_AXPBY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double PRF1,double PRF2,int ns);
void QCDLA_AXPY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double a,int ns);
void QCDLA_AXMY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double a,int ns);
void QCDLA_AXPBYPZ(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,QCDComplex* pZ,double a,double b,int ns);
void QCDLA_AXPY_Norm(QCDComplex* pV,double* AV,QCDComplex* pX,QCDComplex* pY,double a,int ns);

#ifdef QCD_SPINOR_3x4
/*

0: w(1,1) w(2,1) 

1: w(3,1) w(1,2) 

2: w(2,2) w(3,2)


3: w(1,3) w(2,3) 

4: w(3,3) w(1,4) 

5: w(2,4) w(3,4)

*/

void QCDLA_MultGamma5(QCDComplex* pV,QCDComplex* pW,int ns);
void QCDLA_Proj_P(QCDComplex* pV,QCDComplex* pW,int ns);
void QCDLA_Proj_M(QCDComplex* pV,QCDComplex* pW,int ns);

#else	//QCD_SPINOR_3x4
void QCDLA_MultGamma5(QCDComplex* pV,QCDComplex* pW,int ns);
void QCDLA_Proj_P(QCDComplex* pV,QCDComplex* pW,int ns);
void QCDLA_Proj_M(QCDComplex* pV,QCDComplex* pW,int ns);

#endif

#endif //__LIB_VEC_H__
