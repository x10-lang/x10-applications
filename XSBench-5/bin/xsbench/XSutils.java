package xsbench;

@x10.runtime.impl.java.X10Generated abstract public class XSutils extends x10.core.Ref implements xsbench.XSbench_header, x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<XSutils> $RTT = x10.rtt.NamedType.<XSutils> make(
    "xsbench.XSutils", XSutils.class, new x10.rtt.Type[] {xsbench.XSbench_header.$RTT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.XSutils $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + XSutils.class + " calling"); } 
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public XSutils(final java.lang.System[] $dummy) { 
    }
    
        
        
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
public static x10.core.Rail
                                                                                              gpmatrix(
                                                                                              final long m,
                                                                                              final long n){
            
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.core.fun.Fun_0_1 t213485 =
              ((x10.core.fun.Fun_0_1)(new xsbench.XSutils.$Closure$119(n)));
            
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.core.Rail t213486 =
              ((x10.core.Rail)(new x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>>(x10.rtt.ParameterizedType.make(x10.core.Rail.$RTT, xsbench.XSbench_header.NuclideGridPoint.$RTT), ((long)(m)),
                                                                                                         ((x10.core.fun.Fun_0_1)(t213485)), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
            
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return t213486;
        }
        
        
//#line 9 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
public static void
                                                                                              gpmatrix_free__0$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(
                                                                                              final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> M){
            
        }
        
        
//#line 12 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final public static x10.core.fun.Fun_0_2<xsbench.XSbench_header.NuclideGridPoint,xsbench.XSbench_header.NuclideGridPoint,x10.core.Int> NGP_compare = ((x10.core.fun.Fun_0_2)(new xsbench.XSutils.$Closure$120()));
        
        
//#line 15 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
public static void
                                                                                               logo(
                                                                                               final long version){
            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
xsbench.XSutils.border_print();
            
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213491 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 18 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final java.lang.String t213487 =
              "                   __   __ ___________                 _                        \n                   \\ \\ / //  ___| ___ \\               | |                       \n";
            
//#line 18 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final java.lang.String t213488 =
              "                   __   __ ___________                 _                        \n                   \\ \\ / //  ___| ___ \\               | |                       \n                    \\ V / \\ `--.| |_/ / ___ _ __   ___| |__                     \n";
            
//#line 18 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final java.lang.String t213489 =
              "                   __   __ ___________                 _                        \n                   \\ \\ / //  ___| ___ \\               | |                       \n                    \\ V / \\ `--.| |_/ / ___ _ __   ___| |__                     \n                    /   \\  `--. \\ ___ \\/ _ \\ \'_ \\ / __| \'_ \\                    \n";
            
//#line 18 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final java.lang.String t213490 =
              "                   __   __ ___________                 _                        \n                   \\ \\ / //  ___| ___ \\               | |                       \n                    \\ V / \\ `--.| |_/ / ___ _ __   ___| |__                     \n                    /   \\  `--. \\ ___ \\/ _ \\ \'_ \\ / __| \'_ \\                    \n                   / /^\\ \\/\\__/ / |_/ /  __/ | | | (__| | | |                   \n";
            
//#line 18 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final java.lang.String t213492 =
              "                   __   __ ___________                 _                        \n                   \\ \\ / //  ___| ___ \\               | |                       \n                    \\ V / \\ `--.| |_/ / ___ _ __   ___| |__                     \n                    /   \\  `--. \\ ___ \\/ _ \\ \'_ \\ / __| \'_ \\                    \n                   / /^\\ \\/\\__/ / |_/ /  __/ | | | (__| | | |                   \n                   \\/   \\/\\____/\\____/ \\___|_| |_|\\___|_| |_|                   \n\n";
            
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213491.print(((java.lang.String)(t213492)));
            
//#line 25 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
xsbench.XSutils.border_print();
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
xsbench.XSutils.center_print(((java.lang.String)("Developed at Argonne National Laboratory")),
                                                                                                                              (long)(79L));
            
//#line 27 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final java.lang.Object t213493 =
              ((java.lang.Object)
                x10.core.Long.$box(version));
            
//#line 27 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.core.Rail t213494 =
              ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<java.lang.Object> makeRailFromJavaArray(x10.rtt.Types.ANY, new java.lang.Object[] {t213493})));
            
//#line 27 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final java.lang.String v =
              x10.runtime.impl.java.StringUtils.format("Version: %d",(java.lang.Object[]) (t213494).value);
            
//#line 28 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
xsbench.XSutils.center_print(((java.lang.String)(v)),
                                                                                                                              (long)(79L));
            
//#line 29 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
xsbench.XSutils.border_print();
        }
        
        
//#line 33 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
public static void
                                                                                               center_print(
                                                                                               final java.lang.String s,
                                                                                               final long width){
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final int t213495 =
              (s).length();
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long length =
              ((long)(((int)(t213495))));
            
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
long i213571 =
              0L;
            
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
for (;
                                                                                                      true;
                                                                                                      ) {
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213572 =
                  i213571;
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213573 =
                  ((width) - (((long)(length))));
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213574 =
                  ((t213573) / (((long)(2L))));
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213575 =
                  ((t213572) <= (((long)(t213574))));
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (!(t213575)) {
                    
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
break;
                }
                
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213568 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213568.print(((java.lang.String)(" ")));
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213569 =
                  i213571;
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213570 =
                  ((t213569) + (((long)(1L))));
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
i213571 = t213570;
            }
            
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213504 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213504.println(((java.lang.Object)(s)));
        }
        
        
//#line 41 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
public static void
                                                                                               border_print(
                                                                                               ){
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213505 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213505.print(((java.lang.String)("================================================================================\n")));
        }
        
        
//#line 46 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
public static void
                                                                                               fancy_int(
                                                                                               final long a){
            
//#line 47 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213528 =
              ((a) < (((long)(1000L))));
            
//#line 47 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213528) {
                
//#line 48 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213506 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 48 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213506.printf(((java.lang.String)("%d\n")),
                                                                                                                    x10.core.Long.$box(a));
            } else {
                
//#line 49 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
boolean t213507 =
                  ((a) >= (((long)(1000L))));
                
//#line 49 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213507) {
                    
//#line 49 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213507 = ((a) < (((long)(1000000L))));
                }
                
