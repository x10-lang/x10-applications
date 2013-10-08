/*************************************************/
/* START of MC_Comm */
#include <MC_Comm.h>

#include <x10/lang/Int.h>
#include <MC.h>
#include <x10/lang/VoidFun_0_3.h>
#include <x10/lang/Rail.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>
#include <x10/lang/Boolean.h>
#include <x10/lang/Runtime.h>
#include <x10/lang/Place.h>
#include <x10/compiler/CompilerFlags.h>
#include <x10/lang/FailedDynamicCheckException.h>
#include <x10/lang/System.h>
#include <x10/lang/Long.h>
#include <x10/lang/FinishState.h>
#include <x10/lang/CheckedThrowable.h>
#include <x10/lang/VoidFun_0_0.h>
#include <Grid.h>
#include <x10/lang/Double.h>
#include <x10/lang/GlobalRail.h>
#include <x10/lang/PlaceLocalHandle.h>
#include <Particle.h>
#include <x10/lang/Error.h>
#include <x10/lang/Exception.h>
#include <x10/compiler/AsyncClosure.h>
#include <x10/lang/Runtime__Profile.h>
#include <x10/compiler/Finalization.h>
#include <x10/compiler/Abort.h>
#include <MC_Cycle.h>
#include <x10/lang/Fun_0_0.h>
#ifndef MC_COMM__CLOSURE__4_CLOSURE
#define MC_COMM__CLOSURE__4_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
class MC_Comm__closure__4 : public x10::lang::Closure {
    public:
    
    static x10::lang::VoidFun_0_0::itable<MC_Comm__closure__4> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 65 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 66 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
            x10_int from = x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                             hid);
            
            //#line 67 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
            x10::lang::Rail<x10_double >* fromP = x10::lang::Rail<x10_double >::_make(numRecv3);
            
            //#line 69 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
            {
                x10_int i;
                for (
                     //#line 69 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                     i = ((x10_int)0); ((((x10_long) (i))) < (numRecv));
                     
                     //#line 69 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int) ((i) + (((x10_int)1))))) {
                    
                    //#line 70 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    Particle* particle = x10aux::nullCheck(particlesRef->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                                           ((x10_long) (((x10_int) ((from) + (i))))));
                    
                    //#line 71 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    fromP->x10::lang::Rail<x10_double >::__set(
                      ((x10_long) (i)), x10aux::nullCheck(particle)->
                                          FMGL(x));
                    
                    //#line 72 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    fromP->x10::lang::Rail<x10_double >::__set(
                      ((x10_long) ((numRecv) + (((x10_long) (i))))),
                      x10aux::nullCheck(particle)->FMGL(y));
                    
                    //#line 73 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    fromP->x10::lang::Rail<x10_double >::__set(
                      ((x10_long) ((numRecv2) + (((x10_long) (i))))),
                      x10aux::nullCheck(particle)->FMGL(z));
                }
            }
            
            //#line 76 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
            x10::lang::Rail<void >::asyncCopy<x10_double >(
              fromP, ((x10_long)0ll), grefP, ((x10_long)0ll),
              numRecv3);
        }
        catch (x10::lang::CheckedThrowable* __exc14) {
            if (x10aux::instanceof<x10::lang::Error*>(__exc14)) {
                x10::lang::Error* __lowerer__var__0__ = static_cast<x10::lang::Error*>(__exc14);
                {
                    
                    //#line 65 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(__lowerer__var__0__));
                }
            } else
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__1__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc14);
                {
                    
                    //#line 65 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::ensureException(
                                                               reinterpret_cast<x10::lang::CheckedThrowable*>(__lowerer__var__1__))));
                }
            } else
            throw;
        }
    }
    
    // captured environment
    x10_long hid;
    x10::lang::Rail<x10_int >* sdispl;
    x10_long numRecv3;
    x10_long numRecv;
    x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> particlesRef;
    x10_long numRecv2;
    x10::lang::GlobalRail<x10_double> grefP;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->hid);
        buf.write(this->sdispl);
        buf.write(this->numRecv3);
        buf.write(this->numRecv);
        buf.write(this->particlesRef);
        buf.write(this->numRecv2);
        buf.write(this->grefP);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__4* storage = x10aux::alloc<MC_Comm__closure__4>();
        buf.record_reference(storage);
        x10_long that_hid = buf.read<x10_long>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10_long that_numRecv3 = buf.read<x10_long>();
        x10_long that_numRecv = buf.read<x10_long>();
        x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> that_particlesRef = buf.read<x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> >();
        x10_long that_numRecv2 = buf.read<x10_long>();
        x10::lang::GlobalRail<x10_double> that_grefP = buf.read<x10::lang::GlobalRail<x10_double> >();
        MC_Comm__closure__4* this_ = new (storage) MC_Comm__closure__4(that_hid, that_sdispl, that_numRecv3, that_numRecv, that_particlesRef, that_numRecv2, that_grefP);
        return this_;
    }
    
    MC_Comm__closure__4(x10_long hid, x10::lang::Rail<x10_int >* sdispl, x10_long numRecv3, x10_long numRecv, x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> particlesRef, x10_long numRecv2, x10::lang::GlobalRail<x10_double> grefP) : hid(hid), sdispl(sdispl), numRecv3(numRecv3), numRecv(numRecv), particlesRef(particlesRef), numRecv2(numRecv2), grefP(grefP) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:65-77";
    }

};

#endif // MC_COMM__CLOSURE__4_CLOSURE
#ifndef MC_COMM__CLOSURE__3_CLOSURE
#define MC_COMM__CLOSURE__3_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
class MC_Comm__closure__3 : public x10::lang::Closure {
    public:
    
    static x10::lang::VoidFun_0_0::itable<MC_Comm__closure__3> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
            {
                x10_int j;
                for (
                     //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                     j = ((x10_int)0); ((j) < (((x10_int)6))); 
                                                               //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                                                               j = ((x10_int) ((j) + (((x10_int)1)))))
                {
                    
                    //#line 44 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_int id = x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(mc)->
                                                                       FMGL(grid))->
                                                     FMGL(nabes))->x10::lang::Rail<x10_int >::__apply(
                                   ((x10_long) (j)));
                    
                    //#line 45 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
                    if (((((x10_long) (id))) < (((x10_long)0ll))))
                    {
                        
                        //#line 46 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Branch_c
                        continue;
                    }
                    
                    //#line 48 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10::lang::Place pl = x10::lang::Place::place(
                                            ((x10_long) (id)));
                    
                    //#line 50 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                    np = x10aux::nullCheck(mc)->FMGL(nparticles);
                    
