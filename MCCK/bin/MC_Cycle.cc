/*************************************************/
/* START of MC_Cycle */
#include <MC_Cycle.h>

#ifndef MC_CYCLE__CLOSURE__1_CLOSURE
#define MC_CYCLE__CLOSURE__1_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Cycle__closure__1 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*>::itable<MC_Cycle__closure__1> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    x10::lang::Rail<Particle* >* __apply() {
        
        //#line 310 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
        return x10::lang::Rail<Particle* >::_make(((x10_long) (((x10_int) ((total) + (((x10_int)1)))))));
        
    }
    
    // captured environment
    x10_int total;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->total);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Cycle__closure__1* storage = x10aux::alloc<MC_Cycle__closure__1>();
        buf.record_reference(storage);
        x10_int that_total = buf.read<x10_int>();
        MC_Cycle__closure__1* this_ = new (storage) MC_Cycle__closure__1(that_total);
        return this_;
    }
    
    MC_Cycle__closure__1(x10_int total) : total(total) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10:310";
    }

};

#endif // MC_CYCLE__CLOSURE__1_CLOSURE

//#line 9 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c
x10_int MC_Cycle::FMGL(BNDRY_REFLECT);
void MC_Cycle::FMGL(BNDRY_REFLECT__do_init)() {
    FMGL(BNDRY_REFLECT__status) = x10aux::StaticInitController::INITIALIZING;
    _SI_("Doing static initialization for field: MC_Cycle.BNDRY_REFLECT");
    x10_int __var37__ = x10aux::class_cast_unchecked<x10_int>(((x10_int)-1));
    FMGL(BNDRY_REFLECT) = __var37__;
    FMGL(BNDRY_REFLECT__status) = x10aux::StaticInitController::INITIALIZED;
}
void MC_Cycle::FMGL(BNDRY_REFLECT__init)() {
    x10aux::StaticInitController::initField(&FMGL(BNDRY_REFLECT__status), &FMGL(BNDRY_REFLECT__do_init), &FMGL(BNDRY_REFLECT__exception), "MC_Cycle.BNDRY_REFLECT");
    
}
volatile x10aux::StaticInitController::status MC_Cycle::FMGL(BNDRY_REFLECT__status);
x10::lang::CheckedThrowable* MC_Cycle::FMGL(BNDRY_REFLECT__exception);

//#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c
x10_int MC_Cycle::FMGL(BNDRY_PERIODIC);
void MC_Cycle::FMGL(BNDRY_PERIODIC__do_init)() {
    FMGL(BNDRY_PERIODIC__status) = x10aux::StaticInitController::INITIALIZING;
    _SI_("Doing static initialization for field: MC_Cycle.BNDRY_PERIODIC");
    x10_int __var38__ = x10aux::class_cast_unchecked<x10_int>(((x10_int)-2));
    FMGL(BNDRY_PERIODIC) = __var38__;
    FMGL(BNDRY_PERIODIC__status) = x10aux::StaticInitController::INITIALIZED;
}
void MC_Cycle::FMGL(BNDRY_PERIODIC__init)() {
    x10aux::StaticInitController::initField(&FMGL(BNDRY_PERIODIC__status), &FMGL(BNDRY_PERIODIC__do_init), &FMGL(BNDRY_PERIODIC__exception), "MC_Cycle.BNDRY_PERIODIC");
    
}
volatile x10aux::StaticInitController::status MC_Cycle::FMGL(BNDRY_PERIODIC__status);
x10::lang::CheckedThrowable* MC_Cycle::FMGL(BNDRY_PERIODIC__exception);

//#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c
x10_int MC_Cycle::FMGL(BNDRY_LEAK);
void MC_Cycle::FMGL(BNDRY_LEAK__do_init)() {
    FMGL(BNDRY_LEAK__status) = x10aux::StaticInitController::INITIALIZING;
    _SI_("Doing static initialization for field: MC_Cycle.BNDRY_LEAK");
    x10_int __var39__ = x10aux::class_cast_unchecked<x10_int>(((x10_int)-3));
    FMGL(BNDRY_LEAK) = __var39__;
    FMGL(BNDRY_LEAK__status) = x10aux::StaticInitController::INITIALIZED;
}
void MC_Cycle::FMGL(BNDRY_LEAK__init)() {
    x10aux::StaticInitController::initField(&FMGL(BNDRY_LEAK__status), &FMGL(BNDRY_LEAK__do_init), &FMGL(BNDRY_LEAK__exception), "MC_Cycle.BNDRY_LEAK");
    
}
volatile x10aux::StaticInitController::status MC_Cycle::FMGL(BNDRY_LEAK__status);
x10::lang::CheckedThrowable* MC_Cycle::FMGL(BNDRY_LEAK__exception);

//#line 13 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c

