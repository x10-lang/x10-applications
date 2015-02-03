/*--------------------------------------------------------------------
	Dslash base code using MPI + CUDA

	Copyright 2015 Koichi Shirahata

	Written by
		Koichi Shirahata

--------------------------------------------------------------------*/
/*--------------------------------------------------------------------
	Dslash base code using MPI

	Copyright 2009-2013 IBM Research - Tokyo, IBM Corporation

	Written by
		Jun Doi  (doichan@jp.ibm.com)

--------------------------------------------------------------------*/

#include "dslash_base.h"
#include <stdio.h>
#include <stdlib.h>
#include <complex.h>
#include <cuComplex.h>

#include <sys/time.h>

#include <helper_cuda.h>
#include <helper_functions.h>

#include <mpi.h>

#include <omp.h>

// #include "qcd.h"
// #include "qcd_mult.h"

    

QCDReal qcdtKappa[4];
static int qcdBaseIeo = 0;

__device__ QCDReal dqcdtKappa[4];

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

__device__ int dqcdNx;
__device__ int dqcdNy;
__device__ int dqcdNz;
__device__ int dqcdNt;
__device__ int dqcdNxy;
__device__ int dqcdNxyz;
__device__ int dqcdNsite;

static QCDComplex* qcdSendBuf[8];
static QCDComplex* qcdRecvBuf[8];

static QCDComplex* pqcdSendBuf[8];
static QCDComplex* pqcdRecvBuf[8];

static QCDComplex* dqcdSendBuf[8];
static QCDComplex* dqcdRecvBuf[8];

static cudaStream_t stream[8];
// static cudaStream_t stream[9];

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

