/*--------------------------------------------------------------------
	QCD kernel library

	Copyright 2009-2013 IBM Research - Tokyo, IBM Corporation

	Written by
		Jun Doi  (doichan@jp.ibm.com)
---------------------------------------------------------------------*/

#ifndef __QCD_MULT_H__
#define __QCD_MULT_H__

#include "qcd.h"

#define cuDoubleComplex_I make_cuDoubleComplex(0, 1)

#define SPINOR_ID(i,j) (i + j * dqcdNsite)

#define QCDDopr_LoadGauge(vec,pt) \
{\
	QCDComplex* pT;\
	int iSet,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + iSIMD;\
		for(iSet=0;iSet<9;iSet++){\
			vec[iSet + iSIMD*9] = *pT;\
			pT += QCD_NUM_SIMD;\
		}\
	}\
}\

#define QCDDopr_LoadGauge_Stride(vec,pt) \
{\
	QCDComplex* pT;\
	int iSet;\
	pT = pt;		\
	for(iSet=0;iSet<9;iSet++){		\
	    vec[iSet] = *pT;			\
	    pT += 4 * dqcdNsite;		\
	}					\
}\



#define QCDDopr_Copy(dest,src,nSet) \
{\
	QCDComplex* pSrc;\
	QCDComplex* pDest;\
	int iCol,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pSrc = (QCDComplex*)(src) + iSIMD;\
		pDest = (QCDComplex*)(dest) + iSIMD;\
		for(iCol=0;iCol<3*nSet;iCol++){\
			*pDest = *pSrc;\
			pSrc += QCD_NUM_SIMD;\
			pDest += QCD_NUM_SIMD;\
		}\
	}\
}\

#define QCDDopr_Add(dest,src,nSet) \
{\
	QCDComplex* pSrc;\
	QCDComplex* pDest;\
	int iCol,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pSrc = (QCDComplex*)(src) + iSIMD;\
		pDest = (QCDComplex*)(dest) + iSIMD;\
		for(iCol=0;iCol<3*nSet;iCol++){\
			*pDest += *pSrc;\
			pSrc += QCD_NUM_SIMD;\
			pDest += QCD_NUM_SIMD;\
		}\
	}\
}\


#ifdef QCD_SPINOR_4X3

#define QCDDopr_Load(vec,pt,nSet) \
{\
	QCDComplex* pT;\
	int iSet,iCol,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + iSIMD;\
		for(iCol=0;iCol<3;iCol++){\
			for(iSet=0;iSet<nSet;iSet++){\
				vec[iSet*3 + iCol + iSIMD*nSet*3] = *pT;\
				pT += QCD_NUM_SIMD;\
			}\
		}\
	}\
}\


#define QCDDopr_Load5(vec,pt) \
{\
	QCDComplex* pT;\
	int iSet,iCol,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + iSIMD;\
		for(iCol=0;iCol<3;iCol++){\
			vec[    iCol + iSIMD*12] = pT[2*QCD_NUM_SIMD];\
			vec[3 + iCol + iSIMD*12] = pT[3*QCD_NUM_SIMD];\
			vec[6 + iCol + iSIMD*12] = pT[0*QCD_NUM_SIMD];\
			vec[9 + iCol + iSIMD*12] = pT[1*QCD_NUM_SIMD];\
			pT += QCD_NUM_SIMD*4;\
		}\
	}\
}\

#define QCDDopr_Store(vec,pt,nSet) \
{\
	QCDComplex* pT;\
	int iSet,iCol,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + iSIMD;\
		for(iCol=0;iCol<3;iCol++){\
			for(iSet=0;iSet<nSet;iSet++){\
				*pT = vec[iSet*3 + iCol + iSIMD*nSet*3];\
				pT += QCD_NUM_SIMD;\
			}\
		}\
	}\
}\

#define QCDDopr_StoreShiftPlus(vec,pt,nSet) \
{\
	QCDComplex* pT;\
	int iSet,iCol,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + ((iSIMD + 1) % QCD_NUM_SIMD);\
		for(iCol=0;iCol<3;iCol++){\
			for(iSet=0;iSet<nSet;iSet++){\
				*pT = vec[iSet*3 + iCol + iSIMD*nSet*3];\
				pT += QCD_NUM_SIMD;\
			}\
		}\
	}\
}\

#define QCDDopr_StoreShiftMinus(vec,pt,nSet) \
{\
	QCDComplex* pT;\
	int iSet,iCol,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + ((iSIMD + QCD_NUM_SIMD - 1) % QCD_NUM_SIMD);\
		for(iCol=0;iCol<3;iCol++){\
			for(iSet=0;iSet<nSet;iSet++){\
				*pT = vec[iSet*3 + iCol + iSIMD*nSet*3];\
				pT += QCD_NUM_SIMD;\
			}\
		}\
	}\
}\


#else

#define QCDDopr_Load(vec,pt,nSet) \
{\
	QCDComplex* pT;\
	int iSet,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + iSIMD;\
		for(iSet=0;iSet<nSet*3;iSet++){\
			vec[iSet + iSIMD*nSet*3] = *pT;\
			pT += QCD_NUM_SIMD;\
		}\
	}\
}\

// #define QCDDopr_Load(vec,pt,nSet)		\
// {						\
//     QCDComplex* pT;					\
//     int iSet;						\
//     pT = pt;						\
//     for(iSet=0;iSet<nSet*3;iSet++){			\
// 	vec[iSet] = *pT;				\
// 	pT += qcdNsite;					\
//     }							\
// }							\
	
#define QCDDopr_Load_Stride(vec,pt,stride,nSet)	\
{						\
    QCDComplex* pT;					\
    int iSet;						\
    pT = pt;						\
    for(iSet=0;iSet<nSet*3;iSet++){			\
	vec[iSet] = *pT;				\
	pT += stride;					\
    }							\
}							\
	
#define QCDDopr_Load5(vec,pt) \
{\
	QCDComplex* pT;\
	int iSet,iCol,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + iSIMD;\
		for(iCol=0;iCol<3;iCol++){\
			vec[    iCol + iSIMD*12] = pT[6*QCD_NUM_SIMD];\
			vec[3 + iCol + iSIMD*12] = pT[9*QCD_NUM_SIMD];\
			vec[6 + iCol + iSIMD*12] = pT[0*QCD_NUM_SIMD];\
			vec[9 + iCol + iSIMD*12] = pT[3*QCD_NUM_SIMD];\
			pT += QCD_NUM_SIMD;\
		}\
	}\
}\


#define QCDDopr_Store(vec,pt,nSet) \
{\
	QCDComplex* pT;\
	int iSet,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + iSIMD;\
		for(iSet=0;iSet<nSet*3;iSet++){\
			*pT = vec[iSet + iSIMD*nSet*3];\
			pT += QCD_NUM_SIMD;\
		}\
	}\
}\

// #define QCDDopr_Store(vec,pt,nSet)		\
// {\
// 	QCDComplex* pT;\
// 	int iSet;\
// 	pT = pt;					\
// 	for(iSet=0;iSet<nSet*3;iSet++){			\
// 	    *pT = vec[iSet];		\
// 	    pT += qcdNsite;				\
// 	}						\
// }\

