package xsbench;


@x10.runtime.impl.java.X10Generated abstract public class FakeOMP extends x10.core.Ref implements xsbench.XSbench_header, x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<FakeOMP> $RTT = x10.rtt.NamedType.<FakeOMP> make(
    "xsbench.FakeOMP", FakeOMP.class, new x10.rtt.Type[] {xsbench.XSbench_header.$RTT}
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.FakeOMP $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + FakeOMP.class + " calling"); } 
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public FakeOMP(final java.lang.System[] $dummy) { 
    }
    
        
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
private static x10.lang.Cell<x10.core.Int> num_threads;
        
        
//#line 12 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
public static int
                                                                                               omp_get_num_procs$O(
                                                                                               ){try {return java.lang.Runtime.getRuntime().availableProcessors();}
        catch (java.lang.Throwable exc$234557) {
        throw x10.runtime.impl.java.ThrowableUtils.ensureX10Exception(exc$234557);
        }
        }
        
        
        
//#line 19 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
public static void
                                                                                               omp_set_num_threads(
                                                                                               final int nthreads){
            
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final boolean t234000 =
              xsbench.XSbench_header.$Shadow.get$XSBENCH_NO_ASYNC();
            
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final boolean t234002 =
              !(t234000);
            
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
if (t234002) {
                
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final x10.lang.Cell t234001 =
                  ((x10.lang.Cell)(xsbench.FakeOMP.get$num_threads()));
                
//#line 20 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
((x10.lang.Cell<x10.core.Int>)t234001).$apply__0x10$lang$Cell$$T(x10.core.Int.$box(nthreads));
            }
        }
        
        
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
public static int
                                                                                               omp_get_num_threads$O(
                                                                                               ){
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final x10.lang.Cell t234003 =
              ((x10.lang.Cell)(xsbench.FakeOMP.get$num_threads()));
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final int t234004 =
              x10.core.Int.$unbox(((x10.lang.Cell<x10.core.Int>)t234003).$apply$G());
            
//#line 26 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
return t234004;
        }
        
        
//#line 31 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
public static int
                                                                                               omp_get_thread_num$O(
                                                                                               ){
            
//#line 31 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
return 0;
        }
        
        
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
public static double
                                                                                               omp_get_wtime$O(
                                                                                               ){
            
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final long t234005 =
              x10.lang.System.currentTimeMillis$O();
            
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final double t234006 =
              ((double)(long)(((long)(t234005))));
            
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final double t234007 =
              ((t234006) / (((double)(1000.0))));
            
//#line 36 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
return t234007;
        }
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final public xsbench.FakeOMP
                                                                                              xsbench$FakeOMP$$this$xsbench$FakeOMP(
                                                                                              ){
            
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
return xsbench.FakeOMP.this;
        }
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"

        // constructor for non-virtual call
        final public xsbench.FakeOMP xsbench$FakeOMP$$init$S() { {
                                                                        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
;
                                                                        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"

                                                                        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
this.__fieldInitializers_xsbench_FakeOMP();
                                                                    }
                                                                    return this;
                                                                    }
        
        
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeOMP.x10"
final public void
                                                                                              __fieldInitializers_xsbench_FakeOMP(
                                                                                              ){
            
        }
        
        final private static x10.core.concurrent.AtomicInteger initStatus$num_threads = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$num_threads;
        
        public static x10.lang.Cell
          get$num_threads(
          ){
            if (((int) xsbench.FakeOMP.initStatus$num_threads.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.FakeOMP.num_threads;
            }
            if (((int) xsbench.FakeOMP.initStatus$num_threads.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.FakeOMP.num_threads")));
                }
                throw xsbench.FakeOMP.exception$num_threads;
            }
            if (xsbench.FakeOMP.initStatus$num_threads.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                     (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.FakeOMP.num_threads = ((x10.lang.Cell)(new x10.lang.Cell<x10.core.Int>((java.lang.System[]) null, x10.rtt.Types.INT).x10$lang$Cell$$init$S((x10.core.Int.$box(1)), (x10.lang.Cell.__0x10$lang$Cell$$T) null)));
                }}catch (java.lang.Throwable exc$234008) {
                    xsbench.FakeOMP.exception$num_threads = new x10.lang.ExceptionInInitializer(exc$234008);
                    xsbench.FakeOMP.initStatus$num_threads.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.FakeOMP.exception$num_threads;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.FakeOMP.num_threads")));
                }
                xsbench.FakeOMP.initStatus$num_threads.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.FakeOMP.initStatus$num_threads.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.FakeOMP.initStatus$num_threads.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.FakeOMP.initStatus$num_threads.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.FakeOMP.num_threads")));
                        }
                        throw xsbench.FakeOMP.exception$num_threads;
                    }
                }
            }
            return xsbench.FakeOMP.num_threads;
        }
    
}