//#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c
x10_int MC_Cycle::FMGL(RAND_MAX);
void MC_Cycle::FMGL(RAND_MAX__do_init)() {
    FMGL(RAND_MAX__status) = x10aux::StaticInitController::INITIALIZING;
    _SI_("Doing static initialization for field: MC_Cycle.RAND_MAX");
    x10_int __var40__ = x10aux::class_cast_unchecked<x10_int>(((x10_int)2147483647));
    FMGL(RAND_MAX) = __var40__;
    FMGL(RAND_MAX__status) = x10aux::StaticInitController::INITIALIZED;
}
void MC_Cycle::FMGL(RAND_MAX__init)() {
    x10aux::StaticInitController::initField(&FMGL(RAND_MAX__status), &FMGL(RAND_MAX__do_init), &FMGL(RAND_MAX__exception), "MC_Cycle.RAND_MAX");
    
}
volatile x10aux::StaticInitController::status MC_Cycle::FMGL(RAND_MAX__status);
x10::lang::CheckedThrowable* MC_Cycle::FMGL(RAND_MAX__exception);

//#line 18 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c
x10::util::Random* MC_Cycle::FMGL(random);
void MC_Cycle::FMGL(random__do_init)() {
    FMGL(random__status) = x10aux::StaticInitController::INITIALIZING;
    _SI_("Doing static initialization for field: MC_Cycle.random");
    x10::util::Random* __var41__ = reinterpret_cast<x10::util::Random*>(x10::util::Random::_make());
    FMGL(random) = __var41__;
    FMGL(random__status) = x10aux::StaticInitController::INITIALIZED;
}
void MC_Cycle::FMGL(random__init)() {
    x10aux::StaticInitController::initField(&FMGL(random__status), &FMGL(random__do_init), &FMGL(random__exception), "MC_Cycle.random");
    
}
volatile x10aux::StaticInitController::status MC_Cycle::FMGL(random__status);
x10::lang::CheckedThrowable* MC_Cycle::FMGL(random__exception);

//#line 20 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c

//#line 23 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c
/** how many particles sent to proc i at a stage */

//#line 26 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10FieldDecl_c
/** how many particles recv from proc i at a stage */

//#line 28 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10ConstructorDecl_c
void MC_Cycle::_constructor(MC* mcobj, x10_int comm_choice) {
    
    //#line 28 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Empty_c
    ;
    
    //#line 28 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.AssignPropertyCall_c
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    this->MC_Cycle::__fieldInitializers_MC_Cycle();
    
    //#line 29 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(mc) = mcobj;
    
    //#line 31 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    MC_Cycle::FMGL(random__get)()->x10::util::Random::setSeed(x10::lang::DoubleNatives::toLong(x10aux::nullCheck(this->
                                                                                                                   FMGL(mc))->
                                                                                                 FMGL(seed)));
    
    //#line 33 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(comm_choice) = comm_choice;
}
MC_Cycle* MC_Cycle::_make(MC* mcobj, x10_int comm_choice)
{
    MC_Cycle* this_ = new (memset(x10aux::alloc<MC_Cycle>(), 0, sizeof(MC_Cycle))) MC_Cycle();
    this_->_constructor(mcobj, comm_choice);
    return this_;
}



//#line 36 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c