#define QCDDopr_Store_Stride(vec,pt,stride,nSet)		\
{\
	QCDComplex* pT;\
	int iSet;\
	pT = pt;					\
	for(iSet=0;iSet<nSet*3;iSet++){			\
	    *pT = vec[iSet];		\
	    pT += stride;				\
	}						\
}\

#define QCDDopr_StoreShiftPlus(vec,pt,nSet) \
{\
	QCDComplex* pT;\
	int iSet,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + ((iSIMD + 1) % QCD_NUM_SIMD);\
		for(iSet=0;iSet<nSet*3;iSet++){\
			*pT = vec[iSet + iSIMD*nSet*3];\
			pT += QCD_NUM_SIMD;\
		}\
	}\
}\


#define QCDDopr_StoreShiftMinus(vec,pt,nSet) \
{\
	QCDComplex* pT;\
	int iSet,iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		pT = (QCDComplex*)(pt) + ((iSIMD + QCD_NUM_SIMD - 1) % QCD_NUM_SIMD);\
		for(iSet=0;iSet<nSet*3;iSet++){\
			*pT = vec[iSet + iSIMD*nSet*3];\
			pT += QCD_NUM_SIMD;\
		}\
	}\
}\


#endif


#define DOPRSET_SPIN		4
#define DOPRSET_HSPIN		2

// #define QCD_MUL_UP(v,u,t) 		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*6 + 0] = u[iSIMD*9 + 0] * t[iSIMD*6 + 0] + u[iSIMD*9 + 1] * t[iSIMD*6 + 1] + u[iSIMD*9 + 2] * t[iSIMD*6 + 2];\
// 		v[iSIMD*6 + 3] = u[iSIMD*9 + 0] * t[iSIMD*6 + 3] + u[iSIMD*9 + 1] * t[iSIMD*6 + 4] + u[iSIMD*9 + 2] * t[iSIMD*6 + 5];\
// 		v[iSIMD*6 + 1] = u[iSIMD*9 + 3] * t[iSIMD*6 + 0] + u[iSIMD*9 + 4] * t[iSIMD*6 + 1] + u[iSIMD*9 + 5] * t[iSIMD*6 + 2];\
// 		v[iSIMD*6 + 4] = u[iSIMD*9 + 3] * t[iSIMD*6 + 3] + u[iSIMD*9 + 4] * t[iSIMD*6 + 4] + u[iSIMD*9 + 5] * t[iSIMD*6 + 5];\
// 		v[iSIMD*6 + 2] = u[iSIMD*9 + 6] * t[iSIMD*6 + 0] + u[iSIMD*9 + 7] * t[iSIMD*6 + 1] + u[iSIMD*9 + 8] * t[iSIMD*6 + 2];\
// 		v[iSIMD*6 + 5] = u[iSIMD*9 + 6] * t[iSIMD*6 + 3] + u[iSIMD*9 + 7] * t[iSIMD*6 + 4] + u[iSIMD*9 + 8] * t[iSIMD*6 + 5];\
// 	}\
// }\

#define QCD_MUL_UP(v,u,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*6 + 0] = cuCadd(cuCadd(cuCmul(u[iSIMD*9 + 0], t[iSIMD*6 + 0]), \
					   cuCmul(u[iSIMD*9 + 1], t[iSIMD*6 + 1])), \
				    cuCmul(u[iSIMD*9 + 2], t[iSIMD*6 + 2])); \
	    v[iSIMD*6 + 3] = cuCadd(cuCadd(cuCmul(u[iSIMD*9 + 0], t[iSIMD*6 + 3]), \
					   cuCmul(u[iSIMD*9 + 1], t[iSIMD*6 + 4])), \
				    cuCmul(u[iSIMD*9 + 2], t[iSIMD*6 + 5])); \
	    v[iSIMD*6 + 1] = cuCadd(cuCadd(cuCmul(u[iSIMD*9 + 3], t[iSIMD*6 + 0]), \
					   cuCmul(u[iSIMD*9 + 4], t[iSIMD*6 + 1])), \
				    cuCmul(u[iSIMD*9 + 5], t[iSIMD*6 + 2])); \
	    v[iSIMD*6 + 4] = cuCadd(cuCadd(cuCmul(u[iSIMD*9 + 3], t[iSIMD*6 + 3]), \
					   cuCmul(u[iSIMD*9 + 4], t[iSIMD*6 + 4])), \
				    cuCmul(u[iSIMD*9 + 5], t[iSIMD*6 + 5])); \
	    v[iSIMD*6 + 2] = cuCadd(cuCadd(cuCmul(u[iSIMD*9 + 6], t[iSIMD*6 + 0]), \
					   cuCmul(u[iSIMD*9 + 7], t[iSIMD*6 + 1])), \
				    cuCmul(u[iSIMD*9 + 8], t[iSIMD*6 + 2])); \
	    v[iSIMD*6 + 5] = cuCadd(cuCadd(cuCmul(u[iSIMD*9 + 6], t[iSIMD*6 + 3]), \
					   cuCmul(u[iSIMD*9 + 7], t[iSIMD*6 + 4])), \
				    cuCmul(u[iSIMD*9 + 8], t[iSIMD*6 + 5])); \
	}\
}\

// #define QCD_MUL_UM(v,u,t) 		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*6 + 0] = ~u[iSIMD*9 + 0] * t[iSIMD*6 + 0] + ~u[iSIMD*9 + 3] * t[iSIMD*6 + 1] + ~u[iSIMD*9 + 6] * t[iSIMD*6 + 2];\
// 		v[iSIMD*6 + 3] = ~u[iSIMD*9 + 0] * t[iSIMD*6 + 3] + ~u[iSIMD*9 + 3] * t[iSIMD*6 + 4] + ~u[iSIMD*9 + 6] * t[iSIMD*6 + 5];\
// 		v[iSIMD*6 + 1] = ~u[iSIMD*9 + 1] * t[iSIMD*6 + 0] + ~u[iSIMD*9 + 4] * t[iSIMD*6 + 1] + ~u[iSIMD*9 + 7] * t[iSIMD*6 + 2];\
// 		v[iSIMD*6 + 4] = ~u[iSIMD*9 + 1] * t[iSIMD*6 + 3] + ~u[iSIMD*9 + 4] * t[iSIMD*6 + 4] + ~u[iSIMD*9 + 7] * t[iSIMD*6 + 5];\
// 		v[iSIMD*6 + 2] = ~u[iSIMD*9 + 2] * t[iSIMD*6 + 0] + ~u[iSIMD*9 + 5] * t[iSIMD*6 + 1] + ~u[iSIMD*9 + 8] * t[iSIMD*6 + 2];\
// 		v[iSIMD*6 + 5] = ~u[iSIMD*9 + 2] * t[iSIMD*6 + 3] + ~u[iSIMD*9 + 5] * t[iSIMD*6 + 4] + ~u[iSIMD*9 + 8] * t[iSIMD*6 + 5];\
// 	}\
// }\

