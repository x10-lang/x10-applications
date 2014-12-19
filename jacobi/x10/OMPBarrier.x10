import x10.util.concurrent.AtomicInteger;
import x10.xrx.Runtime;

public final class OMPBarrier(count:Int) {
    private val alive = new AtomicInteger(count);
    private val workers = new Rail[Runtime.Worker](count);
    private val index = new AtomicInteger(0n);

    /* constructs an SPMDBarrier for the given task count */
    /* does not implicitly register caller task */
    public def this(count:Int) {
        property(count);
        assert (Runtime.NTHREADS >= count) : "OMPBarrier constructor invoked with task count greater than Runtime.NTHREADS";
    }
    
    /* register caller task with the barrier */
    public def register() {
    	val i = index.getAndIncrement();
    	assert (i < count) : "OMPBarrier register invoked too many times";
        workers(i) = Runtime.worker();
    }

    /* let only one task proceed */
    public def single() {
        if (alive.decrementAndGet() == 0n) {
            return true;
        } else {
            Runtime.Worker.park();
            return false;
        }
    }

    /* resume all tasks */
    public def multi() {
 		alive.set(count);
  		for (var i:Int=0n; i<count; ++i) workers(i).unpark();
  		Runtime.Worker.park();
    }
}
