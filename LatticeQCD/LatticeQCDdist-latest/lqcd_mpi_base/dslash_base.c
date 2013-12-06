/*--------------------------------------------------------------------
	Dslash base code using MPI

	Copyright 2009-2013 IBM Research - Tokyo, IBM Corporation

	Written by
		Jun Doi  (doichan@jp.ibm.com)

--------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <complex.h>

#include <sys/time.h>

#include <mpi.h>

#include <omp.h>

#include "qcd.h"
#include "qcd_mult.h"


QCDReal qcdtKappa[4];
static int qcdBaseIeo = 0;

int qcdNx;
int qcdNy;
int qcdNz;
int qcdNt;
int qcdNxy;
int qcdNxyz;
int qcdNsite;

int qcdMyRank;
int qcdNProcs;

int qcdNetSize[4];
int qcdNetPos[4];
int qcdRankNeighbors[8];
int qcdSx;
int qcdSy;
int qcdSz;
int qcdSt;

static QCDHalfSpinor* qcdSendBuf[8];
static QCDHalfSpinor* qcdRecvBuf[8];

int qcdNumThreadsDivY[QCD_NUM_MAX_THREADS][2];
int qcdNumThreadsDivZ[QCD_NUM_MAX_THREADS][2];



typedef struct __qcd_RNG__
{
	int s;
	int e;
}QCDRng;

QCDRng qcdRngX[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

QCDRng qcdRngYOut[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
QCDRng qcdRngYIn[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
QCDRng qcdRngYInBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

QCDRng qcdRngZOut[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
QCDRng qcdRngZIn[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
QCDRng qcdRngZInBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

QCDRng qcdRngT[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
QCDRng qcdRngTBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];



void QCDDopr_MakeXPB(QCDHalfSpinor* pXP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex t[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i;

	pWP += qcdRngX[nid][tid].s*qcdNx;
	for(i=qcdRngX[nid][tid].s;i<qcdRngX[nid][tid].e;i++){
		QCDDopr_Load(v,pWP,DOPRSET_SPIN);

		//for Plus boundary (send to minus)
		QCD_UXP_HALF(hv,v);

		QCDDopr_Store(hv,(pXP+i),DOPRSET_HSPIN);

		pWP += qcdNx;
	}
}

void QCDDopr_MakeXMB(QCDHalfSpinor* pXM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex t[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i;

	pWM += qcdRngX[nid][tid].s*qcdNx;
	pUM += qcdRngX[nid][tid].s*qcdNx;
	for(i=qcdRngX[nid][tid].s;i<qcdRngX[nid][tid].e;i++){
		QCDDopr_Load(v,pWM,DOPRSET_SPIN);
		QCDDopr_LoadGauge(u,pUM);

		//for Minus boundary (send to plus)
		QCD_UXM_HALF(t,v);
		QCD_MUL_UM(hv,u,t);

		QCDDopr_Store(hv,(pXM+i),DOPRSET_HSPIN);

		pWM += qcdNx;
		pUM += qcdNx;
	}
}

void QCDDopr_XPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x;

	pWP += qcdRngX[nid][tid].s*qcdNx;
	pUP += qcdRngX[nid][tid].s*qcdNx;
	pV += qcdRngX[nid][tid].s*qcdNx;
	for(i=qcdRngX[nid][tid].s;i<qcdRngX[nid][tid].e;i++){
		for(x=0;x<qcdNx-1;x++){
			QCDDopr_Load(v,pV,DOPRSET_SPIN);


			//uxp
			QCDDopr_Load(w,pWP,DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,pUP);

			QCD_UXP_HALF(tv,w);
			QCD_MUL_UP(hv,u,tv);
			QCD_UXP_SET(v,hv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
			pUP += 1;
			pWP += 1;
		}
		pV += 1;
		pUP += 1;
		pWP += 1;
	}
}
void QCDDopr_XMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x;

	pWM += qcdRngX[nid][tid].s*qcdNx;
	pUM += qcdRngX[nid][tid].s*qcdNx;
	pV += qcdRngX[nid][tid].s*qcdNx;
	for(i=qcdRngX[nid][tid].s;i<qcdRngX[nid][tid].e;i++){
		pV += 1;
		pUM += 1;
		pWM += 1;
		for(x=1;x<qcdNx;x++){
			QCDDopr_Load(v,pV,DOPRSET_SPIN);

			//uxm
			QCDDopr_Load(w,pWM,DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,pUM);
			QCD_UXM_HALF(tv,w);
			QCD_MUL_UM(hv,u,tv);
			QCD_UXM_SET(v,hv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
			pUM += 1;
			pWM += 1;
		}
	}
}

void QCDDopr_SetXPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pXP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x;

	pUP += qcdRngX[nid][tid].s*qcdNx + qcdNx - 1;
	pV += qcdRngX[nid][tid].s*qcdNx + qcdNx - 1;
	for(i=qcdRngX[nid][tid].s;i<qcdRngX[nid][tid].e;i++){
		QCDDopr_Load(v,pV,DOPRSET_SPIN);

		//uxp
		QCDDopr_Load(hv,(pXP + i),DOPRSET_HSPIN);
		QCDDopr_LoadGauge(u,pUP);

		QCD_MUL_UP(tv,u,hv);
		QCD_UXP_SET(v,tv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += qcdNx;
		pUP += qcdNx;
	}
}


void QCDDopr_SetXMBnd(QCDSpinor* pV,QCDHalfSpinor* pXM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x;

	pV += qcdRngX[nid][tid].s*qcdNx;
	for(i=qcdRngX[nid][tid].s;i<qcdRngX[nid][tid].e;i++){
		QCDDopr_Load(v,pV,DOPRSET_SPIN);

		//uxm
		QCDDopr_Load(hv,(pXM+i),DOPRSET_HSPIN);
		QCD_UXM_SET(v,hv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += qcdNx;
	}
}


void QCDDopr_MakeXPB_EO(QCDHalfSpinor* pXP,QCDSpinor* pWP,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,y,z,t,ipar;

	ieo += qcdBaseIeo;

	i = 0;
	for(t=0;t<Nt;t++){
		for(z=0;z<Nz;z++){
			for(y=0;y<Ny;y++){
				ipar = (ieo + y + z + t) % 2;
				if(ipar != 0){
					QCDDopr_Load(v,pWP,DOPRSET_SPIN);

					//for Plus boundary (send to minus)
					QCD_UXP_HALF(hv,v);

					QCDDopr_Store(hv,(pXP+i),DOPRSET_HSPIN);
					i++;
				}
				pWP += Nx;
			}
		}
	}
}

void QCDDopr_MakeXMB_EO(QCDHalfSpinor* pXM,QCDMatrix* pUM,QCDSpinor* pWM,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,y,z,t,ipar;

	ieo += qcdBaseIeo;

	i = 0;
	for(t=0;t<Nt;t++){
		for(z=0;z<Nz;z++){
			for(y=0;y<Ny;y++){
				ipar = (ieo + y + z + t) % 2;
				if(ipar == 0){
					QCDDopr_Load(v,pWM,DOPRSET_SPIN);
					QCDDopr_LoadGauge(u,pUM);

					//for Minus boundary (send to plus)
					QCD_UXM_HALF(tv,v);
					QCD_MUL_UM(hv,u,tv);

					QCDDopr_Store(hv,(pXM+i),DOPRSET_HSPIN);
					i++;
				}
				pWM += Nx;
				pUM += Nx;
			}
		}
	}
}

void QCDDopr_XPin_EO(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x,y,z,t,ipar,n,iw;

	ieo += qcdBaseIeo;

	i = 0;
	for(t=0;t<Nt;t++){
		for(z=0;z<Nz;z++){
			for(y=0;y<Ny;y++){
				ipar = (ieo + y + z + t) % 2;

				if(ipar){
					n = Nx - 1;
					iw = 1;
				}
				else{
					n = Nx;
					iw = 0;
				}
				for(x=0;x<n;x++){
					QCDDopr_Load(v,pV + x,DOPRSET_SPIN);


					//uxp
					QCDDopr_Load(w,pWP + iw + x,DOPRSET_SPIN);
					QCDDopr_LoadGauge(u,pUP + x);

					QCD_UXP_HALF(tv,w);
					QCD_MUL_UP(hv,u,tv);
					QCD_UXP_SET(v,hv,kappa);

					QCDDopr_Store(v,pV + x,DOPRSET_SPIN);
				}
				pV += Nx;
				pWP += Nx;
				pUP += Nx;
			}
		}
	}
}

void QCDDopr_XMin_EO(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x,y,z,t,ipar,n,iv;

	ieo += qcdBaseIeo;

	i = 0;
	for(t=0;t<Nt;t++){
		for(z=0;z<Nz;z++){
			for(y=0;y<Ny;y++){
				ipar = (ieo + y + z + t) % 2;

				if(ipar == 0){
					n = Nx - 1;
					iv = 1;
				}
				else{
					n = Nx;
					iv = 0;
				}
				for(x=0;x<n;x++){
					QCDDopr_Load(v,pV + x + iv,DOPRSET_SPIN);

					//uxm
					QCDDopr_Load(w,pWM + x,DOPRSET_SPIN);
					QCDDopr_LoadGauge(u,pUM + x);
					QCD_UXM_HALF(tv,w);
					QCD_MUL_UM(hv,u,tv);
					QCD_UXM_SET(v,hv,kappa);

					QCDDopr_Store(v,pV + x + iv,DOPRSET_SPIN);
				}
				pV += Nx;
				pWM += Nx;
				pUM += Nx;
			}
		}
	}
}

void QCDDopr_SetXPBnd_EO(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pXP,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x,y,z,t,ipar,n,iv;

	ieo += qcdBaseIeo;

	pV += Nx - 1;
	pUP += Nx - 1;
	i = 0;
	for(t=0;t<Nt;t++){
		for(z=0;z<Nz;z++){
			for(y=0;y<Ny;y++){
				ipar = (ieo + y + z + t) % 2;
				if(ipar){
					QCDDopr_Load(v,pV,DOPRSET_SPIN);

					//uxp
					QCDDopr_Load(hv,(pXP + i),DOPRSET_HSPIN);
					QCDDopr_LoadGauge(u,pUP);

					QCD_MUL_UP(tv,u,hv);
					QCD_UXP_SET(v,tv,kappa);

					QCDDopr_Store(v,pV,DOPRSET_SPIN);
					i++;
				}
				pV += Nx;
				pUP += Nx;
			}
		}
	}
}


void QCDDopr_SetXMBnd_EO(QCDSpinor* pV,QCDHalfSpinor* pXM,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x,y,z,t,ipar,n,iv;

	ieo += qcdBaseIeo;

	i = 0;
	for(t=0;t<Nt;t++){
		for(z=0;z<Nz;z++){
			for(y=0;y<Ny;y++){
				ipar = (ieo + y + z + t) % 2;
				if(ipar == 0){
					QCDDopr_Load(v,pV,DOPRSET_SPIN);

					//uxm
					QCDDopr_Load(hv,(pXM+i),DOPRSET_HSPIN);
					QCD_UXM_SET(v,hv,kappa);

					QCDDopr_Store(v,pV,DOPRSET_SPIN);
					i++;
				}
				pV += Nx;
			}
		}
	}
}


void QCDDopr_MakeYPB(QCDHalfSpinor* pYP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;

	pYP += qcdRngYOut[nid][tid].s*qcdNx;
	pWP += qcdRngYOut[nid][tid].s*qcdNxy;
	for(i=qcdRngYOut[nid][tid].s;i<qcdRngYOut[nid][tid].e;i++){
		for(j=qcdRngYInBnd[nid][tid].s;j<qcdRngYInBnd[nid][tid].e;j++){
			QCDDopr_Load(v,(pWP + j),DOPRSET_SPIN);

			//for Plus boundary (send to minus)
			QCD_UYP_HALF(hv,v);

#ifdef QCD_SHIFT_Y
			QCDDopr_StoreShiftMinus(hv,(pYP + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store(hv,(pYP + j),DOPRSET_HSPIN);
#endif
		}
		pYP += qcdNx;
		pWP += qcdNxy;
	}
}

void QCDDopr_MakeYMB(QCDHalfSpinor* pYM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;

	pYM += qcdRngYOut[nid][tid].s*qcdNx;
	pWM += qcdRngYOut[nid][tid].s*qcdNxy;
	pUM += qcdRngYOut[nid][tid].s*qcdNxy;
	for(i=qcdRngYOut[nid][tid].s;i<qcdRngYOut[nid][tid].e;i++){
		for(j=qcdRngYInBnd[nid][tid].s;j<qcdRngYInBnd[nid][tid].e;j++){
			QCDDopr_Load(v,(pWM + j),DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,(pUM + j));

			//for Minus boundary (send to plus)
			QCD_UYM_HALF(tv,v);
			QCD_MUL_UM(hv,u,tv);

#ifdef QCD_SHIFT_Y
			QCDDopr_StoreShiftPlus(hv,(pYM + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store(hv,(pYM + j),DOPRSET_HSPIN);
#endif

		}
		pYM += qcdNx;
		pWM += qcdNxy;
		pUM += qcdNxy;
	}
}



void QCDDopr_YPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,y;

	pWP += qcdRngYOut[nid][tid].s*qcdNxy;
	pUP += qcdRngYOut[nid][tid].s*qcdNxy;
	pV += qcdRngYOut[nid][tid].s*qcdNxy;
	for(i=qcdRngYOut[nid][tid].s;i<qcdRngYOut[nid][tid].e;i++){
		for(j=qcdRngYIn[nid][tid].s;j<qcdRngYIn[nid][tid].e;j++){
			QCDDopr_Load(v,(pV + j),DOPRSET_SPIN);

			//uyp
			QCDDopr_Load(w,(pWP + j),DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,(pUP + j));

			QCD_UYP_HALF(tv,w);
			QCD_MUL_UP(hv,u,tv);
			QCD_UYP_SET(v,hv,kappa);

			QCDDopr_Store(v,(pV + j),DOPRSET_SPIN);
		}
		pV += qcdNxy;
		pUP += qcdNxy;
		pWP += qcdNxy;
	}
}

void QCDDopr_YMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,y;

	pV += qcdNx;
	pUM += qcdNx;
	pWM += qcdNx;
	pWM += qcdRngYOut[nid][tid].s*qcdNxy;
	pUM += qcdRngYOut[nid][tid].s*qcdNxy;
	pV += qcdRngYOut[nid][tid].s*qcdNxy;
	for(i=qcdRngYOut[nid][tid].s;i<qcdRngYOut[nid][tid].e;i++){
		for(j=qcdRngYIn[nid][tid].s;j<qcdRngYIn[nid][tid].e;j++){
			QCDDopr_Load(v,(pV + j),DOPRSET_SPIN);

			//uym
			QCDDopr_Load(w,(pWM + j),DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,(pUM + j));
			QCD_UYM_HALF(tv,w);
			QCD_MUL_UM(hv,u,tv);
			QCD_UYM_SET(v,hv,kappa);

			QCDDopr_Store(v,(pV + j),DOPRSET_SPIN);
		}
		pV += qcdNxy;
		pUM += qcdNxy;
		pWM += qcdNxy;
	}
}

void QCDDopr_SetYPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pYP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,y;

	pYP += qcdRngYOut[nid][tid].s*qcdNx;
	pV += qcdNxy - qcdNx;
	pUP += qcdNxy - qcdNx;
	pUP += qcdRngYOut[nid][tid].s*qcdNxy;
	pV += qcdRngYOut[nid][tid].s*qcdNxy;
	for(i=qcdRngYOut[nid][tid].s;i<qcdRngYOut[nid][tid].e;i++){
		for(j=qcdRngYInBnd[nid][tid].s;j<qcdRngYInBnd[nid][tid].e;j++){
			QCDDopr_Load(v,(pV + j),DOPRSET_SPIN);

			//uyp
			QCDDopr_Load(hv,(pYP + j),DOPRSET_HSPIN);
			QCDDopr_LoadGauge(u,(pUP + j));
			QCD_MUL_UP(tv,u,hv);
			QCD_UYP_SET(v,tv,kappa);

			QCDDopr_Store(v,(pV + j),DOPRSET_SPIN);
		}
		pYP += qcdNx;
		pV += qcdNxy;
		pUP += qcdNxy;
	}
}


void QCDDopr_SetYMBnd(QCDSpinor* pV,QCDHalfSpinor* pYM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,y;

	pYM += qcdRngYOut[nid][tid].s*qcdNx;
	pV += qcdRngYOut[nid][tid].s*qcdNxy;
	for(i=qcdRngYOut[nid][tid].s;i<qcdRngYOut[nid][tid].e;i++){
		for(j=qcdRngYInBnd[nid][tid].s;j<qcdRngYInBnd[nid][tid].e;j++){
			QCDDopr_Load(v,(pV + j),DOPRSET_SPIN);

			//uym
			QCDDopr_Load(hv,(pYM+j),DOPRSET_HSPIN);
			QCD_UYM_SET(v,hv,kappa);

			QCDDopr_Store(v,(pV + j),DOPRSET_SPIN);
		}
		pYM += qcdNx;
		pV += qcdNxy;
	}
}


void QCDDopr_MakeZPB(QCDHalfSpinor* pZP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;

	pZP += qcdRngZOut[nid][tid].s*qcdNxy;
	pWP += qcdRngZOut[nid][tid].s*qcdNxyz;
	for(i=qcdRngZOut[nid][tid].s;i<qcdRngZOut[nid][tid].e;i++){
		for(j=qcdRngZInBnd[nid][tid].s;j<qcdRngZInBnd[nid][tid].e;j++){
			//for Plus boundary (send to minus)
			QCDDopr_Load(v,(pWP + j),DOPRSET_SPIN);
			QCD_UZP_HALF(hv,v);

#ifdef QCD_SHIFT_Z
			QCDDopr_StoreShiftMinus(hv,(pZP + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store(hv,(pZP + j),DOPRSET_HSPIN);
#endif
		}
		pZP += qcdNxy;
		pWP += qcdNxyz;
	}
}


void QCDDopr_MakeZMB(QCDHalfSpinor* pZM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;

	pZM += qcdRngZOut[nid][tid].s*qcdNxy;
	pWM += qcdRngZOut[nid][tid].s*qcdNxyz;
	pUM += qcdRngZOut[nid][tid].s*qcdNxyz;
	for(i=qcdRngZOut[nid][tid].s;i<qcdRngZOut[nid][tid].e;i++){
		for(j=qcdRngZInBnd[nid][tid].s;j<qcdRngZInBnd[nid][tid].e;j++){
			//for Minus boundary (send to plus)
			QCDDopr_Load(v,(pWM + j),DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,(pUM + j));

			QCD_UZM_HALF(tv,v);
			QCD_MUL_UM(hv,u,tv);

#ifdef QCD_SHIFT_Z
			QCDDopr_StoreShiftPlus(hv,(pZM + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store(hv,(pZM + j),DOPRSET_HSPIN);
#endif

		}
		pZM += qcdNxy;
		pWM += qcdNxyz;
		pUM += qcdNxyz;
	}
}

void QCDDopr_ZPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,z;

	pV += qcdRngZOut[nid][tid].s*qcdNxyz;
	pWP += qcdRngZOut[nid][tid].s*qcdNxyz;
	pUP += qcdRngZOut[nid][tid].s*qcdNxyz;
	for(i=qcdRngZOut[nid][tid].s;i<qcdRngZOut[nid][tid].e;i++){
		for(j=qcdRngZIn[nid][tid].s;j<qcdRngZIn[nid][tid].e;j++){
			QCDDopr_Load(v,(pV + j),DOPRSET_SPIN);

			//uzp
			QCDDopr_Load(w,(pWP + j),DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,(pUP + j));

			QCD_UZP_HALF(tv,w);
			QCD_MUL_UP(hv,u,tv);
			QCD_UZP_SET(v,hv,kappa);

			QCDDopr_Store(v,(pV + j),DOPRSET_SPIN);
		}
		pV += qcdNxyz;
		pUP += qcdNxyz;
		pWP += qcdNxyz;
	}
}

void QCDDopr_ZMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,z;

	pV += qcdNxy;
	pUM += qcdNxy;
	pWM += qcdNxy;
	pV += qcdRngZOut[nid][tid].s*qcdNxyz;
	pWM += qcdRngZOut[nid][tid].s*qcdNxyz;
	pUM += qcdRngZOut[nid][tid].s*qcdNxyz;
	for(i=qcdRngZOut[nid][tid].s;i<qcdRngZOut[nid][tid].e;i++){
		for(j=qcdRngZIn[nid][tid].s;j<qcdRngZIn[nid][tid].e;j++){
			QCDDopr_Load(v,(pV + j),DOPRSET_SPIN);

			//uzm
			QCDDopr_Load(w,(pWM + j),DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,(pUM + j));
			QCD_UZM_HALF(tv,w);
			QCD_MUL_UM(hv,u,tv);
			QCD_UZM_SET(v,hv,kappa);

			QCDDopr_Store(v,(pV + j),DOPRSET_SPIN);
		}
		pV += qcdNxyz;
		pUM += qcdNxyz;
		pWM += qcdNxyz;
	}
}


void QCDDopr_SetZPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pZP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,z;

	pV += qcdNxyz - qcdNxy;
	pUP += qcdNxyz - qcdNxy;

	pZP += qcdRngZOut[nid][tid].s*qcdNxy;
	pUP += qcdRngZOut[nid][tid].s*qcdNxyz;
	pV += qcdRngZOut[nid][tid].s*qcdNxyz;
	for(i=qcdRngZOut[nid][tid].s;i<qcdRngZOut[nid][tid].e;i++){
		for(j=qcdRngZInBnd[nid][tid].s;j<qcdRngZInBnd[nid][tid].e;j++){
			QCDDopr_Load(v,(pV + j),DOPRSET_SPIN);

			//uzp
			QCDDopr_Load(hv,(pZP + j),DOPRSET_HSPIN);
			QCDDopr_LoadGauge(u,(pUP + j));
			QCD_MUL_UP(tv,u,hv);
			QCD_UZP_SET(v,tv,kappa);

			QCDDopr_Store(v,(pV + j),DOPRSET_SPIN);
		}
		pZP += qcdNxy;
		pUP += qcdNxyz;
		pV += qcdNxyz;
	}
}

void QCDDopr_SetZMBnd(QCDSpinor* pV,QCDHalfSpinor* pZM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,z;

	pZM += qcdRngZOut[nid][tid].s*qcdNxy;
	pV += qcdRngZOut[nid][tid].s*qcdNxyz;
	for(i=qcdRngZOut[nid][tid].s;i<qcdRngZOut[nid][tid].e;i++){
		for(j=qcdRngZInBnd[nid][tid].s;j<qcdRngZInBnd[nid][tid].e;j++){
			QCDDopr_Load(v,(pV+j),DOPRSET_SPIN);

			//uzm
			QCDDopr_Load(hv,(pZM+j),DOPRSET_HSPIN);
			QCD_UZM_SET(v,hv,kappa);

			QCDDopr_Store(v,(pV + j),DOPRSET_SPIN);
		}
		pZM += qcdNxy;
		pV += qcdNxyz;
	}
}

void QCDDopr_MakeTPB(QCDHalfSpinor* pTP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;

	for(i=qcdRngTBnd[nid][tid].s;i<qcdRngTBnd[nid][tid].e;i++){
		//for Plus boundary (send to minus)
		QCDDopr_Load(v,(pWP + j),DOPRSET_SPIN);

		QCD_UTP_HALF(hv,v);

		QCDDopr_Store(hv,(pTP + j),DOPRSET_HSPIN);
	}
}

void QCDDopr_MakeTMB(QCDHalfSpinor* pTM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;

	for(i=qcdRngTBnd[nid][tid].s;i<qcdRngTBnd[nid][tid].e;i++){
		//for Minus boundary (send to plus)
		QCDDopr_Load(v,(pWM + j),DOPRSET_SPIN);
		QCDDopr_LoadGauge(u,(pUM + j));

		QCD_UTM_HALF(tv,v);
		QCD_MUL_UM(hv,u,tv);

		QCDDopr_Store(hv,(pTM + j),DOPRSET_HSPIN);
	}
}

void QCDDopr_TPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nin,int Nt,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	for(t=0;t<Nt-1;t++){
		for(j=0;j<Nin;j++){
			QCDDopr_Load(v,pV,DOPRSET_SPIN);

			//utp
			QCDDopr_Load(w,pWP,DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,pUP);
			QCD_UTP_HALF(tv,w);
			QCD_MUL_UP(hv,u,tv);
			QCD_UTP_SET(v,hv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
			pUP += 1;
			pWP += 1;
		}
	}
}

void QCDDopr_TMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Nt,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	pV += Nin;
	pUM += Nin;
	pWM += Nin;

	for(t=1;t<Nt;t++){
		for(j=0;j<Nin;j++){
			QCDDopr_Load(v,pV,DOPRSET_SPIN);

			//utm
			QCDDopr_Load(w,pWM,DOPRSET_SPIN);
			QCDDopr_LoadGauge(u,pUM);
			QCD_UTM_HALF(tv,w);
			QCD_MUL_UM(hv,u,tv);
			QCD_UTM_SET(v,hv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
			pUM += 1;
			pWM += 1;
		}
	}

}


void QCDDopr_SetTPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pTP,int Nin,int Nt,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	pV += Nin*Nt - Nin;
	pUP += Nin*Nt - Nin;

	for(j=0;j<Nin;j++){
		QCDDopr_Load(v,pV,DOPRSET_SPIN);

		//utp
		QCDDopr_Load(hv,(pTP + j),DOPRSET_HSPIN);
		QCDDopr_LoadGauge(u,pUP);
		QCD_MUL_UP(tv,u,hv);
		QCD_UTP_SET(v,tv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += 1;
		pUP += 1;
	}
}


void QCDDopr_SetTMBnd(QCDSpinor* pV,QCDHalfSpinor* pTM,int Nin,int Nt,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	for(j=0;j<Nin;j++){
		QCDDopr_Load(v,pV,DOPRSET_SPIN);

		//utm
		QCDDopr_Load(hv,(pTM+j),DOPRSET_HSPIN);
		QCD_UTM_SET(v,hv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += 1;
	}
}

void QCDDopr_MakeTPB_dirac(QCDHalfSpinor* pTP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;

	for(i=qcdRngTBnd[nid][tid].s;i<qcdRngTBnd[nid][tid].e;i++){
		//for Plus boundary (send to minus)
		QCDDopr_Load(v,(pWP + i),DOPRSET_SPIN);

		QCD_UTP_DIRAC_HALF(hv,v);

		QCDDopr_Store(hv,(pTP + i),DOPRSET_HSPIN);
	}
}

void QCDDopr_MakeTMB_dirac(QCDHalfSpinor* pTM,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;

	for(i=qcdRngTBnd[nid][tid].s;i<qcdRngTBnd[nid][tid].e;i++){
		//for Minus boundary (send to plus)
		QCDDopr_Load(v,(pWM + i),DOPRSET_SPIN);
		QCDDopr_LoadGauge(u,(pUM + i));

		QCD_UTM_DIRAC_HALF(tv,v);
		QCD_MUL_UM(hv,u,tv);

		QCDDopr_Store(hv,(pTM + i),DOPRSET_HSPIN);
	}
}


void QCDDopr_TPin_dirac(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	for(i=qcdRngT[nid][tid].s;i<qcdRngT[nid][tid].e;i++){
		QCDDopr_Load(v,(pV + i),DOPRSET_SPIN);

		//utp
		QCDDopr_Load(w,(pWP + i),DOPRSET_SPIN);
		QCDDopr_LoadGauge(u,(pUP + i));
		QCD_UTP_DIRAC_HALF(tv,w);
		QCD_MUL_UP(hv,u,tv);
		QCD_UTP_DIRAC_SET(v,hv,kappa);

		QCDDopr_Store(v,(pV + i),DOPRSET_SPIN);

	}
}

void QCDDopr_TMin_dirac(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	pV += qcdNxyz;
	pUM += qcdNxyz;
	pWM += qcdNxyz;

	for(i=qcdRngT[nid][tid].s;i<qcdRngT[nid][tid].e;i++){
		QCDDopr_Load(v,(pV + i),DOPRSET_SPIN);

		//utm
		QCDDopr_Load(w,(pWM + i),DOPRSET_SPIN);
		QCDDopr_LoadGauge(u,(pUM + i));
		QCD_UTM_DIRAC_HALF(tv,w);
		QCD_MUL_UM(hv,u,tv);
		QCD_UTM_DIRAC_SET(v,hv,kappa);

		QCDDopr_Store(v,(pV + i),DOPRSET_SPIN);
	}

}


void QCDDopr_SetTPBnd_dirac(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pTP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	pV += qcdNsite - qcdNxyz;
	pUP += qcdNsite - qcdNxyz;

	for(i=qcdRngTBnd[nid][tid].s;i<qcdRngTBnd[nid][tid].e;i++){
		QCDDopr_Load(v,(pV + i),DOPRSET_SPIN);

		//utp
		QCDDopr_Load(hv,(pTP + i),DOPRSET_HSPIN);
		QCDDopr_LoadGauge(u,(pUP + i));
		QCD_MUL_UP(tv,u,hv);
		QCD_UTP_DIRAC_SET(v,tv,kappa);

		QCDDopr_Store(v,(pV + i),DOPRSET_SPIN);
	}
}


void QCDDopr_SetTMBnd_dirac(QCDSpinor* pV,QCDHalfSpinor* pTM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	for(i=qcdRngTBnd[nid][tid].s;i<qcdRngTBnd[nid][tid].e;i++){
		QCDDopr_Load(v,(pV + i),DOPRSET_SPIN);

		//utm
		QCDDopr_Load(hv,(pTM+i),DOPRSET_HSPIN);
		QCD_UTM_DIRAC_SET(v,hv,kappa);

		QCDDopr_Store(v,(pV + i),DOPRSET_SPIN);
	}
}


#define QCDDopr_GetRank(x,y,z,t) \
	((x) + (y) * qcdNetSize[0] + (z) * qcdNetSize[0]*qcdNetSize[1] + (t) * qcdNetSize[0]*qcdNetSize[1]*qcdNetSize[2])


int QCDGetGCD(int a,int b)
{
	int i,j,t;

	if(a == b){
		return a;
	}
	else if(a > b){
		t = b;
		j = a;
	}
	else{
		j = b;
		t = a;
	}
	do{
		i = j;
		j = t;
		t = j % i;
	}while(t != 0);

	return i;
}


void QCDDopr_Init(int Nx,int Ny,int Nz,int Nt,int npx,int npy,int npz,int npt,int myrank)
{
	int tid,nid;
	int noY,niY,noZ,niZ,ii,io;

	qcdNProcs = npx*npy*npz*npt;
	qcdMyRank = myrank;
	qcdNx = Nx;
	qcdNy = Ny;
	qcdNz = Nz;
	qcdNt = Nt;
	qcdNxy = Nx*Ny;
	qcdNxyz = qcdNxy*Nz;
	qcdNsite = qcdNxyz*Nt;

	qcdNetSize[0] = npx;
	qcdNetSize[1] = npy;
	qcdNetSize[2] = npz;
	qcdNetSize[3] = npt;

	qcdNetPos[0] = qcdMyRank % qcdNetSize[0];
	qcdNetPos[1] = (qcdMyRank/qcdNetSize[0]) % qcdNetSize[1];
	qcdNetPos[2] = (qcdMyRank/(qcdNetSize[0]*qcdNetSize[1])) % qcdNetSize[2];
	qcdNetPos[3] = qcdMyRank/(qcdNetSize[0]*qcdNetSize[1]*qcdNetSize[2]);

	qcdRankNeighbors[QCD_XP] = QCDDopr_GetRank((qcdNetPos[0] + 1) % qcdNetSize[0],qcdNetPos[1],qcdNetPos[2],qcdNetPos[3]);
	qcdRankNeighbors[QCD_XM] = QCDDopr_GetRank((qcdNetPos[0] + qcdNetSize[0] - 1) % qcdNetSize[0],qcdNetPos[1],qcdNetPos[2],qcdNetPos[3]);
	qcdRankNeighbors[QCD_YP] = QCDDopr_GetRank(qcdNetPos[0],(qcdNetPos[1] + 1) % qcdNetSize[1],qcdNetPos[2],qcdNetPos[3]);
	qcdRankNeighbors[QCD_YM] = QCDDopr_GetRank(qcdNetPos[0],(qcdNetPos[1] + qcdNetSize[1] - 1) % qcdNetSize[1],qcdNetPos[2],qcdNetPos[3]);
	qcdRankNeighbors[QCD_ZP] = QCDDopr_GetRank(qcdNetPos[0],qcdNetPos[1],(qcdNetPos[2] + 1) % qcdNetSize[2],qcdNetPos[3]);
	qcdRankNeighbors[QCD_ZM] = QCDDopr_GetRank(qcdNetPos[0],qcdNetPos[1],(qcdNetPos[2] + qcdNetSize[2] - 1) % qcdNetSize[2],qcdNetPos[3]);
	qcdRankNeighbors[QCD_TP] = QCDDopr_GetRank(qcdNetPos[0],qcdNetPos[1],qcdNetPos[2],(qcdNetPos[3] + 1) % qcdNetSize[3]);
	qcdRankNeighbors[QCD_TM] = QCDDopr_GetRank(qcdNetPos[0],qcdNetPos[1],qcdNetPos[2],(qcdNetPos[3] + qcdNetSize[3] - 1) % qcdNetSize[3]);


	qcdSendBuf[QCD_XP] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNy*qcdNz*qcdNt);
	qcdSendBuf[QCD_XM] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNy*qcdNz*qcdNt);
	qcdRecvBuf[QCD_XP] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNy*qcdNz*qcdNt);
	qcdRecvBuf[QCD_XM] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNy*qcdNz*qcdNt);

	qcdSendBuf[QCD_YP] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNz*qcdNt);
	qcdSendBuf[QCD_YM] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNz*qcdNt);
	qcdRecvBuf[QCD_YP] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNz*qcdNt);
	qcdRecvBuf[QCD_YM] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNz*qcdNt);

	qcdSendBuf[QCD_ZP] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNy*qcdNt);
	qcdSendBuf[QCD_ZM] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNy*qcdNt);
	qcdRecvBuf[QCD_ZP] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNy*qcdNt);
	qcdRecvBuf[QCD_ZM] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNy*qcdNt);

	qcdSendBuf[QCD_TP] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNy*qcdNz);
	qcdSendBuf[QCD_TM] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNy*qcdNz);
	qcdRecvBuf[QCD_TP] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNy*qcdNz);
	qcdRecvBuf[QCD_TM] = (QCDHalfSpinor*)malloc(sizeof(QCDHalfSpinor)*qcdNx*qcdNy*qcdNz);

	for(nid=1;nid<QCD_NUM_MAX_THREADS;nid++){
		//y
		noY = QCDGetGCD(qcdNt*qcdNz,nid);
		niY = nid / noY;

		//z
		noZ = QCDGetGCD(qcdNt,nid);
		niZ = nid / noZ;

		for(tid=0;tid<nid;tid++){
			//x
			qcdRngX[nid][tid].s = tid * qcdNy*qcdNz*qcdNt / nid;
			qcdRngX[nid][tid].e = (tid + 1) * qcdNy*qcdNz*qcdNt / nid;

			//y
			ii = tid % niY;
			io = tid / niY;
			qcdRngYOut[nid][tid].s = io * qcdNt*qcdNz / noY;
			qcdRngYOut[nid][tid].e = (io + 1) * qcdNt*qcdNz / noY;

			qcdRngYInBnd[nid][tid].s = ii * qcdNx / niY;
			qcdRngYInBnd[nid][tid].e = (ii + 1) * qcdNx / niY;

			qcdRngYIn[nid][tid].s = ii * (qcdNxy - qcdNx) / niY;
			qcdRngYIn[nid][tid].e = (ii + 1) * (qcdNxy - qcdNx) / niY;

			//z
			ii = tid % niZ;
			io = tid / niZ;

			qcdRngZOut[nid][tid].s = io * qcdNt / noZ;
			qcdRngZOut[nid][tid].e = (io + 1) * qcdNt / noZ;
			qcdRngZInBnd[nid][tid].s = ii * qcdNxy / niZ;
			qcdRngZInBnd[nid][tid].e = (ii + 1) * qcdNxy / niZ;
			qcdRngZIn[nid][tid].s = ii * (qcdNxyz-qcdNxy) / niZ;
			qcdRngZIn[nid][tid].e = (ii + 1) * (qcdNxyz-qcdNxy) / niZ;

			//t
			qcdRngT[nid][tid].s = tid * (qcdNsite - qcdNxyz) / nid;
			qcdRngT[nid][tid].e = (tid + 1) * (qcdNsite - qcdNxyz) / nid;

			qcdRngTBnd[nid][tid].s = tid * (qcdNxyz) / nid;
			qcdRngTBnd[nid][tid].e = (tid + 1) * (qcdNxyz) / nid;
		}
	}

}

void QCDDopr_Mult(QCDSpinor* pV,QCDMatrix* pU,QCDSpinor* pW,double k)
{
	MPI_Request reqSend[8];
	MPI_Request reqRecv[8];
	MPI_Status st;
	QCDMatrix* pUx;
	QCDMatrix* pUy;
	QCDMatrix* pUz;
	QCDMatrix* pUt;
	int i;

	qcdtKappa[0] = k;
	qcdtKappa[1] = k;
	qcdtKappa[2] = k;
	qcdtKappa[3] = k;

	pUx = pU;
	pUy = pU + qcdNsite;
	pUz = pU + qcdNsite*2;
	pUt = pU + qcdNsite*3;

/* #pragma omp parallel num_threads(8) */
#pragma omp parallel
	{
	int tid = 0,nid = 1;

	tid = omp_get_thread_num();
	nid = omp_get_num_threads();

	/* //debug */
	/* printf("nthreads: %d\n", nid); */
	/* printf("max_threads: %d\n", omp_get_max_threads()); */

	if(tid == 0){
		MPI_Irecv(qcdRecvBuf[QCD_TP],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TP],QCD_TP,MPI_COMM_WORLD,&reqRecv[QCD_TP]);
		MPI_Irecv(qcdRecvBuf[QCD_TM],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TM],QCD_TM,MPI_COMM_WORLD,&reqRecv[QCD_TM]);

		MPI_Irecv(qcdRecvBuf[QCD_XP],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XP],QCD_XP,MPI_COMM_WORLD,&reqRecv[QCD_XP]);
		MPI_Irecv(qcdRecvBuf[QCD_XM],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XM],QCD_XM,MPI_COMM_WORLD,&reqRecv[QCD_XM]);

		MPI_Irecv(qcdRecvBuf[QCD_YP],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YP],QCD_YP,MPI_COMM_WORLD,&reqRecv[QCD_YP]);
		MPI_Irecv(qcdRecvBuf[QCD_YM],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YM],QCD_YM,MPI_COMM_WORLD,&reqRecv[QCD_YM]);

		MPI_Irecv(qcdRecvBuf[QCD_ZP],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZP],QCD_ZP,MPI_COMM_WORLD,&reqRecv[QCD_ZP]);
		MPI_Irecv(qcdRecvBuf[QCD_ZM],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZM],QCD_ZM,MPI_COMM_WORLD,&reqRecv[QCD_ZM]);
	}

	//Send T
	QCDDopr_MakeTPB_dirac(qcdSendBuf[QCD_TP],pW,tid,nid);
