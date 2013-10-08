#ifndef __MC_CYCLE_H
#define __MC_CYCLE_H

#include <x10rt.h>


#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
class MC;
namespace x10 { namespace util { 
class Random;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace x10 { namespace compiler { 
class Native;
} } 
class Particle;
namespace x10 { namespace lang { 
template<class TPMGL(T)> class PlaceLocalHandle;
} } 
namespace x10 { namespace util { 
class Team;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(Z1), class TPMGL(Z2), class TPMGL(Z3)> class VoidFun_0_3;
} } 
class MC_Comm;
namespace x10 { namespace lang { 
class Place;
} } 
namespace x10 { namespace lang { 
class Runtime;
} } 
namespace x10 { namespace lang { 
class System;
} } 
namespace x10 { namespace io { 
class Printer;
} } 
namespace x10 { namespace io { 
class Console;
} } 
namespace x10 { namespace lang { 
class Any;
} } 
namespace x10 { namespace lang { 
class String;
} } 
namespace x10 { namespace lang { 
class Math;
} } 
class Grid;
namespace x10 { namespace lang { 
class PlaceGroup;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(U)> class Fun_0_0;
} } 
class MC_Cycle : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    static x10_int FMGL(BNDRY_REFLECT);
    static void FMGL(BNDRY_REFLECT__do_init)();
    static void FMGL(BNDRY_REFLECT__init)();
    static volatile x10aux::StaticInitController::status FMGL(BNDRY_REFLECT__status);
    static x10::lang::CheckedThrowable* FMGL(BNDRY_REFLECT__exception);
    static x10_int FMGL(BNDRY_REFLECT__get)();
    
    static x10_int FMGL(BNDRY_PERIODIC);
    static void FMGL(BNDRY_PERIODIC__do_init)();
    static void FMGL(BNDRY_PERIODIC__init)();
    static volatile x10aux::StaticInitController::status FMGL(BNDRY_PERIODIC__status);
    static x10::lang::CheckedThrowable* FMGL(BNDRY_PERIODIC__exception);
    static x10_int FMGL(BNDRY_PERIODIC__get)();
    
    static x10_int FMGL(BNDRY_LEAK);
    static void FMGL(BNDRY_LEAK__do_init)();
    static void FMGL(BNDRY_LEAK__init)();
    static volatile x10aux::StaticInitController::status FMGL(BNDRY_LEAK__status);
    static x10::lang::CheckedThrowable* FMGL(BNDRY_LEAK__exception);
    static x10_int FMGL(BNDRY_LEAK__get)();
    
    MC* FMGL(mc);
    
    static x10_int FMGL(RAND_MAX);
    static void FMGL(RAND_MAX__do_init)();
    static void FMGL(RAND_MAX__init)();
    static volatile x10aux::StaticInitController::status FMGL(RAND_MAX__status);
    static x10::lang::CheckedThrowable* FMGL(RAND_MAX__exception);
    static x10_int FMGL(RAND_MAX__get)();
    
    static x10::util::Random* FMGL(random);
    static void FMGL(random__do_init)();
    static void FMGL(random__init)();
    static volatile x10aux::StaticInitController::status FMGL(random__status);
    static x10::lang::CheckedThrowable* FMGL(random__exception);
    static x10::util::Random* FMGL(random__get)();
    
    x10_int FMGL(comm_choice);
    
    x10::lang::Rail<x10_int >* FMGL(mySendCount);
    
    x10::lang::Rail<x10_int >* FMGL(myRecvCount);
    
    void _constructor(MC* mcobj, x10_int comm_choice);
    
    static MC_Cycle* _make(MC* mcobj, x10_int comm_choice);
    
    virtual void cycle();
    x10_int pack();
    void update_particles_strict();
    void update_particles();
    void check_array_size(x10_int comm_choice, x10::lang::Rail<x10_int >* myRecvCount);
    static x10_int isum(x10::lang::Rail<x10_int >* f, x10_int n);
    x10_int elim_sent();
    static void qsort(x10_int mype, x10::lang::Rail<Particle* >* a, x10_long lo,
                      x10_long hi);
    static x10_int compare_sent(x10_int mype, Particle* p1, Particle* p2);
    static void qsort3(x10::lang::Rail<Particle* >* a, x10_long lo, x10_long hi);
    virtual MC_Cycle* MC_Cycle____this__MC_Cycle();
    virtual void __fieldInitializers_MC_Cycle();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // MC_CYCLE_H

class MC_Cycle;

#ifndef MC_CYCLE_H_NODEPS
#define MC_CYCLE_H_NODEPS
#include <x10/lang/Int.h>
#include <MC.h>
#include <x10/util/Random.h>
#include <x10/lang/Rail.h>
#include <x10/lang/Long.h>
#include <x10/lang/Float.h>
#include <x10/compiler/Native.h>
#include <Particle.h>
#include <x10/lang/PlaceLocalHandle.h>
#include <x10/util/Team.h>
#include <x10/lang/VoidFun_0_3.h>
#include <MC_Comm.h>
#include <x10/lang/Place.h>
#include <x10/lang/Runtime.h>
#include <x10/lang/System.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>
#include <x10/lang/Boolean.h>
#include <x10/lang/String.h>
#include <x10/lang/Double.h>
#include <x10/lang/Math.h>
#include <Grid.h>
#include <x10/lang/PlaceGroup.h>
#include <x10/lang/Fun_0_0.h>
#ifndef MC_CYCLE_H_GENERICS
#define MC_CYCLE_H_GENERICS
inline x10_int MC_Cycle::FMGL(BNDRY_REFLECT__get)() {
    if (FMGL(BNDRY_REFLECT__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(BNDRY_REFLECT__init)();
    }
    return MC_Cycle::FMGL(BNDRY_REFLECT);
}

inline x10_int MC_Cycle::FMGL(BNDRY_PERIODIC__get)() {
    if (FMGL(BNDRY_PERIODIC__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(BNDRY_PERIODIC__init)();
    }
    return MC_Cycle::FMGL(BNDRY_PERIODIC);
}

inline x10_int MC_Cycle::FMGL(BNDRY_LEAK__get)() {
    if (FMGL(BNDRY_LEAK__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(BNDRY_LEAK__init)();
    }
    return MC_Cycle::FMGL(BNDRY_LEAK);
}

inline x10_int MC_Cycle::FMGL(RAND_MAX__get)() {
    if (FMGL(RAND_MAX__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(RAND_MAX__init)();
    }
    return MC_Cycle::FMGL(RAND_MAX);
}

inline x10::util::Random* MC_Cycle::FMGL(random__get)() {
    if (FMGL(random__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(random__init)();
    }
    return MC_Cycle::FMGL(random);
}

#endif // MC_CYCLE_H_GENERICS
#endif // __MC_CYCLE_H_NODEPS
