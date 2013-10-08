/*************************************************/
/* START of MC_Init */
#include <MC_Init.h>

#include <x10/lang/Double.h>
#include <x10/lang/Int.h>
#include <MC.h>
#include <x10/lang/Rail.h>
#include <x10/lang/Long.h>
#include <x10/lang/System.h>
#include <x10/lang/Place.h>
#include <x10/lang/Boolean.h>
#include <Grid.h>
#include <x10/lang/LongRange.h>
#include <x10/regionarray/Region.h>
#include <x10/regionarray/Array.h>
#include <x10/lang/Runtime.h>

//#line 15 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10FieldDecl_c

//#line 17 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10FieldDecl_c

//#line 31 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10MethodDecl_c
void MC_Init::init(MC* mcobj, x10::lang::Rail<x10_double >* size) {
    
    //#line 32 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(mc) = mcobj;
    
    //#line 33 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    this->setup_grid();
    
    //#line 37 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this->FMGL(mc))->FMGL(seed) = ((x10_double) (((x10_long) ((x10::lang::System::currentTimeMillis()) * (((x10_long) (x10aux::nullCheck(this->
                                                                                                                                                             FMGL(mc))->
                                                                                                                                           FMGL(mype))))))));
}

//#line 40 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10FieldDecl_c

//#line 41 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10FieldDecl_c

//#line 47 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10MethodDecl_c
void MC_Init::fact(x10_int value, x10_int div) {
    
    //#line 48 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(value, ((x10_int)0))) || (x10aux::struct_equals(value,
                                                                               ((x10_int)1))))
    {
        
        //#line 49 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10Return_c
        return;
    } else 
    //#line 51 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(((x10_int) ((value) % x10aux::zeroCheck(div))),
                               ((x10_int)0)))) {
        
        //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
        x10::lang::Rail<x10_int >* x55783 = this->FMGL(factorized);
        
        //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
        x10_long y55784 = ((x10_long) (div));
        
        //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.Empty_c
        ;
        
        //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
        x10_int ret55785;
        
        //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
        x10_int r55782 = ((x10_int) ((x10aux::nullCheck(x55783)->x10::lang::Rail<x10_int >::__apply(
                                        y55784)) + (((x10_int)1))));
        
        //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x55783)->x10::lang::Rail<x10_int >::__set(
          y55784, r55782);
        
        //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
        ret55785 = r55782;
        
        //#line 52 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Local_c
        ret55785;
        
        //#line 53 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
        MC_Init* x55786 = this;
        
        //#line 53 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.Empty_c
        ;
        
        //#line 53 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
        x10aux::nullCheck(x55786)->FMGL(counter) = ((x10_int) ((x10aux::nullCheck(x55786)->
                                                                  FMGL(counter)) + (((x10_int)1))));
        
        //#line 54 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        this->fact(((x10_int) ((value) / x10aux::zeroCheck(div))),
                   div);
        
        //#line 55 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10Return_c
        return;
    } else {
        
        //#line 58 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        this->fact(value, ((x10_int) ((div) + (((x10_int)1)))));
    }
    
}