//#line 49 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213527 =
                  t213507;
                
//#line 49 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213527) {
                    
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213508 =
                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                    
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213509 =
                      ((a) / (((long)(1000L))));
                    
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213510 =
                      ((a) % (((long)(1000L))));
                    
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213508.printf(((java.lang.String)("%d,%03d\n")),
                                                                                                                        x10.core.Long.$box(t213509),
                                                                                                                        x10.core.Long.$box(t213510));
                } else {
                    
//#line 51 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
boolean t213511 =
                      ((a) >= (((long)(1000000L))));
                    
//#line 51 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213511) {
                        
//#line 51 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213511 = ((a) < (((long)(1000000000L))));
                    }
                    
//#line 51 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213526 =
                      t213511;
                    
//#line 51 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213526) {
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213513 =
                          ((x10.io.Printer)(x10.io.Console.get$OUT()));
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213514 =
                          ((a) / (((long)(1000000L))));
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213512 =
                          ((a) % (((long)(1000000L))));
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213515 =
                          ((t213512) / (((long)(1000L))));
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213516 =
                          ((a) % (((long)(1000L))));
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213513.printf(((java.lang.String)("%d,%03d,%03d\n")),
                                                                                                                            x10.core.Long.$box(t213514),
                                                                                                                            x10.core.Long.$box(t213515),
                                                                                                                            x10.core.Long.$box(t213516));
                    } else {
                        
//#line 53 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213525 =
                          ((a) >= (((long)(1000000000L))));
                        
//#line 53 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213525) {
                            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213519 =
                              ((x10.io.Printer)(x10.io.Console.get$OUT()));
                            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213520 =
                              ((a) / (((long)(1000000000L))));
                            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213517 =
                              ((a) % (((long)(1000000000L))));
                            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213521 =
                              ((t213517) / (((long)(1000000L))));
                            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213518 =
                              ((a) % (((long)(1000000L))));
                            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213522 =
                              ((t213518) / (((long)(1000L))));
                            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213523 =
                              ((a) % (((long)(1000L))));
                            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213519.printf(((java.lang.String)("%d,%03d,%03d,%03d\n")),
                                                                                                                                x10.core.Long.$box(t213520),
                                                                                                                                x10.core.Long.$box(t213521),
                                                                                                                                x10.core.Long.$box(t213522),
                                                                                                                                x10.core.Long.$box(t213523));
                        } else {
                            
//#line 56 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.io.Printer t213524 =
                              ((x10.io.Printer)(x10.io.Console.get$OUT()));
                            
//#line 56 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
t213524.printf(((java.lang.String)("%d\n")),
                                                                                                                                x10.core.Long.$box(a));
                        }
                    }
                }
            }
        }
        
        
//#line 61 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
public static long
                                                                                               binary_search__0$1xsbench$XSbench_header$NuclideGridPoint$2$O(
                                                                                               final x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint> A,
                                                                                               final double quarry){
            
//#line 62 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long n =
              ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)A).
                size;
            
//#line 63 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
long min =
              0L;
            
