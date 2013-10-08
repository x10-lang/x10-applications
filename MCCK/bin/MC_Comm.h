#ifndef __MC_COMM_H
#define __MC_COMM_H

#include <x10rt.h>


#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
class MC;
namespace x10 { namespace lang { 
template<class TPMGL(Z1), class TPMGL(Z2), class TPMGL(Z3)> class VoidFun_0_3;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
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
class Runtime;
} } 
namespace x10 { namespace lang { 
class Place;
} } 
namespace x10 { namespace compiler { 
class CompilerFlags;
} } 
namespace x10 { namespace lang { 
class FailedDynamicCheckException;
} } 
namespace x10 { namespace lang { 
class System;
} } 
namespace x10 { namespace lang { 
class FinishState;
} } 
namespace x10 { namespace lang { 
class CheckedThrowable;
} } 
namespace x10 { namespace lang { 
class VoidFun_0_0;
} } 
class Grid;
namespace x10 { namespace lang { 
template<class TPMGL(T)> class GlobalRail;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class PlaceLocalHandle;
} } 
class Particle;
namespace x10 { namespace lang { 
class Error;
} } 
namespace x10 { namespace lang { 
class Exception;
} } 
namespace x10 { namespace compiler { 
class AsyncClosure;
} } 
namespace x10 { namespace lang { 
class Runtime__Profile;
} } 
namespace x10 { namespace compiler { 
class Finalization;
} } 
namespace x10 { namespace compiler { 
class Abort;
} } 
class MC_Cycle;
namespace x10 { namespace lang { 
template<class TPMGL(U)> class Fun_0_0;
} } 
class MC_Comm : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    virtual x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*
      init(MC* mc, x10_int comm_choice);
    x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*
      FMGL(nonblocking_exchange);
    
    x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*
      FMGL(blocking_exchange);
    
    virtual MC_Comm* MC_Comm____this__MC_Comm();
    void _constructor();
    
    static MC_Comm* _make();
    
    virtual void __fieldInitializers_MC_Comm();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // MC_COMM_H

class MC_Comm;

#ifndef MC_COMM_H_NODEPS
#define MC_COMM_H_NODEPS
#ifndef MC_COMM_H_GENERICS
#define MC_COMM_H_GENERICS
#endif // MC_COMM_H_GENERICS
#endif // __MC_COMM_H_NODEPS
