#include <stdio.h>
#include <stdlib.h>
// #include <complex.h>
#include <cuComplex.h>

#include <sys/time.h>

#include <mpi.h>

// #include <cuda.h>
// #include <cuda_runtime.h>
#include <helper_cuda.h>
#include <helper_functions.h>

#include "dslash_base.h"
#include "lib_vec.h"
#include "qcd.h"
#include "qcd_mult.h"


#define MYRAND_MAX 		32767
static unsigned long myrand_next;

static int myrand(void) 
{
	myrand_next = myrand_next * 1103515245 + 12345;
	return((unsigned)(myrand_next/65536) % 32768);
}

static void mysrand(unsigned seed) 
{
	myrand_next = seed;
}

double mysecond()
{
	struct timeval tp;
	struct timezone tzp;
	// int i;

	// i = gettimeofday(&tp,&tzp);
	gettimeofday(&tp,&tzp);
	return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
}

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

#define QCD_NX				8
#define QCD_NY				8
#define QCD_NZ				8
#define QCD_NT				16


#define QCD_ENORM			1.0e-16
#define QCD_NITER			200

#define QCD_CKS				0.150


void set_src(int ids,int ics,QCDComplex* Bsrc,int NtimeS)
{
	int NTsrc,NPEsrc;
	// int ist,is,ie;
	int ist;

	NTsrc = NtimeS % qcdNt;
	NPEsrc = (qcdNetSize[0] * qcdNetSize[1] * qcdNetSize[2]) * (NtimeS / qcdNt);

	QCDLA_SetConst(Bsrc,0.0,qcdNsite);

	ist = NTsrc * qcdNx * qcdNy * qcdNz;

	if(qcdMyRank == NPEsrc){
#ifdef QCD_SPINOR_3x4
		// 3x4
		Bsrc[ist].v[ids*QCD_NCOL + ics] = 1.0;
#else
		// 4x3
		// Bsrc[ist].v[ics*QCD_ND + ids] = 1.0;
		// Bsrc[ist].v[ics*QCD_ND + ids] = make_cuDoubleComplex(1.0, 0);
		Bsrc[ist + (ics*QCD_ND + ids) * qcdNsite] = make_cuDoubleComplex(1.0, 0);
#endif
	}
}