                    //#line 51 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long numRecv = ((x10_long) (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                      pl->
                                                        FMGL(id))));
                    
                    //#line 53 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
                    if ((x10aux::struct_equals(numRecv, ((x10_long)0ll))))
                    {
                        
                        //#line 54 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Branch_c
                        continue;
                    }
                    
                    //#line 56 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long numRecv2 = ((x10_long) ((numRecv) * (((x10_long)2ll))));
                    
                    //#line 57 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long numRecv3 = ((x10_long) ((numRecv) * (((x10_long)3ll))));
                    
                    //#line 59 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10::lang::Rail<x10_double >* tempP =
                      x10::lang::Rail<x10_double >::_make(numRecv3);
                    
                    //#line 60 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10::lang::GlobalRail<x10_double> grefP =
                      x10::lang::GlobalRail<x10_double>::_make(tempP);
                    
                    //#line 62 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> particlesRef =
                      x10aux::nullCheck(mc)->FMGL(particles);
                    
                    //#line 63 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10::lang::Rail<Particle* >* particles =
                      particlesRef->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply();
                    
                    //#line 65 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10::lang::Runtime::runAsync(pl, reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(MC_Comm__closure__4)))MC_Comm__closure__4(hid, sdispl, numRecv3, numRecv, particlesRef, numRecv2, grefP))),
                                                 x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
                    
                    //#line 78 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_int to = x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                   pl->FMGL(id));
                    
                    //#line 79 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long end = ((x10_long) ((((x10_long) (to))) + (numRecv)));
                    
                    //#line 85 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
                    {
                        x10_int i;
                        for (
                             //#line 85 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                             i = to; ((((x10_long) (i))) < (end));
                             
                             //#line 85 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                             i = ((x10_int) ((i) + (((x10_int)1)))))
                        {
                            
                            //#line 86 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                            x10aux::nullCheck(particles)->x10::lang::Rail<Particle* >::__set(
                              ((x10_long) (i)), Particle::_make(grefP->x10::lang::GlobalRail<x10_double>::__apply(
                                                                  ((x10_long) (i))),
                                                                grefP->x10::lang::GlobalRail<x10_double>::__apply(
                                                                  ((x10_long) ((numRecv) + (((x10_long) (i)))))),
                                                                grefP->x10::lang::GlobalRail<x10_double>::__apply(
                                                                  ((x10_long) ((numRecv2) + (((x10_long) (i)))))),
                                                                0.0,
                                                                0.0,
                                                                ((x10_int)0),
                                                                mype));
                        }
                    }
                    
                }
            }
            
        }
        catch (x10::lang::CheckedThrowable* __exc15) {
            if (x10aux::instanceof<x10::lang::Error*>(__exc15)) {
                x10::lang::Error* __lowerer__var__0__ = static_cast<x10::lang::Error*>(__exc15);
                {
                    
                    //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(__lowerer__var__0__));
                }
            } else
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__1__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc15);
                {
                    
                    //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::ensureException(
                                                               reinterpret_cast<x10::lang::CheckedThrowable*>(__lowerer__var__1__))));
                }
            } else
            throw;
        }
    }
    
    // captured environment
    MC* mc;
    x10aux::captured_struct_lval<x10_int> np;
    x10::lang::Rail<x10_int >* myRecvCount;
    x10_long hid;
    x10::lang::Rail<x10_int >* sdispl;
    x10::lang::Rail<x10_int >* displ;
    x10_int mype;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->mc);
        buf.write(this->np);
        buf.write(this->myRecvCount);
        buf.write(this->hid);
        buf.write(this->sdispl);
        buf.write(this->displ);
        buf.write(this->mype);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__3* storage = x10aux::alloc<MC_Comm__closure__3>();
        buf.record_reference(storage);
        MC* that_mc = buf.read<MC*>();
        x10aux::captured_struct_lval<x10_int> that_np = buf.read<x10aux::captured_struct_lval<x10_int> >();
        x10::lang::Rail<x10_int >* that_myRecvCount = buf.read<x10::lang::Rail<x10_int >*>();
        x10_long that_hid = buf.read<x10_long>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10::lang::Rail<x10_int >* that_displ = buf.read<x10::lang::Rail<x10_int >*>();
        x10_int that_mype = buf.read<x10_int>();
        MC_Comm__closure__3* this_ = new (storage) MC_Comm__closure__3(that_mc, that_np, that_myRecvCount, that_hid, that_sdispl, that_displ, that_mype);
        return this_;
    }
    
    MC_Comm__closure__3(MC* mc, x10aux::captured_struct_lval<x10_int> np, x10::lang::Rail<x10_int >* myRecvCount, x10_long hid, x10::lang::Rail<x10_int >* sdispl, x10::lang::Rail<x10_int >* displ, x10_int mype) : mc(mc), np(np), myRecvCount(myRecvCount), hid(hid), sdispl(sdispl), displ(displ), mype(mype) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:43-88";
    }

};

#endif // MC_COMM__CLOSURE__3_CLOSURE
#ifndef MC_COMM__CLOSURE__2_CLOSURE
#define MC_COMM__CLOSURE__2_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
class MC_Comm__closure__2 : public x10::lang::Closure {
    public:
    
    static x10::lang::VoidFun_0_0::itable<MC_Comm__closure__2> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 40 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
            x10::lang::Place h = x10::lang::Place::_make(x10aux::here);
            
            //#line 41 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
            x10_long hid = x10::lang::Place::_make(x10aux::here)->FMGL(id);
            
            //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::runAsync(reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(MC_Comm__closure__3)))MC_Comm__closure__3(mc, &(np), myRecvCount, hid, sdispl, displ, mype))));
        }
        catch (x10::lang::CheckedThrowable* __exc16) {
            if (x10aux::instanceof<x10::lang::Error*>(__exc16)) {
                x10::lang::Error* __lowerer__var__0__ = static_cast<x10::lang::Error*>(__exc16);
                {
                    
                    //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(__lowerer__var__0__));
                }
            } else
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__1__ = static_cast<x10::lang::CheckedThrowable*>(__exc16);
                {
                    
                    //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::ensureException(
                                                               reinterpret_cast<x10::lang::CheckedThrowable*>(__lowerer__var__1__))));
                }
            } else
            throw;
        }
    }
    
    // captured environment
    MC* mc;
    x10aux::captured_struct_lval<x10_int> np;
    x10::lang::Rail<x10_int >* myRecvCount;
    x10::lang::Rail<x10_int >* sdispl;
    x10::lang::Rail<x10_int >* displ;
    x10_int mype;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->mc);
        buf.write(this->np);
        buf.write(this->myRecvCount);
        buf.write(this->sdispl);
        buf.write(this->displ);
        buf.write(this->mype);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__2* storage = x10aux::alloc<MC_Comm__closure__2>();
        buf.record_reference(storage);
        MC* that_mc = buf.read<MC*>();
        x10aux::captured_struct_lval<x10_int> that_np = buf.read<x10aux::captured_struct_lval<x10_int> >();
        x10::lang::Rail<x10_int >* that_myRecvCount = buf.read<x10::lang::Rail<x10_int >*>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10::lang::Rail<x10_int >* that_displ = buf.read<x10::lang::Rail<x10_int >*>();
        x10_int that_mype = buf.read<x10_int>();
        MC_Comm__closure__2* this_ = new (storage) MC_Comm__closure__2(that_mc, that_np, that_myRecvCount, that_sdispl, that_displ, that_mype);
        return this_;
    }
    
    MC_Comm__closure__2(MC* mc, x10aux::captured_struct_lval<x10_int> np, x10::lang::Rail<x10_int >* myRecvCount, x10::lang::Rail<x10_int >* sdispl, x10::lang::Rail<x10_int >* displ, x10_int mype) : mc(mc), np(np), myRecvCount(myRecvCount), sdispl(sdispl), displ(displ), mype(mype) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:39-89";
    }

};

