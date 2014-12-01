/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2014.
 */
package com.ibm.m3rlite.example;

import com.ibm.m3rlite.Job;
import com.ibm.m3rlite.ResilientEngine;
import x10.util.Pair;
import x10.util.ArrayList;

/**
 * KMeans for Resilient M3R Lite, this version uses ResilientStore for source and sink
 *
 * @author kawatiya
 *
 * K1(Long)  : Data ID (in 0~N-1)
 * V1(Coords): Coordinates of the data (Double value x ND)
 * K2(Long)  : New cluster ID of the data (in 0~NC-1)
 * V2(Coords): Coordinates added to the cluster (Double value x ND)
 * K3(Long)  : Cluster ID (in 0~NC-1)
 * V3(Coords): New coordinates of the cluster (Double value x ND)
 *
 * Compile:
	x10c -sourcepath ~/X10/trunk/x10.dist/samples/resiliency com/ibm/m3rlite/example/ResilientKMeansM3R_2.x10
 * Execute example (ResilientStore on Place0):
	X10_RESILIENT_MODE=1 X10_NPLACES=8 \
	M3RLITE_NSPARES=1 M3RLITE_VERBOSE=1 \
	x10 com.ibm.m3rlite.example.ResilientKMeansM3R_2 10000 8
 * Execute example (ResilientStore on Hazelcast):
	X10_RESILIENT_MODE=12 X10_NPLACES=8 \
	M3RLITE_NSPARES=1 M3RLITE_VERBOSE=1 \
	X10_RESILIENT_STORE_MODE=2 X10_RESILIENT_STORE_VERBOSE=0 \
	x10 -DX10RT_DATASTORE=Hazelcast \
	com.ibm.m3rlite.example.ResilientKMeansM3R_2 10000 8
 */
static public type Coords = Rail[Double];
public class ResilientKMeansM3R_2 implements Job[Long,Coords, Long,Coords, Long,Coords] {
    static def DEBUG(msg:String) { Console.OUT.println("KMeansM3R(place="+here.id+"): "+msg); }

    static val useHC = getEnvLong("KMEANS_USEHC"); // 1=Use Hazelcast as ResilientStore
    static def getEnvLong(name:String) {
    	val env = System.getenv(name);
    	val v = (env!=null) ? Long.parseLong(env) : 0;
    	if (v>0 && here.id==0) Console.OUT.println(name + "=" + v);
    	return v;
    }
    static def getResilientStore[K,V](name:String){V haszero} = x10.resilient.util.ResilientStoreForApp.make[K,V]();
//  static def getResilientStore[K,V](name:String){K haszero,V haszero}:ResilientStore[K,V] {
//      if (useHC == 0) return ResilientStorePlace0.make[K,V](name);
//      else return ResilientStoreHC.make2[K,V](name, Zero.get[K]()/*dummy lockKey*/);
//  }

    static val RS_CHUNK = 10000; // data is stored by this chunk

    @x10.compiler.NonEscaping
    private val master = GlobalRef(this); // master instance
    private var engine:ResilientEngine[Long,Coords, Long,Coords, Long,Coords];

    val N :Long; // Number of points
    val NC:Long; // Number of clusters
    val ND:Long; // Dimensions of points

  //val rs_data = getResilientStore[Long/*K1*/,Coords/*V1*/]("data"); // resilient store to store N coords
    val rs_data = getResilientStore[Long/*K1*/,Rail[Coords]/*Rail[V1]*/]("data"); // resilient store to store N coords by RS_CHUNK
    transient var myData:Rail[Coords]; // part of N coords for this place ([startIndex,endIndex))
    transient var startIndex:Long = -1, endIndex:Long = -1; // range of myData

    val rs_clusters = getResilientStore[Long/*K3*/,Coords/*V3*/]("clusters"); // resilient store to store cluster values
    transient var clusters:Rail[Coords]; // NC coords

