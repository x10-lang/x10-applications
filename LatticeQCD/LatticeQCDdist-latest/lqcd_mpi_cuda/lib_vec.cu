/*--------------------------------------------------------------------
	Lattice QCD linear algebra routines

	Copyright 2009-2013 IBM Research - Tokyo, IBM Corporation

	Written by
		Jun Doi  (doichan@jp.ibm.com)

--------------------------------------------------------------------*/

#include <helper_cuda.h>
#include <helper_functions.h>

#include "lib_vec.h"
#include "qcd.h"

#define QCDLA_NUM_SPIN		12

double* gtemp1;
double* gtemp2;

int Pow2(int in_size) 
{
    int pow_size = 0;
    // pow 2
    if ((in_size & (in_size - 1)) == 0) {
	pow_size = in_size;
    } else {
	int pow = 0;
	for (int s = in_size; s > 0; s >>= 1) pow++;
	pow_size = 1 << pow;
    }
    return pow_size;
}

void cuQCDLA_Init(int ns)
{
    const int n = ns*QCDLA_NUM_SPIN*2;
    int maxBlockSize = 1024;
    int blockSize = min(maxBlockSize, n);
    int gridSize = (n / blockSize) + ((n % blockSize > 0) ? 1 : 0);
    int gridSizePow = Pow2(gridSize);

    checkCudaErrors(cudaMalloc((void**)&gtemp1, gridSizePow * sizeof(double)));
    checkCudaErrors(cudaMalloc((void**)&gtemp2, (gridSizePow / maxBlockSize) * sizeof(double)));

    checkCudaErrors(cudaMemset(gtemp1, 0, gridSizePow * sizeof(double)));
    checkCudaErrors(cudaMemset(gtemp2, 0, (gridSizePow / maxBlockSize) * sizeof(double)));
}

void QCDLA_SetConst(QCDComplex* pV,QCDReal a,int ns)
{
	register cuDoubleComplex* pV0;
	int i,j;

	pV0 = pV;

	for(i=0;i<ns;i++){
	    for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) = a;
		*(pV0 + j) = make_cuDoubleComplex(a, 0);
	    }
	    pV0 += QCDLA_NUM_SPIN;
	}
}




void QCDLA_Equate(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
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

__global__ void cuQCDLA_Equate(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	// int i,j;
	int i;
	int tid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pV0 = pV;
	pW0 = pW;

	for(i = tid; i < ns * QCDLA_NUM_SPIN; i += stride){
	    *(pV0 + i) = *(pW0 + i);
	}
}

void QCDLA_MultScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) = *(pW0 + j) * PRF;
		    *(pV0 + j) = cuCmul(*(pW0 + j), make_cuDoubleComplex(PRF, 0));
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}

__global__ void cuQCDLA_MultScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	// int i,j;
	int i;
	int tid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pV0 = pV;
	pW0 = pW;

	for(i = tid; i < ns * QCDLA_NUM_SPIN; i += stride){
	    *(pV0 + i) = cuCmul(*(pW0 + i), make_cuDoubleComplex(PRF, 0));
	}
}

void QCDLA_MultAddScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) += *(pW0 + j) * PRF;
		    *(pV0 + j) = cuCadd(*(pV0 + j), cuCmul(*(pW0 + j), make_cuDoubleComplex(PRF, 0)));
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}

__global__ void cuQCDLA_MultAddScalar(QCDComplex* pV,QCDComplex* pW,double PRF,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	// int i,j;
	int i;
	int tid = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	pV0 = pV;
	pW0 = pW;

	for(i = tid; i < ns * QCDLA_NUM_SPIN; i += stride){
	    *(pV0 + i) = cuCadd(*(pV0 + i), cuCmul(*(pW0 + i), make_cuDoubleComplex(PRF, 0)));
	}
}


void QCDLA_Add_MultAddScalar(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double PRF,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pX0;
	register cuDoubleComplex* pY0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) += (*(pX0 + j) + *(pY0 + j))*PRF;
		    *(pV0 + j) = cuCadd(*(pV0 + j), 
					cuCmul(cuCadd(*(pX0 + j), *(pY0 + j)), make_cuDoubleComplex(PRF, 0)));
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Add(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) += *(pW0 + j);
		    *(pV0 + j) = cuCadd(*(pV0 + j), *(pW0 + j));
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}