#endif // MC_COMM__CLOSURE__2_CLOSURE
#ifndef MC_COMM__CLOSURE__1_CLOSURE
#define MC_COMM__CLOSURE__1_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_3.h>
class MC_Comm__closure__1 : public x10::lang::Closure {
    public:
    
    static x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>::itable<MC_Comm__closure__1> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply(MC* mc, x10::lang::Rail<x10_int >* myRecvCount, x10::lang::Rail<x10_int >* mySendCount) {
        
        //#line 23 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10::lang::Rail<x10_int >* displ = x10::lang::Rail<x10_int >::_make(((x10_long) (x10aux::nullCheck(mc)->
                                                                                           FMGL(nprocs))));
        
        //#line 24 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10::lang::Rail<x10_int >* sdispl = x10::lang::Rail<x10_int >::_make(((x10_long) (x10aux::nullCheck(mc)->
                                                                                            FMGL(nprocs))));
        
        //#line 26 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10_int numProcs = x10aux::nullCheck(mc)->FMGL(nprocs);
        
        //#line 27 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10_int mype = x10aux::nullCheck(mc)->FMGL(mype);
        
        //#line 28 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10_int np = x10aux::nullCheck(mc)->FMGL(nparticles);
        
        //#line 30 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__set(
          ((x10_long)0ll), np);
        
        //#line 33 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 33 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)1); ((i) < (numProcs)); 
                                                       //#line 33 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                                                       i =
                                                         ((x10_int) ((i) + (((x10_int)1)))))
            {
                
                //#line 34 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (i)), ((x10_int) ((x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                                   ((x10_long) (((x10_int) ((i) - (((x10_int)1)))))))) + (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                                                                            ((x10_long) (((x10_int) ((i) - (((x10_int)1)))))))))));
            }
        }
        
        //#line 36 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 36 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)1); ((i) < (numProcs)); 
                                                       //#line 36 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                                                       i =
                                                         ((x10_int) ((i) + (((x10_int)1)))))
            {
                
                //#line 37 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (i)), ((x10_int) ((x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                                                   ((x10_long) (((x10_int) ((i) - (((x10_int)1)))))))) + (x10aux::nullCheck(mySendCount)->x10::lang::Rail<x10_int >::__apply(
                                                                                                            ((x10_long) (((x10_int) ((i) - (((x10_int)1)))))))))));
            }
        }
        {
            
            //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
            x10::lang::Runtime::ensureNotInAtomic();
            
            //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
            x10::lang::FinishState* x10____var0 = x10::lang::Runtime::startFinish();
            {
                
                //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                x10::lang::CheckedThrowable* throwable55360 =
                  x10aux::class_cast_unchecked<x10::lang::CheckedThrowable*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL));
                
                //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
                try {
                    
                    //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
                    try {
                        {
                            
                            //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                            x10::lang::Runtime::runAsync(
                              reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(MC_Comm__closure__2)))MC_Comm__closure__2(mc, &(np), myRecvCount, sdispl, displ, mype))));
                        }
                    }
                    catch (x10::lang::CheckedThrowable* __exc17) {
                        if (true) {
                            x10::lang::CheckedThrowable* __lowerer__var__0__ =
                              static_cast<x10::lang::CheckedThrowable*>(__exc17);
                            {
                                
                                //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                                x10::lang::Runtime::pushException(
                                  __lowerer__var__0__);
                                
                                //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                                x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::_make()));
                            }
                        } else
                        throw;
                    }
                    
                    //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10::compiler::Finalization::plausibleThrow();
                }
                catch (x10::lang::CheckedThrowable* __exc18) {
                    if (true) {
                        x10::lang::CheckedThrowable* formal55361 =
                          static_cast<x10::lang::CheckedThrowable*>(__exc18);
                        {
                            
                            //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                            throwable55360 = formal55361;
                        }
                    } else
                    throw;
                }
                
                //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
                if ((!x10aux::struct_equals(reinterpret_cast<x10::lang::CheckedThrowable*>(X10_NULL),
                                            throwable55360)))
                {
                    
                    //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
                    if (x10aux::instanceof<x10::compiler::Abort*>(throwable55360))
                    {
                        
                        //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                        x10aux::throwException(x10aux::nullCheck(throwable55360));
                    }
                    
                }
                
                //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
                if (true) {
                    
                    //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10::lang::Runtime::stopFinish(x10____var0);
                }
                
                //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
                if ((!x10aux::struct_equals(reinterpret_cast<x10::lang::CheckedThrowable*>(X10_NULL),
                                            throwable55360)))
                {
                    
                    //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
                    if (!(x10aux::instanceof<x10::compiler::Finalization*>(throwable55360)))
                    {
                        
                        //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                        x10aux::throwException(x10aux::nullCheck(throwable55360));
                    }
                    
                }
                
            }
        }
        
        //#line 90 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        MC* x55298 = mc;
        
        //#line 90 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10_int y55299 = MC_Cycle::isum(myRecvCount, x10aux::nullCheck(mc)->
                                                       FMGL(nprocs));
        
        //#line 90 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x55298)->FMGL(nparticles) = ((x10_int) ((x10aux::nullCheck(x55298)->
                                                                     FMGL(nparticles)) + (y55299)));
    }
    
    // captured environment
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__1* storage = x10aux::alloc<MC_Comm__closure__1>();
        buf.record_reference(storage);
        MC_Comm__closure__1* this_ = new (storage) MC_Comm__closure__1();
        return this_;
    }
    
    MC_Comm__closure__1() { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:21-91";
    }

};

