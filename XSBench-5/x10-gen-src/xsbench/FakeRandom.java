package xsbench;

@x10.runtime.impl.java.X10Generated abstract public class FakeRandom extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    private static final long serialVersionUID = 1L;
    public static final x10.rtt.RuntimeType<FakeRandom> $RTT = x10.rtt.NamedType.<FakeRandom> make(
    "xsbench.FakeRandom", FakeRandom.class
    );
    public x10.rtt.RuntimeType<?> $getRTT() {return $RTT;}
    
    public x10.rtt.Type<?> $getParam(int i) {return null;}
    private void writeObject(java.io.ObjectOutputStream oos) throws java.io.IOException { if (x10.runtime.impl.java.Runtime.TRACE_SER) { java.lang.System.out.println("Serializer: writeObject(ObjectOutputStream) of " + this + " calling"); } oos.defaultWriteObject(); }
    public static x10.serialization.X10JavaSerializable $_deserialize_body(xsbench.FakeRandom $_obj , x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + FakeRandom.class + " calling"); } 
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
    
        return null;
        
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
    
        
    }
    
    // constructor just for allocation
    public FakeRandom(final java.lang.System[] $dummy) { 
    }
    
        
//#line 5 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
private static x10.util.Random random;
        
        
//#line 7 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
public static void
                                                                                                 srand(
                                                                                                 final long seed){
            
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
final x10.util.Random t10946 =
              ((x10.util.Random)(xsbench.FakeRandom.get$random()));
            
//#line 8 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
t10946.setSeed((long)(seed));
        }
        
        
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
public static double
                                                                                                  rand$O(
                                                                                                  ){
            
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
final x10.util.Random t10947 =
              ((x10.util.Random)(xsbench.FakeRandom.get$random()));
            
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
final int t10948 =
              t10947.nextInt$O();
            
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
final double t10949 =
              ((double)(int)(((int)(t10948))));
            
//#line 11 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
return t10949;
        }
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
final public xsbench.FakeRandom
                                                                                                 xsbench$FakeRandom$$this$xsbench$FakeRandom(
                                                                                                 ){
            
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
return xsbench.FakeRandom.this;
        }
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"

        // constructor for non-virtual call
        final public xsbench.FakeRandom xsbench$FakeRandom$$init$S() { {
                                                                              
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
;
                                                                              
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"

                                                                              
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
this.__fieldInitializers_xsbench_FakeRandom();
                                                                          }
                                                                          return this;
                                                                          }
        
        
        
//#line 3 "/share/bcp2/mtake/local/x10/trunk-ws/XSBench-5/src/xsbench/FakeRandom.x10"
final public void
                                                                                                 __fieldInitializers_xsbench_FakeRandom(
                                                                                                 ){
            
        }
        
        final private static x10.core.concurrent.AtomicInteger initStatus$random = new x10.core.concurrent.AtomicInteger(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED);
        private static x10.lang.ExceptionInInitializer exception$random;
        
        public static x10.util.Random
          get$random(
          ){
            if (((int) xsbench.FakeRandom.initStatus$random.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.INITIALIZED)) {
                return xsbench.FakeRandom.random;
            }
            if (((int) xsbench.FakeRandom.initStatus$random.get()) ==
                ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.FakeRandom.random")));
                }
                throw xsbench.FakeRandom.exception$random;
            }
            if (xsbench.FakeRandom.initStatus$random.compareAndSet((int)(x10.runtime.impl.java.InitDispatcher.UNINITIALIZED),
                                                                   (int)(x10.runtime.impl.java.InitDispatcher.INITIALIZING))) {
                try {{
                    xsbench.FakeRandom.random = ((x10.util.Random)(new x10.util.Random((java.lang.System[]) null).x10$util$Random$$init$S()));
                }}catch (java.lang.Throwable exc$10950) {
                    xsbench.FakeRandom.exception$random = new x10.lang.ExceptionInInitializer(exc$10950);
                    xsbench.FakeRandom.initStatus$random.set((int)(x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED));
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    x10.runtime.impl.java.InitDispatcher.notifyInitialized();
                    throw xsbench.FakeRandom.exception$random;
                }
                if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                      ((boolean) true)) {
                    x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Doing static initialization for field: xsbench.FakeRandom.random")));
                }
                xsbench.FakeRandom.initStatus$random.set((int)(x10.runtime.impl.java.InitDispatcher.INITIALIZED));
                x10.runtime.impl.java.InitDispatcher.lockInitialized();
                x10.runtime.impl.java.InitDispatcher.notifyInitialized();
            } else {
                if (xsbench.FakeRandom.initStatus$random.get() <
                    x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                    x10.runtime.impl.java.InitDispatcher.lockInitialized();
                    while (xsbench.FakeRandom.initStatus$random.get() <
                           x10.runtime.impl.java.InitDispatcher.INITIALIZED) {
                        x10.runtime.impl.java.InitDispatcher.awaitInitialized();
                    }
                    x10.runtime.impl.java.InitDispatcher.unlockInitialized();
                    if (((int) xsbench.FakeRandom.initStatus$random.get()) ==
                        ((int) x10.runtime.impl.java.InitDispatcher.EXCEPTION_RAISED)) {
                        if (((boolean) x10.runtime.impl.java.InitDispatcher.TRACE_STATIC_INIT) ==
                              ((boolean) true)) {
                            x10.runtime.impl.java.InitDispatcher.printStaticInitMessage(((java.lang.String)("Rethrowing ExceptionInInitializer for field: xsbench.FakeRandom.random")));
                        }
                        throw xsbench.FakeRandom.exception$random;
                    }
                }
            }
            return xsbench.FakeRandom.random;
        }
    
}