__device__ QCDRng dqcdRngX[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

__device__ QCDRng dqcdRngYOut[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
__device__ QCDRng dqcdRngYIn[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
__device__ QCDRng dqcdRngYInBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

__device__ QCDRng dqcdRngZOut[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
__device__ QCDRng dqcdRngZIn[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
__device__ QCDRng dqcdRngZInBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];

__device__ QCDRng dqcdRngT[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];
__device__ QCDRng dqcdRngTBnd[QCD_NUM_MAX_THREADS][QCD_NUM_MAX_THREADS];


__global__ void cuQCDDopr_MakeXPB(QCDComplex* pXP,QCDComplex* pWP,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pWP += (dqcdRngX[nid][tid].s + gtid) * dqcdNx;
	for(i = gtid + dqcdRngX[nid][tid].s; i < dqcdRngX[nid][tid].e; i += stride){
	        QCDDopr_Load_Stride(v,pWP,dqcdNsite,DOPRSET_SPIN);

		//for Plus boundary (send to minus)
		QCD_UXP_HALF(hv,v);

		QCDDopr_Store_Stride(hv,(pXP+i),(dqcdNy*dqcdNz*dqcdNt),DOPRSET_HSPIN);

		pWP += stride * dqcdNx;
	}
}

__global__ void cuQCDDopr_MakeXMB(QCDComplex* pXM,QCDComplex* pUM,QCDComplex* pWM,int tid,int nid)
{
	QCDComplex t[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pWM += (dqcdRngX[nid][tid].s + gtid) * dqcdNx;
	pUM += (dqcdRngX[nid][tid].s + gtid) * dqcdNx;
	for(i = gtid + dqcdRngX[nid][tid].s; i < dqcdRngX[nid][tid].e; i += stride){
	        QCDDopr_Load_Stride(v,pWM,dqcdNsite,DOPRSET_SPIN);
		QCDDopr_LoadGauge_Stride(u,pUM);

		//for Minus boundary (send to plus)
		QCD_UXM_HALF(t,v);
		QCD_MUL_UM(hv,u,t);

		QCDDopr_Store_Stride(hv,(pXM+i),(dqcdNy*dqcdNz*dqcdNt),DOPRSET_HSPIN);

		pWM += stride * dqcdNx;
		pUM += stride * dqcdNx;
	}
}

__global__ void cuQCDDopr_XPin(QCDComplex* pV,QCDComplex* pUP,QCDComplex* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pWP += dqcdRngX[nid][tid].s + gtid;
	pUP += dqcdRngX[nid][tid].s + gtid;
	pV += dqcdRngX[nid][tid].s + gtid;
	for(i = gtid + dqcdRngX[nid][tid].s; i < dqcdRngX[nid][tid].e * dqcdNx; i += stride){
	        if(i % dqcdNx < dqcdNx - 1) {
		        QCDDopr_Load_Stride(v,pV,dqcdNsite,DOPRSET_SPIN);

			//uxp
			QCDDopr_Load_Stride(w,pWP,dqcdNsite,DOPRSET_SPIN);
			QCDDopr_LoadGauge_Stride(u,pUP);

			QCD_UXP_HALF(tv,w);
			QCD_MUL_UP(hv,u,tv);
			QCD_UXP_SET(v,hv,kappa);

			QCDDopr_Store_Stride(v,pV,dqcdNsite,DOPRSET_SPIN);

		}
		pV += stride;
		pUP += stride;
		pWP += stride;
	}
}

__global__ void cuQCDDopr_XMin(QCDComplex* pV,QCDComplex* pUM,QCDComplex* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	// int i,x;
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pWM += dqcdRngX[nid][tid].s + gtid;
	pUM += dqcdRngX[nid][tid].s + gtid;
	pV += dqcdRngX[nid][tid].s + gtid;

	pV += 1;
	pUM += 1;
	pWM += 1;
	for(i = gtid + dqcdRngX[nid][tid].s; i < dqcdRngX[nid][tid].e * dqcdNx; i += stride){
	        if(i % dqcdNx < dqcdNx - 1) {
		        QCDDopr_Load_Stride(v,pV,dqcdNsite,DOPRSET_SPIN);

			//uxm
			QCDDopr_Load_Stride(w,pWM,dqcdNsite,DOPRSET_SPIN);
			QCDDopr_LoadGauge_Stride(u,pUM);
			QCD_UXM_HALF(tv,w);
			QCD_MUL_UM(hv,u,tv);
			QCD_UXM_SET(v,hv,kappa);

			QCDDopr_Store_Stride(v,pV,dqcdNsite,DOPRSET_SPIN);

		}
		pV += stride;
		pUM += stride;
		pWM += stride;
	}
}

__global__ void cuQCDDopr_SetXPBnd(QCDComplex* pV,QCDComplex* pUP,QCDComplex* pXP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pUP += (dqcdRngX[nid][tid].s + gtid) * dqcdNx + dqcdNx - 1;
	pV += (dqcdRngX[nid][tid].s + gtid) * dqcdNx + dqcdNx - 1;
	for(i = gtid + dqcdRngX[nid][tid].s; i < dqcdRngX[nid][tid].e; i += stride){
	        QCDDopr_Load_Stride(v,pV,dqcdNsite,DOPRSET_SPIN);

		//uxp
		QCDDopr_Load_Stride(hv,(pXP + i),(dqcdNy*dqcdNz*dqcdNt),DOPRSET_HSPIN);
		QCDDopr_LoadGauge_Stride(u,pUP);

		QCD_MUL_UP(tv,u,hv);
		QCD_UXP_SET(v,tv,kappa);

		QCDDopr_Store_Stride(v,pV,dqcdNsite,DOPRSET_SPIN);

		pV += stride * dqcdNx;
		pUP += stride * dqcdNx;
	}
}

__global__ void cuQCDDopr_SetXMBnd(QCDComplex* pV,QCDComplex* pXM,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pV += (dqcdRngX[nid][tid].s + gtid) * dqcdNx;
	for(i = gtid + dqcdRngX[nid][tid].s; i < dqcdRngX[nid][tid].e; i += stride){
	        QCDDopr_Load_Stride(v,pV,dqcdNsite,DOPRSET_SPIN);

		//uxm
		QCDDopr_Load_Stride(hv,(pXM+i),(dqcdNy*dqcdNz*dqcdNt),DOPRSET_HSPIN);
		QCD_UXM_SET(v,hv,kappa);

		QCDDopr_Store_Stride(v,pV,dqcdNsite,DOPRSET_SPIN);

		pV += stride * dqcdNx;
	}
}


void QCDDopr_MakeXPB_EO(QCDHalfSpinor* pXP,QCDSpinor* pWP,int Nx,int Ny,int Nz,int Nt,int ieo,int tid,int nid)
{
	// QCDComplex tv[6*QCD_NUM_SIMD];
	// QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
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
	// int i,x,y,z,t,ipar,n,iw;
	int x,y,z,t,ipar,n,iw;

	ieo += qcdBaseIeo;

	// i = 0;
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
	// int i,x,y,z,t,ipar,n,iv;
	int x,y,z,t,ipar,n,iv;

	ieo += qcdBaseIeo;

	// i = 0;
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
	// QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	// int i,x,y,z,t,ipar,n,iv;
	int i,y,z,t,ipar;

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
	// QCDComplex tv[6*QCD_NUM_SIMD];
	// QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	// int i,x,y,z,t,ipar,n,iv;
	int i,y,z,t,ipar;

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

__global__ void cuQCDDopr_MakeYPB(QCDComplex* pYP,QCDComplex* pWP,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pYP += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNx;
	pWP += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	for(i = blockIdx.x + dqcdRngYOut[nid][tid].s; i < dqcdRngYOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngYInBnd[nid][tid].s; j < dqcdRngYInBnd[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pWP + j),dqcdNsite,DOPRSET_SPIN);

			//for Plus boundary (send to minus)
			QCD_UYP_HALF(hv,v);

#ifdef QCD_SHIFT_Y
			QCDDopr_StoreShiftMinus(hv,(pYP + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store_Stride(hv,(pYP + j),(dqcdNx*dqcdNz*dqcdNt),DOPRSET_HSPIN);
#endif
		}
		pYP += gridDim.x * dqcdNx;
		pWP += gridDim.x * dqcdNxy;
	}
}

__global__ void cuQCDDopr_MakeYMB(QCDComplex* pYM,QCDComplex* pUM,QCDComplex* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pYM += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNx;
	pWM += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pUM += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	for(i = blockIdx.x + dqcdRngYOut[nid][tid].s; i < dqcdRngYOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngYInBnd[nid][tid].s; j < dqcdRngYInBnd[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pWM + j),dqcdNsite,DOPRSET_SPIN);
			QCDDopr_LoadGauge_Stride(u,(pUM + j));

			//for Minus boundary (send to plus)
			QCD_UYM_HALF(tv,v);
			QCD_MUL_UM(hv,u,tv);

#ifdef QCD_SHIFT_Y
			QCDDopr_StoreShiftPlus(hv,(pYM + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store_Stride(hv,(pYM + j),(dqcdNx*dqcdNz*dqcdNt),DOPRSET_HSPIN);
#endif

		}
		pYM += gridDim.x * dqcdNx;
		pWM += gridDim.x * dqcdNxy;
		pUM += gridDim.x * dqcdNxy;
	}
}

__global__ void cuQCDDopr_YPin(QCDComplex* pV,QCDComplex* pUP,QCDComplex* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pWP += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pUP += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pV += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	for(i = blockIdx.x + dqcdRngYOut[nid][tid].s; i < dqcdRngYOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngYIn[nid][tid].s ; j < dqcdRngYIn[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);

			//uyp
			QCDDopr_Load_Stride(w,(pWP + j),dqcdNsite,DOPRSET_SPIN);
			QCDDopr_LoadGauge_Stride(u,(pUP + j));

			QCD_UYP_HALF(tv,w);
			QCD_MUL_UP(hv,u,tv);
			QCD_UYP_SET(v,hv,kappa);

			QCDDopr_Store_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);
		}
		pV += gridDim.x * dqcdNxy;
		pUP += gridDim.x * dqcdNxy;
		pWP += gridDim.x * dqcdNxy;
	}
}

__global__ void cuQCDDopr_YMin(QCDComplex* pV,QCDComplex* pUM,QCDComplex* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pV += dqcdNx;
	pUM += dqcdNx;
	pWM += dqcdNx;
	pWM += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pUM += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pV += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	for(i = blockIdx.x + dqcdRngYOut[nid][tid].s; i < dqcdRngYOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngYIn[nid][tid].s; j < dqcdRngYIn[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);

			//uym
			QCDDopr_Load_Stride(w,(pWM + j),dqcdNsite,DOPRSET_SPIN);
			QCDDopr_LoadGauge_Stride(u,(pUM + j));
			QCD_UYM_HALF(tv,w);
			QCD_MUL_UM(hv,u,tv);
			QCD_UYM_SET(v,hv,kappa);

			QCDDopr_Store_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);
		}
		pV += gridDim.x * dqcdNxy;
		pUM += gridDim.x * dqcdNxy;
		pWM += gridDim.x * dqcdNxy;
	}
}

__global__ void cuQCDDopr_SetYPBnd(QCDComplex* pV,QCDComplex* pUP,QCDComplex* pYP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pYP += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNx;
	pV += dqcdNxy - dqcdNx;
	pUP += dqcdNxy - dqcdNx;
	pUP += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pV += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	for(i = blockIdx.x + dqcdRngYOut[nid][tid].s; i < dqcdRngYOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngYInBnd[nid][tid].s; j < dqcdRngYInBnd[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);

			//uyp
			QCDDopr_Load_Stride(hv,(pYP + j),(dqcdNx*dqcdNz*dqcdNt),DOPRSET_HSPIN);
			QCDDopr_LoadGauge_Stride(u,(pUP + j));
			QCD_MUL_UP(tv,u,hv);
			QCD_UYP_SET(v,tv,kappa);

			QCDDopr_Store_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);
		}
		pYP += gridDim.x * dqcdNx;
		pV += gridDim.x * dqcdNxy;
		pUP += gridDim.x * dqcdNxy;
	}
}

