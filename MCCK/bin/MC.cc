/*************************************************/
/* START of MC */
#include <MC.h>

#include <x10/lang/PlaceLocalHandle.h>
#include <x10/lang/Int.h>
#include <x10/lang/Double.h>
#include <x10/lang/Rail.h>
#include <Particle.h>
#include <x10/regionarray/Array.h>
#include <x10/regionarray/Region.h>
#include <Grid.h>
#include <MC_Cycle.h>
#include <x10/lang/Zero.h>

//#line 13 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c
x10_int MC::FMGL(MC_NONBLOCK);
void MC::FMGL(MC_NONBLOCK__do_init)() {
    FMGL(MC_NONBLOCK__status) = x10aux::StaticInitController::INITIALIZING;
    _SI_("Doing static initialization for field: MC.MC_NONBLOCK");
    x10_int __var62__ = x10aux::class_cast_unchecked<x10_int>(((x10_int)-1));
    FMGL(MC_NONBLOCK) = __var62__;
    FMGL(MC_NONBLOCK__status) = x10aux::StaticInitController::INITIALIZED;
}
void MC::FMGL(MC_NONBLOCK__init)() {
    x10aux::StaticInitController::initField(&FMGL(MC_NONBLOCK__status), &FMGL(MC_NONBLOCK__do_init), &FMGL(MC_NONBLOCK__exception), "MC.MC_NONBLOCK");
    
}
volatile x10aux::StaticInitController::status MC::FMGL(MC_NONBLOCK__status);
x10::lang::CheckedThrowable* MC::FMGL(MC_NONBLOCK__exception);

//#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c
x10_int MC::FMGL(MC_MADRE);
void MC::FMGL(MC_MADRE__do_init)() {
    FMGL(MC_MADRE__status) = x10aux::StaticInitController::INITIALIZING;
    _SI_("Doing static initialization for field: MC.MC_MADRE");
    x10_int __var63__ = x10aux::class_cast_unchecked<x10_int>(((x10_int)-2));
    FMGL(MC_MADRE) = __var63__;
    FMGL(MC_MADRE__status) = x10aux::StaticInitController::INITIALIZED;
}
void MC::FMGL(MC_MADRE__init)() {
    x10aux::StaticInitController::initField(&FMGL(MC_MADRE__status), &FMGL(MC_MADRE__do_init), &FMGL(MC_MADRE__exception), "MC.MC_MADRE");
    
}
volatile x10aux::StaticInitController::status MC::FMGL(MC_MADRE__status);
x10::lang::CheckedThrowable* MC::FMGL(MC_MADRE__exception);

//#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c
x10_int MC::FMGL(MC_BLOCK);
void MC::FMGL(MC_BLOCK__do_init)() {
    FMGL(MC_BLOCK__status) = x10aux::StaticInitController::INITIALIZING;
    _SI_("Doing static initialization for field: MC.MC_BLOCK");
    x10_int __var64__ = x10aux::class_cast_unchecked<x10_int>(((x10_int)-3));
    FMGL(MC_BLOCK) = __var64__;
    FMGL(MC_BLOCK__status) = x10aux::StaticInitController::INITIALIZED;
}
void MC::FMGL(MC_BLOCK__init)() {
    x10aux::StaticInitController::initField(&FMGL(MC_BLOCK__status), &FMGL(MC_BLOCK__do_init), &FMGL(MC_BLOCK__exception), "MC.MC_BLOCK");
    
}
volatile x10aux::StaticInitController::status MC::FMGL(MC_BLOCK__status);
x10::lang::CheckedThrowable* MC::FMGL(MC_BLOCK__exception);

//#line 19 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 21 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 23 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 25 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 27 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 29 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 31 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 33 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 35 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 37 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c
 /* public static type Matrix = x10.regionarray.Array[x10.lang.Int]{self.rank==3L}; */ 
 /* public static type Matrix(r: x10.regionarray.Region) = x10.regionarray.Array[x10.lang.Int]{self.rank==3L}; */ 

//#line 49 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10FieldDecl_c

