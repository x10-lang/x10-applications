/*--------------------------------------------------------------------
	Dslash base code using MPI + CUDA

	Copyright 2015 Koichi Shirahata

	Written by
		Koichi Shirahata

--------------------------------------------------------------------*/

#ifndef __DSLASH_BASE_H__
#define __DSLASH_BASE_H__

// #include <stdio.h>
// #include <stdlib.h>
// #include <complex.h>
// #include <cuComplex.h>

// #include <sys/time.h>

// #include <mpi.h>

// #include <omp.h>

#include "qcd.h"
#include "qcd_mult.h"
#include "lib_vec.h"

// QCDReal qcdtKappa[4];
// static int qcdBaseIeo = 0;

// int qcdNx;
// int qcdNy;
// int qcdNz;
// int qcdNt;
// int qcdNxy;
// int qcdNxyz;
// int qcdNsite;

// int qcdMyRank;
// int qcdNProcs;

// int qcdNetSize[4];
// int qcdNetPos[4];
// int qcdRankNeighbors[8];
// int qcdSx;
// int qcdSy;
// int qcdSz;
// int qcdSt;

// int qcdNx;
// int qcdNy;
// int qcdNz;
// int qcdNt;
// int qcdNxy;
// int qcdNxyz;
// int qcdNsite;

extern int qcdNx;
extern int qcdNy;
extern int qcdNz;
extern int qcdNt;
extern int qcdNxy;
extern int qcdNxyz;
extern int qcdNsite;

extern int qcdMyRank;
extern int qcdNProcs;

extern int qcdNetSize[4];
extern int qcdNetPos[4];
extern int qcdRankNeighbors[8];
extern int qcdSx;
extern int qcdSy;
extern int qcdSz;
extern int qcdSt;

// static QCDHalfSpinor* qcdSendBuf[8];
// static QCDHalfSpinor* qcdRecvBuf[8];

// int qcdNumThreadsDivY[QCD_NUM_MAX_THREADS][2];
// int qcdNumThreadsDivZ[QCD_NUM_MAX_THREADS][2];



// typedef struct __qcd_RNG__
// {
// 	int s;
// 	int e;
// }QCDRng;

// QCDRng qcdRngX[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

// QCDRng qcdRngYOut[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
// QCDRng qcdRngYIn[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
// QCDRng qcdRngYInBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

// QCDRng qcdRngZOut[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
// QCDRng qcdRngZIn[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
// QCDRng qcdRngZInBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

// QCDRng qcdRngT[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
// QCDRng qcdRngTBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];



// void QCDDopr_MakeXPB(QCDHalfSpinor* pXP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_MakeXMB(QCDHalfSpinor* pXM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_XPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_XMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_SetXPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pXP,int tid,int nid);
// void QCDDopr_SetXMBnd(QCDSpinor* pV,QCDHalfSpinor* pXM,int tid,int nid);
// void QCDDopr_MakeXPB_EO(QCDHalfSpinor* pXP,QCDSpinor* pWP,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid);
// void QCDDopr_MakeXMB_EO(QCDHalfSpinor* pXM,QCDMatrix* pUM,QCDSpinor* pWM,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid);
// void QCDDopr_XPin_EO(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid);
// void QCDDopr_XMin_EO(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid);
// void QCDDopr_SetXPBnd_EO(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pXP,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid);
// void QCDDopr_SetXMBnd_EO(QCDSpinor* pV,QCDHalfSpinor* pXM,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid);
// void QCDDopr_MakeYPB(QCDHalfSpinor* pYP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_MakeYMB(QCDHalfSpinor* pYM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_YPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_YMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_SetYPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pYP,int tid,int nid);
// void QCDDopr_SetYMBnd(QCDSpinor* pV,QCDHalfSpinor* pYM,int tid,int nid);
// void QCDDopr_MakeZPB(QCDHalfSpinor* pZP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_MakeZMB(QCDHalfSpinor* pZM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_ZPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_ZMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_SetZPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pZP,int tid,int nid);
// void QCDDopr_SetZMBnd(QCDSpinor* pV,QCDHalfSpinor* pZM,int tid,int nid);
// void QCDDopr_MakeTPB(QCDHalfSpinor* pTP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_MakeTMB(QCDHalfSpinor* pTM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_TPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nin,int Nt,int tid,int nid);
// void QCDDopr_TMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Nt,int tid,int nid);
// void QCDDopr_SetTPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pTP,int Nin,int Nt,int tid,int nid);
// void QCDDopr_SetTMBnd(QCDSpinor* pV,QCDHalfSpinor* pTM,int Nin,int Nt,int tid,int nid);
// void QCDDopr_MakeTPB_dirac(QCDHalfSpinor* pTP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_MakeTMB_dirac(QCDHalfSpinor* pTM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_TPin_dirac(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int tid,int nid);
// void QCDDopr_TMin_dirac(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid);
// void QCDDopr_SetTPBnd_dirac(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pTP,int tid,int nid);
// void QCDDopr_SetTMBnd_dirac(QCDSpinor* pV,QCDHalfSpinor* pTM,int tid,int nid);
// int QCDGetGCD(int a,int b);
void QCDDopr_Init(int Nx,int Ny,int Nz,int Nt,int npx,int npy,int npz,int npt,int myrank);
// void QCDDopr_Mult(QCDSpinor* pV,QCDMatrix* pU,QCDSpinor* pW,double k);
// void QCDDopr_H(QCDSpinor* pV,QCDMatrix* pU,QCDSpinor* pW,double k);
// void QCDDopr_DdagD(QCDSpinor* pV,QCDMatrix* pU,QCDSpinor* pW,QCDSpinor* pT,double k);

// void cuQCDDopr_DdagD(QCDSpinor* dpV,QCDMatrix* dpU,QCDSpinor* dpW,QCDSpinor* dpT,double k);
void cuQCDDopr_DdagD(QCDComplex* dpV,QCDComplex* dpU,QCDComplex* dpW,QCDComplex* dpT,double k);

#endif //__DSLASH_BASE_H__
