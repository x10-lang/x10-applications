package xsbench;


@x10.runtime.impl.java.X10Generated abstract public class CalculateXS extends x10.core.Ref implements xsbench.XSbench_header, x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<CalculateXS> $RTT = x10.rtt.NamedType.<CalculateXS> make(
    "xsbench.CalculateXS", CalculateXS.class, new x10.rtt.Type[] {xsbench.XSbench_header.$RTT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.CalculateXS $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + CalculateXS.class + " calling"); } 
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public CalculateXS(final java.lang.System[] $dummy) { 
    }
    
        
        
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
public static void
                                                                                                  calculate_micro_xs__2$1xsbench$XSbench_header$GridPoint$2__3$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Double$2(
                                                                                                  final double p_energy,
                                                                                                  final int nuc,
                                                                                                  final x10.core.Rail<xsbench.XSbench_header.GridPoint> energy_grid,
                                                                                                  final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids,
                                                                                                  final long idx,
                                                                                                  final x10.core.Rail<x10.core.Double> xs_vector){
            
//#line 15 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233861 =
              ((long)(((int)(nuc))));
            
//#line 15 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.core.Rail grid =
              ((x10.core.Rail[])nuclide_grids.value)[(int)t233861];
            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final xsbench.XSbench_header.GridPoint t233862 =
              ((xsbench.XSbench_header.GridPoint[])energy_grid.value)[(int)idx];
            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.core.Rail t233863 =
              ((x10.core.Rail)(t233862.
                                 xs_ptrs));
            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233864 =
              ((long)(((int)(nuc))));
            
//#line 16 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final int low =
              ((int[])t233863.value)[(int)t233864];
            
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233865 =
              ((long)(((int)(low))));
            
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long high =
              ((t233865) + (((long)(1L))));
            
//#line 19 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final xsbench.XSbench_header.NuclideGridPoint grid_high =
              ((xsbench.XSbench_header.NuclideGridPoint[])grid.value)[(int)high];
            
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233866 =
              ((long)(((int)(low))));
            
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final xsbench.XSbench_header.NuclideGridPoint grid_low =
              ((xsbench.XSbench_header.NuclideGridPoint[])grid.value)[(int)t233866];
            
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233867 =
              grid_high.
                energy;
            
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233870 =
              ((t233867) - (((double)(p_energy))));
            
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233868 =
              grid_high.
                energy;
            
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233869 =
              grid_low.
                energy;
            
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233871 =
              ((t233868) - (((double)(t233869))));
            
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double f =
              ((t233870) / (((double)(t233871))));
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233875 =
              grid_high.
                total_xs;
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233872 =
              grid_high.
                total_xs;
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233873 =
              grid_low.
                total_xs;
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233874 =
              ((t233872) - (((double)(t233873))));
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233876 =
              ((f) * (((double)(t233874))));
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233877 =
              ((t233875) - (((double)(t233876))));
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
((double[])xs_vector.value)[(int)0L] = t233877;
            
//#line 28 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233878 =
              xsbench.XSbench_header.ADD_EXTRAS;
            
//#line 28 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (t233878) {
                
//#line 29 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_flops();
                
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_loads__1$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2((int)(nuc),
                                                                                                                                                                                                  ((x10.core.Rail)(nuclide_grids)));
            }
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233882 =
              grid_high.
                elastic_xs;
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233879 =
              grid_high.
                elastic_xs;
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233880 =
              grid_low.
                elastic_xs;
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233881 =
              ((t233879) - (((double)(t233880))));
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233883 =
              ((f) * (((double)(t233881))));
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233884 =
              ((t233882) - (((double)(t233883))));
            