__global__ void cuQCDDopr_SetYMBnd(QCDComplex* pV,QCDComplex* pYM,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pYM += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNx;
	pV += (dqcdRngYOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	for(i = blockIdx.x + dqcdRngYOut[nid][tid].s; i < dqcdRngYOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngYInBnd[nid][tid].s; j < dqcdRngYInBnd[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);

			//uym
			QCDDopr_Load_Stride(hv,(pYM+j),(dqcdNx*dqcdNz*dqcdNt),DOPRSET_HSPIN);
			QCD_UYM_SET(v,hv,kappa);

			QCDDopr_Store_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);
		}
		pYM += gridDim.x * dqcdNx;
		pV += gridDim.x * dqcdNxy;
	}
}

__global__ void cuQCDDopr_MakeZPB(QCDComplex* pZP,QCDComplex* pWP,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pZP += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pWP += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	for(i = blockIdx.x + dqcdRngZOut[nid][tid].s; i < dqcdRngZOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngZInBnd[nid][tid].s; j < dqcdRngZInBnd[nid][tid].e; j += blockDim.x){
			//for Plus boundary (send to minus)
		        QCDDopr_Load_Stride(v,(pWP + j),dqcdNsite,DOPRSET_SPIN);
			QCD_UZP_HALF(hv,v);

#ifdef QCD_SHIFT_Z
			QCDDopr_StoreShiftMinus(hv,(pZP + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store_Stride(hv,(pZP + j),(dqcdNx*dqcdNy*dqcdNt),DOPRSET_HSPIN);
#endif
		}
		pZP += gridDim.x * dqcdNxy;
		pWP += gridDim.x * dqcdNxyz;
	}
}

__global__ void cuQCDDopr_MakeZMB(QCDComplex* pZM,QCDComplex* pUM,QCDComplex* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pZM += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pWM += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	pUM += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	for(i = blockIdx.x + dqcdRngZOut[nid][tid].s; i < dqcdRngZOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngZInBnd[nid][tid].s; j < dqcdRngZInBnd[nid][tid].e; j += blockDim.x){
			//for Minus boundary (send to plus)
		        QCDDopr_Load_Stride(v,(pWM + j),dqcdNsite,DOPRSET_SPIN);
			QCDDopr_LoadGauge_Stride(u,(pUM + j));

			QCD_UZM_HALF(tv,v);
			QCD_MUL_UM(hv,u,tv);

#ifdef QCD_SHIFT_Z
			QCDDopr_StoreShiftPlus(hv,(pZM + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store_Stride(hv,(pZM + j),(dqcdNx*dqcdNy*dqcdNt),DOPRSET_HSPIN);
#endif

		}
		pZM += gridDim.x * dqcdNxy;
		pWM += gridDim.x * dqcdNxyz;
		pUM += gridDim.x * dqcdNxyz;
	}
}

__global__ void cuQCDDopr_ZPin(QCDComplex* pV,QCDComplex* pUP,QCDComplex* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pV += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	pWP += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	pUP += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	for(i = blockIdx.x + dqcdRngZOut[nid][tid].s; i < dqcdRngZOut[nid][tid].e; i += gridDim.x){
	        for(j = threadIdx.x + dqcdRngZIn[nid][tid].s; j < dqcdRngZIn[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);

			//uzp
			QCDDopr_Load_Stride(w,(pWP + j),dqcdNsite,DOPRSET_SPIN);
			QCDDopr_LoadGauge_Stride(u,(pUP + j));

			QCD_UZP_HALF(tv,w);
			QCD_MUL_UP(hv,u,tv);
			QCD_UZP_SET(v,hv,kappa);

			QCDDopr_Store_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);
		}
		pV += gridDim.x * dqcdNxyz;
		pUP += gridDim.x * dqcdNxyz;
		pWP += gridDim.x * dqcdNxyz;
	}
}

__global__ void cuQCDDopr_ZMin(QCDComplex* pV,QCDComplex* pUM,QCDComplex* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pV += dqcdNxy;
	pUM += dqcdNxy;
	pWM += dqcdNxy;
	pV += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	pWM += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	pUM += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	for(i = blockIdx.x + dqcdRngZOut[nid][tid].s; i < dqcdRngZOut[nid][tid].e; i += gridDim.x){
	        for(j = threadIdx.x + dqcdRngZIn[nid][tid].s; j < dqcdRngZIn[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);

			//uzm
			QCDDopr_Load_Stride(w,(pWM + j),dqcdNsite,DOPRSET_SPIN);
			QCDDopr_LoadGauge_Stride(u,(pUM + j));
			QCD_UZM_HALF(tv,w);
			QCD_MUL_UM(hv,u,tv);
			QCD_UZM_SET(v,hv,kappa);

			QCDDopr_Store_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);
		}
		pV += gridDim.x * dqcdNxyz;
		pUM += gridDim.x * dqcdNxyz;
		pWM += gridDim.x * dqcdNxyz;
	}
}

