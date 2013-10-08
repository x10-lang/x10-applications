#ifndef __PARTICLE_H
#define __PARTICLE_H

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
class Particle : public x10::lang::X10Class   {
    public:
    RTT_H_DECLS_CLASS
    
    x10_double FMGL(x);
    
    x10_double FMGL(y);
    
    x10_double FMGL(z);
    
    x10_double FMGL(energy);
    
    x10_double FMGL(angle);
    
    x10_int FMGL(absorbed);
    
    x10_int FMGL(proc);
    
    void _constructor(x10_double x, x10_double y, x10_double z, x10_double energy,
                      x10_double angle, x10_int absorbed, x10_int proc);
    
    static Particle* _make(x10_double x, x10_double y, x10_double z,
                           x10_double energy, x10_double angle, x10_int absorbed,
                           x10_int proc);
    
    static x10_int compare(Particle* p1, Particle* p2);
    virtual void print(Particle* p, x10_int np, x10_int nprocs);
    virtual Particle* Particle____this__Particle();
    virtual void __fieldInitializers_Particle();
    
    // Serialization
    public: static const x10aux::serialization_id_t _serialization_id;
    
    public: virtual x10aux::serialization_id_t _get_serialization_id() {
         return _serialization_id;
    }
    
    public: virtual void _serialize_body(x10aux::serialization_buffer& buf);
    
    public: static x10::lang::Reference* _deserializer(x10aux::deserialization_buffer& buf);
    
    public: void _deserialize_body(x10aux::deserialization_buffer& buf);
    
};

#endif // PARTICLE_H

class Particle;

#ifndef PARTICLE_H_NODEPS
#define PARTICLE_H_NODEPS
#ifndef PARTICLE_H_GENERICS
#define PARTICLE_H_GENERICS
#endif // PARTICLE_H_GENERICS
#endif // __PARTICLE_H_NODEPS