//#line 61 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10MethodDecl_c
x10::lang::Rail<x10_int >* MC_Init::getDim() {
    
    //#line 62 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    this->fact(((x10_int) (((x10_long)x10aux::num_hosts))),
               ((x10_int)2));
    
    //#line 63 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_int >* packed = x10::lang::Rail<x10_int >::_make(((x10_long) (this->
                                                                                        FMGL(counter))));
    
    //#line 65 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10_int index = ((x10_int)0);
    
    //#line 66 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
    {
        x10_int i;
        for (
             //#line 66 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0); ((((x10_long) (i))) < ((x10_long)(x10aux::nullCheck(this->
                                                                                     FMGL(factorized))->FMGL(size))));
             
             //#line 66 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_int) ((i) + (((x10_int)1))))) {
            
            //#line 67 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
            {
                x10_int j;
                for (
                     //#line 67 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
                     j = ((x10_int)0); ((j) < (x10aux::nullCheck(this->
                                                                   FMGL(factorized))->x10::lang::Rail<x10_int >::__apply(
                                                 ((x10_long) (i)))));
                     
                     //#line 67 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                     j = ((x10_int) ((j) + (((x10_int)1)))))
                {
                    
                    //#line 68 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
                    x10aux::nullCheck(packed)->x10::lang::Rail<x10_int >::__set(
                      ((x10_long) (((x10_int) ((index = ((x10_int) ((index) + (((x10_int)1))))) - (((x10_int)1)))))),
                      i);
                }
            }
            
        }
    }
    
    //#line 71 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_int >* dim = x10::lang::Rail<x10_int >::_make(((x10_long) (((x10_int)3))));
    
    //#line 72 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
    index = ((x10_int)0);
    
    //#line 73 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if (((this->FMGL(counter)) < (((x10_int)3)))) {
        
        //#line 74 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 74 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)0); ((((x10_long) (i))) < ((x10_long)(x10aux::nullCheck(packed)->FMGL(size))));
                 
                 //#line 74 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_int) ((i) + (((x10_int)1))))) {
                
                //#line 75 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (((x10_int) ((index = ((x10_int) ((index) + (((x10_int)1))))) - (((x10_int)1)))))),
                  x10aux::nullCheck(packed)->x10::lang::Rail<x10_int >::__apply(
                    ((x10_long) (i))));
            }
        }
        
        //#line 77 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 77 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
                 i = index; ((i) < (((x10_int)3))); 
                                                    //#line 77 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                                                    i = ((x10_int) ((i) + (((x10_int)1)))))
            {
                
                //#line 78 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (i)), ((x10_int)1));
            }
        }
        
    } else 
    //#line 80 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(this->FMGL(counter), ((x10_int)3))))
    {
        
        //#line 81 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
        dim = packed;
    } else 
    //#line 83 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if (((this->FMGL(counter)) > (((x10_int)3)))) {
        
        //#line 84 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
        x10_int begin = ((x10_int)0);
        
        //#line 85 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
        x10_int end = ((x10_int) ((this->FMGL(counter)) - (((x10_int)1))));
        
        //#line 87 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10While_c
        while ((!x10aux::struct_equals(this->FMGL(counter),
                                       ((x10_int)3)))) {
            
            //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
            x10::lang::Rail<x10_int >* x55788 = packed;
            
            //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
            x10_long y55789 = ((x10_long) (((x10_int) ((begin =
              ((x10_int) ((begin) + (((x10_int)1))))) - (((x10_int)1))))));
            
            //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
            x10_int z55790 = x10aux::nullCheck(packed)->x10::lang::Rail<x10_int >::__apply(
                               ((x10_long) (((x10_int) ((end =
                                 ((x10_int) ((end) - (((x10_int)1))))) + (((x10_int)1)))))));
            
            //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
            x10_int ret55791;
            
            //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
            x10_int r55787 = ((x10_int) ((x10aux::nullCheck(x55788)->x10::lang::Rail<x10_int >::__apply(
                                            y55789)) * (z55790)));
            
            //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x55788)->x10::lang::Rail<x10_int >::__set(
              y55789, r55787);
            
            //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
            ret55791 = r55787;
            
            //#line 88 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Local_c
            ret55791;
            
            //#line 89 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
            if (((begin) >= (end))) {
                
                //#line 90 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                begin = ((x10_int)0);
                
                //#line 91 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                end = ((x10_int) ((this->FMGL(counter)) - (((x10_int)1))));
            }
            
            //#line 93 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
            MC_Init* x55792 = this;
            
            //#line 93 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.Empty_c
            ;
            
            //#line 93 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
            x10aux::nullCheck(x55792)->FMGL(counter) = ((x10_int) ((x10aux::nullCheck(x55792)->
                                                                      FMGL(counter)) - (((x10_int)1))));
        }
        
        //#line 95 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
        {
            x10_int i;
            for (
                 //#line 95 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
                 i = ((x10_int)0); ((i) < (((x10_int)3)));
                 
                 //#line 95 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                 i = ((x10_int) ((i) + (((x10_int)1))))) {
                
                //#line 96 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
                x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__set(
                  ((x10_long) (i)), x10aux::nullCheck(packed)->x10::lang::Rail<x10_int >::__apply(
                                      ((x10_long) (i))));
            }
        }
        
    }
    
    //#line 99 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10Return_c
    return dim;
    
}