void QCDLA_Sub(QCDComplex* pV,QCDComplex* pW,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) -= *(pW0 + j);
		    *(pV0 + j) = cuCsub(*(pV0 + j), *(pW0 + j));
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_Norm(double* AV,double* pV,int ns)
{
	register double* pV0;
	double r;
	// int i,j;
	int i;

	pV0 = pV;

	r = 0.0;
	for(i=0;i<ns*QCDLA_NUM_SPIN*2;i++){
		r += pV0[i] * pV0[i];
	}
	*AV = r;
}

void QCDLA_Norm_Simple(double* AV,double* pV,int ns)
{
	register double* pV0;
	double r;
	// int i,j;
	int i;

	pV0 = pV;

	r = 0.0;
	// for(i=0;i<ns*QCDLA_NUM_SPIN*2;i++){
	for(i=0;i<ns;i++){
		r += pV0[i] * pV0[i];
	}
	*AV = r;
}

void cuQCDLA_Norm(double* AV, double* pV,int ns)
{
    cuQCDLA_DotProd(AV, pV, pV, ns);
}

__global__ void cuQCDLA_Reduce_Kernel(double* pV, double* g_odata, int ns)
{
    extern __shared__ double sdata[];

    unsigned int tid = threadIdx.x;
    unsigned int blockSize = blockDim.x;
    unsigned int i = blockIdx.x * (blockSize * 2) + tid;
    unsigned int gridSize = blockSize * 2 * gridDim.x;
    sdata[tid] = 0;

    register double* pV0;
    pV0 = pV;

    while (i < ns) { sdata[tid] += pV0[i] + pV0[i + blockSize]; i += gridSize; }
    __syncthreads();
    
    if (blockSize >= 1024) { if (tid < 512) { sdata[tid] += sdata[tid + 512]; } __syncthreads(); }
    if (blockSize >=  512) { if (tid < 256) { sdata[tid] += sdata[tid + 256]; } __syncthreads(); }
    if (blockSize >=  256) { if (tid < 128) { sdata[tid] += sdata[tid + 128]; } __syncthreads(); }
    if (blockSize >=  128) { if (tid <  64) { sdata[tid] += sdata[tid +  64]; } __syncthreads(); }

    if (tid < 32) {
	if (blockSize >= 64) sdata[tid] += sdata[tid + 32];
	if (blockSize >= 32) sdata[tid] += sdata[tid + 16];
	if (blockSize >= 16) sdata[tid] += sdata[tid + 8];
	if (blockSize >=  8) sdata[tid] += sdata[tid + 4];
	if (blockSize >=  4) sdata[tid] += sdata[tid + 2];
	if (blockSize >=  2) sdata[tid] += sdata[tid + 1];
    }

    if (tid == 0) g_odata[blockIdx.x] = sdata[0];
}

__global__ void cuQCDLA_DotProd_Kernel(double* pV, double* pW, double* g_odata, int ns)
{
    extern __shared__ double sdata[];

    unsigned int tid = threadIdx.x;
    unsigned int blockSize = blockDim.x;
    unsigned int i = blockIdx.x * (blockSize * 2) + tid;
    unsigned int gridSize = blockSize * 2 * gridDim.x;
    sdata[tid] = 0;

    register double* pV0;
    register double* pW0;
    pV0 = pV;
    pW0 = pW;

    while (i < ns) { sdata[tid] += pV0[i] * pW0[i] + pV0[i + blockSize] * pW0[i + blockSize]; i += gridSize; }
    __syncthreads();
    
    if (blockSize >= 1024) { if (tid < 512) { sdata[tid] += sdata[tid + 512]; } __syncthreads(); }
    if (blockSize >=  512) { if (tid < 256) { sdata[tid] += sdata[tid + 256]; } __syncthreads(); }
    if (blockSize >=  256) { if (tid < 128) { sdata[tid] += sdata[tid + 128]; } __syncthreads(); }
    if (blockSize >=  128) { if (tid <  64) { sdata[tid] += sdata[tid +  64]; } __syncthreads(); }

    if (tid < 32) {
    	if (blockSize >= 64) sdata[tid] += sdata[tid + 32];
    	if (blockSize >= 32) sdata[tid] += sdata[tid + 16];
    	if (blockSize >= 16) sdata[tid] += sdata[tid + 8];
    	if (blockSize >=  8) sdata[tid] += sdata[tid + 4];
    	if (blockSize >=  4) sdata[tid] += sdata[tid + 2];
    	if (blockSize >=  2) sdata[tid] += sdata[tid + 1];
    }

    if (tid == 0) g_odata[blockIdx.x] = sdata[0];
}


