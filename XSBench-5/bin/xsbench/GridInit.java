package xsbench;


@x10.runtime.impl.java.X10Generated abstract public class GridInit extends x10.core.Ref implements xsbench.XSbench_header, x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<GridInit> $RTT = x10.rtt.NamedType.<GridInit> make(
    "xsbench.GridInit", GridInit.class, new x10.rtt.Type[] {xsbench.XSbench_header.$RTT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.GridInit $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + GridInit.class + " calling"); } 
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public GridInit(final java.lang.System[] $dummy) { 
    }
    
        
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final private static x10.core.fun.Fun_0_2<xsbench.XSbench_header.NuclideGridPoint,xsbench.XSbench_header.NuclideGridPoint,x10.core.Int> NGP_compare = ((x10.core.fun.Fun_0_2)(new xsbench.GridInit.$Closure$159()));
        
        
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
public static void
                                                                                                generate_grids__0$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(
                                                                                                final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids){
            
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long i =
              0L;
            {
                
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail[] nuclide_grids$value384498 =
                  ((x10.core.Rail[])nuclide_grids.value);
                
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                           true;
                                                                                                           ) {
                    
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384172 =
                      i;
                    
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384173 =
                      ((x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>>)nuclide_grids).
                        size;
                    
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384185 =
                      ((t384172) < (((long)(t384173))));
                    
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384185)) {
                        
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                    }
                    
//#line 15 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384348 =
                      i;
                    
//#line 15 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail nuclide_grids_i384349 =
                      ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)nuclide_grids$value384498[(int)t384348]);
                    
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long j384344 =
                      0L;
                    {
                        
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.NuclideGridPoint[] nuclide_grids_i384349$value384497 =
                          ((xsbench.XSbench_header.NuclideGridPoint[])nuclide_grids_i384349.value);
                        
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                                   true;
                                                                                                                   ) {
                            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384345 =
                              j384344;
                            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384346 =
                              ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)nuclide_grids_i384349).
                                size;
                            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384347 =
                              ((t384345) < (((long)(t384346))));
                            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384347)) {
                                
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                            }
                            
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384340 =
                              j384344;
                            
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.NuclideGridPoint t384341 =
                              ((xsbench.XSbench_header.NuclideGridPoint)nuclide_grids_i384349$value384497[(int)t384340]);
                            
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384341.randomize();
                            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384342 =
                              j384344;
                            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384343 =
                              ((t384342) + (((long)(1L))));
                            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
j384344 = t384343;
                        }
                    }
                    
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384350 =
                      i;
                    
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384351 =
                      ((t384350) + (((long)(1L))));
                    
//#line 14 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
i = t384351;
                }
            }
        }
        
        
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
public static void
                                                                                                sort_nuclide_grids__0$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(
                                                                                                final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids){
            
//#line 24 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384186 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 24 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384186.print(((java.lang.String)("Sorting Nuclide Energy Grids...\n")));
            
//#line 28 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.fun.Fun_0_2 cmp =
              ((x10.core.fun.Fun_0_2)(xsbench.GridInit.NGP_compare));
            
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long i384356 =
              0L;
            {
                
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail[] nuclide_grids$value384499 =
                  ((x10.core.Rail[])nuclide_grids.value);
                
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                           true;
                                                                                                           ) {
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384357 =
                      i384356;
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384358 =
                      ((x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>>)nuclide_grids).
                        size;
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384359 =
                      ((t384357) < (((long)(t384358))));
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384359)) {
                        
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                    }
                    
//#line 31 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384352 =
                      i384356;
                    
//#line 31 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384353 =
                      ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)nuclide_grids$value384499[(int)t384352]);
                    