#endif // MC_COMM__CLOSURE__1_CLOSURE
#ifndef MC_COMM__CLOSURE__7_CLOSURE
#define MC_COMM__CLOSURE__7_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__7 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__7> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    x10_long __apply() {
        
        //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10::lang::Place::_make(x10aux::here)->FMGL(id);
            
        }
        catch (x10::lang::CheckedThrowable* __exc19) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ = static_cast<x10::lang::CheckedThrowable*>(__exc19);
                {
                    
                    //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long __lowerer__var__1__ = x10aux::class_cast_unchecked<x10_long>(x10::lang::Runtime::wrapAtChecked<x10_long >(
                                                                                            __lowerer__var__0__));
                    
                    //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__7* storage = x10aux::alloc<MC_Comm__closure__7>();
        buf.record_reference(storage);
        MC_Comm__closure__7* this_ = new (storage) MC_Comm__closure__7();
        return this_;
    }
    
    MC_Comm__closure__7() { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:118";
    }

};

#endif // MC_COMM__CLOSURE__7_CLOSURE
#ifndef MC_COMM__CLOSURE__6_CLOSURE
#define MC_COMM__CLOSURE__6_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__6 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__6> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    Particle* __apply() {
        
        //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10aux::nullCheck(x10aux::nullCheck(mc)->FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                     ((x10_long) (((x10_int) ((x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                                                 x10::lang::Runtime::evalAt<x10_long >(
                                                   x10::lang::Place::_make(x10aux::here),
                                                   reinterpret_cast<x10::lang::Fun_0_0<x10_long>*>((new (x10aux::alloc<x10::lang::Fun_0_0<x10_long> >(sizeof(MC_Comm__closure__7)))MC_Comm__closure__7())),
                                                   x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))))) + (ii))))));
            
        }
        catch (x10::lang::CheckedThrowable* __exc20) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc20);
                {
                    
                    //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    Particle* __lowerer__var__1__ = x10::lang::Runtime::wrapAtChecked<Particle* >(
                                                      __lowerer__var__0__);
                    
                    //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    MC* mc;
    x10::lang::Rail<x10_int >* sdispl;
    x10_int ii;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->mc);
        buf.write(this->sdispl);
        buf.write(this->ii);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__6* storage = x10aux::alloc<MC_Comm__closure__6>();
        buf.record_reference(storage);
        MC* that_mc = buf.read<MC*>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10_int that_ii = buf.read<x10_int>();
        MC_Comm__closure__6* this_ = new (storage) MC_Comm__closure__6(that_mc, that_sdispl, that_ii);
        return this_;
    }
    
    MC_Comm__closure__6(MC* mc, x10::lang::Rail<x10_int >* sdispl, x10_int ii) : mc(mc), sdispl(sdispl), ii(ii) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:118";
    }

};

#endif // MC_COMM__CLOSURE__6_CLOSURE
#ifndef MC_COMM__CLOSURE__9_CLOSURE
#define MC_COMM__CLOSURE__9_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__9 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__9> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    x10_long __apply() {
        
        //#line 123 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 123 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10::lang::Place::_make(x10aux::here)->FMGL(id);
            
        }
        catch (x10::lang::CheckedThrowable* __exc21) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ = static_cast<x10::lang::CheckedThrowable*>(__exc21);
                {
                    
                    //#line 123 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long __lowerer__var__1__ = x10aux::class_cast_unchecked<x10_long>(x10::lang::Runtime::wrapAtChecked<x10_long >(
                                                                                            __lowerer__var__0__));
                    
                    //#line 123 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__9* storage = x10aux::alloc<MC_Comm__closure__9>();
        buf.record_reference(storage);
        MC_Comm__closure__9* this_ = new (storage) MC_Comm__closure__9();
        return this_;
    }
    
    MC_Comm__closure__9() { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:123";
    }

};

#endif // MC_COMM__CLOSURE__9_CLOSURE
#ifndef MC_COMM__CLOSURE__8_CLOSURE
#define MC_COMM__CLOSURE__8_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__8 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__8> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    Particle* __apply() {
        
        //#line 123 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 123 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10aux::nullCheck(x10aux::nullCheck(mc)->FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                     ((x10_long) (((x10_int) ((x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                                                 x10::lang::Runtime::evalAt<x10_long >(
                                                   x10::lang::Place::_make(x10aux::here),
                                                   reinterpret_cast<x10::lang::Fun_0_0<x10_long>*>((new (x10aux::alloc<x10::lang::Fun_0_0<x10_long> >(sizeof(MC_Comm__closure__9)))MC_Comm__closure__9())),
                                                   x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))))) + (ii))))));
            
        }
        catch (x10::lang::CheckedThrowable* __exc22) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc22);
                {
                    
                    //#line 123 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    Particle* __lowerer__var__1__ = x10::lang::Runtime::wrapAtChecked<Particle* >(
                                                      __lowerer__var__0__);
                    
                    //#line 123 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    MC* mc;
    x10::lang::Rail<x10_int >* sdispl;
    x10_int ii;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->mc);
        buf.write(this->sdispl);
        buf.write(this->ii);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__8* storage = x10aux::alloc<MC_Comm__closure__8>();
        buf.record_reference(storage);
        MC* that_mc = buf.read<MC*>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10_int that_ii = buf.read<x10_int>();
        MC_Comm__closure__8* this_ = new (storage) MC_Comm__closure__8(that_mc, that_sdispl, that_ii);
        return this_;
    }
    
    MC_Comm__closure__8(MC* mc, x10::lang::Rail<x10_int >* sdispl, x10_int ii) : mc(mc), sdispl(sdispl), ii(ii) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:123";
    }

};

#endif // MC_COMM__CLOSURE__8_CLOSURE
#ifndef MC_COMM__CLOSURE__11_CLOSURE
#define MC_COMM__CLOSURE__11_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__11 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__11> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    x10_long __apply() {
        
        //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10::lang::Place::_make(x10aux::here)->FMGL(id);
            
        }
        catch (x10::lang::CheckedThrowable* __exc23) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ = static_cast<x10::lang::CheckedThrowable*>(__exc23);
                {
                    
                    //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long __lowerer__var__1__ = x10aux::class_cast_unchecked<x10_long>(x10::lang::Runtime::wrapAtChecked<x10_long >(
                                                                                            __lowerer__var__0__));
                    
                    //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__11* storage = x10aux::alloc<MC_Comm__closure__11>();
        buf.record_reference(storage);
        MC_Comm__closure__11* this_ = new (storage) MC_Comm__closure__11();
        return this_;
    }
    
    MC_Comm__closure__11() { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:131";
    }

};