void QCDLA_DotProd(double* AV,double* pV,double* pW,int ns)
{
	register double* pV0;
	register double* pW0;
	double r;
	// int i,j;
	int i;

	pV0 = pV;
	pW0 = pW;

	r = 0.0;
	for(i=0;i<ns*QCDLA_NUM_SPIN*2;i++){
		r += pV0[i] * pW0[i];
	}
	*AV = r;
}

void cuQCDLA_DotProd(double* AV,double* pV,double* pW,int ns)
{
    const int n = ns*QCDLA_NUM_SPIN*2;
    const int maxBlockSize = 1024;


    int blockSize = min(maxBlockSize, n);
    int gridSize = (n / blockSize) + ((n % blockSize > 0) ? 1 : 0);
    int smemSize = blockSize * sizeof(double);

    cuQCDLA_DotProd_Kernel<<<gridSize, blockSize/2, smemSize>>>(pV, pW, gtemp1, n);
    
    int gridSizePow = Pow2(gridSize);
    if (gridSizePow > maxBlockSize) {
	blockSize = maxBlockSize;
	gridSize = gridSizePow / blockSize;
	smemSize = blockSize * sizeof(double);
	cuQCDLA_Reduce_Kernel<<<gridSize, blockSize/2, smemSize>>>(gtemp1, gtemp2, gridSizePow);

	blockSize = gridSize;
	smemSize = blockSize * sizeof(double);
	cuQCDLA_Reduce_Kernel<<<1, blockSize/2, smemSize>>>(gtemp2, AV, gridSize);
    } else if (gridSizePow > 1) {
	blockSize = gridSizePow;
	smemSize = blockSize * sizeof(double);
	cuQCDLA_Reduce_Kernel<<<1, blockSize/2, smemSize>>>(gtemp1, AV, gridSize);
    } else {
	checkCudaErrors(cudaMemcpy(AV, gtemp1, sizeof(double), cudaMemcpyDeviceToDevice));
    }
}


void QCDLA_MultScalar_Add(QCDComplex* pV,QCDComplex* pW,double PRF,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	int i,j;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) = *(pW0 + j) + *(pV0 + j) * PRF;
		    *(pV0 + j) = cuCadd(*(pW0 + j), cuCmul(*(pV0 + j), make_cuDoubleComplex(PRF, 0)));
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_AXPBY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double PRF1,double PRF2,int ns)
{
        register cuDoubleComplex* pV0;
	register cuDoubleComplex* pX0;
	register cuDoubleComplex* pY0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) = PRF1 * *(pX0 + j) + PRF2 * *(pY0 + j);
		    *(pV0 + j) = cuCadd(cuCmul(make_cuDoubleComplex(PRF1, 0), *(pX0 + j)), 
					cuCmul(make_cuDoubleComplex(PRF2, 0), *(pY0 + j)));
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_AXPY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double a,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pX0;
	register cuDoubleComplex* pY0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) = a * *(pX0 + j) + *(pY0 + j);
		    *(pV0 + j) = cuCadd(cuCmul(make_cuDoubleComplex(a, 0), *(pX0 + j)), *(pY0 + j));
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
}