//#line 40 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
void MC_Cycle::cycle() {
    
    //#line 41 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int i;
    
    //#line 42 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<Particle* >* p = x10aux::nullCheck(this->
                                                         FMGL(mc))->
                                       FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply();
    
    //#line 45 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int np_min = ((x10_int)-1);
    
    //#line 46 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int np_max = ((x10_int)-1);
    
    //#line 49 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int iter = ((x10_int)0);
    
    //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int npg = ((x10_int)0);
    
    //#line 53 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int npl = ((x10_int)0);
    
    //#line 55 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int npg_before = ((x10_int)0);
    
    //#line 57 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(this->FMGL(myRecvCount))->x10::lang::Rail<x10_int >::__set(
      ((x10_long) (x10aux::nullCheck(this->FMGL(mc))->FMGL(mype))),
      ((x10_int)0));
    
    //#line 59 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10::util::Team team = x10::util::Team::FMGL(WORLD__get)();
    
    //#line 61 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>* exchange =
      (MC_Comm::_make())->init(this->FMGL(mc), this->FMGL(comm_choice));
    
    //#line 64 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_long start = ((x10_long)0ll);
    
    //#line 65 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    team->barrier();
    
    //#line 66 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here)->
                                 FMGL(id), ((x10_long)0ll))))
    {
        
        //#line 67 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        start = x10::lang::System::nanoTime();
    }
    
    //#line 69 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10While_c
    while (true) {
        
        //#line 70 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        iter = ((x10_int) ((iter) + (((x10_int)1))));
        
        //#line 71 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        npl = x10aux::nullCheck(this->FMGL(mc))->FMGL(nparticles);
        
        //#line 72 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        npg = ((x10_int)0);
        
        //#line 73 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        np_min = ((x10_int) ((npl) + (((x10_int)1))));
        
        //#line 74 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        np_max = ((x10_int)-1);
        
        //#line 76 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        npg = team->allreduce(npl, x10::util::Team::FMGL(ADD__get)());
        
        //#line 77 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        np_min = team->allreduce(npl, x10::util::Team::FMGL(MIN__get)());
        
        //#line 78 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        np_max = team->allreduce(npl, x10::util::Team::FMGL(MAX__get)());
        
        //#line 84 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
        x10_float np_mean;
        
        //#line 85 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
        x10_float delta;
        
        //#line 87 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        npg_before = npg;
        
        //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        np_mean = ((x10_float) (((x10_int) ((npg) / x10aux::zeroCheck(x10aux::nullCheck(this->
                                                                                          FMGL(mc))->
                                                                        FMGL(nprocs))))));
        
        //#line 89 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        delta = ((((x10_float) (np_max))) - (np_mean));
        
        //#line 91 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here)->
                                     FMGL(id), ((x10_long)0ll))))
        {
            
            //#line 92 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
            x10::io::Console::FMGL(OUT__get)()->printf(x10aux::makeStringLit("stage %3d, %8lld total np ([min:%6d max:%6d mean:%6.2f  delta:%2.2f])\n"),
                                                       x10aux::class_cast_unchecked<x10::lang::Any*>(iter),
                                                       x10aux::class_cast_unchecked<x10::lang::Any*>(npg),
                                                       x10aux::class_cast_unchecked<x10::lang::Any*>(np_min),
                                                       x10aux::class_cast_unchecked<x10::lang::Any*>(np_max),
                                                       x10aux::class_cast_unchecked<x10::lang::Any*>(np_mean),
                                                       x10aux::class_cast_unchecked<x10::lang::Any*>(delta));
        }
        
        //#line 95 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(x10aux::nullCheck(this->
                                                       FMGL(mc))->
                                     FMGL(strict), ((x10_int)1))))
        {
            
            //#line 96 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
            this->update_particles_strict();
        } else {
            
            //#line 98 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
            this->update_particles();
        }
        
        //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        npl = x10aux::nullCheck(this->FMGL(mc))->FMGL(nparticles) =
          this->pack();
        
        //#line 109 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        np_max = team->allreduce(npl, x10::util::Team::FMGL(MAX__get)());
        
        //#line 111 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
        if (((np_max) <= (((x10_int)1)))) {
            
            //#line 112 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Branch_c
            break;
        }
        
        //#line 116 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
        {
            for (
                 //#line 116 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_int)0); ((i) < (npl)); 
                                                  //#line 116 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                                                  i = ((x10_int) ((i) + (((x10_int)1)))))
            {
                
                //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
                if ((x10aux::struct_equals(x10aux::nullCheck(p)->x10::lang::Rail<Particle* >::__apply(
                                             ((x10_long) (i))),
                                           reinterpret_cast<x10::lang::NullType*>(X10_NULL))))
                {
                    
                    //#line 119 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Branch_c
                    continue;
                }
                
                //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                x10::lang::Rail<x10_int >* x56357 = this->
                                                      FMGL(mySendCount);
                
                //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                x10_long y56358 = ((x10_long) (x10aux::nullCheck(x10aux::nullCheck(p)->x10::lang::Rail<Particle* >::__apply(
                                                                   ((x10_long) (i))))->
                                                 FMGL(proc)));
                
                //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Empty_c
                ;
                
                //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                x10_int ret56359;
                
                //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                x10_int r56356 = ((x10_int) ((x10aux::nullCheck(x56357)->x10::lang::Rail<x10_int >::__apply(
                                                y56358)) + (((x10_int)1))));
                
                //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(x56357)->x10::lang::Rail<x10_int >::__set(
                  y56358, r56356);
                
                //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                ret56359 = r56356;
                
                //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Local_c
                ret56359;
            }
        }
        
        //#line 125 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        team->alltoall<x10_int >(this->FMGL(mySendCount),
                                 ((x10_long)0ll), this->FMGL(myRecvCount),
                                 ((x10_long)0ll), ((x10_long)1ll));
        
        //#line 132 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        this->check_array_size(this->FMGL(comm_choice), this->
                                                          FMGL(myRecvCount));
        
        //#line 135 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(this->FMGL(myRecvCount))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (x10aux::nullCheck(this->FMGL(mc))->
                         FMGL(mype))), ((x10_int)0));
        
        //#line 137 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        team->barrier();
        
        //#line 146 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.ClosureCall_c
        x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>::__apply(x10aux::nullCheck(exchange), 
          this->FMGL(mc), this->FMGL(myRecvCount), this->
                                                     FMGL(mySendCount));
        
        //#line 148 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(this->FMGL(comm_choice),
                                   ((void)(this->FMGL(mc)),MC::
                                     FMGL(MC_NONBLOCK__get)()))) ||
            (x10aux::struct_equals(this->FMGL(comm_choice),
                                   ((void)(this->FMGL(mc)),MC::
                                     FMGL(MC_BLOCK__get)()))))
        {
            
            //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(this->FMGL(mc))->FMGL(nparticles) =
              this->elim_sent();
        }
        
        //#line 158 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
        {
            for (
                 //#line 158 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_int)0); ((i) < (x10aux::nullCheck(this->
                                                               FMGL(mc))->
                                             FMGL(nprocs)));
                 
                 //#line 158 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_int) ((i) + (((x10_int)1))))) {
                
                //#line 159 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(this->FMGL(mySendCount))->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (i)), ((x10_int)0));
            }
        }
        
    }
    
    //#line 162 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    team->barrier();
    
    //#line 163 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here)->
                                 FMGL(id), ((x10_long)0ll))))
    {
        
        //#line 164 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        x10::io::Console::FMGL(ERR__get)()->x10::io::Printer::println(
          reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(((((x10_double) (((x10_long) ((x10::lang::System::nanoTime()) - (start)))))) / (1000000.0)), x10aux::makeStringLit(" (ms)"))));
    }
    
}