#define QCD_MUL_UM(v,u,t) 		\
{\
    int iSIMD;						\
    for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){				\
	v[iSIMD*6 + 0] = cuCadd(cuCadd(cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 0].x, -u[iSIMD*9 + 0].y), t[iSIMD*6 + 0]), \
				       cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 3].x, -u[iSIMD*9 + 3].y), t[iSIMD*6 + 1])), \
				cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 6].x, -u[iSIMD*9 + 6].y), t[iSIMD*6 + 2])); \
	v[iSIMD*6 + 3] = cuCadd(cuCadd(cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 0].x, -u[iSIMD*9 + 0].y), t[iSIMD*6 + 3]), \
				       cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 3].x, -u[iSIMD*9 + 3].y), t[iSIMD*6 + 4])), \
				cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 6].x, -u[iSIMD*9 + 6].y), t[iSIMD*6 + 5])); \
	v[iSIMD*6 + 1] = cuCadd(cuCadd(cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 1].x, -u[iSIMD*9 + 1].y), t[iSIMD*6 + 0]), \
				       cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 4].x, -u[iSIMD*9 + 4].y), t[iSIMD*6 + 1])), \
				cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 7].x, -u[iSIMD*9 + 7].y), t[iSIMD*6 + 2])); \
	v[iSIMD*6 + 4] = cuCadd(cuCadd(cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 1].x, -u[iSIMD*9 + 1].y), t[iSIMD*6 + 3]), \
				       cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 4].x, -u[iSIMD*9 + 4].y), t[iSIMD*6 + 4])), \
				cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 7].x, -u[iSIMD*9 + 7].y), t[iSIMD*6 + 5])); \
	v[iSIMD*6 + 2] = cuCadd(cuCadd(cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 2].x, -u[iSIMD*9 + 2].y), t[iSIMD*6 + 0]), \
				       cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 5].x, -u[iSIMD*9 + 5].y), t[iSIMD*6 + 1])), \
				cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 8].x, -u[iSIMD*9 + 8].y), t[iSIMD*6 + 2])); \
	v[iSIMD*6 + 5] = cuCadd(cuCadd(cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 2].x, -u[iSIMD*9 + 2].y), t[iSIMD*6 + 3]), \
				       cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 5].x, -u[iSIMD*9 + 5].y), t[iSIMD*6 + 4])), \
				cuCmul(make_cuDoubleComplex(u[iSIMD*9 + 8].x, -u[iSIMD*9 + 8].y), t[iSIMD*6 + 5])); \
    }									\
}									\


#define QCD_MUL_UP_1(v,u,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*3 + 0] = u[iSIMD*9 + 0] * t[iSIMD*3 + 0] + u[iSIMD*9 + 1] * t[iSIMD*3 + 1] + u[iSIMD*9 + 2] * t[iSIMD*3 + 2];\
		v[iSIMD*3 + 1] = u[iSIMD*9 + 3] * t[iSIMD*3 + 0] + u[iSIMD*9 + 4] * t[iSIMD*3 + 1] + u[iSIMD*9 + 5] * t[iSIMD*3 + 2];\
		v[iSIMD*3 + 2] = u[iSIMD*9 + 6] * t[iSIMD*3 + 0] + u[iSIMD*9 + 7] * t[iSIMD*3 + 1] + u[iSIMD*9 + 8] * t[iSIMD*3 + 2];\
	}\
}\

#define QCD_MUL_UM_1(v,u,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*3 + 0] = ~u[iSIMD*9 + 0] * t[iSIMD*3 + 0] + ~u[iSIMD*9 + 3] * t[iSIMD*3 + 1] + ~u[iSIMD*9 + 6] * t[iSIMD*3 + 2];\
		v[iSIMD*3 + 1] = ~u[iSIMD*9 + 1] * t[iSIMD*3 + 0] + ~u[iSIMD*9 + 4] * t[iSIMD*3 + 1] + ~u[iSIMD*9 + 7] * t[iSIMD*3 + 2];\
		v[iSIMD*3 + 2] = ~u[iSIMD*9 + 2] * t[iSIMD*3 + 0] + ~u[iSIMD*9 + 5] * t[iSIMD*3 + 1] + ~u[iSIMD*9 + 8] * t[iSIMD*3 + 2];\
	}\
}\



#define QCD_MADD_UP(v,u,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*6 + 0] += u[iSIMD*9 + 0] * t[iSIMD*6 + 0] + u[iSIMD*9 + 1] * t[iSIMD*6 + 1] + u[iSIMD*9 + 2] * t[iSIMD*6 + 2];\
		v[iSIMD*6 + 3] += u[iSIMD*9 + 0] * t[iSIMD*6 + 3] + u[iSIMD*9 + 1] * t[iSIMD*6 + 4] + u[iSIMD*9 + 2] * t[iSIMD*6 + 5];\
		v[iSIMD*6 + 1] += u[iSIMD*9 + 3] * t[iSIMD*6 + 0] + u[iSIMD*9 + 4] * t[iSIMD*6 + 1] + u[iSIMD*9 + 5] * t[iSIMD*6 + 2];\
		v[iSIMD*6 + 4] += u[iSIMD*9 + 3] * t[iSIMD*6 + 3] + u[iSIMD*9 + 4] * t[iSIMD*6 + 4] + u[iSIMD*9 + 5] * t[iSIMD*6 + 5];\
		v[iSIMD*6 + 2] += u[iSIMD*9 + 6] * t[iSIMD*6 + 0] + u[iSIMD*9 + 7] * t[iSIMD*6 + 1] + u[iSIMD*9 + 8] * t[iSIMD*6 + 2];\
		v[iSIMD*6 + 5] += u[iSIMD*9 + 6] * t[iSIMD*6 + 3] + u[iSIMD*9 + 7] * t[iSIMD*6 + 4] + u[iSIMD*9 + 8] * t[iSIMD*6 + 5];\
	}\
}\

#define QCD_MADD_UM(v,u,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*6 + 0] += ~u[iSIMD*9 + 0] * t[iSIMD*6 + 0] + ~u[iSIMD*9 + 3] * t[iSIMD*6 + 1] + ~u[iSIMD*9 + 6] * t[iSIMD*6 + 2];\
		v[iSIMD*6 + 3] += ~u[iSIMD*9 + 0] * t[iSIMD*6 + 3] + ~u[iSIMD*9 + 3] * t[iSIMD*6 + 4] + ~u[iSIMD*9 + 6] * t[iSIMD*6 + 5];\
		v[iSIMD*6 + 1] += ~u[iSIMD*9 + 1] * t[iSIMD*6 + 0] + ~u[iSIMD*9 + 4] * t[iSIMD*6 + 1] + ~u[iSIMD*9 + 7] * t[iSIMD*6 + 2];\
		v[iSIMD*6 + 4] += ~u[iSIMD*9 + 1] * t[iSIMD*6 + 3] + ~u[iSIMD*9 + 4] * t[iSIMD*6 + 4] + ~u[iSIMD*9 + 7] * t[iSIMD*6 + 5];\
		v[iSIMD*6 + 2] += ~u[iSIMD*9 + 2] * t[iSIMD*6 + 0] + ~u[iSIMD*9 + 5] * t[iSIMD*6 + 1] + ~u[iSIMD*9 + 8] * t[iSIMD*6 + 2];\
		v[iSIMD*6 + 5] += ~u[iSIMD*9 + 2] * t[iSIMD*6 + 3] + ~u[iSIMD*9 + 5] * t[iSIMD*6 + 4] + ~u[iSIMD*9 + 8] * t[iSIMD*6 + 5];\
	}\
}\


