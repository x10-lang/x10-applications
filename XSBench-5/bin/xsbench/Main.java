package xsbench;

@x10.runtime.impl.java.X10Generated abstract public class Main extends x10.core.Ref implements xsbench.XSbench_header, x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<Main> $RTT = x10.rtt.NamedType.<Main> make(
    "xsbench.Main", Main.class, new x10.rtt.Type[] {xsbench.XSbench_header.$RTT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Main $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Main.class + " calling"); } 
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public Main(final java.lang.System[] $dummy) { 
    }
    
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
public static class $Main extends x10.runtime.impl.java.Runtime {
        private static final long serialVersionUID = 1L;
        public static void main(java.lang.String[] args)  {
        // start native runtime
        new $Main().start(args);
        }
        
        // called by native runtime inside main x10 thread
        public void runtimeCallback(final x10.core.Rail<java.lang.String> args)  {
        // call the original app-main method
        Main.main(args);
        }
        }
        
        // the original app-main method
        public static void main(final x10.core.Rail<java.lang.String> args)  {
            
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long version =
              5L;
            
//#line 12 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
long n_isotopes =
               0;
            
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long n_gridpoints =
              11303L;
            
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long lookups =
              15000000L;
            
//#line 15 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
int nthreads =
               0;
            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int max_procs =
              java.lang.Runtime.getRuntime().availableProcessors();
            
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
java.lang.String HM =
               null;
            
//#line 18 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
int bgq_mode =
              0;
            
//#line 22 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394266 =
              x10.lang.System.currentTimeMillis$O();
            
//#line 22 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.FakeRandom.srand((long)(t394266));
            
//#line 33 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394267 =
              ((x10.core.Rail<java.lang.String>)args).
                size;
            
//#line 33 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394284 =
              ((long) t394267) ==
            ((long) 1L);
            
//#line 33 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394284) {
                
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final java.lang.String t394268 =
                  ((java.lang.String[])args.value)[(int)0L];
                
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394269 =
                  java.lang.Integer.parseInt(t394268);
                
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
nthreads = t394269;
                
//#line 35 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
n_isotopes = 355L;
            } else {
                
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394270 =
                  ((x10.core.Rail<java.lang.String>)args).
                    size;
                
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394283 =
                  ((long) t394270) ==
                ((long) 2L);
                
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394283) {
                    
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final java.lang.String t394271 =
                      ((java.lang.String[])args.value)[(int)0L];
                    
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394272 =
                      java.lang.Integer.parseInt(t394271);
                    
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
nthreads = t394272;
                    
//#line 40 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final java.lang.String t394273 =
                      ((java.lang.String[])args.value)[(int)1L];
                    
//#line 40 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394274 =
                      (t394273).equalsIgnoreCase("small");
                    
//#line 40 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394274) {
                        
//#line 41 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
n_isotopes = 68L;
                    } else {
                        
//#line 43 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
n_isotopes = 355L;
                    }
                } else {
                    
//#line 45 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394275 =
                      ((x10.core.Rail<java.lang.String>)args).
                        size;
                    
//#line 45 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394282 =
                      ((long) t394275) ==
                    ((long) 3L);
                    
//#line 45 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394282) {
                        
//#line 46 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final java.lang.String t394276 =
                          ((java.lang.String[])args.value)[(int)0L];
                        
//#line 46 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394277 =
                          java.lang.Integer.parseInt(t394276);
                        
//#line 46 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
nthreads = t394277;
                        
//#line 48 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final java.lang.String t394278 =
                          ((java.lang.String[])args.value)[(int)1L];
                        
//#line 48 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394279 =
                          (t394278).equalsIgnoreCase("small");
                        
//#line 48 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394279) {
                            
//#line 49 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
n_isotopes = 68L;
                        } else {
                            
//#line 51 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
n_isotopes = 355L;
                        }
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final java.lang.String t394280 =
                          ((java.lang.String[])args.value)[(int)2L];
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394281 =
                          java.lang.Integer.parseInt(t394280);
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
bgq_mode = t394281;
                    } else {
                        
//#line 55 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
nthreads = max_procs;
                        
//#line 56 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
n_isotopes = 355L;
                    }
                }
            }
            