    // Create a "master" job instance
    public def this(n:Long, nc:Long, nd: Long, d:Rail[Coords]) {
        N = n; NC = nc; ND = nd;
        clusters = new Rail[Coords](NC, (i:Long)=>d(i)); // use the first NC points as the initial cluster values

        // put data into ResilientStore
        DEBUG("Storing data into ResilientStore");
      //for (var i:Long = 0; i < N; i++) rs_data.put(i, d(i));
        val chunk = new Rail[Coords](RS_CHUNK);
        for (var i:Long = 0; i < N; i += RS_CHUNK) {
            val remainSize = N-i;
            val copySize = Math.min(remainSize, RS_CHUNK);
            Rail.copy(d, i, chunk, 0, copySize);
            if (copySize < RS_CHUNK) chunk.clear(copySize, RS_CHUNK-copySize);
            rs_data.put(i, chunk);
        }
    }

    // K1=data ID, V1=coordinates of the data
    public def source() { // source(placeIndex:Long, numLivePlaces:Long)
        val h = here;
        clusters = at (master) master().clusters; // set the latest cluster info into local job instance
        val placeIndex = engine.placeIndex(h), numLivePlaces = engine.numLivePlaces();
        val s = placeIndex * N / numLivePlaces;
        val e = (placeIndex+1) * N / numLivePlaces;
        if (s != startIndex || e != endIndex) {
            // get data from ResilientStore
            DEBUG("Loading data ["+s+","+e+") from ResilientStore");
          //myData = new Rail[Coords](e-s, (i:Long)=>rs_data.getOrElse(s+i,null));
            myData = new Rail[Coords](e-s);
            for (var i:Long = 0; i < N; i += RS_CHUNK) {
                if (i+RS_CHUNK < s) continue; if (e <= i) break;
                val chunk = rs_data.getOrElse(i,null) as Rail[Coords];
                assert chunk.size==RS_CHUNK;
                val chunkStart:Long, myDataStart:Long, copySize:Long;
                if (i < s) { chunkStart = s-i; myDataStart = 0; copySize = Math.min(e-s, RS_CHUNK-chunkStart); }
                else       { chunkStart = 0; myDataStart = i-s; copySize = Math.min(RS_CHUNK, e-i); }
                Rail.copy(chunk, chunkStart, myData, myDataStart, copySize);
            }
            //DEBUG("Loaded data from ResilientStore: myData="+myData);
            startIndex = s; endIndex = e;
        }
        return new Iterable[Pair[Long,Coords]]() {
            public def iterator() = new Iterator[Pair[Long,Coords]]() {
                var idata:Long = 0;
                public def hasNext() = (startIndex+idata < endIndex);
                public def next() {
                    val p = Pair[Long,Coords](startIndex+idata, myData(idata));
                    idata++;
                    //DEBUG("source: passing data "+p);
                    return p;
                }
            };
        };
    }

    // K1=data ID, V1=coordinates of the data, K2=cluster ID, V2=coordinates added to the cluster
    public def mapper(k:Long, v:Coords, msink:(Long,Coords)=>void) {
        //DEBUG("mapper: mapping data "+k+" v="+v+" for clusters="+clusters);
        var dmin:Double = Double.MAX_VALUE;
        var idmin:Long = -1;
        // find the nearest cluster
        for (var i:Long = 0; i < NC; i++) {
            var d:Double = 0.0;
            for (var j:Long = 0; j <ND; j++) {
                val t:Double = v(j) - clusters(i)(j);
                d += t*t;
            }
            //DEBUG("mapper: data "+k+" cluster "+i+" diff="+d);
            if (d < dmin) { dmin = d; idmin = i; }
        }
        //DEBUG("mapper: mapped data "+k+" to cluster "+idmin);
        msink(idmin, v); // nearest cluster ID and data ID
    }

    // K2=cluster ID
    public def partition(k:Long) = k;

    // K2=cluster ID, V2=coordinates, K3=cluster ID, V3=new coordinates of the cluster
    public def reducer(a:Long, b:Iterable[Coords], output:ArrayList[Pair[Long,Coords]]) {
        if (b == null) return ; // no data to process
        var pos:Coords = new Coords(ND, 0.0);
        var c:Long = 0;
        for (v in b) {
            //DEBUG("reducer: reducing cluster "+a+" v="+v);
            c++; for (var j:Long = 0; j < ND; j++) pos(j) += v(j);
        }
        for (var j:Long = 0; j < ND; j++) pos(j) /= c;
        //DEBUG("reducer: reduced cluster"+a+" to "+pos);
        output.add(Pair(a as Long, pos));
    }

