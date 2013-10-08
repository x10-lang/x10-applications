#ifndef __MAIN_H
#define __MAIN_H

#include <x10rt.h>


namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
namespace x10 { namespace lang { 
class String;
} } 
namespace x10 { namespace lang { 
class Place;
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
namespace x10 { namespace compiler { 
class CompilerFlags;
} } 
namespace x10 { namespace lang { 
class FailedDynamicCheckException;
} } 
namespace x10 { namespace lang { 
class System;
} } 
class MC_Cycle;
namespace x10 { namespace io { 
class File;
} } 
namespace x10 { namespace io { 
class IOException;
} } 
namespace x10 { namespace io { 
template<class TPMGL(T)> class ReaderIterator;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Iterator;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Iterable;
} } 
namespace x10 { namespace lang { 
class PlaceGroup;
} } 
namespace x10 { namespace lang { 
template<class TPMGL(T)> class PlaceLocalHandle;
} } 
class Particle;
namespace x10 { namespace lang { 
template<class TPMGL(U)> class Fun_0_0;
} } 
namespace x10 { namespace lang { 
class PlaceGroup__SimplePlaceGroup;
} } 
namespace x10 { namespace lang { 
class VoidFun_0_0;
} } 
class MC;
class MC_Init;
class Grid;
class Main : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    static void main(x10::lang::Rail<x10::lang::String* >* args);
    static void main2(x10::lang::Rail<x10::lang::String* >* args);
    static void init_particles(MC* mc, x10_int np, x10::lang::Rail<x10_double >* mycoords);
    virtual Main* Main____this__Main();
    void _constructor();
    
    static Main* _make();
    
    virtual void __fieldInitializers_Main();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // MAIN_H

class Main;

#ifndef MAIN_H_NODEPS
#define MAIN_H_NODEPS
#ifndef MAIN_H_GENERICS
#define MAIN_H_GENERICS
#endif // MAIN_H_GENERICS
#endif // __MAIN_H_NODEPS
