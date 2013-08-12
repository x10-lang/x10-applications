package xsbench;

@x10.runtime.impl.java.X10Generated abstract public class Materials extends x10.core.Ref implements xsbench.XSbench_header, x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<Materials> $RTT = x10.rtt.NamedType.<Materials> make(
    "xsbench.Materials", Materials.class, new x10.rtt.Type[] {xsbench.XSbench_header.$RTT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Materials $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Materials.class + " calling"); } 
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public Materials(final java.lang.System[] $dummy) { 
    }
    
        
//#line 9 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> num_nucs_;
        
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> num_nucs_Sml;
        
//#line 24 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> num_nucs_Lrg;
        
        
//#line 28 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
public static x10.core.Rail
                                                                                                 load_num_nucs(
                                                                                                 final long n_isotopes){
            
//#line 50 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail num_nucs;
            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212261 =
              ((long) n_isotopes) ==
            ((long) 68L);
            
//#line 54 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (t212261) {
                
//#line 55 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail t212259 =
                  ((x10.core.Rail)(xsbench.Materials.get$num_nucs_Sml()));
                
//#line 55 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
num_nucs = ((x10.core.Rail)(t212259));
            } else {
                
//#line 57 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail t212260 =
                  ((x10.core.Rail)(xsbench.Materials.get$num_nucs_Lrg()));
                
//#line 57 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
num_nucs = ((x10.core.Rail)(t212260));
            }
            
//#line 59 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return num_nucs;
        }
        
        
//#line 65 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats0_Sml;
        
//#line 69 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats0_Lrg;
        
//#line 72 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats1;
        
//#line 73 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats2;
        
//#line 74 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats3;
        
//#line 75 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats4;
        
//#line 78 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats5;
        
//#line 80 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats6;
        
//#line 82 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats7;
        
//#line 84 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats8;
        
//#line 86 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats9;
        
//#line 88 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats10;
        
//#line 89 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Int> mats11;
        
//#line 92 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Rail<x10.core.Int>> mats_Sml;
        
//#line 93 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Rail<x10.core.Int>> mats_Lrg;
        
        
//#line 96 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
public static x10.core.Rail
                                                                                                 load_mats__0$1x10$lang$Int$2(
                                                                                                 final x10.core.Rail<x10.core.Int> num_nucs,
                                                                                                 final long n_isotopes){
            
//#line 152 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail mats;
            
//#line 155 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212264 =
              ((long) n_isotopes) ==
            ((long) 68L);
            
//#line 155 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (t212264) {
                
//#line 156 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail t212262 =
                  ((x10.core.Rail)(xsbench.Materials.get$mats_Sml()));
                
//#line 156 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
mats = ((x10.core.Rail)(t212262));
            } else {
                
//#line 158 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail t212263 =
                  ((x10.core.Rail)(xsbench.Materials.get$mats_Lrg()));
                
//#line 158 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
mats = ((x10.core.Rail)(t212263));
            }
            
//#line 161 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (false) {
                
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
long i =
                  0L;
                {
                    
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail[] mats$value212399 =
                      ((x10.core.Rail[])mats.value);
                    
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
for (;
                                                                                                                 true;
                                                                                                                 ) {
                        
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212266 =
                          i;
                        
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212267 =
                          ((x10.core.Rail<x10.core.Rail<x10.core.Int>>)mats).
                            size;
                        
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212282 =
                          ((t212266) < (((long)(t212267))));
                        
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (!(t212282)) {
                            
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
break;
                        }
                        
//#line 163 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212339 =
                          i;
                        
//#line 163 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail mats_i212340 =
                          ((x10.core.Rail<x10.core.Int>)mats$value212399[(int)t212339]);
                        
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
long j212335 =
                          0L;
                        {
                            
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final int[] mats_i212340$value212398 =
                              ((int[])mats_i212340.value);
                            
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
for (;
                                                                                                                         true;
                                                                                                                         ) {
                                
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212336 =
                                  j212335;
                                
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212337 =
                                  ((x10.core.Rail<x10.core.Int>)mats_i212340).
                                    size;
                                
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212338 =
                                  ((t212336) < (((long)(t212337))));
                                
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (!(t212338)) {
                                    
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
break;
                                }
                                
//#line 165 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.io.Printer t212328 =
                                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                
//#line 165 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212329 =
                                  i;
                                
//#line 165 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212330 =
                                  j212335;
                                
//#line 165 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212331 =
                                  j212335;
                                
//#line 165 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final int t212332 =
                                  ((int)mats_i212340$value212398[(int)t212331]);
                                
//#line 165 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
t212328.printf(((java.lang.String)("material %d - Nuclide %d: %d\n")),
                                                                                                                                       x10.core.Long.$box(t212329),
                                                                                                                                       x10.core.Long.$box(t212330),
                                                                                                                                       x10.core.Int.$box(t212332));
                                
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212333 =
                                  j212335;
                                
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212334 =
                                  ((t212333) + (((long)(1L))));
                                
//#line 164 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
j212335 = t212334;
                            }
                        }
                        
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212341 =
                          i;
                        
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212342 =
                          ((t212341) + (((long)(1L))));
                        
//#line 162 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
i = t212342;
                    }
                }
            }
            