    // K3=cluster ID, V3=new coordinates of the cluster
    public def sink(s:Iterable[Pair[Long,Coords]]) {
        if (s == null) return; // no data to process
        //DEBUG("sink: received "+s);
        for (kv in s) {
            val k = kv.first;  // cluster ID
            val v = kv.second; // center of the cluster
            rs_clusters.put(k, v); // put the cluster data into ResilientStore
        }
    }

    // called only for the master
    public def stop() {
        val iterNum = engine.iterationNumber();
        val iterFailed = engine.iterationFailed();
        //DEBUG("stop: iterNum="+iterNum+" iterFailed="+iterFailed);
        if (engine.iterationFailed()) { // some livePlace died in the last iteration
            DEBUG("Failed iteration, skipping");
            return false;
        } else if (iterNum == 0) { // first stop() call before the execution
            return false;
        } else { // iteration succeeded without place death
            // update the cluster values and calculate diff
            var diff:Double = 0.0; // diff from the old clusters
            for (var i:Long = 0; i < NC; i++) {
                val v = rs_clusters.getOrElse(i,null) as Coords/*V3*/; // get the new cluster data from ResilientStore
                assert v != null;
                for (var j:Long = 0; j < ND; j++) {
                    var t:Double = v(j) - clusters(i)(j);
                    diff += t*t;
                }
                clusters(i) = v;
            }
            DEBUG("diff="+diff/*+" clusters="+clusters*/);
            return (diff < 1.0e-8); // converged
        }
    }

    /*
     * Test routines
     */
    public static def calc_kmeans(n:Long, nc:Long, nd: Long, d:Rail[Coords]):Rail[Coords] {
        DEBUG("calc_kmeans");
        val job = new ResilientKMeansM3R_2(n, nc, nd, d);
        val engine = new ResilientEngine(job);
        job.engine = engine; // to make the engine accessible from job
        engine.run();
	// Console.OUT.println("==== test to call run twice"); job.clusters = new Coords(job.ND*job.NC, (i:Long)=>job.data()(i)); job.diff = Double.MAX_VALUE; engine.run();
        return job.clusters;
    }

    public static def testWithRandom(args:Rail[String]) {
        DEBUG("testWithRandom");
        val N  : Long = (args.size > 0) ? Long.parseLong(args(0)) : 1000;
        val NC : Long = (args.size > 1) ? Long.parseLong(args(1)) : 10;
        val ND : Long = (args.size > 2) ? Long.parseLong(args(2)) : 2;
        Console.OUT.println("N = " + N);
        Console.OUT.println("num of Clusters = " + NC);
        Console.OUT.println("dimension = " + ND);

        // init the N points randomly
        val rnd = new x10.util.Random(100); // Random(System.nanoTime());
        val d = new Rail[Coords](N, (i:Long)=>new Coords(ND, (j:Long)=>rnd.nextDouble()));

        val clusters = calc_kmeans(N, NC, ND, d);

        // print the result in clusters
        for (var i:Long = 0; i < NC; i++) {
            Console.OUT.print("Cluster["+i+"] :");
            for (var j:Long = 0; j < ND; j++) Console.OUT.print(" " + clusters(i)(j));
            Console.OUT.println();
        }
    }

    public static def testWithSimple(args:Rail[String]) {
        DEBUG("testWithSimple");
        val N  : Long = (args.size > 0) ? Long.parseLong(args(0)) : 8;
        val NC : Long = (args.size > 1) ? Long.parseLong(args(1)) : 4;
        val ND : Long = (args.size > 2) ? Long.parseLong(args(2)) : 1;
        Console.OUT.println("N = " + N);
        Console.OUT.println("num of Clusters = " + NC);
        Console.OUT.println("dimension = " + ND);

        val d = new Rail[Coords](N, (i:Long)=>new Coords(ND, i as Double)); // 0 1 2 3 4 5 6 7
        val clusters = calc_kmeans(N, NC, ND, d);

        for (var i:Long = 0; i < NC; i++) {
            Console.OUT.print("Cluster["+i+"] :");
            for (var j:Long = 0; j < ND; j++) Console.OUT.print(" " + clusters(i)(j)); // 0.0 1.5 3.5 6.0
            Console.OUT.println();
        }
    }

    public static def main(args:Rail[String]) {
	testWithSimple(args); // 1000000 8 for larger test
//	testWithRandom(args);
    }
}