//#line 175 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
x10_int MC_Cycle::pack() {
    
    //#line 176 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_long np = ((x10_long) (x10aux::nullCheck(this->FMGL(mc))->
                                 FMGL(nparticles)));
    
    //#line 177 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int count;
    
    //#line 178 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<Particle* >* p = x10aux::nullCheck(this->
                                                         FMGL(mc))->
                                       FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply();
    
    //#line 182 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    MC_Cycle::qsort3(p, ((x10_long)0ll), ((x10_long) ((np) - (((x10_long)1ll)))));
    
    //#line 184 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
    {
        for (
             //#line 184 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
             count = ((x10_int)0); ((((x10_long) (count))) < (np));
             
             //#line 184 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
             count = ((x10_int) ((count) + (((x10_int)1)))))
        {
            
            //#line 185 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
            if ((x10aux::struct_equals(x10aux::nullCheck(x10aux::nullCheck(p)->x10::lang::Rail<Particle* >::__apply(
                                                           ((x10_long) (count))))->
                                         FMGL(absorbed), ((x10_int)1))))
            {
                
                //#line 186 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Branch_c
                break;
            }
            
        }
    }
    
    //#line 189 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
    return count;
    
}

//#line 192 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
void MC_Cycle::update_particles_strict() {
    
    //#line 193 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int np = x10aux::nullCheck(this->FMGL(mc))->FMGL(nparticles);
    
    //#line 194 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_double leakage = x10aux::nullCheck(this->FMGL(mc))->
                           FMGL(leakage);
    
    //#line 195 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int boundary_flag = x10aux::nullCheck(this->FMGL(mc))->
                              FMGL(boundary_flag);
    
    //#line 196 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int nabe;
    
    //#line 198 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int npa = x10::lang::DoubleNatives::toInt(x10::lang::MathNatives::round(((((((x10_double) (((x10_long)1ll)))) - (leakage))) * (((x10_double) (np))))));
    
    //#line 199 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int npl = ((x10_int) ((np) - (npa)));
    
    //#line 202 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10While_c
    while ((!x10aux::struct_equals(((x10_int) ((npl) % x10aux::zeroCheck(((x10_int)6)))),
                                   ((x10_int)0)))) {
        
        //#line 203 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        npl = ((x10_int) ((npl) - (((x10_int)1))));
        
        //#line 204 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        npa = ((x10_int) ((npa) + (((x10_int)1))));
    }
    
    //#line 208 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
    {
        x10_int i;
        for (
             //#line 208 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0); ((i) < (npa)); 
                                              //#line 208 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                                              i = ((x10_int) ((i) + (((x10_int)1)))))
        {
            
            //#line 209 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                ((x10_long) (i))))->FMGL(absorbed) =
              ((x10_int)1);
        }
    }
    
    //#line 212 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
    {
        x10_int i;
        x10_int j;
        for (
             //#line 212 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0), 
                               //#line 212 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                               j = ((x10_int)0); ((i) < (npl));
             
             //#line 212 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_int) ((i) + (((x10_int)1)))), 
                                                     //#line 212 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                                                     j = ((x10_int) ((i) % x10aux::zeroCheck(((x10_int)6)))))
        {
            
            //#line 213 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                ((x10_long) (((x10_int) ((npa) + (i)))))))->
              FMGL(absorbed) = ((x10_int)0);
            
            //#line 214 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
            nabe = x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                           FMGL(mc))->
                                                         FMGL(grid))->
                                       FMGL(nabes))->x10::lang::Rail<x10_int >::__apply(
                     ((x10_long) (j)));
            
            //#line 215 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
            if ((x10aux::struct_equals(nabe, ((x10_int)-1))))
            {
                
                //#line 216 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                        FMGL(mc))->
                                                      FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                    ((x10_long) (((x10_int) ((npa) + (i)))))))->
                  FMGL(proc) = x10aux::nullCheck(this->FMGL(mc))->
                                 FMGL(mype);
            } else {
                
                //#line 218 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                        FMGL(mc))->
                                                      FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                    ((x10_long) (((x10_int) ((npa) + (i)))))))->
                  FMGL(proc) = nabe;
            }
            
        }
    }
    
}