#endif // MC_COMM__CLOSURE__11_CLOSURE
#ifndef MC_COMM__CLOSURE__10_CLOSURE
#define MC_COMM__CLOSURE__10_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__10 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__10> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    Particle* __apply() {
        
        //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10aux::nullCheck(x10aux::nullCheck(mc)->FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                     ((x10_long) (((x10_int) ((x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                                                 x10::lang::Runtime::evalAt<x10_long >(
                                                   x10::lang::Place::_make(x10aux::here),
                                                   reinterpret_cast<x10::lang::Fun_0_0<x10_long>*>((new (x10aux::alloc<x10::lang::Fun_0_0<x10_long> >(sizeof(MC_Comm__closure__11)))MC_Comm__closure__11())),
                                                   x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))))) + (ii))))));
            
        }
        catch (x10::lang::CheckedThrowable* __exc24) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc24);
                {
                    
                    //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    Particle* __lowerer__var__1__ = x10::lang::Runtime::wrapAtChecked<Particle* >(
                                                      __lowerer__var__0__);
                    
                    //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    MC* mc;
    x10::lang::Rail<x10_int >* sdispl;
    x10_int ii;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->mc);
        buf.write(this->sdispl);
        buf.write(this->ii);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__10* storage = x10aux::alloc<MC_Comm__closure__10>();
        buf.record_reference(storage);
        MC* that_mc = buf.read<MC*>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10_int that_ii = buf.read<x10_int>();
        MC_Comm__closure__10* this_ = new (storage) MC_Comm__closure__10(that_mc, that_sdispl, that_ii);
        return this_;
    }
    
    MC_Comm__closure__10(MC* mc, x10::lang::Rail<x10_int >* sdispl, x10_int ii) : mc(mc), sdispl(sdispl), ii(ii) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:131";
    }

};

#endif // MC_COMM__CLOSURE__10_CLOSURE
#ifndef MC_COMM__CLOSURE__13_CLOSURE
#define MC_COMM__CLOSURE__13_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__13 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__13> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    x10_long __apply() {
        
        //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10::lang::Place::_make(x10aux::here)->FMGL(id);
            
        }
        catch (x10::lang::CheckedThrowable* __exc25) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ = static_cast<x10::lang::CheckedThrowable*>(__exc25);
                {
                    
                    //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long __lowerer__var__1__ = x10aux::class_cast_unchecked<x10_long>(x10::lang::Runtime::wrapAtChecked<x10_long >(
                                                                                            __lowerer__var__0__));
                    
                    //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__13* storage = x10aux::alloc<MC_Comm__closure__13>();
        buf.record_reference(storage);
        MC_Comm__closure__13* this_ = new (storage) MC_Comm__closure__13();
        return this_;
    }
    
    MC_Comm__closure__13() { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:136";
    }

};

#endif // MC_COMM__CLOSURE__13_CLOSURE
#ifndef MC_COMM__CLOSURE__12_CLOSURE
#define MC_COMM__CLOSURE__12_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__12 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__12> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    Particle* __apply() {
        
        //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10aux::nullCheck(x10aux::nullCheck(mc)->FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                     ((x10_long) (((x10_int) ((x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                                                 x10::lang::Runtime::evalAt<x10_long >(
                                                   x10::lang::Place::_make(x10aux::here),
                                                   reinterpret_cast<x10::lang::Fun_0_0<x10_long>*>((new (x10aux::alloc<x10::lang::Fun_0_0<x10_long> >(sizeof(MC_Comm__closure__13)))MC_Comm__closure__13())),
                                                   x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))))) + (ii))))));
            
        }
        catch (x10::lang::CheckedThrowable* __exc26) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc26);
                {
                    
                    //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    Particle* __lowerer__var__1__ = x10::lang::Runtime::wrapAtChecked<Particle* >(
                                                      __lowerer__var__0__);
                    
                    //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    MC* mc;
    x10::lang::Rail<x10_int >* sdispl;
    x10_int ii;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->mc);
        buf.write(this->sdispl);
        buf.write(this->ii);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__12* storage = x10aux::alloc<MC_Comm__closure__12>();
        buf.record_reference(storage);
        MC* that_mc = buf.read<MC*>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10_int that_ii = buf.read<x10_int>();
        MC_Comm__closure__12* this_ = new (storage) MC_Comm__closure__12(that_mc, that_sdispl, that_ii);
        return this_;
    }
    
    MC_Comm__closure__12(MC* mc, x10::lang::Rail<x10_int >* sdispl, x10_int ii) : mc(mc), sdispl(sdispl), ii(ii) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:136";
    }

};

#endif // MC_COMM__CLOSURE__12_CLOSURE
#ifndef MC_COMM__CLOSURE__15_CLOSURE
#define MC_COMM__CLOSURE__15_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__15 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__15> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    x10_long __apply() {
        
        //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10::lang::Place::_make(x10aux::here)->FMGL(id);
            
        }
        catch (x10::lang::CheckedThrowable* __exc27) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ = static_cast<x10::lang::CheckedThrowable*>(__exc27);
                {
                    
                    //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long __lowerer__var__1__ = x10aux::class_cast_unchecked<x10_long>(x10::lang::Runtime::wrapAtChecked<x10_long >(
                                                                                            __lowerer__var__0__));
                    
                    //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__15* storage = x10aux::alloc<MC_Comm__closure__15>();
        buf.record_reference(storage);
        MC_Comm__closure__15* this_ = new (storage) MC_Comm__closure__15();
        return this_;
    }
    
    MC_Comm__closure__15() { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:144";
    }

};

#endif // MC_COMM__CLOSURE__15_CLOSURE
#ifndef MC_COMM__CLOSURE__14_CLOSURE
#define MC_COMM__CLOSURE__14_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__14 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__14> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    Particle* __apply() {
        
        //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10aux::nullCheck(x10aux::nullCheck(mc)->FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                     ((x10_long) (((x10_int) ((x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                                                 x10::lang::Runtime::evalAt<x10_long >(
                                                   x10::lang::Place::_make(x10aux::here),
                                                   reinterpret_cast<x10::lang::Fun_0_0<x10_long>*>((new (x10aux::alloc<x10::lang::Fun_0_0<x10_long> >(sizeof(MC_Comm__closure__15)))MC_Comm__closure__15())),
                                                   x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))))) + (ii))))));
            
        }
        catch (x10::lang::CheckedThrowable* __exc28) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc28);
                {
                    
                    //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    Particle* __lowerer__var__1__ = x10::lang::Runtime::wrapAtChecked<Particle* >(
                                                      __lowerer__var__0__);
                    
                    //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    MC* mc;
    x10::lang::Rail<x10_int >* sdispl;
    x10_int ii;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->mc);
        buf.write(this->sdispl);
        buf.write(this->ii);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__14* storage = x10aux::alloc<MC_Comm__closure__14>();
        buf.record_reference(storage);
        MC* that_mc = buf.read<MC*>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10_int that_ii = buf.read<x10_int>();
        MC_Comm__closure__14* this_ = new (storage) MC_Comm__closure__14(that_mc, that_sdispl, that_ii);
        return this_;
    }
    
    MC_Comm__closure__14(MC* mc, x10::lang::Rail<x10_int >* sdispl, x10_int ii) : mc(mc), sdispl(sdispl), ii(ii) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:144";
    }

};