//#line 34 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
((double[])xs_vector.value)[(int)1L] = t233884;
            
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233886 =
              xsbench.XSbench_header.ADD_EXTRAS;
            
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (t233886) {
                
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_flops();
                
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final int t233885 =
                  ((nuc) + (((int)(1))));
                
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_loads__1$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2((int)(t233885),
                                                                                                                                                                                                  ((x10.core.Rail)(nuclide_grids)));
            }
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233890 =
              grid_high.
                absorbtion_xs;
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233887 =
              grid_high.
                absorbtion_xs;
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233888 =
              grid_low.
                absorbtion_xs;
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233889 =
              ((t233887) - (((double)(t233888))));
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233891 =
              ((f) * (((double)(t233889))));
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233892 =
              ((t233890) - (((double)(t233891))));
            
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
((double[])xs_vector.value)[(int)2L] = t233892;
            
//#line 44 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233894 =
              xsbench.XSbench_header.ADD_EXTRAS;
            
//#line 44 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (t233894) {
                
//#line 45 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_flops();
                
//#line 46 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final int t233893 =
                  ((nuc) + (((int)(2))));
                
//#line 46 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_loads__1$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2((int)(t233893),
                                                                                                                                                                                                  ((x10.core.Rail)(nuclide_grids)));
            }
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233898 =
              grid_high.
                fission_xs;
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233895 =
              grid_high.
                fission_xs;
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233896 =
              grid_low.
                fission_xs;
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233897 =
              ((t233895) - (((double)(t233896))));
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233899 =
              ((f) * (((double)(t233897))));
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233900 =
              ((t233898) - (((double)(t233899))));
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
((double[])xs_vector.value)[(int)3L] = t233900;
            
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233902 =
              xsbench.XSbench_header.ADD_EXTRAS;
            
//#line 52 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (t233902) {
                
//#line 53 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_flops();
                
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final int t233901 =
                  ((nuc) + (((int)(3))));
                
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_loads__1$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2((int)(t233901),
                                                                                                                                                                                                  ((x10.core.Rail)(nuclide_grids)));
            }
            
//#line 58 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233906 =
              grid_high.
                nu_fission_xs;
            
//#line 58 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233903 =
              grid_high.
                nu_fission_xs;
            
//#line 58 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233904 =
              grid_low.
                nu_fission_xs;
            
//#line 58 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233905 =
              ((t233903) - (((double)(t233904))));
            
//#line 58 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233907 =
              ((f) * (((double)(t233905))));
            
//#line 58 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233908 =
              ((t233906) - (((double)(t233907))));
            
//#line 58 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
((double[])xs_vector.value)[(int)4L] = t233908;
            
//#line 60 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233910 =
              xsbench.XSbench_header.ADD_EXTRAS;
            
//#line 60 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (t233910) {
                
//#line 61 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_flops();
                
//#line 62 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final int t233909 =
                  ((nuc) + (((int)(4))));
                
//#line 62 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.Do_flops.do_loads__1$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2((int)(t233909),
                                                                                                                                                                                                  ((x10.core.Rail)(nuclide_grids)));
            }
            
//#line 66 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (false) {
                
//#line 67 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final int t233911 =
                  xsbench.FakeOMP.omp_get_thread_num$O();
                
//#line 67 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233921 =
                  ((int) t233911) ==
                ((int) 0);
                
//#line 67 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (t233921) {
                    
//#line 68 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.io.Printer t233912 =
                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                    
//#line 68 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
t233912.printf(((java.lang.String)("Lookup: Energy = %f, nuc = %d\n")),
                                                                                                                            x10.core.Double.$box(p_energy),
                                                                                                                            x10.core.Int.$box(nuc));
                    
//#line 69 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.io.Printer t233913 =
                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                    
//#line 69 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233914 =
                      grid_high.
                        energy;
                    
//#line 69 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233915 =
                      grid_low.
                        energy;
                    
//#line 69 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
t233913.printf(((java.lang.String)("e_h = %f e_l = %f\n")),
                                                                                                                            x10.core.Double.$box(t233914),
                                                                                                                            x10.core.Double.$box(t233915));
                    
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.io.Printer t233916 =
                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                    
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233917 =
                      grid_high.
                        elastic_xs;
                    
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233918 =
                      grid_low.
                        elastic_xs;
                    