//#line 223 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
void MC_Cycle::update_particles() {
    
    //#line 224 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int np = x10aux::nullCheck(this->FMGL(mc))->FMGL(nparticles);
    
    //#line 225 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_double r;
    
    //#line 226 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int random_nabe_index;
    
    //#line 227 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int random_nabe;
    
    //#line 228 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<Particle* >* particles = x10aux::nullCheck(this->
                                                                 FMGL(mc))->
                                               FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply();
    
    //#line 230 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10aux::nullCheck(this->FMGL(mc))->
                                 FMGL(boundary_flag), MC_Cycle::
                                                        FMGL(BNDRY_REFLECT__get)())))
    {
        
        //#line 231 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 231 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)0); ((i) < (np)); 
                                                 //#line 231 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                                                 i = ((x10_int) ((i) + (((x10_int)1)))))
            {
                
                //#line 233 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                r = ((((x10_double) (((x10_int)::labs(MC_Cycle::
                                                        FMGL(random__get)()->random()))))) / (((((x10_double) (MC_Cycle::
                                                                                                                 FMGL(RAND_MAX__get)()))) + (1.0))));
                
                //#line 235 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
                if (((r) > (x10aux::nullCheck(this->FMGL(mc))->
                              FMGL(leakage)))) {
                    
                    //#line 236 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                    x10aux::nullCheck(x10aux::nullCheck(particles)->x10::lang::Rail<Particle* >::__apply(
                                        ((x10_long) (i))))->
                      FMGL(absorbed) = ((x10_int)1);
                } else {
                    
                    //#line 239 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                    random_nabe_index = x10::lang::DoubleNatives::toInt(((((x10_double) (((x10_int)::labs(MC_Cycle::
                                                                                                            FMGL(random__get)()->random()))))) / (((((((x10_double) (MC_Cycle::
                                                                                                                                                                       FMGL(RAND_MAX__get)()))) + (1.0))) / (((x10_double) (((x10_long)6ll))))))));
                    
                    //#line 240 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                    random_nabe = x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                          FMGL(mc))->
                                                                        FMGL(grid))->
                                                      FMGL(nabes))->x10::lang::Rail<x10_int >::__apply(
                                    ((x10_long) (random_nabe_index)));
                    
                    //#line 241 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                    x10aux::nullCheck(x10aux::nullCheck(particles)->x10::lang::Rail<Particle* >::__apply(
                                        ((x10_long) (i))))->
                      FMGL(absorbed) = ((x10_int)0);
                    
                    //#line 243 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
                    if ((!x10aux::struct_equals(random_nabe,
                                                ((x10_int)-1))))
                    {
                        
                        //#line 244 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                        x10aux::nullCheck(x10aux::nullCheck(particles)->x10::lang::Rail<Particle* >::__apply(
                                            ((x10_long) (i))))->
                          FMGL(proc) = random_nabe;
                    } else {
                        
                        //#line 246 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                        x10aux::nullCheck(x10aux::nullCheck(particles)->x10::lang::Rail<Particle* >::__apply(
                                            ((x10_long) (i))))->
                          FMGL(proc) = x10aux::nullCheck(this->
                                                           FMGL(mc))->
                                         FMGL(mype);
                    }
                    
                }
                
            }
        }
        
    } else 
    //#line 250 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10aux::nullCheck(this->FMGL(mc))->
                                 FMGL(boundary_flag), MC_Cycle::
                                                        FMGL(BNDRY_LEAK__get)())))
    {
        
        //#line 251 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 251 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)0); ((i) < (np)); 
                                                 //#line 251 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                                                 i = ((x10_int) ((i) + (((x10_int)1)))))
            {
                
                //#line 252 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                r = ((((x10_double) (((x10_int)::labs(MC_Cycle::
                                                        FMGL(random__get)()->random()))))) / (((((x10_double) (MC_Cycle::
                                                                                                                 FMGL(RAND_MAX__get)()))) + (1.0))));
                
                //#line 255 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
                if (((r) > (x10aux::nullCheck(this->FMGL(mc))->
                              FMGL(leakage)))) {
                    
                    //#line 256 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                            FMGL(mc))->
                                                          FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                        ((x10_long) (i))))->
                      FMGL(absorbed) = ((x10_int)1);
                } else {
                    
                    //#line 258 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                    random_nabe_index = x10::lang::DoubleNatives::toInt(((((x10_double) (((x10_int)::labs(MC_Cycle::
                                                                                                            FMGL(random__get)()->random()))))) / (((((((x10_double) (MC_Cycle::
                                                                                                                                                                       FMGL(RAND_MAX__get)()))) + (1.0))) / (((x10_double) (((x10_long)6ll))))))));
                    
                    //#line 261 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                    random_nabe = x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                          FMGL(mc))->
                                                                        FMGL(grid))->
                                                      FMGL(nabes))->x10::lang::Rail<x10_int >::__apply(
                                    ((x10_long) (random_nabe_index)));
                    
                    //#line 262 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                            FMGL(mc))->
                                                          FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                        ((x10_long) (i))))->
                      FMGL(absorbed) = ((x10_int)0);
                    
                    //#line 263 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
                    if ((!x10aux::struct_equals(random_nabe,
                                                ((x10_int)-1))))
                    {
                        
                        //#line 264 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                FMGL(mc))->
                                                              FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                            ((x10_long) (i))))->
                          FMGL(proc) = random_nabe;
                    } else {
                        
                        //#line 266 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                        r = ((((x10_double) (((x10_int)::labs(MC_Cycle::
                                                                FMGL(random__get)()->random()))))) / (((((x10_double) (MC_Cycle::
                                                                                                                         FMGL(RAND_MAX__get)()))) + (1.0))));
                        
                        //#line 269 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
                        if (((r) > (x10aux::nullCheck(this->
                                                        FMGL(mc))->
                                      FMGL(leakage)))) {
                            
                            //#line 270 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                    FMGL(mc))->
                                                                  FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                                ((x10_long) (i))))->
                              FMGL(absorbed) = ((x10_int)1);
                        } else {
                            
                            //#line 272 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                    FMGL(mc))->
                                                                  FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                                ((x10_long) (i))))->
                              FMGL(proc) = x10aux::nullCheck(this->
                                                               FMGL(mc))->
                                             FMGL(mype);
                        }
                        
                    }
                    
                }
                
            }
        }
        
    } else 
    //#line 277 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10aux::nullCheck(this->FMGL(mc))->
                                 FMGL(boundary_flag), MC_Cycle::
                                                        FMGL(BNDRY_PERIODIC__get)())))
    {
        
        //#line 278 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 278 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)0); ((i) < (np)); 
                                                 //#line 278 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                                                 i = ((x10_int) ((i) + (((x10_int)1)))))
            {
                
                //#line 279 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                r = ((((x10_double) (((x10_int)::labs(MC_Cycle::
                                                        FMGL(random__get)()->random()))))) / (((((x10_double) (MC_Cycle::
                                                                                                                 FMGL(RAND_MAX__get)()))) + (1.0))));
                
                //#line 282 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
                if (((r) > (x10aux::nullCheck(this->FMGL(mc))->
                              FMGL(leakage)))) {
                    
                    //#line 283 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                            FMGL(mc))->
                                                          FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                        ((x10_long) (i))))->
                      FMGL(absorbed) = ((x10_int)1);
                } else {
                    
                    //#line 285 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                    random_nabe_index = x10::lang::DoubleNatives::toInt(((((x10_double) (((x10_int)::labs(MC_Cycle::
                                                                                                            FMGL(random__get)()->random()))))) / (((((((x10_double) (MC_Cycle::
                                                                                                                                                                       FMGL(RAND_MAX__get)()))) + (1.0))) / (((x10_double) (((x10_long)6ll))))))));
                    
                    //#line 288 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                    random_nabe = x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                          FMGL(mc))->
                                                                        FMGL(grid))->
                                                      FMGL(nabes))->x10::lang::Rail<x10_int >::__apply(
                                    ((x10_long) (random_nabe_index)));
                    
                    //#line 289 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                            FMGL(mc))->
                                                          FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                        ((x10_long) (i))))->
                      FMGL(absorbed) = ((x10_int)0);
                    
                    //#line 290 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
                    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                            FMGL(mc))->
                                                          FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                        ((x10_long) (i))))->
                      FMGL(proc) = random_nabe;
                }
                
            }
        }
        
    }
    
}