void uinit(double* pU,int lx,int ly,int lz,int lt)
{
	int i,j,x,y,z,t,is,d;
	int sx,sy,sz,st;
	int ex,ey,ez,et;
	QCDReal dt;

	sx = ((qcdNetPos[0]) * (lx)) / (qcdNetSize[0]);
	ex = ((qcdNetPos[0] + 1) * (lx)) / (qcdNetSize[0]);
	sy = ((qcdNetPos[1]) * (ly)) / (qcdNetSize[1]);
	ey = ((qcdNetPos[1] + 1) * (ly)) / (qcdNetSize[1]);
	sz = ((qcdNetPos[2]) * (lz)) / (qcdNetSize[2]);
	ez = ((qcdNetPos[2] + 1) * (lz)) / (qcdNetSize[2]);
	st = ((qcdNetPos[3]) * (lt)) / (qcdNetSize[3]);
	et = ((qcdNetPos[3] + 1) * (lt)) / (qcdNetSize[3]);

	mysrand(100);

	/* if(lx == 8 && ly == 8 && lz == 8 && lt == 16){ */
	/* 	FILE* pFile; */
	/* 	pFile = fopen("conf_08080816.txt","r"); */

	/* 	for(t=0;t<lt;t++){ */
	/* 		for(z=0;z<lz;z++){ */
	/* 			for(y=0;y<ly;y++){ */
	/* 				for(x=0;x<lx;x++){ */
	/* 					if((x >= sx && x < ex) && (y >= sy && y < ey) && (z >= sz && z < ez) && (t >= st && t < et)){ */
	/* 						for(i=0;i<4;i++){ */
	/* 							is = 18*(i*qcdNsite + (x-sx) + (y-sy)*qcdNx + (z-sz)*qcdNxy + (t-st)*qcdNxyz); */
	/* 							for(j=0;j<18;j++){ */
	/* 								fscanf(pFile,"%lf",&pU[is + j]); */
	/* 							} */
	/* 						} */
	/* 					} */
	/* 					else{ */
	/* 						for(i=0;i<4*18;i++){ */
	/* 							fscanf(pFile,"%lf",&d); */
	/* 						} */
	/* 						//fseek(pFile,4*18*8,SEEK_CUR); */
	/* 					} */
	/* 				} */
	/* 			} */
	/* 		} */
	/* 	} */

	/* 	fclose(pFile); */
	/* } */
	/* else{ */
		d = 0;
		is = 0;
		for(i=0;i<4;i++){
		    for(t=0;t<lt;t++){
			for(z=0;z<lz;z++){
 			    for(y=0;y<ly;y++){
				for(x=0;x<lx;x++){
				    if((x >= sx && x < ex) && (y >= sy && y < ey) && (z >= sz && z < ez) && (t >= st && t < et)){
					is = (x - sx) + (y - sy)*qcdNx + (z - sz)*qcdNxy + (t - st)*qcdNxyz + i*qcdNsite;
					for(j=0;j<9;j++){
					    dt = 2.0*(QCDReal)myrand()/(QCDReal)MYRAND_MAX;
					    // pU[is++] = dt - 1.0;
					    pU[is * 2] = dt - 1.0;
					    dt = 2.0*(QCDReal)myrand()/(QCDReal)MYRAND_MAX;
					    // pU[is++] = dt - 1.0;
					    pU[is * 2 + 1] = dt - 1.0;
					    is += 4*qcdNsite;
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
	/* } */
}


void cuSolve_CG(QCDComplex* dpXq,QCDComplex* dpU,QCDComplex* dpB,double CKs,double enorm,int* pNconv,double* pDiff)
{
	// static QCDSpinor* dpX = NULL;
	// static QCDSpinor* dpS = NULL;
	// static QCDSpinor* dpR = NULL;
	// static QCDSpinor* dpP = NULL;
	// static QCDSpinor* dpT = NULL;
	static QCDComplex* dpX = NULL;
	static QCDComplex* dpS = NULL;
	static QCDComplex* dpR = NULL;
	static QCDComplex* dpP = NULL;
	static QCDComplex* dpT = NULL;

	int iter,niter = 500;
	double snorm,sr,ret;
	double rr,rrp;
	double cr, bk, pap;
	int nconv = -1;

	dim3 threads(128,1,1);
	dim3 blocks(qcdNsite/threads.x,1,1);
	static double* dret = NULL;

	if(dpX == NULL){
		checkCudaErrors(cudaMalloc((void**)&dret, sizeof(double)));

		checkCudaErrors(cudaMalloc((void**)&dpX, sizeof(QCDComplex)*QCD_SPINOR_SIZE*qcdNsite));
		checkCudaErrors(cudaMalloc((void**)&dpS, sizeof(QCDComplex)*QCD_SPINOR_SIZE*qcdNsite));
		checkCudaErrors(cudaMalloc((void**)&dpR, sizeof(QCDComplex)*QCD_SPINOR_SIZE*qcdNsite));
		checkCudaErrors(cudaMalloc((void**)&dpP, sizeof(QCDComplex)*QCD_SPINOR_SIZE*qcdNsite));
		checkCudaErrors(cudaMalloc((void**)&dpT, sizeof(QCDComplex)*QCD_SPINOR_SIZE*qcdNsite));

		cuQCDLA_Init(qcdNsite);
	}

	cuQCDLA_Equate<<<blocks, threads>>>(dpS,dpB,qcdNsite);

	cuQCDLA_Norm(dret, (double*)dpS,qcdNsite);
	checkCudaErrors(cudaMemcpy(&ret, dret, sizeof(double), cudaMemcpyDeviceToHost));

	MPI_Allreduce(&ret,&sr,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD);
	snorm = 1.0 / sr;

	//init
	cuQCDLA_Equate<<<blocks, threads>>>(dpR,dpS,qcdNsite);
	cuQCDLA_Equate<<<blocks, threads>>>(dpX,dpS,qcdNsite);

	cuQCDDopr_DdagD(dpS,dpU,dpX,dpT,CKs);

	cuQCDLA_MultAddScalar<<<blocks, threads>>>(dpR,dpS,-1.0,qcdNsite);

	cuQCDLA_Equate<<<blocks, threads>>>(dpP,dpR,qcdNsite);

	cuQCDLA_Norm(dret,(double*)dpR,qcdNsite);
	checkCudaErrors(cudaMemcpy(&ret, dret, sizeof(double), cudaMemcpyDeviceToHost));

	MPI_Allreduce(&ret,&rr,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD);
	rrp = rr;

	// printf("%f\n", rr);

	for(iter=0; iter < niter; iter++){
	        cuQCDDopr_DdagD(dpS,dpU,dpP,dpT,CKs);

		cuQCDLA_DotProd(dret,(double*)dpS,(double*)dpP,qcdNsite);
		checkCudaErrors(cudaMemcpy(&ret, dret, sizeof(double), cudaMemcpyDeviceToHost));

		MPI_Allreduce(&ret,&pap,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD);
		cr = rrp/pap;

		cuQCDLA_MultAddScalar<<<blocks, threads>>>(dpX,dpP,cr,qcdNsite);
		cuQCDLA_MultAddScalar<<<blocks, threads>>>(dpR,dpS,-cr,qcdNsite);

		cuQCDLA_Norm(dret,(double*)dpR,qcdNsite);
		checkCudaErrors(cudaMemcpy(&ret, dret, sizeof(double), cudaMemcpyDeviceToHost));

		MPI_Allreduce(&ret,&rr,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD);
		bk = rr/rrp;

		cuQCDLA_MultScalar<<<blocks, threads>>>(dpP,dpP,bk,qcdNsite);
		cuQCDLA_MultAddScalar<<<blocks, threads>>>(dpP,dpR,1.0,qcdNsite);

		rrp = rr;

		// printf("%f\n", rr*snorm);

		if(rr*snorm < enorm){
			nconv = iter;
			break;
		}
	}

	if(nconv == -1 && qcdMyRank == 0){
		printf(" not converged\n");
	}

	cuQCDLA_Equate<<<blocks, threads>>>(dpXq,dpX,qcdNsite);

	cuQCDDopr_DdagD(dpR,dpU,dpX,dpT,CKs);

	cuQCDLA_MultAddScalar<<<blocks, threads>>>(dpR,dpB,-1.0,qcdNsite);

	cuQCDLA_Norm(dret,(double*)dpR,qcdNsite);
	checkCudaErrors(cudaMemcpy(&ret, dret, sizeof(double), cudaMemcpyDeviceToHost));
	MPI_Allreduce(&ret,&rr,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD);

	*pDiff = rr;
	*pNconv = nconv;
}

int main(int argc,char** argv)
{
	int myrank=0,nprocs=1;
	int ngpus=1;
	int latsize[4],localsize[4];
	// int netSize[16],netPos[16],netDim;
	int netSize[16],netPos[16];
	int i,j,t,npIn,nsite;
	// int Niter = QCD_NITER;
	QCDComplex* pSrc;
	QCDComplex* pDest;
	QCDComplex* pGauge;

	QCDComplex* dpSrc;
	QCDComplex* dpDest;
	QCDComplex* dpGauge;

	QCDReal Enorm = QCD_ENORM;
	QCDReal Cks = QCD_CKS;
	QCDReal* pCorr;
	double tstart,tend,ttotal;
	// char* pStr;
	// int ItimeS,NtimeS,ics,ids,is,ie,ipet,it,Nconv,cnt;
	// int ics,ids,is,ipet,it,Nconv;
	int ics,ids,is,ipet,it,Nconv,iv;
	// double CorrF,Diff,rr;
	double CorrF,Diff,rr,tCorrF;
	// unsigned long flops;
	// double tt;

	latsize[0] = 0;
	latsize[1] = 0;
	latsize[2] = 0;
	latsize[3] = 0;

	// netDim = 4;
	netSize[0] = 0;
	netSize[1] = 0;
	netSize[2] = 0;
	netSize[3] = 0;

	for(i=1;i<argc;i++){
		if(argv[i][0] == 'L'){
			t = 0;
			for(j=1;j<strlen(argv[i]);j++){
				if(argv[i][j] == 'x'){
					t++;
				}
				else if(argv[i][j] >= '0' && argv[i][j] <= '9'){
					latsize[t] = 10*latsize[t] + (int)(argv[i][j] - '0');
				}
			}
		}
		else if(argv[i][0] == 'P'){
			t = 0;
			for(j=1;j<strlen(argv[i]);j++){
				if(argv[i][j] == 'x'){
					t++;
				}
				else if(argv[i][j] >= '0' && argv[i][j] <= '9'){
					netSize[t] = 10*netSize[t] + (int)(argv[i][j] - '0');
				}
			}
		}
		else if(argv[i][0] == 'G'){
		    ngpus = (int)(argv[i][1] - '0');
		}
	}

	t = 0;
	for(i=0;i<4;i++){
		if(latsize[0] == 0){
			t++;
		}
	}
	if(t > 0){
		latsize[0] = QCD_NX;
		latsize[1] = QCD_NY;
		latsize[2] = QCD_NZ;
		latsize[3] = QCD_NT;
	}

	MPI_Init(&argc,&argv);

	MPI_Comm_size(MPI_COMM_WORLD,&nprocs);
	MPI_Comm_rank(MPI_COMM_WORLD,&myrank);

	checkCudaErrors(cudaSetDevice(myrank % ngpus));

	npIn = 1;
	for(i=0;i<4;i++){
		npIn *= netSize[i];

		//debug
		/* printf("netSize[%d] == %d\n", i, netSize[i]); */

	}
	if(npIn != nprocs){
		if(myrank == 0){
			printf("Number of processes is invalid\n");
		}
		return 0;
	}

	nsite = 1;
	for(i=0;i<4;i++){
		localsize[i] = latsize[i] / netSize[i];
		nsite *= localsize[i];
	}

	t = myrank;
	for(i=0;i<4;i++){
		netPos[i] = t % netSize[i];
		t /= netSize[i];
	}

	QCDDopr_Init(localsize[0],localsize[1],localsize[2],localsize[3],netSize[0],netSize[1],netSize[2],netSize[3],myrank);

	if(myrank == 0){
		printf("=============================================\n");
		printf("QCD base MPI program\n");
		printf("          Lattice size = %dx%dx%dx%d\n",latsize[0],latsize[1],latsize[2],latsize[3]);
		printf("Decomposed by %d procs : %dx%dx%dx%d\n",nprocs,netSize[0],netSize[1],netSize[2],netSize[3]);
		printf("    Local Lattice size = %dx%dx%dx%d\n",localsize[0],localsize[1],localsize[2],localsize[3]);
		printf("\n Cks = %f\n",Cks);
		printf("=============================================\n");
	}

	pGauge = (QCDComplex*)malloc(sizeof(QCDComplex) * QCD_MATRIX_SIZE * 4 * nsite + 512);
	uinit((QCDReal*)pGauge,latsize[0],latsize[1],latsize[2],latsize[3]);

	checkCudaErrors(cudaMalloc((void**)&dpGauge, sizeof(QCDComplex) * QCD_MATRIX_SIZE * 4 * nsite + 512));
	checkCudaErrors(cudaMemcpy(dpGauge, pGauge, sizeof(QCDComplex) * QCD_MATRIX_SIZE * 4 * nsite + 512, cudaMemcpyHostToDevice));

	pSrc = (QCDComplex*)malloc(sizeof(QCDComplex) * QCD_SPINOR_SIZE * nsite + 128);
	pDest = (QCDComplex*)malloc(sizeof(QCDComplex) * QCD_SPINOR_SIZE * nsite + 128);

	checkCudaErrors(cudaMalloc((void**)&dpSrc, sizeof(QCDComplex) * QCD_SPINOR_SIZE * nsite + 128));
	checkCudaErrors(cudaMalloc((void**)&dpDest, sizeof(QCDComplex) * QCD_SPINOR_SIZE * nsite + 128));

	pCorr = (QCDReal*)malloc(sizeof(QCDReal) * latsize[3]);
 	for(i=0;i<latsize[3];i++){
		pCorr[i] = 0.0;
	}

	ttotal = 0.0;
	/* for(ics=0;ics<QCD_NCOL;ics++){ */
	/* 	for(ids=0;ids<QCD_ND;ids++){ */
	for(ics=0;ics<1;ics++){
		for(ids=0;ids<1;ids++){
			set_src(ids,ics,pSrc,0);

			checkCudaErrors(cudaMemcpy(dpSrc, pSrc, sizeof(QCDComplex) * QCD_SPINOR_SIZE * nsite + 128, cudaMemcpyHostToDevice));
			MPI_Barrier(MPI_COMM_WORLD);
			tstart = mysecond();
			// Solve_CG(pDest,pGauge,pSrc,Cks,Enorm,&Nconv,&Diff);
			cuSolve_CG(dpDest,dpGauge,dpSrc,Cks,Enorm,&Nconv,&Diff);
			MPI_Barrier(MPI_COMM_WORLD);
			tend = mysecond() - tstart;
			ttotal += tend;

			checkCudaErrors(cudaMemcpy(pDest, dpDest, sizeof(QCDComplex) * QCD_SPINOR_SIZE * nsite + 128, cudaMemcpyDeviceToHost));

			if(myrank == 0){
				printf(" %3d %3d  %6d %12.4e ... %f sec\n", ics, ids, Nconv, Diff,tend);
			}

			for(i=0;i<latsize[3];i++){
				ipet = i/localsize[3];
				it = i % localsize[3];
				if(ipet == netPos[3]){
					is = it*localsize[0]*localsize[1]*localsize[2];
					// QCDLA_Norm(&CorrF,(double*)(pDest + is),localsize[0]*localsize[1]*localsize[2]);
					CorrF = 0.0;
					for (iv = 0; iv < QCD_SPINOR_SIZE; iv++) {
					    QCDLA_Norm_Simple(&tCorrF,(double*)(pDest + is + iv * qcdNsite), 2*localsize[0]*localsize[1]*localsize[2]);
					    CorrF += tCorrF;
					}
				}
				else{
					CorrF = 0.0;
				}
				MPI_Allreduce(&CorrF,&rr,1,MPI_DOUBLE_PRECISION,MPI_SUM,MPI_COMM_WORLD);
				pCorr[i] = pCorr[i] + rr;
			}
		}
	}

	if(myrank == 0){

		printf("\nPs meson correlator:\n");
		for(i=0;i<latsize[3];i++){
			printf("%d: %0.8E\n",i,pCorr[i]);
		}

		printf("\n Avg. Solver Time = %f [sec]\n",ttotal / 12);
	}

	MPI_Barrier(MPI_COMM_WORLD);

	MPI_Finalize();

	//debug
	/* printf("finish\n"); */

	return 0;
}






