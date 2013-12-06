/*--------------------------------------------------------------------
	Lattice QCD linear algebra routines

	Copyright 2009-2013 IBM Research - Tokyo, IBM Corporation

	Written by
		Jun Doi  (doichan@jp.ibm.com)

--------------------------------------------------------------------*/

#include "qcd.h"

#define QCDLA_NUM_SPIN		12


void QCDLA_SetConst(QCDComplex* pV,QCDReal a,int ns)
{
	register double _Complex* pV0;
	int i,j;

	pV0 = pV;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = a;
		}
		pV0 += QCDLA_NUM_SPIN;
	}
}




void QCDLA_Equate(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = *(pW0 + j);
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}

void QCDLA_MultScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = *(pW0 + j) * PRF;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}

void QCDLA_MultAddScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) += *(pW0 + j) * PRF;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Add_MultAddScalar(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double PRF,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pX0;
	register double _Complex* pY0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) += (*(pX0 + j) + *(pY0 + j))*PRF;
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Add(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) += *(pW0 + j);
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}

void QCDLA_Sub(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) -= *(pW0 + j);
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Norm(double* AV,double* pV,int ns)
{
	register double* pV0;
	double r;
	int i,j;

	pV0 = pV;

	r = 0.0;
	for(i=0;i<ns*QCDLA_NUM_SPIN*2;i++){
		r += pV0[i] * pV0[i];
	}
	*AV = r;
}


void QCDLA_DotProd(double* AV,double* pV,double* pW,int ns)
{
	register double* pV0;
	register double* pW0;
	double r;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	r = 0.0;
	for(i=0;i<ns*QCDLA_NUM_SPIN*2;i++){
		r += pV0[i] * pW0[i];
	}
	*AV = r;
}


void QCDLA_MultScalar_Add(QCDComplex* pV,QCDComplex* pW,double PRF,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = *(pW0 + j) + *(pV0 + j) * PRF;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_AXPBY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double PRF1,double PRF2,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pX0;
	register double _Complex* pY0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = PRF1 * *(pX0 + j) + PRF2 * *(pY0 + j);
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_AXPY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double a,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pX0;
	register double _Complex* pY0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = a * *(pX0 + j) + *(pY0 + j);
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
}

void QCDLA_AXMY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double a,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pX0;
	register double _Complex* pY0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = a * *(pX0 + j) - *(pY0 + j);
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
}



void QCDLA_AXPBYPZ(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,QCDComplex* pZ,double a,double b,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pX0;
	register double _Complex* pY0;
	register double _Complex* pZ0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;
	pZ0 = pZ;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = a * *(pX0 + j) + b * *(pY0 + j) + *(pZ0 + j);
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
		pZ0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_AXPY_Norm(QCDComplex* pV,double* AV,QCDComplex* pX,QCDComplex* pY,double a,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pX0;
	register double _Complex* pY0;
	double* pN;
	double r;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	r = 0.0;
	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			*(pV0 + j) = a * *(pX0 + j) + *(pY0 + j);
			pN = (double*)(pV0 + j);
			r += pN[0] * pN[0] + pN[1] * pN[1];
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
	*AV = r;
}


#ifdef QCD_SPINOR_3x4
/*

0: w(1,1) w(2,1) 

1: w(3,1) w(1,2) 

2: w(2,2) w(3,2)


3: w(1,3) w(2,3) 

4: w(3,3) w(1,4) 

5: w(2,4) w(3,4)

*/


void QCDLA_MultGamma5(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	register double _Complex v0;
	register double _Complex v1;
	register double _Complex v2;
	register double _Complex v3;
	int i,j,k;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(k=0;k<3;k++){
			v0 = *(pW0     + k);
			v1 = *(pW0 + 3 + k);
			v2 = *(pW0 + 6 + k);
			v3 = *(pW0 + 9 + k);
			*(pV0     + k) = v2;
			*(pV0 + 3 + k) = v3;
			*(pV0 + 6 + k) = v0;
			*(pV0 + 9 + k) = v1;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Proj_P(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	double p0,p1;
	int i,j,k;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(k=0;k<3;k++){
			p0 = 0.5*(*(pW0 + k    ) + *(pW0 + k + 6));
			p1 = 0.5*(*(pW0 + k + 3) + *(pW0 + k + 9));
			*(pV0 + k    ) = p0;
			*(pV0 + k + 3) = p1;
			*(pV0 + k + 6) = p0;
			*(pV0 + k + 9) = p1;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Proj_M(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	double p0,p1;
	int i,j,k;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(k=0;k<3;k++){
			p0 = 0.5*(*(pW0 + k    ) - *(pW0 + k + 6));
			p1 = 0.5*(*(pW0 + k + 3) - *(pW0 + k + 9));
			*(pV0 + k    ) = p0;
			*(pV0 + k + 3) = p1;
			*(pV0 + k + 6) = -p0;
			*(pV0 + k + 9) = -p1;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}




#else	//QCD_SPINOR_3x4
void QCDLA_MultGamma5(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	register double _Complex v0;
	register double _Complex v1;
	int i,j,k;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(k=0;k<3;k++){
			v0 = *(pW0 + k*4    );
			v1 = *(pW0 + k*4 + 1);
			*(pV0 + k*4    ) = *(pW0 + k*4 + 2);
			*(pV0 + k*4 + 1) = *(pW0 + k*4 + 3);
			*(pV0 + k*4 + 2) = v0;
			*(pV0 + k*4 + 3) = v1;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Proj_P(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	double p0,p1;
	int i,j,k;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(k=0;k<3;k++){
			p0 = 0.5*(*(pW0 + k*4    ) + *(pW0 + k*4 + 2));
			p1 = 0.5*(*(pW0 + k*4 + 1) + *(pW0 + k*4 + 3));
			*(pV0 + k*4    ) = p0;
			*(pV0 + k*4 + 1) = p1;
			*(pV0 + k*4 + 2) = p0;
			*(pV0 + k*4 + 3) = p1;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Proj_M(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register double _Complex* pV0;
	register double _Complex* pW0;
	double p0,p1;
	int i,j,k;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(k=0;k<3;k++){
			p0 = 0.5*(*(pW0 + k*4    ) - *(pW0 + k*4 + 2));
			p1 = 0.5*(*(pW0 + k*4 + 1) - *(pW0 + k*4 + 3));
			*(pV0 + k*4    ) = p0;
			*(pV0 + k*4 + 1) = p1;
			*(pV0 + k*4 + 2) = -p0;
			*(pV0 + k*4 + 3) = -p1;
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}

#endif


