package com.ibm.m3rlite.example;


@x10.runtime.impl.java.X10Generated
public class Histogram extends x10.core.Ref implements com.ibm.m3rlite.Job, x10.serialization.X10JavaSerializable
{
    public static final x10.rtt.RuntimeType<Histogram> $RTT = 
        x10.rtt.NamedType.<Histogram> make("com.ibm.m3rlite.example.Histogram",
                                           Histogram.class,
                                           new x10.rtt.Type[] {
                                               x10.rtt.ParameterizedType.make(com.ibm.m3rlite.Job.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.LONG, x10.rtt.Types.LONG, x10.rtt.Types.LONG, x10.rtt.Types.LONG, x10.rtt.Types.LONG)
                                           });
    
    public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
    
    public x10.rtt.Type<?> $getParam(int i) { return null; }
    
    private Object writeReplace() throws java.io.ObjectStreamException {
        return new x10.serialization.SerializationProxy(this);
    }
    
    public static x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.example.Histogram $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Histogram.class + " calling"); } 
        $_obj.i = $deserializer.readLong();
        $_obj.plh = $deserializer.readObject();
        $_obj.plh2 = $deserializer.readObject();
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
        com.ibm.m3rlite.example.Histogram $_obj = new com.ibm.m3rlite.example.Histogram((java.lang.System[]) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
        $serializer.write(this.i);
        $serializer.write(this.plh);
        $serializer.write(this.plh2);
        
    }
    
    // constructor just for allocation
    public Histogram(final java.lang.System[] $dummy) {
        
    }
    
    // dispatcher for method abstract public com.ibm.m3rlite.Job[K1, V1, K2, V2, K3, V3].partition(k:K2){}:x10.lang.Long
    public java.lang.Object partition(final java.lang.Object a1, final x10.rtt.Type t1) {
        return x10.core.Long.$box(partition$O(x10.core.Long.$unbox(a1)));
        
    }
    
    // dispatcher for method abstract public com.ibm.m3rlite.Job[K1, V1, K2, V2, K3, V3].partition(k:K2){}:x10.lang.Long
    public long partition$J(final java.lang.Object a1, final x10.rtt.Type t1) {
        return partition$O(x10.core.Long.$unbox(a1));
        
    }
    
    // dispatcher for method abstract public com.ibm.m3rlite.Job[K1, V1, K2, V2, K3, V3].sink(x10.lang.Iterable[x10.util.Pair[K3, V3]]){}:void
    public java.lang.Object sink(final x10.lang.Iterable a1, final x10.rtt.Type t1) {
        sink__0$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2((x10.lang.Iterable)a1); return null;
        
    }
    
    // dispatcher for method abstract public com.ibm.m3rlite.Job[K1, V1, K2, V2, K3, V3].sink(x10.lang.Iterable[x10.util.Pair[K3, V3]]){}:void
    public void sink$V(final x10.lang.Iterable a1, final x10.rtt.Type t1) {
        sink__0$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2((x10.lang.Iterable)a1);
        
    }
    
    // dispatcher for method abstract public com.ibm.m3rlite.Job[K1, V1, K2, V2, K3, V3].mapper(K1, V1, (K2,V2)=>void){}:void
    public java.lang.Object mapper(final java.lang.Object a1, final x10.rtt.Type t1, final java.lang.Object a2, final x10.rtt.Type t2, final x10.core.fun.VoidFun_0_2 a3, final x10.rtt.Type t3) {
        mapper__2$1x10$lang$Long$3x10$lang$Long$2(x10.core.Long.$unbox(a1), x10.core.Long.$unbox(a2), (x10.core.fun.VoidFun_0_2)a3); return null;
        
    }
    
    // dispatcher for method abstract public com.ibm.m3rlite.Job[K1, V1, K2, V2, K3, V3].mapper(K1, V1, (K2,V2)=>void){}:void
    public void mapper$V(final java.lang.Object a1, final x10.rtt.Type t1, final java.lang.Object a2, final x10.rtt.Type t2, final x10.core.fun.VoidFun_0_2 a3, final x10.rtt.Type t3) {
        mapper__2$1x10$lang$Long$3x10$lang$Long$2(x10.core.Long.$unbox(a1), x10.core.Long.$unbox(a2), (x10.core.fun.VoidFun_0_2)a3);
        
    }
    
    // dispatcher for method abstract public com.ibm.m3rlite.Job[K1, V1, K2, V2, K3, V3].reducer(K2, x10.lang.Iterable[V2], x10.util.ArrayList[x10.util.Pair[K3, V3]]){}:void
    public java.lang.Object reducer(final java.lang.Object a1, final x10.rtt.Type t1, final x10.lang.Iterable a2, final x10.rtt.Type t2, final x10.util.ArrayList a3, final x10.rtt.Type t3) {
        reducer__1$1x10$lang$Long$2__2$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2(x10.core.Long.$unbox(a1), (x10.lang.Iterable)a2, (x10.util.ArrayList)a3); return null;
        
    }
    
    // dispatcher for method abstract public com.ibm.m3rlite.Job[K1, V1, K2, V2, K3, V3].reducer(K2, x10.lang.Iterable[V2], x10.util.ArrayList[x10.util.Pair[K3, V3]]){}:void
    public void reducer$V(final java.lang.Object a1, final x10.rtt.Type t1, final x10.lang.Iterable a2, final x10.rtt.Type t2, final x10.util.ArrayList a3, final x10.rtt.Type t3) {
        reducer__1$1x10$lang$Long$2__2$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2(x10.core.Long.$unbox(a1), (x10.lang.Iterable)a2, (x10.util.ArrayList)a3);
        
    }
    
    // synthetic type for parameter mangling
    public static final class __0$1x10$lang$Rail$1x10$lang$Long$2$2__1$1x10$util$ArrayList$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2$2 {}
    
    // properties
    
    //#line 12 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public x10.lang.PlaceLocalHandle<x10.core.Rail<x10.core.Long>> plh;
    
    //#line 13 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public x10.lang.PlaceLocalHandle<x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>> plh2;
    

    
    //#line 15 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public long i;
    
    
    //#line 16 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public boolean stop$O() {
        
        //#line 16 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3914 = this.i;
        
        //#line 16 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3915 = ((t$3914) + (((long)(1L))));
        
        //#line 16 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3916 = this.i = t$3915;
        
        //#line 16 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3917 = ((t$3916) - (((long)(1L))));
        
        //#line 16 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final boolean t$3918 = ((t$3917) > (((long)(0L))));
        
        //#line 16 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        return t$3918;
    }
    
    
    //#line 18 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public com.ibm.m3rlite.example.Histogram.Anonymous$619 source() {
        
        //#line 18 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final com.ibm.m3rlite.example.Histogram.Anonymous$619 t$3919 = ((com.ibm.m3rlite.example.Histogram.Anonymous$619)(new com.ibm.m3rlite.example.Histogram.Anonymous$619((java.lang.System[]) null).com$ibm$m3rlite$example$Histogram$Anonymous$619$$init$S(this)));
        
        //#line 18 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        return t$3919;
    }
    
    
    //#line 26 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public long partition$O(final long k) {
        
        //#line 26 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3920 = ((long)x10.x10rt.X10RT.numPlaces());
        
        //#line 26 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3921 = ((k) % (((long)(t$3920))));
        
        //#line 26 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        return t$3921;
    }
    
    
    //#line 28 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public void sink__0$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2(final x10.lang.Iterable s) {
        
        //#line 29 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.lang.Iterator kv$3907 = ((x10.lang.Iterator<x10.util.Pair<x10.core.Long, x10.core.Long>>)
                                            ((x10.lang.Iterable<x10.util.Pair<x10.core.Long, x10.core.Long>>)s).iterator());
        
        //#line 29 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        for (;
             true;
             ) {
            
            //#line 29 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final boolean t$3928 = ((x10.lang.Iterator<x10.util.Pair<x10.core.Long, x10.core.Long>>)kv$3907).hasNext$O();
            
            //#line 29 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            if (!(t$3928)) {
                
                //#line 29 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                break;
            }
            
            //#line 29 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final x10.util.Pair kv$3989 = ((x10.util.Pair)(((x10.lang.Iterator<x10.util.Pair<x10.core.Long, x10.core.Long>>)kv$3907).next$G()));
            
            //#line 30 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final x10.lang.PlaceLocalHandle t$3990 = ((x10.lang.PlaceLocalHandle)(plh2));
            
            //#line 30 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final x10.util.ArrayList t$3991 = ((x10.lang.PlaceLocalHandle<x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>>)t$3990).$apply$G();
            
            //#line 30 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            ((x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>)t$3991).add__0x10$util$ArrayList$$T$O(((x10.util.Pair)(kv$3989)));
            
            //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final x10.io.Printer t$3992 = ((x10.io.Printer)(x10.io.Console.get$OUT()));
            
            //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final java.lang.String t$3993 = ((x10.x10rt.X10RT.here()) + (" sees: "));
            
            //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final java.lang.String t$3994 = ((t$3993) + (kv$3989));
            
            //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            t$3992.println(((java.lang.Object)(t$3994)));
        }
    }
    
    
    //#line 36 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public void mapper__2$1x10$lang$Long$3x10$lang$Long$2(final long k, final long v, final x10.core.fun.VoidFun_0_2 s) {
        
        //#line 37 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        ((x10.core.fun.VoidFun_0_2<x10.core.Long,x10.core.Long>)s).$apply(x10.core.Long.$box(v), x10.rtt.Types.LONG, x10.core.Long.$box(k), x10.rtt.Types.LONG);
    }
    
    
    //#line 40 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public void reducer__1$1x10$lang$Long$2__2$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2(final long a, final x10.lang.Iterable b, final x10.util.ArrayList sink) {
        
        //#line 42 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        long sum = 0L;
        
        //#line 43 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final boolean t$3933 = ((b) != (null));
        
        //#line 43 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        if (t$3933) {
            
            //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final x10.lang.Iterator x$3909 = ((x10.lang.Iterator<x10.core.Long>)
                                               ((x10.lang.Iterable<x10.core.Long>)b).iterator());
            
            //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            for (;
                 true;
                 ) {
                
                //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final boolean t$3932 = ((x10.lang.Iterator<x10.core.Long>)x$3909).hasNext$O();
                
                //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                if (!(t$3932)) {
                    
                    //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    break;
                }
                
                //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long x$3995 = x10.core.Long.$unbox(((x10.lang.Iterator<x10.core.Long>)x$3909).next$G());
                
                //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3996 = sum;
                
                //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3997 = ((t$3996) + (((long)(1L))));
                
                //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                sum = t$3997;
            }
        }
        
        //#line 45 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3934 = a;
        
        //#line 45 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3935 = sum;
        
        //#line 45 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.util.Pair t$3936 = new x10.util.Pair<x10.core.Long, x10.core.Long>((java.lang.System[]) null, x10.rtt.Types.LONG, x10.rtt.Types.LONG).x10$util$Pair$$init$S(x10.core.Long.$box(t$3934), x10.core.Long.$box(t$3935), (x10.util.Pair.__0x10$util$Pair$$T__1x10$util$Pair$$U) null);
        
        //#line 45 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        ((x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>)sink).add__0x10$util$ArrayList$$T$O(((x10.util.Pair)(t$3936)));
    }
    
    
    //#line 47 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public static void test0__0$1x10$lang$String$2(final x10.core.Rail<java.lang.String> args) {
        
        //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long t$3937 = ((x10.core.Rail<java.lang.String>)args).size;
        
        //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final boolean t$3939 = ((t$3937) > (((long)(0L))));
        
        //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        long t$3940 =  0;
        
        //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        if (t$3939) {
            
            //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final java.lang.String t$3938 = ((java.lang.String[])args.value)[(int)0L];
            
            //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            t$3940 = java.lang.Long.parseLong(t$3938);
        } else {
            
            //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            t$3940 = 10L;
        }
        
        //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final long N = t$3940;
        
        //#line 49 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.io.Printer t$3941 = ((x10.io.Printer)(x10.io.Console.get$OUT()));
        
        //#line 49 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final java.lang.String t$3942 = (("N=") + ((x10.core.Long.$box(N))));
        
        //#line 49 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        t$3941.println(((java.lang.Object)(t$3942)));
        
        //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.lang.PlaceGroup t$3945 = ((x10.lang.PlaceGroup)(x10.lang.Place.places()));
        
        //#line 51 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.core.fun.Fun_0_0 t$3946 = ((x10.core.fun.Fun_0_0)(new com.ibm.m3rlite.example.Histogram.$Closure$12(N)));
        
        //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.lang.PlaceLocalHandle t$3950 = x10.lang.PlaceLocalHandle.<x10.core.Rail<x10.core.Long>> make__1$1x10$lang$PlaceLocalHandle$$T$2(x10.rtt.ParameterizedType.make(x10.core.Rail.$RTT, x10.rtt.Types.LONG), ((x10.lang.PlaceGroup)(t$3945)), ((x10.core.fun.Fun_0_0)(t$3946)));
        
        //#line 52 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.lang.PlaceGroup t$3948 = ((x10.lang.PlaceGroup)(x10.lang.Place.places()));
        
        //#line 53 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.core.fun.Fun_0_0 t$3949 = ((x10.core.fun.Fun_0_0)(new com.ibm.m3rlite.example.Histogram.$Closure$13()));
        
        //#line 52 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final x10.lang.PlaceLocalHandle t$3951 = x10.lang.PlaceLocalHandle.<x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>> make__1$1x10$lang$PlaceLocalHandle$$T$2(x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.LONG)), ((x10.lang.PlaceGroup)(t$3948)), ((x10.core.fun.Fun_0_0)(t$3949)));
        
        //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final com.ibm.m3rlite.example.Histogram h = ((com.ibm.m3rlite.example.Histogram)(new com.ibm.m3rlite.example.Histogram((java.lang.System[]) null).com$ibm$m3rlite$example$Histogram$$init$S(t$3950, t$3951, (com.ibm.m3rlite.example.Histogram.__0$1x10$lang$Rail$1x10$lang$Long$2$2__1$1x10$util$ArrayList$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2$2) null)));
        
        //#line 54 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        final com.ibm.m3rlite.Engine t$3952 = ((com.ibm.m3rlite.Engine)(new com.ibm.m3rlite.Engine<x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long>((java.lang.System[]) null, x10.rtt.Types.LONG, x10.rtt.Types.LONG, x10.rtt.Types.LONG, x10.rtt.Types.LONG, x10.rtt.Types.LONG, x10.rtt.Types.LONG).com$ibm$m3rlite$Engine$$init$S(((com.ibm.m3rlite.Job<x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long>)(h)), (com.ibm.m3rlite.Engine.__0$1com$ibm$m3rlite$Engine$$K1$3com$ibm$m3rlite$Engine$$V1$3com$ibm$m3rlite$Engine$$K2$3com$ibm$m3rlite$Engine$$V2$3com$ibm$m3rlite$Engine$$K3$3com$ibm$m3rlite$Engine$$V3$2) null)));
        
        //#line 54 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        ((com.ibm.m3rlite.Engine<x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long, x10.core.Long>)t$3952).run();
        
        //#line 55 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        try {{
            
            //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final long n;
            {
                
                //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.lang.FinishState fs$4021 = ((x10.lang.FinishState)(x10.lang.Runtime.<x10.core.Long> startCollectingFinish__0$1x10$lang$Runtime$$T$2(x10.rtt.Types.LONG, ((x10.lang.Reducible)(new x10.lang.Reducible.SumReducer<x10.core.Long>((java.lang.System[]) null, x10.rtt.Types.LONG).x10$lang$Reducible$SumReducer$$init$S())))));
                
                //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                try {{
                    {
                        
                        //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                        final x10.lang.PlaceGroup t$3954 = ((x10.lang.PlaceGroup)(x10.lang.Place.places()));
                        
                        //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                        final x10.lang.Iterator p$3913 = ((x10.lang.Iterable<x10.lang.Place>)t$3954).iterator();
                        
                        //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                        for (;
                             true;
                             ) {
                            
                            //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                            final boolean t$3965 = ((x10.lang.Iterator<x10.lang.Place>)p$3913).hasNext$O();
                            
                            //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                            if (!(t$3965)) {
                                
                                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                                break;
                            }
                            
                            //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                            final x10.lang.Place p$4007 = ((x10.lang.Place)(((x10.lang.Iterator<x10.lang.Place>)p$3913).next$G()));
                            
                            //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                            x10.lang.Runtime.runAsync(((x10.core.fun.VoidFun_0_0)(new com.ibm.m3rlite.example.Histogram.$Closure$15(p$4007, h))));
                        }
                    }
                }}catch (java.lang.Throwable __lowerer__var__0__) {
                    
                    //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    x10.lang.Runtime.pushException(((java.lang.Throwable)(__lowerer__var__0__)));
                    
                    //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    throw new java.lang.RuntimeException();
                }finally {{
                     
                     //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                     n = x10.core.Long.$unbox(x10.lang.Runtime.<x10.core.Long> stopCollectingFinish$G(x10.rtt.Types.LONG, ((x10.lang.FinishState)(fs$4021))));
                 }}
                }
            
            //#line 67 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final boolean t$3972 = ((long) n) != ((long) N);
            
            //#line 67 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            if (t$3972) {
                
                //#line 68 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.io.Printer t$3969 = ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
                //#line 68 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final java.lang.String t$3966 = ((x10.x10rt.X10RT.here()) + (" error. Expected "));
                
                //#line 68 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final java.lang.String t$3967 = ((t$3966) + ((x10.core.Long.$box(N))));
                
                //#line 68 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final java.lang.String t$3968 = ((t$3967) + (" got "));
                
                //#line 68 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final java.lang.String t$3970 = ((t$3968) + ((x10.core.Long.$box(n))));
                
                //#line 68 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                t$3969.println(((java.lang.Object)(t$3970)));
            } else {
                
                //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.io.Printer t$3971 = ((x10.io.Printer)(x10.io.Console.get$OUT()));
                
                //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                t$3971.println(((java.lang.Object)("test0 ok.")));
            }
            }}catch (final java.lang.RuntimeException s) {
                
                //#line 72 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                s.printStackTrace();
            }
        }
    
    
    //#line 76 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    public static class $Main extends x10.runtime.impl.java.Runtime
    {
        // java main method
        public static void main(java.lang.String[] args) {
            // start native runtime
            new $Main().start(args);
        }
        
        // called by native runtime inside main x10 thread
        public void runtimeCallback(final x10.core.Rail<java.lang.String> args) {
            // call the original app-main method
            Histogram.main(args);
        }
    }
    
    // the original app-main method
    public static void main(final x10.core.Rail<java.lang.String> args) {
        
        //#line 77 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        com.ibm.m3rlite.example.Histogram.test0__0$1x10$lang$String$2(((x10.core.Rail)(args)));
    }
    
    
    //#line 12 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    final public com.ibm.m3rlite.example.Histogram com$ibm$m3rlite$example$Histogram$$this$com$ibm$m3rlite$example$Histogram() {
        
        //#line 12 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        return com.ibm.m3rlite.example.Histogram.this;
    }
    
    
    //#line 14 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    // creation method for java code (1-phase java constructor)
    public Histogram(final x10.lang.PlaceLocalHandle<x10.core.Rail<x10.core.Long>> plh, final x10.lang.PlaceLocalHandle<x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>> plh2, __0$1x10$lang$Rail$1x10$lang$Long$2$2__1$1x10$util$ArrayList$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2$2 $dummy) {
        this((java.lang.System[]) null);
        com$ibm$m3rlite$example$Histogram$$init$S(plh, plh2, (com.ibm.m3rlite.example.Histogram.__0$1x10$lang$Rail$1x10$lang$Long$2$2__1$1x10$util$ArrayList$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2$2) null);
    }
    
    // constructor for non-virtual call
    final public com.ibm.m3rlite.example.Histogram com$ibm$m3rlite$example$Histogram$$init$S(final x10.lang.PlaceLocalHandle<x10.core.Rail<x10.core.Long>> plh, final x10.lang.PlaceLocalHandle<x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>> plh2, __0$1x10$lang$Rail$1x10$lang$Long$2$2__1$1x10$util$ArrayList$1x10$util$Pair$1x10$lang$Long$3x10$lang$Long$2$2$2 $dummy) {
         {
            
            //#line 14 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            this.plh = plh;
            this.plh2 = plh2;
            
            
            //#line 12 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            this.__fieldInitializers_com_ibm_m3rlite_example_Histogram();
        }
        return this;
    }
    
    
    
    //#line 12 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    final public void __fieldInitializers_com_ibm_m3rlite_example_Histogram() {
        
        //#line 12 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        this.i = 0L;
    }
    
    
    //#line 18 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
    @x10.runtime.impl.java.X10Generated
    final public static class Anonymous$619 extends x10.core.Ref implements x10.lang.Iterable, x10.serialization.X10JavaSerializable
    {
        public static final x10.rtt.RuntimeType<Anonymous$619> $RTT = 
            x10.rtt.NamedType.<Anonymous$619> make("com.ibm.m3rlite.example.Histogram.Anonymous$619",
                                                   Anonymous$619.class,
                                                   new x10.rtt.Type[] {
                                                       x10.rtt.ParameterizedType.make(x10.lang.Iterable.$RTT, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.LONG))
                                                   });
        
        public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
        
        public x10.rtt.Type<?> $getParam(int i) { return null; }
        
        private Object writeReplace() throws java.io.ObjectStreamException {
            return new x10.serialization.SerializationProxy(this);
        }
        
        public static x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.example.Histogram.Anonymous$619 $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Anonymous$619.class + " calling"); } 
            $_obj.out$ = $deserializer.readObject();
            return $_obj;
        }
        
        public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            com.ibm.m3rlite.example.Histogram.Anonymous$619 $_obj = new com.ibm.m3rlite.example.Histogram.Anonymous$619((java.lang.System[]) null);
            $deserializer.record_reference($_obj);
            return $_deserialize_body($_obj, $deserializer);
        }
        
        public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            $serializer.write(this.out$);
            
        }
        
        // constructor just for allocation
        public Anonymous$619(final java.lang.System[] $dummy) {
            
        }
        
        
    
        
        //#line 12 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        public com.ibm.m3rlite.example.Histogram out$;
        
        
        //#line 19 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        public com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679 iterator() {
            
            //#line 19 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679 t$3973 = ((com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679)(new com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679((java.lang.System[]) null).com$ibm$m3rlite$example$Histogram$Anonymous$619$Anonymous$679$$init$S(this)));
            
            //#line 19 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            return t$3973;
        }
        
        
        //#line 18 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        // creation method for java code (1-phase java constructor)
        public Anonymous$619(final com.ibm.m3rlite.example.Histogram out$) {
            this((java.lang.System[]) null);
            com$ibm$m3rlite$example$Histogram$Anonymous$619$$init$S(out$);
        }
        
        // constructor for non-virtual call
        final public com.ibm.m3rlite.example.Histogram.Anonymous$619 com$ibm$m3rlite$example$Histogram$Anonymous$619$$init$S(final com.ibm.m3rlite.example.Histogram out$) {
             {
                
                //#line 12 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                this.out$ = out$;
            }
            return this;
        }
        
        
        
        //#line 19 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
        @x10.runtime.impl.java.X10Generated
        final public static class Anonymous$679 extends x10.core.Ref implements x10.lang.Iterator, x10.serialization.X10JavaSerializable
        {
            public static final x10.rtt.RuntimeType<Anonymous$679> $RTT = 
                x10.rtt.NamedType.<Anonymous$679> make("com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679",
                                                       Anonymous$679.class,
                                                       new x10.rtt.Type[] {
                                                           x10.rtt.ParameterizedType.make(x10.lang.Iterator.$RTT, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.LONG))
                                                       });
            
            public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
            
            public x10.rtt.Type<?> $getParam(int i) { return null; }
            
            private Object writeReplace() throws java.io.ObjectStreamException {
                return new x10.serialization.SerializationProxy(this);
            }
            
            public static x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679 $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Anonymous$679.class + " calling"); } 
                $_obj.data = $deserializer.readObject();
                $_obj.i = $deserializer.readLong();
                $_obj.out$ = $deserializer.readObject();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679 $_obj = new com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679((java.lang.System[]) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
                $serializer.write(this.data);
                $serializer.write(this.i);
                $serializer.write(this.out$);
                
            }
            
            // constructor just for allocation
            public Anonymous$679(final java.lang.System[] $dummy) {
                
            }
            
            // bridge for method abstract public x10.lang.Iterator.next(){}:T
            public x10.util.Pair next$G() {
                return next();
            }
            
            
        
            
            //#line 18 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            public com.ibm.m3rlite.example.Histogram.Anonymous$619 out$;
            
            //#line 20 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            public x10.core.Rail<x10.core.Long> data;
            
            //#line 21 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            public long i = 0L;
            
            
            //#line 22 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            public boolean hasNext$O() {
                
                //#line 22 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3975 = i;
                
                //#line 22 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.core.Rail t$3974 = ((x10.core.Rail)(data));
                
                //#line 22 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3976 = ((x10.core.Rail<x10.core.Long>)t$3974).size;
                
                //#line 22 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final boolean t$3977 = ((t$3975) < (((long)(t$3976))));
                
                //#line 22 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                return t$3977;
            }
            
            
            //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            public x10.util.Pair next() {
                
                //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.core.Rail t$3981 = ((x10.core.Rail)(data));
                
                //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3978 = this.i;
                
                //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3979 = ((t$3978) + (((long)(1L))));
                
                //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3980 = this.i = t$3979;
                
                //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3982 = ((t$3980) - (((long)(1L))));
                
                //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$3983 = ((long[])t$3981.value)[(int)t$3982];
                
                //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.util.Pair t$3984 = new x10.util.Pair<x10.core.Long, x10.core.Long>((java.lang.System[]) null, x10.rtt.Types.LONG, x10.rtt.Types.LONG).x10$util$Pair$$init$S((x10.core.Long.$box(0L)), x10.core.Long.$box(t$3983), (x10.util.Pair.__0x10$util$Pair$$T__1x10$util$Pair$$U) null);
                
                //#line 23 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                return t$3984;
            }
            
            
            //#line 19 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            // creation method for java code (1-phase java constructor)
            public Anonymous$679(final com.ibm.m3rlite.example.Histogram.Anonymous$619 out$) {
                this((java.lang.System[]) null);
                com$ibm$m3rlite$example$Histogram$Anonymous$619$Anonymous$679$$init$S(out$);
            }
            
            // constructor for non-virtual call
            final public com.ibm.m3rlite.example.Histogram.Anonymous$619.Anonymous$679 com$ibm$m3rlite$example$Histogram$Anonymous$619$Anonymous$679$$init$S(final com.ibm.m3rlite.example.Histogram.Anonymous$619 out$) {
                 {
                    
                    //#line 18 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    this.out$ = out$;
                    
                    //#line 20 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final com.ibm.m3rlite.example.Histogram.Anonymous$619 t$3985 = this.out$;
                    
                    //#line 20 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final com.ibm.m3rlite.example.Histogram t$3986 = t$3985.out$;
                    
                    //#line 20 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final x10.lang.PlaceLocalHandle t$3987 = ((x10.lang.PlaceLocalHandle)(t$3986.plh));
                    
                    //#line 20 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final x10.core.Rail t$3988 = ((x10.lang.PlaceLocalHandle<x10.core.Rail<x10.core.Long>>)t$3987).$apply$G();
                    
                    //#line 20 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    this.data = t$3988;
                }
                return this;
            }
            
        }
        
    }
    
    @x10.runtime.impl.java.X10Generated
    final public static class $Closure$11 extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
    {
        public static final x10.rtt.RuntimeType<$Closure$11> $RTT = 
            x10.rtt.StaticFunType.<$Closure$11> make($Closure$11.class,
                                                     new x10.rtt.Type[] {
                                                         x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.LONG)
                                                     });
        
        public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
        
        public x10.rtt.Type<?> $getParam(int i) { return null; }
        
        private Object writeReplace() throws java.io.ObjectStreamException {
            return new x10.serialization.SerializationProxy(this);
        }
        
        public static x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.example.Histogram.$Closure$11 $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$11.class + " calling"); } 
            return $_obj;
        }
        
        public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            com.ibm.m3rlite.example.Histogram.$Closure$11 $_obj = new com.ibm.m3rlite.example.Histogram.$Closure$11((java.lang.System[]) null);
            $deserializer.record_reference($_obj);
            return $_deserialize_body($_obj, $deserializer);
        }
        
        public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
        }
        
        // constructor just for allocation
        public $Closure$11(final java.lang.System[] $dummy) {
            
        }
        
        // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
        public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
            return x10.core.Long.$box($apply$O(x10.core.Long.$unbox(a1)));
            
        }
        
        // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
        public long $apply$J(final java.lang.Object a1, final x10.rtt.Type t1) {
            return $apply$O(x10.core.Long.$unbox(a1));
            
        }
        
        
    
        
        public long $apply$O(final long i) {
            
            //#line 51 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            return i;
        }
        
        public $Closure$11() {
             {
                
            }
        }
        
    }
    
    @x10.runtime.impl.java.X10Generated
    final public static class $Closure$12 extends x10.core.Ref implements x10.core.fun.Fun_0_0, x10.serialization.X10JavaSerializable
    {
        public static final x10.rtt.RuntimeType<$Closure$12> $RTT = 
            x10.rtt.StaticFunType.<$Closure$12> make($Closure$12.class,
                                                     new x10.rtt.Type[] {
                                                         x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_0.$RTT, x10.rtt.ParameterizedType.make(x10.core.Rail.$RTT, x10.rtt.Types.LONG))
                                                     });
        
        public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
        
        public x10.rtt.Type<?> $getParam(int i) { return null; }
        
        private Object writeReplace() throws java.io.ObjectStreamException {
            return new x10.serialization.SerializationProxy(this);
        }
        
        public static x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.example.Histogram.$Closure$12 $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$12.class + " calling"); } 
            $_obj.N = $deserializer.readLong();
            return $_obj;
        }
        
        public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            com.ibm.m3rlite.example.Histogram.$Closure$12 $_obj = new com.ibm.m3rlite.example.Histogram.$Closure$12((java.lang.System[]) null);
            $deserializer.record_reference($_obj);
            return $_deserialize_body($_obj, $deserializer);
        }
        
        public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            $serializer.write(this.N);
            
        }
        
        // constructor just for allocation
        public $Closure$12(final java.lang.System[] $dummy) {
            
        }
        
        // bridge for method abstract public ()=>U.operator()():U
        public x10.core.Rail $apply$G() {
            return $apply();
        }
        
        
    
        
        public x10.core.Rail $apply() {
            
            //#line 51 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final x10.core.fun.Fun_0_1 t$3943 = ((x10.core.fun.Fun_0_1)(new com.ibm.m3rlite.example.Histogram.$Closure$11()));
            
            //#line 51 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final x10.core.Rail t$3944 = ((x10.core.Rail)(new x10.core.Rail<x10.core.Long>(x10.rtt.Types.LONG, this.N, ((x10.core.fun.Fun_0_1)(t$3943)), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
            
            //#line 51 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            return t$3944;
        }
        
        public long N;
        
        public $Closure$12(final long N) {
             {
                this.N = N;
            }
        }
        
    }
    
    @x10.runtime.impl.java.X10Generated
    final public static class $Closure$13 extends x10.core.Ref implements x10.core.fun.Fun_0_0, x10.serialization.X10JavaSerializable
    {
        public static final x10.rtt.RuntimeType<$Closure$13> $RTT = 
            x10.rtt.StaticFunType.<$Closure$13> make($Closure$13.class,
                                                     new x10.rtt.Type[] {
                                                         x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_0.$RTT, x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.LONG)))
                                                     });
        
        public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
        
        public x10.rtt.Type<?> $getParam(int i) { return null; }
        
        private Object writeReplace() throws java.io.ObjectStreamException {
            return new x10.serialization.SerializationProxy(this);
        }
        
        public static x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.example.Histogram.$Closure$13 $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$13.class + " calling"); } 
            return $_obj;
        }
        
        public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            com.ibm.m3rlite.example.Histogram.$Closure$13 $_obj = new com.ibm.m3rlite.example.Histogram.$Closure$13((java.lang.System[]) null);
            $deserializer.record_reference($_obj);
            return $_deserialize_body($_obj, $deserializer);
        }
        
        public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            
        }
        
        // constructor just for allocation
        public $Closure$13(final java.lang.System[] $dummy) {
            
        }
        
        // bridge for method abstract public ()=>U.operator()():U
        public x10.util.ArrayList $apply$G() {
            return $apply();
        }
        
        
    
        
        public x10.util.ArrayList $apply() {
            
            //#line 53 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            final x10.util.ArrayList t$3947 = ((x10.util.ArrayList)(new x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>((java.lang.System[]) null, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, x10.rtt.Types.LONG, x10.rtt.Types.LONG)).x10$util$ArrayList$$init$S()));
            
            //#line 53 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            return t$3947;
        }
        
        public $Closure$13() {
             {
                
            }
        }
        
    }
    
    @x10.runtime.impl.java.X10Generated
    final public static class $Closure$14 extends x10.core.Ref implements x10.core.fun.VoidFun_0_0, x10.serialization.X10JavaSerializable
    {
        public static final x10.rtt.RuntimeType<$Closure$14> $RTT = 
            x10.rtt.StaticVoidFunType.<$Closure$14> make($Closure$14.class,
                                                         new x10.rtt.Type[] {
                                                             x10.core.fun.VoidFun_0_0.$RTT
                                                         });
        
        public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
        
        public x10.rtt.Type<?> $getParam(int i) { return null; }
        
        private Object writeReplace() throws java.io.ObjectStreamException {
            return new x10.serialization.SerializationProxy(this);
        }
        
        public static x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.example.Histogram.$Closure$14 $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$14.class + " calling"); } 
            $_obj.h = $deserializer.readObject();
            return $_obj;
        }
        
        public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            com.ibm.m3rlite.example.Histogram.$Closure$14 $_obj = new com.ibm.m3rlite.example.Histogram.$Closure$14((java.lang.System[]) null);
            $deserializer.record_reference($_obj);
            return $_deserialize_body($_obj, $deserializer);
        }
        
        public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            $serializer.write(this.h);
            
        }
        
        // constructor just for allocation
        public $Closure$14(final java.lang.System[] $dummy) {
            
        }
        
        
    
        
        public void $apply() {
            
            //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            try {{
                
                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.lang.PlaceLocalHandle t$4008 = ((x10.lang.PlaceLocalHandle)(this.h.plh2));
                
                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.util.ArrayList a$4009 = ((x10.lang.PlaceLocalHandle<x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>>)t$4008).$apply$G();
                
                //#line 59 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final x10.util.ListIterator kv$4005 = ((x10.util.ListIterator<x10.util.Pair<x10.core.Long, x10.core.Long>>)
                                                        ((x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>)a$4009).iterator());
                
                //#line 59 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                for (;
                     true;
                     ) {
                    
                    //#line 59 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final boolean t$4006 = ((x10.util.ListIterator<x10.util.Pair<x10.core.Long, x10.core.Long>>)kv$4005).hasNext$O();
                    
                    //#line 59 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    if (!(t$4006)) {
                        
                        //#line 59 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                        break;
                    }
                    
                    //#line 59 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final x10.util.Pair kv$3998 = ((x10.util.Pair)(((x10.util.ListIterator<x10.util.Pair<x10.core.Long, x10.core.Long>>)kv$4005).next$G()));
                    
                    //#line 60 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final long t$3999 = x10.core.Long.$unbox(x10.core.Long.$unbox(((x10.util.Pair<x10.core.Long, x10.core.Long>)kv$3998).second));
                    
                    //#line 60 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final long t$4000 = ((long)x10.x10rt.X10RT.numPlaces());
                    
                    //#line 60 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    final boolean t$4001 = ((long) t$3999) != ((long) t$4000);
                    
                    //#line 60 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    if (t$4001) {
                        
                        //#line 61 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                        final x10.io.Printer t$4002 = ((x10.io.Printer)(x10.io.Console.get$OUT()));
                        
                        //#line 61 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                        final java.lang.String t$4003 = ((x10.x10rt.X10RT.here()) + (" error:"));
                        
                        //#line 61 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                        final java.lang.String t$4004 = ((t$4003) + (kv$3998));
                        
                        //#line 61 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                        t$4002.println(((java.lang.Object)(t$4004)));
                    }
                }
                
                //#line 64 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                final long t$4010 = ((x10.util.ArrayList<x10.util.Pair<x10.core.Long, x10.core.Long>>)a$4009).size$O();
                
                //#line 64 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                x10.lang.Runtime.<x10.core.Long> makeOffer__0x10$lang$Runtime$$T(x10.rtt.Types.LONG, x10.core.Long.$box(t$4010));
            }}catch (java.lang.Throwable __lowerer__var__0__) {
                
                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                int __lowerer__var__1__ = (x10.core.Int.$unbox(x10.lang.Runtime.<x10.core.Int> wrapAtChecked$G(x10.rtt.Types.INT, ((java.lang.Throwable)(__lowerer__var__0__)))));
            }
        }
        
        public com.ibm.m3rlite.example.Histogram h;
        
        public $Closure$14(final com.ibm.m3rlite.example.Histogram h) {
             {
                this.h = ((com.ibm.m3rlite.example.Histogram)(h));
            }
        }
        
    }
    
    @x10.runtime.impl.java.X10Generated
    final public static class $Closure$15 extends x10.core.Ref implements x10.core.fun.VoidFun_0_0, x10.serialization.X10JavaSerializable
    {
        public static final x10.rtt.RuntimeType<$Closure$15> $RTT = 
            x10.rtt.StaticVoidFunType.<$Closure$15> make($Closure$15.class,
                                                         new x10.rtt.Type[] {
                                                             x10.core.fun.VoidFun_0_0.$RTT
                                                         });
        
        public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
        
        public x10.rtt.Type<?> $getParam(int i) { return null; }
        
        private Object writeReplace() throws java.io.ObjectStreamException {
            return new x10.serialization.SerializationProxy(this);
        }
        
        public static x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.example.Histogram.$Closure$15 $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$15.class + " calling"); } 
            $_obj.p$4007 = $deserializer.readObject();
            $_obj.h = $deserializer.readObject();
            return $_obj;
        }
        
        public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            com.ibm.m3rlite.example.Histogram.$Closure$15 $_obj = new com.ibm.m3rlite.example.Histogram.$Closure$15((java.lang.System[]) null);
            $deserializer.record_reference($_obj);
            return $_deserialize_body($_obj, $deserializer);
        }
        
        public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            $serializer.write(this.p$4007);
            $serializer.write(this.h);
            
        }
        
        // constructor just for allocation
        public $Closure$15(final java.lang.System[] $dummy) {
            
        }
        
        
    
        
        public void $apply() {
            
            //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
            try {{
                {
                    
                    //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                    x10.lang.Runtime.runAt(((x10.lang.Place)(this.p$4007)), ((x10.core.fun.VoidFun_0_0)(new com.ibm.m3rlite.example.Histogram.$Closure$14(((com.ibm.m3rlite.example.Histogram)(this.h))))), ((x10.lang.Runtime.Profile)(null)));
                }
            }}catch (java.lang.Error __lowerer__var__0__) {
                
                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                throw __lowerer__var__0__;
            }catch (java.lang.Throwable __lowerer__var__1__) {
                
                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/example/Histogram.x10"
                throw x10.rtt.Types.EXCEPTION.isInstance(__lowerer__var__1__) ? (java.lang.RuntimeException)(__lowerer__var__1__) : new x10.lang.WrappedThrowable(__lowerer__var__1__);
            }
        }
        
        public x10.lang.Place p$4007;
        public com.ibm.m3rlite.example.Histogram h;
        
        public $Closure$15(final x10.lang.Place p$4007, final com.ibm.m3rlite.example.Histogram h) {
             {
                this.p$4007 = ((x10.lang.Place)(p$4007));
                this.h = ((com.ibm.m3rlite.example.Histogram)(h));
            }
        }
        
    }
    
    }
    
    