//#line 70 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
t233916.printf(((java.lang.String)("xs_h = %f xs_l = %f\n")),
                                                                                                                            x10.core.Double.$box(t233917),
                                                                                                                            x10.core.Double.$box(t233918));
                    
//#line 71 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.io.Printer t233919 =
                      ((x10.io.Printer)(x10.io.Console.get$OUT()));
                    
//#line 71 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233920 =
                      ((double[])xs_vector.value)[(int)1L];
                    
//#line 71 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
t233919.printf(((java.lang.String)("total_xs = %f\n\n")),
                                                                                                                            x10.core.Double.$box(t233920));
                }
            }
        }
        
        
//#line 79 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
public static void
                                                                                                   calculate_macro_xs__2$1x10$lang$Rail$1x10$lang$Double$2$2__3$1xsbench$XSbench_header$GridPoint$2__4$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Rail$1x10$lang$Int$2$2__6$1x10$lang$Double$2(
                                                                                                   final double p_energy,
                                                                                                   final long mat,
                                                                                                   final x10.core.Rail<x10.core.Rail<x10.core.Double>> concs,
                                                                                                   final x10.core.Rail<xsbench.XSbench_header.GridPoint> energy_grid,
                                                                                                   final x10.core.Rail<x10.core.Rail<xsbench.XSbench_header.NuclideGridPoint>> nuclide_grids,
                                                                                                   final x10.core.Rail<x10.core.Rail<x10.core.Int>> mats,
                                                                                                   final x10.core.Rail<x10.core.Double> macro_xs_vector){
            
//#line 85 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.core.Rail xs_vector =
              ((x10.core.Rail)(new x10.core.Rail<x10.core.Double>(x10.rtt.Types.DOUBLE, ((long)(5L)))));
            
//#line 88 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
((x10.core.Rail<x10.core.Double>)macro_xs_vector).clear();
            
//#line 91 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long idx =
              xsbench.CalculateXS.grid_search__1$1xsbench$XSbench_header$GridPoint$2$O((double)(p_energy),
                                                                                       ((x10.core.Rail)(energy_grid)));
            
//#line 100 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.core.Rail mats_mat =
              ((x10.core.Rail[])mats.value)[(int)mat];
            
//#line 101 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.core.Rail concs_mat =
              ((x10.core.Rail[])concs.value)[(int)mat];
            
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
long j233975 =
              0L;
            {
                
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final int[] mats_mat$value233989 =
                  ((int[])mats_mat.value);
                
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double[] concs_mat$value233990 =
                  ((double[])concs_mat.value);
                
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
for (;
                                                                                                               true;
                                                                                                               ) {
                    
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233976 =
                      j233975;
                    
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233977 =
                      ((x10.core.Rail<x10.core.Int>)mats_mat).
                        size;
                    
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233978 =
                      ((t233976) < (((long)(t233977))));
                    
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (!(t233978)) {
                        
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
break;
                    }
                    
//#line 103 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233958 =
                      j233975;
                    
//#line 103 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final int p_nuc233959 =
                      ((int)mats_mat$value233989[(int)t233958]);
                    
//#line 104 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233960 =
                      j233975;
                    
//#line 104 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double conc233961 =
                      ((double)concs_mat$value233990[(int)t233960]);
                    
//#line 105 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
xsbench.CalculateXS.calculate_micro_xs__2$1xsbench$XSbench_header$GridPoint$2__3$1x10$lang$Rail$1xsbench$XSbench_header$NuclideGridPoint$2$2__5$1x10$lang$Double$2((double)(p_energy),
                                                                                                                                                                                                                                                                                 (int)(p_nuc233959),
                                                                                                                                                                                                                                                                                 ((x10.core.Rail)(energy_grid)),
                                                                                                                                                                                                                                                                                 ((x10.core.Rail)(nuclide_grids)),
                                                                                                                                                                                                                                                                                 (long)(idx),
                                                                                                                                                                                                                                                                                 ((x10.core.Rail)(xs_vector)));
                    
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.core.fun.Fun_0_2 t233962 =
                      ((x10.core.fun.Fun_0_2)(new xsbench.CalculateXS.$Closure$137(conc233961)));
                    
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
x10.util.RailUtils.<x10.core.Double,
                    x10.core.Double,
                    x10.core.Double> map__0$1x10$util$RailUtils$$S$2__1$1x10$util$RailUtils$$T$2__2$1x10$util$RailUtils$$U$2__3$1x10$util$RailUtils$$S$3x10$util$RailUtils$$T$3x10$util$RailUtils$$U$2(x10.rtt.Types.DOUBLE, x10.rtt.Types.DOUBLE, x10.rtt.Types.DOUBLE, ((x10.core.Rail)(macro_xs_vector)),
                                                                                                                                                                                                       ((x10.core.Rail)(xs_vector)),
                                                                                                                                                                                                       ((x10.core.Rail)(macro_xs_vector)),
                                                                                                                                                                                                       ((x10.core.fun.Fun_0_2)(t233962)));
                    
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233967 =
                      j233975;
                    
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233968 =
                      ((t233967) + (((long)(1L))));
                    
//#line 102 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
j233975 = t233968;
                }
            }
            
//#line 112 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (false) {
                
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
long k =
                  0L;
                {
                    
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double[] macro_xs_vector$value233991 =
                      ((double[])macro_xs_vector.value);
                    
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
for (;
                                                                                                                   true;
                                                                                                                   ) {
                        
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233934 =
                          k;
                        
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233935 =
                          ((x10.core.Rail<x10.core.Double>)macro_xs_vector).
                            size;
                        
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233942 =
                          ((t233934) < (((long)(t233935))));
                        
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (!(t233942)) {
                            
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
break;
                        }
                        
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final x10.io.Printer t233969 =
                          ((x10.io.Printer)(x10.io.Console.get$OUT()));
                        
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233970 =
                          k;
                        
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233971 =
                          k;
                        
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233972 =
                          ((double)macro_xs_vector$value233991[(int)t233971]);
                        
//#line 114 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
t233969.printf(((java.lang.String)("Energy: %f, Material: %d, XSVector[%d]: %f\n")),
                                                                                                                                 x10.core.Double.$box(p_energy),
                                                                                                                                 x10.core.Long.$box(mat),
                                                                                                                                 x10.core.Long.$box(t233970),
                                                                                                                                 x10.core.Double.$box(t233972));
                        
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233973 =
                          k;
                        
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233974 =
                          ((t233973) + (((long)(1L))));
                        
//#line 113 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
k = t233974;
                    }
                }
            }
        }
        
        