//#line 31 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
x10.util.RailUtils.<xsbench.XSbench_header.NuclideGridPoint> sort__0$1x10$util$RailUtils$$T$2__1$1x10$util$RailUtils$$T$3x10$util$RailUtils$$T$3x10$lang$Int$2(xsbench.XSbench_header.NuclideGridPoint.$RTT, ((x10.core.Rail)(t384353)),
                                                                                                                                                                                                                                                                         ((x10.core.fun.Fun_0_2)(cmp)));
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384354 =
                      i384356;
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384355 =
                      ((t384354) + (((long)(1L))));
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
i384356 = t384355;
                }
            }
        }
        
        
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
public static x10.core.Rail
                                                                                                generate_energy_grid__0$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(
                                                                                                final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids){
            
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long n_isotopes =
              ((x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>>)nuclide_grids).
                size;
            
//#line 39 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384195 =
              ((x10.core.Rail[])nuclide_grids.value)[(int)0L];
            
//#line 39 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long n_gridpoints =
              ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)t384195).
                size;
            
//#line 41 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384196 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 41 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384196.print(((java.lang.String)("Generating Unionized Energy Grid...\n")));
            
//#line 43 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long n_unionized_grid_points =
              ((n_isotopes) * (((long)(n_gridpoints))));
            
//#line 45 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384197 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 45 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384197.print(((java.lang.String)("Copying and Sorting all nuclide grids...\n")));
            
//#line 47 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail n_grid_sorted =
              ((x10.core.Rail)(xsbench.XSutils.gpmatrix((long)(1L),
                                                        (long)(n_unionized_grid_points))));
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail n_grid_sorted_flat =
              ((x10.core.Rail[])n_grid_sorted.value)[(int)0L];
            
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long i384367 =
              0L;
            
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long j384368 =
              0L;
            {
                
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail[] nuclide_grids$value384500 =
                  ((x10.core.Rail[])nuclide_grids.value);
                
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                           true;
                                                                                                           ) {
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384369 =
                      i384367;
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384370 =
                      ((t384369) < (((long)(n_isotopes))));
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384370)) {
                        
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                    }
                    
//#line 53 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384360 =
                      i384367;
                    
//#line 53 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384361 =
                      ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)nuclide_grids$value384500[(int)t384360]);
                    
//#line 53 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384362 =
                      j384368;
                    
//#line 53 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
x10.core.Rail.<xsbench.XSbench_header.NuclideGridPoint> copy__0$1x10$lang$Rail$$T$2__2$1x10$lang$Rail$$T$2(xsbench.XSbench_header.NuclideGridPoint.$RTT, ((x10.core.Rail)(t384361)),
                                                                                                                                                                                                                     (long)(0L),
                                                                                                                                                                                                                     ((x10.core.Rail)(n_grid_sorted_flat)),
                                                                                                                                                                                                                     (long)(t384362),
                                                                                                                                                                                                                     (long)(n_gridpoints));
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384363 =
                      i384367;
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384364 =
                      ((t384363) + (((long)(1L))));
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
i384367 = t384364;
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384365 =
                      j384368;
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384366 =
                      ((t384365) + (((long)(n_gridpoints))));
                    
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
j384368 = t384366;
                }
            }
            
//#line 58 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.fun.Fun_0_2 cmp =
              ((x10.core.fun.Fun_0_2)(xsbench.GridInit.NGP_compare));
            
//#line 60 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
x10.util.RailUtils.<xsbench.XSbench_header.NuclideGridPoint> sort__0$1x10$util$RailUtils$$T$2__1$1x10$util$RailUtils$$T$3x10$util$RailUtils$$T$3x10$lang$Int$2(xsbench.XSbench_header.NuclideGridPoint.$RTT, ((x10.core.Rail)(n_grid_sorted_flat)),
                                                                                                                                                                                                                                                                 ((x10.core.fun.Fun_0_2)(cmp)));
            
//#line 62 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384208 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 62 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384208.print(((java.lang.String)("Assigning energies to unionized grid...\n")));
            
//#line 64 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.fun.Fun_0_1 t384213 =
              ((x10.core.fun.Fun_0_1)(new xsbench.GridInit.$Closure$160(n_grid_sorted_flat,
                                                                        n_isotopes, (xsbench.GridInit.$Closure$160.__0$1xsbench$XSbench_header$NuclideGridPoint$2) null)));
            
