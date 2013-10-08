#ifndef __GRID_H
#define __GRID_H

#include <x10rt.h>


#define X10_LANG_DOUBLE_H_NODEPS
#include <x10/lang/Double.h>
#undef X10_LANG_DOUBLE_H_NODEPS
#define X10_LANG_INT_H_NODEPS
#include <x10/lang/Int.h>
#undef X10_LANG_INT_H_NODEPS
namespace x10 { namespace lang { 
template<class TPMGL(T)> class Rail;
} } 
class Grid : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    x10::lang::Rail<x10_double >* FMGL(size);
    
    x10::lang::Rail<x10_double >* FMGL(coords);
    
    x10::lang::Rail<x10_int >* FMGL(nabes);
    
    x10::lang::Rail<x10_int >* FMGL(proc_coords);
    
    void _constructor();
    
    static Grid* _make();
    
    virtual Grid* Grid____this__Grid();
    virtual void __fieldInitializers_Grid();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // GRID_H

class Grid;

#ifndef GRID_H_NODEPS
#define GRID_H_NODEPS
#ifndef GRID_H_GENERICS
#define GRID_H_GENERICS
#endif // GRID_H_GENERICS
#endif // __GRID_H_NODEPS