//#line 54 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10ConstructorDecl_c
void MC::_constructor(x10_int s, x10_int bf, x10_double se, x10_int nps, x10_double lkg,
                      x10_double bufsize, x10_int npros, x10_int mp) {
    
    //#line 54 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": polyglot.ast.Empty_c
    ;
    
    //#line 54 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.AssignPropertyCall_c
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10Call_c
    this->MC::__fieldInitializers_MC();
    
    //#line 55 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(s, ((x10_int)-1)))) {
        
        //#line 56 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
        this->FMGL(strict) = ((x10_int)0);
    }
    
    //#line 57 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(bf, ((x10_int)0)))) {
        
        //#line 58 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
        this->FMGL(boundary_flag) = MC_Cycle::FMGL(BNDRY_REFLECT__get)();
    }
    
    //#line 60 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(seed) = se;
    
    //#line 61 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nparticles) = nps;
    
    //#line 62 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(leakage) = lkg;
    
    //#line 63 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(sizep) = x10::lang::DoubleNatives::toInt(((((1.0) + (bufsize))) * (((x10_double) (this->
                                                                                                   FMGL(nparticles))))));
    
    //#line 64 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nprocs) = npros;
    
    //#line 65 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(mype) = mp;
}
MC* MC::_make(x10_int s, x10_int bf, x10_double se, x10_int nps,
              x10_double lkg, x10_double bufsize, x10_int npros,
              x10_int mp) {
    MC* this_ = new (memset(x10aux::alloc<MC>(), 0, sizeof(MC))) MC();
    this_->_constructor(s, bf, se, nps, lkg, bufsize, npros,
    mp);
    return this_;
}



//#line 68 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10ConstructorDecl_c
void MC::_constructor(x10_int s, x10_int bf, x10_double se,
                      x10::lang::Rail<x10_int >* nps_array,
                      x10::lang::Rail<x10_double >* lkg_array,
                      x10_double bufsize, x10_int npros, x10_int mp) {
    
    //#line 68 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": polyglot.ast.Empty_c
    ;
    
    //#line 68 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.AssignPropertyCall_c
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10Call_c
    this->MC::__fieldInitializers_MC();
}
MC* MC::_make(x10_int s, x10_int bf, x10_double se, x10::lang::Rail<x10_int >* nps_array,
              x10::lang::Rail<x10_double >* lkg_array, x10_double bufsize,
              x10_int npros, x10_int mp) {
    MC* this_ = new (memset(x10aux::alloc<MC>(), 0, sizeof(MC))) MC();
    this_->_constructor(s, bf, se, nps_array, lkg_array, bufsize,
    npros, mp);
    return this_;
}



//#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10MethodDecl_c
MC* MC::MC____this__MC() {
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": x10.ast.X10MethodDecl_c
void MC::__fieldInitializers_MC() {
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(particles) = x10aux::zeroValue<x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> >();
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nparticles) = ((x10_int)0);
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(np_array) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_int >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(leakage_array) = (x10aux::class_cast_unchecked<x10::lang::Rail<x10_double >*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nprocs) = ((x10_int)0);
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(mype) = ((x10_int)0);
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(boundary_flag) = ((x10_int)0);
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(strict) = ((x10_int)0);
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(leakage) = 0.0;
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(seed) = 0.0;
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(sizep) = ((x10_int)0);
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(matrix) = (x10aux::class_cast_unchecked<x10::regionarray::Array<x10_int>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(grid) = (x10aux::class_cast_unchecked<Grid*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
}
const x10aux::serialization_id_t MC::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void MC::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(particles));
    buf.write(this->FMGL(nparticles));
    buf.write(this->FMGL(np_array));
    buf.write(this->FMGL(leakage_array));
    buf.write(this->FMGL(nprocs));
    buf.write(this->FMGL(mype));
    buf.write(this->FMGL(boundary_flag));
    buf.write(this->FMGL(strict));
    buf.write(this->FMGL(leakage));
    buf.write(this->FMGL(seed));
    buf.write(this->FMGL(sizep));
    buf.write(this->FMGL(matrix));
    buf.write(this->FMGL(grid));
    
}

x10::lang::Reference* MC::_deserializer(x10aux::deserialization_buffer& buf) {
    MC* this_ = new (memset(x10aux::alloc<MC>(), 0, sizeof(MC))) MC();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void MC::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(particles) = buf.read<x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> >();
    FMGL(nparticles) = buf.read<x10_int>();
    FMGL(np_array) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(leakage_array) = buf.read<x10::lang::Rail<x10_double >*>();
    FMGL(nprocs) = buf.read<x10_int>();
    FMGL(mype) = buf.read<x10_int>();
    FMGL(boundary_flag) = buf.read<x10_int>();
    FMGL(strict) = buf.read<x10_int>();
    FMGL(leakage) = buf.read<x10_double>();
    FMGL(seed) = buf.read<x10_double>();
    FMGL(sizep) = buf.read<x10_int>();
    FMGL(matrix) = buf.read<x10::regionarray::Array<x10_int>*>();
    FMGL(grid) = buf.read<Grid*>();
}

x10aux::RuntimeType MC::rtt;
void MC::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("MC",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of MC */
/*************************************************/
