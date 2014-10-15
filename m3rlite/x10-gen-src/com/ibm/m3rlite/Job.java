package com.ibm.m3rlite;


@x10.runtime.impl.java.X10Generated
public interface Job<$K1, $V1, $K2, $V2, $K3, $V3> extends x10.core.Any
{
    public static final x10.rtt.RuntimeType<Job> $RTT = 
        x10.rtt.NamedType.<Job> make("com.ibm.m3rlite.Job",
                                     Job.class,
                                     6);
    
    

    
    
    //#line 22 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Job.x10"
    long partition$J(final java.lang.Object k, x10.rtt.Type t1);
    
    
    //#line 28 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Job.x10"
    boolean stop$O();
    
    
    //#line 36 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Job.x10"
    x10.lang.Iterable source();
    
    
    //#line 46 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Job.x10"
    void sink$V(final x10.lang.Iterable id$1454, x10.rtt.Type t1);
    
    
    //#line 67 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Job.x10"
    void mapper$V(final java.lang.Object id$1455, x10.rtt.Type t1, final java.lang.Object id$1456, x10.rtt.Type t2, final x10.core.fun.VoidFun_0_2 id$1459, x10.rtt.Type t3);
    
    
    //#line 89 "/Users/vijaysaraswat/Downloads/x10dt-4/x10dt.app/Contents/MacOS/~/x10ws-1/m3rlite/src/com/ibm/m3rlite/Job.x10"
    void reducer$V(final java.lang.Object id$1460, x10.rtt.Type t1, final x10.lang.Iterable id$1461, x10.rtt.Type t2, final x10.util.ArrayList id$1462, x10.rtt.Type t3);
}