//#line 64 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail energy_grid =
              ((x10.core.Rail)(new x10.core.Rail<xsbench.XSbench_header.GridPoint>(xsbench.XSbench_header.GridPoint.$RTT, ((long)(n_unionized_grid_points)),
                                                                                   ((x10.core.fun.Fun_0_1)(t384213)), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
            
//#line 66 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
xsbench.XSutils.gpmatrix_free__0$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(((x10.core.Rail)(n_grid_sorted)));
            
//#line 68 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
return energy_grid;
        }
        
        
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
public static void
                                                                                                set_grid_ptrs__0$1xsbench$XSbench_header$GridPoint$2__1$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2(
                                                                                                final x10.core.Rail<xsbench.XSbench_header.GridPoint> energy_grid,
                                                                                                final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids){
            
//#line 76 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long n_isotopes =
              ((x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>>)nuclide_grids).
                size;
            
//#line 77 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384214 =
              ((x10.core.Rail[])nuclide_grids.value)[(int)0L];
            
//#line 77 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long n_gridpoints =
              ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)t384214).
                size;
            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384215 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384215.print(((java.lang.String)("Assigning pointers to Unionized Energy Grid...\n")));
            
//#line 82 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384338 =
              xsbench.XSbench_header.$Shadow.get$XSBENCH_NO_ASYNC();
            
//#line 82 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384338) {
                
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long i =
                  0L;
                {
                    
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint[] energy_grid$value384501 =
                      ((xsbench.XSbench_header.GridPoint[])energy_grid.value);
                    
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail[] nuclide_grids$value384502 =
                      ((x10.core.Rail[])nuclide_grids.value);
                    
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                               true;
                                                                                                               ) {
                        
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384217 =
                          i;
                        
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384218 =
                          ((n_isotopes) * (((long)(n_gridpoints))));
                        
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384252 =
                          ((t384217) < (((long)(t384218))));
                        
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384252)) {
                            
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                        }
                        
//#line 88 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384384 =
                          i;
                        
//#line 88 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint t384385 =
                          ((xsbench.XSbench_header.GridPoint)energy_grid$value384501[(int)t384384]);
                        
//#line 88 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double quarry384386 =
                          t384385.
                            energy;
                        
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
boolean t384387 =
                          xsbench.XSbench_header.INFO;
                        
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384387) {
                            
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int t384388 =
                              xsbench.FakeOMP.omp_get_thread_num$O();
                            
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384387 = ((int) t384388) ==
                            ((int) 0);
                        }
                        
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
boolean t384389 =
                          t384387;
                        
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384389) {
                            
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384390 =
                              i;
                            
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384391 =
                              ((t384390) % (((long)(200L))));
                            
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384389 = ((long) t384391) ==
                            ((long) 0L);
                        }
                        
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384392 =
                          t384389;
                        
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384392) {
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384393 =
                              ((x10.io.Printer)(x10.io.Console.get$OUT()));
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384394 =
                              i;
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384395 =
                              ((double)(long)(((long)(t384394))));
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384396 =
                              ((100.0) * (((double)(t384395))));
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384397 =
                              ((n_isotopes) * (((long)(n_gridpoints))));
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int t384398 =
                              xsbench.FakeOMP.omp_get_num_threads$O();
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384399 =
                              ((long)(((int)(t384398))));
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384400 =
                              ((t384397) / (((long)(t384399))));
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384401 =
                              ((double)(long)(((long)(t384400))));
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384402 =
                              ((t384396) / (((double)(t384401))));
                            
//#line 90 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384393.printf(((java.lang.String)("\rAligning Unionized Grid...(%.0f%% complete)")),
                                                                                                                                 x10.core.Double.$box(t384402));
                        }
                        
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long j384381 =
                          0L;
                        {
                            
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                                       true;
                                                                                                                       ) {
                                
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384382 =
                                  j384381;
                                
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384383 =
                                  ((t384382) < (((long)(n_isotopes))));
                                
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384383)) {
                                    
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                                }
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384371 =
                                  i;
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint t384372 =
                                  ((xsbench.XSbench_header.GridPoint)energy_grid$value384501[(int)t384371]);
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384373 =
                                  ((x10.core.Rail)(t384372.
                                                     xs_ptrs));
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384374 =
                                  j384381;
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384375 =
                                  j384381;
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384376 =
                                  ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)nuclide_grids$value384502[(int)t384375]);
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384377 =
                                  xsbench.XSutils.binary_search__0$1xsbench$XSbench_header$NuclideGridPoint$2$O(((x10.core.Rail)(t384376)),
                                                                                                                (double)(quarry384386));
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int t384378 =
                                  ((int)(long)(((long)(t384377))));
                                