//#line 123 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
public static long
                                                                                                    grid_search__1$1xsbench$XSbench_header$GridPoint$2$O(
                                                                                                    final double quarry,
                                                                                                    final x10.core.Rail<xsbench.XSbench_header.GridPoint> A){
            
//#line 124 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
long lowerLimit =
              0L;
            
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233943 =
              ((x10.core.Rail<xsbench.XSbench_header.GridPoint>)A).
                size;
            
//#line 125 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
long upperLimit =
              ((t233943) - (((long)(1L))));
            
//#line 126 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233944 =
              upperLimit;
            
//#line 126 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233945 =
              lowerLimit;
            
//#line 126 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
long length =
              ((t233944) - (((long)(t233945))));
            {
                
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final xsbench.XSbench_header.GridPoint[] A$value233992 =
                  ((xsbench.XSbench_header.GridPoint[])A.value);
                
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
while (true) {
                    
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233946 =
                      length;
                    
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233956 =
                      ((t233946) > (((long)(1L))));
                    
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (!(t233956)) {
                        
//#line 128 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
break;
                    }
                    
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233979 =
                      lowerLimit;
                    
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233980 =
                      length;
                    
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233981 =
                      ((t233980) / (((long)(2L))));
                    
//#line 129 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long examinationPoint233982 =
                      ((t233979) + (((long)(t233981))));
                    
//#line 130 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final xsbench.XSbench_header.GridPoint t233983 =
                      ((xsbench.XSbench_header.GridPoint)A$value233992[(int)examinationPoint233982]);
                    
//#line 130 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233984 =
                      t233983.
                        energy;
                    
//#line 130 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final boolean t233985 =
                      ((t233984) > (((double)(quarry))));
                    
//#line 130 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
if (t233985) {
                        
//#line 131 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
upperLimit = examinationPoint233982;
                    } else {
                        
//#line 133 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
lowerLimit = examinationPoint233982;
                    }
                    
//#line 134 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233986 =
                      upperLimit;
                    
//#line 134 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233987 =
                      lowerLimit;
                    
//#line 134 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233988 =
                      ((t233986) - (((long)(t233987))));
                    
//#line 134 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
length = t233988;
                }
            }
            
//#line 137 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final long t233957 =
              lowerLimit;
            
//#line 137 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
return t233957;
        }
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final public xsbench.CalculateXS
                                                                                                  xsbench$CalculateXS$$this$xsbench$CalculateXS(
                                                                                                  ){
            
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
return xsbench.CalculateXS.this;
        }
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"

        // constructor for non-virtual call
        final public xsbench.CalculateXS xsbench$CalculateXS$$init$S() { {
                                                                                
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
;
                                                                                
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"

                                                                                
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
this.__fieldInitializers_xsbench_CalculateXS();
                                                                            }
                                                                            return this;
                                                                            }
        
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final public void
                                                                                                  __fieldInitializers_xsbench_CalculateXS(
                                                                                                  ){
            
        }
        
        @x10.runtime.impl.java.X10Generated final public static class $Closure$137 extends x10.core.Ref implements x10.core.fun.Fun_0_2, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$137> $RTT = x10.rtt.StaticFunType.<$Closure$137> make(
            $Closure$137.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_2.$RTT, x10.rtt.Types.DOUBLE, x10.rtt.Types.DOUBLE, x10.rtt.Types.DOUBLE)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.CalculateXS.$Closure$137 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$137.class + " calling"); } 
                $_obj.conc233961 = $deserializer.readDouble();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.CalculateXS.$Closure$137 $_obj = new xsbench.CalculateXS.$Closure$137((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                $serializer.write(this.conc233961);
                
            }
            
            // constructor just for allocation
            public $Closure$137(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1,Z2)=>U.operator()(a1:Z1,a2:Z2):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1, final java.lang.Object a2, final x10.rtt.Type t2) {
            return x10.core.Double.$box($apply$O(x10.core.Double.$unbox(a1), x10.core.Double.$unbox(a2)));
            }
            // dispatcher for method abstract public (Z1,Z2)=>U.operator()(a1:Z1,a2:Z2):U
            public double $apply$D(final java.lang.Object a1, final x10.rtt.Type t1, final java.lang.Object a2, final x10.rtt.Type t2) {
            return $apply$O(x10.core.Double.$unbox(a1), x10.core.Double.$unbox(a2));
            }
            
                
                public double
                  $apply$O(
                  final double a233963,
                  final double b233964){
                    
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233965 =
                      ((b233964) * (((double)(this.
                                                conc233961))));
                    
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
final double t233966 =
                      ((a233963) + (((double)(t233965))));
                    
//#line 108 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/CalculateXS.x10"
return t233966;
                }
                
                public double conc233961;
                
                public $Closure$137(final double conc233961) { {
                                                                      this.conc233961 = conc233961;
                                                                  }}
                
            }
            
        
    }
    
    