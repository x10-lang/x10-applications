/*************************************************/
/* START of Hello */
#include <Hello.h>

#include <x10/lang/Rail.h>
#include <x10/lang/String.h>
#include <x10/lang/Runtime.h>
#include <x10/lang/FinishState.h>
#include <x10/lang/CheckedThrowable.h>
#include <x10/lang/Iterator.h>
#include <x10/lang/Place.h>
#include <x10/lang/Iterable.h>
#include <x10/lang/PlaceGroup.h>
#include <x10/lang/Boolean.h>
#include <x10/lang/VoidFun_0_0.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>
#include <x10/lang/Error.h>
#include <x10/lang/Exception.h>
#include <x10/compiler/AsyncClosure.h>
#include <x10/lang/Runtime__Profile.h>
#include <x10/compiler/Finalization.h>
#include <x10/compiler/Abort.h>
#include <x10/compiler/CompilerFlags.h>
#ifndef HELLO__CLOSURE__1_CLOSURE
#define HELLO__CLOSURE__1_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
class Hello__closure__1 : public x10::lang::Closure {
    public:
    
    static x10::lang::VoidFun_0_0::itable<Hello__closure__1> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Try_c
        try {
            
            //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": Eval of x10.ast.X10Call_c
            x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
              reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10aux::makeStringLit("Hello World from place "), p->
                                                                                                                              FMGL(id))));
        }
        catch (x10::lang::CheckedThrowable* __exc57) {
            if (x10aux::instanceof<x10::lang::Error*>(__exc57)) {
                x10::lang::Error* __lowerer__var__0__ = static_cast<x10::lang::Error*>(__exc57);
                {
                    
                    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(__lowerer__var__0__));
                }
            } else
            if (true) {
                x10::lang::CheckedThrowable* __lowerer__var__1__ =
                  static_cast<x10::lang::CheckedThrowable*>(__exc57);
                {
                    
                    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::ensureException(
                                                               reinterpret_cast<x10::lang::CheckedThrowable*>(__lowerer__var__1__))));
                }
            } else
            throw;
        }
    }
    
    // captured environment
    x10::lang::Place p;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->p);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        Hello__closure__1* storage = x10aux::alloc<Hello__closure__1>();
        buf.record_reference(storage);
        x10::lang::Place that_p = buf.read<x10::lang::Place>();
        Hello__closure__1* this_ = new (storage) Hello__closure__1(that_p);
        return this_;
    }
    
    Hello__closure__1(x10::lang::Place p) : p(p) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10:11";
    }

};

#endif // HELLO__CLOSURE__1_CLOSURE

