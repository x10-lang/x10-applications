package com.ibm.m3rlite;
import x10.compiler.Native;
import x10.util.HashMap;
import x10.util.GrowableRail;
import x10.util.Pair;
import x10.util.ArrayList;

/**
 * A simple multi-place, iterative, main-memory MR engine using one activity 
 * per place.
 * 
 * Let the number of places be P. 
 * This engine requires the job to supply a DataSource, a DataSink, a partition
 * function, a function that determines the termination of iterations, 
 * a Mapper and a Reducer. 
 * 
 * <p> The engine runs simultaneously in P places and uses separate finishes to
 * synchronize the work across many places. In each place, the engine uses the 
 * supplied DataSource to obtain (K1, V1) pairs, runs the supplied Mapper to 
 * obtain a sequence of (K2, V2) pairs, buckets the results into P partitions, and 
 * upon completion transmits to place q the (K2,V2) pairs bucketed for q. Once
 * this has happened at all places, every place has all the incoming (K2, V2) 
 * pairs. These are shuffled together to produce for each key k in K2 the list of
 * all values associated with it. These are then fed to the reducer, which 
 * produces a sequence of (K3, V3) pairs. These are provided to the supplied 
 * DataSource. Once all places have done this, in each place the engine calls
 * the provided termination method on the job to determine whether the engine
 * should continue its execution.
 * 
 * @author vj
 *
 * <p>
 * About resiliency support.
 * <br/>
 * When a place is dead during an iterative map/reduce execution, next iteration
 * will be done excluding the dead place.  The job can call numActivePlaces() and
 * placeIndex(Place), to know the total places used for the calculation and the
 * index of the specified place (0 to numActivePlaces-1).
 * <br/>
 * If an environment variable M3RLITE_NSPARES=n is specified, n places are reserved
 * as spare places, which will replace the dead place.  The spare place has a job
 * instance in its PLH, which was created at the initialization phase, so we may
 * need some mechanism to support dynamic place addition. 
 * <br/>
 * If there is no spare places remaining, the dead place is just excluded and
 * the iteration can continue on the reduced number of places.  This can be
 * disabled by an environment variable M3RLITE_NOSHRINK=1.  In this case, the
 * execution will fail when there is no remaining spare place.
 * <br/>
 * There is another environment variable to control the debug output, M3RLITE_VERBOSE=level
 * <br/>
 * The job for ResilientEngine should: (1) keep the source data resiliently
 * (e.g. by using ResilientStore), (2) divide the source data appropriately using
 * placeIndex() and numActivePlaces(), (3) not use Place.places() or numPlaces() during
 * the execution, and (4) return false in stop() if all data are not processed.
 *
 * @author kawatiya (for resiliency support)
 */
public class ResilientEngine[K1,V1,K2,V2,K3,V3](job:Job[K1,V1,K2,V2,K3,V3]{self!=null}) {
	static def DEBUG(msg:String) { Console.OUT.println("M3RLite: "+msg); }
	static val verbose  = getEnvLong("M3RLITE_VERBOSE");
	static val nspares  = getEnvLong("M3RLITE_NSPARES");  // number of spare places
	static val noshrink = getEnvLong("M3RLITE_NOSHRINK"); // don't shrink #places
	static def getEnvLong(name:String) {
		val env = System.getenv(name);
		val v = (env!=null) ? Long.parseLong(env) : 0;
		if (v>0 && here.id==0) Console.OUT.println(name + "=" + v);
		return v;
	}

	static type NN[T]{T haszero} = T{self!=null};
	static type MyMap[K2,V2] = HashMap[K2,ArrayList[V2]];
	