//#line 296 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
void MC_Cycle::check_array_size(x10_int comm_choice, x10::lang::Rail<x10_int >* myRecvCount) {
    
    //#line 297 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int total_np;
    
    //#line 299 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if ((!x10aux::struct_equals(comm_choice, ((void)(this->
                                                       FMGL(mc)),MC::
                                               FMGL(MC_MADRE__get)()))))
    {
        
        //#line 300 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        total_np = ((x10_int) ((((x10_int) ((x10aux::nullCheck(this->
                                                                 FMGL(mc))->
                                               FMGL(nparticles)) + (MC_Cycle::isum(
                                                                      myRecvCount,
                                                                      x10aux::nullCheck(this->
                                                                                          FMGL(mc))->
                                                                        FMGL(nprocs)))))) - (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                                                               ((x10_long) (x10aux::nullCheck(this->
                                                                                                                                FMGL(mc))->
                                                                                                              FMGL(mype)))))));
    } else {
        
        //#line 302 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        total_np = MC_Cycle::isum(myRecvCount, x10aux::nullCheck(this->
                                                                   FMGL(mc))->
                                                 FMGL(nprocs));
    }
    
    //#line 304 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if (((x10aux::nullCheck(this->FMGL(mc))->FMGL(sizep)) < (total_np)))
    {
        
        //#line 305 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        x10::io::Console::FMGL(OUT__get)()->printf(x10aux::makeStringLit("WARNING: not enough space to hold: %d particles while receiving: %d particles on proc: %d\n"),
                                                   x10aux::class_cast_unchecked<x10::lang::Any*>(total_np),
                                                   x10aux::class_cast_unchecked<x10::lang::Any*>(((x10_int) ((MC_Cycle::isum(
                                                                                                                myRecvCount,
                                                                                                                x10aux::nullCheck(this->
                                                                                                                                    FMGL(mc))->
                                                                                                                  FMGL(nprocs))) - (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                                                                                                      ((x10_long) (x10aux::nullCheck(this->
                                                                                                                                                                       FMGL(mc))->
                                                                                                                                                     FMGL(mype)))))))),
                                                   x10aux::class_cast_unchecked<x10::lang::Any*>(x10aux::nullCheck(this->
                                                                                                                     FMGL(mc))->
                                                                                                   FMGL(mype)));
        
        //#line 307 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        x10::io::Console::FMGL(OUT__get)()->printf(x10aux::makeStringLit("reallocating....... "));
        
        //#line 308 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
        x10::lang::Rail<Particle* >* tmp = x10aux::nullCheck(this->
                                                               FMGL(mc))->
                                             FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply();
        
        //#line 309 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
        x10_int total = total_np;
        
        //#line 310 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
        x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> plh =
          x10::lang::PlaceLocalHandle<void>::make<x10::lang::Rail<Particle* >* >(
            x10::lang::Place::places(), reinterpret_cast<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*> >(sizeof(MC_Cycle__closure__1)))MC_Cycle__closure__1(total))));
        
        //#line 313 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(this->FMGL(mc))->FMGL(sizep) = ((x10_int) ((total_np) + (((x10_int)1))));
        
        //#line 314 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 314 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)0); ((i) < (x10aux::nullCheck(this->
                                                               FMGL(mc))->
                                             FMGL(sizep)));
                 
                 //#line 314 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_int) ((i) + (((x10_int)1))))) {
                
                //#line 315 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(x10aux::nullCheck(this->
                                                      FMGL(mc))->
                                    FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__set(
                  ((x10_long) (i)), x10aux::nullCheck(tmp)->x10::lang::Rail<Particle* >::__apply(
                                      ((x10_long) (i))));
            }
        }
        
    }
    
}

