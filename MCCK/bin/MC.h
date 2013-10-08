#ifndef __MC_H
#define __MC_H

#include <x10rt.h>


#define X10_LANG_PLACELOCALHANDLE_H_NODEPS
#include <x10/lang/PlaceLocalHandle.h>
#undef X10_LANG_PLACELOCALHANDLE_H_NODEPS
#define X10_LANG_PLACELOCALHANDLE_H_NODEPS
#include <x10/lang/PlaceLocalHandle.h>
#undef X10_LANG_PLACELOCALHANDLE_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
class Particle;
namespace x10 { namespace regionarray { 
template<class TPMGL(T)> class Array;
} } 
namespace x10 { namespace regionarray { 
class Region;
} } 
class Grid;
class MC_Cycle;
namespace x10 { namespace lang { 
class Zero;
} } 
class MC : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    static x10_int FMGL(MC_NONBLOCK);
    static void FMGL(MC_NONBLOCK__do_init)();
    static void FMGL(MC_NONBLOCK__init)();
    static volatile x10aux::StaticInitController::status FMGL(MC_NONBLOCK__status);
    static x10::lang::CheckedThrowable* FMGL(MC_NONBLOCK__exception);
    static x10_int FMGL(MC_NONBLOCK__get)();
    
    static x10_int FMGL(MC_MADRE);
    static void FMGL(MC_MADRE__do_init)();
    static void FMGL(MC_MADRE__init)();
    static volatile x10aux::StaticInitController::status FMGL(MC_MADRE__status);
    static x10::lang::CheckedThrowable* FMGL(MC_MADRE__exception);
    static x10_int FMGL(MC_MADRE__get)();
    
    static x10_int FMGL(MC_BLOCK);
    static void FMGL(MC_BLOCK__do_init)();
    static void FMGL(MC_BLOCK__init)();
    static volatile x10aux::StaticInitController::status FMGL(MC_BLOCK__status);
    static x10::lang::CheckedThrowable* FMGL(MC_BLOCK__exception);
    static x10_int FMGL(MC_BLOCK__get)();
    
    x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> FMGL(particles);
    
    x10_int FMGL(nparticles);
    
    x10::lang::Rail<x10_int >* FMGL(np_array);
    
    x10::lang::Rail<x10_double >* FMGL(leakage_array);
    
    x10_int FMGL(nprocs);
    
    x10_int FMGL(mype);
    
    x10_int FMGL(boundary_flag);
    
    x10_int FMGL(strict);
    
    x10_double FMGL(leakage);
    
    x10_double FMGL(seed);
    
    x10_int FMGL(sizep);
    
    x10::regionarray::Array<x10_int>* FMGL(matrix);
    
    Grid* FMGL(grid);
    
    void _constructor(x10_int s, x10_int bf, x10_double se, x10_int nps, x10_double lkg,
                      x10_double bufsize, x10_int npros, x10_int mp);
    
    static MC* _make(x10_int s, x10_int bf, x10_double se, x10_int nps,
                     x10_double lkg, x10_double bufsize, x10_int npros,
                     x10_int mp);
    
    void _constructor(x10_int s, x10_int bf, x10_double se, x10::lang::Rail<x10_int >* nps_array,
                      x10::lang::Rail<x10_double >* lkg_array,
                      x10_double bufsize, x10_int npros, x10_int mp);
    
    static MC* _make(x10_int s, x10_int bf, x10_double se,
                     x10::lang::Rail<x10_int >* nps_array,
                     x10::lang::Rail<x10_double >* lkg_array,
                     x10_double bufsize, x10_int npros, x10_int mp);
    
    virtual MC* MC____this__MC();
    virtual void __fieldInitializers_MC();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // MC_H

class MC;

#ifndef MC_H_NODEPS
#define MC_H_NODEPS
#ifndef MC_H_GENERICS
#define MC_H_GENERICS
inline x10_int MC::FMGL(MC_NONBLOCK__get)() {
    if (FMGL(MC_NONBLOCK__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(MC_NONBLOCK__init)();
    }
    return MC::FMGL(MC_NONBLOCK);
}

inline x10_int MC::FMGL(MC_MADRE__get)() {
    if (FMGL(MC_MADRE__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(MC_MADRE__init)();
    }
    return MC::FMGL(MC_MADRE);
}

inline x10_int MC::FMGL(MC_BLOCK__get)() {
    if (FMGL(MC_BLOCK__status) != x10aux::StaticInitController::INITIALIZED) {
        FMGL(MC_BLOCK__init)();
    }
    return MC::FMGL(MC_BLOCK);
}

#endif // MC_H_GENERICS
#endif // __MC_H_NODEPS