#pragma omp barrier
	if(tid == 0){
		MPI_Isend(qcdSendBuf[QCD_TP],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TM],QCD_TP,MPI_COMM_WORLD,&reqSend[QCD_TP]);
	}

	QCDDopr_MakeTMB_dirac(qcdSendBuf[QCD_TM],pUt + qcdNsite-qcdNxyz,pW + qcdNsite-qcdNxyz,tid,nid);
#pragma omp barrier
	if(tid == 0){
		MPI_Isend(qcdSendBuf[QCD_TM],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TP],QCD_TM,MPI_COMM_WORLD,&reqSend[QCD_TM]);
	}

	//Send X
	QCDDopr_MakeXPB(qcdSendBuf[QCD_XP],pW,tid,nid);
#pragma omp barrier
	if(tid == 0){
		MPI_Isend(qcdSendBuf[QCD_XP],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XM],QCD_XP,MPI_COMM_WORLD,&reqSend[QCD_XP]);
	}

	QCDDopr_MakeXMB(qcdSendBuf[QCD_XM],pUx + qcdNx-1,pW + qcdNx-1,tid,nid);
#pragma omp barrier
	if(tid == 0){
		MPI_Isend(qcdSendBuf[QCD_XM],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XP],QCD_XM,MPI_COMM_WORLD,&reqSend[QCD_XM]);
	}


	//Send Y
	QCDDopr_MakeYPB(qcdSendBuf[QCD_YP],pW,tid,nid);
