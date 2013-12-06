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

#include "qcd.h"
#include "qcd_mult.h"


QCDReal qcdtKappa[4];
static int qcdBaseIeo = 0;


void QCDDopr_MakeXPB(QCDHalfSpinor* pXP,QCDSpinor* pWP,int Nx,int Nout)
{
	QCDComplex t[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i;

	for(i=0;i<Nout;i++){
		QCDDopr_Load(v,pWP,DOPRSET_SPIN);

		//for Plus boundary (send to minus)
		QCD_UXP_HALF(hv,v);

		QCDDopr_Store(hv,(pXP+i),DOPRSET_HSPIN);

		pWP += Nx;
	}
}

void QCDDopr_MakeXMB(QCDHalfSpinor* pXM,QCDMatrix* pUM,QCDSpinor* pWM,int Nx,int Nout)
{
	QCDComplex t[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i;

	for(i=0;i<Nout;i++){
		QCDDopr_Load(v,pWM,DOPRSET_SPIN);
		QCDDopr_LoadGauge(u,pUM);

		//for Minus boundary (send to plus)
		QCD_UXM_HALF(t,v);
		QCD_MUL_UM(hv,u,t);

		QCDDopr_Store(hv,(pXM+i),DOPRSET_HSPIN);

		pWM += Nx;
		pUM += Nx;
	}
}

void QCDDopr_XPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nx,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x;

	for(i=0;i<Nout;i++){
		for(x=0;x<Nx-1;x++){
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
void QCDDopr_XMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nx,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x;

	pV += 1;
	pUM += 1;
	pWM += 1;
	for(i=0;i<Nout;i++){
		for(x=1;x<Nx;x++){
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
		pV += 1;
		pUM += 1;
		pWM += 1;
	}
}

void QCDDopr_SetXPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pXP,int Nx,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x;

	pV += Nx - 1;
	pUP += Nx - 1;

	for(i=0;i<Nout;i++){
		QCDDopr_Load(v,pV,DOPRSET_SPIN);

		//uxp
		QCDDopr_Load(hv,(pXP + i),DOPRSET_HSPIN);
		QCDDopr_LoadGauge(u,pUP);

		QCD_MUL_UP(tv,u,hv);
		QCD_UXP_SET(v,tv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += Nx;
		pUP += Nx;
	}
}


void QCDDopr_SetXMBnd(QCDSpinor* pV,QCDHalfSpinor* pXM,int Nx,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,x;

	for(i=0;i<Nout;i++){
		QCDDopr_Load(v,pV,DOPRSET_SPIN);

		//uxm
		QCDDopr_Load(hv,(pXM+i),DOPRSET_HSPIN);
		QCD_UXM_SET(v,hv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += Nx;
	}
}


void QCDDopr_MakeXPB_EO(QCDHalfSpinor* pXP,QCDSpinor* pWP,int Nx,int Ny,int Nz,int Nt,int ieo)
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

void QCDDopr_MakeXMB_EO(QCDHalfSpinor* pXM,QCDMatrix* pUM,QCDSpinor* pWM,int Nx,int Ny,int Nz,int Nt,int ieo)
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

void QCDDopr_XPin_EO(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nx,int Ny,int Nz,int Nt,int ieo)
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

void QCDDopr_XMin_EO(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nx,int Ny,int Nz,int Nt,int ieo)
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

void QCDDopr_SetXPBnd_EO(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pXP,int Nx,int Ny,int Nz,int Nt,int ieo)
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


void QCDDopr_SetXMBnd_EO(QCDSpinor* pV,QCDHalfSpinor* pXM,int Nx,int Ny,int Nz,int Nt,int ieo)
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


void QCDDopr_MakeYPB(QCDHalfSpinor* pYP,QCDSpinor* pWP,int Nin,int Ny,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	int offset = Nin * Ny;

	for(i=0;i<Nout;i++){
		for(j=0;j<Nin;j++){
			QCDDopr_Load(v,(pWP + j),DOPRSET_SPIN);

			//for Plus boundary (send to minus)
			QCD_UYP_HALF(hv,v);

#ifdef QCD_SHIFT_Y
			QCDDopr_StoreShiftMinus(hv,(pYP + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store(hv,(pYP + j),DOPRSET_HSPIN);
#endif
		}
		pYP += Nin;
		pWP += offset;
	}
}

void QCDDopr_MakeYMB(QCDHalfSpinor* pYM,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Ny,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	int offset = Nin * Ny;

	for(i=0;i<Nout;i++){
		for(j=0;j<Nin;j++){
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
		pYM += Nin;
		pWM += offset;
		pUM += offset;
	}
}



void QCDDopr_MakeZPB(QCDHalfSpinor* pZP,QCDSpinor* pWP,int Nin,int Nz,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	int offset = Nin * Nz;

	for(i=0;i<Nout;i++){
		for(j=0;j<Nin;j++){
			//for Plus boundary (send to minus)
			QCDDopr_Load(v,(pWP + j),DOPRSET_SPIN);
			QCD_UZP_HALF(hv,v);

#ifdef QCD_SHIFT_Z
			QCDDopr_StoreShiftMinus(hv,(pZP + j),DOPRSET_HSPIN);
#else
			QCDDopr_Store(hv,(pZP + j),DOPRSET_HSPIN);
#endif
		}
		pZP += Nin;
		pWP += offset;
	}
}

void QCDDopr_YPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nin,int Ny,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,y;

	for(i=0;i<Nout;i++){
		for(y=0;y<Ny-1;y++){
			for(j=0;j<Nin;j++){
				QCDDopr_Load(v,pV,DOPRSET_SPIN);

				//uyp
				QCDDopr_Load(w,pWP,DOPRSET_SPIN);
				QCDDopr_LoadGauge(u,pUP);

				QCD_UYP_HALF(tv,w);
				QCD_MUL_UP(hv,u,tv);
				QCD_UYP_SET(v,hv,kappa);

				QCDDopr_Store(v,pV,DOPRSET_SPIN);

				pV += 1;
				pUP += 1;
				pWP += 1;
			}
		}
		pV += Nin;
		pUP += Nin;
		pWP += Nin;
	}
}

void QCDDopr_YMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Ny,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,y;

	pV += Nin;
	pUM += Nin;
	pWM += Nin;
	for(i=0;i<Nout;i++){
		for(y=1;y<Ny;y++){
			for(j=0;j<Nin;j++){
				QCDDopr_Load(v,pV,DOPRSET_SPIN);

				//uym
				QCDDopr_Load(w,pWM,DOPRSET_SPIN);
				QCDDopr_LoadGauge(u,pUM);
				QCD_UYM_HALF(tv,w);
				QCD_MUL_UM(hv,u,tv);
				QCD_UYM_SET(v,hv,kappa);

				QCDDopr_Store(v,pV,DOPRSET_SPIN);

				pV += 1;
				pUM += 1;
				pWM += 1;
			}
		}
		pV += Nin;
		pUM += Nin;
		pWM += Nin;
	}
}

void QCDDopr_SetYPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pYP,int Nin,int Ny,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,y;

	for(i=0;i<Nout;i++){
		pV += Ny*Nin - Nin;
		pUP += Ny*Nin - Nin;
		for(j=0;j<Nin;j++){
			QCDDopr_Load(v,pV,DOPRSET_SPIN);

			//uyp
			QCDDopr_Load(hv,(pYP + j),DOPRSET_HSPIN);
			QCDDopr_LoadGauge(u,pUP);
			QCD_MUL_UP(tv,u,hv);
			QCD_UYP_SET(v,tv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
			pUP += 1;
		}
		pYP += Nin;
	}
}


void QCDDopr_SetYMBnd(QCDSpinor* pV,QCDHalfSpinor* pYM,int Nin,int Ny,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,y;

	for(i=0;i<Nout;i++){
		for(j=0;j<Nin;j++){
			QCDDopr_Load(v,pV,DOPRSET_SPIN);

			//uym
			QCDDopr_Load(hv,(pYM+j),DOPRSET_HSPIN);
			QCD_UYM_SET(v,hv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
		}
		pYM += Nin;

		pV += Ny*Nin - Nin;
	}
}


void QCDDopr_MakeZMB(QCDHalfSpinor* pZM,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Nz,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	int offset = Nin * Nz;

	for(i=0;i<Nout;i++){
		for(j=0;j<Nin;j++){
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
		pZM += Nin;
		pWM += offset;
		pUM += offset;
	}
}

void QCDDopr_ZPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nin,int Nz,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,z;

	for(i=0;i<Nout;i++){
		for(z=0;z<Nz-1;z++){
			for(j=0;j<Nin;j++){
				QCDDopr_Load(v,pV,DOPRSET_SPIN);

				//uzp
				QCDDopr_Load(w,pWP,DOPRSET_SPIN);
				QCDDopr_LoadGauge(u,pUP);

				QCD_UZP_HALF(tv,w);
				QCD_MUL_UP(hv,u,tv);
				QCD_UZP_SET(v,hv,kappa);

				QCDDopr_Store(v,pV,DOPRSET_SPIN);

				pV += 1;
				pUP += 1;
				pWP += 1;
			}
		}
		pV += Nin;
		pUP += Nin;
		pWP += Nin;
	}
}

void QCDDopr_ZMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Nz,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,z;

	pV += Nin;
	pUM += Nin;
	pWM += Nin;
	for(i=0;i<Nout;i++){
		for(z=1;z<Nz;z++){
			for(j=0;j<Nin;j++){
				QCDDopr_Load(v,pV,DOPRSET_SPIN);

				//uzm
				QCDDopr_Load(w,pWM,DOPRSET_SPIN);
				QCDDopr_LoadGauge(u,pUM);
				QCD_UZM_HALF(tv,w);
				QCD_MUL_UM(hv,u,tv);
				QCD_UZM_SET(v,hv,kappa);

				QCDDopr_Store(v,pV,DOPRSET_SPIN);

				pV += 1;
				pUM += 1;
				pWM += 1;
			}
		}
		pV += Nin;
		pUM += Nin;
		pWM += Nin;
	}
}


void QCDDopr_SetZPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pZP,int Nin,int Nz,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,z;

	for(i=0;i<Nout;i++){
		pV += Nin*Nz - Nin;
		pUP += Nin*Nz - Nin;
		for(j=0;j<Nin;j++){
			QCDDopr_Load(v,pV,DOPRSET_SPIN);

			//uzp
			QCDDopr_Load(hv,(pZP + j),DOPRSET_HSPIN);
			QCDDopr_LoadGauge(u,pUP);
			QCD_MUL_UP(tv,u,hv);
			QCD_UZP_SET(v,tv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
			pUP += 1;
		}
		pZP += Nin;
	}
}

void QCDDopr_SetZMBnd(QCDSpinor* pV,QCDHalfSpinor* pZM,int Nin,int Nz,int Nout)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,z;

	for(i=0;i<Nout;i++){
		for(j=0;j<Nin;j++){
			QCDDopr_Load(v,pV,DOPRSET_SPIN);

			//uzm
			QCDDopr_Load(hv,(pZM+j),DOPRSET_HSPIN);
			QCD_UZM_SET(v,hv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
		}
		pZM += Nin;

		pV += Nin*Nz - Nin;
	}
}

void QCDDopr_MakeTPB(QCDHalfSpinor* pTP,QCDSpinor* pWP,int Nin,int Nt)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	int offset = Nin * Nt;

	for(j=0;j<Nin;j++){
		//for Plus boundary (send to minus)
		QCDDopr_Load(v,(pWP + j),DOPRSET_SPIN);

		QCD_UTP_HALF(hv,v);

		QCDDopr_Store(hv,(pTP + j),DOPRSET_HSPIN);
	}
}

void QCDDopr_MakeTMB(QCDHalfSpinor* pTM,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Nt)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	int offset = Nin * Nt;

	for(j=0;j<Nin;j++){
		//for Minus boundary (send to plus)
		QCDDopr_Load(v,(pWM + j),DOPRSET_SPIN);
		QCDDopr_LoadGauge(u,(pUM + j));

		QCD_UTM_HALF(tv,v);
		QCD_MUL_UM(hv,u,tv);

		QCDDopr_Store(hv,(pTM + j),DOPRSET_HSPIN);
	}
}

void QCDDopr_TPin(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nin,int Nt)
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

void QCDDopr_TMin(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Nt)
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


void QCDDopr_SetTPBnd(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pTP,int Nin,int Nt)
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


void QCDDopr_SetTMBnd(QCDSpinor* pV,QCDHalfSpinor* pTM,int Nin,int Nt)
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

void QCDDopr_MakeTPB_dirac(QCDHalfSpinor* pTP,QCDSpinor* pWP,int Nin,int Nt)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	int offset = Nin * Nt;

	for(j=0;j<Nin;j++){
		//for Plus boundary (send to minus)
		QCDDopr_Load(v,(pWP + j),DOPRSET_SPIN);

		QCD_UTP_DIRAC_HALF(hv,v);

		QCDDopr_Store(hv,(pTP + j),DOPRSET_HSPIN);
	}
}

void QCDDopr_MakeTMB_dirac(QCDHalfSpinor* pTM,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Nt)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	int i,j;
	int offset = Nin * Nt;

	for(j=0;j<Nin;j++){
		//for Minus boundary (send to plus)
		QCDDopr_Load(v,(pWM + j),DOPRSET_SPIN);
		QCDDopr_LoadGauge(u,(pUM + j));

		QCD_UTM_DIRAC_HALF(tv,v);
		QCD_MUL_UM(hv,u,tv);

		QCDDopr_Store(hv,(pTM + j),DOPRSET_HSPIN);
	}
}


void QCDDopr_TPin_dirac(QCDSpinor* pV,QCDMatrix* pUP,QCDSpinor* pWP,int Nin,int Nt)
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
			QCD_UTP_DIRAC_HALF(tv,w);
			QCD_MUL_UP(hv,u,tv);
			QCD_UTP_DIRAC_SET(v,hv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
			pUP += 1;
			pWP += 1;
		}
	}
}