#define QCD_MADD_UP_1(v,u,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*3 + 0] += u[iSIMD*9 + 0] * t[iSIMD*3 + 0] + u[iSIMD*9 + 1] * t[iSIMD*3 + 1] + u[iSIMD*9 + 2] * t[iSIMD*3 + 2];\
		v[iSIMD*3 + 1] += u[iSIMD*9 + 3] * t[iSIMD*3 + 0] + u[iSIMD*9 + 4] * t[iSIMD*3 + 1] + u[iSIMD*9 + 5] * t[iSIMD*3 + 2];\
		v[iSIMD*3 + 2] += u[iSIMD*9 + 6] * t[iSIMD*3 + 0] + u[iSIMD*9 + 7] * t[iSIMD*3 + 1] + u[iSIMD*9 + 8] * t[iSIMD*3 + 2];\
	}\
}\

#define QCD_MADD_UM_1(v,u,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*3 + 0] += ~u[iSIMD*9 + 0] * t[iSIMD*3 + 0] + ~u[iSIMD*9 + 3] * t[iSIMD*3 + 1] + ~u[iSIMD*9 + 6] * t[iSIMD*3 + 2];\
		v[iSIMD*3 + 1] += ~u[iSIMD*9 + 1] * t[iSIMD*3 + 0] + ~u[iSIMD*9 + 4] * t[iSIMD*3 + 1] + ~u[iSIMD*9 + 7] * t[iSIMD*3 + 2];\
		v[iSIMD*3 + 2] += ~u[iSIMD*9 + 2] * t[iSIMD*3 + 0] + ~u[iSIMD*9 + 5] * t[iSIMD*3 + 1] + ~u[iSIMD*9 + 8] * t[iSIMD*3 + 2];\
	}\
}\

#define QCD_ADD_1(v,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*3 + 0] += t[iSIMD*3 + 0];\
		v[iSIMD*3 + 1] += t[iSIMD*3 + 1];\
		v[iSIMD*3 + 2] += t[iSIMD*3 + 2];\
	}\
}\

#define QCD_MADD_1(v,t,s) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*3 + 0] += s*t[iSIMD*3 + 0];\
		v[iSIMD*3 + 1] += s*t[iSIMD*3 + 1];\
		v[iSIMD*3 + 2] += s*t[iSIMD*3 + 2];\
	}\
}\


#define QCD_SUB_1(v,t) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*3 + 0] -= t[iSIMD*3 + 0];\
		v[iSIMD*3 + 1] -= t[iSIMD*3 + 1];\
		v[iSIMD*3 + 2] -= t[iSIMD*3 + 2];\
	}\
}\

#define QCD_MSUB_1(v,t,s) 		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*3 + 0] -= s*t[iSIMD*3 + 0];\
		v[iSIMD*3 + 1] -= s*t[iSIMD*3 + 1];\
		v[iSIMD*3 + 2] -= s*t[iSIMD*3 + 2];\
	}\
}\


// #define QCD_UXM_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = w[iSIMD*12 + 0] - _Complex_I * w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 1] = w[iSIMD*12 + 1] - _Complex_I * w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 2] = w[iSIMD*12 + 2] - _Complex_I * w[iSIMD*12 + 11];\
// \
// 		t[iSIMD*6 + 3] = w[iSIMD*12 + 3] - _Complex_I * w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 4] = w[iSIMD*12 + 4] - _Complex_I * w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 5] = w[iSIMD*12 + 5] - _Complex_I * w[iSIMD*12 + 8];\
// 	}\
// }\

#define QCD_UXM_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCsub(w[iSIMD*12 + 0], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 9])); \
	    t[iSIMD*6 + 1] = cuCsub(w[iSIMD*12 + 1], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 10])); \
	    t[iSIMD*6 + 2] = cuCsub(w[iSIMD*12 + 2], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 11])); \
\
	    t[iSIMD*6 + 3] = cuCsub(w[iSIMD*12 + 3], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 6])); \
	    t[iSIMD*6 + 4] = cuCsub(w[iSIMD*12 + 4], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 7])); \
	    t[iSIMD*6 + 5] = cuCsub(w[iSIMD*12 + 5], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 8])); \
	}\
}\

// #define QCD_UXP_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = w[iSIMD*12 + 0] + _Complex_I * w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 1] = w[iSIMD*12 + 1] + _Complex_I * w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 2] = w[iSIMD*12 + 2] + _Complex_I * w[iSIMD*12 + 11];\
// \
// 		t[iSIMD*6 + 3] = w[iSIMD*12 + 3] + _Complex_I * w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 4] = w[iSIMD*12 + 4] + _Complex_I * w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 5] = w[iSIMD*12 + 5] + _Complex_I * w[iSIMD*12 + 8];\
// 	}\
// }\

#define QCD_UXP_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCadd(w[iSIMD*12 + 0], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 9])); \
	    t[iSIMD*6 + 1] = cuCadd(w[iSIMD*12 + 1], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 10])); \
	    t[iSIMD*6 + 2] = cuCadd(w[iSIMD*12 + 2], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 11])); \
\
	    t[iSIMD*6 + 3] = cuCadd(w[iSIMD*12 + 3], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 6])); \
	    t[iSIMD*6 + 4] = cuCadd(w[iSIMD*12 + 4], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 7])); \
	    t[iSIMD*6 + 5] = cuCadd(w[iSIMD*12 + 5], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 8])); \
	}\
}\

// #define QCD_UXM_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// \
// 		v[iSIMD*12 + 6] += _Complex_I * h[iSIMD*6 + 3] * k[2];\
// 		v[iSIMD*12 + 7] += _Complex_I * h[iSIMD*6 + 4] * k[2];\
// 		v[iSIMD*12 + 8] += _Complex_I * h[iSIMD*6 + 5] * k[2];\
// \
// 		v[iSIMD*12 + 9]  += _Complex_I * h[iSIMD*6 + 0] * k[3];\
// 		v[iSIMD*12 + 10] += _Complex_I * h[iSIMD*6 + 1] * k[3];\
// 		v[iSIMD*12 + 11] += _Complex_I * h[iSIMD*6 + 2] * k[3];\
// 	}\
// }\

#define QCD_UXM_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
\
	    v[iSIMD*12 + 6] = cuCadd(v[iSIMD*12 + 6], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[2], 0)))); \
	    v[iSIMD*12 + 7] = cuCadd(v[iSIMD*12 + 7], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[2], 0)))); \
	    v[iSIMD*12 + 8] = cuCadd(v[iSIMD*12 + 8], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[2], 0)))); \
\
	    v[iSIMD*12 + 9]  = cuCadd(v[iSIMD*12 + 9], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[3], 0)))); \
	    v[iSIMD*12 + 10] = cuCadd(v[iSIMD*12 + 10], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[3], 0)))); \
	    v[iSIMD*12 + 11] = cuCadd(v[iSIMD*12 + 11], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[3], 0)))); \
	}\
}\

// #define QCD_UXP_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// \
// 		v[iSIMD*12 + 6] -= _Complex_I * h[iSIMD*6 + 3] * k[2];\
// 		v[iSIMD*12 + 7] -= _Complex_I * h[iSIMD*6 + 4] * k[2];\
// 		v[iSIMD*12 + 8] -= _Complex_I * h[iSIMD*6 + 5] * k[2];\
// \
// 		v[iSIMD*12 + 9]  -= _Complex_I * h[iSIMD*6 + 0] * k[3];\
// 		v[iSIMD*12 + 10] -= _Complex_I * h[iSIMD*6 + 1] * k[3];\
// 		v[iSIMD*12 + 11] -= _Complex_I * h[iSIMD*6 + 2] * k[3];\
// 	}\
// }\

