package xsbench;

@x10.runtime.impl.java.X10Generated public interface XSbench_header extends x10.core.Any
{
    public static final x10.rtt.RuntimeType<XSbench_header> $RTT = x10.rtt.NamedType.<XSbench_header> make(
    "xsbench.XSbench_header", XSbench_header.class
    );
    
        
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
@x10.runtime.impl.java.X10Generated public static class GridPoint extends x10.core.Ref implements x10.serialization.X10JavaSerializable
                                                                                                   {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<GridPoint> $RTT = x10.rtt.NamedType.<GridPoint> make(
            "xsbench.XSbench_header.GridPoint", GridPoint.class
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.XSbench_header.GridPoint $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + GridPoint.class + " calling"); } 
                $_obj.energy = $deserializer.readDouble();
                $_obj.xs_ptrs = $deserializer.readRef();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.XSbench_header.GridPoint $_obj = new xsbench.XSbench_header.GridPoint((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                $serializer.write(this.energy);
                if (xs_ptrs instanceof x10.serialization.X10JavaSerializable) {
                $serializer.write((x10.serialization.X10JavaSerializable) this.xs_ptrs);
                } else {
                $serializer.write(this.xs_ptrs);
                }
                
            }
            
            // constructor just for allocation
            public GridPoint(final java.lang.System[] $dummy) { 
            }
            
                
//#line 9 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
public double energy;
                
//#line 10 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
public x10.core.Rail<x10.core.Int> xs_ptrs;
                
                
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
// creation method for java code (1-phase java constructor)
                public GridPoint(final double energy,
                                 final x10.core.Rail<x10.core.Int> xs_ptrs, __1$1x10$lang$Int$2 $dummy){this((java.lang.System[]) null);
                                                                                                            xsbench$XSbench_header$GridPoint$$init$S(energy,xs_ptrs, (xsbench.XSbench_header.GridPoint.__1$1x10$lang$Int$2) null);}
                
                // constructor for non-virtual call
                final public xsbench.XSbench_header.GridPoint xsbench$XSbench_header$GridPoint$$init$S(final double energy,
                                                                                                       final x10.core.Rail<x10.core.Int> xs_ptrs, __1$1x10$lang$Int$2 $dummy) { {
                                                                                                                                                                                       
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
;
                                                                                                                                                                                       
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"

                                                                                                                                                                                       
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.__fieldInitializers_xsbench_XSbench_header_GridPoint();
                                                                                                                                                                                       
//#line 12 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.energy = energy;
                                                                                                                                                                                       
//#line 13 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.xs_ptrs = ((x10.core.Rail)(xs_ptrs));
                                                                                                                                                                                   }
                                                                                                                                                                                   return this;
                                                                                                                                                                                   }
                
                
                
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final public xsbench.XSbench_header.GridPoint
                                                                                                             xsbench$XSbench_header$GridPoint$$this$xsbench$XSbench_header$GridPoint(
                                                                                                             ){
                    
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
return xsbench.XSbench_header.GridPoint.this;
                }
                
                
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final public void
                                                                                                             __fieldInitializers_xsbench_XSbench_header_GridPoint(
                                                                                                             ){
                    
                }
            // synthetic type for parameter mangling
            public static final class __1$1x10$lang$Int$2 {}
            
        }
        
        
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
@x10.runtime.impl.java.X10Generated public static class NuclideGridPoint extends x10.core.Ref implements x10.serialization.X10JavaSerializable
                                                                                                    {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<NuclideGridPoint> $RTT = x10.rtt.NamedType.<NuclideGridPoint> make(
            "xsbench.XSbench_header.NuclideGridPoint", NuclideGridPoint.class
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.XSbench_header.NuclideGridPoint $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + NuclideGridPoint.class + " calling"); } 
                $_obj.energy = $deserializer.readDouble();
                $_obj.total_xs = $deserializer.readDouble();
                $_obj.elastic_xs = $deserializer.readDouble();
                $_obj.absorbtion_xs = $deserializer.readDouble();
                $_obj.fission_xs = $deserializer.readDouble();
                $_obj.nu_fission_xs = $deserializer.readDouble();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                xsbench.XSbench_header.NuclideGridPoint $_obj = new xsbench.XSbench_header.NuclideGridPoint((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                $serializer.write(this.energy);
                $serializer.write(this.total_xs);
                $serializer.write(this.elastic_xs);
                $serializer.write(this.absorbtion_xs);
                $serializer.write(this.fission_xs);
                $serializer.write(this.nu_fission_xs);
                
            }
            
            // constructor just for allocation
            public NuclideGridPoint(final java.lang.System[] $dummy) { 
            }
            
                
//#line 18 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
public double energy;
                
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
public double total_xs;
                
//#line 21 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
public double elastic_xs;
                
//#line 22 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
public double absorbtion_xs;
                
//#line 23 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
public double fission_xs;
                
//#line 24 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
public double nu_fission_xs;
                
                
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final public void
                                                                                                              randomize(
                                                                                                              ){
                    
//#line 27 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final double t212502 =
                      xsbench.FakeRandom.rand$O();
                    
//#line 27 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.energy = t212502;
                    
//#line 28 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final double t212503 =
                      xsbench.FakeRandom.rand$O();
                    
//#line 28 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.total_xs = t212503;
                    
//#line 29 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final double t212504 =
                      xsbench.FakeRandom.rand$O();
                    
//#line 29 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.elastic_xs = t212504;
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final double t212505 =
                      xsbench.FakeRandom.rand$O();
                    
//#line 30 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.absorbtion_xs = t212505;
                    
//#line 31 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final double t212506 =
                      xsbench.FakeRandom.rand$O();
                    
//#line 31 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.fission_xs = t212506;
                    
//#line 32 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final double t212507 =
                      xsbench.FakeRandom.rand$O();
                    
//#line 32 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.nu_fission_xs = t212507;
                }
                
                
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final public xsbench.XSbench_header.NuclideGridPoint
                                                                                                              xsbench$XSbench_header$NuclideGridPoint$$this$xsbench$XSbench_header$NuclideGridPoint(
                                                                                                              ){
                    
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
return xsbench.XSbench_header.NuclideGridPoint.this;
                }
                
                
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
// creation method for java code (1-phase java constructor)
                public NuclideGridPoint(){this((java.lang.System[]) null);
                                              xsbench$XSbench_header$NuclideGridPoint$$init$S();}
                
                // constructor for non-virtual call
                final public xsbench.XSbench_header.NuclideGridPoint xsbench$XSbench_header$NuclideGridPoint$$init$S() { {
                                                                                                                                
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
;
                                                                                                                                
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"

                                                                                                                                
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.__fieldInitializers_xsbench_XSbench_header_NuclideGridPoint();
                                                                                                                            }
                                                                                                                            return this;
                                                                                                                            }
                
                
                
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
final public void
                                                                                                              __fieldInitializers_xsbench_XSbench_header_NuclideGridPoint(
                                                                                                              ){
                    
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.energy = 0.0;
                    
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.total_xs = 0.0;
                    
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.elastic_xs = 0.0;
                    
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.absorbtion_xs = 0.0;
                    
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.fission_xs = 0.0;
                    
//#line 17 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
this.nu_fission_xs = 0.0;
                }
            
        }
        
        
//#line 37 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
boolean ADD_EXTRAS = false;
        
//#line 38 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
long EXTRA_FLOPS = 0L;
        
//#line 39 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
long EXTRA_LOADS = 0L;
        
//#line 42 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
boolean INFO = true;
        
//#line 43 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
boolean DEBUG = true;
        
//#line 44 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
boolean SAVE = true;
        
//#line 45 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
boolean PRINT_PAPI_INFO = true;
        @x10.runtime.impl.java.X10Generated abstract public class $Shadow extends x10.core.Ref implements x10.serialization.X10JavaSerializable
        {
            private static final long serialVersionUID = 1L;
            public static final x10.rtt.RuntimeType<$Shadow> $RTT = x10.rtt.NamedType.<$Shadow> make(
            "xsbench.XSbench_header.$Shadow", $Shadow.class
            );
            public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
            
            public x10.rtt.Type<?> $getParam(int i) {return null;}
            private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
            public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.XSbench_header.$Shadow $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Shadow.class + " calling"); } 
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            
                return null;
                
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
                
            }
            
            // constructor just for allocation
            public $Shadow(final java.lang.System[] $dummy) { 
            }
            
                
