/*************************************************/
/* START of Main */
#include <Main.h>

#include <x10/lang/Rail.h>
#include <x10/lang/String.h>
#include <x10/lang/Int.h>
#include <x10/lang/Boolean.h>
#include <x10/lang/Double.h>
#include <x10/lang/Long.h>
#include <x10/lang/Place.h>
#include <x10/io/Printer.h>
#include <x10/io/Console.h>
#include <x10/lang/Any.h>
#include <x10/lang/Runtime.h>
#include <x10/compiler/CompilerFlags.h>
#include <x10/lang/FailedDynamicCheckException.h>
#include <x10/lang/System.h>
#include <MC_Cycle.h>
#include <x10/io/File.h>
#include <x10/io/IOException.h>
#include <x10/io/ReaderIterator.h>
#include <x10/lang/Iterator.h>
#include <x10/lang/Iterable.h>
#include <x10/lang/PlaceGroup.h>
#include <x10/lang/PlaceLocalHandle.h>
#include <Particle.h>
#include <x10/lang/Fun_0_0.h>
#include <x10/lang/PlaceGroup__SimplePlaceGroup.h>
#include <x10/lang/VoidFun_0_0.h>
#include <MC.h>
#include <MC_Init.h>
#include <Grid.h>
#ifndef MAIN__CLOSURE__1_CLOSURE
#define MAIN__CLOSURE__1_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/Fun_0_0.h>
class Main__closure__1 : public x10::lang::Closure {
    public:
    
    static x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*>::itable<Main__closure__1> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    x10::lang::Rail<Particle* >* __apply() {
        
        //#line 141 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10Return_c
        return x10::lang::Rail<Particle* >::_make(((x10_long) (((x10_int) ((nps) * (x10::lang::DoubleNatives::toInt(((((x10_double) (((x10_long)1ll)))) + (bufsize)))))))));
        
    }
    
    // captured environment
    x10_int nps;
    x10_double bufsize;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->nps);
        buf.write(this->bufsize);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        Main__closure__1* storage = x10aux::alloc<Main__closure__1>();
        buf.record_reference(storage);
        x10_int that_nps = buf.read<x10_int>();
        x10_double that_bufsize = buf.read<x10_double>();
        Main__closure__1* this_ = new (storage) Main__closure__1(that_nps, that_bufsize);
        return this_;
    }
    
    Main__closure__1(x10_int nps, x10_double bufsize) : nps(nps), bufsize(bufsize) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*> >(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*> >(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10:141";
    }

};

#endif // MAIN__CLOSURE__1_CLOSURE
#ifndef MAIN__CLOSURE__2_CLOSURE
#define MAIN__CLOSURE__2_CLOSURE
#include <x10/lang/Closure.h>
#include <x10/lang/VoidFun_0_0.h>
class Main__closure__2 : public x10::lang::Closure {
    public:
    
    static x10::lang::VoidFun_0_0::itable<Main__closure__2> _itable;
    static x10aux::itable_entry _itables[2];
    
    virtual x10aux::itable_entry* _getITables() { return _itables; }
    
    // closure body
    void __apply() {
        
        //#line 150 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
        MC* mc;
        
        //#line 151 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(flag, ((x10_int)0)))) {
            
            //#line 152 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
            mc = MC::_make(s, bf, se, nps, lkg, bufsize, nprocs, ((x10_int) (x10::lang::Place::_make(x10aux::here)->
                                                                               FMGL(id))));
        } else {
            
            //#line 154 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
            mc = MC::_make(s, bf, se, np_array, leakage_array, bufsize,
                           nprocs, ((x10_int) (x10::lang::Place::_make(x10aux::here)->
                                                 FMGL(id))));
        }
        
        //#line 156 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(mc)->FMGL(particles) = particles;
        
        //#line 157 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
        (MC_Init::_make())->init(mc, domain);
        
        //#line 158 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
        Main::init_particles(mc, x10aux::nullCheck(mc)->FMGL(nparticles),
                             x10aux::nullCheck(x10aux::nullCheck(mc)->
                                                 FMGL(grid))->
                               FMGL(coords));
        
