#ifndef __MC_INIT_H
#define __MC_INIT_H

#include <x10rt.h>


#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
class MC;
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace x10 { namespace lang { 
class System;
} } 
namespace x10 { namespace lang { 
class Place;
} } 
class Grid;
namespace x10 { namespace lang { 
class LongRange;
} } 
namespace x10 { namespace regionarray { 
class Region;
} } 
namespace x10 { namespace regionarray { 
template<class TPMGL(T)> class Array;
} } 
namespace x10 { namespace lang { 
class Runtime;
} } 
class MC_Init : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    MC* FMGL(mc);
    
    x10_double FMGL(bufsize);
    
    virtual void init(MC* mcobj, x10::lang::Rail<x10_double >* size);
    x10::lang::Rail<x10_int >* FMGL(factorized);
    
    x10_int FMGL(counter);
    
    void fact(x10_int value, x10_int div);
    x10::lang::Rail<x10_int >* getDim();
    void setup_grid();
    virtual MC_Init* MC_Init____this__MC_Init();
    void _constructor();
    
    static MC_Init* _make();
    
    virtual void __fieldInitializers_MC_Init();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // MC_INIT_H

class MC_Init;

#ifndef MC_INIT_H_NODEPS
#define MC_INIT_H_NODEPS
#ifndef MC_INIT_H_GENERICS
#define MC_INIT_H_GENERICS
#endif // MC_INIT_H_GENERICS
#endif // __MC_INIT_H_NODEPS