//#line 94 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
((int[])t384373.value)[(int)t384374] = t384378;
                                
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384379 =
                                  j384381;
                                
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384380 =
                                  ((t384379) + (((long)(1L))));
                                
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
j384381 = t384380;
                            }
                        }
                        
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384403 =
                          i;
                        
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384404 =
                          ((t384403) + (((long)(1L))));
                        
//#line 87 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
i = t384404;
                    }
                }
            } else {
                
//#line 104 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int nthreads =
                  xsbench.FakeOMP.omp_get_num_threads$O();
                
//#line 105 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long n_unionized_grid_points =
                  ((n_isotopes) * (((long)(n_gridpoints))));
                
//#line 106 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384253 =
                  ((long)(((int)(nthreads))));
                
//#line 106 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long n_unionized_grid_points_per_thread =
                  ((n_unionized_grid_points) / (((long)(t384253))));
                {
                    
//#line 107 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
x10.lang.Runtime.ensureNotInAtomic();
                    
//#line 107 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.lang.FinishState x10$__var57 =
                      x10.lang.Runtime.startFinish();
                    
//#line 107 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
try {{
                        {
                            
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
int thread_384486 =
                              0;
                            
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                                        true;
                                                                                                                        ) {
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int t384487 =
                                  thread_384486;
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384488 =
                                  ((long)(((int)(t384487))));
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384489 =
                                  ((long)(((int)(nthreads))));
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384490 =
                                  ((t384489) - (((long)(1L))));
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384491 =
                                  ((t384488) < (((long)(t384490))));
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384491)) {
                                    
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                                }
                                
//#line 109 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int thread384437 =
                                  thread_384486;
                                
//#line 110 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
x10.lang.Runtime.runAsync(((x10.core.fun.VoidFun_0_0)(new xsbench.GridInit.$Closure$161(thread384437,
                                                                                                                                                                                                               n_unionized_grid_points_per_thread,
                                                                                                                                                                                                               energy_grid,
                                                                                                                                                                                                               n_isotopes,
                                                                                                                                                                                                               nuclide_grids, (xsbench.GridInit.$Closure$161.__2$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2) null))));
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int t384445 =
                                  thread_384486;
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int t384446 =
                                  ((t384445) + (((int)(1))));
                                
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
thread_384486 = t384446;
                            }
                            
//#line 124 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int thread384492 =
                              ((nthreads) - (((int)(1))));
                            
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384482 =
                              ((long)(((int)(thread384492))));
                            
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long i384483 =
                              ((n_unionized_grid_points_per_thread) * (((long)(t384482))));
                            {
                                
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint[] energy_grid$value384503 =
                                  ((xsbench.XSbench_header.GridPoint[])energy_grid.value);
                                
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail[] nuclide_grids$value384504 =
                                  ((x10.core.Rail[])nuclide_grids.value);
                                
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                                            true;
                                                                                                                            ) {
                                    
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384484 =
                                      i384483;
                                    
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384485 =
                                      ((t384484) < (((long)(n_unionized_grid_points))));
                                    
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384485)) {
                                        
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                                    }
                                    
//#line 126 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384460 =
                                      i384483;
                                    
//#line 126 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint t384461 =
                                      ((xsbench.XSbench_header.GridPoint)energy_grid$value384503[(int)t384460]);
                                    
//#line 126 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double quarry384462 =
                                      t384461.
                                        energy;
                                    
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
boolean t384463 =
                                      xsbench.XSbench_header.INFO;
                                    
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384463) {
                                        
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384463 = ((int) thread384492) ==
                                        ((int) 0);
                                    }
                                    
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
boolean t384464 =
                                      t384463;
                                    
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384464) {
                                        
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384465 =
                                          i384483;
                                        
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384466 =
                                          ((t384465) % (((long)(200L))));
                                        
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384464 = ((long) t384466) ==
                                        ((long) 0L);
                                    }
                                    
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384467 =
                                      t384464;
                                    