        //#line 159 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
        MC_Cycle* mc_cycle = MC_Cycle::_make(mc, ((void)(mc),MC::
                                                   FMGL(MC_NONBLOCK__get)()));
        
        //#line 160 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(mc_cycle)->cycle();
    }
    
    // captured environment
    x10_int flag;
    x10_int s;
    x10_int bf;
    x10_double se;
    x10_int nps;
    x10_double lkg;
    x10_double bufsize;
    x10_int nprocs;
    x10::lang::Rail<x10_int >* np_array;
    x10::lang::Rail<x10_double >* leakage_array;
    x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> particles;
    x10::lang::Rail<x10_double >* domain;
    
    x10aux::serialization_id_t _get_serialization_id() {
        return _serialization_id;
    }
    
    void _serialize_body(x10aux::serialization_buffer &buf) {
        buf.write(this->flag);
        buf.write(this->s);
        buf.write(this->bf);
        buf.write(this->se);
        buf.write(this->nps);
        buf.write(this->lkg);
        buf.write(this->bufsize);
        buf.write(this->nprocs);
        buf.write(this->np_array);
        buf.write(this->leakage_array);
        buf.write(this->particles);
        buf.write(this->domain);
    }
    
    template<class __T> static __T* _deserialize(x10aux::deserialization_buffer &buf) {
        Main__closure__2* storage = x10aux::alloc<Main__closure__2>();
        buf.record_reference(storage);
        x10_int that_flag = buf.read<x10_int>();
        x10_int that_s = buf.read<x10_int>();
        x10_int that_bf = buf.read<x10_int>();
        x10_double that_se = buf.read<x10_double>();
        x10_int that_nps = buf.read<x10_int>();
        x10_double that_lkg = buf.read<x10_double>();
        x10_double that_bufsize = buf.read<x10_double>();
        x10_int that_nprocs = buf.read<x10_int>();
        x10::lang::Rail<x10_int >* that_np_array = buf.read<x10::lang::Rail<x10_int >*>();
        x10::lang::Rail<x10_double >* that_leakage_array = buf.read<x10::lang::Rail<x10_double >*>();
        x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> that_particles = buf.read<x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> >();
        x10::lang::Rail<x10_double >* that_domain = buf.read<x10::lang::Rail<x10_double >*>();
        Main__closure__2* this_ = new (storage) Main__closure__2(that_flag, that_s, that_bf, that_se, that_nps, that_lkg, that_bufsize, that_nprocs, that_np_array, that_leakage_array, that_particles, that_domain);
        return this_;
    }
    
    Main__closure__2(x10_int flag, x10_int s, x10_int bf, x10_double se, x10_int nps, x10_double lkg, x10_double bufsize, x10_int nprocs, x10::lang::Rail<x10_int >* np_array, x10::lang::Rail<x10_double >* leakage_array, x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> particles, x10::lang::Rail<x10_double >* domain) : flag(flag), s(s), bf(bf), se(se), nps(nps), lkg(lkg), bufsize(bufsize), nprocs(nprocs), np_array(np_array), leakage_array(leakage_array), particles(particles), domain(domain) { }
    
    static const x10aux::serialization_id_t _serialization_id;
    
    static const x10aux::RuntimeType* getRTT() { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    virtual const x10aux::RuntimeType *_type() const { return x10aux::getRTT<x10::lang::VoidFun_0_0>(); }
    
    const char* toNativeString() {
        return "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10:149-161";
    }

};

#endif // MAIN__CLOSURE__2_CLOSURE

//#line 9 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10MethodDecl_c
void Main::main(x10::lang::Rail<x10::lang::String* >* args) {
    
    //#line 10 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int count = ((x10_int)0);
    
    //#line 11 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10While_c
    while (((((x10_int) ((count = ((x10_int) ((count) + (((x10_int)1))))) - (((x10_int)1))))) < (((x10_int)1))))
    {
        
        //#line 12 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
        Main::main2(args);
    }
    
}