//#line 319 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
x10_int MC_Cycle::isum(x10::lang::Rail<x10_int >* f, x10_int n) {
    
    //#line 320 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int sum = ((x10_int)0);
    
    //#line 321 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
    {
        x10_int i;
        for (
             //#line 321 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0); ((i) < (n)); 
                                            //#line 321 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                                            i = ((x10_int) ((i) + (((x10_int)1)))))
        {
            
            //#line 322 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
            sum = ((x10_int) ((sum) + (x10aux::nullCheck(f)->x10::lang::Rail<x10_int >::__apply(
                                         ((x10_long) (i))))));
        }
    }
    
    //#line 324 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
    return sum;
    
}

//#line 331 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
x10_int MC_Cycle::elim_sent() {
    
    //#line 332 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<Particle* >* p = x10aux::nullCheck(this->
                                                         FMGL(mc))->
                                       FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply();
    
    //#line 333 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int np = x10aux::nullCheck(this->FMGL(mc))->FMGL(nparticles);
    
    //#line 334 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int mype = x10aux::nullCheck(this->FMGL(mc))->FMGL(mype);
    
    //#line 335 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int count = ((x10_int)0);
    
    //#line 337 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    MC_Cycle::qsort(mype, p, ((x10_long) (((x10_int)0))),
                    ((x10_long) (((x10_int) ((np) - (((x10_int)1)))))));
    
    //#line 339 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.For_c
    {
        x10_int i;
        for (
             //#line 339 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0); ((i) < (np)); 
                                             //#line 339 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                                             i = ((x10_int) ((i) + (((x10_int)1)))))
        {
            
            //#line 340 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
            if ((x10aux::struct_equals(x10aux::nullCheck(x10aux::nullCheck(p)->x10::lang::Rail<Particle* >::__apply(
                                                           ((x10_long) (i))))->
                                         FMGL(proc), mype)) &&
                (x10aux::struct_equals(x10aux::nullCheck(x10aux::nullCheck(p)->x10::lang::Rail<Particle* >::__apply(
                                                           ((x10_long) (i))))->
                                         FMGL(absorbed), ((x10_int)0))))
            {
                
                //#line 341 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
                count = ((x10_int) ((count) + (((x10_int)1))));
            }
            
        }
    }
    
    //#line 344 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
    return count;
    
}

//#line 347 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
void MC_Cycle::qsort(x10_int mype, x10::lang::Rail<Particle* >* a,
                     x10_long lo, x10_long hi) {
    
    //#line 348 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if (((hi) <= (lo))) {
        
        //#line 349 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
        return;
    }
    
    //#line 351 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_long l = ((x10_long) ((lo) - (((x10_long)1ll))));
    
    //#line 352 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_long h = hi;
    
    //#line 353 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    Particle* temp;
    
    //#line 355 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10While_c
    while (true) {
        
        //#line 356 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10While_c
        while (((((x10_long) (MC_Cycle::compare_sent(mype,
                                                     x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                                                       l =
                                                         ((x10_long) ((l) + (((x10_long)1ll))))),
                                                     x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                                                       hi))))) < (((x10_long)0ll))))
        {
            
            //#line 356 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Empty_c
            ;
        }
        
        //#line 357 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10While_c
        while (((((x10_long) (MC_Cycle::compare_sent(mype,
                                                     x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                                                       hi),
                                                     x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                                                       h =
                                                         ((x10_long) ((h) - (((x10_long)1ll))))))))) < (((x10_long)0ll))) &&
               ((h) > (lo))) {
            
            //#line 357 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Empty_c
            ;
        }
        
        //#line 358 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
        if (((l) >= (h))) {
            
            //#line 359 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Branch_c
            break;
        }
        
        //#line 361 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        temp = x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                 l);
        
        //#line 362 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__set(
          l, x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
               h));
        
        //#line 363 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__set(
          h, temp);
    }
    
    //#line 365 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
    temp = x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
             l);
    
    //#line 366 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__set(
      l, x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
           hi));
    
    //#line 367 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__set(
      hi, temp);
    
    //#line 369 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    MC_Cycle::qsort(mype, a, lo, ((x10_long) ((h) - (((x10_long) (((x10_int)1)))))));
    
    //#line 370 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    MC_Cycle::qsort(mype, a, ((x10_long) ((l) + (((x10_long) (((x10_int)1)))))),
                    hi);
}