#define QCD_UXP_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
\
	    v[iSIMD*12 + 6] = cuCsub(v[iSIMD*12 + 6], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[2], 0)))); \
	    v[iSIMD*12 + 7] = cuCsub(v[iSIMD*12 + 7], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[2], 0)))); \
	    v[iSIMD*12 + 8] = cuCsub(v[iSIMD*12 + 8], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[2], 0)))); \
\
	    v[iSIMD*12 + 9] = cuCsub(v[iSIMD*12 + 9], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[3], 0)))); \
	    v[iSIMD*12 + 10] = cuCsub(v[iSIMD*12 + 10], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[3], 0)))); \
	    v[iSIMD*12 + 11] = cuCsub(v[iSIMD*12 + 11], cuCmul(cuDoubleComplex_I, cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[3], 0)))); \
	}\
}\


// #define QCD_UYM_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = w[iSIMD*12 + 0] - w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 1] = w[iSIMD*12 + 1] - w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 2] = w[iSIMD*12 + 2] - w[iSIMD*12 + 11];\
// \
// 		t[iSIMD*6 + 3] = w[iSIMD*12 + 3] + w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 4] = w[iSIMD*12 + 4] + w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 5] = w[iSIMD*12 + 5] + w[iSIMD*12 + 8];\
// 	}\
// }\

#define QCD_UYM_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCsub(w[iSIMD*12 + 0], w[iSIMD*12 + 9]);	\
	    t[iSIMD*6 + 1] = cuCsub(w[iSIMD*12 + 1], w[iSIMD*12 + 10]);	\
	    t[iSIMD*6 + 2] = cuCsub(w[iSIMD*12 + 2], w[iSIMD*12 + 11]); \
\
	    t[iSIMD*6 + 3] = cuCadd(w[iSIMD*12 + 3], w[iSIMD*12 + 6]);	\
	    t[iSIMD*6 + 4] = cuCadd(w[iSIMD*12 + 4], w[iSIMD*12 + 7]);	\
	    t[iSIMD*6 + 5] = cuCadd(w[iSIMD*12 + 5], w[iSIMD*12 + 8]);	\
	}\
}\

// #define QCD_UYP_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = w[iSIMD*12 + 0] + w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 1] = w[iSIMD*12 + 1] + w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 2] = w[iSIMD*12 + 2] + w[iSIMD*12 + 11];\
// \
// 		t[iSIMD*6 + 3] = w[iSIMD*12 + 3] - w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 4] = w[iSIMD*12 + 4] - w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 5] = w[iSIMD*12 + 5] - w[iSIMD*12 + 8];\
// 	}\
// }\

#define QCD_UYP_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCadd(w[iSIMD*12 + 0], w[iSIMD*12 + 9]);	\
	    t[iSIMD*6 + 1] = cuCadd(w[iSIMD*12 + 1], w[iSIMD*12 + 10]);	\
	    t[iSIMD*6 + 2] = cuCadd(w[iSIMD*12 + 2], w[iSIMD*12 + 11]);	\
\
	    t[iSIMD*6 + 3] = cuCsub(w[iSIMD*12 + 3], w[iSIMD*12 + 6]);	\
	    t[iSIMD*6 + 4] = cuCsub(w[iSIMD*12 + 4], w[iSIMD*12 + 7]);	\
	    t[iSIMD*6 + 5] = cuCsub(w[iSIMD*12 + 5], w[iSIMD*12 + 8]);	\
	}\
}\

// #define QCD_UYM_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// \
// 		v[iSIMD*12 + 6] += h[iSIMD*6 + 3] * k[2];\
// 		v[iSIMD*12 + 7] += h[iSIMD*6 + 4] * k[2];\
// 		v[iSIMD*12 + 8] += h[iSIMD*6 + 5] * k[2];\
// \
// 		v[iSIMD*12 + 9]  -= h[iSIMD*6 + 0] * k[3];\
// 		v[iSIMD*12 + 10] -= h[iSIMD*6 + 1] * k[3];\
// 		v[iSIMD*12 + 11] -= h[iSIMD*6 + 2] * k[3];\
// 	}\
// }\

#define QCD_UYM_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
\
	    v[iSIMD*12 + 6] = cuCadd(v[iSIMD*12 + 6], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 7] = cuCadd(v[iSIMD*12 + 7], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 8] = cuCadd(v[iSIMD*12 + 8], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[2], 0))); \
\
	    v[iSIMD*12 + 9]  = cuCsub(v[iSIMD*12 + 9], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 10] = cuCsub(v[iSIMD*12 + 10], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 11] = cuCsub(v[iSIMD*12 + 11], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[3], 0))); \
	}\
}\

// #define QCD_UYP_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// \
// 		v[iSIMD*12 + 6] -= h[iSIMD*6 + 3] * k[2];\
// 		v[iSIMD*12 + 7] -= h[iSIMD*6 + 4] * k[2];\
// 		v[iSIMD*12 + 8] -= h[iSIMD*6 + 5] * k[2];\
// \
// 		v[iSIMD*12 + 9]  += h[iSIMD*6 + 0] * k[3];\
// 		v[iSIMD*12 + 10] += h[iSIMD*6 + 1] * k[3];\
// 		v[iSIMD*12 + 11] += h[iSIMD*6 + 2] * k[3];\
// 	}\
// }\

#define QCD_UYP_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
\
	    v[iSIMD*12 + 6] = cuCsub(v[iSIMD*12 + 6], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 7] = cuCsub(v[iSIMD*12 + 7], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 8] = cuCsub(v[iSIMD*12 + 8], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[2], 0))); \
\
	    v[iSIMD*12 + 9]  = cuCadd(v[iSIMD*12 + 9], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 10] = cuCadd(v[iSIMD*12 + 10], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 11] = cuCadd(v[iSIMD*12 + 11], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[3], 0))); \
	}\
}\



// #define QCD_UZM_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = w[iSIMD*12 + 0] - _Complex_I * w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 1] = w[iSIMD*12 + 1] - _Complex_I * w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 2] = w[iSIMD*12 + 2] - _Complex_I * w[iSIMD*12 + 8];\
// \
// 		t[iSIMD*6 + 3] = w[iSIMD*12 + 3] + _Complex_I * w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 4] = w[iSIMD*12 + 4] + _Complex_I * w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 5] = w[iSIMD*12 + 5] + _Complex_I * w[iSIMD*12 + 11];\
// 	}\
// }\

#define QCD_UZM_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCsub(w[iSIMD*12 + 0], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 6])); \
	    t[iSIMD*6 + 1] = cuCsub(w[iSIMD*12 + 1], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 7])); \
	    t[iSIMD*6 + 2] = cuCsub(w[iSIMD*12 + 2], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 8])); \
\
	    t[iSIMD*6 + 3] = cuCadd(w[iSIMD*12 + 3], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 9])); \
	    t[iSIMD*6 + 4] = cuCadd(w[iSIMD*12 + 4], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 10])); \
	    t[iSIMD*6 + 5] = cuCadd(w[iSIMD*12 + 5], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 11])); \
	}\
}\