#pragma omp barrier
	if(tid == 0){
		MPI_Isend(qcdSendBuf[QCD_YP],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YM],QCD_YP,MPI_COMM_WORLD,&reqSend[QCD_YP]);
	}

	QCDDopr_MakeYMB(qcdSendBuf[QCD_YM],pUy + qcdNxy-qcdNx,pW + qcdNxy-qcdNx,tid,nid);
#pragma omp barrier
	if(tid == 0){
		MPI_Isend(qcdSendBuf[QCD_YM],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YP],QCD_YM,MPI_COMM_WORLD,&reqSend[QCD_YM]);
	}

	//Send Z
	QCDDopr_MakeZPB(qcdSendBuf[QCD_ZP],pW,tid,nid);
#pragma omp barrier
	if(tid == 0){
		MPI_Isend(qcdSendBuf[QCD_ZP],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZM],QCD_ZP,MPI_COMM_WORLD,&reqSend[QCD_ZP]);
	}

	QCDDopr_MakeZMB(qcdSendBuf[QCD_ZM],pUz + qcdNxyz-qcdNxy,pW + qcdNxyz-qcdNxy,tid,nid);
#pragma omp barrier
	if(tid == 0){
		MPI_Isend(qcdSendBuf[QCD_ZM],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZP],QCD_ZM,MPI_COMM_WORLD,&reqSend[QCD_ZM]);
	}

	QCDLA_Equate(pV + tid*qcdNsite/nid,pW + tid*qcdNsite/nid, (tid+1)*qcdNsite/nid - tid*qcdNsite/nid);