//#line 16 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10MethodDecl_c
void Main::main2(x10::lang::Rail<x10::lang::String* >* args) {
    
    //#line 17 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_double >* domain = x10::lang::Rail<x10_double >::_make(((x10_long)2ll));
    
    //#line 18 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.For_c
    {
        x10_int i;
        for (
             //#line 18 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0); ((i) < (((x10_int)2))); 
                                                       //#line 18 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                                                       i = ((x10_int) ((i) + (((x10_int)1)))))
        {
            
            //#line 19 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(domain)->x10::lang::Rail<x10_double >::__set(
              ((x10_long) (i)), 1.0);
        }
    }
    
    //#line 21 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_double leakage = 0.5;
    
    //#line 22 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_double bufsize = 0.5;
    
    //#line 23 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int nprocs = ((x10_int) (((x10_long)x10aux::num_hosts)));
    
    //#line 24 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int np = ((x10_int)0);
    
    //#line 25 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int mype = ((x10_int)0);
    
    //#line 26 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int nstages = ((x10_int)0);
    
    //#line 27 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int strict = ((x10_int)-1);
    
    //#line 28 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int boundary_flag = ((x10_int)0);
    
    //#line 29 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_double seed = ((x10_double) (((x10_int)0)));
    
    //#line 30 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_int >* np_array = x10::lang::Rail<x10_int >::_make(((x10_long) (nprocs)));
    
    //#line 31 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_double >* leakage_array = x10::lang::Rail<x10_double >::_make(((x10_long) (nprocs)));
    
    //#line 32 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int read_flag = ((x10_int)0);
    
    //#line 33 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int nparticles = ((x10_int)0);
    
    //#line 35 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals((x10_long)(x10aux::nullCheck(args)->FMGL(size)),
                               ((x10_long)0ll)))) {
        
        //#line 36 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
        x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
          reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("Usage:\nIn native X10, mpirun [-np NUM_PROC] <executable> NPARTICLES GLOBAL_LEAKAGE [-f INPUT FILE] [-r] [-b BOUNDARY CONDITION] [-m STRICT]\n")));
        
        //#line 37 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
        x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
          reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("In managed X10, X10_NPLACES=NUM_PROC $X10_PATH/bin/x10 -x10rt mpi <Main> NPARTICLES GLOBAL_LEAKAGE [-f INPUT FILE] [-r] [-b BOUNDARY CONDITION] [-m STRICT]\n")));
        
        //#line 38 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Empty_c
        ;
        
        //#line 38 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
        if (!((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here),
                                     x10::lang::Place::FMGL(FIRST_PLACE__get)()))))
        {
            
            //#line 38 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
            if (true) {
                
                //#line 38 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Throw_c
                x10aux::throwException(x10aux::nullCheck(x10::lang::FailedDynamicCheckException::_make(x10aux::makeStringLit("!(here == x10.lang.Place.FIRST_PLACE)"))));
            }
            
        }
        
        //#line 38 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
        (x10aux::exitCode = (((x10_int)1)));
        
        //#line 39 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10Return_c
        return;
    }
    
    //#line 42 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int i;
    
    //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.For_c
    {
        for (
             //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_int)0); ((((x10_long) (i))) < (((x10_long) (((x10_long)(x10aux::nullCheck(args)->FMGL(size))) - (((x10_long)2ll))))));
             
             //#line 43 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_int) ((i) + (((x10_int)1))))) {
            
            //#line 44 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
            if ((((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                     ((x10_long) (i))))->indexOf(x10aux::makeStringLit("-m"))) >= (((x10_int)0))) ||
                (((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                     ((x10_long) (i))))->indexOf(x10aux::makeStringLit("-M"))) >= (((x10_int)0))))
            {
                
                //#line 46 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                x10::lang::String* mode;
                
                //#line 47 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                if ((x10aux::struct_equals((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                              ((x10_long) (i))))->length(),
                                           ((x10_int)2))))
                {
                    
                    //#line 48 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    mode = x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                             ((x10_long) (i = ((x10_int) ((i) + (((x10_int)1)))))));
                } else {
                    
                    //#line 50 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    mode = (x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                              ((x10_long) (i))))->substring(((x10_int)2));
                }
                
                //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                if (x10aux::equals(mode,reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("strict"))))
                {
                    
                    //#line 53 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    strict = ((x10_int)1);
                } else 
                //#line 54 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                if (x10aux::equals(mode,reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("nostrict"))))
                {
                    
                    //#line 55 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    strict = ((x10_int)0);
                }
                
                //#line 57 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Branch_c
                continue;
            }
            
            //#line 59 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
            if ((((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                     ((x10_long) (i))))->indexOf(x10aux::makeStringLit("-b"))) >= (((x10_int)0))) ||
                (((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                     ((x10_long) (i))))->indexOf(x10aux::makeStringLit("-B"))) >= (((x10_int)0))))
            {
                
                //#line 61 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                x10::lang::String* bndry_string;
                
                //#line 62 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                if ((x10aux::struct_equals((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                              ((x10_long) (i))))->length(),
                                           ((x10_int)2))))
                {
                    
                    //#line 63 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    bndry_string = x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                     ((x10_long) (i = ((x10_int) ((i) + (((x10_int)1)))))));
                } else {
                    
                    //#line 65 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    bndry_string = (x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                      ((x10_long) (i))))->substring(((x10_int)2));
                }
                
                //#line 67 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                if (x10aux::equals(bndry_string,reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("reflect"))))
                {
                    
                    //#line 68 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    boundary_flag = MC_Cycle::FMGL(BNDRY_REFLECT__get)();
                } else 
                //#line 69 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                if (x10aux::equals(bndry_string,reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("leak"))))
                {
                    
                    //#line 70 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    boundary_flag = MC_Cycle::FMGL(BNDRY_LEAK__get)();
                } else 
                //#line 71 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                if (x10aux::equals(bndry_string,reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("periodic"))))
                {
                    
                    //#line 72 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    boundary_flag = MC_Cycle::FMGL(BNDRY_PERIODIC__get)();
                }
                
                //#line 74 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Branch_c
                continue;
            }
            
            //#line 76 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
            if (x10aux::equals(x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                 ((x10_long) (i))),reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("-r"))) ||
                x10aux::equals(x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                 ((x10_long) (i))),reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("-R"))))
            {
                
                //#line 78 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                seed = 3333.0;
                
                //#line 79 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Branch_c
                continue;
            }
            
            //#line 81 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
            if ((((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                     ((x10_long) (i))))->indexOf(x10aux::makeStringLit("-f"))) >= (((x10_int)0))) ||
                (((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                     ((x10_long) (i))))->indexOf(x10aux::makeStringLit("-F"))) >= (((x10_int)0))))
            {
                
                //#line 83 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                x10::lang::String* ifile;
                
                //#line 84 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                if ((x10aux::struct_equals((x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                              ((x10_long) (i))))->length(),
                                           ((x10_int)2))))
                {
                    
                    //#line 85 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    ifile = x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                              ((x10_long) (i = ((x10_int) ((i) + (((x10_int)1)))))));
                } else {
                    
                    //#line 87 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    ifile = (x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                               ((x10_long) (i))))->substring(((x10_int)2));
                }
                
                //#line 89 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                x10::io::File* file;
                
                //#line 90 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Try_c
                try {
                    
                    //#line 91 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                    file = x10::io::File::_make(ifile);
                }
                catch (x10::lang::CheckedThrowable* __exc2) {
                    if (x10aux::instanceof<x10::io::IOException*>(__exc2)) {
                        x10::io::IOException* id__45107 =
                          static_cast<x10::io::IOException*>(__exc2);
                        {
                            
                            //#line 93 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                            x10::lang::RuntimeNatives::println(x10aux::to_string(reinterpret_cast<x10::lang::Any*>(x10aux::makeStringLit("Could not open file\n")))->c_str());
                            
                            //#line 94 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Empty_c
                            ;
                            
                            //#line 94 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                            if (!((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here),
                                                         x10::lang::Place::
                                                           FMGL(FIRST_PLACE__get)()))))
                            {
                                
                                //#line 94 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                                if (true) {
                                    
                                    //#line 94 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Throw_c
                                    x10aux::throwException(x10aux::nullCheck(x10::lang::FailedDynamicCheckException::_make(x10aux::makeStringLit("!(here == x10.lang.Place.FIRST_PLACE)"))));
                                }
                                
                            }
                            
                            //#line 94 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                            (x10aux::exitCode = (((x10_int)1)));
                            
                            //#line 95 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10Return_c
                            return;
                        }
                    } else
                    throw;
                }
                
                //#line 97 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
                  reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("reading input file: "), ifile), x10aux::makeStringLit("\n"))));
                
                //#line 99 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Try_c
                try {
                    
                    //#line 100 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                    x10::io::ReaderIterator<x10::lang::String*>* input =
                      x10aux::nullCheck(file)->lines();
                    
                    //#line 101 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                    if ((!x10aux::struct_equals(x10::lang::IntNatives::parseInt(x10aux::nullCheck(input)->next()),
                                                nprocs)))
                    {
                        
                        //#line 102 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                        x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
                          reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("Error reading input file: "), ifile), x10aux::makeStringLit(". header value != nprocs\n"))));
                        
                        //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Empty_c
                        ;
                        
                        //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                        if (!((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here),
                                                     x10::lang::Place::
                                                       FMGL(FIRST_PLACE__get)()))))
                        {
                            
                            //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                            if (true) {
                                
                                //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Throw_c
                                x10aux::throwException(x10aux::nullCheck(x10::lang::FailedDynamicCheckException::_make(x10aux::makeStringLit("!(here == x10.lang.Place.FIRST_PLACE)"))));
                            }
                            
                        }
                        
                        //#line 105 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                        (x10aux::exitCode = (((x10_int)1)));
                        
                        //#line 106 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10Return_c
                        return;
                    }
                    
                    //#line 108 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.For_c
                    {
                        x10_int j;
                        for (
                             //#line 108 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                             j = ((x10_int)0); ((j) < (nprocs));
                             
                             //#line 108 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                             j = ((x10_int) ((j) + (((x10_int)1)))))
                        {
                            
                            //#line 109 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                            if (!(x10aux::nullCheck(input)->hasNext()))
                            {
                                
                                //#line 110 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                                x10::io::Console::FMGL(OUT__get)()->x10::io::Printer::println(
                                  reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10::lang::String::__plus(x10aux::makeStringLit("Error reading input file: "), ifile), x10aux::makeStringLit(". unexpected EOF encountered\n"))));
                                
                                //#line 113 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Empty_c
                                ;
                                
                                //#line 113 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                                if (!((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here),
                                                             x10::lang::Place::
                                                               FMGL(FIRST_PLACE__get)()))))
                                {
                                    
                                    //#line 113 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                                    if (true) {
                                        
                                        //#line 113 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Throw_c
                                        x10aux::throwException(x10aux::nullCheck(x10::lang::FailedDynamicCheckException::_make(x10aux::makeStringLit("!(here == x10.lang.Place.FIRST_PLACE)"))));
                                    }
                                    
                                }
                                
                                //#line 113 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                                (x10aux::exitCode = (((x10_int)1)));
                                
                                //#line 114 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10Return_c
                                return;
                            }
                            
                            //#line 116 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                            x10::lang::String* line = x10aux::nullCheck(input)->next();
                            
                            //#line 117 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                            x10::lang::Rail<x10::lang::String* >* token =
                              x10::lang::StringHelper::split(x10aux::makeStringLit(" "), line);
                            
                            //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.For_c
                            {
                                x10::lang::Iterator<x10::lang::Place>* pl54850;
                                for (
                                     //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                                     pl54850 = x10aux::nullCheck(x10::lang::Place::places())->iterator();
                                     x10::lang::Iterator<x10::lang::Place>::hasNext(x10aux::nullCheck(pl54850));
                                     ) {
                                    
                                    //#line 118 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
                                    x10::lang::Place pl =
                                      x10::lang::Iterator<x10::lang::Place>::next(x10aux::nullCheck(pl54850));
                                    
                                    //#line 119 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                                    x10aux::nullCheck(np_array)->x10::lang::Rail<x10_int >::__set(
                                      pl->FMGL(id), x10::lang::IntNatives::parseInt(x10aux::nullCheck(token)->x10::lang::Rail<x10::lang::String* >::__apply(
                                                                                      ((x10_long) (((x10_int)0))))));
                                    
                                    //#line 120 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                                    x10aux::nullCheck(leakage_array)->x10::lang::Rail<x10_double >::__set(
                                      pl->FMGL(id), x10::lang::DoubleNatives::parseDouble(x10aux::nullCheck(token)->x10::lang::Rail<x10::lang::String* >::__apply(
                                                                                            ((x10_long) (((x10_int)1))))));
                                }
                            }
                            
                            //#line 122 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                            read_flag = ((x10_int)1);
                        }
                    }
                    
                }
                catch (x10::lang::CheckedThrowable* __exc3) {
                    if (x10aux::instanceof<x10::io::IOException*>(__exc3)) {
                        x10::io::IOException* id__45108 =
                          static_cast<x10::io::IOException*>(__exc3);
                        {
                            
                            //#line 126 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Empty_c
                            ;
                            
                            //#line 126 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                            if (!((x10aux::struct_equals(x10::lang::Place::_make(x10aux::here),
                                                         x10::lang::Place::
                                                           FMGL(FIRST_PLACE__get)()))))
                            {
                                
                                //#line 126 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
                                if (true) {
                                    
                                    //#line 126 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Throw_c
                                    x10aux::throwException(x10aux::nullCheck(x10::lang::FailedDynamicCheckException::_make(x10aux::makeStringLit("!(here == x10.lang.Place.FIRST_PLACE)"))));
                                }
                                
                            }
                            
                            //#line 126 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                            (x10aux::exitCode = (((x10_int)1)));
                            
                            //#line 127 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
                            x10::lang::RuntimeNatives::println(x10aux::to_string(reinterpret_cast<x10::lang::Any*>(x10::lang::String::__plus(x10aux::makeStringLit("Exception at "), x10::lang::Place::_make(x10aux::here))))->c_str());
                            
                            //#line 128 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10Return_c
                            return;
                        }
                    } else
                    throw;
                }
            }
            
        }
    }
    
    //#line 135 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(read_flag, ((x10_int)0))))
    {
        
        //#line 136 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
        nparticles = x10::lang::IntNatives::parseInt(x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                                       ((x10_long) (i))));
        
        //#line 137 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
        leakage = x10::lang::DoubleNatives::parseDouble(x10aux::nullCheck(args)->x10::lang::Rail<x10::lang::String* >::__apply(
                                                          ((x10_long) (((x10_int) ((i) + (((x10_int)1))))))));
    }
    
    //#line 140 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int nps = nparticles;
    
    //#line 141 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*> particles =
      x10::lang::PlaceLocalHandle<void>::make<x10::lang::Rail<Particle* >* >(
        x10::lang::Place::places(), reinterpret_cast<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*>*>((new (x10aux::alloc<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*> >(sizeof(Main__closure__1)))Main__closure__1(nps, bufsize))));
    
    //#line 143 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int s = strict;
    
    //#line 144 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int bf = boundary_flag;
    
    //#line 145 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_double se = seed;
    
    //#line 146 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_int flag = read_flag;
    
    //#line 147 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_double lkg = leakage;
    
    //#line 149 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
    x10::lang::PlaceGroup::FMGL(WORLD__get)()->broadcastFlat(
      reinterpret_cast<x10::lang::VoidFun_0_0*>((new (x10aux::alloc<x10::lang::VoidFun_0_0>(sizeof(Main__closure__2)))Main__closure__2(flag, s, bf, se, nps, lkg, bufsize, nprocs, np_array, leakage_array, particles, domain))));
}

