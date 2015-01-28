/*--------------------------------------------------------------------
	QCD kernel library using CUDA

	Copyright 2015 Koichi Shirahata

	Written by
		Koichi Shirahata

--------------------------------------------------------------------*/
/*--------------------------------------------------------------------
	QCD kernel library

	Copyright 2009-2013 IBM Research - Tokyo, IBM Corporation

	Written by
		Jun Doi  (doichan@jp.ibm.com)
---------------------------------------------------------------------*/

#ifndef __QCD_H__
#define __QCD_H__

#include <stdint.h>
#include <cuComplex.h>

typedef double QCDReal;
// typedef double _Complex QCDComplex;
typedef cuDoubleComplex QCDComplex;

//typedef float QCDReal;
//typedef float _Complex QCDComplex;


#ifndef QCD_NUM_SIMD
#define QCD_NUM_SIMD			1
#endif


#define QCD_COLORS 				3
#define QCD_DIMS 				4

#define QCD_NCOL				3
#define QCD_ND					4



#define QCD_MATRIX_SIZE 		(QCD_COLORS*QCD_COLORS)
#define QCD_SPINOR_SIZE 		(QCD_COLORS*QCD_DIMS)
#define QCD_HALF_SPINOR_SIZE 	(QCD_COLORS*2)


#define QCD_ODD_TO_EVEN 		1
#define QCD_EVEN_TO_ODD			2


#define QCD_XP					0
#define QCD_XM					1
#define QCD_YP					2
#define QCD_YM					3
#define QCD_ZP					4
#define QCD_ZM					5
#define QCD_TP					6
#define QCD_TM					7


#define BGWILSON_X					0
#define BGWILSON_Y					1
#define BGWILSON_Z					2
#define BGWILSON_T					3


#define BGWILSON_FORWARD            1
#define BGWILSON_BACKWARD			-1
#define BGWILSON_BOTH_DIRECTION     0



#define QCD_ACK_BASE			16


#define QCD_BUFFER_ID			0


#define QCD_NUM_BUF				4


#define QCD_DIRAC				0
#define QCD_CHIRAL				1


#define QCD_MAX5D				16

typedef struct __QCDLattice__ {
	int Lx;		/*global lattice size*/
	int Ly;
	int Lz;
	int Lt;
	int Nx;		/*local lattice size*/
	int Ny;
	int Nz;
	int Nt;
	int Nsite;
	int Nxy;
	int Nxyz;
	int BaseEO;
	int nPole;
	int nMaxPole;
	int MatrixSize[4];
}QCDLattice;


typedef struct __QCDSpinor__ {
	QCDComplex v[QCD_SPINOR_SIZE*QCD_NUM_SIMD];
}QCDSpinor;

typedef struct __QCDSpinor1D__ {
	QCDComplex v[QCD_COLORS*QCD_NUM_SIMD];
}QCDSpinor1D;

typedef struct __QCDSpinor2D__ {
	QCDComplex v[2*QCD_COLORS*QCD_NUM_SIMD];
}QCDSpinor2D;

typedef struct __QCDHalfSpinor__ {
	QCDComplex v[QCD_HALF_SPINOR_SIZE*QCD_NUM_SIMD];
}QCDHalfSpinor;

typedef struct __QCDMatrix__ {
	QCDComplex u[QCD_MATRIX_SIZE*QCD_NUM_SIMD];
}QCDMatrix;


#if (QCD_NUM_SIMD==2)
#define QCD_SPINOR_SIZE_IN_BYTE				384
#define QCD_HALF_SPINOR_SIZE_IN_BYTE		192
#define QCD_MATRIX_SIZE_IN_BYTE				288
#else
#define QCD_SPINOR_SIZE_IN_BYTE				192
#define QCD_HALF_SPINOR_SIZE_IN_BYTE		96
#define QCD_MATRIX_SIZE_IN_BYTE				144
#endif


typedef unsigned char QCDIndex;

#ifdef QCD_64BIT
typedef unsigned long long QCDuInt;
typedef long long QCDInt;
#else
typedef unsigned int QCDuInt;
typedef int QCDInt;
#endif



/*
typedef struct __QCDMopr5_5D_info__ {
	uint16_t ixmb;
	uint16_t ixpb;
	uint16_t iymb;
	uint16_t iypb;
	uint16_t izmb;
	uint16_t izpb;
	int16_t itmb;
	int16_t itpb;
	int16_t xpOffset;
	int16_t xmOffset;
	int8_t bndX;
	int8_t bndY;
	int8_t bndZ;
	int8_t bndT;
}QCDMopr5_5D_info;
*/

typedef struct __QCDMopr5_5D_info__ {
	uint8_t iymb;
	uint8_t iypb;
	uint8_t izmb;
	uint8_t izpb;
	uint8_t itmb;
	uint8_t itpb;
	uint8_t xPar;
	uint8_t bnd;
}QCDMopr5_5D_info;




typedef struct __QCDMopr_Thread_Info__ {
	int posBxp;
	int posBxm;
	int posByp;
	int posBym;
	int posBzp;
	int posBzm;
	int posBtp;
	int posBtm;
	int numBxp;
	int numBxm;
	int numByp;
	int numBym;
	int numBzp;
	int numBzm;
	int numBtp;
	int numBtm;

	int yztStart;
	int yztEnd;

	int zBMNum;
	int zBPNum;
	int zINNum;
	int* zBMOffset;
	int* zBMLength;
	int* zBPOffset;
	int* zBPLength;
	int* zINOffset;
	int* zINLength;

	int tBMOffset;
	int tBMLength;
	int tBPOffset;
	int tBPLength;
	int tINOffset;
	int tINLength;

	int bndPos[2][4];
	int bndNum[2][4];
	int bndOuterS[2][4];
	int bndOuterE[2][4];
	int bndInnerS[2][4];
	int bndInnerE[2][4];
}QCDMopr_ThreadInfo;


#define QCD_BND_XP			0x01
#define QCD_BND_XM			0x02
#define QCD_BND_X			(QCD_BND_XP|QCD_BND_XM)
#define QCD_BND_YP			0x04
#define QCD_BND_YM			0x08
#define QCD_BND_Y			(QCD_BND_YP|QCD_BND_YM)
#define QCD_BND_ZP			0x10
#define QCD_BND_ZM			0x20
#define QCD_BND_Z			(QCD_BND_ZP|QCD_BND_ZM)
#define QCD_BND_TP			0x40
#define QCD_BND_TM			0x80
#define QCD_BND_T			(QCD_BND_TP|QCD_BND_TM)


typedef void (*QCDMopr5_5D_EO_1SITE_Proc)(QCDMopr5_5D_info* pInfo,QCDSpinor* pV,QCDMatrix* pU,QCDSpinor* pW,int nPole,int tid,int nid,double* pK,double* pPrm);



#ifdef QCD_BGQ
#define QCD_NUM_MAX_THREADS			64
#else
#define QCD_NUM_MAX_THREADS			64
#endif



#define qcd_dopr_5d_eo_opt qcd_dopr_5d_eo_opt_large
//#define qcd_dopr_5d_eo_opt qcd_dopr_5d_eo_opt_small



typedef void (*QCDMopr_PostProc)(QCDSpinor* pV,int n,int nPole,void* pParam);


#endif	//__QCD_H__