#pragma omp barrier

	QCDDopr_TPin_dirac(pV,pUt,pW + qcdNxyz,tid,nid);
#pragma omp barrier
	QCDDopr_TMin_dirac(pV,pUt-qcdNxyz,pW - qcdNxyz,tid,nid);
#pragma omp barrier
	QCDDopr_XPin(pV,pUx,pW+1,tid,nid);
#pragma omp barrier
	QCDDopr_XMin(pV,pUx-1,pW-1,tid,nid);
#pragma omp barrier

	QCDDopr_YPin(pV,pUy,pW + qcdNx,tid,nid);
#pragma omp barrier
	QCDDopr_YMin(pV,pUy-qcdNx,pW - qcdNx,tid,nid);
#pragma omp barrier
	QCDDopr_ZPin(pV,pUz,pW + qcdNxy,tid,nid);
#pragma omp barrier
	QCDDopr_ZMin(pV,pUz-qcdNxy,pW - qcdNxy,tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_TP],&st);
	}
#pragma omp barrier
	QCDDopr_SetTPBnd_dirac(pV,pUt,qcdRecvBuf[QCD_TP],tid,nid);
	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_TM],&st);
	}
#pragma omp barrier
	QCDDopr_SetTMBnd_dirac(pV,qcdRecvBuf[QCD_TM],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_XP],&st);
	}