//#line 164 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10MethodDecl_c
void Main::init_particles(MC* mc, x10_int np, x10::lang::Rail<x10_double >* mycoords) {
    
    //#line 165 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_double xc = ((((x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_double >::__apply(
                          ((x10_long)0ll))) + (x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_double >::__apply(
                                                 ((x10_long)1ll))))) / (((x10_double) (((x10_long)2ll)))));
    
    //#line 166 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_double yc = ((((x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_double >::__apply(
                          ((x10_long)2ll))) + (x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_double >::__apply(
                                                 ((x10_long)3ll))))) / (((x10_double) (((x10_long)2ll)))));
    
    //#line 167 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
    x10_double zc = ((((x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_double >::__apply(
                          ((x10_long)4ll))) + (x10aux::nullCheck(mycoords)->x10::lang::Rail<x10_double >::__apply(
                                                 ((x10_long)5ll))))) / (((x10_double) (((x10_long)2ll)))));
    
    //#line 169 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.For_c
    {
        x10_int i;
        for (
             //#line 169 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0); ((i) < (np)); 
                                             //#line 169 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10LocalAssign_c
                                             i = ((x10_int) ((i) + (((x10_int)1)))))
        {
            
            //#line 171 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(mc)->FMGL(particles)->x10::lang::PlaceLocalHandle<x10::lang::Rail<Particle* >*>::__apply())->x10::lang::Rail<Particle* >::__set(
              ((x10_long) (i)), Particle::_make(xc, yc, zc,
                                                0.0, 0.0,
                                                ((x10_int)0),
                                                x10aux::nullCheck(mc)->
                                                  FMGL(mype)));
        }
    }
    
}

