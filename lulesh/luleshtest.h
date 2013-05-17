#ifndef __LULESHTEST_H
#define __LULESHTEST_H

#include <x10rt.h>


class Domain;
namespace x10 { namespace lang { 
class Boolean;
} } 
namespace x10 { namespace lang { 
class Int;
} } 
namespace x10 { namespace lang { 
class Float;
} } 
namespace x10 { namespace lang { 
class Math;
} } 
namespace x10 { namespace compiler { 
class Inline;
} } 
namespace x10 { namespace lang { 
class Double;
} } 
namespace x10 { namespace array { 
template<class TPMGL(T)> class Array;
} } 
namespace x10 { namespace lang { 
class Long;
} } 
namespace x10 { namespace util { 
class Timer;
} } 
namespace x10 { namespace lang { 
class IntRange;
} } 
namespace x10 { namespace array { 
class Region;
} } 
namespace x10 { namespace array { 
class Array__LayoutHelper;
} } 
namespace x10 { namespace util { 
template<class TPMGL(T)> class IndexedMemoryChunk;
} } 
namespace x10 { namespace io { 
class Printer;
} } 
namespace x10 { namespace io { 
class Console;
} } 
namespace x10 { namespace lang { 
class String;
} } 
namespace x10 { namespace lang { 
class Any;
} } 
namespace x10 { namespace compiler { 
class CompilerFlags;
} } 
namespace x10 { namespace lang { 
class FailedDynamicCheckException;
} } 
namespace x10 { namespace util { 
template<class TPMGL(T), class TPMGL(U)> class Pair;
} } 
namespace x10 { namespace array { 
class RectRegion1D;
} } 
namespace x10 { namespace lang { 
class Place;
} } 
namespace x10 { namespace lang { 
class Runtime;
} } 
namespace x10 { namespace lang { 
class System;
} } 
class luleshtest__VolumeException;
class luleshtest__QStopException;
namespace x10 { namespace array { 
class Point;
} } 
namespace x10 { namespace io { 
class File;
} } 
class luleshtest : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    static Domain* FMGL(domain);
    static void FMGL(domain__do_init)();
    static void FMGL(domain__init)();
    static volatile x10aux::StaticInitController::status FMGL(domain__status);
    static x10::lang::CheckedThrowable* FMGL(domain__exception);
    static Domain* FMGL(domain__get)();
    
    static x10_boolean FMGL(LULESH_SHOW_PROGRESS);
    static void FMGL(LULESH_SHOW_PROGRESS__do_init)();
    static void FMGL(LULESH_SHOW_PROGRESS__init)();
    static volatile x10aux::StaticInitController::status FMGL(LULESH_SHOW_PROGRESS__status);
    static x10::lang::CheckedThrowable* FMGL(LULESH_SHOW_PROGRESS__exception);
    static x10_boolean FMGL(LULESH_SHOW_PROGRESS__get)();
    
    static x10_int FMGL(VolumeError);
    static void FMGL(VolumeError__do_init)();
    static void FMGL(VolumeError__init)();
    static volatile x10aux::StaticInitController::status FMGL(VolumeError__status);
    static x10::lang::CheckedThrowable* FMGL(VolumeError__exception);
    static x10_int FMGL(VolumeError__get)();
    
    static x10_int FMGL(QStopError);
    static void FMGL(QStopError__do_init)();
    static void FMGL(QStopError__init)();
    static volatile x10aux::StaticInitController::status FMGL(QStopError__status);
    static x10::lang::CheckedThrowable* FMGL(QStopError__exception);
    static x10_int FMGL(QStopError__get)();
    
    static x10_int FMGL(XI_M);
    static void FMGL(XI_M__do_init)();
    static void FMGL(XI_M__init)();
    static volatile x10aux::StaticInitController::status FMGL(XI_M__status);
    static x10::lang::CheckedThrowable* FMGL(XI_M__exception);
    static x10_int FMGL(XI_M__get)();
    
    static x10_int FMGL(XI_M_SYMM);
    static void FMGL(XI_M_SYMM__do_init)();
    static void FMGL(XI_M_SYMM__init)();
    static volatile x10aux::StaticInitController::status FMGL(XI_M_SYMM__status);
    static x10::lang::CheckedThrowable* FMGL(XI_M_SYMM__exception);
    static x10_int FMGL(XI_M_SYMM__get)();
    
    static x10_int FMGL(XI_M_FREE);
    static void FMGL(XI_M_FREE__do_init)();
    static void FMGL(XI_M_FREE__init)();
    static volatile x10aux::StaticInitController::status FMGL(XI_M_FREE__status);
    static x10::lang::CheckedThrowable* FMGL(XI_M_FREE__exception);
    static x10_int FMGL(XI_M_FREE__get)();
    
    static x10_int FMGL(XI_P);
    static void FMGL(XI_P__do_init)();
    static void FMGL(XI_P__init)();
    static volatile x10aux::StaticInitController::status FMGL(XI_P__status);
    static x10::lang::CheckedThrowable* FMGL(XI_P__exception);
    static x10_int FMGL(XI_P__get)();
    
    static x10_int FMGL(XI_P_SYMM);
    static void FMGL(XI_P_SYMM__do_init)();
    static void FMGL(XI_P_SYMM__init)();
    static volatile x10aux::StaticInitController::status FMGL(XI_P_SYMM__status);
    static x10::lang::CheckedThrowable* FMGL(XI_P_SYMM__exception);
    static x10_int FMGL(XI_P_SYMM__get)();
    
    static x10_int FMGL(XI_P_FREE);
    static void FMGL(XI_P_FREE__do_init)();
    static void FMGL(XI_P_FREE__init)();
    static volatile x10aux::StaticInitController::status FMGL(XI_P_FREE__status);
    static x10::lang::CheckedThrowable* FMGL(XI_P_FREE__exception);
    static x10_int FMGL(XI_P_FREE__get)();
    
    static x10_int FMGL(ETA_M);
    static void FMGL(ETA_M__do_init)();
    static void FMGL(ETA_M__init)();
    static volatile x10aux::StaticInitController::status FMGL(ETA_M__status);
    static x10::lang::CheckedThrowable* FMGL(ETA_M__exception);
    static x10_int FMGL(ETA_M__get)();
    
    static x10_int FMGL(ETA_M_SYMM);
    static void FMGL(ETA_M_SYMM__do_init)();
    static void FMGL(ETA_M_SYMM__init)();
    static volatile x10aux::StaticInitController::status FMGL(ETA_M_SYMM__status);
    static x10::lang::CheckedThrowable* FMGL(ETA_M_SYMM__exception);
    static x10_int FMGL(ETA_M_SYMM__get)();
    
    static x10_int FMGL(ETA_M_FREE);
    static void FMGL(ETA_M_FREE__do_init)();
    static void FMGL(ETA_M_FREE__init)();
    static volatile x10aux::StaticInitController::status FMGL(ETA_M_FREE__status);
    static x10::lang::CheckedThrowable* FMGL(ETA_M_FREE__exception);
    static x10_int FMGL(ETA_M_FREE__get)();
    
    static x10_int FMGL(ETA_P);
    static void FMGL(ETA_P__do_init)();
    static void FMGL(ETA_P__init)();
    static volatile x10aux::StaticInitController::status FMGL(ETA_P__status);
    static x10::lang::CheckedThrowable* FMGL(ETA_P__exception);
    static x10_int FMGL(ETA_P__get)();
    
    static x10_int FMGL(ETA_P_SYMM);
    static void FMGL(ETA_P_SYMM__do_init)();
    static void FMGL(ETA_P_SYMM__init)();
    static volatile x10aux::StaticInitController::status FMGL(ETA_P_SYMM__status);
    static x10::lang::CheckedThrowable* FMGL(ETA_P_SYMM__exception);
    static x10_int FMGL(ETA_P_SYMM__get)();
    
    static x10_int FMGL(ETA_P_FREE);
    static void FMGL(ETA_P_FREE__do_init)();
    static void FMGL(ETA_P_FREE__init)();
    static volatile x10aux::StaticInitController::status FMGL(ETA_P_FREE__status);
    static x10::lang::CheckedThrowable* FMGL(ETA_P_FREE__exception);
    static x10_int FMGL(ETA_P_FREE__get)();
    
    static x10_int FMGL(ZETA_M);
    static void FMGL(ZETA_M__do_init)();
    static void FMGL(ZETA_M__init)();
    static volatile x10aux::StaticInitController::status FMGL(ZETA_M__status);
    static x10::lang::CheckedThrowable* FMGL(ZETA_M__exception);
    static x10_int FMGL(ZETA_M__get)();
    
    static x10_int FMGL(ZETA_M_SYMM);
    static void FMGL(ZETA_M_SYMM__do_init)();
    static void FMGL(ZETA_M_SYMM__init)();
    static volatile x10aux::StaticInitController::status FMGL(ZETA_M_SYMM__status);
    static x10::lang::CheckedThrowable* FMGL(ZETA_M_SYMM__exception);
    static x10_int FMGL(ZETA_M_SYMM__get)();
    
    static x10_int FMGL(ZETA_M_FREE);
    static void FMGL(ZETA_M_FREE__do_init)();
    static void FMGL(ZETA_M_FREE__init)();
    static volatile x10aux::StaticInitController::status FMGL(ZETA_M_FREE__status);
    static x10::lang::CheckedThrowable* FMGL(ZETA_M_FREE__exception);
    static x10_int FMGL(ZETA_M_FREE__get)();
    
    static x10_int FMGL(ZETA_P);
    static void FMGL(ZETA_P__do_init)();
    static void FMGL(ZETA_P__init)();
    static volatile x10aux::StaticInitController::status FMGL(ZETA_P__status);
    static x10::lang::CheckedThrowable* FMGL(ZETA_P__exception);
    static x10_int FMGL(ZETA_P__get)();
    
    static x10_int FMGL(ZETA_P_SYMM);
    static void FMGL(ZETA_P_SYMM__do_init)();
    static void FMGL(ZETA_P_SYMM__init)();
    static volatile x10aux::StaticInitController::status FMGL(ZETA_P_SYMM__status);
    static x10::lang::CheckedThrowable* FMGL(ZETA_P_SYMM__exception);
    static x10_int FMGL(ZETA_P_SYMM__get)();
    
    static x10_int FMGL(ZETA_P_FREE);
    static void FMGL(ZETA_P_FREE__do_init)();
    static void FMGL(ZETA_P_FREE__init)();
    static volatile x10aux::StaticInitController::status FMGL(ZETA_P_FREE__status);
    static x10::lang::CheckedThrowable* FMGL(ZETA_P_FREE__exception);
    static x10_int FMGL(ZETA_P_FREE__get)();
    
    static x10_float SQRT(x10_float arg);
    static x10_double SQRT(x10_double arg);
    static void TimeIncrement();
    static x10::array::Array<x10_double>* InitStressTermsForElems(x10_int numElem);
    static x10::util::Pair<x10::array::Array<x10_double>*, x10_double> CalcElemShapeFunctionDerivatives(
      x10::array::Array<x10_double>* x, x10::array::Array<x10_double>* y,
      x10::array::Array<x10_double>* z);
    static x10::array::Array<x10_double>* SumElemFaceNormal(x10_double normalX0,
                                                            x10_double normalY0,
                                                            x10_double normalZ0,
                                                            x10_double normalX1,
                                                            x10_double normalY1,
                                                            x10_double normalZ1,
                                                            x10_double normalX2,
                                                            x10_double normalY2,
                                                            x10_double normalZ2,
                                                            x10_double normalX3,
                                                            x10_double normalY3,
                                                            x10_double normalZ3,
                                                            x10_double x0,
                                                            x10_double y0,
                                                            x10_double z0,
                                                            x10_double x1,
                                                            x10_double y1,
                                                            x10_double z1,
                                                            x10_double x2,
                                                            x10_double y2,
                                                            x10_double z2,
                                                            x10_double x3,
                                                            x10_double y3,
                                                            x10_double z3);
    static x10::array::Array<x10_double>* CalcElemNodeNormals(x10::array::Array<x10_double>* pfxyz,
                                                              x10::array::Array<x10_double>* x,
                                                              x10::array::Array<x10_double>* y,
                                                              x10::array::Array<x10_double>* z);
    static x10::array::Array<x10_double>* SumElemStressesToNodeForces(
      x10::array::Array<x10_double>* B, x10_double stress_xx,
      x10_double stress_yy, x10_double stress_zz);
    static x10::array::Array<x10_double>* IntegrateStressForElems(
      x10_int numElem, x10::array::Array<x10_double>* sigxxyyzz);
    static x10::array::Array<x10_double>* CollectDomainNodesToElemNodes(
      x10_int i, x10::array::Array<x10_int>* elemToNode);
    static x10::array::Array<x10_double>* VoluDer(x10_double x0,
                                                  x10_double x1,
                                                  x10_double x2,
                                                  x10_double x3,
                                                  x10_double x4,
                                                  x10_double x5,
                                                  x10_double y0,
                                                  x10_double y1,
                                                  x10_double y2,
                                                  x10_double y3,
                                                  x10_double y4,
                                                  x10_double y5,
                                                  x10_double z0,
                                                  x10_double z1,
                                                  x10_double z2,
                                                  x10_double z3,
                                                  x10_double z4,
                                                  x10_double z5);
    static x10::array::Array<x10_double>* CalcElemVolumeDerivative(
      x10::array::Array<x10_double>* xyz);
    static x10::array::Array<x10_double>* CalcElemFBHourglassForce(
      x10::array::Array<x10_double>* xd, x10::array::Array<x10_double>* yd,
      x10::array::Array<x10_double>* zd, x10::array::Array<x10_double>* hourgam0,
      x10::array::Array<x10_double>* hourgam1, x10::array::Array<x10_double>* hourgam2,
      x10::array::Array<x10_double>* hourgam3, x10::array::Array<x10_double>* hourgam4,
      x10::array::Array<x10_double>* hourgam5, x10::array::Array<x10_double>* hourgam6,
      x10::array::Array<x10_double>* hourgam7, x10_double coefficient);
    static void CalcFBHourglassForceForElems(x10::array::Array<x10_double>* determ,
                                             x10::array::Array<x10_double>* x8n,
                                             x10::array::Array<x10_double>* y8n,
                                             x10::array::Array<x10_double>* z8n,
                                             x10::array::Array<x10_double>* dvdx,
                                             x10::array::Array<x10_double>* dvdy,
                                             x10::array::Array<x10_double>* dvdz,
                                             x10_double hourg);
    static void CalcHourglassControlForElems(x10::array::Array<x10_double>* determ,
                                             x10_double hgcoef);
    static void CalcVolumeForceForElems();
    static void CalcForceForNodes();
    static void CalcAccelerationForNodes();
    static void ApplyAccelerationBoundaryConditionsForNodes(
      );
    static void CalcVelocityForNodes(x10_double dt, x10_double u_cut);
    static void CalcPositionForNodes(x10_double dt);
    static void LagrangeNodal();
    static x10_double TripleProduct(x10_double x1, x10_double y1,
                                    x10_double z1, x10_double x2,
                                    x10_double y2, x10_double z2,
                                    x10_double x3, x10_double y3,
                                    x10_double z3);
    static x10_double CalcElemVolume(x10_double x0, x10_double x1,
                                     x10_double x2, x10_double x3,
                                     x10_double x4, x10_double x5,
                                     x10_double x6, x10_double x7,
                                     x10_double y0, x10_double y1,
                                     x10_double y2, x10_double y3,
                                     x10_double y4, x10_double y5,
                                     x10_double y6, x10_double y7,
                                     x10_double z0, x10_double z1,
                                     x10_double z2, x10_double z3,
                                     x10_double z4, x10_double z5,
                                     x10_double z6, x10_double z7);
    static x10_double CalcElemVolume(x10::array::Array<x10_double>* x,
                                     x10::array::Array<x10_double>* y,
                                     x10::array::Array<x10_double>* z);
    static x10_double AreaFace(x10_double x0, x10_double x1,
                               x10_double x2, x10_double x3,
                               x10_double y0, x10_double y1,
                               x10_double y2, x10_double y3,
                               x10_double z0, x10_double z1,
                               x10_double z2, x10_double z3);
    static x10_double CalcElemCharacteristicLength(x10::array::Array<x10_double>* x,
                                                   x10::array::Array<x10_double>* y,
                                                   x10::array::Array<x10_double>* z,
                                                   x10_double volume);
    static x10::array::Array<x10_double>* CalcElemVelocityGrandient(
      x10::array::Array<x10_double>* xvel, x10::array::Array<x10_double>* yvel,
      x10::array::Array<x10_double>* zvel, x10::array::Array<x10_double>* b,
      x10_double detJ);
    static void CalcKinematicsForElems(x10_int numElem, x10_double dt);
    static void CalcLagrangeElements(x10_double deltatime);
    static x10_double SUM4(x10_double a, x10_double b, x10_double c,
                           x10_double d);
    static void CalcMonotonicQGradientsForElems();
    static void CalcMonotonicQRegionForElems(x10_double qlc_monoq,
                                             x10_double qqc_monoq,
                                             x10_double monoq_limiter_mult,
                                             x10_double monoq_max_slope,
                                             x10_double ptiny,
                                             x10_int elength);
    static void CalcMonotonicQForElems();
    static void CalcQForElems();
    static x10::array::Array<x10_double>* CalcPressureForElems(
      x10::array::Array<x10_double>* e_old, x10::array::Array<x10_double>* compression,
      x10::array::Array<x10_double>* vnewc, x10_double pmin,
      x10_double p_cut, x10_double eosvmax, x10_int length);
    static void CalcEnergyForElems(x10::array::Array<x10_double>* p_new,
                                   x10::array::Array<x10_double>* bvc,
                                   x10::array::Array<x10_double>* pbvc,
                                   x10::array::Array<x10_double>* p_old,
                                   x10::array::Array<x10_double>* e_old,
                                   x10::array::Array<x10_double>* q_old,
                                   x10::array::Array<x10_double>* compression,
                                   x10::array::Array<x10_double>* compHalfStep,
                                   x10::array::Array<x10_double>* vnewc,
                                   x10::array::Array<x10_double>* work,
                                   x10::array::Array<x10_double>* delvc,
                                   x10_double pmin, x10_double p_cut,
                                   x10_double e_cut, x10_double q_cut,
                                   x10_double emin, x10::array::Array<x10_double>* qq,
                                   x10::array::Array<x10_double>* ql,
                                   x10_double rho0, x10_double eosvmax,
                                   x10_int length);
    static void CalcSoundSpeedForElems(x10::array::Array<x10_double>* vnewc,
                                       x10_double rho0, x10::array::Array<x10_double>* enewc,
                                       x10::array::Array<x10_double>* pnewc,
                                       x10::array::Array<x10_double>* pbvc,
                                       x10::array::Array<x10_double>* bvc,
                                       x10_double ss4o3, x10_int nz);
    static void EvalEOSForElems(x10::array::Array<x10_double>* vnewc,
                                x10_int length);
    static void ApplyMaterialPropertiesForElems();
    static void UpdateVolumesForElems();
    static void LagrangeElements();
    static void CalcCourantConstraintForElems();
    static void CalcHydroConstraintForElems();
    static void CalcTimeConstraintsForElems();
    static void LagrangeLeapFrog();
    static void main(x10::array::Array<x10::lang::String*>* args);
    virtual luleshtest* luleshtest____this__luleshtest();
    void _constructor();
    
    static luleshtest* _make();
    
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // LULESHTEST_H