#pragma omp barrier
	QCDDopr_SetXPBnd(pV,pUx,qcdRecvBuf[QCD_XP],tid,nid);
	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_XM],&st);
	}
#pragma omp barrier
	QCDDopr_SetXMBnd(pV,qcdRecvBuf[QCD_XM],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_YP],&st);
	}
#pragma omp barrier
	QCDDopr_SetYPBnd(pV,pUy,qcdRecvBuf[QCD_YP],tid,nid);
	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_YM],&st);
	}
#pragma omp barrier
	QCDDopr_SetYMBnd(pV,qcdRecvBuf[QCD_YM],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_ZP],&st);
	}
#pragma omp barrier
	QCDDopr_SetZPBnd(pV,pUz,qcdRecvBuf[QCD_ZP],tid,nid);
	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_ZM],&st);
	}
#pragma omp barrier
	QCDDopr_SetZMBnd(pV,qcdRecvBuf[QCD_ZM],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqSend[QCD_TP],&st);
		MPI_Wait(&reqSend[QCD_TM],&st);
		MPI_Wait(&reqSend[QCD_XP],&st);
		MPI_Wait(&reqSend[QCD_XM],&st);
		MPI_Wait(&reqSend[QCD_YP],&st);
		MPI_Wait(&reqSend[QCD_YM],&st);
		MPI_Wait(&reqSend[QCD_ZP],&st);
		MPI_Wait(&reqSend[QCD_ZM],&st);
	}
