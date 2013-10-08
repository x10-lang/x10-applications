/*************************************************/
/* START of Particle */
#include <Particle.h>

#include <x10/lang/Double.h>
#include <x10/lang/Int.h>
#include <x10/lang/Boolean.h>

//#line 3 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10FieldDecl_c

//#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10FieldDecl_c

//#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10FieldDecl_c

//#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10FieldDecl_c

//#line 8 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10FieldDecl_c

//#line 9 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10FieldDecl_c

//#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10FieldDecl_c

//#line 12 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10ConstructorDecl_c
void Particle::_constructor(x10_double x, x10_double y, x10_double z, x10_double energy,
                            x10_double angle, x10_int absorbed, x10_int proc) {
    
    //#line 12 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": polyglot.ast.Empty_c
    ;
    
    //#line 12 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.AssignPropertyCall_c
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10Call_c
    this->Particle::__fieldInitializers_Particle();
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(x) = x;
    
    //#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(y) = y;
    
    //#line 16 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(z) = z;
    
    //#line 17 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(energy) = energy;
    
    //#line 18 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(angle) = angle;
    
    //#line 19 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(absorbed) = absorbed;
    
    //#line 20 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(proc) = proc;
}
Particle* Particle::_make(x10_double x, x10_double y, x10_double z,
                          x10_double energy, x10_double angle, x10_int absorbed,
                          x10_int proc) {
    Particle* this_ = new (memset(x10aux::alloc<Particle>(), 0, sizeof(Particle))) Particle();
    this_->_constructor(x, y, z, energy, angle, absorbed, proc);
    return this_;
}



//#line 23 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10MethodDecl_c
x10_int Particle::compare(Particle* p1, Particle* p2) {
    
    //#line 24 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10aux::nullCheck(p1)->FMGL(absorbed),
                               ((x10_int)1))) && (x10aux::struct_equals(x10aux::nullCheck(p2)->
                                                                          FMGL(absorbed),
                                                                        ((x10_int)0))))
    {
        
        //#line 25 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10Return_c
        return ((x10_int)1);
        
    } else 
    //#line 26 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10aux::nullCheck(p1)->FMGL(absorbed),
                               ((x10_int)0))) && (x10aux::struct_equals(x10aux::nullCheck(p2)->
                                                                          FMGL(absorbed),
                                                                        ((x10_int)1))))
    {
        
        //#line 27 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10Return_c
        return ((x10_int)-1);
        
    }
    
    //#line 29 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10If_c
    if (((x10aux::nullCheck(p1)->FMGL(proc)) > (x10aux::nullCheck(p2)->
                                                  FMGL(proc))))
    {
        
        //#line 30 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10Return_c
        return ((x10_int)1);
        
    } else 
    //#line 31 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10If_c
    if (((x10aux::nullCheck(p1)->FMGL(proc)) < (x10aux::nullCheck(p2)->
                                                  FMGL(proc))))
    {
        
        //#line 32 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10Return_c
        return ((x10_int)-1);
        
    } else {
        
        //#line 34 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10Return_c
        return ((x10_int)0);
        
    }
    
}

//#line 41 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10MethodDecl_c
void Particle::print(Particle* p, x10_int np, x10_int nprocs) {
 
}

//#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10MethodDecl_c
Particle* Particle::Particle____this__Particle() {
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": x10.ast.X10MethodDecl_c
void Particle::__fieldInitializers_Particle() {
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(x) = 0.0;
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(y) = 0.0;
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(z) = 0.0;
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(energy) = 0.0;
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(angle) = 0.0;
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(absorbed) = ((x10_int)0);
    
    //#line 2 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Particle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(proc) = ((x10_int)0);
}
const x10aux::serialization_id_t Particle::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(Particle::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void Particle::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(x));
    buf.write(this->FMGL(y));
    buf.write(this->FMGL(z));
    buf.write(this->FMGL(energy));
    buf.write(this->FMGL(angle));
    buf.write(this->FMGL(absorbed));
    buf.write(this->FMGL(proc));
    
}

x10::lang::Reference* Particle::_deserializer(x10aux::deserialization_buffer& buf) {
    Particle* this_ = new (memset(x10aux::alloc<Particle>(), 0, sizeof(Particle))) Particle();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void Particle::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(x) = buf.read<x10_double>();
    FMGL(y) = buf.read<x10_double>();
    FMGL(z) = buf.read<x10_double>();
    FMGL(energy) = buf.read<x10_double>();
    FMGL(angle) = buf.read<x10_double>();
    FMGL(absorbed) = buf.read<x10_int>();
    FMGL(proc) = buf.read<x10_int>();
}

x10aux::RuntimeType Particle::rtt;
void Particle::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("Particle",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of Particle */
/*************************************************/