//#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10MethodDecl_c
Main* Main::Main____this__Main() {
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10ConstructorDecl_c
void Main::_constructor() {
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": polyglot.ast.Empty_c
    ;
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.AssignPropertyCall_c
    
    //#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": Eval of x10.ast.X10Call_c
    this->Main::__fieldInitializers_Main();
}
Main* Main::_make() {
    Main* this_ = new (memset(x10aux::alloc<Main>(), 0, sizeof(Main))) Main();
    this_->_constructor();
    return this_;
}



//#line 7 "/home/horie/x10dt/x10dt/workspace/MCCK/src/Main.x10": x10.ast.X10MethodDecl_c
void Main::__fieldInitializers_Main() {
 
}
const x10aux::serialization_id_t Main::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(Main::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void Main::_serialize_body(x10aux::serialization_buffer& buf) {
    
}

x10::lang::Reference* Main::_deserializer(x10aux::deserialization_buffer& buf) {
    Main* this_ = new (memset(x10aux::alloc<Main>(), 0, sizeof(Main))) Main();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void Main::_deserialize_body(x10aux::deserialization_buffer& buf) {
    
}

x10aux::RuntimeType Main::rtt;
void Main::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("Main",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*>::itable<Main__closure__1>Main__closure__1::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &Main__closure__1::__apply, &Main__closure__1::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry Main__closure__1::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::Fun_0_0<x10::lang::Rail<Particle* >*> >, &Main__closure__1::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t Main__closure__1::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(Main__closure__1::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

x10::lang::VoidFun_0_0::itable<Main__closure__2>Main__closure__2::_itable(&x10::lang::Reference::equals, &x10::lang::Closure::hashCode, &Main__closure__2::__apply, &Main__closure__2::toString, &x10::lang::Closure::typeName);
x10aux::itable_entry Main__closure__2::_itables[2] = {x10aux::itable_entry(&x10aux::getRTT<x10::lang::VoidFun_0_0>, &Main__closure__2::_itable),x10aux::itable_entry(NULL, NULL)};

const x10aux::serialization_id_t Main__closure__2::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(Main__closure__2::_deserialize<x10::lang::Reference>,x10aux::CLOSURE_KIND_NOT_ASYNC);

/* END of Main */
/*************************************************/