//#line 9 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10MethodDecl_c
void Hello::main(x10::lang::Rail<x10::lang::String* >* id__45187) {
    {
        
        //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": Eval of x10.ast.X10Call_c
        x10::lang::Runtime::ensureNotInAtomic();
        
        //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10LocalDecl_c
        x10::lang::FinishState* x10____var1 = x10::lang::Runtime::startFinish();
        {
            
            //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10LocalDecl_c
            x10::lang::CheckedThrowable* throwable56373 = x10aux::class_cast_unchecked<x10::lang::CheckedThrowable*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL));
            
            //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Try_c
            try {
                
                //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Try_c
                try {
                    {
                        
                        //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.For_c
                        {
                            x10::lang::Iterator<x10::lang::Place>* p56366;
                            for (
                                 //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10LocalDecl_c
                                 p56366 = x10aux::nullCheck(x10::lang::Place::places())->iterator();
                                 x10::lang::Iterator<x10::lang::Place>::hasNext(x10aux::nullCheck(p56366));
                                 ) {
                                
                                //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10LocalDecl_c
                                x10::lang::Place p = x10::lang::Iterator<x10::lang::Place>::next(x10aux::nullCheck(p56366));
                                
                                //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": Eval of x10.ast.X10Call_c
                                x10::lang::Runtime::runAsync(
                                  p, reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(Hello__closure__1)))Hello__closure__1(p))),
                                  x10aux::class_cast_unchecked<x10::lang::Runtime__Profile*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
                            }
                        }
                        
                    }
                }
                catch (x10::lang::CheckedThrowable* __exc58) {
                    if (true) {
                        x10::lang::CheckedThrowable* __lowerer__var__0__ =
                          static_cast<x10::lang::CheckedThrowable*>(__exc58);
                        {
                            
                            //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": Eval of x10.ast.X10Call_c
                            x10::lang::Runtime::pushException(
                              __lowerer__var__0__);
                            
                            //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Throw_c
                            x10aux::throwException(x10aux::nullCheck(x10::lang::Exception::_make()));
                        }
                    } else
                    throw;
                }
                
                //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": Eval of x10.ast.X10Call_c
                x10::compiler::Finalization::plausibleThrow();
            }
            catch (x10::lang::CheckedThrowable* __exc59) {
                if (true) {
                    x10::lang::CheckedThrowable* formal56374 =
                      static_cast<x10::lang::CheckedThrowable*>(__exc59);
                    {
                        
                        //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": Eval of x10.ast.X10LocalAssign_c
                        throwable56373 = formal56374;
                    }
                } else
                throw;
            }
            
            //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10If_c
            if ((!x10aux::struct_equals(reinterpret_cast<x10::lang::CheckedThrowable*>(X10_NULL),
                                        throwable56373)))
            {
                
                //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10If_c
                if (x10aux::instanceof<x10::compiler::Abort*>(throwable56373))
                {
                    
                    //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(throwable56373));
                }
                
            }
            
            //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10If_c
            if (true) {
                
                //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": Eval of x10.ast.X10Call_c
                x10::lang::Runtime::stopFinish(x10____var1);
            }
            
            //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10If_c
            if ((!x10aux::struct_equals(reinterpret_cast<x10::lang::CheckedThrowable*>(X10_NULL),
                                        throwable56373)))
            {
                
                //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10If_c
                if (!(x10aux::instanceof<x10::compiler::Finalization*>(throwable56373)))
                {
                    
                    //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Throw_c
                    x10aux::throwException(x10aux::nullCheck(throwable56373));
                }
                
            }
            
        }
    }
}

//#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10MethodDecl_c
Hello* Hello::Hello____this__Hello() {
    
    //#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10ConstructorDecl_c
void Hello::_constructor() {
    
    //#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": polyglot.ast.Empty_c
    ;
    
    //#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.AssignPropertyCall_c
    
    //#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": Eval of x10.ast.X10Call_c
    this->Hello::__fieldInitializers_Hello();
}
Hello* Hello::_make() {
    Hello* this_ = new (memset(x10aux::alloc<Hello>(), 0, sizeof(Hello))) Hello();
    this_->_constructor();
    return this_;
}



//#line 4 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Hello.x10": x10.ast.X10MethodDecl_c
void Hello::__fieldInitializers_Hello() {
 
}
const x10aux::serialization_id_t Hello::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(Hello::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void Hello::_serialize_body(x10aux::serialization_buffer& buf) {
    
}

x10::lang::Reference* Hello::_deserializer(x10aux::deserialization_buffer& buf) {
    Hello* this_ = new (memset(x10aux::alloc<Hello>(), 0, sizeof(Hello))) Hello();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void Hello::_deserialize_body(x10aux::deserialization_buffer& buf) {
    
}

x10aux::RuntimeType Hello::rtt;
void Hello::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("Hello",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

x10::lang::VoidFun_0_0::itable<Hello__closure__1>Hello__closure__1::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &Hello__closure__1::__apply, &Hello__closure__1::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry Hello__closure__1::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &Hello__closure__1::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t Hello__closure__1::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(Hello__closure__1::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_SIMPLE_ASYNC);

/* END of Hello */
/*************************************************/