#endif // MC_COMM__CLOSURE__14_CLOSURE
#ifndef MC_COMM__CLOSURE__17_CLOSURE
#define MC_COMM__CLOSURE__17_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__17 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__17> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    x10_long __apply() {
        
        //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10::lang::Place::_make(x10aux::here)->FMGL(id);
            
        }
        catch (x10::lang::CheckedThrowable* __exc29) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ = static_cast<x10::lang::CheckedThrowable*>(__exc29);
                {
                    
                    //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_long __lowerer__var__1__ = x10aux::class_cast_unchecked<x10_long>(x10::lang::Runtime::wrapAtChecked<x10_long >(
                                                                                            __lowerer__var__0__));
                    
                    //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__17* storage = x10aux::alloc<MC_Comm__closure__17>();
        buf.record_reference(storage);
        MC_Comm__closure__17* this_ = new (storage) MC_Comm__closure__17();
        return this_;
    }
    
    MC_Comm__closure__17() { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:149";
    }

};

#endif // MC_COMM__CLOSURE__17_CLOSURE
#ifndef MC_COMM__CLOSURE__16_CLOSURE
#define MC_COMM__CLOSURE__16_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class MC_Comm__closure__16 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__16> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    Particle* __apply() {
        
        //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Try_c
        try {
            
            //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
            return x10aux::nullCheck(x10aux::nullCheck(mc)->FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__apply(
                     ((x10_long) (((x10_int) ((x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                                                 x10::lang::Runtime::evalAt<x10_long >(
                                                   x10::lang::Place::_make(x10aux::here),
                                                   reinterpret_cast<x10::lang::Fun_0_0<x10_long>*>((new (x10aux::alloc<x10::lang::Fun_0_0<x10_long> >(sizeof(MC_Comm__closure__17)))MC_Comm__closure__17())),
                                                   x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))))) + (ii))))));
            
        }
        catch (x10::lang::CheckedThrowable* __exc30) {
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__0__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc30);
                {
                    
                    //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    Particle* __lowerer__var__1__ = x10::lang::Runtime::wrapAtChecked<Particle* >(
                                                      __lowerer__var__0__);
                    
                    //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
                    return __lowerer__var__1__;
                    
                }
            } else
            throw;
        }
    }
    
    // captured environment
    MC* mc;
    x10::lang::Rail<x10_int >* sdispl;
    x10_int ii;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->mc);
        buf.write(this->sdispl);
        buf.write(this->ii);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__16* storage = x10aux::alloc<MC_Comm__closure__16>();
        buf.record_reference(storage);
        MC* that_mc = buf.read<MC*>();
        x10::lang::Rail<x10_int >* that_sdispl = buf.read<x10::lang::Rail<x10_int >*>();
        x10_int that_ii = buf.read<x10_int>();
        MC_Comm__closure__16* this_ = new (storage) MC_Comm__closure__16(that_mc, that_sdispl, that_ii);
        return this_;
    }
    
    MC_Comm__closure__16(MC* mc, x10::lang::Rail<x10_int >* sdispl, x10_int ii) : mc(mc), sdispl(sdispl), ii(ii) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:149";
    }

};

#endif // MC_COMM__CLOSURE__16_CLOSURE
#ifndef MC_COMM__CLOSURE__5_CLOSURE
#define MC_COMM__CLOSURE__5_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_3.h>
class MC_Comm__closure__5 : public x10::lang::Closure {
    public:
    
    static x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>::itable<MC_Comm__closure__5> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply(MC* mc, x10::lang::Rail<x10_int >* myRecvCount, x10::lang::Rail<x10_int >* mySendCount) {
        
        //#line 98 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10::lang::Rail<x10_int >* mycoords = x10aux::nullCheck(x10aux::nullCheck(mc)->
                                                                  FMGL(grid))->
                                                FMGL(proc_coords);
        