// #define QCD_UZP_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = w[iSIMD*12 + 0] + _Complex_I * w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 1] = w[iSIMD*12 + 1] + _Complex_I * w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 2] = w[iSIMD*12 + 2] + _Complex_I * w[iSIMD*12 + 8];\
// \
// 		t[iSIMD*6 + 3] = w[iSIMD*12 + 3] - _Complex_I * w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 4] = w[iSIMD*12 + 4] - _Complex_I * w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 5] = w[iSIMD*12 + 5] - _Complex_I * w[iSIMD*12 + 11];\
// 	}\
// }\

#define QCD_UZP_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCadd(w[iSIMD*12 + 0], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 6])); \
	    t[iSIMD*6 + 1] = cuCadd(w[iSIMD*12 + 1], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 7])); \
	    t[iSIMD*6 + 2] = cuCadd(w[iSIMD*12 + 2], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 8])); \
\
	    t[iSIMD*6 + 3] = cuCsub(w[iSIMD*12 + 3], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 9])); \
	    t[iSIMD*6 + 4] = cuCsub(w[iSIMD*12 + 4], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 10])); \
	    t[iSIMD*6 + 5] = cuCsub(w[iSIMD*12 + 5], cuCmul(cuDoubleComplex_I, w[iSIMD*12 + 11])); \
	}\
}\

// #define QCD_UZM_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// \
// 		v[iSIMD*12 + 6] += _Complex_I * h[iSIMD*6 + 0] * k[2];\
// 		v[iSIMD*12 + 7] += _Complex_I * h[iSIMD*6 + 1] * k[2];\
// 		v[iSIMD*12 + 8] += _Complex_I * h[iSIMD*6 + 2] * k[2];\
// \
// 		v[iSIMD*12 + 9]  -= _Complex_I * h[iSIMD*6 + 3] * k[3];\
// 		v[iSIMD*12 + 10] -= _Complex_I * h[iSIMD*6 + 4] * k[3];\
// 		v[iSIMD*12 + 11] -= _Complex_I * h[iSIMD*6 + 5] * k[3];\
// 	}\
// }\

#define QCD_UZM_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
\
	    v[iSIMD*12 + 6] = cuCadd(v[iSIMD*12 + 6], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 0]), make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 7] = cuCadd(v[iSIMD*12 + 7], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 1]), make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 8] = cuCadd(v[iSIMD*12 + 8], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 2]), make_cuDoubleComplex(k[2], 0))); \
\
	    v[iSIMD*12 + 9]  = cuCsub(v[iSIMD*12 + 9], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 3]), make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 10] = cuCsub(v[iSIMD*12 + 10], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 4]), make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 11] = cuCsub(v[iSIMD*12 + 11], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 5]), make_cuDoubleComplex(k[3], 0))); \
	}\
}\

// #define QCD_UZP_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// \
// 		v[iSIMD*12 + 6] -= _Complex_I * h[iSIMD*6 + 0] * k[2];\
// 		v[iSIMD*12 + 7] -= _Complex_I * h[iSIMD*6 + 1] * k[2];\
// 		v[iSIMD*12 + 8] -= _Complex_I * h[iSIMD*6 + 2] * k[2];\
// \
// 		v[iSIMD*12 + 9]  += _Complex_I * h[iSIMD*6 + 3] * k[3];\
// 		v[iSIMD*12 + 10] += _Complex_I * h[iSIMD*6 + 4] * k[3];\
// 		v[iSIMD*12 + 11] += _Complex_I * h[iSIMD*6 + 5] * k[3];\
// 	}\
// }\

#define QCD_UZP_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
\
	    v[iSIMD*12 + 6] = cuCsub(v[iSIMD*12 + 6], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 0]), make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 7] = cuCsub(v[iSIMD*12 + 7], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 1]), make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 8] = cuCsub(v[iSIMD*12 + 8], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 2]), make_cuDoubleComplex(k[2], 0))); \
\
	    v[iSIMD*12 + 9]  = cuCadd(v[iSIMD*12 + 9], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 3]), make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 10] = cuCadd(v[iSIMD*12 + 10], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 4]), make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 11] = cuCadd(v[iSIMD*12 + 11], cuCmul(cuCmul(cuDoubleComplex_I, h[iSIMD*6 + 5]), make_cuDoubleComplex(k[3], 0))); \
	}\
}\


// #define QCD_UTM_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = w[iSIMD*12 + 0] - w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 1] = w[iSIMD*12 + 1] - w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 2] = w[iSIMD*12 + 2] - w[iSIMD*12 + 8];\
// \
// 		t[iSIMD*6 + 3] = w[iSIMD*12 + 3] - w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 4] = w[iSIMD*12 + 4] - w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 5] = w[iSIMD*12 + 5] - w[iSIMD*12 + 11];\
// 	}\
// }\

#define QCD_UTM_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCsub(w[iSIMD*12 + 0], w[iSIMD*12 + 6]);	\
	    t[iSIMD*6 + 1] = cuCsub(w[iSIMD*12 + 1], w[iSIMD*12 + 7]);	\
	    t[iSIMD*6 + 2] = cuCsub(w[iSIMD*12 + 2], w[iSIMD*12 + 8]);	\
\
	    t[iSIMD*6 + 3] = cuCsub(w[iSIMD*12 + 3], w[iSIMD*12 + 9]);	\
	    t[iSIMD*6 + 4] = cuCsub(w[iSIMD*12 + 4], w[iSIMD*12 + 10]);	\
	    t[iSIMD*6 + 5] = cuCsub(w[iSIMD*12 + 5], w[iSIMD*12 + 11]);	\
	}\
}\

// #define QCD_UTM_DIRAC_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = 2.0*w[iSIMD*12 + 0];\
// 		t[iSIMD*6 + 1] = 2.0*w[iSIMD*12 + 1];\
// 		t[iSIMD*6 + 2] = 2.0*w[iSIMD*12 + 2];\
// \
// 		t[iSIMD*6 + 3] = 2.0*w[iSIMD*12 + 3];\
// 		t[iSIMD*6 + 4] = 2.0*w[iSIMD*12 + 4];\
// 		t[iSIMD*6 + 5] = 2.0*w[iSIMD*12 + 5];\
// 	}\
// }\

#define QCD_UTM_DIRAC_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 0]); \
	    t[iSIMD*6 + 1] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 1]); \
	    t[iSIMD*6 + 2] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 2]); \
\
	    t[iSIMD*6 + 3] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 3]); \
	    t[iSIMD*6 + 4] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 4]); \
	    t[iSIMD*6 + 5] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 5]); \
	}\
}\


// #define QCD_UTP_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = w[iSIMD*12 + 0] + w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 1] = w[iSIMD*12 + 1] + w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 2] = w[iSIMD*12 + 2] + w[iSIMD*12 + 8];\
// \
// 		t[iSIMD*6 + 3] = w[iSIMD*12 + 3] + w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 4] = w[iSIMD*12 + 4] + w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 5] = w[iSIMD*12 + 5] + w[iSIMD*12 + 11];\
// 	}\
// }\

#define QCD_UTP_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCadd(w[iSIMD*12 + 0], w[iSIMD*12 + 6]);	\
	    t[iSIMD*6 + 1] = cuCadd(w[iSIMD*12 + 1], w[iSIMD*12 + 7]);	\
	    t[iSIMD*6 + 2] = cuCadd(w[iSIMD*12 + 2], w[iSIMD*12 + 8]);	\