//#line 102 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10MethodDecl_c
void MC_Init::setup_grid() {
    
    //#line 103 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this->FMGL(mc))->FMGL(grid) = Grid::_make();
    
    //#line 104 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10::lang::Rail<x10_int >* dim = this->getDim();
    
    //#line 106 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10_int dx;
    
    //#line 107 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10_int dy;
    
    //#line 108 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10_int dz;
    
    //#line 110 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10::lang::LongRange states1 = x10::lang::LongRange::_make(((x10_long)0ll), ((x10_long) (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                                                               ((x10_long)0ll)))));
    
    //#line 111 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10::lang::LongRange states2 = x10::lang::LongRange::_make(((x10_long)0ll), ((x10_long) (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                                                               ((x10_long)1ll)))));
    
    //#line 112 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10::lang::LongRange states3 = x10::lang::LongRange::_make(((x10_long)0ll), ((x10_long) (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                                                               ((x10_long)2ll)))));
    
    //#line 113 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10::regionarray::Region* s = x10::regionarray::Region::make(
                                    states1, states2, states3);
    
    //#line 115 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
    x10aux::nullCheck(this->FMGL(mc))->FMGL(matrix) = x10::regionarray::Array<x10_int>::_make(s);
    
    //#line 117 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10::lang::Place p = x10::lang::Place::FMGL(FIRST_PLACE__get)();
    
    //#line 119 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10_int xh = ((x10_int)-1);
    
    //#line 120 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10_int yh = ((x10_int)-1);
    
    //#line 121 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
    x10_int zh = ((x10_int)-1);
    
    //#line 129 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
    {
        x10_int i;
        for (
             //#line 129 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0); ((i) < (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                         ((x10_long)0ll))));
             
             //#line 129 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_int) ((i) + (((x10_int)1))))) {
            
            //#line 130 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
            {
                x10_int j;
                for (
                     //#line 130 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
                     j = ((x10_int)0); ((j) < (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                 ((x10_long)1ll))));
                     
                     //#line 130 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                     j = ((x10_int) ((j) + (((x10_int)1)))))
                {
                    
                    //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
                    {
                        x10_int k;
                        for (
                             //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
                             k = ((x10_int)0); ((k) < (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                         ((x10_long)2ll))));
                             
                             //#line 131 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                             k = ((x10_int) ((k) + (((x10_int)1)))))
                        {
                            
                            //#line 132 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
                            if ((x10aux::struct_equals(i,
                                                       ((x10_int)0))) &&
                                (x10aux::struct_equals(j,
                                                       ((x10_int)0))) &&
                                (x10aux::struct_equals(k,
                                                       ((x10_int)0))))
                            {
                                
                                //#line 133 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                                p = x10::lang::Place::FMGL(FIRST_PLACE__get)();
                            }
                            
                            //#line 135 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
                            x10aux::nullCheck(x10aux::nullCheck(this->
                                                                  FMGL(mc))->
                                                FMGL(matrix))->x10::regionarray::Array<x10_int>::__set(
                              ((x10_long) (i)), ((x10_long) (j)),
                              ((x10_long) (k)), ((x10_int) (p->x10::lang::Place::id())));
                            
                            //#line 138 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
                            if ((x10aux::struct_equals(p->x10::lang::Place::id(),
                                                       x10::lang::Place::_make(x10aux::here)->
                                                         FMGL(id))))
                            {
                                
                                //#line 139 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                                xh = i;
                                
                                //#line 140 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                                yh = j;
                                
                                //#line 141 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                                zh = k;
                            }
                            
                            //#line 143 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
                            p = p->x10::lang::Place::next();
                        }
                    }
                    
                }
            }
            
        }
    }
    
    //#line 151 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(proc_coords))->x10::lang::Rail<x10_int >::__set(
      ((x10_long) (((x10_int)0))), xh);
    
    //#line 152 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(proc_coords))->x10::lang::Rail<x10_int >::__set(
      ((x10_long) (((x10_int)1))), yh);
    
    //#line 153 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(proc_coords))->x10::lang::Rail<x10_int >::__set(
      ((x10_long) (((x10_int)2))), zh);
    
    //#line 155 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(xh, ((x10_int)0)))) {
        
        //#line 156 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)0))), ((x10_int)-1));
        
        //#line 157 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(xh, ((x10_int) ((x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                      ((x10_long) (((x10_int)0))))) - (((x10_int)1)))))))
        {
            
            //#line 158 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(grid))->
                                FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
              ((x10_long) (((x10_int)1))), ((x10_int)-1));
        } else {
            
            //#line 160 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(grid))->
                                FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
              ((x10_long) (((x10_int)1))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                 FMGL(mc))->
                                                               FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                             ((x10_long) (((x10_int) ((xh) + (((x10_int)1)))))),
                                             ((x10_long) (yh)),
                                             ((x10_long) (zh))));
        }
        
    } else 
    //#line 164 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(xh, ((x10_int) ((x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                  ((x10_long) (((x10_int)0))))) - (((x10_int)1)))))))
    {
        
        //#line 165 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)0))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (((x10_int) ((xh) - (((x10_int)1)))))),
                                         ((x10_long) (yh)),
                                         ((x10_long) (zh))));
        
        //#line 166 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)1))), ((x10_int)-1));
    } else {
        
        //#line 169 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)0))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (((x10_int) ((xh) - (((x10_int)1)))))),
                                         ((x10_long) (yh)),
                                         ((x10_long) (zh))));
        
        //#line 170 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)1))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (((x10_int) ((xh) + (((x10_int)1)))))),
                                         ((x10_long) (yh)),
                                         ((x10_long) (zh))));
    }
    
    //#line 173 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(yh, ((x10_int)0)))) {
        
        //#line 174 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)2))), ((x10_int)-1));
        
        //#line 176 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(yh, ((x10_int) ((x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                      ((x10_long) (((x10_int)1))))) - (((x10_int)1)))))))
        {
            
            //#line 177 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(grid))->
                                FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
              ((x10_long) (((x10_int)3))), ((x10_int)-1));
        } else {
            
            //#line 179 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(grid))->
                                FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
              ((x10_long) (((x10_int)3))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                 FMGL(mc))->
                                                               FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                             ((x10_long) (xh)),
                                             ((x10_long) (((x10_int) ((yh) + (((x10_int)1)))))),
                                             ((x10_long) (zh))));
        }
        
    } else 
    //#line 181 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(yh, ((x10_int) ((x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                  ((x10_long) (((x10_int)1))))) - (((x10_int)1)))))))
    {
        
        //#line 182 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)2))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (xh)),
                                         ((x10_long) (((x10_int) ((yh) - (((x10_int)1)))))),
                                         ((x10_long) (zh))));
        
        //#line 183 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)3))), ((x10_int)-1));
    } else {
        
        //#line 186 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)2))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (xh)),
                                         ((x10_long) (((x10_int) ((yh) - (((x10_int)1)))))),
                                         ((x10_long) (zh))));
        
        //#line 187 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)3))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (xh)),
                                         ((x10_long) (((x10_int) ((yh) + (((x10_int)1)))))),
                                         ((x10_long) (zh))));
    }
    
    //#line 190 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(zh, ((x10_int)0)))) {
        
        //#line 191 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)4))), ((x10_int)-1));
        
        //#line 193 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
        if ((x10aux::struct_equals(zh, ((x10_int) ((x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                      ((x10_long) (((x10_int)2))))) - (((x10_int)1)))))))
        {
            
            //#line 194 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(grid))->
                                FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
              ((x10_long) (((x10_int)5))), ((x10_int)-1));
        } else {
            
            //#line 196 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(grid))->
                                FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
              ((x10_long) (((x10_int)5))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                 FMGL(mc))->
                                                               FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                             ((x10_long) (xh)),
                                             ((x10_long) (yh)),
                                             ((x10_long) (((x10_int) ((zh) + (((x10_int)1))))))));
        }
        
    } else 
    //#line 198 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10If_c
    if ((x10aux::struct_equals(zh, ((x10_int) ((x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                  ((x10_long) (((x10_int)2))))) - (((x10_int)1)))))))
    {
        
        //#line 199 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)4))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (xh)),
                                         ((x10_long) (yh)),
                                         ((x10_long) (((x10_int) ((zh) - (((x10_int)1))))))));
        
        //#line 200 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)5))), ((x10_int)-1));
    } else {
        
        //#line 203 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)4))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (xh)),
                                         ((x10_long) (yh)),
                                         ((x10_long) (((x10_int) ((zh) - (((x10_int)1))))))));
        
        //#line 204 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
        x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                FMGL(mc))->
                                              FMGL(grid))->
                            FMGL(nabes))->x10::lang::Rail<x10_int >::__set(
          ((x10_long) (((x10_int)5))), x10aux::nullCheck(x10aux::nullCheck(this->
                                                                             FMGL(mc))->
                                                           FMGL(matrix))->x10::regionarray::Array<x10_int>::__apply(
                                         ((x10_long) (xh)),
                                         ((x10_long) (yh)),
                                         ((x10_long) (((x10_int) ((zh) + (((x10_int)1))))))));
    }
    
    //#line 214 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.For_c
    {
        x10_int i;
        for (
             //#line 214 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10LocalDecl_c
             i = ((x10_int)0); ((((x10_long) (i))) < ((x10_long)(x10aux::nullCheck(dim)->FMGL(size))));
             
             //#line 214 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
             i = ((x10_int) ((i) + (((x10_int)1))))) {
            
            //#line 215 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
            x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                    FMGL(mc))->
                                                  FMGL(grid))->
                                FMGL(size))->x10::lang::Rail<x10_double >::__set(
              ((x10_long) (i)), ((x10_double) (((x10_int) ((x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                              ((x10_long) (i)))) / x10aux::zeroCheck(x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                                                                       ((x10_long) (i)))))))));
        }
    }
    
    //#line 217 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
    dx = x10::lang::DoubleNatives::toInt(((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                                   FMGL(mc))->
                                                                                 FMGL(grid))->
                                                               FMGL(size))->x10::lang::Rail<x10_double >::__apply(
                                             ((x10_long) (((x10_int)0))))) / (((x10_double) (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                                                               ((x10_long) (((x10_int)0)))))))));
    
    //#line 218 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
    dy = x10::lang::DoubleNatives::toInt(((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                                   FMGL(mc))->
                                                                                 FMGL(grid))->
                                                               FMGL(size))->x10::lang::Rail<x10_double >::__apply(
                                             ((x10_long) (((x10_int)1))))) / (((x10_double) (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                                                               ((x10_long) (((x10_int)1)))))))));
    
    //#line 219 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10LocalAssign_c
    dz = x10::lang::DoubleNatives::toInt(((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                                   FMGL(mc))->
                                                                                 FMGL(grid))->
                                                               FMGL(size))->x10::lang::Rail<x10_double >::__apply(
                                             ((x10_long) (((x10_int)2))))) / (((x10_double) (x10aux::nullCheck(dim)->x10::lang::Rail<x10_int >::__apply(
                                                                                               ((x10_long) (((x10_int)2)))))))));
    
    //#line 221 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(coords))->x10::lang::Rail<x10_double >::__set(
      ((x10_long) (((x10_int)0))), ((x10_double) (((x10_int) ((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                                                       FMGL(mc))->
                                                                                                     FMGL(grid))->
                                                                                   FMGL(proc_coords))->x10::lang::Rail<x10_int >::__apply(
                                                                 ((x10_long) (((x10_int)0))))) * (dx))))));
    
    //#line 222 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(coords))->x10::lang::Rail<x10_double >::__set(
      ((x10_long) (((x10_int)1))), ((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                             FMGL(mc))->
                                                                           FMGL(grid))->
                                                         FMGL(coords))->x10::lang::Rail<x10_double >::__apply(
                                       ((x10_long) (((x10_int)0))))) + (((x10_double) (dx)))));
    
    //#line 224 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(coords))->x10::lang::Rail<x10_double >::__set(
      ((x10_long) (((x10_int)2))), ((x10_double) (((x10_int) ((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                                                       FMGL(mc))->
                                                                                                     FMGL(grid))->
                                                                                   FMGL(proc_coords))->x10::lang::Rail<x10_int >::__apply(
                                                                 ((x10_long) (((x10_int)1))))) * (dy))))));
    
    //#line 225 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(coords))->x10::lang::Rail<x10_double >::__set(
      ((x10_long) (((x10_int)3))), ((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                             FMGL(mc))->
                                                                           FMGL(grid))->
                                                         FMGL(coords))->x10::lang::Rail<x10_double >::__apply(
                                       ((x10_long) (((x10_int)2))))) + (((x10_double) (dy)))));
    
    //#line 227 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(coords))->x10::lang::Rail<x10_double >::__set(
      ((x10_long) (((x10_int)4))), ((x10_double) (((x10_int) ((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                                                       FMGL(mc))->
                                                                                                     FMGL(grid))->
                                                                                   FMGL(proc_coords))->x10::lang::Rail<x10_int >::__apply(
                                                                 ((x10_long) (((x10_int)2))))) * (dz))))));
    
    //#line 228 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                            FMGL(mc))->
                                          FMGL(grid))->FMGL(coords))->x10::lang::Rail<x10_double >::__set(
      ((x10_long) (((x10_int)5))), ((x10aux::nullCheck(x10aux::nullCheck(x10aux::nullCheck(this->
                                                                                             FMGL(mc))->
                                                                           FMGL(grid))->
                                                         FMGL(coords))->x10::lang::Rail<x10_double >::__apply(
                                       ((x10_long) (((x10_int)4))))) + (((x10_double) (dz)))));
}