	static def insert[K2,V2](a:NN[MyMap[K2,V2]], k:K2, v:V2) {
		val gr = a.get(k);
		val gr2 = gr==null? new ArrayList[V2](): gr;
		gr2.add(v);
		a.put(k,gr2);
	}
	static def insert[K2,V2](a:NN[MyMap[K2,V2]], k:K2, v:ArrayList[V2]) {
		val gr = a.get(k);
		val gr2 = gr==null? new ArrayList[V2](): gr;
		gr2.addAll(v);
		a.put(k,gr2);
	}
	static def mergeInto[K2,V2](a:NN[MyMap[K2,V2]], b:NN[MyMap[K2,V2]]):void {
		for (k in b.keySet()) insert(a, k, b(k));
	}
	static class State[K1,V1,K2,V2,K3,V3](job:NN[Job[K1,V1,K2,V2,K3,V3]], 
			incoming:NN[Rail[MyMap[K2,V2]]]){}
	
	// resiliency support
	private val activePlaces:ArrayList[Place] = new	ArrayList[Place](); // places used for the computation
	transient private val sparePlaces:ArrayList[Place] = new ArrayList[Place](); // spare places 
	transient private var iterationNumber:Long = 0;
	transient private var iterationFailed:Boolean = false;
	@x10.compiler.NonEscaping private val master = GlobalRef(this); // master instance //@@@@
	private def numActivePlaces0() = activePlaces.size();
	private def placeIndex0(p:Place) = activePlaces.indexOf(p);
	// utility methods
	public def numLivePlaces()     = numActivePlaces(); // old API, to be removed
	public def numActivePlaces()   = at (master) master().numActivePlaces0();
	public def placeIndex(p:Place) = at (master) master().placeIndex0(p);
	public def getActivePlaces()   = at (master) master().activePlaces;
	public def iterationNumber()   = at (master) master().iterationNumber; // current iteration number (>=0)
	public def iterationFailed()   = at (master) master().iterationFailed; // last iteration failed, should be called from stop()

        // workaround for the change of package name of Runtime from x10.lang to x10.xrx
        @Native("java", "java.lang.management.ManagementFactory.getRuntimeMXBean().getName()")
        @Native("c++", "::x10aux::runtime_name()")
        private static native def getName() : String;

