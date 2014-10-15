package com.ibm.m3rlite;
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
 * <p> The engine runs simultaneously in P places and uses a clock to synchronize
 * the work across many places. In each place, the engine uses the 
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
 */
public class Engine[K1,V1,K2,V2,K3,V3](job:Job[K1,V1,K2,V2,K3,V3]{self!=null}) {
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
	
	public def run() {
		val plh = PlaceLocalHandle.make(Place.places(),
				():State[K1,V1,K2,V2,K3,V3]=> new State(job, 
						new Rail[MyMap[K2,V2]](Place.numPlaces(), (Long)=>new MyMap[K2,V2]())));
		for (var i:Int=0n; ! job.stop(); i++) {
			// map and communicate phase
			finish for(p in Place.places()) at (p) async {
				val P = Place.numPlaces();
				val job = plh().job; // local copy
				val incoming = plh().incoming;	
				// Prepare and run the mapper
				val results = new Rail[MyMap[K2,V2]](P, (Long) => new MyMap[K2,V2]());
				val mSink = (k:K2,v:V2)=> {insert(results(job.partition(k) % P), k, v);};
				val src = job.source();
				
				// Map Phase: Call the user-supplied mapper
				if (src != null)
					for (kv in src) job.mapper(kv.first, kv.second, mSink);
				
				// Transmit data to all places
				for (q in Place.places()) { 
					val v = results(q.id);
					if (v.size() > 0)
						at(q) plh().incoming(p.id)=v;
				}
			}
		// reduce phase
			finish for(p in Place.places()) at (p) async {	
				val P = Place.numPlaces();
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
						mergeInto(a, incoming(j));
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
		}
	}
}