//#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10MethodDecl_c
MC_Init* MC_Init::MC_Init____this__MC_Init() {
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10Return_c
    return this;
    
}

//#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10ConstructorDecl_c
void MC_Init::_constructor() {
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": polyglot.ast.Empty_c
    ;
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.AssignPropertyCall_c
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10Call_c
    this->MC_Init::__fieldInitializers_MC_Init();
}
MC_Init* MC_Init::_make() {
    MC_Init* this_ = new (memset(x10aux::alloc<MC_Init>(), 0, sizeof(MC_Init))) MC_Init();
    this_->_constructor();
    return this_;
}



//#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": x10.ast.X10MethodDecl_c
void MC_Init::__fieldInitializers_MC_Init() {
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(mc) = (x10aux::class_cast_unchecked<MC*>(reinterpret_cast<x10::lang::NullType*>(X10_NULL)));
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(bufsize) = 1.5;
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(factorized) = x10::lang::Rail<x10_int >::_make(((x10_long)20000ll));
    
    //#line 14 "/home/horie/x10dt/x10dt/workspace/MCCK/src/MC_Init.x10": Eval of x10.ast.X10FieldAssign_c
    this->FMGL(counter) = ((x10_int)0);
}
const x10aux::serialization_id_t MC_Init::_serialization_id = 
    x10aux::DeserializationDispatcher::addDeserializer(MC_Init::_deserializer, x10aux::CLOSURE_KIND_NOT_ASYNC);