class luleshtest;

#ifndef LULESHTEST_H_NODEPS
#define LULESHTEST_H_NODEPS
#include <Domain.h>
#include <x10/lang/Boolean.h>
#include <x10/lang/Int.h>
#include <x10/lang/Float.h>
#include <x10/lang/Math.h>
#include <x10/compiler/Inline.h>
#include <x10/lang/Double.h>
#include <x10/array/Array.h>
#include <x10/lang/Long.h>
#include <x10/util/Timer.h>
#include <x10/lang/IntRange.h>
#include <x10/array/Region.h>
#include <x10/array/Array__LayoutHelper.h>
#include <x10/util/IndexedMemoryChunk.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/String.h>
#include <x10/lang/Any.h>
#include <x10/compiler/CompilerFlags.h>
#include <x10/lang/FailedDynamicCheckException.h>
#include <x10/util/Pair.h>
#include <x10/array/RectRegion1D.h>
#include <x10/lang/Place.h>
#include <x10/lang/Runtime.h>
#include <x10/lang/System.h>
#include <luleshtest__VolumeException.h>
#include <luleshtest__QStopException.h>
#include <x10/array/Point.h>
#include <x10/io/File.h>
#ifndef LULESHTEST_H_GENERICS
#define LULESHTEST_H_GENERICS
inline Domain* luleshtest::FMGL(domain__get)() {
    if (FMGL(domain__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(domain__init)();
    }
    return luleshtest::FMGL(domain);
}

inline x10_boolean luleshtest::FMGL(LULESH_SHOW_PROGRESS__get)() {
    if (FMGL(LULESH_SHOW_PROGRESS__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(LULESH_SHOW_PROGRESS__init)();
    }
    return luleshtest::FMGL(LULESH_SHOW_PROGRESS);
}

inline x10_int luleshtest::FMGL(VolumeError__get)() {
    if (FMGL(VolumeError__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(VolumeError__init)();
    }
    return luleshtest::FMGL(VolumeError);
}

inline x10_int luleshtest::FMGL(QStopError__get)() {
    if (FMGL(QStopError__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(QStopError__init)();
    }
    return luleshtest::FMGL(QStopError);
}

inline x10_int luleshtest::FMGL(XI_M__get)() {
    if (FMGL(XI_M__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(XI_M__init)();
    }
    return luleshtest::FMGL(XI_M);
}

inline x10_int luleshtest::FMGL(XI_M_SYMM__get)() {
    if (FMGL(XI_M_SYMM__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(XI_M_SYMM__init)();
    }
    return luleshtest::FMGL(XI_M_SYMM);
}

inline x10_int luleshtest::FMGL(XI_M_FREE__get)() {
    if (FMGL(XI_M_FREE__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(XI_M_FREE__init)();
    }
    return luleshtest::FMGL(XI_M_FREE);
}

inline x10_int luleshtest::FMGL(XI_P__get)() {
    if (FMGL(XI_P__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(XI_P__init)();
    }
    return luleshtest::FMGL(XI_P);
}

inline x10_int luleshtest::FMGL(XI_P_SYMM__get)() {
    if (FMGL(XI_P_SYMM__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(XI_P_SYMM__init)();
    }
    return luleshtest::FMGL(XI_P_SYMM);
}

inline x10_int luleshtest::FMGL(XI_P_FREE__get)() {
    if (FMGL(XI_P_FREE__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(XI_P_FREE__init)();
    }
    return luleshtest::FMGL(XI_P_FREE);
}

inline x10_int luleshtest::FMGL(ETA_M__get)() {
    if (FMGL(ETA_M__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ETA_M__init)();
    }
    return luleshtest::FMGL(ETA_M);
}

inline x10_int luleshtest::FMGL(ETA_M_SYMM__get)() {
    if (FMGL(ETA_M_SYMM__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ETA_M_SYMM__init)();
    }
    return luleshtest::FMGL(ETA_M_SYMM);
}

inline x10_int luleshtest::FMGL(ETA_M_FREE__get)() {
    if (FMGL(ETA_M_FREE__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ETA_M_FREE__init)();
    }
    return luleshtest::FMGL(ETA_M_FREE);
}

inline x10_int luleshtest::FMGL(ETA_P__get)() {
    if (FMGL(ETA_P__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ETA_P__init)();
    }
    return luleshtest::FMGL(ETA_P);
}

inline x10_int luleshtest::FMGL(ETA_P_SYMM__get)() {
    if (FMGL(ETA_P_SYMM__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ETA_P_SYMM__init)();
    }
    return luleshtest::FMGL(ETA_P_SYMM);
}

inline x10_int luleshtest::FMGL(ETA_P_FREE__get)() {
    if (FMGL(ETA_P_FREE__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ETA_P_FREE__init)();
    }
    return luleshtest::FMGL(ETA_P_FREE);
}

inline x10_int luleshtest::FMGL(ZETA_M__get)() {
    if (FMGL(ZETA_M__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ZETA_M__init)();
    }
    return luleshtest::FMGL(ZETA_M);
}

inline x10_int luleshtest::FMGL(ZETA_M_SYMM__get)() {
    if (FMGL(ZETA_M_SYMM__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ZETA_M_SYMM__init)();
    }
    return luleshtest::FMGL(ZETA_M_SYMM);
}

inline x10_int luleshtest::FMGL(ZETA_M_FREE__get)() {
    if (FMGL(ZETA_M_FREE__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ZETA_M_FREE__init)();
    }
    return luleshtest::FMGL(ZETA_M_FREE);
}

inline x10_int luleshtest::FMGL(ZETA_P__get)() {
    if (FMGL(ZETA_P__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ZETA_P__init)();
    }
    return luleshtest::FMGL(ZETA_P);
}

inline x10_int luleshtest::FMGL(ZETA_P_SYMM__get)() {
    if (FMGL(ZETA_P_SYMM__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ZETA_P_SYMM__init)();
    }
    return luleshtest::FMGL(ZETA_P_SYMM);
}

inline x10_int luleshtest::FMGL(ZETA_P_FREE__get)() {
    if (FMGL(ZETA_P_FREE__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(ZETA_P_FREE__init)();
    }
    return luleshtest::FMGL(ZETA_P_FREE);
}

#endif // LULESHTEST_H_GENERICS
#endif // __LULESHTEST_H_NODEPS