//#line 64 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
long max =
              ((n) - (((long)(1L))));
            
//#line 65 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
long mid =
               0;
            
//#line 68 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final xsbench.XSbench_header.NuclideGridPoint t213529 =
              ((xsbench.XSbench_header.NuclideGridPoint[])A.value)[(int)0L];
            
//#line 68 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213530 =
              t213529.
                energy;
            
//#line 68 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213536 =
              ((t213530) > (((double)(quarry))));
            
//#line 68 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213536) {
                
//#line 69 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return 0L;
            } else {
                
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213531 =
                  ((n) - (((long)(1L))));
                
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final xsbench.XSbench_header.NuclideGridPoint t213532 =
                  ((xsbench.XSbench_header.NuclideGridPoint[])A.value)[(int)t213531];
                
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213533 =
                  t213532.
                    energy;
                
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213535 =
                  ((t213533) < (((double)(quarry))));
                
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213535) {
                    
//#line 71 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213534 =
                      ((n) - (((long)(2L))));
                    
//#line 71 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return t213534;
                }
            }
            {
                
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final xsbench.XSbench_header.NuclideGridPoint[] A$value213598 =
                  ((xsbench.XSbench_header.NuclideGridPoint[])A.value);
                
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
while (true) {
                    
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213537 =
                      max;
                    
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213538 =
                      min;
                    
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213561 =
                      ((t213537) >= (((long)(t213538))));
                    
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (!(t213561)) {
                        
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
break;
                    }
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213576 =
                      min;
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213577 =
                      max;
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213578 =
                      min;
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213579 =
                      ((t213577) - (((long)(t213578))));
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213580 =
                      ((double)(long)(((long)(t213579))));
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213581 =
                      ((t213580) / (((double)(2.0))));
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213582 =
                      java.lang.Math.floor(((double)(t213581)));
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213583 =
                      ((long)(double)(((double)(t213582))));
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213584 =
                      ((t213576) + (((long)(t213583))));
                    
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
mid = t213584;
                    
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213585 =
                      mid;
                    
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final xsbench.XSbench_header.NuclideGridPoint t213586 =
                      ((xsbench.XSbench_header.NuclideGridPoint)A$value213598[(int)t213585]);
                    
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213587 =
                      t213586.
                        energy;
                    
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213588 =
                      ((t213587) < (((double)(quarry))));
                    
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213588) {
                        
//#line 77 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213589 =
                          mid;
                        
//#line 77 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213590 =
                          ((t213589) + (((long)(1L))));
                        
//#line 77 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
min = t213590;
                    } else {
                        
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213591 =
                          mid;
                        
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final xsbench.XSbench_header.NuclideGridPoint t213592 =
                          ((xsbench.XSbench_header.NuclideGridPoint)A$value213598[(int)t213591]);
                        
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213593 =
                          t213592.
                            energy;
                        
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final boolean t213594 =
                          ((t213593) > (((double)(quarry))));
                        
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
if (t213594) {
                            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213595 =
                              mid;
                            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213596 =
                              ((t213595) - (((long)(1L))));
                            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
max = t213596;
                        } else {
                            
//#line 81 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213597 =
                              mid;
                            
//#line 81 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return t213597;
                        }
                    }
                }
            }
            
//#line 83 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213562 =
              max;
            
//#line 83 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return t213562;
        }
        
        