void MC_Init::_serialize_body(x10aux::serialization_buffer& buf) {
    buf.write(this->FMGL(mc));
    buf.write(this->FMGL(bufsize));
    buf.write(this->FMGL(factorized));
    buf.write(this->FMGL(counter));
    
}

x10::lang::Reference* MC_Init::_deserializer(x10aux::deserialization_buffer& buf) {
    MC_Init* this_ = new (memset(x10aux::alloc<MC_Init>(), 0, sizeof(MC_Init))) MC_Init();
    buf.record_reference(this_);
    this_->_deserialize_body(buf);
    return this_;
}

void MC_Init::_deserialize_body(x10aux::deserialization_buffer& buf) {
    FMGL(mc) = buf.read<MC*>();
    FMGL(bufsize) = buf.read<x10_double>();
    FMGL(factorized) = buf.read<x10::lang::Rail<x10_int >*>();
    FMGL(counter) = buf.read<x10_int>();
}

x10aux::RuntimeType MC_Init::rtt;
void MC_Init::_initRTT() {
    if (rtt.initStageOne(&rtt)) return;
    const x10aux::RuntimeType** parents = NULL; 
    rtt.initStageTwo("MC_Init",x10aux::RuntimeType::class_kind, 0, parents, 0, NULL, NULL);
}

/* END of MC_Init */
/*************************************************/