//#line 60 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394285 =
              n_isotopes;
            
//#line 60 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394286 =
              ((long) t394285) ==
            ((long) 68L);
            
//#line 60 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394286) {
                
//#line 61 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
HM = "Small";
            } else {
                
//#line 63 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
HM = "Large";
            }
            
//#line 66 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394287 =
              nthreads;
            
//#line 66 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.FakeOMP.omp_set_num_threads((int)(t394287));
            
//#line 72 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.logo((long)(version));
            
//#line 73 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.center_print(((java.lang.String)("INPUT SUMMARY")),
                                                                                                                           (long)(79L));
            
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.border_print();
            
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394288 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394288.printf(((java.lang.String)("Materials:                    %d\n")),
                                                                                                             x10.core.Long.$box(12L));
            
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394289 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final java.lang.String t394290 =
              HM;
            
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394289.printf(((java.lang.String)("H-M Benchmark Size:           %s\n")),
                                                                                                             ((java.lang.Object)(t394290)));
            
//#line 77 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394291 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 77 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394292 =
              n_isotopes;
            
//#line 77 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394291.printf(((java.lang.String)("Total Isotopes:               %d\n")),
                                                                                                             x10.core.Long.$box(t394292));
            
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394293 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394293.print(((java.lang.String)("Gridpoints (per Nuclide):     ")));
            
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.fancy_int((long)(n_gridpoints));
            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394294 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394294.print(((java.lang.String)("Unionized Energy Gridpoints:  ")));
            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394295 =
              n_isotopes;
            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394296 =
              ((t394295) * (((long)(n_gridpoints))));
            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.fancy_int((long)(t394296));
            
//#line 80 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394297 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 80 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394297.print(((java.lang.String)("XS Lookups:                   ")));
            
//#line 80 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.fancy_int((long)(lookups));
            
//#line 81 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394298 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 81 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394299 =
              nthreads;
            
//#line 81 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394298.printf(((java.lang.String)("Threads:                      %d\n")),
                                                                                                             x10.core.Int.$box(t394299));
            
//#line 82 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394300 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 82 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394300.printf(((java.lang.String)("Est. Memory Usage (MB):       UNKNOWN\n")));
            
//#line 83 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394301 =
              xsbench.XSbench_header.EXTRA_FLOPS;
            
//#line 83 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394304 =
              false;
            
//#line 83 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394304) {
                
//#line 84 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394302 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 84 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394303 =
                  xsbench.XSbench_header.EXTRA_FLOPS;
                
//#line 84 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394302.printf(((java.lang.String)("Extra Flops:                  %d\n")),
                                                                                                                 x10.core.Long.$box(t394303));
            }
            
//#line 85 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394305 =
              xsbench.XSbench_header.EXTRA_LOADS;
            
//#line 85 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394308 =
              false;
            
//#line 85 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394308) {
                
//#line 86 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394306 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 86 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394307 =
                  xsbench.XSbench_header.EXTRA_LOADS;
                
//#line 86 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394306.printf(((java.lang.String)("Extra Loads:                  %d\n")),
                                                                                                                 x10.core.Long.$box(t394307));
            }
            
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.border_print();
            
//#line 88 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.center_print(((java.lang.String)("INITIALIZATION")),
                                                                                                                           (long)(79L));
            
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.border_print();
            
//#line 96 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394309 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 96 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394309.print(((java.lang.String)("Generating Nuclide Energy Grids...\n")));
            
//#line 98 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394310 =
              n_isotopes;
            
//#line 98 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail nuclide_grids =
              ((x10.core.Rail)(xsbench.XSutils.gpmatrix((long)(t394310),
                                                        (long)(n_gridpoints))));
            
//#line 100 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.GridInit.generate_grids__0$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(((x10.core.Rail)(nuclide_grids)));
            
//#line 103 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.GridInit.sort_nuclide_grids__0$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(((x10.core.Rail)(nuclide_grids)));
            
//#line 106 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail energy_grid =
              xsbench.GridInit.generate_energy_grid__0$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(((x10.core.Rail)(nuclide_grids)));
            