#pragma omp barrier

	}
}



void QCDDopr_H(QCDSpinor* pV,QCDMatrix* pU,QCDSpinor* pW,double k)
{
	int i;
	double _Complex v0,v1;

	QCDDopr_Mult(pV,pU,pW,-k);
//	QCDLA_MultGamma5(pV,pV,qcdNsite);

	for(i=0;i<qcdNsite;i++){
		v0 = pV[i].v[0];
		v1 = pV[i].v[3];
		pV[i].v[0] = pV[i].v[6];
		pV[i].v[3] = pV[i].v[9];
		pV[i].v[6] = v0;
		pV[i].v[9] = v1;

		v0 = pV[i].v[1];
		v1 = pV[i].v[4];
		pV[i].v[1] = pV[i].v[7];
		pV[i].v[4] = pV[i].v[10];
		pV[i].v[7] = v0;
		pV[i].v[10] = v1;

		v0 = pV[i].v[2];
		v1 = pV[i].v[5];
		pV[i].v[2] = pV[i].v[8];
		pV[i].v[5] = pV[i].v[11];
		pV[i].v[8] = v0;
		pV[i].v[11] = v1;
	}
}

void QCDDopr_DdagD(QCDSpinor* pV,QCDMatrix* pU,QCDSpinor* pW,QCDSpinor* pT,double k)
{
	QCDDopr_H(pT,pU,pW,k);
	QCDDopr_H(pV,pU,pT,k);
}