//#line 127 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384467) {
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384468 =
                                          ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384469 =
                                          i384483;
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384470 =
                                          ((long)(((int)(thread384492))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384471 =
                                          ((n_unionized_grid_points_per_thread) * (((long)(t384470))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384472 =
                                          ((t384469) - (((long)(t384471))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384473 =
                                          ((double)(long)(((long)(t384472))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384474 =
                                          ((100.0) * (((double)(t384473))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384475 =
                                          ((long)(((int)(thread384492))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384476 =
                                          ((n_unionized_grid_points_per_thread) * (((long)(t384475))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384477 =
                                          ((n_unionized_grid_points) - (((long)(t384476))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384478 =
                                          ((double)(long)(((long)(t384477))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384479 =
                                          ((t384474) / (((double)(t384478))));
                                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384468.printf(((java.lang.String)("\rAligning Unionized Grid...(%.0f%% complete)")),
                                                                                                                                              x10.core.Double.$box(t384479));
                                    }
                                    
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long j384457 =
                                      0L;
                                    {
                                        
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                                                    true;
                                                                                                                                    ) {
                                            
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384458 =
                                              j384457;
                                            
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384459 =
                                              ((t384458) < (((long)(n_isotopes))));
                                            
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384459)) {
                                                
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                                            }
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384447 =
                                              i384483;
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint t384448 =
                                              ((xsbench.XSbench_header.GridPoint)energy_grid$value384503[(int)t384447]);
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384449 =
                                              ((x10.core.Rail)(t384448.
                                                                 xs_ptrs));
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384450 =
                                              j384457;
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384451 =
                                              j384457;
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384452 =
                                              ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)nuclide_grids$value384504[(int)t384451]);
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384453 =
                                              xsbench.XSutils.binary_search__0$1xsbench$XSbench_header$NuclideGridPoint$2$O(((x10.core.Rail)(t384452)),
                                                                                                                            (double)(quarry384462));
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int t384454 =
                                              ((int)(long)(((long)(t384453))));
                                            
//#line 132 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
((int[])t384449.value)[(int)t384450] = t384454;
                                            
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384455 =
                                              j384457;
                                            
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384456 =
                                              ((t384455) + (((long)(1L))));
                                            
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
j384457 = t384456;
                                        }
                                    }
                                    
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384480 =
                                      i384483;
                                    
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384481 =
                                      ((t384480) + (((long)(1L))));
                                    
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
i384483 = t384481;
                                }
                            }
                        }
                    }}catch (java.lang.Throwable __lowerer__var__0__) {
                        
//#line 107 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
x10.lang.Runtime.pushException(((java.lang.Throwable)(__lowerer__var__0__)));
                        
//#line 107 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
throw new java.lang.RuntimeException();
                    }finally {{
                         
//#line 107 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
x10.lang.Runtime.stopFinish(((x10.lang.FinishState)(x10$__var57)));
                     }}
                    }
                }
            
//#line 142 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384339 =
              ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
//#line 142 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384339.print(((java.lang.String)("\n")));
            }
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final public xsbench.GridInit
                                                                                               xsbench$GridInit$$this$xsbench$GridInit(
                                                                                               ){
            
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
return xsbench.GridInit.this;
        }
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"

        // constructor for non-virtual call
        final public xsbench.GridInit xsbench$GridInit$$init$S() { {
                                                                          
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
;
                                                                          
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"

                                                                          
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
this.__fieldInitializers_xsbench_GridInit();
                                                                      }
                                                                      return this;
                                                                      }
        
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final public void
                                                                                               __fieldInitializers_xsbench_GridInit(
                                                                                               ){
            
        }
        
        @x10.runtime.impl.java.X10Generated final public static class $Closure$159 extends x10.core.Ref implements x10.core.fun.Fun_0_2, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$159> $RTT = x10.rtt.StaticFunType.<$Closure$159> make(
            $Closure$159.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_2.$RTT, xsbench.XSbench_header.NuclideGridPoint.$RTT, xsbench.XSbench_header.NuclideGridPoint.$RTT, x10.rtt.Types.INT)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.GridInit.$Closure$159 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$159.class + " calling"); } 
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.GridInit.$Closure$159 $_obj = new xsbench.GridInit.$Closure$159((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Closure$159(final java.lang.System[] $dummy) { 
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
                    
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
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
                
                public $Closure$159() { {
                                               
                                           }}
                
            }
            
        @x10.runtime.impl.java.X10Generated final public static class $Closure$160 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$160> $RTT = x10.rtt.StaticFunType.<$Closure$160> make(
            $Closure$160.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, xsbench.XSbench_header.GridPoint.$RTT)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.GridInit.$Closure$160 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$160.class + " calling"); } 
                $_obj.n_grid_sorted_flat = $deserializer.readRef();
                $_obj.n_isotopes = $deserializer.readLong();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.GridInit.$Closure$160 $_obj = new xsbench.GridInit.$Closure$160((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                if (n_grid_sorted_flat instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.n_grid_sorted_flat);
                } else {
                $serializer.write(this.n_grid_sorted_flat);
                }
                $serializer.write(this.n_isotopes);
                
            }
            
            // constructor just for allocation
            public $Closure$160(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply(x10.core.Long.$unbox(a1));
            }
            
                
                public xsbench.XSbench_header.GridPoint
                  $apply(
                  final long i){
                    
//#line 64 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.NuclideGridPoint t384209 =
                      ((xsbench.XSbench_header.NuclideGridPoint[])this.
                                                                    n_grid_sorted_flat.value)[(int)i];
                    
//#line 64 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384210 =
                      t384209.
                        energy;
                    
//#line 64 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384211 =
                      ((x10.core.Rail)(new x10.core.Rail<x10.core.Int>(x10.rtt.Types.INT, ((long)(this.
                                                                                                    n_isotopes)))));
                    
//#line 64 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint t384212 =
                      ((xsbench.XSbench_header.GridPoint)(new xsbench.XSbench_header.GridPoint((java.lang.System[]) null).xsbench$XSbench_header$GridPoint$$init$S(t384210,
                                                                                                                                                                   ((x10.core.Rail)(t384211)), (xsbench.XSbench_header.GridPoint.__1$1x10$lang$Int$2) null)));
                    
//#line 64 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
return t384212;
                }
                
                public x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint> n_grid_sorted_flat;
                public long n_isotopes;
                
                public $Closure$160(final x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint> n_grid_sorted_flat,
                                    final long n_isotopes, __0$1xsbench$XSbench_header$NuclideGridPoint$2 $dummy) { {
                                                                                                                           this.n_grid_sorted_flat = ((x10.core.Rail)(n_grid_sorted_flat));
                                                                                                                           this.n_isotopes = n_isotopes;
                                                                                                                       }}
                // synthetic type for parameter mangling
                public static final class __0$1xsbench$XSbench_header$NuclideGridPoint$2 {}
                
            }
            
        @x10.runtime.impl.java.X10Generated final public static class $Closure$161 extends x10.core.Ref implements x10.core.fun.VoidFun_0_0, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$161> $RTT = x10.rtt.StaticVoidFunType.<$Closure$161> make(
            $Closure$161.class, new x10.rtt.Type[] {x10.core.fun.VoidFun_0_0.$RTT}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.GridInit.$Closure$161 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$161.class + " calling"); } 
                $_obj.thread384437 = $deserializer.readInt();
                $_obj.n_unionized_grid_points_per_thread = $deserializer.readLong();
                $_obj.energy_grid = $deserializer.readRef();
                $_obj.n_isotopes = $deserializer.readLong();
                $_obj.nuclide_grids = $deserializer.readRef();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.GridInit.$Closure$161 $_obj = new xsbench.GridInit.$Closure$161((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                $serializer.write(this.thread384437);
                $serializer.write(this.n_unionized_grid_points_per_thread);
                if (energy_grid instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.energy_grid);
                } else {
                $serializer.write(this.energy_grid);
                }
                $serializer.write(this.n_isotopes);
                if (nuclide_grids instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.nuclide_grids);
                } else {
                $serializer.write(this.nuclide_grids);
                }
                
            }
            
            // constructor just for allocation
            public $Closure$161(final java.lang.System[] $dummy) { 
            }
            
                
                public void
                  $apply(
                  ){
                    
//#line 110 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
try {{
                        
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384438 =
                          ((long)(((int)(this.
                                           thread384437))));
                        
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long i384439 =
                          ((this.
                              n_unionized_grid_points_per_thread) * (((long)(t384438))));
                        {
                            
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint[] this$LPAREN$$COLON$xsbench$GridInit$$Closure$161$RPAREN$$energy_grid$value384505 =
                              ((xsbench.XSbench_header.GridPoint[])this.
                                                                     energy_grid.value);
                            
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail[] this$LPAREN$$COLON$xsbench$GridInit$$Closure$161$RPAREN$$nuclide_grids$value384506 =
                              ((x10.core.Rail[])this.
                                                  nuclide_grids.value);
                            
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                                        true;
                                                                                                                        ) {
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384440 =
                                  i384439;
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384441 =
                                  ((long)(((int)(this.
                                                   thread384437))));
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384442 =
                                  ((t384441) + (((long)(1L))));
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384443 =
                                  ((this.
                                      n_unionized_grid_points_per_thread) * (((long)(t384442))));
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384444 =
                                  ((t384440) < (((long)(t384443))));
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384444)) {
                                    
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                                }
                                
//#line 112 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384418 =
                                  i384439;
                                
//#line 112 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint t384419 =
                                  ((xsbench.XSbench_header.GridPoint)this$LPAREN$$COLON$xsbench$GridInit$$Closure$161$RPAREN$$energy_grid$value384505[(int)t384418]);
                                
//#line 112 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double quarry384420 =
                                  t384419.
                                    energy;
                                
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
boolean t384421 =
                                  xsbench.XSbench_header.INFO;
                                
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384421) {
                                    
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384421 = ((int) this.
                                                                                                                                              thread384437) ==
                                    ((int) 0);
                                }
                                
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
boolean t384422 =
                                  t384421;
                                
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384422) {
                                    
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384423 =
                                      i384439;
                                    
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384424 =
                                      ((t384423) % (((long)(200L))));
                                    
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384422 = ((long) t384424) ==
                                    ((long) 0L);
                                }
                                
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384425 =
                                  t384422;
                                
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (t384425) {
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.io.Printer t384426 =
                                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384427 =
                                      i384439;
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384428 =
                                      ((long)(((int)(this.
                                                       thread384437))));
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384429 =
                                      ((this.
                                          n_unionized_grid_points_per_thread) * (((long)(t384428))));
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384430 =
                                      ((t384427) - (((long)(t384429))));
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384431 =
                                      ((double)(long)(((long)(t384430))));
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384432 =
                                      ((100.0) * (((double)(t384431))));
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384433 =
                                      ((double)(long)(((long)(this.
                                                                n_unionized_grid_points_per_thread))));
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final double t384434 =
                                      ((t384432) / (((double)(t384433))));
                                    
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
t384426.printf(((java.lang.String)("\rAligning Unionized Grid...(%.0f%% complete)")),
                                                                                                                                          x10.core.Double.$box(t384434));
                                }
                                
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
long j384415 =
                                  0L;
                                {
                                    
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
for (;
                                                                                                                                true;
                                                                                                                                ) {
                                        
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384416 =
                                          j384415;
                                        
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final boolean t384417 =
                                          ((t384416) < (((long)(this.
                                                                  n_isotopes))));
                                        
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
if (!(t384417)) {
                                            
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
break;
                                        }
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384405 =
                                          i384439;
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final xsbench.XSbench_header.GridPoint t384406 =
                                          ((xsbench.XSbench_header.GridPoint)this$LPAREN$$COLON$xsbench$GridInit$$Closure$161$RPAREN$$energy_grid$value384505[(int)t384405]);
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384407 =
                                          ((x10.core.Rail)(t384406.
                                                             xs_ptrs));
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384408 =
                                          j384415;
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384409 =
                                          j384415;
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final x10.core.Rail t384410 =
                                          ((x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>)this$LPAREN$$COLON$xsbench$GridInit$$Closure$161$RPAREN$$nuclide_grids$value384506[(int)t384409]);
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384411 =
                                          xsbench.XSutils.binary_search__0$1xsbench$XSbench_header$NuclideGridPoint$2$O(((x10.core.Rail)(t384410)),
                                                                                                                        (double)(quarry384420));
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final int t384412 =
                                          ((int)(long)(((long)(t384411))));
                                        
//#line 118 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
((int[])t384407.value)[(int)t384408] = t384412;
                                        
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384413 =
                                          j384415;
                                        
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384414 =
                                          ((t384413) + (((long)(1L))));
                                        
//#line 115 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
j384415 = t384414;
                                    }
                                }
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384435 =
                                  i384439;
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
final long t384436 =
                                  ((t384435) + (((long)(1L))));
                                