//#line 110 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.GridInit.set_grid_ptrs__0$1xsbench$XSbench_header$GridPoint$2__1$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(((x10.core.Rail)(energy_grid)),
                                                                                                                                                                                                                                    ((x10.core.Rail)(nuclide_grids)));
            
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394311 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394311.print(((java.lang.String)("Loading Mats...\n")));
            
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394312 =
              n_isotopes;
            
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail num_nucs =
              xsbench.Materials.load_num_nucs((long)(t394312));
            
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394313 =
              n_isotopes;
            
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail mats =
              xsbench.Materials.load_mats__0$1x10$lang$Int$2(((x10.core.Rail)(num_nucs)),
                                                             (long)(t394313));
            
//#line 116 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail concs =
              xsbench.Materials.load_concs__0$1x10$lang$Int$2(((x10.core.Rail)(num_nucs)));
            
//#line 122 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.border_print();
            
//#line 123 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.center_print(((java.lang.String)("SIMULATION")),
                                                                                                                            (long)(79L));
            
//#line 124 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.border_print();
            
//#line 126 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double omp_start =
              xsbench.FakeOMP.omp_get_wtime$O();
            
//#line 135 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394398 =
              xsbench.XSbench_header.$Shadow.get$XSBENCH_NO_ASYNC();
            
//#line 135 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394398) {
                
//#line 142 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail macro_xs_vector =
                  ((x10.core.Rail)(new x10.core.Rail<x10.core.Double>(x10.rtt.Types.DOUBLE, ((long)(5L)))));
                
//#line 143 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int thread =
                  xsbench.FakeOMP.omp_get_thread_num$O();
                
//#line 144 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394314 =
                  ((thread) + (((int)(1))));
                
//#line 144 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394315 =
                  ((t394314) * (((int)(19))));
                
//#line 144 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394316 =
                  ((t394315) + (((int)(17))));
                
//#line 144 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394317 =
                  ((long)(int)(((int)(t394316))));
                
//#line 144 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.lang.Cell seed =
                  ((x10.lang.Cell)(new x10.lang.Cell<x10.core.ULong>((java.lang.System[]) null, x10.rtt.Types.ULONG).x10$lang$Cell$$init$S(x10.core.ULong.$box(t394317), (x10.lang.Cell.__0x10$lang$Cell$$T) null)));
                
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
long i394447 =
                  0L;
                
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
for (;
                                                                                                        true;
                                                                                                        ) {
                    
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394448 =
                      i394447;
                    
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394449 =
                      ((t394448) < (((long)(lookups))));
                    
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (!(t394449)) {
                        
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
break;
                    }
                    
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
boolean t394429 =
                      xsbench.XSbench_header.INFO;
                    
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394429) {
                        
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394429 = ((int) thread) ==
                        ((int) 0);
                    }
                    
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
boolean t394430 =
                      t394429;
                    
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394430) {
                        
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394431 =
                          i394447;
                        
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394432 =
                          ((t394431) % (((long)(1000L))));
                        
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394430 = ((long) t394432) ==
                        ((long) 0L);
                    }
                    
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394433 =
                      t394430;
                    
//#line 148 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394433) {
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394434 =
                          ((x10.io.Printer)(x10.io.Console.get$OUT()));
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394435 =
                          i394447;
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394436 =
                          ((double)(long)(((long)(t394435))));
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394437 =
                          ((double)(long)(((long)(lookups))));
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394438 =
                          nthreads;
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394439 =
                          ((double)(int)(((int)(t394438))));
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394440 =
                          ((t394437) / (((double)(t394439))));
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394441 =
                          ((t394436) / (((double)(t394440))));
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394442 =
                          ((t394441) * (((double)(100.0))));
                        
//#line 149 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394434.printf(((java.lang.String)("\rCalculating XS\'s... (%.0f%% completed)")),
                                                                                                                          x10.core.Double.$box(t394442));
                    }
                    
//#line 152 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double p_energy394443 =
                      xsbench.XSutils.rn__0$1x10$lang$ULong$2$O(((x10.lang.Cell)(seed)));
                    
//#line 153 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long mat394444 =
                      xsbench.Materials.pick_mat__0$1x10$lang$ULong$2$O(((x10.lang.Cell)(seed)));
                    