//#line 88 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
public static double
                                                                                               rn__0$1x10$lang$ULong$2$O(
                                                                                               final x10.lang.Cell<x10.core.ULong> seed){
            
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long a =
              16807L;
            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long m =
              2147483647L;
            
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213563 =
              x10.core.ULong.$unbox(((x10.lang.Cell<x10.core.ULong>)seed).$apply$G());
            
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long t213564 =
              ((a) * (((long)(t213563))));
            
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final long n1 =
              x10.runtime.impl.java.ULongUtils.rem(t213564, ((long)(m)));
            
//#line 92 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
((x10.lang.Cell<x10.core.ULong>)seed).$apply__0x10$lang$Cell$$T(x10.core.ULong.$box(n1));
            
//#line 93 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213565 =
              (x10.runtime.impl.java.ULongUtils.toDouble(((long)(n1))));
            
//#line 93 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213566 =
              (x10.runtime.impl.java.ULongUtils.toDouble(((long)(m))));
            
//#line 93 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final double t213567 =
              ((t213565) / (((double)(t213566))));
            
//#line 93 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return t213567;
        }
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final public xsbench.XSutils
                                                                                              xsbench$XSutils$$this$xsbench$XSutils(
                                                                                              ){
            
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return xsbench.XSutils.this;
        }
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"

        // constructor for non-virtual call
        final public xsbench.XSutils xsbench$XSutils$$init$S() { {
                                                                        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
;
                                                                        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"

                                                                        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
this.__fieldInitializers_xsbench_XSutils();
                                                                    }
                                                                    return this;
                                                                    }
        
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final public void
                                                                                              __fieldInitializers_xsbench_XSutils(
                                                                                              ){
            
        }
        
        @x10.runtime.impl.java.X10Generated final public static class $Closure$118 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$118> $RTT = x10.rtt.StaticFunType.<$Closure$118> make(
            $Closure$118.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, xsbench.XSbench_header.NuclideGridPoint.$RTT)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.XSutils.$Closure$118 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$118.class + " calling"); } 
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.XSutils.$Closure$118 $_obj = new xsbench.XSutils.$Closure$118((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Closure$118(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply(x10.core.Long.$unbox(a1));
            }
            
                
                public xsbench.XSbench_header.NuclideGridPoint
                  $apply(
                  final long id$208361){
                    
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final xsbench.XSbench_header.NuclideGridPoint t213482 =
                      ((xsbench.XSbench_header.NuclideGridPoint)(new xsbench.XSbench_header.NuclideGridPoint((java.lang.System[]) null).xsbench$XSbench_header$NuclideGridPoint$$init$S()));
                    
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return t213482;
                }
                
                public $Closure$118() { {
                                               
                                           }}
                
            }
            
        @x10.runtime.impl.java.X10Generated final public static class $Closure$119 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$119> $RTT = x10.rtt.StaticFunType.<$Closure$119> make(
            $Closure$119.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.ParameterizedType.make(x10.core.Rail.$RTT, xsbench.XSbench_header.NuclideGridPoint.$RTT))}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.XSutils.$Closure$119 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$119.class + " calling"); } 
                $_obj.n = $deserializer.readLong();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.XSutils.$Closure$119 $_obj = new xsbench.XSutils.$Closure$119((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                $serializer.write(this.n);
                
            }
            
            // constructor just for allocation
            public $Closure$119(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply(x10.core.Long.$unbox(a1));
            }
            
                
                public x10.core.Rail
                  $apply(
                  final long id$208360){
                    
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.core.fun.Fun_0_1 t213483 =
                      ((x10.core.fun.Fun_0_1)(new xsbench.XSutils.$Closure$118()));
                    
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
final x10.core.Rail t213484 =
                      ((x10.core.Rail)(new x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>(xsbench.XSbench_header.NuclideGridPoint.$RTT, this.
                                                                                                                                                  n,
                                                                                                  ((x10.core.fun.Fun_0_1)(t213483)), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
                    
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return t213484;
                }
                
                public long n;
                
                public $Closure$119(final long n) { {
                                                           this.n = n;
                                                       }}
                
            }
            
        @x10.runtime.impl.java.X10Generated final public static class $Closure$120 extends x10.core.Ref implements x10.core.fun.Fun_0_2, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$120> $RTT = x10.rtt.StaticFunType.<$Closure$120> make(
            $Closure$120.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_2.$RTT, xsbench.XSbench_header.NuclideGridPoint.$RTT, xsbench.XSbench_header.NuclideGridPoint.$RTT, x10.rtt.Types.INT)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.XSutils.$Closure$120 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$120.class + " calling"); } 
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.XSutils.$Closure$120 $_obj = new xsbench.XSutils.$Closure$120((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Closure$120(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1,Z2)=>U.operator()(a1:Z1,a2:Z2):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1, final java.lang.Object a2, final x10.rtt.Type t2) {
            return x10.core.Int.$box($apply$O((xsbench.XSbench_header.NuclideGridPoint)a1, (xsbench.XSbench_header.NuclideGridPoint)a2));
            }
            // dispatcher for method abstract public (Z1,Z2)=>U.operator()(a1:Z1,a2:Z2):U
            public int $apply$I(final java.lang.Object a1, final x10.rtt.Type t1, final java.lang.Object a2, final x10.rtt.Type t2) {
            return $apply$O((xsbench.XSbench_header.NuclideGridPoint)a1, (xsbench.XSbench_header.NuclideGridPoint)a2);
            }
            
                
                public int
                  $apply$O(
                  final xsbench.XSbench_header.NuclideGridPoint i,
                  final xsbench.XSbench_header.NuclideGridPoint j){
                    
//#line 12 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSutils.x10"
return ((double) i.
                                                                                                                            energy) ==
                    ((double) j.
                                energy)
                      ? 0
                      : (((i.
                             energy) > (((double)(j.
                                                    energy))))
                           ? 1
                           : -1);
                }
                
                public $Closure$120() { {
                                               
                                           }}
                
            }
            
        
        }
        
        