//#line 6 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/XSbench_header.x10"
private static boolean XSBENCH_NO_ASYNC = false;
                final private static x10.core.concurrent.AtomicInteger initStatus$XSBENCH_NO_ASYNC = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
                private static x10.lang.ExceptionInInitializer exception$XSBENCH_NO_ASYNC;
                
                public static boolean
                  get$XSBENCH_NO_ASYNC(
                  ){
                    if (((int) xsbench.XSbench_header.$Shadow.initStatus$XSBENCH_NO_ASYNC.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                        return xsbench.XSbench_header.$Shadow.XSBENCH_NO_ASYNC;
                    }
                    if (((int) xsbench.XSbench_header.$Shadow.initStatus$XSBENCH_NO_ASYNC.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.XSbench_header$$Shadow.XSBENCH_NO_ASYNC")));
                        }
                        throw xsbench.XSbench_header.$Shadow.exception$XSBENCH_NO_ASYNC;
                    }
                    if (xsbench.XSbench_header.$Shadow.initStatus$XSBENCH_NO_ASYNC.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                                                 (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                        try {{
                            xsbench.XSbench_header.$Shadow.XSBENCH_NO_ASYNC = ((x10.lang.System.getenv(((java.lang.String)("XSBENCH_NO_ASYNC")))) != (null));
                        }}catch (java.lang.Throwable exc$212508) {
                            xsbench.XSbench_header.$Shadow.exception$XSBENCH_NO_ASYNC = new x10.lang.ExceptionInInitializer(exc$212508);
                            xsbench.XSbench_header.$Shadow.initStatus$XSBENCH_NO_ASYNC.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                            x10.runtime.impl.java.InitDispatcher.lockInitialized();
                            x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                            throw xsbench.XSbench_header.$Shadow.exception$XSBENCH_NO_ASYNC;
                        }
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.XSbench_header$$Shadow.XSBENCH_NO_ASYNC")));
                        }
                        xsbench.XSbench_header.$Shadow.initStatus$XSBENCH_NO_ASYNC.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                        x10.runtime.impl.java.InitDispatcher.lockInitialized();
                        x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    } else {
                        if (xsbench.XSbench_header.$Shadow.initStatus$XSBENCH_NO_ASYNC.get() <
                            x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                            x10.runtime.impl.java.InitDispatcher.lockInitialized();
                            while (xsbench.XSbench_header.$Shadow.initStatus$XSBENCH_NO_ASYNC.get() <
                                   x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                                x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                            }
                            x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                            if (((int) xsbench.XSbench_header.$Shadow.initStatus$XSBENCH_NO_ASYNC.get()) ==
                                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                                      ((boolean) true)) {
                                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.XSbench_header$$Shadow.XSBENCH_NO_ASYNC")));
                                }
                                throw xsbench.XSbench_header.$Shadow.exception$XSBENCH_NO_ASYNC;
                            }
                        }
                    }
                    return xsbench.XSbench_header.$Shadow.XSBENCH_NO_ASYNC;
                }
            
        }
        
    
}