//#line 111 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
i384439 = t384436;
                            }
                        }
                    }}catch (java.lang.Error __lowerer__var__0__) {
                        
//#line 110 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
throw __lowerer__var__0__;
                    }catch (java.lang.Throwable __lowerer__var__1__) {
                        
//#line 110 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/GridInit.x10"
throw x10.rtt.Types.EXCEPTION.isInstance(__lowerer__var__1__) ? (java.lang.RuntimeException)(__lowerer__var__1__) : new x10.lang.WrappedThrowable(__lowerer__var__1__);
                    }
                }
                
                public int thread384437;
                public long n_unionized_grid_points_per_thread;
                public x10.core.Rail<xsbench.XSbench_header.GridPoint> energy_grid;
                public long n_isotopes;
                public x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids;
                
                public $Closure$161(final int thread384437,
                                    final long n_unionized_grid_points_per_thread,
                                    final x10.core.Rail<xsbench.XSbench_header.GridPoint> energy_grid,
                                    final long n_isotopes,
                                    final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids, __2$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2 $dummy) { {
                                                                                                                                                                                                                                                       this.thread384437 = thread384437;
                                                                                                                                                                                                                                                       this.n_unionized_grid_points_per_thread = n_unionized_grid_points_per_thread;
                                                                                                                                                                                                                                                       this.energy_grid = ((x10.core.Rail)(energy_grid));
                                                                                                                                                                                                                                                       this.n_isotopes = n_isotopes;
                                                                                                                                                                                                                                                       this.nuclide_grids = ((x10.core.Rail)(nuclide_grids));
                                                                                                                                                                                                                                                   }}
                // synthetic type for parameter mangling
                public static final class __2$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2 {}
                
            }
            
        
        }
        
        