//#line 170 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return mats;
        }
        
        
//#line 175 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
public static x10.core.Rail
                                                                                                  load_concs__0$1x10$lang$Int$2(
                                                                                                  final x10.core.Rail<x10.core.Int> num_nucs){
            
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212288 =
              ((x10.core.Rail<x10.core.Int>)num_nucs).
                size;
            
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.fun.Fun_0_1 t212289 =
              ((x10.core.fun.Fun_0_1)(new xsbench.Materials.$Closure$111(num_nucs, (xsbench.Materials.$Closure$111.__0$1x10$lang$Int$2) null)));
            
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail concs =
              ((x10.core.Rail)(new x10.core.Rail<x10.core.Rail<x10.core.Double>>(x10.rtt.ParameterizedType.make(x10.core.Rail.$RTT, x10.rtt.Types.DOUBLE), ((long)(t212288)),
                                                                                 ((x10.core.fun.Fun_0_1)(t212289)), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
            
//#line 180 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (false) {
                
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
long i =
                  0L;
                {
                    
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail[] concs$value212401 =
                      ((x10.core.Rail[])concs.value);
                    
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
for (;
                                                                                                                 true;
                                                                                                                 ) {
                        
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212291 =
                          i;
                        
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212292 =
                          ((x10.core.Rail<x10.core.Rail<x10.core.Double>>)concs).
                            size;
                        
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212307 =
                          ((t212291) < (((long)(t212292))));
                        
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (!(t212307)) {
                            
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
break;
                        }
                        
//#line 182 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212354 =
                          i;
                        
//#line 182 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail concs_i212355 =
                          ((x10.core.Rail<x10.core.Double>)concs$value212401[(int)t212354]);
                        
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
long j212350 =
                          0L;
                        {
                            
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final double[] concs_i212355$value212400 =
                              ((double[])concs_i212355.value);
                            
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
for (;
                                                                                                                         true;
                                                                                                                         ) {
                                
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212351 =
                                  j212350;
                                
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212352 =
                                  ((x10.core.Rail<x10.core.Double>)concs_i212355).
                                    size;
                                
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212353 =
                                  ((t212351) < (((long)(t212352))));
                                
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (!(t212353)) {
                                    
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
break;
                                }
                                
//#line 184 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.io.Printer t212343 =
                                  ((x10.io.Printer)(x10.io.Console.get$OUT()));
                                
//#line 184 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212344 =
                                  i;
                                
//#line 184 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212345 =
                                  j212350;
                                
//#line 184 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212346 =
                                  j212350;
                                
//#line 184 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final double t212347 =
                                  ((double)concs_i212355$value212400[(int)t212346]);
                                
//#line 184 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
t212343.printf(((java.lang.String)("concs[%d][%d] = %f\n")),
                                                                                                                                       x10.core.Long.$box(t212344),
                                                                                                                                       x10.core.Long.$box(t212345),
                                                                                                                                       x10.core.Double.$box(t212347));
                                
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212348 =
                                  j212350;
                                
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212349 =
                                  ((t212348) + (((long)(1L))));
                                
//#line 183 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
j212350 = t212349;
                            }
                        }
                        
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212356 =
                          i;
                        
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212357 =
                          ((t212356) + (((long)(1L))));
                        
//#line 181 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
i = t212357;
                    }
                }
            }
            
//#line 189 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return concs;
        }
        
        
//#line 194 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
private static x10.core.Rail<x10.core.Double> dist;
        
        
//#line 210 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
public static long
                                                                                                  pick_mat__0$1x10$lang$ULong$2$O(
                                                                                                  final x10.lang.Cell<x10.core.ULong> seed){
            
//#line 235 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final double roll =
              xsbench.XSutils.rn__0$1x10$lang$ULong$2$O(((x10.lang.Cell)(seed)));
            
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
long i212374 =
              0L;
            
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
for (;
                                                                                                         true;
                                                                                                         ) {
                
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212375 =
                  i212374;
                
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail t212376 =
                  ((x10.core.Rail)(xsbench.Materials.get$dist()));
                
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212377 =
                  ((x10.core.Rail<x10.core.Double>)t212376).
                    size;
                
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212378 =
                  ((t212375) < (((long)(t212377))));
                
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (!(t212378)) {
                    
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
break;
                }
                
//#line 239 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
double running212368 =
                  ((double)(long)(((long)(0L))));
                
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
long j212365 =
                  i212374;
                
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
for (;
                                                                                                             true;
                                                                                                             ) {
                    
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212366 =
                      j212365;
                    
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212367 =
                      ((t212366) > (((long)(0L))));
                    
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (!(t212367)) {
                        
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
break;
                    }
                    
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final double t212358 =
                      running212368;
                    
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail t212359 =
                      ((x10.core.Rail)(xsbench.Materials.get$dist()));
                    
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212360 =
                      j212365;
                    
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final double t212361 =
                      ((double[])t212359.value)[(int)t212360];
                    
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final double t212362 =
                      ((t212358) + (((double)(t212361))));
                    
//#line 241 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
running212368 = t212362;
                    
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212363 =
                      j212365;
                    
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212364 =
                      ((t212363) - (((long)(1L))));
                    
//#line 240 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
j212365 = t212364;
                }
                
//#line 242 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final double t212369 =
                  running212368;
                
//#line 242 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final boolean t212370 =
                  ((roll) < (((double)(t212369))));
                
//#line 242 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
if (t212370) {
                    
//#line 243 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212371 =
                      i212374;
                    
//#line 243 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return t212371;
                }
                
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212372 =
                  i212374;
                
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212373 =
                  ((t212372) + (((long)(1L))));
                
//#line 238 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
i212374 = t212373;
            }
            
//#line 246 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return 0L;
        }
        
        
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final public xsbench.Materials
                                                                                                xsbench$Materials$$this$xsbench$Materials(
                                                                                                ){
            
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return xsbench.Materials.this;
        }
        
        
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"

        // constructor for non-virtual call
        final public xsbench.Materials xsbench$Materials$$init$S() { {
                                                                            
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
;
                                                                            
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"

                                                                            
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
this.__fieldInitializers_xsbench_Materials();
                                                                        }
                                                                        return this;
                                                                        }
        
        
        
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final public void
                                                                                                __fieldInitializers_xsbench_Materials(
                                                                                                ){
            
        }
        
        final private static x10.core.concurrent.AtomicInteger initStatus$dist = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$dist;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats_Lrg = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats_Lrg;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats_Sml = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats_Sml;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats11 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats11;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats10 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats10;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats9 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats9;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats8 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats8;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats7 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats7;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats6 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats6;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats5 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats5;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats4 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats4;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats3 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats3;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats2 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats2;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats1 = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats1;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats0_Lrg = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats0_Lrg;
        final private static x10.core.concurrent.AtomicInteger initStatus$mats0_Sml = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$mats0_Sml;
        final private static x10.core.concurrent.AtomicInteger initStatus$num_nucs_Lrg = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$num_nucs_Lrg;
        final private static x10.core.concurrent.AtomicInteger initStatus$num_nucs_Sml = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$num_nucs_Sml;
        final private static x10.core.concurrent.AtomicInteger initStatus$num_nucs_ = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$num_nucs_;
        
        public static x10.core.Rail
          get$num_nucs_(
          ){
            if (((int) xsbench.Materials.initStatus$num_nucs_.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.num_nucs_;
            }
            if (((int) xsbench.Materials.initStatus$num_nucs_.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.num_nucs_")));
                }
                throw xsbench.Materials.exception$num_nucs_;
            }
            if (xsbench.Materials.initStatus$num_nucs_.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                     (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.num_nucs_ = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {0, 5, 4, 4, 27, 21, 21, 21, 21, 21, 9, 9})));
                }}catch (java.lang.Throwable exc$212379) {
                    xsbench.Materials.exception$num_nucs_ = new x10.lang.ExceptionInInitializer(exc$212379);
                    xsbench.Materials.initStatus$num_nucs_.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$num_nucs_;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.num_nucs_")));
                }
                xsbench.Materials.initStatus$num_nucs_.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$num_nucs_.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$num_nucs_.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$num_nucs_.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.num_nucs_")));
                        }
                        throw xsbench.Materials.exception$num_nucs_;
                    }
                }
            }
            return xsbench.Materials.num_nucs_;
        }
        
        public static x10.core.Rail
          get$num_nucs_Sml(
          ){
            if (((int) xsbench.Materials.initStatus$num_nucs_Sml.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.num_nucs_Sml;
            }
            if (((int) xsbench.Materials.initStatus$num_nucs_Sml.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.num_nucs_Sml")));
                }
                throw xsbench.Materials.exception$num_nucs_Sml;
            }
            if (xsbench.Materials.initStatus$num_nucs_Sml.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                        (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.num_nucs_Sml = ((x10.core.Rail)(new x10.core.Rail<x10.core.Int>(x10.rtt.Types.INT, ((long)(((x10.core.Rail<x10.core.Int>)xsbench.Materials.get$num_nucs_()).
                                                                                                                                   size)),
                                                                                                      ((x10.core.fun.Fun_0_1)(new xsbench.Materials.$Closure$112())), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
                }}catch (java.lang.Throwable exc$212380) {
                    xsbench.Materials.exception$num_nucs_Sml = new x10.lang.ExceptionInInitializer(exc$212380);
                    xsbench.Materials.initStatus$num_nucs_Sml.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$num_nucs_Sml;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.num_nucs_Sml")));
                }
                xsbench.Materials.initStatus$num_nucs_Sml.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$num_nucs_Sml.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$num_nucs_Sml.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$num_nucs_Sml.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.num_nucs_Sml")));
                        }
                        throw xsbench.Materials.exception$num_nucs_Sml;
                    }
                }
            }
            return xsbench.Materials.num_nucs_Sml;
        }
        
        public static x10.core.Rail
          get$num_nucs_Lrg(
          ){
            if (((int) xsbench.Materials.initStatus$num_nucs_Lrg.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.num_nucs_Lrg;
            }
            if (((int) xsbench.Materials.initStatus$num_nucs_Lrg.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.num_nucs_Lrg")));
                }
                throw xsbench.Materials.exception$num_nucs_Lrg;
            }
            if (xsbench.Materials.initStatus$num_nucs_Lrg.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                        (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.num_nucs_Lrg = ((x10.core.Rail)(new x10.core.Rail<x10.core.Int>(x10.rtt.Types.INT, ((long)(((x10.core.Rail<x10.core.Int>)xsbench.Materials.get$num_nucs_()).
                                                                                                                                   size)),
                                                                                                      ((x10.core.fun.Fun_0_1)(new xsbench.Materials.$Closure$113())), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
                }}catch (java.lang.Throwable exc$212381) {
                    xsbench.Materials.exception$num_nucs_Lrg = new x10.lang.ExceptionInInitializer(exc$212381);
                    xsbench.Materials.initStatus$num_nucs_Lrg.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$num_nucs_Lrg;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.num_nucs_Lrg")));
                }
                xsbench.Materials.initStatus$num_nucs_Lrg.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$num_nucs_Lrg.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$num_nucs_Lrg.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$num_nucs_Lrg.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.num_nucs_Lrg")));
                        }
                        throw xsbench.Materials.exception$num_nucs_Lrg;
                    }
                }
            }
            return xsbench.Materials.num_nucs_Lrg;
        }
        
        public static x10.core.Rail
          get$mats0_Sml(
          ){
            if (((int) xsbench.Materials.initStatus$mats0_Sml.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats0_Sml;
            }
            if (((int) xsbench.Materials.initStatus$mats0_Sml.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats0_Sml")));
                }
                throw xsbench.Materials.exception$mats0_Sml;
            }
            if (xsbench.Materials.initStatus$mats0_Sml.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                     (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats0_Sml = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {58, 59, 60, 61, 40, 42, 43, 44, 45, 46, 1, 2, 3, 7, 8, 9, 10, 29, 57, 47, 48, 0, 62, 15, 33, 34, 52, 53, 54, 55, 56, 18, 23, 41})));
                }}catch (java.lang.Throwable exc$212382) {
                    xsbench.Materials.exception$mats0_Sml = new x10.lang.ExceptionInInitializer(exc$212382);
                    xsbench.Materials.initStatus$mats0_Sml.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats0_Sml;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats0_Sml")));
                }
                xsbench.Materials.initStatus$mats0_Sml.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats0_Sml.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats0_Sml.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats0_Sml.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats0_Sml")));
                        }
                        throw xsbench.Materials.exception$mats0_Sml;
                    }
                }
            }
            return xsbench.Materials.mats0_Sml;
        }
        
        public static x10.core.Rail
          get$mats0_Lrg(
          ){
            if (((int) xsbench.Materials.initStatus$mats0_Lrg.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats0_Lrg;
            }
            if (((int) xsbench.Materials.initStatus$mats0_Lrg.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats0_Lrg")));
                }
                throw xsbench.Materials.exception$mats0_Lrg;
            }
            if (xsbench.Materials.initStatus$mats0_Lrg.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                     (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats0_Lrg = ((x10.core.Rail)(new x10.core.Rail<x10.core.Int>(x10.rtt.Types.INT, ((long)(321L)),
                                                                                                   ((x10.core.fun.Fun_0_1)(new xsbench.Materials.$Closure$114())), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
                }}catch (java.lang.Throwable exc$212383) {
                    xsbench.Materials.exception$mats0_Lrg = new x10.lang.ExceptionInInitializer(exc$212383);
                    xsbench.Materials.initStatus$mats0_Lrg.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats0_Lrg;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats0_Lrg")));
                }
                xsbench.Materials.initStatus$mats0_Lrg.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats0_Lrg.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats0_Lrg.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats0_Lrg.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats0_Lrg")));
                        }
                        throw xsbench.Materials.exception$mats0_Lrg;
                    }
                }
            }
            return xsbench.Materials.mats0_Lrg;
        }
        
        public static x10.core.Rail
          get$mats1(
          ){
            if (((int) xsbench.Materials.initStatus$mats1.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats1;
            }
            if (((int) xsbench.Materials.initStatus$mats1.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats1")));
                }
                throw xsbench.Materials.exception$mats1;
            }
            if (xsbench.Materials.initStatus$mats1.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats1 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {63, 64, 65, 66, 67})));
                }}catch (java.lang.Throwable exc$212384) {
                    xsbench.Materials.exception$mats1 = new x10.lang.ExceptionInInitializer(exc$212384);
                    xsbench.Materials.initStatus$mats1.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats1;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats1")));
                }
                xsbench.Materials.initStatus$mats1.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats1.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats1.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats1.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats1")));
                        }
                        throw xsbench.Materials.exception$mats1;
                    }
                }
            }
            return xsbench.Materials.mats1;
        }
        
        public static x10.core.Rail
          get$mats2(
          ){
            if (((int) xsbench.Materials.initStatus$mats2.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats2;
            }
            if (((int) xsbench.Materials.initStatus$mats2.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats2")));
                }
                throw xsbench.Materials.exception$mats2;
            }
            if (xsbench.Materials.initStatus$mats2.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats2 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5})));
                }}catch (java.lang.Throwable exc$212385) {
                    xsbench.Materials.exception$mats2 = new x10.lang.ExceptionInInitializer(exc$212385);
                    xsbench.Materials.initStatus$mats2.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats2;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats2")));
                }
                xsbench.Materials.initStatus$mats2.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats2.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats2.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats2.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats2")));
                        }
                        throw xsbench.Materials.exception$mats2;
                    }
                }
            }
            return xsbench.Materials.mats2;
        }
        
        public static x10.core.Rail
          get$mats3(
          ){
            if (((int) xsbench.Materials.initStatus$mats3.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats3;
            }
            if (((int) xsbench.Materials.initStatus$mats3.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats3")));
                }
                throw xsbench.Materials.exception$mats3;
            }
            if (xsbench.Materials.initStatus$mats3.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats3 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5})));
                }}catch (java.lang.Throwable exc$212386) {
                    xsbench.Materials.exception$mats3 = new x10.lang.ExceptionInInitializer(exc$212386);
                    xsbench.Materials.initStatus$mats3.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats3;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats3")));
                }
                xsbench.Materials.initStatus$mats3.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats3.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats3.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats3.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats3")));
                        }
                        throw xsbench.Materials.exception$mats3;
                    }
                }
            }
            return xsbench.Materials.mats3;
        }
        
        public static x10.core.Rail
          get$mats4(
          ){
            if (((int) xsbench.Materials.initStatus$mats4.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats4;
            }
            if (((int) xsbench.Materials.initStatus$mats4.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats4")));
                }
                throw xsbench.Materials.exception$mats4;
            }
            if (xsbench.Materials.initStatus$mats4.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats4 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {19, 20, 21, 22, 35, 36, 37, 38, 39, 25, 27, 28, 29, 30, 31, 32, 26, 49, 50, 51, 11, 12, 13, 14, 6, 16, 17})));
                }}catch (java.lang.Throwable exc$212387) {
                    xsbench.Materials.exception$mats4 = new x10.lang.ExceptionInInitializer(exc$212387);
                    xsbench.Materials.initStatus$mats4.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats4;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats4")));
                }
                xsbench.Materials.initStatus$mats4.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats4.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats4.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats4.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats4")));
                        }
                        throw xsbench.Materials.exception$mats4;
                    }
                }
            }
            return xsbench.Materials.mats4;
        }
        
        public static x10.core.Rail
          get$mats5(
          ){
            if (((int) xsbench.Materials.initStatus$mats5.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats5;
            }
            if (((int) xsbench.Materials.initStatus$mats5.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats5")));
                }
                throw xsbench.Materials.exception$mats5;
            }
            if (xsbench.Materials.initStatus$mats5.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats5 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5, 19, 20, 21, 22, 35, 36, 37, 38, 39, 25, 49, 50, 51, 11, 12, 13, 14})));
                }}catch (java.lang.Throwable exc$212388) {
                    xsbench.Materials.exception$mats5 = new x10.lang.ExceptionInInitializer(exc$212388);
                    xsbench.Materials.initStatus$mats5.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats5;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats5")));
                }
                xsbench.Materials.initStatus$mats5.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats5.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats5.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats5.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats5")));
                        }
                        throw xsbench.Materials.exception$mats5;
                    }
                }
            }
            return xsbench.Materials.mats5;
        }
        
        public static x10.core.Rail
          get$mats6(
          ){
            if (((int) xsbench.Materials.initStatus$mats6.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats6;
            }
            if (((int) xsbench.Materials.initStatus$mats6.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats6")));
                }
                throw xsbench.Materials.exception$mats6;
            }
            if (xsbench.Materials.initStatus$mats6.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats6 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5, 19, 20, 21, 22, 35, 36, 37, 38, 39, 25, 49, 50, 51, 11, 12, 13, 14})));
                }}catch (java.lang.Throwable exc$212389) {
                    xsbench.Materials.exception$mats6 = new x10.lang.ExceptionInInitializer(exc$212389);
                    xsbench.Materials.initStatus$mats6.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats6;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats6")));
                }
                xsbench.Materials.initStatus$mats6.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats6.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats6.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats6.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats6")));
                        }
                        throw xsbench.Materials.exception$mats6;
                    }
                }
            }
            return xsbench.Materials.mats6;
        }
        
        public static x10.core.Rail
          get$mats7(
          ){
            if (((int) xsbench.Materials.initStatus$mats7.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats7;
            }
            if (((int) xsbench.Materials.initStatus$mats7.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats7")));
                }
                throw xsbench.Materials.exception$mats7;
            }
            if (xsbench.Materials.initStatus$mats7.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats7 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5, 19, 20, 21, 22, 35, 36, 37, 38, 39, 25, 49, 50, 51, 11, 12, 13, 14})));
                }}catch (java.lang.Throwable exc$212390) {
                    xsbench.Materials.exception$mats7 = new x10.lang.ExceptionInInitializer(exc$212390);
                    xsbench.Materials.initStatus$mats7.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats7;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats7")));
                }
                xsbench.Materials.initStatus$mats7.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats7.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats7.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats7.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats7")));
                        }
                        throw xsbench.Materials.exception$mats7;
                    }
                }
            }
            return xsbench.Materials.mats7;
        }
        
        public static x10.core.Rail
          get$mats8(
          ){
            if (((int) xsbench.Materials.initStatus$mats8.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats8;
            }
            if (((int) xsbench.Materials.initStatus$mats8.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats8")));
                }
                throw xsbench.Materials.exception$mats8;
            }
            if (xsbench.Materials.initStatus$mats8.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats8 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5, 19, 20, 21, 22, 35, 36, 37, 38, 39, 25, 49, 50, 51, 11, 12, 13, 14})));
                }}catch (java.lang.Throwable exc$212391) {
                    xsbench.Materials.exception$mats8 = new x10.lang.ExceptionInInitializer(exc$212391);
                    xsbench.Materials.initStatus$mats8.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats8;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats8")));
                }
                xsbench.Materials.initStatus$mats8.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats8.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats8.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats8.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats8")));
                        }
                        throw xsbench.Materials.exception$mats8;
                    }
                }
            }
            return xsbench.Materials.mats8;
        }
        
        public static x10.core.Rail
          get$mats9(
          ){
            if (((int) xsbench.Materials.initStatus$mats9.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats9;
            }
            if (((int) xsbench.Materials.initStatus$mats9.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats9")));
                }
                throw xsbench.Materials.exception$mats9;
            }
            if (xsbench.Materials.initStatus$mats9.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats9 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5, 19, 20, 21, 22, 35, 36, 37, 38, 39, 25, 49, 50, 51, 11, 12, 13, 14})));
                }}catch (java.lang.Throwable exc$212392) {
                    xsbench.Materials.exception$mats9 = new x10.lang.ExceptionInInitializer(exc$212392);
                    xsbench.Materials.initStatus$mats9.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats9;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats9")));
                }
                xsbench.Materials.initStatus$mats9.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats9.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats9.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats9.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats9")));
                        }
                        throw xsbench.Materials.exception$mats9;
                    }
                }
            }
            return xsbench.Materials.mats9;
        }
        
        public static x10.core.Rail
          get$mats10(
          ){
            if (((int) xsbench.Materials.initStatus$mats10.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats10;
            }
            if (((int) xsbench.Materials.initStatus$mats10.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats10")));
                }
                throw xsbench.Materials.exception$mats10;
            }
            if (xsbench.Materials.initStatus$mats10.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                  (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats10 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5, 63, 64, 65, 66, 67})));
                }}catch (java.lang.Throwable exc$212393) {
                    xsbench.Materials.exception$mats10 = new x10.lang.ExceptionInInitializer(exc$212393);
                    xsbench.Materials.initStatus$mats10.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats10;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats10")));
                }
                xsbench.Materials.initStatus$mats10.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats10.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats10.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats10.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats10")));
                        }
                        throw xsbench.Materials.exception$mats10;
                    }
                }
            }
            return xsbench.Materials.mats10;
        }
        
        public static x10.core.Rail
          get$mats11(
          ){
            if (((int) xsbench.Materials.initStatus$mats11.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats11;
            }
            if (((int) xsbench.Materials.initStatus$mats11.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats11")));
                }
                throw xsbench.Materials.exception$mats11;
            }
            if (xsbench.Materials.initStatus$mats11.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                  (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats11 = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Int> makeRailFromJavaArray(x10.rtt.Types.INT, new int[] {24, 41, 4, 5, 63, 64, 65, 66, 67})));
                }}catch (java.lang.Throwable exc$212394) {
                    xsbench.Materials.exception$mats11 = new x10.lang.ExceptionInInitializer(exc$212394);
                    xsbench.Materials.initStatus$mats11.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats11;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats11")));
                }
                xsbench.Materials.initStatus$mats11.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats11.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats11.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats11.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats11")));
                        }
                        throw xsbench.Materials.exception$mats11;
                    }
                }
            }
            return xsbench.Materials.mats11;
        }
        
        public static x10.core.Rail
          get$mats_Sml(
          ){
            if (((int) xsbench.Materials.initStatus$mats_Sml.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats_Sml;
            }
            if (((int) xsbench.Materials.initStatus$mats_Sml.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats_Sml")));
                }
                throw xsbench.Materials.exception$mats_Sml;
            }
            if (xsbench.Materials.initStatus$mats_Sml.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                    (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats_Sml = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Rail<x10.core.Int>> makeRailFromJavaArray(x10.rtt.ParameterizedType.make(x10.core.Rail.$RTT, x10.rtt.Types.INT), new x10.core.Rail[] {xsbench.Materials.get$mats0_Sml(), xsbench.Materials.get$mats1(), xsbench.Materials.get$mats2(), xsbench.Materials.get$mats3(), xsbench.Materials.get$mats4(), xsbench.Materials.get$mats5(), xsbench.Materials.get$mats6(), xsbench.Materials.get$mats7(), xsbench.Materials.get$mats8(), xsbench.Materials.get$mats9(), xsbench.Materials.get$mats10(), xsbench.Materials.get$mats11()})));
                }}catch (java.lang.Throwable exc$212395) {
                    xsbench.Materials.exception$mats_Sml = new x10.lang.ExceptionInInitializer(exc$212395);
                    xsbench.Materials.initStatus$mats_Sml.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats_Sml;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats_Sml")));
                }
                xsbench.Materials.initStatus$mats_Sml.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats_Sml.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats_Sml.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats_Sml.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats_Sml")));
                        }
                        throw xsbench.Materials.exception$mats_Sml;
                    }
                }
            }
            return xsbench.Materials.mats_Sml;
        }
        
        public static x10.core.Rail
          get$mats_Lrg(
          ){
            if (((int) xsbench.Materials.initStatus$mats_Lrg.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.mats_Lrg;
            }
            if (((int) xsbench.Materials.initStatus$mats_Lrg.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats_Lrg")));
                }
                throw xsbench.Materials.exception$mats_Lrg;
            }
            if (xsbench.Materials.initStatus$mats_Lrg.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                    (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.mats_Lrg = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Rail<x10.core.Int>> makeRailFromJavaArray(x10.rtt.ParameterizedType.make(x10.core.Rail.$RTT, x10.rtt.Types.INT), new x10.core.Rail[] {xsbench.Materials.get$mats0_Lrg(), xsbench.Materials.get$mats1(), xsbench.Materials.get$mats2(), xsbench.Materials.get$mats3(), xsbench.Materials.get$mats4(), xsbench.Materials.get$mats5(), xsbench.Materials.get$mats6(), xsbench.Materials.get$mats7(), xsbench.Materials.get$mats8(), xsbench.Materials.get$mats9(), xsbench.Materials.get$mats10(), xsbench.Materials.get$mats11()})));
                }}catch (java.lang.Throwable exc$212396) {
                    xsbench.Materials.exception$mats_Lrg = new x10.lang.ExceptionInInitializer(exc$212396);
                    xsbench.Materials.initStatus$mats_Lrg.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$mats_Lrg;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.mats_Lrg")));
                }
                xsbench.Materials.initStatus$mats_Lrg.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$mats_Lrg.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$mats_Lrg.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$mats_Lrg.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.mats_Lrg")));
                        }
                        throw xsbench.Materials.exception$mats_Lrg;
                    }
                }
            }
            return xsbench.Materials.mats_Lrg;
        }
        
        public static x10.core.Rail
          get$dist(
          ){
            if (((int) xsbench.Materials.initStatus$dist.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.Materials.dist;
            }
            if (((int) xsbench.Materials.initStatus$dist.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.dist")));
                }
                throw xsbench.Materials.exception$dist;
            }
            if (xsbench.Materials.initStatus$dist.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.Materials.dist = ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.core.Double> makeRailFromJavaArray(x10.rtt.Types.DOUBLE, new double[] {0.14, 0.052, 0.275, 0.134, 0.154, 0.064, 0.066, 0.055, 0.008, 0.015, 0.025, 0.013})));
                }}catch (java.lang.Throwable exc$212397) {
                    xsbench.Materials.exception$dist = new x10.lang.ExceptionInInitializer(exc$212397);
                    xsbench.Materials.initStatus$dist.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.Materials.exception$dist;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.Materials.dist")));
                }
                xsbench.Materials.initStatus$dist.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.Materials.initStatus$dist.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.Materials.initStatus$dist.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.Materials.initStatus$dist.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.Materials.dist")));
                        }
                        throw xsbench.Materials.exception$dist;
                    }
                }
            }
            return xsbench.Materials.dist;
        }
        
        @x10.runtime.impl.java.X10Generated final public static class $Closure$110 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$110> $RTT = x10.rtt.StaticFunType.<$Closure$110> make(
            $Closure$110.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.DOUBLE)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Materials.$Closure$110 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$110.class + " calling"); } 
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.Materials.$Closure$110 $_obj = new xsbench.Materials.$Closure$110((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Closure$110(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return x10.core.Double.$box($apply$O(x10.core.Long.$unbox(a1)));
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public double $apply$D(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply$O(x10.core.Long.$unbox(a1));
            }
            
                
                public double
                  $apply$O(
                  final long id$208359){
                    
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final double t212284 =
                      xsbench.FakeRandom.rand$O();
                    
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return t212284;
                }
                
                public $Closure$110() { {
                                               
                                           }}
                
            }
            
        @x10.runtime.impl.java.X10Generated final public static class $Closure$111 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$111> $RTT = x10.rtt.StaticFunType.<$Closure$111> make(
            $Closure$111.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.ParameterizedType.make(x10.core.Rail.$RTT, x10.rtt.Types.DOUBLE))}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Materials.$Closure$111 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$111.class + " calling"); } 
                $_obj.num_nucs = $deserializer.readRef();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.Materials.$Closure$111 $_obj = new xsbench.Materials.$Closure$111((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                if (num_nucs instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.num_nucs);
                } else {
                $serializer.write(this.num_nucs);
                }
                
            }
            
            // constructor just for allocation
            public $Closure$111(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply(x10.core.Long.$unbox(a1));
            }
            
                
                public x10.core.Rail
                  $apply(
                  final long i){
                    
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final int t212283 =
                      ((int[])this.
                                num_nucs.value)[(int)i];
                    
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final long t212285 =
                      ((long)(((int)(t212283))));
                    
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.fun.Fun_0_1 t212286 =
                      ((x10.core.fun.Fun_0_1)(new xsbench.Materials.$Closure$110()));
                    
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
final x10.core.Rail t212287 =
                      ((x10.core.Rail)(new x10.core.Rail<x10.core.Double>(x10.rtt.Types.DOUBLE, t212285,
                                                                          ((x10.core.fun.Fun_0_1)(t212286)), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
                    
//#line 177 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return t212287;
                }
                
                public x10.core.Rail<x10.core.Int> num_nucs;
                
                public $Closure$111(final x10.core.Rail<x10.core.Int> num_nucs, __0$1x10$lang$Int$2 $dummy) { {
                                                                                                                     this.num_nucs = ((x10.core.Rail)(num_nucs));
                                                                                                                 }}
                // synthetic type for parameter mangling
                public static final class __0$1x10$lang$Int$2 {}
                
            }
            
        @x10.runtime.impl.java.X10Generated final public static class $Closure$112 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$112> $RTT = x10.rtt.StaticFunType.<$Closure$112> make(
            $Closure$112.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.INT)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Materials.$Closure$112 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$112.class + " calling"); } 
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.Materials.$Closure$112 $_obj = new xsbench.Materials.$Closure$112((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Closure$112(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return x10.core.Int.$box($apply$O(x10.core.Long.$unbox(a1)));
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public int $apply$I(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply$O(x10.core.Long.$unbox(a1));
            }
            
                
                public int
                  $apply$O(
                  final long i){
                    
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return ((long) i) ==
                    ((long) 0L)
                      ? 34
                      : ((int[])xsbench.Materials.get$num_nucs_().value)[(int)i];
                }
                
                public $Closure$112() { {
                                               
                                           }}
                
            }
            
        @x10.runtime.impl.java.X10Generated final public static class $Closure$113 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$113> $RTT = x10.rtt.StaticFunType.<$Closure$113> make(
            $Closure$113.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.INT)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Materials.$Closure$113 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$113.class + " calling"); } 
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.Materials.$Closure$113 $_obj = new xsbench.Materials.$Closure$113((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Closure$113(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return x10.core.Int.$box($apply$O(x10.core.Long.$unbox(a1)));
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public int $apply$I(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply$O(x10.core.Long.$unbox(a1));
            }
            
                
                public int
                  $apply$O(
                  final long i){
                    
//#line 24 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return ((long) i) ==
                    ((long) 0L)
                      ? 321
                      : ((int[])xsbench.Materials.get$num_nucs_().value)[(int)i];
                }
                
                public $Closure$113() { {
                                               
                                           }}
                
            }
            
        @x10.runtime.impl.java.X10Generated final public static class $Closure$114 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Closure$114> $RTT = x10.rtt.StaticFunType.<$Closure$114> make(
            $Closure$114.class, new x10.rtt.Type[] {x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.INT)}
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.Materials.$Closure$114 $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$114.class + " calling"); } 
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.Materials.$Closure$114 $_obj = new xsbench.Materials.$Closure$114((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Closure$114(final java.lang.System[] $dummy) { 
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return x10.core.Int.$box($apply$O(x10.core.Long.$unbox(a1)));
            }
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public int $apply$I(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply$O(x10.core.Long.$unbox(a1));
            }
            
                
                public int
                  $apply$O(
                  final long i){
                    
//#line 69 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/Materials.x10"
return ((i) < (((long)(((x10.core.Rail<x10.core.Int>)xsbench.Materials.get$mats0_Sml()).
                                                                                                                                    size))))
                      ? ((int[])xsbench.Materials.get$mats0_Sml().value)[(int)i]
                      : ((34) + (((int)(((int)(long)(((long)(i))))))));
                }
                
                public $Closure$114() { {
                                               
                                           }}
                
            }
            
        
        }
        
        