__global__ void cuQCDDopr_SetZPBnd(QCDComplex* pV,QCDComplex* pUP,QCDComplex* pZP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pV += dqcdNxyz - dqcdNxy;
	pUP += dqcdNxyz - dqcdNxy;

	pZP += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pUP += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	pV += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	for(i = blockIdx.x + dqcdRngZOut[nid][tid].s; i < dqcdRngZOut[nid][tid].e; i += gridDim.x){
		for(j = threadIdx.x + dqcdRngZInBnd[nid][tid].s; j < dqcdRngZInBnd[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);

			//uzp
			QCDDopr_Load_Stride(hv,(pZP + j),(dqcdNx*dqcdNy*dqcdNt),DOPRSET_HSPIN);
			QCDDopr_LoadGauge_Stride(u,(pUP + j));
			QCD_MUL_UP(tv,u,hv);
			QCD_UZP_SET(v,tv,kappa);

			QCDDopr_Store_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);
		}
		pZP += gridDim.x * dqcdNxy;
		pUP += gridDim.x * dqcdNxyz;
		pV += gridDim.x * dqcdNxyz;
	}
}

__global__ void cuQCDDopr_SetZMBnd(QCDComplex* pV,QCDComplex* pZM,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i,j;
	// int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	// int stride = blockDim.x * gridDim.x;

	pZM += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxy;
	pV += (dqcdRngZOut[nid][tid].s + blockIdx.x) * dqcdNxyz;
	for(i = blockIdx.x + dqcdRngZOut[nid][tid].s; i < dqcdRngZOut[nid][tid].e; i += gridDim.x){
		for(j= threadIdx.x + dqcdRngZInBnd[nid][tid].s; j < dqcdRngZInBnd[nid][tid].e; j += blockDim.x){
		        QCDDopr_Load_Stride(v,(pV+j),dqcdNsite,DOPRSET_SPIN);

			//uzm
			QCDDopr_Load_Stride(hv,(pZM+j),(dqcdNx*dqcdNy*dqcdNt),DOPRSET_HSPIN);
			QCD_UZM_SET(v,hv,kappa);

			QCDDopr_Store_Stride(v,(pV + j),dqcdNsite,DOPRSET_SPIN);
		}
		pZM += gridDim.x * dqcdNxy;
		pV += gridDim.x * dqcdNxyz;
	}
}

void QCDDopr_MakeTPB(QCDHalfSpinor* pTP,QCDSpinor* pWP,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
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
	// int i,j,t;
	int j,t;

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
	// int i,j,t;
	int j,t;

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
	// QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	// int i,j,t;
	int j;

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
	// QCDComplex tv[6*QCD_NUM_SIMD];
	// QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	// int i,j,t;
	int j;

	for(j=0;j<Nin;j++){
		QCDDopr_Load(v,pV,DOPRSET_SPIN);

		//utm
		QCDDopr_Load(hv,(pTM+j),DOPRSET_HSPIN);
		QCD_UTM_SET(v,hv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += 1;
	}
}

__global__ void cuQCDDopr_MakeTPB_dirac(QCDComplex* pTP,QCDComplex* pWP,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	for(i = gtid + dqcdRngTBnd[nid][tid].s; i < dqcdRngTBnd[nid][tid].e; i += stride){
		//for Plus boundary (send to minus)
	        QCDDopr_Load_Stride(v,(pWP + i),dqcdNsite,DOPRSET_SPIN);

		QCD_UTP_DIRAC_HALF(hv,v);

		QCDDopr_Store_Stride(hv,(pTP + i),(dqcdNx*dqcdNy*dqcdNz),DOPRSET_HSPIN);
	}
}

__global__ void cuQCDDopr_MakeTMB_dirac(QCDComplex* pTM,QCDComplex* pUM,QCDComplex* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	for(i = gtid + dqcdRngTBnd[nid][tid].s; i < dqcdRngTBnd[nid][tid].e; i += stride){
		//for Minus boundary (send to plus)
	        QCDDopr_Load_Stride(v,(pWM + i),dqcdNsite,DOPRSET_SPIN);
		QCDDopr_LoadGauge_Stride(u,(pUM + i));

		QCD_UTM_DIRAC_HALF(tv,v);
		QCD_MUL_UM(hv,u,tv);

		QCDDopr_Store_Stride(hv,(pTM + i),(dqcdNx*dqcdNy*dqcdNz),DOPRSET_HSPIN);
	}
}

__global__ void cuQCDDopr_TPin_dirac(QCDComplex* pV,QCDComplex* pUP,QCDComplex* pWP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	// int i,j,t;
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	for(i = gtid + dqcdRngT[nid][tid].s; i < dqcdRngT[nid][tid].e; i += stride){
	        QCDDopr_Load_Stride(v,(pV + i),dqcdNsite,DOPRSET_SPIN);

		//utp
		QCDDopr_Load_Stride(w,(pWP + i),dqcdNsite,DOPRSET_SPIN);
		QCDDopr_LoadGauge_Stride(u,(pUP + i));
		QCD_UTP_DIRAC_HALF(tv,w);
		QCD_MUL_UP(hv,u,tv);
		QCD_UTP_DIRAC_SET(v,hv,kappa);

		QCDDopr_Store_Stride(v,(pV + i),dqcdNsite,DOPRSET_SPIN);

	}
}

__global__ void cuQCDDopr_TMin_dirac(QCDComplex* pV,QCDComplex* pUM,QCDComplex* pWM,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pV += dqcdNxyz;
	pUM += dqcdNxyz;
	pWM += dqcdNxyz;

	for(i = gtid + dqcdRngT[nid][tid].s; i < dqcdRngT[nid][tid].e; i += stride){
	        QCDDopr_Load_Stride(v,(pV + i),dqcdNsite,DOPRSET_SPIN);

		//utm
		QCDDopr_Load_Stride(w,(pWM + i),dqcdNsite,DOPRSET_SPIN);
		QCDDopr_LoadGauge_Stride(u,(pUM + i));
		QCD_UTM_DIRAC_HALF(tv,w);
		QCD_MUL_UM(hv,u,tv);
		QCD_UTM_DIRAC_SET(v,hv,kappa);

		QCDDopr_Store_Stride(v,(pV + i),dqcdNsite,DOPRSET_SPIN);
	}

}

__global__ void cuQCDDopr_SetTPBnd_dirac(QCDComplex* pV,QCDComplex* pUP,QCDComplex* pTP,int tid,int nid)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pV += dqcdNsite - dqcdNxyz;
	pUP += dqcdNsite - dqcdNxyz;

	for(i = gtid + dqcdRngTBnd[nid][tid].s; i < dqcdRngTBnd[nid][tid].e; i += stride){
	        QCDDopr_Load_Stride(v,(pV + i),dqcdNsite,DOPRSET_SPIN);

		//utp
		QCDDopr_Load_Stride(hv,(pTP + i),(dqcdNx*dqcdNy*dqcdNz),DOPRSET_HSPIN);
		QCDDopr_LoadGauge_Stride(u,(pUP + i));
		QCD_MUL_UP(tv,u,hv);
		QCD_UTP_DIRAC_SET(v,tv,kappa);

		QCDDopr_Store_Stride(v,(pV + i),dqcdNsite,DOPRSET_SPIN);
	}
}