\
	    t[iSIMD*6 + 3] = cuCadd(w[iSIMD*12 + 3], w[iSIMD*12 + 9]);	\
	    t[iSIMD*6 + 4] = cuCadd(w[iSIMD*12 + 4], w[iSIMD*12 + 10]);	\
	    t[iSIMD*6 + 5] = cuCadd(w[iSIMD*12 + 5], w[iSIMD*12 + 11]);	\
	}\
}\


// #define QCD_UTP_DIRAC_HALF(t,w)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		t[iSIMD*6 + 0] = 2.0*w[iSIMD*12 + 6];\
// 		t[iSIMD*6 + 1] = 2.0*w[iSIMD*12 + 7];\
// 		t[iSIMD*6 + 2] = 2.0*w[iSIMD*12 + 8];\
// \
// 		t[iSIMD*6 + 3] = 2.0*w[iSIMD*12 + 9];\
// 		t[iSIMD*6 + 4] = 2.0*w[iSIMD*12 + 10];\
// 		t[iSIMD*6 + 5] = 2.0*w[iSIMD*12 + 11];\
// 	}\
// }\

#define QCD_UTP_DIRAC_HALF(t,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    t[iSIMD*6 + 0] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 6]); \
	    t[iSIMD*6 + 1] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 7]); \
	    t[iSIMD*6 + 2] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 8]); \
\
	    t[iSIMD*6 + 3] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 9]); \
	    t[iSIMD*6 + 4] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 10]); \
	    t[iSIMD*6 + 5] = cuCmul(make_cuDoubleComplex(2.0, 0), w[iSIMD*12 + 11]); \
	}\
}\


// #define QCD_UTM_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// \
// 		v[iSIMD*12 + 6] -= h[iSIMD*6 + 0] * k[2];\
// 		v[iSIMD*12 + 7] -= h[iSIMD*6 + 1] * k[2];\
// 		v[iSIMD*12 + 8] -= h[iSIMD*6 + 2] * k[2];\
// \
// 		v[iSIMD*12 + 9]  -= h[iSIMD*6 + 3] * k[3];\
// 		v[iSIMD*12 + 10] -= h[iSIMD*6 + 4] * k[3];\
// 		v[iSIMD*12 + 11] -= h[iSIMD*6 + 5] * k[3];\
// 	}\
// }\

#define QCD_UTM_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
\
	    v[iSIMD*12 + 6] = cuCsub(v[iSIMD*12 + 6], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 7] = cuCsub(v[iSIMD*12 + 7], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 8] = cuCsub(v[iSIMD*12 + 8], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[2], 0))); \
\
	    v[iSIMD*12 + 9]  = cuCsub(v[iSIMD*12 + 9], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 10] = cuCsub(v[iSIMD*12 + 10], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 11] = cuCsub(v[iSIMD*12 + 11], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[3], 0))); \
	}\
}\


// #define QCD_UTM_DIRAC_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// 	}\
// }\

#define QCD_UTM_DIRAC_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
	}\
}\


#define QCD_UTM_SET5(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 6] += h[iSIMD*6 + 0] * k[0];\
		v[iSIMD*12 + 7] += h[iSIMD*6 + 1] * k[0];\
		v[iSIMD*12 + 8] += h[iSIMD*6 + 2] * k[0];\
\
		v[iSIMD*12 + 9] += h[iSIMD*6 + 3] * k[1];\
		v[iSIMD*12 +10] += h[iSIMD*6 + 4] * k[1];\
		v[iSIMD*12 +11] += h[iSIMD*6 + 5] * k[1];\
\
		v[iSIMD*12 + 0] -= h[iSIMD*6 + 0] * k[2];\
		v[iSIMD*12 + 1] -= h[iSIMD*6 + 1] * k[2];\
		v[iSIMD*12 + 2] -= h[iSIMD*6 + 2] * k[2];\
\
		v[iSIMD*12 + 3] -= h[iSIMD*6 + 3] * k[3];\
		v[iSIMD*12 + 4] -= h[iSIMD*6 + 4] * k[3];\
		v[iSIMD*12 + 5] -= h[iSIMD*6 + 5] * k[3];\
	}\
}\


#define QCD_UTM_DIRAC_SET5(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 6] += h[iSIMD*6 + 0] * k[0];\
		v[iSIMD*12 + 7] += h[iSIMD*6 + 1] * k[0];\
		v[iSIMD*12 + 8] += h[iSIMD*6 + 2] * k[0];\
\
		v[iSIMD*12 + 9] += h[iSIMD*6 + 3] * k[1];\
		v[iSIMD*12 +10] += h[iSIMD*6 + 4] * k[1];\
		v[iSIMD*12 +11] += h[iSIMD*6 + 5] * k[1];\
	}\
}\




#define QCD_UTM_INIT(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 0] = h[iSIMD*6 + 0] * k[0];\
		v[iSIMD*12 + 1] = h[iSIMD*6 + 1] * k[0];\
		v[iSIMD*12 + 2] = h[iSIMD*6 + 2] * k[0];\
\
		v[iSIMD*12 + 3] = h[iSIMD*6 + 3] * k[1];\
		v[iSIMD*12 + 4] = h[iSIMD*6 + 4] * k[1];\
		v[iSIMD*12 + 5] = h[iSIMD*6 + 5] * k[1];\
\
		v[iSIMD*12 + 6] = -h[iSIMD*6 + 0] * k[2];\
		v[iSIMD*12 + 7] = -h[iSIMD*6 + 1] * k[2];\
		v[iSIMD*12 + 8] = -h[iSIMD*6 + 2] * k[2];\
\
		v[iSIMD*12 + 9]  = -h[iSIMD*6 + 3] * k[3];\
		v[iSIMD*12 + 10] = -h[iSIMD*6 + 4] * k[3];\
		v[iSIMD*12 + 11] = -h[iSIMD*6 + 5] * k[3];\
	}\
}\


#define QCD_UTM_DIRAC_INIT(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 0] = h[iSIMD*6 + 0] * k[0];\
		v[iSIMD*12 + 1] = h[iSIMD*6 + 1] * k[0];\
		v[iSIMD*12 + 2] = h[iSIMD*6 + 2] * k[0];\
\
		v[iSIMD*12 + 3] = h[iSIMD*6 + 3] * k[1];\
		v[iSIMD*12 + 4] = h[iSIMD*6 + 4] * k[1];\
		v[iSIMD*12 + 5] = h[iSIMD*6 + 5] * k[1];\
	}\
}\



#define QCD_UTM_INIT5(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 6] = h[iSIMD*6 + 0] * k[0];\
		v[iSIMD*12 + 7] = h[iSIMD*6 + 1] * k[0];\
		v[iSIMD*12 + 8] = h[iSIMD*6 + 2] * k[0];\
\
		v[iSIMD*12 + 9] = h[iSIMD*6 + 3] * k[1];\
		v[iSIMD*12 +10] = h[iSIMD*6 + 4] * k[1];\
		v[iSIMD*12 +11] = h[iSIMD*6 + 5] * k[1];\