void QCDDopr_TMin_dirac(QCDSpinor* pV,QCDMatrix* pUM,QCDSpinor* pWM,int Nin,int Nt)
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
			QCD_UTM_DIRAC_HALF(tv,w);
			QCD_MUL_UM(hv,u,tv);
			QCD_UTM_DIRAC_SET(v,hv,kappa);

			QCDDopr_Store(v,pV,DOPRSET_SPIN);

			pV += 1;
			pUM += 1;
			pWM += 1;
		}
	}

}


void QCDDopr_SetTPBnd_dirac(QCDSpinor* pV,QCDMatrix* pUP,QCDHalfSpinor* pTP,int Nin,int Nt)
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
		QCD_UTP_DIRAC_SET(v,tv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += 1;
		pUP += 1;
	}
}


void QCDDopr_SetTMBnd_dirac(QCDSpinor* pV,QCDHalfSpinor* pTM,int Nin,int Nt)
{
	QCDComplex tv[6*QCD_NUM_SIMD];
	QCDComplex u[9*QCD_NUM_SIMD],v[12*QCD_NUM_SIMD],w[12*QCD_NUM_SIMD],hv[6*QCD_NUM_SIMD];
	QCDReal* kappa = qcdtKappa;
	int i,j,t;

	for(j=0;j<Nin;j++){
		QCDDopr_Load(v,pV,DOPRSET_SPIN);

		//utm
		QCDDopr_Load(hv,(pTM+j),DOPRSET_HSPIN);
		QCD_UTM_DIRAC_SET(v,hv,kappa);

		QCDDopr_Store(v,pV,DOPRSET_SPIN);

		pV += 1;
	}
}


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