void QCDLA_AXMY(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,double a,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pX0;
	register cuDoubleComplex* pY0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) = a * *(pX0 + j) - *(pY0 + j);
		    *(pV0 + j) = cuCsub(cuCmul(make_cuDoubleComplex(a, 0), *(pX0 + j)), *(pY0 + j));
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
	}
}



void QCDLA_AXPBYPZ(QCDComplex* pV,QCDComplex* pX,QCDComplex* pY,QCDComplex* pZ,double a,double b,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pX0;
	register cuDoubleComplex* pY0;
	register cuDoubleComplex* pZ0;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;
	pZ0 = pZ;

	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) = a * *(pX0 + j) + b * *(pY0 + j) + *(pZ0 + j);
		    *(pV0 + j) = cuCadd(cuCadd(cuCmul(make_cuDoubleComplex(a, 0), *(pX0 + j)), 
					       cuCmul(make_cuDoubleComplex(b, 0), *(pY0 + j))), 
					*(pZ0 + j));
		}
		pV0 += QCDLA_NUM_SPIN;
		pX0 += QCDLA_NUM_SPIN;
		pY0 += QCDLA_NUM_SPIN;
		pZ0 += QCDLA_NUM_SPIN;
	}
}


void QCDLA_AXPY_Norm(QCDComplex* pV,double* AV,QCDComplex* pX,QCDComplex* pY,double a,int ns)
{
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pX0;
	register cuDoubleComplex* pY0;
	double* pN;
	double r;
	int i,j;

	pV0 = pV;
	pX0 = pX;
	pY0 = pY;

	r = 0.0;
	for(i=0;i<ns;i++){
		for(j=0;j<QCDLA_NUM_SPIN;j++){
			// *(pV0 + j) = a * *(pX0 + j) + *(pY0 + j);
		    *(pV0 + j) = cuCadd(cuCmul(make_cuDoubleComplex(a, 0), *(pX0 + j)), *(pY0 + j));
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
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	register cuDoubleComplex v0;
	register cuDoubleComplex v1;
	// int i,j,k;
	int i,k;

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
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	cuDoubleComplex p0,p1;
	// int i,j,k;
	int i,k;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(k=0;k<3;k++){
			// p0 = 0.5*(*(pW0 + k*4    ) + *(pW0 + k*4 + 2));
			// p1 = 0.5*(*(pW0 + k*4 + 1) + *(pW0 + k*4 + 3));
		    p0 = cuCmul(make_cuDoubleComplex(0.5, 0), 
				cuCadd(*(pW0 + k*4    ), *(pW0 + k*4 + 2)));
		    p1 = cuCmul(make_cuDoubleComplex(0.5, 0), 
				cuCadd(*(pW0 + k*4 + 1), *(pW0 + k*4 + 3)));
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
	register cuDoubleComplex* pV0;
	register cuDoubleComplex* pW0;
	cuDoubleComplex p0,p1;
	// int i,j,k;
	int i,k;

	pV0 = pV;
	pW0 = pW;

	for(i=0;i<ns;i++){
		for(k=0;k<3;k++){
			// p0 = 0.5*(*(pW0 + k*4    ) - *(pW0 + k*4 + 2));
			// p1 = 0.5*(*(pW0 + k*4 + 1) - *(pW0 + k*4 + 3));
		    p0 = cuCmul(make_cuDoubleComplex(0.5, 0), 
				cuCsub(*(pW0 + k*4    ), *(pW0 + k*4 + 2)));
		    p1 = cuCmul(make_cuDoubleComplex(0.5, 0),
				cuCsub(*(pW0 + k*4 + 1), *(pW0 + k*4 + 3)));
			*(pV0 + k*4    ) = p0;
			*(pV0 + k*4 + 1) = p1;
			// *(pV0 + k*4 + 2) = -p0;
			// *(pV0 + k*4 + 3) = -p1;
			*(pV0 + k*4 + 2) = cuCsub(*(pV0 + k*4 + 2), p0);
			*(pV0 + k*4 + 3) = cuCsub(*(pV0 + k*4 + 3), p1);
		}
		pV0 += QCDLA_NUM_SPIN;
		pW0 += QCDLA_NUM_SPIN;
	}
}

#endif