	public def this(job:Job[K1,V1,K2,V2,K3,V3]{self!=null}) {
		property(job);

		// initialize activePlaces and sparePlaces lists
		var num_use:Long = Place.numPlaces() - nspares;
		if (verbose>=1) DEBUG("use " + num_use +" places for the computation");
		if (num_use <= 0) throw new Exception("Too many spare places to run");
		for (p in Place.places()) {
		    try {
			at (p) Console.OUT.println(here+" running in "+getName());
			if (num_use-- > 0) activePlaces.add(p); else sparePlaces.add(p);
		    } catch (e:DeadPlaceException) {
			Console.OUT.println(p+" is dead");
		    }
		}
		if (num_use > 0) throw new Exception("Not enough live places to run");
	}
	public def run() {
		var t0:Long = 0;
		if (verbose>=1)	{ DEBUG("---- run called"); t0 = System.nanoTime(); }

		// distribute the job to all non-dead places
		var tmpPlh:PlaceLocalHandle[State[K1,V1,K2,V2,K3,V3]];
		var inited:Boolean = false;
		while (true) {
		    try {
			val places = activePlaces.clone();
			places.addAll(sparePlaces); // activePlaces + sparePlaces
			places.sort((p1:Place,p2:Place)=>(p1.id-p2.id) as Int);
			if (verbose>=2)	DEBUG("places: "+places);
			tmpPlh = PlaceLocalHandle.make(new SparsePlaceGroup(places.toRail()),
				():State[K1,V1,K2,V2,K3,V3]=> new State(job, 
						new Rail[MyMap[K2,V2]](Place.numPlaces(), (Long)=>new MyMap[K2,V2]())));
			break;
		    } catch (e:Exception) {
			processException(e, 0);
		    }
		}
		val plh = tmpPlh;

		if (verbose>=2) DEBUG("activePlaces: "+activePlaces+"  sparePlaces: " + sparePlaces);
		if (verbose>=1)	{ val t = System.nanoTime(); DEBUG("---- activePlaces prepared in "+((t-t0)/1000000.0)+"msec"); t0 = t; }
		while (true) {
		  try {
			if (job.stop()) break; //TODO: should stop be called before the first iteration?
			iterationNumber++;
			if (iterationFailed) {
				if (verbose>=2) DEBUG("New activePlaces: "+activePlaces);
				iterationFailed = false;

				// clean up possible garbage in the incoming array
				val P = numActivePlaces0();
				finish for (p in activePlaces) at (p) async {
					val incoming = plh().incoming;	
					for (var j:Long=0; j < P; j++) incoming(j) = null;
				}
			}

			// map and communicate phase
			finish for (p in activePlaces) at (p) async {
				val P = numActivePlaces0();
				val job = plh().job; // local copy
				val incoming = plh().incoming;	
				// Prepare and run the mapper
				val results = new Rail[MyMap[K2,V2]](P, (Long) => new MyMap[K2,V2]());
				val mSink = (k:K2,v:V2)=> {insert(results(job.partition(k) % P), k, v);};
				val src = job.source(); // job.source(placeIndex0(here), numActivePlaces0())
				
				// Map Phase: Call the user-supplied mapper
				if (src != null)
					for (kv in src) job.mapper(kv.first, kv.second, mSink);
				
				// Transmit data to all places
				for (q in activePlaces) {
					val v = results(placeIndex0(q));
					if (v.size() > 0)
						at(q) plh().incoming(placeIndex0(p))=v;
				}
			}
			// reduce phase
			finish for(p in activePlaces) at (p) async {	
				val P = numActivePlaces0();
				val job = plh().job; // local copy
				val incoming = plh().incoming;	
				// Now process all the incoming data, shuffling it together
				// Note: the items associated with a key are not sorted.
				var j:Long=0n;
				for (; j < P && incoming(j)==null; j++);
				if (j==P) { // received nothing as input
					job.sink(null); //continue;
				} else {
					val a = incoming(j);
					incoming(j)=null;
					for (; ++j < P;) {
						if (incoming(j)!=null) mergeInto(a, incoming(j));
						incoming(j)=null;
					}
					
					// Now reduce
					val output = new ArrayList[Pair[K3,V3]]();
					
					// Reduce phase: Call the user-suplied reducer
					for (k in a.keySet()) job.reducer(k,a(k), output);
					
					// Sink the result to the job.
					job.sink(output);
				}
			}
		  } catch (e:Exception) {
			processException(e, 0);
		  }
			if (verbose>=1)	{ val t = System.nanoTime(); DEBUG("---- Iteration "+iterationNumber+" finished in "+((t-t0)/1000000.0)+"msec"); t0 = t; }
		}
		if (verbose>=1)	DEBUG("---- run returning");
	}
	
	/**
	 * Process Exception(s)
	 * l is the nest level of MultipleExceptions (for pretty print)
	 */
	private def processException(e:CheckedThrowable, l:Long) {
	    if (e instanceof DeadPlaceException) {
	        val deadPlace = (e as DeadPlaceException).place;
	        DEBUG(new String(new Rail[Char](l,' ')) + "DeadPlaceException thrown from " + deadPlace);
		sparePlaces.remove(deadPlace); // nothing may happen
		val deadIndex = activePlaces.indexOf(deadPlace);
		if (deadIndex >= 0) {
			if (sparePlaces.size() > 0) {	// replace with a spare place
				activePlaces.set(sparePlaces.removeFirst(), deadIndex);
			} else if (noshrink == 0) {	// shrink activePlaces
				activePlaces.remove(deadPlace);
			} else {			// error
				throw new Exception("No spare place to continue");
			}
		        iterationFailed = true;
		}
	    } else if (e instanceof MultipleExceptions) {
	        val exceptions = (e as MultipleExceptions).exceptions();
	        DEBUG(new String(new Rail[Char](l,' ')) + "MultipleExceptions size=" + exceptions.size);
	        val deadPlaceExceptions = (e as MultipleExceptions).getExceptionsOfType[DeadPlaceException]();
	        for (dpe in deadPlaceExceptions) {
	            processException(dpe, l+1);
	        }
	        val filtered = (e as MultipleExceptions).filterExceptionsOfType[DeadPlaceException]();
	        if (filtered != null) throw filtered;
	    } else {
	        throw new Exception("Unhandled exception ", e);
	    }
	}
}