        //#line 99 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10::lang::Rail<x10_int >* nabes = x10aux::nullCheck(x10aux::nullCheck(mc)->
                                                               FMGL(grid))->
                                             FMGL(nabes);
        
        //#line 101 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10::lang::Rail<x10_int >* displ = x10::lang::Rail<x10_int >::_make(((x10_long) (x10aux::nullCheck(mc)->
                                                                                           FMGL(nprocs))));
        
        //#line 102 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10::lang::Rail<x10_int >* sdispl = x10::lang::Rail<x10_int >::_make(((x10_long) (x10aux::nullCheck(mc)->
                                                                                            FMGL(nprocs))));
        
        //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)1); ((i) < (x10aux::nullCheck(mc)->
                                             FMGL(nprocs)));
                 
                 //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_int) ((i) + (((x10_int)1))))) {
                
                //#line 106 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (i)), ((x10_int) ((x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                                   ((x10_long) (((x10_int) ((i) - (((x10_int)1)))))))) + (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                                                                            ((x10_long) (((x10_int) ((i) - (((x10_int)1)))))))))));
            }
        }
        
        //#line 109 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 109 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)1); ((i) < (x10aux::nullCheck(mc)->
                                             FMGL(nprocs)));
                 
                 //#line 109 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_int) ((i) + (((x10_int)1))))) {
                
                //#line 110 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (i)), ((x10_int) ((x10aux::nullCheck(sdispl)->x10::lang::Rail<x10_int >::__apply(
                                                   ((x10_long) (((x10_int) ((i) - (((x10_int)1)))))))) + (x10aux::nullCheck(mySendCount)->x10::lang::Rail<x10_int >::__apply(
                                                                                                            ((x10_long) (((x10_int) ((i) - (((x10_int)1)))))))))));
            }
        }
        
        //#line 113 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(((x10_long) ((((x10_long) (x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)0ll))))) % x10aux::zeroCheck(((x10_long)2ll)))),
                                   ((x10_long)0ll)))) {
            
            //#line 114 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
            x10_int i;
            
            //#line 115 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
            {
                for (
                     //#line 115 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int)0); ((i) < (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                 ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)1ll)))))));
                     
                     //#line 115 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int) ((i) + (((x10_int)1)))))
                {
                    
                    //#line 116 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_int ii = i;
                    
                    //#line 117 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10aux::nullCheck(x10aux::nullCheck(mc)->
                                        FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__set(
                      ((x10_long) (((x10_int) ((((x10_int) ((x10aux::nullCheck(mc)->
                                                               FMGL(nparticles)) + (x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                                                                      ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                                                     ((x10_long)1ll))))))))) + (i))))),
                      x10::lang::Runtime::evalAt<Particle* >(
                        x10::lang::Place::place(((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                               ((x10_long)0ll))))),
                        reinterpret_cast<x10::lang::Fun_0_0<Particle*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<Particle*> >(sizeof(MC_Comm__closure__6)))MC_Comm__closure__6(mc, sdispl, ii))),
                        x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))));
                }
            }
            
            //#line 120 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
            {
                for (
                     //#line 120 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int)0); ((i) < (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                 ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)0ll)))))));
                     
                     //#line 120 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int) ((i) + (((x10_int)1)))))
                {
                    
                    //#line 121 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_int ii = i;
                    
                    //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10aux::nullCheck(x10aux::nullCheck(mc)->
                                        FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__set(
                      ((x10_long) (((x10_int) ((((x10_int) ((x10aux::nullCheck(mc)->
                                                               FMGL(nparticles)) + (x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                                                                      ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                                                     ((x10_long)0ll))))))))) + (i))))),
                      x10::lang::Runtime::evalAt<Particle* >(
                        x10::lang::Place::place(((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                               ((x10_long)1ll))))),
                        reinterpret_cast<x10::lang::Fun_0_0<Particle*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<Particle*> >(sizeof(MC_Comm__closure__8)))MC_Comm__closure__8(mc, sdispl, ii))),
                        x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))));
                }
            }
            
        }
        
        //#line 126 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(((x10_long) ((((x10_long) (x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)1ll))))) % x10aux::zeroCheck(((x10_long)2ll)))),
                                   ((x10_long)0ll)))) {
            
            //#line 127 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
            x10_int i;
            
            //#line 128 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
            {
                for (
                     //#line 128 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int)0); ((i) < (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                 ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)3ll)))))));
                     
                     //#line 128 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int) ((i) + (((x10_int)1)))))
                {
                    
                    //#line 129 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_int ii = i;
                    
                    //#line 130 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10aux::nullCheck(x10aux::nullCheck(mc)->
                                        FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__set(
                      ((x10_long) (((x10_int) ((((x10_int) ((x10aux::nullCheck(mc)->
                                                               FMGL(nparticles)) + (x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                                                                      ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                                                     ((x10_long)3ll))))))))) + (i))))),
                      x10::lang::Runtime::evalAt<Particle* >(
                        x10::lang::Place::place(((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                               ((x10_long)2ll))))),
                        reinterpret_cast<x10::lang::Fun_0_0<Particle*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<Particle*> >(sizeof(MC_Comm__closure__10)))MC_Comm__closure__10(mc, sdispl, ii))),
                        x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))));
                }
            }
            
            //#line 133 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
            {
                for (
                     //#line 133 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int)0); ((i) < (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                 ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)2ll)))))));
                     
                     //#line 133 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int) ((i) + (((x10_int)1)))))
                {
                    
                    //#line 134 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_int ii = i;
                    
                    //#line 135 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10aux::nullCheck(x10aux::nullCheck(mc)->
                                        FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__set(
                      ((x10_long) (((x10_int) ((((x10_int) ((x10aux::nullCheck(mc)->
                                                               FMGL(nparticles)) + (x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                                                                      ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                                                     ((x10_long)2ll))))))))) + (i))))),
                      x10::lang::Runtime::evalAt<Particle* >(
                        x10::lang::Place::place(((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                               ((x10_long)3ll))))),
                        reinterpret_cast<x10::lang::Fun_0_0<Particle*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<Particle*> >(sizeof(MC_Comm__closure__12)))MC_Comm__closure__12(mc, sdispl, ii))),
                        x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))));
                }
            }
            
        }
        
        //#line 139 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(((x10_long) ((((x10_long) (x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)2ll))))) % x10aux::zeroCheck(((x10_long)2ll)))),
                                   ((x10_long)0ll)))) {
            
            //#line 140 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
            x10_int i;
            
            //#line 141 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
            {
                for (
                     //#line 141 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int)0); ((i) < (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                 ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)5ll)))))));
                     
                     //#line 141 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int) ((i) + (((x10_int)1)))))
                {
                    
                    //#line 142 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_int ii = i;
                    
                    //#line 143 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10aux::nullCheck(x10aux::nullCheck(mc)->
                                        FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__set(
                      ((x10_long) (((x10_int) ((((x10_int) ((x10aux::nullCheck(mc)->
                                                               FMGL(nparticles)) + (x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                                                                      ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                                                     ((x10_long)5ll))))))))) + (i))))),
                      x10::lang::Runtime::evalAt<Particle* >(
                        x10::lang::Place::place(((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                               ((x10_long)4ll))))),
                        reinterpret_cast<x10::lang::Fun_0_0<Particle*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<Particle*> >(sizeof(MC_Comm__closure__14)))MC_Comm__closure__14(mc, sdispl, ii))),
                        x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))));
                }
            }
            
            //#line 146 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.For_c
            {
                for (
                     //#line 146 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int)0); ((i) < (x10aux::nullCheck(myRecvCount)->x10::lang::Rail<x10_int >::__apply(
                                                 ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                ((x10_long)4ll)))))));
                     
                     //#line 146 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10LocalAssign_c
                     i = ((x10_int) ((i) + (((x10_int)1)))))
                {
                    
                    //#line 147 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
                    x10_int ii = i;
                    
                    //#line 148 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
                    x10aux::nullCheck(x10aux::nullCheck(mc)->
                                        FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__set(
                      ((x10_long) (((x10_int) ((((x10_int) ((x10aux::nullCheck(mc)->
                                                               FMGL(nparticles)) + (x10aux::nullCheck(displ)->x10::lang::Rail<x10_int >::__apply(
                                                                                      ((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                                                                     ((x10_long)4ll))))))))) + (i))))),
                      x10::lang::Runtime::evalAt<Particle* >(
                        x10::lang::Place::place(((x10_long) (x10aux::nullCheck(nabes)->x10::lang::Rail<x10_int >::__apply(
                                                               ((x10_long)5ll))))),
                        reinterpret_cast<x10::lang::Fun_0_0<Particle*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<Particle*> >(sizeof(MC_Comm__closure__16)))MC_Comm__closure__16(mc, sdispl, ii))),
                        x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL))));
                }
            }
            
        }
        
        //#line 152 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        MC* x55300 = mc;
        
        //#line 152 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10LocalDecl_c
        x10_int y55301 = MC_Cycle::isum(myRecvCount, x10aux::nullCheck(mc)->
                                                       FMGL(nprocs));
        
        //#line 152 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x55300)->FMGL(nparticles) = ((x10_int) ((x10aux::nullCheck(x55300)->
                                                                     FMGL(nparticles)) + (y55301)));
    }
    
    // captured environment
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        MC_Comm__closure__5* storage = x10aux::alloc<MC_Comm__closure__5>();
        buf.record_reference(storage);
        MC_Comm__closure__5* this_ = new (storage) MC_Comm__closure__5();
        return this_;
    }
    
    MC_Comm__closure__5() { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10:96-153";
    }

};

#endif // MC_COMM__CLOSURE__5_CLOSURE