__global__ void cuQCDDopr_SetTMBnd_dirac(QCDComplex* pV,QCDComplex* pTM,int tid,int nid)
{
	QCDComplex v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = dqcdtKappa;
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	for(i = gtid + dqcdRngTBnd[nid][tid].s; i < dqcdRngTBnd[nid][tid].e; i += stride){
	        QCDDopr_Load_Stride(v,(pV + i),dqcdNsite,DOPRSET_SPIN);

		//utm
		QCDDopr_Load_Stride(hv,(pTM+i),(dqcdNx*dqcdNy*dqcdNz),DOPRSET_HSPIN);
		QCD_UTM_DIRAC_SET(v,hv,kappa);

		QCDDopr_Store_Stride(v,(pV + i),dqcdNsite,DOPRSET_SPIN);
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
	int i,noY,niY,noZ,niZ,ii,io;

	qcdNProcs = npx*npy*npz*npt;
	qcdMyRank = myrank;
	qcdNx = Nx;
	qcdNy = Ny;
	qcdNz = Nz;
	qcdNt = Nt;
	qcdNxy = Nx*Ny;
	qcdNxyz = qcdNxy*Nz;
	qcdNsite = qcdNxyz*Nt;

	checkCudaErrors(cudaMemcpyToSymbol(dqcdNx, &qcdNx, sizeof(int)));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdNy, &qcdNy, sizeof(int)));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdNz, &qcdNz, sizeof(int)));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdNt, &qcdNt, sizeof(int)));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdNxy, &qcdNxy, sizeof(int)));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdNxyz, &qcdNxyz, sizeof(int)));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdNsite, &qcdNsite, sizeof(int)));

	for (i = 0; i < 8; i++) {
	// for (i = 0; i < 9; i++) {
	    checkCudaErrors(cudaStreamCreateWithFlags(&stream[i], cudaStreamNonBlocking));
	    // checkCudaErrors(cudaStreamCreate(&stream[i]));
	    // checkCudaErrors(cudaEventCreateWithFlags(&event[i], cudaEventDisableTiming));
	}

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


        qcdSendBuf[QCD_XP] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt);
        qcdSendBuf[QCD_XM] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt);
        qcdRecvBuf[QCD_XP] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt);
        qcdRecvBuf[QCD_XM] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt);

	qcdSendBuf[QCD_YP] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt);
        qcdSendBuf[QCD_YM] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt);
	qcdRecvBuf[QCD_YP] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt);
        qcdRecvBuf[QCD_YM] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt);

        qcdSendBuf[QCD_ZP] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt);
	qcdSendBuf[QCD_ZM] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt);
        qcdRecvBuf[QCD_ZP] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt);
	qcdRecvBuf[QCD_ZM] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt);

        qcdSendBuf[QCD_TP] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz);
        qcdSendBuf[QCD_TM] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz);
        qcdRecvBuf[QCD_TP] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz);
        qcdRecvBuf[QCD_TM] = (QCDComplex*)malloc(sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz);

	checkCudaErrors(cudaMallocHost((void**)&pqcdSendBuf[QCD_XP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdSendBuf[QCD_XM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdRecvBuf[QCD_XP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdRecvBuf[QCD_XM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt));

	checkCudaErrors(cudaMallocHost((void**)&pqcdSendBuf[QCD_YP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdSendBuf[QCD_YM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdRecvBuf[QCD_YP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdRecvBuf[QCD_YM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt));

	checkCudaErrors(cudaMallocHost((void**)&pqcdSendBuf[QCD_ZP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdSendBuf[QCD_ZM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdRecvBuf[QCD_ZP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt));
	checkCudaErrors(cudaMallocHost((void**)&pqcdRecvBuf[QCD_ZM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt));

	checkCudaErrors(cudaMallocHost((void**)&pqcdSendBuf[QCD_TP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz));
	checkCudaErrors(cudaMallocHost((void**)&pqcdSendBuf[QCD_TM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz));
	checkCudaErrors(cudaMallocHost((void**)&pqcdRecvBuf[QCD_TP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz));
	checkCudaErrors(cudaMallocHost((void**)&pqcdRecvBuf[QCD_TM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz));

	checkCudaErrors(cudaMalloc((void**)&dqcdSendBuf[QCD_XP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdSendBuf[QCD_XM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdRecvBuf[QCD_XP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdRecvBuf[QCD_XM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt));

	checkCudaErrors(cudaMalloc((void**)&dqcdSendBuf[QCD_YP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdSendBuf[QCD_YM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdRecvBuf[QCD_YP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdRecvBuf[QCD_YM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt));

	checkCudaErrors(cudaMalloc((void**)&dqcdSendBuf[QCD_ZP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdSendBuf[QCD_ZM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdRecvBuf[QCD_ZP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt));
	checkCudaErrors(cudaMalloc((void**)&dqcdRecvBuf[QCD_ZM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt));

	checkCudaErrors(cudaMalloc((void**)&dqcdSendBuf[QCD_TP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz));
	checkCudaErrors(cudaMalloc((void**)&dqcdSendBuf[QCD_TM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz));
	checkCudaErrors(cudaMalloc((void**)&dqcdRecvBuf[QCD_TP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz));
	checkCudaErrors(cudaMalloc((void**)&dqcdRecvBuf[QCD_TM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz));


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

	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngX, qcdRngX, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));

	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngYOut, qcdRngYOut, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngYIn, qcdRngYIn, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngYInBnd, qcdRngYInBnd, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));

	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngZOut, qcdRngZOut, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngZIn, qcdRngZIn, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngZInBnd, qcdRngZInBnd, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));

	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngT, qcdRngT, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));
	checkCudaErrors(cudaMemcpyToSymbol(dqcdRngTBnd, qcdRngTBnd, sizeof(QCDRng)*QCD_NUM_MAX_THREADS*QCD_NUM_MAX_THREADS));
}

void cuQCDDopr_Mult(QCDComplex* dpV,QCDComplex* dpU,QCDComplex* dpW,double k)
{
	MPI_Request reqSend[8];
	MPI_Request reqRecv[8];
	MPI_Status st;
	// int i;

	QCDComplex* dpUx;
	QCDComplex* dpUy;
	QCDComplex* dpUz;
	QCDComplex* dpUt;

	dim3 threads(128,1,1);
	dim3 blocks(qcdNsite/threads.x,1,1);

	qcdtKappa[0] = k;
	qcdtKappa[1] = k;
	qcdtKappa[2] = k;
	qcdtKappa[3] = k;

	//debug
	checkCudaErrors(cudaMemcpyToSymbol(dqcdtKappa, qcdtKappa, sizeof(QCDReal)*4));

	dpUx = dpU;
	dpUy = dpU + qcdNsite;
	dpUz = dpU + qcdNsite*2;
	dpUt = dpU + qcdNsite*3;

/* #pragma omp parallel num_threads(8) */
#pragma omp parallel
	{
	int tid = 0,nid = 1;

#if 0
	tid = omp_get_thread_num();
	nid = omp_get_num_threads();
#endif
	/* //debug */
	// printf("nthreads: %d\n", nid);
	// printf("max_threads: %d\n", omp_get_max_threads());

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

	cuQCDDopr_MakeTPB_dirac<<<blocks, threads, 0, stream[QCD_TP]>>>(dqcdSendBuf[QCD_TP],dpW,tid,nid);
	cuQCDDopr_MakeTMB_dirac<<<blocks, threads, 0, stream[QCD_TM]>>>(dqcdSendBuf[QCD_TM],dpUt + qcdNsite-qcdNxyz,dpW + qcdNsite-qcdNxyz,tid,nid);
	cuQCDDopr_MakeXPB<<<blocks, threads, 0, stream[QCD_XP]>>>(dqcdSendBuf[QCD_XP],dpW,tid,nid);
	cuQCDDopr_MakeXMB<<<blocks, threads, 0, stream[QCD_XM]>>>(dqcdSendBuf[QCD_XM],dpUx + qcdNx-1,dpW + qcdNx-1,tid,nid);
	cuQCDDopr_MakeYPB<<<blocks, threads, 0, stream[QCD_YP]>>>(dqcdSendBuf[QCD_YP],dpW,tid,nid);
	cuQCDDopr_MakeYMB<<<blocks, threads, 0, stream[QCD_YM]>>>(dqcdSendBuf[QCD_YM],dpUy + qcdNxy-qcdNx,dpW + qcdNxy-qcdNx,tid,nid);
	cuQCDDopr_MakeZPB<<<blocks, threads, 0, stream[QCD_ZP]>>>(dqcdSendBuf[QCD_ZP],dpW,tid,nid);
	cuQCDDopr_MakeZMB<<<blocks, threads, 0, stream[QCD_ZM]>>>(dqcdSendBuf[QCD_ZM],dpUz + qcdNxyz-qcdNxy,dpW + qcdNxyz-qcdNxy,tid,nid);

	//Send T
#pragma omp barrier
	if(tid == 0){
	    checkCudaErrors(cudaMemcpyAsync(pqcdSendBuf[QCD_TP], dqcdSendBuf[QCD_TP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz, cudaMemcpyDeviceToHost, stream[QCD_TP]));
	    checkCudaErrors(cudaMemcpyAsync(qcdSendBuf[QCD_TP], pqcdSendBuf[QCD_TP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz, cudaMemcpyHostToHost, stream[QCD_TP]));
	    checkCudaErrors(cudaStreamSynchronize(stream[QCD_TP]));
	    MPI_Isend(qcdSendBuf[QCD_TP],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TM],QCD_TP,MPI_COMM_WORLD,&reqSend[QCD_TP]);
	}

#pragma omp barrier
	if(tid == 0){
	    checkCudaErrors(cudaMemcpyAsync(pqcdSendBuf[QCD_TM], dqcdSendBuf[QCD_TM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz, cudaMemcpyDeviceToHost, stream[QCD_TM]));
	    checkCudaErrors(cudaMemcpyAsync(qcdSendBuf[QCD_TM], pqcdSendBuf[QCD_TM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz, cudaMemcpyHostToHost, stream[QCD_TM]));
	    checkCudaErrors(cudaStreamSynchronize(stream[QCD_TM]));
	    MPI_Isend(qcdSendBuf[QCD_TM],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TP],QCD_TM,MPI_COMM_WORLD,&reqSend[QCD_TM]);
	}

	//Send X
#pragma omp barrier
	if(tid == 0){
	    checkCudaErrors(cudaMemcpyAsync(pqcdSendBuf[QCD_XP], dqcdSendBuf[QCD_XP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt, cudaMemcpyDeviceToHost, stream[QCD_XP]));
	    checkCudaErrors(cudaMemcpyAsync(qcdSendBuf[QCD_XP], pqcdSendBuf[QCD_XP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt, cudaMemcpyHostToHost, stream[QCD_XP]));
	    checkCudaErrors(cudaStreamSynchronize(stream[QCD_XP]));
	    MPI_Isend(qcdSendBuf[QCD_XP],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XM],QCD_XP,MPI_COMM_WORLD,&reqSend[QCD_XP]);
	}

#pragma omp barrier
	if(tid == 0){
	    checkCudaErrors(cudaMemcpyAsync(pqcdSendBuf[QCD_XM], dqcdSendBuf[QCD_XM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt, cudaMemcpyDeviceToHost, stream[QCD_XM]));
	    checkCudaErrors(cudaMemcpyAsync(qcdSendBuf[QCD_XM], pqcdSendBuf[QCD_XM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt, cudaMemcpyHostToHost, stream[QCD_XM]));
	    checkCudaErrors(cudaStreamSynchronize(stream[QCD_XM]));
	    MPI_Isend(qcdSendBuf[QCD_XM],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XP],QCD_XM,MPI_COMM_WORLD,&reqSend[QCD_XM]);
	}

	//Send Y
#pragma omp barrier
	if(tid == 0){
	    checkCudaErrors(cudaMemcpyAsync(pqcdSendBuf[QCD_YP], dqcdSendBuf[QCD_YP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt, cudaMemcpyDeviceToHost, stream[QCD_YP]));
	    checkCudaErrors(cudaMemcpyAsync(qcdSendBuf[QCD_YP], pqcdSendBuf[QCD_YP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt, cudaMemcpyHostToHost, stream[QCD_YP]));
	    checkCudaErrors(cudaStreamSynchronize(stream[QCD_YP]));
	    MPI_Isend(qcdSendBuf[QCD_YP],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YM],QCD_YP,MPI_COMM_WORLD,&reqSend[QCD_YP]);
	}

#pragma omp barrier
	if(tid == 0){
	    checkCudaErrors(cudaMemcpyAsync(pqcdSendBuf[QCD_YM], dqcdSendBuf[QCD_YM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt, cudaMemcpyDeviceToHost, stream[QCD_YM]));
	    checkCudaErrors(cudaMemcpyAsync(qcdSendBuf[QCD_YM], pqcdSendBuf[QCD_YM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt, cudaMemcpyHostToHost, stream[QCD_YM]));
	    checkCudaErrors(cudaStreamSynchronize(stream[QCD_YM]));
	    MPI_Isend(qcdSendBuf[QCD_YM],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YP],QCD_YM,MPI_COMM_WORLD,&reqSend[QCD_YM]);
	}

	//Send Z
#pragma omp barrier
	if(tid == 0){
	    checkCudaErrors(cudaMemcpyAsync(pqcdSendBuf[QCD_ZP], dqcdSendBuf[QCD_ZP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt, cudaMemcpyDeviceToHost, stream[QCD_ZP]));
	    checkCudaErrors(cudaMemcpyAsync(qcdSendBuf[QCD_ZP], pqcdSendBuf[QCD_ZP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt, cudaMemcpyHostToHost, stream[QCD_ZP]));
	    checkCudaErrors(cudaStreamSynchronize(stream[QCD_ZP]));
	    MPI_Isend(qcdSendBuf[QCD_ZP],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZM],QCD_ZP,MPI_COMM_WORLD,&reqSend[QCD_ZP]);
	}

#pragma omp barrier
	if(tid == 0){
	    checkCudaErrors(cudaMemcpyAsync(pqcdSendBuf[QCD_ZM], dqcdSendBuf[QCD_ZM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt, cudaMemcpyDeviceToHost, stream[QCD_ZM]));
	    checkCudaErrors(cudaMemcpyAsync(qcdSendBuf[QCD_ZM], pqcdSendBuf[QCD_ZM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt, cudaMemcpyHostToHost, stream[QCD_ZM]));
	    checkCudaErrors(cudaStreamSynchronize(stream[QCD_ZM]));
	    MPI_Isend(qcdSendBuf[QCD_ZM],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZP],QCD_ZM,MPI_COMM_WORLD,&reqSend[QCD_ZM]);
	}

	cuQCDLA_Equate<<<blocks, threads>>>(dpV + tid*qcdNsite/nid,dpW + tid*qcdNsite/nid, (tid+1)*qcdNsite/nid - tid*qcdNsite/nid);
	cuQCDDopr_TPin_dirac<<<blocks, threads>>>(dpV,dpUt,dpW + qcdNxyz,tid,nid);
	cuQCDDopr_TMin_dirac<<<blocks, threads>>>(dpV,dpUt-qcdNxyz,dpW - qcdNxyz,tid,nid);
	cuQCDDopr_XPin<<<blocks, threads>>>(dpV,dpUx,dpW+1,tid,nid);
	cuQCDDopr_XMin<<<blocks, threads>>>(dpV,dpUx-1,dpW-1,tid,nid);
	cuQCDDopr_YPin<<<blocks, threads>>>(dpV,dpUy,dpW + qcdNx,tid,nid);
	cuQCDDopr_YMin<<<blocks, threads>>>(dpV,dpUy-qcdNx,dpW - qcdNx,tid,nid);
	cuQCDDopr_ZPin<<<blocks, threads>>>(dpV,dpUz,dpW + qcdNxy,tid,nid);
	cuQCDDopr_ZMin<<<blocks, threads>>>(dpV,dpUz-qcdNxy,dpW - qcdNxy,tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_TP],&st);
		checkCudaErrors(cudaMemcpyAsync(pqcdRecvBuf[QCD_TP], qcdRecvBuf[QCD_TP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz, cudaMemcpyHostToHost, stream[QCD_TP]));
		checkCudaErrors(cudaMemcpyAsync(dqcdRecvBuf[QCD_TP], pqcdRecvBuf[QCD_TP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz, cudaMemcpyHostToDevice, stream[QCD_TP]));
	}
#pragma omp barrier
	checkCudaErrors(cudaStreamSynchronize(stream[QCD_TP]));
	cuQCDDopr_SetTPBnd_dirac<<<blocks, threads>>>(dpV,dpUt,dqcdRecvBuf[QCD_TP],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_TM],&st);
		checkCudaErrors(cudaMemcpyAsync(pqcdRecvBuf[QCD_TM], qcdRecvBuf[QCD_TM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz, cudaMemcpyHostToHost, stream[QCD_TM]));
		checkCudaErrors(cudaMemcpyAsync(dqcdRecvBuf[QCD_TM], pqcdRecvBuf[QCD_TM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNz, cudaMemcpyHostToDevice, stream[QCD_TM]));
	}
#pragma omp barrier
	checkCudaErrors(cudaStreamSynchronize(stream[QCD_TM]));
	cuQCDDopr_SetTMBnd_dirac<<<blocks, threads>>>(dpV,dqcdRecvBuf[QCD_TM],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_XP],&st);
		checkCudaErrors(cudaMemcpyAsync(pqcdRecvBuf[QCD_XP], qcdRecvBuf[QCD_XP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt, cudaMemcpyHostToHost, stream[QCD_XP]));
		checkCudaErrors(cudaMemcpyAsync(dqcdRecvBuf[QCD_XP], pqcdRecvBuf[QCD_XP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt, cudaMemcpyHostToDevice, stream[QCD_XP]));
	}
#pragma omp barrier
	checkCudaErrors(cudaStreamSynchronize(stream[QCD_XP]));
	cuQCDDopr_SetXPBnd<<<blocks, threads>>>(dpV,dpUx,dqcdRecvBuf[QCD_XP],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_XM],&st);
		checkCudaErrors(cudaMemcpyAsync(pqcdRecvBuf[QCD_XM], qcdRecvBuf[QCD_XM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt, cudaMemcpyHostToHost, stream[QCD_XM]));
		checkCudaErrors(cudaMemcpyAsync(dqcdRecvBuf[QCD_XM], pqcdRecvBuf[QCD_XM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNy*qcdNz*qcdNt, cudaMemcpyHostToDevice, stream[QCD_XM]));
	}
#pragma omp barrier
	checkCudaErrors(cudaStreamSynchronize(stream[QCD_XM]));
	cuQCDDopr_SetXMBnd<<<blocks, threads>>>(dpV,dqcdRecvBuf[QCD_XM],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_YP],&st);
		checkCudaErrors(cudaMemcpyAsync(pqcdRecvBuf[QCD_YP], qcdRecvBuf[QCD_YP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt, cudaMemcpyHostToHost, stream[QCD_YP]));
		checkCudaErrors(cudaMemcpyAsync(dqcdRecvBuf[QCD_YP], pqcdRecvBuf[QCD_YP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt, cudaMemcpyHostToDevice, stream[QCD_YP]));
	}
#pragma omp barrier
	checkCudaErrors(cudaStreamSynchronize(stream[QCD_YP]));
	cuQCDDopr_SetYPBnd<<<blocks, threads>>>(dpV,dpUy,dqcdRecvBuf[QCD_YP],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_YM],&st);
		checkCudaErrors(cudaMemcpyAsync(pqcdRecvBuf[QCD_YM], qcdRecvBuf[QCD_YM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt, cudaMemcpyHostToHost, stream[QCD_YM]));
		checkCudaErrors(cudaMemcpyAsync(dqcdRecvBuf[QCD_YM], pqcdRecvBuf[QCD_YM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNz*qcdNt, cudaMemcpyHostToDevice, stream[QCD_YM]));
	}
#pragma omp barrier
	checkCudaErrors(cudaStreamSynchronize(stream[QCD_YM]));
	cuQCDDopr_SetYMBnd<<<blocks, threads>>>(dpV,dqcdRecvBuf[QCD_YM],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_ZP],&st);
		checkCudaErrors(cudaMemcpyAsync(pqcdRecvBuf[QCD_ZP], qcdRecvBuf[QCD_ZP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt, cudaMemcpyHostToHost, stream[QCD_ZP]));
		checkCudaErrors(cudaMemcpyAsync(dqcdRecvBuf[QCD_ZP], pqcdRecvBuf[QCD_ZP], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt, cudaMemcpyHostToDevice, stream[QCD_ZP]));
	}
#pragma omp barrier
	checkCudaErrors(cudaStreamSynchronize(stream[QCD_ZP]));
	cuQCDDopr_SetZPBnd<<<blocks, threads>>>(dpV,dpUz,dqcdRecvBuf[QCD_ZP],tid,nid);

	if(tid == 0){
		MPI_Wait(&reqRecv[QCD_ZM],&st);
		checkCudaErrors(cudaMemcpyAsync(pqcdRecvBuf[QCD_ZM], qcdRecvBuf[QCD_ZM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt, cudaMemcpyHostToHost, stream[QCD_ZM]));
		checkCudaErrors(cudaMemcpyAsync(dqcdRecvBuf[QCD_ZM], pqcdRecvBuf[QCD_ZM], sizeof(QCDComplex)*QCD_HALF_SPINOR_SIZE*qcdNx*qcdNy*qcdNt, cudaMemcpyHostToDevice, stream[QCD_ZM]));
	}
#pragma omp barrier
	checkCudaErrors(cudaStreamSynchronize(stream[QCD_ZM]));
	cuQCDDopr_SetZMBnd<<<blocks, threads>>>(dpV,dqcdRecvBuf[QCD_ZM],tid,nid);

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

__global__ void cuQCDopr_MultGamma5(QCDComplex* pV)
{
	int i;
	int gtid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;
	cuDoubleComplex v0,v1;

	for(i = gtid; i < dqcdNsite; i += stride){
	        v0 = pV[SPINOR_ID(i, 0)];
		v1 = pV[SPINOR_ID(i, 3)];
		pV[SPINOR_ID(i, 0)] = pV[SPINOR_ID(i, 6)];
		pV[SPINOR_ID(i, 3)] = pV[SPINOR_ID(i, 9)];
		pV[SPINOR_ID(i, 6)] = v0;
		pV[SPINOR_ID(i, 9)] = v1;

		v0 = pV[SPINOR_ID(i, 1)];
		v1 = pV[SPINOR_ID(i, 4)];
		pV[SPINOR_ID(i, 1)] = pV[SPINOR_ID(i, 7)];
		pV[SPINOR_ID(i, 4)] = pV[SPINOR_ID(i, 10)];
		pV[SPINOR_ID(i, 7)] = v0;
		pV[SPINOR_ID(i, 10)] = v1;

		v0 = pV[SPINOR_ID(i, 2)];
		v1 = pV[SPINOR_ID(i, 5)];
		pV[SPINOR_ID(i, 2)] = pV[SPINOR_ID(i, 8)];
		pV[SPINOR_ID(i, 5)] = pV[SPINOR_ID(i, 11)];
		pV[SPINOR_ID(i, 8)] = v0;
		pV[SPINOR_ID(i, 11)] = v1;
	}
}

void cuQCDDopr_H(QCDComplex* dpV,QCDComplex* dpU,QCDComplex* dpW,double k)
{
    dim3 threads(128,1,1);
    dim3 blocks(qcdNsite/threads.x,1,1);

    cuQCDDopr_Mult(dpV,dpU,dpW,-k);
    cuQCDopr_MultGamma5<<<blocks, threads>>>(dpV);

}

void cuQCDDopr_DdagD(QCDComplex* dpV,QCDComplex* dpU,QCDComplex* dpW,QCDComplex* dpT,double k)
{
    cuQCDDopr_H(dpT,dpU,dpW,k);
    cuQCDDopr_H(dpV,dpU,dpT,k);
}
