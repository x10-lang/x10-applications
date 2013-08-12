package xsbench;

@x10.runtime.impl.java.X10Generated abstract public class Do_flops extends x10.core.Ref implements xsbench.XSbench_header, x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<Do_flops> $RTT = x10.rtt.NamedType.<Do_flops> make(
    "xsbench.Do_flops", Do_flops.class, new x10.rtt.Type[] {xsbench.XSbench_header.$RTT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Do_flops $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Do_flops.class + " calling"); } 
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public Do_flops(final java.lang.System[] $dummy) { 
    }
    
        
        
//#line 10 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
public static void
                                                                                                do_flops(
                                                                                                ){
            
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
double a =
              1.33;
            
//#line 12 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final double b =
              2.34;
            
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
long i212485 =
              0L;
            
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
for (;
                                                                                                       true;
                                                                                                       ) {
                
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212486 =
                  i212485;
                
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212487 =
                  xsbench.XSbench_header.EXTRA_FLOPS;
                
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final boolean t212488 =
                  ((t212486) < (((long)(t212487))));
                
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
if (!(t212488)) {
                    
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
break;
                }
                
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final double t212481 =
                  a;
                
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final double t212482 =
                  ((t212481) * (((double)(b))));
                
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
a = t212482;
                
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212483 =
                  i212485;
                
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212484 =
                  ((t212483) + (((long)(1L))));
                
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
i212485 = t212484;
            }
        }
        
        
//#line 19 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
public static void
                                                                                                do_loads__1$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(
                                                                                                final int nuc_,
                                                                                                final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids){
            
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212462 =
              xsbench.XSbench_header.EXTRA_LOADS;
            
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final boolean t212463 =
              true;
            
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
if (t212463) {
                
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
return;
            }
            
//#line 21 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long n_isotopes =
              ((x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>>)nuclide_grids).
                size;
            
//#line 22 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final x10.core.Rail t212464 =
              ((x10.core.Rail[])nuclide_grids.value)[(int)0L];
            
//#line 22 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long n_gridpoints =
              ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)t212464).
                size;
            
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212465 =
              ((long)(((int)(nuc_))));
            
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long nuc =
              ((t212465) % (((long)(n_isotopes))));
            
//#line 24 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212466 =
              ((long)(((long)(nuc))));
            
//#line 24 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final x10.lang.Cell tmp =
              ((x10.lang.Cell)(new x10.lang.Cell<x10.core.ULong>((java.lang.System[]) null, x10.rtt.Types.ULONG).x10$lang$Cell$$init$S(x10.core.ULong.$box(t212466), (x10.lang.Cell.__0x10$lang$Cell$$T) null)));
            
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
long i212497 =
              0L;
            {
                
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final x10.core.Rail[] nuclide_grids$value212501 =
                  ((x10.core.Rail[])nuclide_grids.value);
                
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
for (;
                                                                                                           true;
                                                                                                           ) {
                    
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212498 =
                      i212497;
                    
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212499 =
                      xsbench.XSbench_header.EXTRA_LOADS;
                    
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final boolean t212500 =
                      ((t212498) < (((long)(t212499))));
                    
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
if (!(t212500)) {
                        
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
break;
                    }
                    
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final int t212489 =
                      xsbench.Do_flops.rn_int__0$1x10$lang$ULong$2$O(((x10.lang.Cell)(tmp)));
                    
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212490 =
                      ((long)(((int)(t212489))));
                    
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long idx212491 =
                      ((t212490) % (((long)(n_gridpoints))));
                    
//#line 27 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final x10.core.Rail t212492 =
                      ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)nuclide_grids$value212501[(int)nuc]);
                    
//#line 27 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final xsbench.XSbench_header.NuclideGridPoint t212493 =
                      ((xsbench.XSbench_header.NuclideGridPoint[])t212492.value)[(int)idx212491];
                    
//#line 27 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final double load212494 =
                      t212493.
                        total_xs;
                    
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212495 =
                      i212497;
                    
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212496 =
                      ((t212495) + (((long)(1L))));
                    
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
i212497 = t212496;
                }
            }
        }
        
        
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
public static int
                                                                                                rn_int__0$1x10$lang$ULong$2$O(
                                                                                                final x10.lang.Cell<x10.core.ULong> seed){
            
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long a =
              16807L;
            
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long m =
              2147483647L;
            
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212477 =
              x10.core.ULong.$unbox(((x10.lang.Cell<x10.core.ULong>)seed).$apply$G());
            
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long t212478 =
              ((a) * (((long)(t212477))));
            
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final long n1 =
              x10.runtime.impl.java.ULongUtils.rem(t212478, ((long)(m)));
            
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
((x10.lang.Cell<x10.core.ULong>)seed).$apply__0x10$lang$Cell$$T(x10.core.ULong.$box(n1));
            
//#line 40 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final java.lang.Object t212479 =
              ((java.lang.Object)
                x10.core.ULong.$box(n1));
            
//#line 40 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final int t212480 =
              x10.rtt.Types.asint(t212479,x10.rtt.Types.ANY);
            
//#line 40 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
return t212480;
        }
        
        
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final public xsbench.Do_flops
                                                                                               xsbench$Do_flops$$this$xsbench$Do_flops(
                                                                                               ){
            
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
return xsbench.Do_flops.this;
        }
        
        
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"

        // constructor for non-virtual call
        final public xsbench.Do_flops xsbench$Do_flops$$init$S() { {
                                                                          
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
;
                                                                          
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"

                                                                          
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
this.__fieldInitializers_xsbench_Do_flops();
                                                                      }
                                                                      return this;
                                                                      }
        
        
        
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Do_flops.x10"
final public void
                                                                                               __fieldInitializers_xsbench_Do_flops(
                                                                                               ){
            
        }
    
}