//#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10MethodDecl_c
x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*
  MC_Comm::init(MC* mc, x10_int comm_choice) {
    
    //#line 8 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(comm_choice, ((void)(mc),MC::FMGL(MC_NONBLOCK__get)()))))
    {
        
        //#line 9 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
        return this->FMGL(nonblocking_exchange);
        
    } else 
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(comm_choice, ((void)(mc),MC::
                                              FMGL(MC_BLOCK__get)()))))
    {
        
        //#line 12 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
        return this->FMGL(blocking_exchange);
        
    } else {
        
        //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
        x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
          reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("Invalid communication choice...")));
        
        //#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Empty_c
        ;
        
        //#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
        if (!((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here),
                                     x10::lang::Place::FMGL(FIRST_PLACE__get)()))))
        {
            
            //#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10If_c
            if (true) {
                
                //#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Throw_c
                x10aux::throwException(x10aux::nullCheck(x10::lang::FailedDynamicCheckException::_make(x10aux::makeStringLit("!(here == x10.lang.Place.FIRST_PLACE)"))));
            }
            
        }
        
        //#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
        (x10aux::exitCode = (((x10_int)1)));
        
        //#line 16 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
        return x10aux::class_cast_unchecked<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL));
        
    }
    
}

//#line 20 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10FieldDecl_c

//#line 95 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10FieldDecl_c
/** 3D Cartesian ordered checkerboard blocking communication */

//#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10MethodDecl_c
MC_Comm* MC_Comm::MC_Comm____this__MC_Comm() {
    
    //#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10ConstructorDecl_c
void MC_Comm::_constructor() {
    
    //#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": polyglot.ast.Empty_c
    ;
    
    //#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.AssignPropertyCall_c
    
    //#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10Call_c
    this->MC_Comm::__fieldInitializers_MC_Comm();
}
MC_Comm* MC_Comm::_make() {
    MC_Comm* this_ = new (memset(x10aux::alloc<MC_Comm>(), 0, sizeof(MC_Comm))) MC_Comm();
    this_->_constructor();
    return this_;
}



//#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": x10.ast.X10MethodDecl_c
void MC_Comm::__fieldInitializers_MC_Comm() {
    
    //#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(nonblocking_exchange) = reinterpret_cast<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*>((new (x10aux::alloc<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*> >(sizeof(MC_Comm__closure__1)))MC_Comm__closure__1()));
    
    //#line 5 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Comm.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(blocking_exchange) = reinterpret_cast<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*>((new (x10aux::alloc<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*> >(sizeof(MC_Comm__closure__5)))MC_Comm__closure__5()));
}
const x10aux::serialization_id_t MC_Comm::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void MC_Comm::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(nonblocking_exchange));
    buf.write(this->FMGL(blocking_exchange));
    
}

x10::lang::Reference* MC_Comm::_deserializer(x10aux::deserialization_buffer& buf) {
    MC_Comm* this_ = new (memset(x10aux::alloc<MC_Comm>(), 0, sizeof(MC_Comm))) MC_Comm();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void MC_Comm::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(nonblocking_exchange) = buf.read<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*>();
    FMGL(blocking_exchange) = buf.read<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>*>();
}

x10aux::RuntimeType MC_Comm::rtt;
void MC_Comm::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("MC_Comm",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

x10::lang::VoidFun_0_0::itable<MC_Comm__closure__4>MC_Comm__closure__4::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__4::__apply, &MC_Comm__closure__4::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__4::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &MC_Comm__closure__4::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__4::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__4::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_SIMPLE_ASYNC);

x10::lang::VoidFun_0_0::itable<MC_Comm__closure__3>MC_Comm__closure__3::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__3::__apply, &MC_Comm__closure__3::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__3::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &MC_Comm__closure__3::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__3::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__3::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_SIMPLE_ASYNC);

x10::lang::VoidFun_0_0::itable<MC_Comm__closure__2>MC_Comm__closure__2::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__2::__apply, &MC_Comm__closure__2::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__2::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &MC_Comm__closure__2::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__2::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__2::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_SIMPLE_ASYNC);

x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>::itable<MC_Comm__closure__1>MC_Comm__closure__1::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__1::__apply, &MC_Comm__closure__1::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__1::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*> >, &MC_Comm__closure__1::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__1::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__1::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__7>MC_Comm__closure__7::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__7::__apply, &MC_Comm__closure__7::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__7::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >, &MC_Comm__closure__7::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__7::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__7::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__6>MC_Comm__closure__6::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__6::__apply, &MC_Comm__closure__6::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__6::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >, &MC_Comm__closure__6::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__6::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__6::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__9>MC_Comm__closure__9::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__9::__apply, &MC_Comm__closure__9::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__9::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >, &MC_Comm__closure__9::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__9::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__9::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__8>MC_Comm__closure__8::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__8::__apply, &MC_Comm__closure__8::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__8::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >, &MC_Comm__closure__8::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__8::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__8::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__11>MC_Comm__closure__11::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__11::__apply, &MC_Comm__closure__11::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__11::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >, &MC_Comm__closure__11::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__11::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__11::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__10>MC_Comm__closure__10::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__10::__apply, &MC_Comm__closure__10::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__10::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >, &MC_Comm__closure__10::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__10::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__10::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__13>MC_Comm__closure__13::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__13::__apply, &MC_Comm__closure__13::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__13::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >, &MC_Comm__closure__13::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__13::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__13::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__12>MC_Comm__closure__12::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__12::__apply, &MC_Comm__closure__12::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__12::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >, &MC_Comm__closure__12::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__12::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__12::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__15>MC_Comm__closure__15::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__15::__apply, &MC_Comm__closure__15::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__15::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >, &MC_Comm__closure__15::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__15::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__15::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__14>MC_Comm__closure__14::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__14::__apply, &MC_Comm__closure__14::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__14::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >, &MC_Comm__closure__14::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__14::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__14::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<x10_long>::itable<MC_Comm__closure__17>MC_Comm__closure__17::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__17::__apply, &MC_Comm__closure__17::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__17::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<x10_long> >, &MC_Comm__closure__17::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__17::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__17::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::Fun_0_0<Particle*>::itable<MC_Comm__closure__16>MC_Comm__closure__16::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__16::__apply, &MC_Comm__closure__16::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__16::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<Particle*> >, &MC_Comm__closure__16::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__16::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__16::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*>::itable<MC_Comm__closure__5>MC_Comm__closure__5::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &MC_Comm__closure__5::__apply, &MC_Comm__closure__5::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry MC_Comm__closure__5::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_3<MC*, x10::lang::Rail<x10_int >*, x10::lang::Rail<x10_int >*> >, &MC_Comm__closure__5::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t MC_Comm__closure__5::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Comm__closure__5::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

/* END of MC_Comm */
/*************************************************/