//#line 373 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
x10_int MC_Cycle::compare_sent(x10_int mype, Particle* p1,
                               Particle* p2) {
    
    //#line 374 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int p1_proc_match = ((x10_int)2);
    
    //#line 375 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_int p2_proc_match = ((x10_int)2);
    
    //#line 377 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10aux::nullCheck(p1)->FMGL(proc),
                               mype))) {
        
        //#line 378 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        p1_proc_match = ((x10_int)1);
    }
    
    //#line 380 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(x10aux::nullCheck(p2)->FMGL(proc),
                               mype))) {
        
        //#line 381 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        p2_proc_match = ((x10_int)1);
    }
    
    //#line 383 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if (((p1_proc_match) > (p2_proc_match))) {
        
        //#line 384 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
        return ((x10_int)1);
        
    } else 
    //#line 385 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if (((p1_proc_match) < (p2_proc_match))) {
        
        //#line 386 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
        return ((x10_int)-1);
        
    } else {
        
        //#line 388 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
        return ((x10_int)0);
        
    }
    
}

//#line 392 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
void MC_Cycle::qsort3(x10::lang::Rail<Particle* >* a, x10_long lo,
                      x10_long hi) {
    
    //#line 393 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
    if (((hi) <= (lo))) {
        
        //#line 394 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
        return;
    }
    
    //#line 396 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_long l = ((x10_long) ((lo) - (((x10_long)1ll))));
    
    //#line 397 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    x10_long h = hi;
    
    //#line 398 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10LocalDecl_c
    Particle* temp;
    
    //#line 400 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10While_c
    while (true) {
        
        //#line 401 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10While_c
        while (((((x10_long) (Particle::compare(x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                                                  l = ((x10_long) ((l) + (((x10_long)1ll))))),
                                                x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                                                  hi))))) < (((x10_long)0ll))))
        {
            
            //#line 401 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Empty_c
            ;
        }
        
        //#line 402 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10While_c
        while (((((x10_long) (Particle::compare(x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                                                  hi), x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                                                         h =
                                                           ((x10_long) ((h) - (((x10_long)1ll))))))))) < (((x10_long)0ll))) &&
               ((h) > (lo))) {
            
            //#line 402 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Empty_c
            ;
        }
        
        //#line 404 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10If_c
        if (((l) >= (h))) {
            
            //#line 405 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": polyglot.ast.Branch_c
            break;
        }
        
        //#line 407 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
        temp = x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
                 l);
        
        //#line 408 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__set(
          l, x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
               h));
        
        //#line 409 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__set(
          h, temp);
    }
    
    //#line 411 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10LocalAssign_c
    temp = x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
             l);
    
    //#line 412 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__set(
      l, x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__apply(
           hi));
    
    //#line 413 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(a)->x10::lang::Rail<Particle* >::__set(
      hi, temp);
    
    //#line 415 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    MC_Cycle::qsort3(a, lo, ((x10_long) ((h) - (((x10_long) (((x10_int)1)))))));
    
    //#line 416 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10Call_c
    MC_Cycle::qsort3(a, ((x10_long) ((l) + (((x10_long) (((x10_int)1)))))),
                     hi);
}

//#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
MC_Cycle* MC_Cycle::MC_Cycle____this__MC_Cycle() {
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": x10.ast.X10MethodDecl_c
void MC_Cycle::__fieldInitializers_MC_Cycle() {
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(mc) = (x10aux::class_cast_unchecked<MC*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(comm_choice) = ((x10_int)0);
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(mySendCount) = x10::lang::Rail<x10_int >::_make(((x10_long)x10aux::num_hosts));
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Cycle.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(myRecvCount) = x10::lang::Rail<x10_int >::_make(((x10_long)x10aux::num_hosts));
}
const x10aux::serialization_id_t MC_Cycle::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Cycle::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void MC_Cycle::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(mc));
    buf.write(this->FMGL(comm_choice));
    buf.write(this->FMGL(mySendCount));
    buf.write(this->FMGL(myRecvCount));
    
}

x10::lang::Reference* MC_Cycle::_deserializer(x10aux::deserialization_buffer& buf) {
    MC_Cycle* this_ = new (memset(x10aux::alloc<MC_Cycle>(), 0, sizeof(MC_Cycle))) MC_Cycle();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void MC_Cycle::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(mc) = buf.read<MC*>();
    FMGL(comm_choice) = buf.read<x10_int>();
    FMGL(mySendCount) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(myRecvCount) = buf.read<x10::lang::Rail<x10_int >*>();
}

x10aux::RuntimeType MC_Cycle::rtt;
void MC_Cycle::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("MC_Cycle",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*>::itable<MC_Cycle__closure__1>MC_Cycle__closure__1::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Cycle__closure__1::__apply, &MC_Cycle__closure__1::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Cycle__closure__1::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*> >, &MC_Cycle__closure__1::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Cycle__closure__1::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Cycle__closure__1::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

/* END of MC_Cycle */
/*************************************************/