#define QCDDopr_GetRank(x,y,z,t) \
	((x) + (y) * qcdNetSize[0] + (z) * qcdNetSize[0]*qcdNetSize[1] + (t) * qcdNetSize[0]*qcdNetSize[1]*qcdNetSize[2])



void QCDDopr_Init(int Nx,int Ny,int Nz,int Nt,int npx,int npy,int npz,int npt,int myrank)
{
	
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
}


#if 0
void QCDDopr_Mult_Ser(QCDSpinor* pV,QCDMatrix* pU,QCDSpinor* pW,double k)
{
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

	//Send T
	QCDDopr_MakeTPB_dirac(qcdRecvBuf[QCD_TP],pW,qcdNxyz,qcdNt);
	QCDDopr_MakeTMB_dirac(qcdRecvBuf[QCD_TM],pUt + qcdNsite-qcdNxyz,pW + qcdNsite-qcdNxyz,qcdNxyz,qcdNt);

	//Send X
	QCDDopr_MakeXPB(qcdRecvBuf[QCD_XP],pW,qcdNx,qcdNy*qcdNz*qcdNt);
	QCDDopr_MakeXMB(qcdRecvBuf[QCD_XM],pUx + qcdNx-1,pW + qcdNx-1,qcdNx,qcdNy*qcdNz*qcdNt);

	//Send Y
	QCDDopr_MakeYPB(qcdRecvBuf[QCD_YP],pW,qcdNx,qcdNy,qcdNz*qcdNt);
	QCDDopr_MakeYMB(qcdRecvBuf[QCD_YM],pUy + qcdNxy-qcdNx,pW + qcdNxy-qcdNx,qcdNx,qcdNy,qcdNz*qcdNt);

	//Send Z
	QCDDopr_MakeZPB(qcdRecvBuf[QCD_ZP],pW,qcdNxy,qcdNz,qcdNt);
	QCDDopr_MakeZMB(qcdRecvBuf[QCD_ZM],pUz + qcdNxyz-qcdNxy,pW + qcdNxyz-qcdNxy,qcdNxy,qcdNz,qcdNt);

	QCDLA_Equate(pV,pW,qcdNsite);
	QCDDopr_TPin_dirac(pV,pUt,pW + qcdNxyz,qcdNxyz,qcdNt);
	QCDDopr_TMin_dirac(pV,pUt-qcdNxyz,pW - qcdNxyz,qcdNxyz,qcdNt);
	QCDDopr_XPin(pV,pUx,pW+1,qcdNx,qcdNy*qcdNz*qcdNt);
	QCDDopr_XMin(pV,pUx-1,pW-1,qcdNx,qcdNy*qcdNz*qcdNt);
	QCDDopr_YPin(pV,pUy,pW + qcdNx,qcdNx,qcdNy,qcdNz*qcdNt);
	QCDDopr_YMin(pV,pUy-qcdNx,pW - qcdNx,qcdNx,qcdNy,qcdNz*qcdNt);
	QCDDopr_ZPin(pV,pUz,pW + qcdNxy,qcdNxy,qcdNz,qcdNt);
	QCDDopr_ZMin(pV,pUz-qcdNxy,pW - qcdNxy,qcdNxy,qcdNz,qcdNt);

	QCDDopr_SetTPBnd_dirac(pV,pUt,qcdRecvBuf[QCD_TP],qcdNxyz,qcdNt);
	QCDDopr_SetTMBnd_dirac(pV,qcdRecvBuf[QCD_TM],qcdNxyz,qcdNt);

	QCDDopr_SetXPBnd(pV,pUx,qcdRecvBuf[QCD_XP],qcdNx,qcdNy*qcdNz*qcdNt);
	QCDDopr_SetXMBnd(pV,qcdRecvBuf[QCD_XM],qcdNx,qcdNy*qcdNz*qcdNt);

	QCDDopr_SetYPBnd(pV,pUy,qcdRecvBuf[QCD_YP],qcdNx,qcdNy,qcdNz*qcdNt);
	QCDDopr_SetYMBnd(pV,qcdRecvBuf[QCD_YM],qcdNx,qcdNy,qcdNz*qcdNt);

	QCDDopr_SetZPBnd(pV,pUz,qcdRecvBuf[QCD_ZP],qcdNxy,qcdNz,qcdNt);
	QCDDopr_SetZMBnd(pV,qcdRecvBuf[QCD_ZM],qcdNxy,qcdNz,qcdNt);
}

