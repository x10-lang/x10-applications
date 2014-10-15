package com.ibm.m3rlite.example;
import com.ibm.m3rlite.Job;
import x10.util.Pair;
import x10.util.ArrayList;
import com.ibm.m3rlite.Engine;

/**
 * An example of the user of the MRLite API. At each place, a rail contains
 * numbers. We output for each number x (contained in a rail at any place)
 * the total number of times that x occurs in any rail at any place.
 */
public class Histogram(plh:PlaceLocalHandle[Rail[Long]],
		plh2:PlaceLocalHandle[ArrayList[Pair[Long,Long]]]) 
   implements Job[Long,Long,Long,Long,Long,Long] {
	var i:Long=0;
	public def stop():Boolean=i++ > 0; // run once
	
	public def source()= new Iterable[Pair[Long,Long]]() {
		public def iterator() = new Iterator[Pair[Long,Long]]() {
			val data = plh();
			var i:Long=0;
			public def hasNext() = i < data.size;
			public def next() = Pair[Long,Long](0,data(i++));
		};
	};
	public def partition(k:Long)=k % Place.numPlaces();
	
	public def sink(s:Iterable[Pair[Long, Long]]): void {
		for (kv in s)  {
			plh2().add(kv);
			//Console.OUT.println(here + " sees: " + kv);
		}
	}
	
	public def mapper(k:Long, v:Long, s:(Long,Long)=>void):void {
		s(v,k);
	}

	public def reducer(a:Long, b:Iterable[Long], sink:ArrayList[Pair[Long, Long]]): void {
		var sum:Long=0L; 
		if (b !=null) for (x in b) sum += 1;
		sink.add(Pair(a as Long, sum));
	}
	public static def test0(args:Rail[String]) {
		val N = args.size > 0 ? Long.parseLong(args(0)) : 10;
		Console.OUT.println("N=" + N);
		val h=new Histogram(PlaceLocalHandle.make(Place.places(), 
				():Rail[Long] => new Rail[Long](N, (i:Long)=> i)),
				PlaceLocalHandle.make(Place.places(),
						():ArrayList[Pair[Long,Long]]=> new ArrayList[Pair[Long,Long]]()));
		new Engine(h).run();
		try {
			val n = finish(Reducible.SumReducer[Long]()) {
				for (p in Place.places()) async at(p) {
					val a = h.plh2();
					for (kv in a) {
						if (kv.second != Place.numPlaces()) {
							Console.OUT.println(here + " error:" + kv);
						}
					}
					offer a.size();
				}
			};
			if (n != N) {
				Console.OUT.println(here + " error. Expected " + N + " got " + n);
			} else 
				Console.OUT.println("test0 ok.");
		} catch (s:Exception) {
			s.printStackTrace();
		}
		
	}
	public static def main(args:Rail[String]) {
		test0(args);
	}

}