//#line 158 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.CalculateXS.calculate_macro_xs__2$1x10$lang$Rail$1x10$lang$Double$2$2__3$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Rail$1x10$lang$Int$2$2__6$1x10$lang$Double$2((double)(p_energy394443),
                                                                                                                                                                                                                                                                                                                                                     (long)(mat394444),
                                                                                                                                                                                                                                                                                                                                                     ((x10.core.Rail)(concs)),
                                                                                                                                                                                                                                                                                                                                                     ((x10.core.Rail)(energy_grid)),
                                                                                                                                                                                                                                                                                                                                                     ((x10.core.Rail)(nuclide_grids)),
                                                                                                                                                                                                                                                                                                                                                     ((x10.core.Rail)(mats)),
                                                                                                                                                                                                                                                                                                                                                     ((x10.core.Rail)(macro_xs_vector)));
                    
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394445 =
                      i394447;
                    
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394446 =
                      ((t394445) + (((long)(1L))));
                    
//#line 146 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
i394447 = t394446;
                }
            } else {
                
//#line 169 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int nthreads_ =
                  nthreads;
                {
                    
//#line 170 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
x10.lang.Runtime.ensureNotInAtomic();
                    
//#line 170 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.lang.FinishState x10$__var58 =
                      x10.lang.Runtime.startFinish();
                    
//#line 170 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
try {{
                        {
                            
//#line 171 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394337 =
                              ((long)(((int)(nthreads_))));
                            
//#line 171 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long lookups_per_thread =
                              ((lookups) / (((long)(t394337))));
                            
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
int thread_394509 =
                              0;
                            
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
for (;
                                                                                                                    true;
                                                                                                                    ) {
                                
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394510 =
                                  thread_394509;
                                
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394511 =
                                  ((nthreads_) - (((int)(1))));
                                
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394512 =
                                  ((t394510) < (((int)(t394511))));
                                
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (!(t394512)) {
                                    
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
break;
                                }
                                
//#line 173 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int thread394475 =
                                  thread_394509;
                                
//#line 174 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
x10.lang.Runtime.runAsync(((x10.core.fun.VoidFun_0_0)(new xsbench.Main.$Closure$162(thread394475,
                                                                                                                                                                                                       lookups_per_thread,
                                                                                                                                                                                                       concs,
                                                                                                                                                                                                       energy_grid,
                                                                                                                                                                                                       nuclide_grids,
                                                                                                                                                                                                       mats, (xsbench.Main.$Closure$162.__2$1x10$lang$Rail$1x10$lang$Double$2$2__3$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Rail$1x10$lang$Int$2$2) null))));
                                
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394482 =
                                  thread_394509;
                                
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394483 =
                                  ((t394482) + (((int)(1))));
                                
//#line 172 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
thread_394509 = t394483;
                            }
                            
//#line 195 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int thread394513 =
                              ((nthreads_) - (((int)(1))));
                            
//#line 196 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail macro_xs_vector394514 =
                              ((x10.core.Rail)(new x10.core.Rail<x10.core.Double>(x10.rtt.Types.DOUBLE, ((long)(5L)))));
                            
//#line 197 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394515 =
                              ((thread394513) + (((int)(1))));
                            
//#line 197 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394516 =
                              ((t394515) * (((int)(19))));
                            
//#line 197 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394517 =
                              ((t394516) + (((int)(17))));
                            
//#line 197 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394518 =
                              ((long)(int)(((int)(t394517))));
                            
//#line 197 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.lang.Cell seed394519 =
                              ((x10.lang.Cell)(new x10.lang.Cell<x10.core.ULong>((java.lang.System[]) null, x10.rtt.Types.ULONG).x10$lang$Cell$$init$S(x10.core.ULong.$box(t394518), (x10.lang.Cell.__0x10$lang$Cell$$T) null)));
                            
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394505 =
                              ((long)(((int)(thread394513))));
                            
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
long i394506 =
                              ((lookups_per_thread) * (((long)(t394505))));
                            
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
for (;
                                                                                                                    true;
                                                                                                                    ) {
                                
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394507 =
                                  i394506;
                                
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394508 =
                                  ((t394507) < (((long)(lookups))));
                                
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (!(t394508)) {
                                    
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
break;
                                }
                                
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
boolean t394484 =
                                  xsbench.XSbench_header.INFO;
                                
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394484) {
                                    
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394484 = ((int) thread394513) ==
                                    ((int) 0);
                                }
                                
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
boolean t394485 =
                                  t394484;
                                
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394485) {
                                    
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394486 =
                                      i394506;
                                    
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394487 =
                                      ((t394486) % (((long)(1000L))));
                                    
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394485 = ((long) t394487) ==
                                    ((long) 0L);
                                }
                                
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394488 =
                                  t394485;
                                
//#line 201 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394488) {
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394489 =
                                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394490 =
                                      i394506;
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394491 =
                                      ((long)(((int)(thread394513))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394492 =
                                      ((lookups_per_thread) * (((long)(t394491))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394493 =
                                      ((t394490) - (((long)(t394492))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394494 =
                                      ((double)(long)(((long)(t394493))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394495 =
                                      ((100.0) * (((double)(t394494))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394496 =
                                      ((long)(((int)(thread394513))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394497 =
                                      ((lookups_per_thread) * (((long)(t394496))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394498 =
                                      ((lookups) - (((long)(t394497))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394499 =
                                      ((double)(long)(((long)(t394498))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394500 =
                                      ((t394495) / (((double)(t394499))));
                                    
//#line 202 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394489.printf(((java.lang.String)("\rCalculating XS\'s... (%.0f%% completed)")),
                                                                                                                                      x10.core.Double.$box(t394500));
                                }
                                
//#line 205 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double p_energy394501 =
                                  xsbench.XSutils.rn__0$1x10$lang$ULong$2$O(((x10.lang.Cell)(seed394519)));
                                
//#line 206 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long mat394502 =
                                  xsbench.Materials.pick_mat__0$1x10$lang$ULong$2$O(((x10.lang.Cell)(seed394519)));
                                
//#line 211 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.CalculateXS.calculate_macro_xs__2$1x10$lang$Rail$1x10$lang$Double$2$2__3$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Rail$1x10$lang$Int$2$2__6$1x10$lang$Double$2((double)(p_energy394501),
                                                                                                                                                                                                                                                                                                                                                                 (long)(mat394502),
                                                                                                                                                                                                                                                                                                                                                                 ((x10.core.Rail)(concs)),
                                                                                                                                                                                                                                                                                                                                                                 ((x10.core.Rail)(energy_grid)),
                                                                                                                                                                                                                                                                                                                                                                 ((x10.core.Rail)(nuclide_grids)),
                                                                                                                                                                                                                                                                                                                                                                 ((x10.core.Rail)(mats)),
                                                                                                                                                                                                                                                                                                                                                                 ((x10.core.Rail)(macro_xs_vector394514)));
                                
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394503 =
                                  i394506;
                                
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394504 =
                                  ((t394503) + (((long)(1L))));
                                
//#line 199 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
i394506 = t394504;
                            }
                        }
                    }}catch (java.lang.Throwable __lowerer__var__0__) {
                        
//#line 170 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
x10.lang.Runtime.pushException(((java.lang.Throwable)(__lowerer__var__0__)));
                        
//#line 170 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
throw new java.lang.RuntimeException();
                    }finally {{
                         
//#line 170 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
x10.lang.Runtime.stopFinish(((x10.lang.FinishState)(x10$__var58)));
                     }}
                    }
                }
            
//#line 223 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394399 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 223 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394399.print(((java.lang.String)("\n")));
            
//#line 224 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394400 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 224 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394400.print(((java.lang.String)("Simulation complete.\n")));
            
//#line 226 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double omp_end =
              xsbench.FakeOMP.omp_get_wtime$O();
            
//#line 232 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.border_print();
            
//#line 233 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.center_print(((java.lang.String)("RESULTS")),
                                                                                                                            (long)(79L));
            
//#line 234 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.border_print();
            
//#line 237 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394401 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 237 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394402 =
              nthreads;
            
//#line 237 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394401.printf(((java.lang.String)("Threads:     %d\n")),
                                                                                                              x10.core.Int.$box(t394402));
            
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394403 =
              xsbench.XSbench_header.EXTRA_FLOPS;
            
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394406 =
              false;
            
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394406) {
                
//#line 239 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394404 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 239 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394405 =
                  xsbench.XSbench_header.EXTRA_FLOPS;
                
//#line 239 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394404.printf(((java.lang.String)("Extra Flops: %d\n")),
                                                                                                                  x10.core.Long.$box(t394405));
            }
            
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394407 =
              xsbench.XSbench_header.EXTRA_LOADS;
            
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394410 =
              false;
            
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394410) {
                
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394408 =
                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394409 =
                  xsbench.XSbench_header.EXTRA_LOADS;
                
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394408.printf(((java.lang.String)("Extra Loads: %d\n")),
                                                                                                                  x10.core.Long.$box(t394409));
            }
            
//#line 242 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394411 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 242 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394412 =
              ((omp_end) - (((double)(omp_start))));
            
//#line 242 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394411.printf(((java.lang.String)("Runtime:     %.3f seconds\n")),
                                                                                                              x10.core.Double.$box(t394412));
            
//#line 243 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394413 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 243 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394413.print(((java.lang.String)("Lookups:     ")));
            
//#line 243 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.fancy_int((long)(lookups));
            
//#line 244 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394414 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 244 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394414.print(((java.lang.String)("Lookups/s:   ")));
            
//#line 244 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394415 =
              ((double)(long)(((long)(lookups))));
            
//#line 244 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394416 =
              ((omp_end) - (((double)(omp_start))));
            
//#line 244 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394417 =
              ((t394415) / (((double)(t394416))));
            
//#line 244 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394418 =
              ((long)(double)(((double)(t394417))));
            
//#line 244 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.fancy_int((long)(t394418));
            
//#line 245 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.XSutils.border_print();
            
//#line 248 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394428 =
              xsbench.XSbench_header.SAVE;
            
//#line 248 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394428) {
                
//#line 249 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.File t394419 =
                  ((x10.io.File)(new x10.io.File((java.lang.System[]) null).x10$io$File$$init$S(((java.lang.String)("results.txt")))));
                
//#line 249 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.FileWriter t394420 =
                  t394419.openWrite((boolean)(true));
                
//#line 249 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer out =
                  ((x10.io.Printer)(new x10.io.Printer((java.lang.System[]) null).x10$io$Printer$$init$S(((x10.io.Writer)(t394420)))));
                
//#line 250 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394421 =
                  bgq_mode;
                
//#line 250 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final java.lang.Object t394424 =
                  ((java.lang.Object)
                    x10.core.Int.$box(t394421));
                
//#line 250 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394425 =
                  nthreads;
                
//#line 250 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394422 =
                  ((double)(long)(((long)(lookups))));
                
//#line 250 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394423 =
                  ((omp_end) - (((double)(omp_start))));
                
//#line 250 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394426 =
                  ((t394422) / (((double)(t394423))));
                
//#line 250 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail t394427 =
                  ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<java.lang.Object> makeRailFromJavaArray(x10.rtt.Types.ANY, new java.lang.Object[] {t394424, t394425, t394426})));
                
//#line 250 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
out.printf__1$1x10$lang$Any$2(((java.lang.String)("c%d\t%d\t%.0f\n")),
                                                                                                                                 ((x10.core.Rail)(t394427)));
                
//#line 251 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
out.close();
            }
            }
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final public xsbench.Main
                                                                                           xsbench$Main$$this$xsbench$Main(
                                                                                           ){
            
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
return xsbench.Main.this;
        }
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"

        // constructor for non-virtual call
        final public xsbench.Main xsbench$Main$$init$S() { {
                                                                  
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
;
                                                                  
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"

                                                                  
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
this.__fieldInitializers_xsbench_Main();
                                                              }
                                                              return this;
                                                              }
        
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final public void
                                                                                           __fieldInitializers_xsbench_Main(
                                                                                           ){
            
        }
        
        @x10.runtime.impl.java.X10Generated final public static class $Closure$162 extends x10.core.Ref implements x10.core.fun.VoidFun_0_0, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$162> $RTT = x10.rtt.StaticVoidFunType.<$Closure$162> make(
            $Closure$162.class, new x10.rtt.Type[] {x10.core.fun.VoidFun_0_0.$RTT}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Main.$Closure$162 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$162.class + " calling"); } 
                $_obj.thread394475 = $deserializer.readInt();
                $_obj.lookups_per_thread = $deserializer.readLong();
                $_obj.concs = $deserializer.readRef();
                $_obj.energy_grid = $deserializer.readRef();
                $_obj.nuclide_grids = $deserializer.readRef();
                $_obj.mats = $deserializer.readRef();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.Main.$Closure$162 $_obj = new xsbench.Main.$Closure$162((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                $serializer.write(this.thread394475);
                $serializer.write(this.lookups_per_thread);
                if (concs instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.concs);
                } else {
                $serializer.write(this.concs);
                }
                if (energy_grid instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.energy_grid);
                } else {
                $serializer.write(this.energy_grid);
                }
                if (nuclide_grids instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.nuclide_grids);
                } else {
                $serializer.write(this.nuclide_grids);
                }
                if (mats instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.mats);
                } else {
                $serializer.write(this.mats);
                }
                
            }
            
            // constructor just for allocation
            public $Closure$162(final java.lang.System[] $dummy) { 
            }
            
                
                public void
                  $apply(
                  ){
                    
//#line 174 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
try {{
                        
//#line 175 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.core.Rail macro_xs_vector394476 =
                          ((x10.core.Rail)(new x10.core.Rail<x10.core.Double>(x10.rtt.Types.DOUBLE, ((long)(5L)))));
                        
//#line 176 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394477 =
                          ((this.
                              thread394475) + (((int)(1))));
                        
//#line 176 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394478 =
                          ((t394477) * (((int)(19))));
                        
//#line 176 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final int t394479 =
                          ((t394478) + (((int)(17))));
                        
//#line 176 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394480 =
                          ((long)(int)(((int)(t394479))));
                        
//#line 176 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.lang.Cell seed394481 =
                          ((x10.lang.Cell)(new x10.lang.Cell<x10.core.ULong>((java.lang.System[]) null, x10.rtt.Types.ULONG).x10$lang$Cell$$init$S(x10.core.ULong.$box(t394480), (x10.lang.Cell.__0x10$lang$Cell$$T) null)));
                        
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394468 =
                          ((long)(((int)(this.
                                           thread394475))));
                        
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
long i394469 =
                          ((this.
                              lookups_per_thread) * (((long)(t394468))));
                        
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
for (;
                                                                                                                true;
                                                                                                                ) {
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394470 =
                              i394469;
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394471 =
                              ((long)(((int)(this.
                                               thread394475))));
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394472 =
                              ((t394471) + (((long)(1L))));
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394473 =
                              ((this.
                                  lookups_per_thread) * (((long)(t394472))));
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394474 =
                              ((t394470) < (((long)(t394473))));
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (!(t394474)) {
                                
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
break;
                            }
                            
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
boolean t394450 =
                              xsbench.XSbench_header.INFO;
                            
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394450) {
                                
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394450 = ((int) this.
                                                                                                                                      thread394475) ==
                                ((int) 0);
                            }
                            
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
boolean t394451 =
                              t394450;
                            
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394451) {
                                
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394452 =
                                  i394469;
                                
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394453 =
                                  ((t394452) % (((long)(1000L))));
                                
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394451 = ((long) t394453) ==
                                ((long) 0L);
                            }
                            
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final boolean t394454 =
                              t394451;
                            
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
if (t394454) {
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final x10.io.Printer t394455 =
                                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394456 =
                                  i394469;
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394457 =
                                  ((long)(((int)(this.
                                                   thread394475))));
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394458 =
                                  ((this.
                                      lookups_per_thread) * (((long)(t394457))));
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394459 =
                                  ((t394456) - (((long)(t394458))));
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394460 =
                                  ((double)(long)(((long)(t394459))));
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394461 =
                                  ((100.0) * (((double)(t394460))));
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394462 =
                                  ((double)(long)(((long)(this.
                                                            lookups_per_thread))));
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double t394463 =
                                  ((t394461) / (((double)(t394462))));
                                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
t394455.printf(((java.lang.String)("\rCalculating XS\'s... (%.0f%% completed)")),
                                                                                                                                  x10.core.Double.$box(t394463));
                            }
                            
//#line 184 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final double p_energy394464 =
                              xsbench.XSutils.rn__0$1x10$lang$ULong$2$O(((x10.lang.Cell)(seed394481)));
                            
//#line 185 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long mat394465 =
                              xsbench.Materials.pick_mat__0$1x10$lang$ULong$2$O(((x10.lang.Cell)(seed394481)));
                            
//#line 190 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
xsbench.CalculateXS.calculate_macro_xs__2$1x10$lang$Rail$1x10$lang$Double$2$2__3$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Rail$1x10$lang$Int$2$2__6$1x10$lang$Double$2((double)(p_energy394464),
                                                                                                                                                                                                                                                                                                                                                             (long)(mat394465),
                                                                                                                                                                                                                                                                                                                                                             ((x10.core.Rail)(this.
                                                                                                                                                                                                                                                                                                                                                                                concs)),
                                                                                                                                                                                                                                                                                                                                                             ((x10.core.Rail)(this.
                                                                                                                                                                                                                                                                                                                                                                                energy_grid)),
                                                                                                                                                                                                                                                                                                                                                             ((x10.core.Rail)(this.
                                                                                                                                                                                                                                                                                                                                                                                nuclide_grids)),
                                                                                                                                                                                                                                                                                                                                                             ((x10.core.Rail)(this.
                                                                                                                                                                                                                                                                                                                                                                                mats)),
                                                                                                                                                                                                                                                                                                                                                             ((x10.core.Rail)(macro_xs_vector394476)));
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394466 =
                              i394469;
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
final long t394467 =
                              ((t394466) + (((long)(1L))));
                            
//#line 178 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
i394469 = t394467;
                        }
                    }}catch (java.lang.Error __lowerer__var__0__) {
                        
//#line 174 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
throw __lowerer__var__0__;
                    }catch (java.lang.Throwable __lowerer__var__1__) {
                        
//#line 174 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Main.x10"
throw x10.rtt.Types.EXCEPTION.isInstance(__lowerer__var__1__) ? (java.lang.RuntimeException)(__lowerer__var__1__) : new x10.lang.WrappedThrowable(__lowerer__var__1__);
                    }
                }
                
                public int thread394475;
                public long lookups_per_thread;
                public x10.core.Rail<x10.core.Rail<x10.core.Double>> concs;
                public x10.core.Rail<xsbench.XSbench_header.GridPoint> energy_grid;
                public x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids;
                public x10.core.Rail<x10.core.Rail<x10.core.Int>> mats;
                
                public $Closure$162(final int thread394475,
                                    final long lookups_per_thread,
                                    final x10.core.Rail<x10.core.Rail<x10.core.Double>> concs,
                                    final x10.core.Rail<xsbench.XSbench_header.GridPoint> energy_grid,
                                    final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids,
                                    final x10.core.Rail<x10.core.Rail<x10.core.Int>> mats, __2$1x10$lang$Rail$1x10$lang$Double$2$2__3$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Rail$1x10$lang$Int$2$2 $dummy) { {
                                                                                                                                                                                                                                                                                              this.thread394475 = thread394475;
                                                                                                                                                                                                                                                                                              this.lookups_per_thread = lookups_per_thread;
                                                                                                                                                                                                                                                                                              this.concs = ((x10.core.Rail)(concs));
                                                                                                                                                                                                                                                                                              this.energy_grid = ((x10.core.Rail)(energy_grid));
                                                                                                                                                                                                                                                                                              this.nuclide_grids = ((x10.core.Rail)(nuclide_grids));
                                                                                                                                                                                                                                                                                              this.mats = ((x10.core.Rail)(mats));
                                                                                                                                                                                                                                                                                          }}
                // synthetic type for parameter mangling
                public static final class __2$1x10$lang$Rail$1x10$lang$Double$2$2__3$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Rail$1x10$lang$Int$2$2 {}
                
            }
            
        
        }
        
        