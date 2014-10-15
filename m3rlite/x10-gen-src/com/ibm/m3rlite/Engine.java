package com.ibm.m3rlite;


@x10.runtime.impl.java.X10Generated
public class Engine<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Ref implements x10.serialization.X10JavaSerializable
{
    public static final x10.rtt.RuntimeType<Engine> $RTT = 
        x10.rtt.NamedType.<Engine> make("com.ibm.m3rlite.Engine",
                                        Engine.class,
                                        6);
    
    public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
    
    public x10.rtt.Type<?> $getParam(int i) { if (i == 0) return $K1; if (i == 1) return $V1; if (i == 2) return $K2; if (i == 3) return $V2; if (i == 4) return $K3; if (i == 5) return $V3; return null; }
    
    private Object writeReplace() throws java.io.ObjectStreamException {
        return new x10.serialization.SerializationProxy(this);
    }
    
    public static <$K1, $V1, $K2, $V2, $K3, $V3> x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.Engine<$K1, $V1, $K2, $V2, $K3, $V3> $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
        if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + Engine.class + " calling"); } 
        $_obj.$K1 = (x10.rtt.Type) $deserializer.readObject();
        $_obj.$V1 = (x10.rtt.Type) $deserializer.readObject();
        $_obj.$K2 = (x10.rtt.Type) $deserializer.readObject();
        $_obj.$V2 = (x10.rtt.Type) $deserializer.readObject();
        $_obj.$K3 = (x10.rtt.Type) $deserializer.readObject();
        $_obj.$V3 = (x10.rtt.Type) $deserializer.readObject();
        $_obj.job = $deserializer.readObject();
        return $_obj;
    }
    
    public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
        com.ibm.m3rlite.Engine $_obj = new com.ibm.m3rlite.Engine((java.lang.System[]) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null);
        $deserializer.record_reference($_obj);
        return $_deserialize_body($_obj, $deserializer);
    }
    
    public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
        $serializer.write(this.$K1);
        $serializer.write(this.$V1);
        $serializer.write(this.$K2);
        $serializer.write(this.$V2);
        $serializer.write(this.$K3);
        $serializer.write(this.$V3);
        $serializer.write(this.job);
        
    }
    
    // constructor just for allocation
    public Engine(final java.lang.System[] $dummy, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
        com.ibm.m3rlite.Engine.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
        
    }
    
    private x10.rtt.Type $K1;
    private x10.rtt.Type $V1;
    private x10.rtt.Type $K2;
    private x10.rtt.Type $V2;
    private x10.rtt.Type $K3;
    private x10.rtt.Type $V3;
    
    // initializer of type parameters
    public static void $initParams(final Engine $this, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
        $this.$K1 = $K1;
        $this.$V1 = $V1;
        $this.$K2 = $K2;
        $this.$V2 = $V2;
        $this.$K3 = $K3;
        $this.$V3 = $V3;
        
    }
    // synthetic type for parameter mangling
    public static final class __0$1com$ibm$m3rlite$Engine$$K1$3com$ibm$m3rlite$Engine$$V1$3com$ibm$m3rlite$Engine$$K2$3com$ibm$m3rlite$Engine$$V2$3com$ibm$m3rlite$Engine$$K3$3com$ibm$m3rlite$Engine$$V3$2 {}
    
    // properties
    
    //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
    public com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job;
    

    
    
    
    
    //#line 35 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
    public static <$K2, $V2>void insert__0$1com$ibm$m3rlite$Engine$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$V2$2$2__1com$ibm$m3rlite$Engine$$K2__2com$ibm$m3rlite$Engine$$V2(final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.util.HashMap<$K2, x10.util.ArrayList<$V2>> a, final $K2 k, final $V2 v) {
        
        //#line 36 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.util.ArrayList gr = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)a).get__0x10$util$HashMap$$K$G((($K2)(k)));
        
        //#line 37 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final boolean t$4093 = ((gr) == (null));
        
        //#line 37 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        x10.util.ArrayList t$4094 =  null;
        
        //#line 37 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        if (t$4093) {
            
            //#line 37 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            t$4094 = new x10.util.ArrayList<$V2>((java.lang.System[]) null, $V2).x10$util$ArrayList$$init$S();
        } else {
            
            //#line 37 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            t$4094 = gr;
        }
        
        //#line 37 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.util.ArrayList gr2 = t$4094;
        
        //#line 38 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        ((x10.util.ArrayList<$V2>)gr2).add__0x10$util$ArrayList$$T$O((($V2)(v)));
        
        //#line 39 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)a).put__0x10$util$HashMap$$K__1x10$util$HashMap$$V$G((($K2)(k)), ((x10.util.ArrayList)(gr2)));
    }
    
    
    //#line 41 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
    public static <$K2, $V2>void insert__0$1com$ibm$m3rlite$Engine$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$V2$2$2__1com$ibm$m3rlite$Engine$$K2__2$1com$ibm$m3rlite$Engine$$V2$2(final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.util.HashMap<$K2, x10.util.ArrayList<$V2>> a, final $K2 k, final x10.util.ArrayList<$V2> v) {
        
        //#line 42 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.util.ArrayList gr = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)a).get__0x10$util$HashMap$$K$G((($K2)(k)));
        
        //#line 43 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final boolean t$4095 = ((gr) == (null));
        
        //#line 43 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        x10.util.ArrayList t$4096 =  null;
        
        //#line 43 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        if (t$4095) {
            
            //#line 43 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            t$4096 = new x10.util.ArrayList<$V2>((java.lang.System[]) null, $V2).x10$util$ArrayList$$init$S();
        } else {
            
            //#line 43 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            t$4096 = gr;
        }
        
        //#line 43 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.util.ArrayList gr2 = t$4096;
        
        //#line 44 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        ((x10.util.AbstractCollection<$V2>)gr2).addAll__0$1x10$util$AbstractCollection$$T$2$O(((x10.util.Container)(v)));
        
        //#line 45 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)a).put__0x10$util$HashMap$$K__1x10$util$HashMap$$V$G((($K2)(k)), ((x10.util.ArrayList)(gr2)));
    }
    
    
    //#line 47 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
    public static <$K2, $V2>void mergeInto__0$1com$ibm$m3rlite$Engine$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$V2$2$2__1$1com$ibm$m3rlite$Engine$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$V2$2$2(final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.util.HashMap<$K2, x10.util.ArrayList<$V2>> a, final x10.util.HashMap<$K2, x10.util.ArrayList<$V2>> b) {
        
        //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.util.Set t$4098 = ((x10.util.Set<$K2>)
                                      ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)b).keySet());
        
        //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.lang.Iterator k$4084 = ((x10.lang.Iterator<$K2>)
                                           ((x10.lang.Iterable<$K2>)t$4098).iterator());
        
        //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        for (;
             true;
             ) {
            
            //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            final boolean t$4100 = ((x10.lang.Iterator<$K2>)k$4084).hasNext$O();
            
            //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            if (!(t$4100)) {
                
                //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                break;
            }
            
            //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            final $K2 k$4167 = (($K2)(((x10.lang.Iterator<$K2>)k$4084).next$G()));
            
            //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            final x10.util.ArrayList t$4168 = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)b).$apply__0x10$util$HashMap$$K$G((($K2)(k$4167)));
            
            //#line 48 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            com.ibm.m3rlite.Engine.<$K2, $V2> insert__0$1com$ibm$m3rlite$Engine$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$V2$2$2__1com$ibm$m3rlite$Engine$$K2__2$1com$ibm$m3rlite$Engine$$V2$2($K2, $V2, ((x10.util.HashMap)(a)), (($K2)(k$4167)), ((x10.util.ArrayList)(t$4168)));
        }
    }
    
    
    //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
    @x10.runtime.impl.java.X10Generated
    public static class State<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Ref implements x10.serialization.X10JavaSerializable
    {
        public static final x10.rtt.RuntimeType<State> $RTT = 
            x10.rtt.NamedType.<State> make("com.ibm.m3rlite.Engine.State",
                                           State.class,
                                           6);
        
        public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
        
        public x10.rtt.Type<?> $getParam(int i) { if (i == 0) return $K1; if (i == 1) return $V1; if (i == 2) return $K2; if (i == 3) return $V2; if (i == 4) return $K3; if (i == 5) return $V3; return null; }
        
        private Object writeReplace() throws java.io.ObjectStreamException {
            return new x10.serialization.SerializationProxy(this);
        }
        
        public static <$K1, $V1, $K2, $V2, $K3, $V3> x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3> $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + State.class + " calling"); } 
            $_obj.$K1 = (x10.rtt.Type) $deserializer.readObject();
            $_obj.$V1 = (x10.rtt.Type) $deserializer.readObject();
            $_obj.$K2 = (x10.rtt.Type) $deserializer.readObject();
            $_obj.$V2 = (x10.rtt.Type) $deserializer.readObject();
            $_obj.$K3 = (x10.rtt.Type) $deserializer.readObject();
            $_obj.$V3 = (x10.rtt.Type) $deserializer.readObject();
            $_obj.job = $deserializer.readObject();
            $_obj.incoming = $deserializer.readObject();
            return $_obj;
        }
        
        public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
            com.ibm.m3rlite.Engine.State $_obj = new com.ibm.m3rlite.Engine.State((java.lang.System[]) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null);
            $deserializer.record_reference($_obj);
            return $_deserialize_body($_obj, $deserializer);
        }
        
        public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
            $serializer.write(this.$K1);
            $serializer.write(this.$V1);
            $serializer.write(this.$K2);
            $serializer.write(this.$V2);
            $serializer.write(this.$K3);
            $serializer.write(this.$V3);
            $serializer.write(this.job);
            $serializer.write(this.incoming);
            
        }
        
        // constructor just for allocation
        public State(final java.lang.System[] $dummy, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
            com.ibm.m3rlite.Engine.State.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
            
        }
        
        private x10.rtt.Type $K1;
        private x10.rtt.Type $V1;
        private x10.rtt.Type $K2;
        private x10.rtt.Type $V2;
        private x10.rtt.Type $K3;
        private x10.rtt.Type $V3;
        
        // initializer of type parameters
        public static void $initParams(final State $this, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
            $this.$K1 = $K1;
            $this.$V1 = $V1;
            $this.$K2 = $K2;
            $this.$V2 = $V2;
            $this.$K3 = $K3;
            $this.$V3 = $V3;
            
        }
        // synthetic type for parameter mangling for __0$1com$ibm$m3rlite$Engine$State$$K1$3com$ibm$m3rlite$Engine$State$$V1$3com$ibm$m3rlite$Engine$State$$K2$3com$ibm$m3rlite$Engine$State$$V2$3com$ibm$m3rlite$Engine$State$$K3$3com$ibm$m3rlite$Engine$State$$V3$2__1$1x10$util$HashMap$1com$ibm$m3rlite$Engine$State$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$State$$V2$2$2$2
        public static final class $_dc3b6f80 {}
        
        // properties
        
        //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        public com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job;
        
        //#line 51 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        public x10.core.Rail<x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>> incoming;
        
    
        
        
        //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final public com.ibm.m3rlite.Engine.State com$ibm$m3rlite$Engine$State$$this$com$ibm$m3rlite$Engine$State() {
            
            //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            return com.ibm.m3rlite.Engine.State.this;
        }
        
        
        //#line 51 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        // creation method for java code (1-phase java constructor)
        public State(final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3, final com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job, final x10.core.Rail<x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>> incoming, $_dc3b6f80 $dummy) {
            this((java.lang.System[]) null, $K1, $V1, $K2, $V2, $K3, $V3);
            com$ibm$m3rlite$Engine$State$$init$S(job, incoming, (com.ibm.m3rlite.Engine.State.$_dc3b6f80) null);
        }
        
        // constructor for non-virtual call
        final public com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3> com$ibm$m3rlite$Engine$State$$init$S(final com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job, final x10.core.Rail<x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>> incoming, $_dc3b6f80 $dummy) {
             {
                
                //#line 51 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                this.job = ((com.ibm.m3rlite.Job)(job));
                this.incoming = ((x10.core.Rail)(incoming));
                
                
                //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                this.__fieldInitializers_com_ibm_m3rlite_Engine_State();
            }
            return this;
        }
        
        
        
        //#line 50 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final public void __fieldInitializers_com_ibm_m3rlite_Engine_State() {
            
        }
    }
    
    
    
    //#line 53 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
    public void run() {
        
        //#line 55 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.lang.PlaceGroup t$4107 = ((x10.lang.PlaceGroup)(x10.lang.Place.places()));
        
        //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.core.fun.Fun_0_0 t$4108 = ((x10.core.fun.Fun_0_0)(new com.ibm.m3rlite.Engine.$Closure$17<$K1, $V1, $K2, $V2, $K3, $V3>($K1, $V1, $K2, $V2, $K3, $V3, ((com.ibm.m3rlite.Engine<$K1, $V1, $K2, $V2, $K3, $V3>)(this)), job, (com.ibm.m3rlite.Engine.$Closure$17.$_92de4fa1) null)));
        
        //#line 55 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final x10.lang.PlaceLocalHandle plh = x10.lang.PlaceLocalHandle.<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>> make__1$1x10$lang$PlaceLocalHandle$$T$2(x10.rtt.ParameterizedType.make(com.ibm.m3rlite.Engine.State.$RTT, $K1, $V1, $K2, $V2, $K3, $V3), ((x10.lang.PlaceGroup)(t$4107)), ((x10.core.fun.Fun_0_0)(t$4108)));
        {
            
            //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            x10.lang.Clock x10$__var1 = null;
            {
                
                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                x10.lang.Runtime.ensureNotInAtomic();
                
                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final x10.lang.FinishState fs$4256 = x10.lang.Runtime.startFinish();
                
                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                try {{
                    {
                        
                        //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                        try {{
                            
                            //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            final x10.lang.Clock x10$__var0 = x10.lang.Clock.make();
                            
                            //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            x10$__var1 = x10$__var0;
                            
                            //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            final x10.lang.PlaceGroup t$4110 = ((x10.lang.PlaceGroup)(x10.lang.Place.places()));
                            
                            //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            final x10.lang.Iterator p$4092 = ((x10.lang.Iterable<x10.lang.Place>)t$4110).iterator();
                            
                            //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            for (;
                                 true;
                                 ) {
                                
                                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final boolean t$4166 = ((x10.lang.Iterator<x10.lang.Place>)p$4092).hasNext$O();
                                
                                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                if (!(t$4166)) {
                                    
                                    //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    break;
                                }
                                
                                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.lang.Place p$4239 = ((x10.lang.Place)(((x10.lang.Iterator<x10.lang.Place>)p$4092).next$G()));
                                
                                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                x10.lang.Runtime.runAsync__1$1x10$lang$Clock$2(((x10.lang.Place)(p$4239)), ((x10.core.Rail)(x10.runtime.impl.java.ArrayUtils.<x10.lang.Clock> makeRailFromJavaArray(x10.lang.Clock.$RTT, new x10.lang.Clock[] {x10$__var0}))), ((x10.core.fun.VoidFun_0_0)(new com.ibm.m3rlite.Engine.$Closure$21<$K1, $V1, $K2, $V2, $K3, $V3>($K1, $V1, $K2, $V2, $K3, $V3, plh, p$4239, (com.ibm.m3rlite.Engine.$Closure$21.$_61bcf8f0) null))), ((x10.lang.Runtime.Profile)(null)));
                            }
                        }}finally {{
                              
                              //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                              if (((x10$__var1) != (null))) {
                                  
                                  //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                  x10$__var1.drop();
                              }
                          }}
                        }
                    }}catch (java.lang.Throwable ct$4254) {
                        
                        //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                        x10.lang.Runtime.pushException(((java.lang.Throwable)(ct$4254)));
                        
                        //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                        throw new java.lang.RuntimeException();
                    }finally {{
                         
                         //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                         x10.lang.Runtime.stopFinish(((x10.lang.FinishState)(fs$4256)));
                     }}
                }
            }
        }
        
        
        //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final public com.ibm.m3rlite.Engine com$ibm$m3rlite$Engine$$this$com$ibm$m3rlite$Engine() {
            
            //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
            return com.ibm.m3rlite.Engine.this;
        }
        
        
        //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        // creation method for java code (1-phase java constructor)
        public Engine(final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3, final com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job, __0$1com$ibm$m3rlite$Engine$$K1$3com$ibm$m3rlite$Engine$$V1$3com$ibm$m3rlite$Engine$$K2$3com$ibm$m3rlite$Engine$$V2$3com$ibm$m3rlite$Engine$$K3$3com$ibm$m3rlite$Engine$$V3$2 $dummy) {
            this((java.lang.System[]) null, $K1, $V1, $K2, $V2, $K3, $V3);
            com$ibm$m3rlite$Engine$$init$S(job, (com.ibm.m3rlite.Engine.__0$1com$ibm$m3rlite$Engine$$K1$3com$ibm$m3rlite$Engine$$V1$3com$ibm$m3rlite$Engine$$K2$3com$ibm$m3rlite$Engine$$V2$3com$ibm$m3rlite$Engine$$K3$3com$ibm$m3rlite$Engine$$V3$2) null);
        }
        
        // constructor for non-virtual call
        final public com.ibm.m3rlite.Engine<$K1, $V1, $K2, $V2, $K3, $V3> com$ibm$m3rlite$Engine$$init$S(final com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job, __0$1com$ibm$m3rlite$Engine$$K1$3com$ibm$m3rlite$Engine$$V1$3com$ibm$m3rlite$Engine$$K2$3com$ibm$m3rlite$Engine$$V2$3com$ibm$m3rlite$Engine$$K3$3com$ibm$m3rlite$Engine$$V3$2 $dummy) {
             {
                
                //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                this.job = ((com.ibm.m3rlite.Job)(job));
                
                
                //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                this.__fieldInitializers_com_ibm_m3rlite_Engine();
            }
            return this;
        }
        
        
        
        //#line 31 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
        final public void __fieldInitializers_com_ibm_m3rlite_Engine() {
            
        }
        
        @x10.runtime.impl.java.X10Generated
        final public static class $Closure$16<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            public static final x10.rtt.RuntimeType<$Closure$16> $RTT = 
                x10.rtt.StaticFunType.<$Closure$16> make($Closure$16.class,
                                                         6,
                                                         new x10.rtt.Type[] {
                                                             x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.ParameterizedType.make(x10.util.HashMap.$RTT, x10.rtt.UnresolvedType.PARAM(2), x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, x10.rtt.UnresolvedType.PARAM(3))))
                                                         });
            
            public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
            
            public x10.rtt.Type<?> $getParam(int i) { if (i == 0) return $K1; if (i == 1) return $V1; if (i == 2) return $K2; if (i == 3) return $V2; if (i == 4) return $K3; if (i == 5) return $V3; return null; }
            
            private Object writeReplace() throws java.io.ObjectStreamException {
                return new x10.serialization.SerializationProxy(this);
            }
            
            public static <$K1, $V1, $K2, $V2, $K3, $V3> x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.Engine.$Closure$16<$K1, $V1, $K2, $V2, $K3, $V3> $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$16.class + " calling"); } 
                $_obj.$K1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V3 = (x10.rtt.Type) $deserializer.readObject();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                com.ibm.m3rlite.Engine.$Closure$16 $_obj = new com.ibm.m3rlite.Engine.$Closure$16((java.lang.System[]) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
                $serializer.write(this.$K1);
                $serializer.write(this.$V1);
                $serializer.write(this.$K2);
                $serializer.write(this.$V2);
                $serializer.write(this.$K3);
                $serializer.write(this.$V3);
                
            }
            
            // constructor just for allocation
            public $Closure$16(final java.lang.System[] $dummy, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                com.ibm.m3rlite.Engine.$Closure$16.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                
            }
            
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
                return $apply(x10.core.Long.$unbox(a1));
                
            }
            
            private x10.rtt.Type $K1;
            private x10.rtt.Type $V1;
            private x10.rtt.Type $K2;
            private x10.rtt.Type $V2;
            private x10.rtt.Type $K3;
            private x10.rtt.Type $V3;
            
            // initializer of type parameters
            public static void $initParams(final $Closure$16 $this, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                $this.$K1 = $K1;
                $this.$V1 = $V1;
                $this.$K2 = $K2;
                $this.$V2 = $V2;
                $this.$K3 = $K3;
                $this.$V3 = $V3;
                
            }
            
        
            
            public x10.util.HashMap $apply(final long id$1452) {
                
                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final x10.util.HashMap t$4101 = ((x10.util.HashMap)(new x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>((java.lang.System[]) null, $K2, x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, $V2)).x10$util$HashMap$$init$S()));
                
                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                return t$4101;
            }
            
            public $Closure$16(final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                com.ibm.m3rlite.Engine.$Closure$16.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                 {
                    
                }
            }
            
        }
        
        @x10.runtime.impl.java.X10Generated
        final public static class $Closure$17<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Ref implements x10.core.fun.Fun_0_0, x10.serialization.X10JavaSerializable
        {
            public static final x10.rtt.RuntimeType<$Closure$17> $RTT = 
                x10.rtt.StaticFunType.<$Closure$17> make($Closure$17.class,
                                                         6,
                                                         new x10.rtt.Type[] {
                                                             x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_0.$RTT, x10.rtt.ParameterizedType.make(com.ibm.m3rlite.Engine.State.$RTT, x10.rtt.UnresolvedType.PARAM(0), x10.rtt.UnresolvedType.PARAM(1), x10.rtt.UnresolvedType.PARAM(2), x10.rtt.UnresolvedType.PARAM(3), x10.rtt.UnresolvedType.PARAM(4), x10.rtt.UnresolvedType.PARAM(5)))
                                                         });
            
            public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
            
            public x10.rtt.Type<?> $getParam(int i) { if (i == 0) return $K1; if (i == 1) return $V1; if (i == 2) return $K2; if (i == 3) return $V2; if (i == 4) return $K3; if (i == 5) return $V3; return null; }
            
            private Object writeReplace() throws java.io.ObjectStreamException {
                return new x10.serialization.SerializationProxy(this);
            }
            
            public static <$K1, $V1, $K2, $V2, $K3, $V3> x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.Engine.$Closure$17<$K1, $V1, $K2, $V2, $K3, $V3> $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$17.class + " calling"); } 
                $_obj.$K1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.out$$ = $deserializer.readObject();
                $_obj.job = $deserializer.readObject();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                com.ibm.m3rlite.Engine.$Closure$17 $_obj = new com.ibm.m3rlite.Engine.$Closure$17((java.lang.System[]) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
                $serializer.write(this.$K1);
                $serializer.write(this.$V1);
                $serializer.write(this.$K2);
                $serializer.write(this.$V2);
                $serializer.write(this.$K3);
                $serializer.write(this.$V3);
                $serializer.write(this.out$$);
                $serializer.write(this.job);
                
            }
            
            // constructor just for allocation
            public $Closure$17(final java.lang.System[] $dummy, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                com.ibm.m3rlite.Engine.$Closure$17.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                
            }
            
            // bridge for method abstract public ()=>U.operator()():U
            public com.ibm.m3rlite.Engine.State $apply$G() {
                return $apply();
            }
            
            private x10.rtt.Type $K1;
            private x10.rtt.Type $V1;
            private x10.rtt.Type $K2;
            private x10.rtt.Type $V2;
            private x10.rtt.Type $K3;
            private x10.rtt.Type $V3;
            
            // initializer of type parameters
            public static void $initParams(final $Closure$17 $this, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                $this.$K1 = $K1;
                $this.$V1 = $V1;
                $this.$K2 = $K2;
                $this.$V2 = $V2;
                $this.$K3 = $K3;
                $this.$V3 = $V3;
                
            }
            // synthetic type for parameter mangling for __0$1com$ibm$m3rlite$Engine$$Closure$17$$K1$3com$ibm$m3rlite$Engine$$Closure$17$$V1$3com$ibm$m3rlite$Engine$$Closure$17$$K2$3com$ibm$m3rlite$Engine$$Closure$17$$V2$3com$ibm$m3rlite$Engine$$Closure$17$$K3$3com$ibm$m3rlite$Engine$$Closure$17$$V3$2__1$1com$ibm$m3rlite$Engine$$Closure$17$$K1$3com$ibm$m3rlite$Engine$$Closure$17$$V1$3com$ibm$m3rlite$Engine$$Closure$17$$K2$3com$ibm$m3rlite$Engine$$Closure$17$$V2$3com$ibm$m3rlite$Engine$$Closure$17$$K3$3com$ibm$m3rlite$Engine$$Closure$17$$V3$2
            public static final class $_92de4fa1 {}
            
        
            
            public com.ibm.m3rlite.Engine.State $apply() {
                
                //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final com.ibm.m3rlite.Job t$4104 = ((com.ibm.m3rlite.Job)(this.job));
                
                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final long t$4102 = ((long)x10.x10rt.X10RT.numPlaces());
                
                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final x10.core.fun.Fun_0_1 t$4103 = ((x10.core.fun.Fun_0_1)(new com.ibm.m3rlite.Engine.$Closure$16<$K1, $V1, $K2, $V2, $K3, $V3>($K1, $V1, $K2, $V2, $K3, $V3)));
                
                //#line 57 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final x10.core.Rail t$4105 = ((x10.core.Rail)(new x10.core.Rail<x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>>(x10.rtt.ParameterizedType.make(x10.util.HashMap.$RTT, $K2, x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, $V2)), t$4102, ((x10.core.fun.Fun_0_1)(t$4103)), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
                
                //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final com.ibm.m3rlite.Engine.State t$4106 = ((com.ibm.m3rlite.Engine.State)(new com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>((java.lang.System[]) null, $K1, $V1, $K2, $V2, $K3, $V3).com$ibm$m3rlite$Engine$State$$init$S(((com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3>)(t$4104)), t$4105, (com.ibm.m3rlite.Engine.State.$_dc3b6f80) null)));
                
                //#line 56 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                return t$4106;
            }
            
            public com.ibm.m3rlite.Engine<$K1, $V1, $K2, $V2, $K3, $V3> out$$;
            public com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job;
            
            public $Closure$17(final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3, final com.ibm.m3rlite.Engine<$K1, $V1, $K2, $V2, $K3, $V3> out$$, final com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job, $_92de4fa1 $dummy) {
                com.ibm.m3rlite.Engine.$Closure$17.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                 {
                    ((com.ibm.m3rlite.Engine.$Closure$17<$K1, $V1, $K2, $V2, $K3, $V3>)this).out$$ = out$$;
                    ((com.ibm.m3rlite.Engine.$Closure$17<$K1, $V1, $K2, $V2, $K3, $V3>)this).job = ((com.ibm.m3rlite.Job)(job));
                }
            }
            
        }
        
        @x10.runtime.impl.java.X10Generated
        final public static class $Closure$18<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Ref implements x10.core.fun.Fun_0_1, x10.serialization.X10JavaSerializable
        {
            public static final x10.rtt.RuntimeType<$Closure$18> $RTT = 
                x10.rtt.StaticFunType.<$Closure$18> make($Closure$18.class,
                                                         6,
                                                         new x10.rtt.Type[] {
                                                             x10.rtt.ParameterizedType.make(x10.core.fun.Fun_0_1.$RTT, x10.rtt.Types.LONG, x10.rtt.ParameterizedType.make(x10.util.HashMap.$RTT, x10.rtt.UnresolvedType.PARAM(2), x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, x10.rtt.UnresolvedType.PARAM(3))))
                                                         });
            
            public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
            
            public x10.rtt.Type<?> $getParam(int i) { if (i == 0) return $K1; if (i == 1) return $V1; if (i == 2) return $K2; if (i == 3) return $V2; if (i == 4) return $K3; if (i == 5) return $V3; return null; }
            
            private Object writeReplace() throws java.io.ObjectStreamException {
                return new x10.serialization.SerializationProxy(this);
            }
            
            public static <$K1, $V1, $K2, $V2, $K3, $V3> x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.Engine.$Closure$18<$K1, $V1, $K2, $V2, $K3, $V3> $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$18.class + " calling"); } 
                $_obj.$K1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V3 = (x10.rtt.Type) $deserializer.readObject();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                com.ibm.m3rlite.Engine.$Closure$18 $_obj = new com.ibm.m3rlite.Engine.$Closure$18((java.lang.System[]) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
                $serializer.write(this.$K1);
                $serializer.write(this.$V1);
                $serializer.write(this.$K2);
                $serializer.write(this.$V2);
                $serializer.write(this.$K3);
                $serializer.write(this.$V3);
                
            }
            
            // constructor just for allocation
            public $Closure$18(final java.lang.System[] $dummy, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                com.ibm.m3rlite.Engine.$Closure$18.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                
            }
            
            // dispatcher for method abstract public (Z1)=>U.operator()(a1:Z1):U
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1) {
                return $apply(x10.core.Long.$unbox(a1));
                
            }
            
            private x10.rtt.Type $K1;
            private x10.rtt.Type $V1;
            private x10.rtt.Type $K2;
            private x10.rtt.Type $V2;
            private x10.rtt.Type $K3;
            private x10.rtt.Type $V3;
            
            // initializer of type parameters
            public static void $initParams(final $Closure$18 $this, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                $this.$K1 = $K1;
                $this.$V1 = $V1;
                $this.$K2 = $K2;
                $this.$V2 = $V2;
                $this.$K3 = $K3;
                $this.$V3 = $V3;
                
            }
            
        
            
            public x10.util.HashMap $apply(final long id$4214) {
                
                //#line 64 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final x10.util.HashMap t$4215 = ((x10.util.HashMap)(new x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>((java.lang.System[]) null, $K2, x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, $V2)).x10$util$HashMap$$init$S()));
                
                //#line 64 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                return t$4215;
            }
            
            public $Closure$18(final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                com.ibm.m3rlite.Engine.$Closure$18.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                 {
                    
                }
            }
            
        }
        
        @x10.runtime.impl.java.X10Generated
        final public static class $Closure$19<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Ref implements x10.core.fun.VoidFun_0_2, x10.serialization.X10JavaSerializable
        {
            public static final x10.rtt.RuntimeType<$Closure$19> $RTT = 
                x10.rtt.StaticVoidFunType.<$Closure$19> make($Closure$19.class,
                                                             6,
                                                             new x10.rtt.Type[] {
                                                                 x10.rtt.ParameterizedType.make(x10.core.fun.VoidFun_0_2.$RTT, x10.rtt.UnresolvedType.PARAM(2), x10.rtt.UnresolvedType.PARAM(3))
                                                             });
            
            public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
            
            public x10.rtt.Type<?> $getParam(int i) { if (i == 0) return $K1; if (i == 1) return $V1; if (i == 2) return $K2; if (i == 3) return $V2; if (i == 4) return $K3; if (i == 5) return $V3; return null; }
            
            private Object writeReplace() throws java.io.ObjectStreamException {
                return new x10.serialization.SerializationProxy(this);
            }
            
            public static <$K1, $V1, $K2, $V2, $K3, $V3> x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.Engine.$Closure$19<$K1, $V1, $K2, $V2, $K3, $V3> $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$19.class + " calling"); } 
                $_obj.$K1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.job$4242 = $deserializer.readObject();
                $_obj.P$4240 = $deserializer.readLong();
                $_obj.results$4216 = $deserializer.readObject();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                com.ibm.m3rlite.Engine.$Closure$19 $_obj = new com.ibm.m3rlite.Engine.$Closure$19((java.lang.System[]) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
                $serializer.write(this.$K1);
                $serializer.write(this.$V1);
                $serializer.write(this.$K2);
                $serializer.write(this.$V2);
                $serializer.write(this.$K3);
                $serializer.write(this.$V3);
                $serializer.write(this.job$4242);
                $serializer.write(this.P$4240);
                $serializer.write(this.results$4216);
                
            }
            
            // constructor just for allocation
            public $Closure$19(final java.lang.System[] $dummy, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                com.ibm.m3rlite.Engine.$Closure$19.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                
            }
            
            // dispatcher for method abstract public (Z1,Z2)=>void.operator()(a1:Z1, a2:Z2):void
            public java.lang.Object $apply(final java.lang.Object a1, final x10.rtt.Type t1, final java.lang.Object a2, final x10.rtt.Type t2) {
                $apply__0com$ibm$m3rlite$Engine$$Closure$19$$K2__1com$ibm$m3rlite$Engine$$Closure$19$$V2(($K2)a1, ($V2)a2); return null;
                
            }
            
            // dispatcher for method abstract public (Z1,Z2)=>void.operator()(a1:Z1, a2:Z2):void
            public void $apply$V(final java.lang.Object a1, final x10.rtt.Type t1, final java.lang.Object a2, final x10.rtt.Type t2) {
                $apply__0com$ibm$m3rlite$Engine$$Closure$19$$K2__1com$ibm$m3rlite$Engine$$Closure$19$$V2(($K2)a1, ($V2)a2);
                
            }
            
            private x10.rtt.Type $K1;
            private x10.rtt.Type $V1;
            private x10.rtt.Type $K2;
            private x10.rtt.Type $V2;
            private x10.rtt.Type $K3;
            private x10.rtt.Type $V3;
            
            // initializer of type parameters
            public static void $initParams(final $Closure$19 $this, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                $this.$K1 = $K1;
                $this.$V1 = $V1;
                $this.$K2 = $K2;
                $this.$V2 = $V2;
                $this.$K3 = $K3;
                $this.$V3 = $V3;
                
            }
            // synthetic type for parameter mangling for __0$1com$ibm$m3rlite$Engine$$Closure$19$$K1$3com$ibm$m3rlite$Engine$$Closure$19$$V1$3com$ibm$m3rlite$Engine$$Closure$19$$K2$3com$ibm$m3rlite$Engine$$Closure$19$$V2$3com$ibm$m3rlite$Engine$$Closure$19$$K3$3com$ibm$m3rlite$Engine$$Closure$19$$V3$2__2$1x10$util$HashMap$1com$ibm$m3rlite$Engine$$Closure$19$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$Closure$19$$V2$2$2$2
            public static final class $_435bd131 {}
            
        
            
            public void $apply__0com$ibm$m3rlite$Engine$$Closure$19$$K2__1com$ibm$m3rlite$Engine$$Closure$19$$V2(final $K2 k$4218, final $V2 v$4219) {
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final long t$4220 = x10.core.Long.$unbox(((com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3>)this.job$4242).partition$J((($K2)(k$4218)), $K2));
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final long t$4221 = ((t$4220) % (((long)(this.P$4240))));
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final x10.util.HashMap a$4222 = ((x10.util.HashMap[])this.results$4216.value)[(int)t$4221];
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final $K2 k$4223 = (($K2)(k$4218));
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final $V2 v$4224 = (($V2)(v$4219));
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final boolean t$4225 = ((a$4222) != (null));
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                final boolean t$4226 = !(t$4225);
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                if (t$4226) {
                    
                    //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final x10.lang.FailedDynamicCheckException t$4227 = ((x10.lang.FailedDynamicCheckException)(new x10.lang.FailedDynamicCheckException(((java.lang.String)("!(a$4031 != null)")))));
                    
                    //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    throw t$4227;
                }
                
                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                com.ibm.m3rlite.Engine.<$K2, $V2> insert__0$1com$ibm$m3rlite$Engine$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$V2$2$2__1com$ibm$m3rlite$Engine$$K2__2com$ibm$m3rlite$Engine$$V2($K2, $V2, ((x10.util.HashMap)(a$4222)), (($K2)(k$4223)), (($V2)(v$4224)));
            }
            
            public com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job$4242;
            public long P$4240;
            public x10.core.Rail<x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>> results$4216;
            
            public $Closure$19(final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3, final com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3> job$4242, final long P$4240, final x10.core.Rail<x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>> results$4216, $_435bd131 $dummy) {
                com.ibm.m3rlite.Engine.$Closure$19.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                 {
                    ((com.ibm.m3rlite.Engine.$Closure$19<$K1, $V1, $K2, $V2, $K3, $V3>)this).job$4242 = ((com.ibm.m3rlite.Job)(job$4242));
                    ((com.ibm.m3rlite.Engine.$Closure$19<$K1, $V1, $K2, $V2, $K3, $V3>)this).P$4240 = P$4240;
                    ((com.ibm.m3rlite.Engine.$Closure$19<$K1, $V1, $K2, $V2, $K3, $V3>)this).results$4216 = ((x10.core.Rail)(results$4216));
                }
            }
            
        }
        
        @x10.runtime.impl.java.X10Generated
        final public static class $Closure$20<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Ref implements x10.core.fun.VoidFun_0_0, x10.serialization.X10JavaSerializable
        {
            public static final x10.rtt.RuntimeType<$Closure$20> $RTT = 
                x10.rtt.StaticVoidFunType.<$Closure$20> make($Closure$20.class,
                                                             6,
                                                             new x10.rtt.Type[] {
                                                                 x10.core.fun.VoidFun_0_0.$RTT
                                                             });
            
            public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
            
            public x10.rtt.Type<?> $getParam(int i) { if (i == 0) return $K1; if (i == 1) return $V1; if (i == 2) return $K2; if (i == 3) return $V2; if (i == 4) return $K3; if (i == 5) return $V3; return null; }
            
            private Object writeReplace() throws java.io.ObjectStreamException {
                return new x10.serialization.SerializationProxy(this);
            }
            
            public static <$K1, $V1, $K2, $V2, $K3, $V3> x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.Engine.$Closure$20<$K1, $V1, $K2, $V2, $K3, $V3> $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$20.class + " calling"); } 
                $_obj.$K1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.plh = $deserializer.readObject();
                $_obj.p$4239 = $deserializer.readObject();
                $_obj.v$4174 = $deserializer.readObject();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                com.ibm.m3rlite.Engine.$Closure$20 $_obj = new com.ibm.m3rlite.Engine.$Closure$20((java.lang.System[]) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
                $serializer.write(this.$K1);
                $serializer.write(this.$V1);
                $serializer.write(this.$K2);
                $serializer.write(this.$V2);
                $serializer.write(this.$K3);
                $serializer.write(this.$V3);
                $serializer.write(this.plh);
                $serializer.write(this.p$4239);
                $serializer.write(this.v$4174);
                
            }
            
            // constructor just for allocation
            public $Closure$20(final java.lang.System[] $dummy, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                com.ibm.m3rlite.Engine.$Closure$20.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                
            }
            
            private x10.rtt.Type $K1;
            private x10.rtt.Type $V1;
            private x10.rtt.Type $K2;
            private x10.rtt.Type $V2;
            private x10.rtt.Type $K3;
            private x10.rtt.Type $V3;
            
            // initializer of type parameters
            public static void $initParams(final $Closure$20 $this, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                $this.$K1 = $K1;
                $this.$V1 = $V1;
                $this.$K2 = $K2;
                $this.$V2 = $V2;
                $this.$K3 = $K3;
                $this.$V3 = $V3;
                
            }
            // synthetic type for parameter mangling for __0$1com$ibm$m3rlite$Engine$State$1com$ibm$m3rlite$Engine$$Closure$20$$K1$3com$ibm$m3rlite$Engine$$Closure$20$$V1$3com$ibm$m3rlite$Engine$$Closure$20$$K2$3com$ibm$m3rlite$Engine$$Closure$20$$V2$3com$ibm$m3rlite$Engine$$Closure$20$$K3$3com$ibm$m3rlite$Engine$$Closure$20$$V3$2$2__2$1com$ibm$m3rlite$Engine$$Closure$20$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$Closure$20$$V2$2$2
            public static final class $_bd08c0de {}
            
        
            
            public void $apply() {
                
                //#line 76 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                try {{
                    
                    //#line 76 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final com.ibm.m3rlite.Engine.State t$4177 = ((x10.lang.PlaceLocalHandle<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>>)this.plh).$apply$G();
                    
                    //#line 76 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final x10.core.Rail t$4178 = ((x10.core.Rail)(((com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>)t$4177).incoming));
                    
                    //#line 76 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final long t$4179 = this.p$4239.id;
                    
                    //#line 76 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    ((x10.util.HashMap[])t$4178.value)[(int)t$4179] = this.v$4174;
                }}catch (java.lang.Throwable __lowerer__var__0__) {
                    
                    //#line 76 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    int __lowerer__var__1__ = (x10.core.Int.$unbox(x10.lang.Runtime.<x10.core.Int> wrapAtChecked$G(x10.rtt.Types.INT, ((java.lang.Throwable)(__lowerer__var__0__)))));
                }
            }
            
            public x10.lang.PlaceLocalHandle<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>> plh;
            public x10.lang.Place p$4239;
            public x10.util.HashMap<$K2, x10.util.ArrayList<$V2>> v$4174;
            
            public $Closure$20(final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3, final x10.lang.PlaceLocalHandle<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>> plh, final x10.lang.Place p$4239, final x10.util.HashMap<$K2, x10.util.ArrayList<$V2>> v$4174, $_bd08c0de $dummy) {
                com.ibm.m3rlite.Engine.$Closure$20.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                 {
                    ((com.ibm.m3rlite.Engine.$Closure$20<$K1, $V1, $K2, $V2, $K3, $V3>)this).plh = ((x10.lang.PlaceLocalHandle)(plh));
                    ((com.ibm.m3rlite.Engine.$Closure$20<$K1, $V1, $K2, $V2, $K3, $V3>)this).p$4239 = ((x10.lang.Place)(p$4239));
                    ((com.ibm.m3rlite.Engine.$Closure$20<$K1, $V1, $K2, $V2, $K3, $V3>)this).v$4174 = ((x10.util.HashMap)(v$4174));
                }
            }
            
        }
        
        @x10.runtime.impl.java.X10Generated
        final public static class $Closure$21<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Ref implements x10.core.fun.VoidFun_0_0, x10.serialization.X10JavaSerializable
        {
            public static final x10.rtt.RuntimeType<$Closure$21> $RTT = 
                x10.rtt.StaticVoidFunType.<$Closure$21> make($Closure$21.class,
                                                             6,
                                                             new x10.rtt.Type[] {
                                                                 x10.core.fun.VoidFun_0_0.$RTT
                                                             });
            
            public x10.rtt.RuntimeType<?> $getRTT() { return $RTT; }
            
            public x10.rtt.Type<?> $getParam(int i) { if (i == 0) return $K1; if (i == 1) return $V1; if (i == 2) return $K2; if (i == 3) return $V2; if (i == 4) return $K3; if (i == 5) return $V3; return null; }
            
            private Object writeReplace() throws java.io.ObjectStreamException {
                return new x10.serialization.SerializationProxy(this);
            }
            
            public static <$K1, $V1, $K2, $V2, $K3, $V3> x10.serialization.X10JavaSerializable $_deserialize_body(com.ibm.m3rlite.Engine.$Closure$21<$K1, $V1, $K2, $V2, $K3, $V3> $_obj, x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                if (x10.runtime.impl.java.Runtime.TRACE_SER) { x10.runtime.impl.java.Runtime.printTraceMessage("X10JavaSerializable: $_deserialize_body() of " + $Closure$21.class + " calling"); } 
                $_obj.$K1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V1 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V2 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$K3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.$V3 = (x10.rtt.Type) $deserializer.readObject();
                $_obj.plh = $deserializer.readObject();
                $_obj.p$4239 = $deserializer.readObject();
                return $_obj;
            }
            
            public static x10.serialization.X10JavaSerializable $_deserializer(x10.serialization.X10JavaDeserializer $deserializer) throws java.io.IOException {
                com.ibm.m3rlite.Engine.$Closure$21 $_obj = new com.ibm.m3rlite.Engine.$Closure$21((java.lang.System[]) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null, (x10.rtt.Type) null);
                $deserializer.record_reference($_obj);
                return $_deserialize_body($_obj, $deserializer);
            }
            
            public void $_serialize(x10.serialization.X10JavaSerializer $serializer) throws java.io.IOException {
                $serializer.write(this.$K1);
                $serializer.write(this.$V1);
                $serializer.write(this.$K2);
                $serializer.write(this.$V2);
                $serializer.write(this.$K3);
                $serializer.write(this.$V3);
                $serializer.write(this.plh);
                $serializer.write(this.p$4239);
                
            }
            
            // constructor just for allocation
            public $Closure$21(final java.lang.System[] $dummy, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                com.ibm.m3rlite.Engine.$Closure$21.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                
            }
            
            private x10.rtt.Type $K1;
            private x10.rtt.Type $V1;
            private x10.rtt.Type $K2;
            private x10.rtt.Type $V2;
            private x10.rtt.Type $K3;
            private x10.rtt.Type $V3;
            
            // initializer of type parameters
            public static void $initParams(final $Closure$21 $this, final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3) {
                $this.$K1 = $K1;
                $this.$V1 = $V1;
                $this.$K2 = $K2;
                $this.$V2 = $V2;
                $this.$K3 = $K3;
                $this.$V3 = $V3;
                
            }
            // synthetic type for parameter mangling for __0$1com$ibm$m3rlite$Engine$State$1com$ibm$m3rlite$Engine$$Closure$21$$K1$3com$ibm$m3rlite$Engine$$Closure$21$$V1$3com$ibm$m3rlite$Engine$$Closure$21$$K2$3com$ibm$m3rlite$Engine$$Closure$21$$V2$3com$ibm$m3rlite$Engine$$Closure$21$$K3$3com$ibm$m3rlite$Engine$$Closure$21$$V3$2$2
            public static final class $_61bcf8f0 {}
            
        
            
            public void $apply() {
                
                //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                try {{
                    
                    //#line 59 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final long P$4240 = ((long)x10.x10rt.X10RT.numPlaces());
                    
                    //#line 60 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final com.ibm.m3rlite.Engine.State t$4241 = ((x10.lang.PlaceLocalHandle<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>>)this.plh).$apply$G();
                    
                    //#line 60 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final com.ibm.m3rlite.Job job$4242 = ((com.ibm.m3rlite.Job)(((com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>)t$4241).job));
                    
                    //#line 61 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final com.ibm.m3rlite.Engine.State t$4243 = ((x10.lang.PlaceLocalHandle<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>>)this.plh).$apply$G();
                    
                    //#line 61 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    final x10.core.Rail incoming$4244 = ((x10.core.Rail)(((com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>)t$4243).incoming));
                    
                    //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    int i$4209 = 0;
                    {
                        
                        //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                        final x10.util.HashMap[] incoming$4244$value$4259 = ((x10.util.HashMap[])incoming$4244.value);
                        
                        //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                        for (;
                             true;
                             ) {
                            
                            //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            final boolean t$4210 = ((com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3>)job$4242).stop$O();
                            
                            //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            final boolean t$4211 = !(t$4210);
                            
                            //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            if (!(t$4211)) {
                                
                                //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                break;
                            }
                            
                            //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            L$4212: {
                                
                                //#line 64 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.core.fun.Fun_0_1 t$4213 = ((x10.core.fun.Fun_0_1)(new com.ibm.m3rlite.Engine.$Closure$18<$K1, $V1, $K2, $V2, $K3, $V3>($K1, $V1, $K2, $V2, $K3, $V3)));
                                //#line 64 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.core.Rail results$4216 = ((x10.core.Rail)(new x10.core.Rail<x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>>(x10.rtt.ParameterizedType.make(x10.util.HashMap.$RTT, $K2, x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, $V2)), ((long)(P$4240)), ((x10.core.fun.Fun_0_1)(t$4213)), (x10.core.Rail.__1$1x10$lang$Long$3x10$lang$Rail$$T$2) null)));
                                //#line 65 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.core.fun.VoidFun_0_2 mSink$4217 = ((x10.core.fun.VoidFun_0_2)(new com.ibm.m3rlite.Engine.$Closure$19<$K1, $V1, $K2, $V2, $K3, $V3>($K1, $V1, $K2, $V2, $K3, $V3, job$4242, P$4240, results$4216, (com.ibm.m3rlite.Engine.$Closure$19.$_435bd131) null)));
                                //#line 66 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.lang.Iterable src$4228 = ((x10.lang.Iterable<x10.util.Pair<$K1, $V1>>)
                                                                     ((com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3>)job$4242).source());
                                //#line 69 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final boolean t$4229 = ((src$4228) != (null));
                                //#line 69 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                if (t$4229) {
                                    
                                    //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    final x10.lang.Iterator kv$4230 = ((x10.lang.Iterator<x10.util.Pair<$K1, $V1>>)
                                                                        ((x10.lang.Iterable<x10.util.Pair<$K1, $V1>>)src$4228).iterator());
                                    
                                    //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    for (;
                                         true;
                                         ) {
                                        
                                        //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final boolean t$4231 = ((x10.lang.Iterator<x10.util.Pair<$K1, $V1>>)kv$4230).hasNext$O();
                                        
                                        //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        if (!(t$4231)) {
                                            
                                            //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            break;
                                        }
                                        
                                        //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final x10.util.Pair kv$4169 = ((x10.util.Pair)(((x10.lang.Iterator<x10.util.Pair<$K1, $V1>>)kv$4230).next$G()));
                                        
                                        //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final $K1 t$4170 = (($K1)(((x10.util.Pair<$K1, $V1>)kv$4169).first));
                                        
                                        //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final $V1 t$4171 = (($V1)(((x10.util.Pair<$K1, $V1>)kv$4169).second));
                                        
                                        //#line 70 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        ((com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3>)job$4242).mapper$V((($K1)(t$4170)), $K1, (($V1)(t$4171)), $V1, ((x10.core.fun.VoidFun_0_2)(mSink$4217)), x10.rtt.ParameterizedType.make(x10.core.fun.VoidFun_0_2.$RTT,$K2,$V2));
                                    }
                                }
                                //#line 73 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.lang.PlaceGroup t$4192 = ((x10.lang.PlaceGroup)(x10.lang.Place.places()));
                                //#line 73 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.lang.Iterator q$4193 = ((x10.lang.Iterable<x10.lang.Place>)t$4192).iterator();{
                                    
                                    //#line 73 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    final x10.util.HashMap[] results$4216$value$4258 = ((x10.util.HashMap[])results$4216.value);
                                    
                                    //#line 73 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    for (;
                                         true;
                                         ) {
                                        
                                        //#line 73 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final boolean t$4194 = ((x10.lang.Iterator<x10.lang.Place>)q$4193).hasNext$O();
                                        
                                        //#line 73 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        if (!(t$4194)) {
                                            
                                            //#line 73 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            break;
                                        }
                                        
                                        //#line 73 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final x10.lang.Place q$4172 = ((x10.lang.Place)(((x10.lang.Iterator<x10.lang.Place>)q$4193).next$G()));
                                        
                                        //#line 74 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4173 = q$4172.id;
                                        
                                        //#line 74 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final x10.util.HashMap v$4174 = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)results$4216$value$4258[(int)t$4173]);
                                        
                                        //#line 75 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4175 = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)v$4174).size$O();
                                        
                                        //#line 75 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final boolean t$4176 = ((t$4175) > (((long)(0L))));
                                        
                                        //#line 75 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        if (t$4176) {
                                            {
                                                
                                                //#line 76 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                                x10.lang.Runtime.runAt(((x10.lang.Place)(q$4172)), ((x10.core.fun.VoidFun_0_0)(new com.ibm.m3rlite.Engine.$Closure$20<$K1, $V1, $K2, $V2, $K3, $V3>($K1, $V1, $K2, $V2, $K3, $V3, ((x10.lang.PlaceLocalHandle<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>>)(this.plh)), ((x10.lang.Place)(this.p$4239)), v$4174, (com.ibm.m3rlite.Engine.$Closure$20.$_bd08c0de) null))), ((x10.lang.Runtime.Profile)(null)));
                                            }
                                        }
                                    }
                                }
                                //#line 78 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                x10.lang.Clock.advanceAll();
                                //#line 82 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                long j$4232 = ((long)(((int)(0))));{
                                    
                                    //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    for (;
                                         true;
                                         ) {
                                        
                                        //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4195 = j$4232;
                                        
                                        //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        boolean t$4196 = ((t$4195) < (((long)(P$4240))));
                                        
                                        //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        if (t$4196) {
                                            
                                            //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            final long t$4197 = j$4232;
                                            
                                            //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            final x10.util.HashMap t$4198 = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)incoming$4244$value$4259[(int)t$4197]);
                                            
                                            //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            t$4196 = ((t$4198) == (null));
                                        }
                                        
                                        //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final boolean t$4199 = t$4196;
                                        
                                        //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        if (!(t$4199)) {
                                            
                                            //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            break;
                                        }
                                        
                                        //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4180 = j$4232;
                                        
                                        //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4181 = ((t$4180) + (((long)(1L))));
                                        
                                        //#line 83 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        j$4232 = t$4181;
                                    }
                                }
                                //#line 84 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final long t$4233 = j$4232;
                                //#line 84 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final boolean t$4234 = ((long) t$4233) == ((long) P$4240);
                                //#line 84 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                if (t$4234) {
                                    
                                    //#line 85 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    ((com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3>)job$4242).sink$V(((x10.lang.Iterable)(null)), x10.rtt.ParameterizedType.make(x10.lang.Iterable.$RTT, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, $K3, $V3)));
                                    
                                    //#line 85 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    break L$4212;
                                }
                                //#line 87 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final long t$4235 = j$4232;
                                //#line 87 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.util.HashMap a$4236 = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)incoming$4244$value$4259[(int)t$4235]);
                                //#line 88 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final long t$4237 = j$4232;
                                //#line 88 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                incoming$4244$value$4259[(int)t$4237]=null;{
                                    
                                    //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    final x10.util.HashMap[] incoming$4244$value$4260 = incoming$4244$value$4259;
                                    
                                    //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    for (;
                                         true;
                                         ) {
                                        
                                        //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4200 = j$4232;
                                        
                                        //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4201 = ((t$4200) + (((long)(1L))));
                                        
                                        //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4202 = j$4232 = t$4201;
                                        
                                        //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final boolean t$4203 = ((t$4202) < (((long)(P$4240))));
                                        
                                        //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        if (!(t$4203)) {
                                            
                                            //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            break;
                                        }
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final x10.util.HashMap a$4182 = a$4236;
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4183 = j$4232;
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final x10.util.HashMap b$4184 = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)incoming$4244$value$4260[(int)t$4183]);
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        boolean t$4185 = ((a$4182) != (null));
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        if (t$4185) {
                                            
                                            //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            t$4185 = ((b$4184) != (null));
                                        }
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final boolean t$4186 = t$4185;
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final boolean t$4187 = !(t$4186);
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        if (t$4187) {
                                            
                                            //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            final x10.lang.FailedDynamicCheckException t$4188 = ((x10.lang.FailedDynamicCheckException)(new x10.lang.FailedDynamicCheckException(((java.lang.String)("!(a$4074 != null && b$4075 != null)")))));
                                            
                                            //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                            throw t$4188;
                                        }
                                        
                                        //#line 90 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        com.ibm.m3rlite.Engine.<$K2, $V2> mergeInto__0$1com$ibm$m3rlite$Engine$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$V2$2$2__1$1com$ibm$m3rlite$Engine$$K2$3x10$util$ArrayList$1com$ibm$m3rlite$Engine$$V2$2$2($K2, $V2, ((x10.util.HashMap)(a$4182)), ((x10.util.HashMap)(b$4184)));
                                        
                                        //#line 91 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        final long t$4189 = j$4232;
                                        
                                        //#line 91 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        incoming$4244$value$4260[(int)t$4189]=null;
                                    }
                                }
                                //#line 95 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.util.ArrayList output$4238 = ((x10.util.ArrayList)(new x10.util.ArrayList<x10.util.Pair<$K3, $V3>>((java.lang.System[]) null, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, $K3, $V3)).x10$util$ArrayList$$init$S()));
                                //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.util.Set t$4204 = ((x10.util.Set<$K2>)
                                                              ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)a$4236).keySet());
                                //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                final x10.lang.Iterator k$4205 = ((x10.lang.Iterator<$K2>)
                                                                   ((x10.lang.Iterable<$K2>)t$4204).iterator());
                                //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                for (;
                                     true;
                                     ) {
                                    
                                    //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    final boolean t$4206 = ((x10.lang.Iterator<$K2>)k$4205).hasNext$O();
                                    
                                    //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    if (!(t$4206)) {
                                        
                                        //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                        break;
                                    }
                                    
                                    //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    final $K2 k$4190 = (($K2)(((x10.lang.Iterator<$K2>)k$4205).next$G()));
                                    
                                    //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    final x10.util.ArrayList t$4191 = ((x10.util.HashMap<$K2, x10.util.ArrayList<$V2>>)a$4236).$apply__0x10$util$HashMap$$K$G((($K2)(k$4190)));
                                    
                                    //#line 98 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                    ((com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3>)job$4242).reducer$V((($K2)(k$4190)), $K2, ((x10.lang.Iterable)(t$4191)), x10.rtt.ParameterizedType.make(x10.lang.Iterable.$RTT, $V2), ((x10.util.ArrayList)(output$4238)), x10.rtt.ParameterizedType.make(x10.util.ArrayList.$RTT, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, $K3, $V3)));
                                }
                                //#line 101 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                ((com.ibm.m3rlite.Job<$K1, $V1, $K2, $V2, $K3, $V3>)job$4242).sink$V(((x10.lang.Iterable)(output$4238)), x10.rtt.ParameterizedType.make(x10.lang.Iterable.$RTT, x10.rtt.ParameterizedType.make(x10.util.Pair.$RTT, $K3, $V3)));
                                //#line 103 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                                x10.lang.Clock.advanceAll();
                            }
                            
                            //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            final int t$4207 = i$4209;
                            
                            //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            final int t$4208 = ((t$4207) + (((int)(1))));
                            
                            //#line 62 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                            i$4209 = t$4208;
                        }
                    }
                }}catch (java.lang.Error __lowerer__var__0__) {
                    
                    //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    throw __lowerer__var__0__;
                }catch (java.lang.Throwable __lowerer__var__1__) {
                    
                    //#line 58 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Engine.x10"
                    throw x10.rtt.Types.EXCEPTION.isInstance(__lowerer__var__1__) ? (java.lang.RuntimeException)(__lowerer__var__1__) : new x10.lang.WrappedThrowable(__lowerer__var__1__);
                }
            }
            
            public x10.lang.PlaceLocalHandle<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>> plh;
            public x10.lang.Place p$4239;
            
            public $Closure$21(final x10.rtt.Type $K1, final x10.rtt.Type $V1, final x10.rtt.Type $K2, final x10.rtt.Type $V2, final x10.rtt.Type $K3, final x10.rtt.Type $V3, final x10.lang.PlaceLocalHandle<com.ibm.m3rlite.Engine.State<$K1, $V1, $K2, $V2, $K3, $V3>> plh, final x10.lang.Place p$4239, $_61bcf8f0 $dummy) {
                com.ibm.m3rlite.Engine.$Closure$21.$initParams(this, $K1, $V1, $K2, $V2, $K3, $V3);
                 {
                    ((com.ibm.m3rlite.Engine.$Closure$21<$K1, $V1, $K2, $V2, $K3, $V3>)this).plh = ((x10.lang.PlaceLocalHandle)(plh));
                    ((com.ibm.m3rlite.Engine.$Closure$21<$K1, $V1, $K2, $V2, $K3, $V3>)this).p$4239 = ((x10.lang.Place)(p$4239));
                }
            }
            
        }
        
    }
    
    