#endif

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

#if 0
	if(qcdNProcs == 1){
		QCDDopr_Mult_Ser(pV,pU,pW,k);
		return;
	}
#endif

	qcdtKappa[0] = k;
	qcdtKappa[1] = k;
	qcdtKappa[2] = k;
	qcdtKappa[3] = k;

	pUx = pU;
	pUy = pU + qcdNsite;
	pUz = pU + qcdNsite*2;
	pUt = pU + qcdNsite*3;

	//Send T
	MPI_Irecv(qcdRecvBuf[QCD_TP],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TP],QCD_TP,MPI_COMM_WORLD,&reqRecv[QCD_TP]);
	MPI_Irecv(qcdRecvBuf[QCD_TM],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TM],QCD_TM,MPI_COMM_WORLD,&reqRecv[QCD_TM]);

	QCDDopr_MakeTPB_dirac(qcdSendBuf[QCD_TP],pW,qcdNxyz,qcdNt);
	MPI_Isend(qcdSendBuf[QCD_TP],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TM],QCD_TP,MPI_COMM_WORLD,&reqSend[QCD_TP]);

	QCDDopr_MakeTMB_dirac(qcdSendBuf[QCD_TM],pUt + qcdNsite-qcdNxyz,pW + qcdNsite-qcdNxyz,qcdNxyz,qcdNt);
	MPI_Isend(qcdSendBuf[QCD_TM],12*qcdNxyz,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_TP],QCD_TM,MPI_COMM_WORLD,&reqSend[QCD_TM]);

	//Send X
	MPI_Irecv(qcdRecvBuf[QCD_XP],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XP],QCD_XP,MPI_COMM_WORLD,&reqRecv[QCD_XP]);
	MPI_Irecv(qcdRecvBuf[QCD_XM],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XM],QCD_XM,MPI_COMM_WORLD,&reqRecv[QCD_XM]);

	QCDDopr_MakeXPB(qcdSendBuf[QCD_XP],pW,qcdNx,qcdNy*qcdNz*qcdNt);
	MPI_Isend(qcdSendBuf[QCD_XP],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XM],QCD_XP,MPI_COMM_WORLD,&reqSend[QCD_XP]);

	QCDDopr_MakeXMB(qcdSendBuf[QCD_XM],pUx + qcdNx-1,pW + qcdNx-1,qcdNx,qcdNy*qcdNz*qcdNt);
	MPI_Isend(qcdSendBuf[QCD_XM],12*qcdNy*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_XP],QCD_XM,MPI_COMM_WORLD,&reqSend[QCD_XM]);


	//Send Y
	MPI_Irecv(qcdRecvBuf[QCD_YP],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YP],QCD_YP,MPI_COMM_WORLD,&reqRecv[QCD_YP]);
	MPI_Irecv(qcdRecvBuf[QCD_YM],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YM],QCD_YM,MPI_COMM_WORLD,&reqRecv[QCD_YM]);

	QCDDopr_MakeYPB(qcdSendBuf[QCD_YP],pW,qcdNx,qcdNy,qcdNz*qcdNt);
	MPI_Isend(qcdSendBuf[QCD_YP],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YM],QCD_YP,MPI_COMM_WORLD,&reqSend[QCD_YP]);

	QCDDopr_MakeYMB(qcdSendBuf[QCD_YM],pUy + qcdNxy-qcdNx,pW + qcdNxy-qcdNx,qcdNx,qcdNy,qcdNz*qcdNt);
	MPI_Isend(qcdSendBuf[QCD_YM],12*qcdNx*qcdNz*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_YP],QCD_YM,MPI_COMM_WORLD,&reqSend[QCD_YM]);

	//Send Z
	MPI_Irecv(qcdRecvBuf[QCD_ZP],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZP],QCD_ZP,MPI_COMM_WORLD,&reqRecv[QCD_ZP]);
	MPI_Irecv(qcdRecvBuf[QCD_ZM],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZM],QCD_ZM,MPI_COMM_WORLD,&reqRecv[QCD_ZM]);

	QCDDopr_MakeZPB(qcdSendBuf[QCD_ZP],pW,qcdNxy,qcdNz,qcdNt);
	MPI_Isend(qcdSendBuf[QCD_ZP],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZM],QCD_ZP,MPI_COMM_WORLD,&reqSend[QCD_ZP]);

	QCDDopr_MakeZMB(qcdSendBuf[QCD_ZM],pUz + qcdNxyz-qcdNxy,pW + qcdNxyz-qcdNxy,qcdNxy,qcdNz,qcdNt);
	MPI_Isend(qcdSendBuf[QCD_ZM],12*qcdNx*qcdNy*qcdNt,MPI_DOUBLE_PRECISION,qcdRankNeighbors[QCD_ZP],QCD_ZM,MPI_COMM_WORLD,&reqSend[QCD_ZM]);

	QCDLA_Equate(pV,pW,qcdNsite);
	QCDDopr_TPin_dirac(pV,pUt,pW + qcdNxyz,qcdNxyz,qcdNt);
	QCDDopr_TMin_dirac(pV,pUt-qcdNxyz,pW - qcdNxyz,qcdNxyz,qcdNt);
	QCDDopr_XPin(pV,pUx,pW+1,qcdNx,qcdNy*qcdNz*qcdNt);
	QCDDopr_XMin(pV,pUx-1,pW-1,qcdNx,qcdNy*qcdNz*qcdNt);
	QCDDopr_YPin(pV,pUy,pW + qcdNx,qcdNx,qcdNy,qcdNz*qcdNt);
	QCDDopr_YMin(pV,pUy-qcdNx,pW - qcdNx,qcdNx,qcdNy,qcdNz*qcdNt);
	QCDDopr_ZPin(pV,pUz,pW + qcdNxy,qcdNxy,qcdNz,qcdNt);
	QCDDopr_ZMin(pV,pUz-qcdNxy,pW - qcdNxy,qcdNxy,qcdNz,qcdNt);

	MPI_Wait(&reqRecv[QCD_TP],&st);
	QCDDopr_SetTPBnd_dirac(pV,pUt,qcdRecvBuf[QCD_TP],qcdNxyz,qcdNt);
	MPI_Wait(&reqRecv[QCD_TM],&st);
	QCDDopr_SetTMBnd_dirac(pV,qcdRecvBuf[QCD_TM],qcdNxyz,qcdNt);

	MPI_Wait(&reqRecv[QCD_XP],&st);
	QCDDopr_SetXPBnd(pV,pUx,qcdRecvBuf[QCD_XP],qcdNx,qcdNy*qcdNz*qcdNt);
	MPI_Wait(&reqRecv[QCD_XM],&st);
	QCDDopr_SetXMBnd(pV,qcdRecvBuf[QCD_XM],qcdNx,qcdNy*qcdNz*qcdNt);

	MPI_Wait(&reqRecv[QCD_YP],&st);
	QCDDopr_SetYPBnd(pV,pUy,qcdRecvBuf[QCD_YP],qcdNx,qcdNy,qcdNz*qcdNt);
	MPI_Wait(&reqRecv[QCD_YM],&st);
	QCDDopr_SetYMBnd(pV,qcdRecvBuf[QCD_YM],qcdNx,qcdNy,qcdNz*qcdNt);

	MPI_Wait(&reqRecv[QCD_ZP],&st);
	QCDDopr_SetZPBnd(pV,pUz,qcdRecvBuf[QCD_ZP],qcdNxy,qcdNz,qcdNt);
	MPI_Wait(&reqRecv[QCD_ZM],&st);
	QCDDopr_SetZMBnd(pV,qcdRecvBuf[QCD_ZM],qcdNxy,qcdNz,qcdNt);

	MPI_Wait(&reqSend[QCD_TP],&st);
	MPI_Wait(&reqSend[QCD_TM],&st);
	MPI_Wait(&reqSend[QCD_XP],&st);
	MPI_Wait(&reqSend[QCD_XM],&st);
	MPI_Wait(&reqSend[QCD_YP],&st);
	MPI_Wait(&reqSend[QCD_YM],&st);
	MPI_Wait(&reqSend[QCD_ZP],&st);
	MPI_Wait(&reqSend[QCD_ZM],&st);
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