\
		v[iSIMD*12 + 0] = -h[iSIMD*6 + 0] * k[2];\
		v[iSIMD*12 + 1] = -h[iSIMD*6 + 1] * k[2];\
		v[iSIMD*12 + 2] = -h[iSIMD*6 + 2] * k[2];\
\
		v[iSIMD*12 + 3] = -h[iSIMD*6 + 3] * k[3];\
		v[iSIMD*12 + 4] = -h[iSIMD*6 + 4] * k[3];\
		v[iSIMD*12 + 5] = -h[iSIMD*6 + 5] * k[3];\
	}\
}\


#define QCD_UTM_DIRAC_INIT5(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 6] = h[iSIMD*6 + 0] * k[0];\
		v[iSIMD*12 + 7] = h[iSIMD*6 + 1] * k[0];\
		v[iSIMD*12 + 8] = h[iSIMD*6 + 2] * k[0];\
\
		v[iSIMD*12 + 9] = h[iSIMD*6 + 3] * k[1];\
		v[iSIMD*12 +10] = h[iSIMD*6 + 4] * k[1];\
		v[iSIMD*12 +11] = h[iSIMD*6 + 5] * k[1];\
	}\
}\



// #define QCD_UTP_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[0];\
// 		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[0];\
// 		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[0];\
// \
// 		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[1];\
// 		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[1];\
// 		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[1];\
// \
// 		v[iSIMD*12 + 6] += h[iSIMD*6 + 0] * k[2];\
// 		v[iSIMD*12 + 7] += h[iSIMD*6 + 1] * k[2];\
// 		v[iSIMD*12 + 8] += h[iSIMD*6 + 2] * k[2];\
// \
// 		v[iSIMD*12 + 9]  += h[iSIMD*6 + 3] * k[3];\
// 		v[iSIMD*12 + 10] += h[iSIMD*6 + 4] * k[3];\
// 		v[iSIMD*12 + 11] += h[iSIMD*6 + 5] * k[3];\
// 	}\
// }\

#define QCD_UTP_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 0] = cuCadd(v[iSIMD*12 + 0], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 1] = cuCadd(v[iSIMD*12 + 1], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[0], 0))); \
	    v[iSIMD*12 + 2] = cuCadd(v[iSIMD*12 + 2], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[0], 0))); \
\
	    v[iSIMD*12 + 3] = cuCadd(v[iSIMD*12 + 3], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 4] = cuCadd(v[iSIMD*12 + 4], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[1], 0))); \
	    v[iSIMD*12 + 5] = cuCadd(v[iSIMD*12 + 5], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[1], 0))); \
\
	    v[iSIMD*12 + 6] = cuCadd(v[iSIMD*12 + 6], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 7] = cuCadd(v[iSIMD*12 + 7], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 8] = cuCadd(v[iSIMD*12 + 8], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[2], 0))); \
\
	    v[iSIMD*12 + 9]  = cuCadd(v[iSIMD*12 + 9], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 10] = cuCadd(v[iSIMD*12 + 10], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 11] = cuCadd(v[iSIMD*12 + 11], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[3], 0))); \
	}\
}\

// #define QCD_UTP_DIRAC_SET(v,h,k)		\
// {\
// 	int iSIMD;\
// 	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
// 		v[iSIMD*12 + 6] += h[iSIMD*6 + 0] * k[2];\
// 		v[iSIMD*12 + 7] += h[iSIMD*6 + 1] * k[2];\
// 		v[iSIMD*12 + 8] += h[iSIMD*6 + 2] * k[2];\
// \
// 		v[iSIMD*12 + 9]  += h[iSIMD*6 + 3] * k[3];\
// 		v[iSIMD*12 + 10] += h[iSIMD*6 + 4] * k[3];\
// 		v[iSIMD*12 + 11] += h[iSIMD*6 + 5] * k[3];\
// 	}\
// }\

#define QCD_UTP_DIRAC_SET(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
	    v[iSIMD*12 + 6] = cuCadd(v[iSIMD*12 + 6], cuCmul(h[iSIMD*6 + 0], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 7] = cuCadd(v[iSIMD*12 + 7], cuCmul(h[iSIMD*6 + 1], make_cuDoubleComplex(k[2], 0))); \
	    v[iSIMD*12 + 8] = cuCadd(v[iSIMD*12 + 8], cuCmul(h[iSIMD*6 + 2], make_cuDoubleComplex(k[2], 0))); \
\
	    v[iSIMD*12 + 9]  = cuCadd(v[iSIMD*12 + 9], cuCmul(h[iSIMD*6 + 3], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 10] = cuCadd(v[iSIMD*12 + 10], cuCmul(h[iSIMD*6 + 4], make_cuDoubleComplex(k[3], 0))); \
	    v[iSIMD*12 + 11] = cuCadd(v[iSIMD*12 + 11], cuCmul(h[iSIMD*6 + 5], make_cuDoubleComplex(k[3], 0))); \
	}\
}\


#define QCD_UTP_SET5(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 6] += h[iSIMD*6 + 0] * k[0];\
		v[iSIMD*12 + 7] += h[iSIMD*6 + 1] * k[0];\
		v[iSIMD*12 + 8] += h[iSIMD*6 + 2] * k[0];\
\
		v[iSIMD*12 + 9] += h[iSIMD*6 + 3] * k[1];\
		v[iSIMD*12 +10] += h[iSIMD*6 + 4] * k[1];\
		v[iSIMD*12 +11] += h[iSIMD*6 + 5] * k[1];\
\
		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[2];\
		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[2];\
		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[2];\
\
		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[3];\
		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[3];\
		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[3];\
	}\
}\

#define QCD_UTP_DIRAC_SET5(v,h,k)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 0] += h[iSIMD*6 + 0] * k[2];\
		v[iSIMD*12 + 1] += h[iSIMD*6 + 1] * k[2];\
		v[iSIMD*12 + 2] += h[iSIMD*6 + 2] * k[2];\
\
		v[iSIMD*12 + 3] += h[iSIMD*6 + 3] * k[3];\
		v[iSIMD*12 + 4] += h[iSIMD*6 + 4] * k[3];\
		v[iSIMD*12 + 5] += h[iSIMD*6 + 5] * k[3];\
	}\
}\



#define QCD_GAMMA5(v,w)		\
{\
	int iSIMD;\
	for(iSIMD=0;iSIMD<QCD_NUM_SIMD;iSIMD++){\
		v[iSIMD*12 + 0] = w[iSIMD*12 + 6];\
		v[iSIMD*12 + 1] = w[iSIMD*12 + 7];\
		v[iSIMD*12 + 2] = w[iSIMD*12 + 8];\
\
		v[iSIMD*12 + 3] = h[iSIMD*6 + 9];\
		v[iSIMD*12 + 4] = h[iSIMD*6 + 10];\
		v[iSIMD*12 + 5] = h[iSIMD*6 + 11];\
\
		v[iSIMD*12 + 6] = w[iSIMD*12 + 0];\
		v[iSIMD*12 + 7] = w[iSIMD*12 + 1];\
		v[iSIMD*12 + 8] = w[iSIMD*12 + 2];\
\
		v[iSIMD*12 + 9] = h[iSIMD*6 + 3];\
		v[iSIMD*12 +10] = h[iSIMD*6 + 4];\
		v[iSIMD*12 +11] = h[iSIMD*6 + 5];\
	}\
}\




#endif	// __QCD_MULT_H__


