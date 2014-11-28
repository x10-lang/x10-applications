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
import x10.util.concurrent.AtomicLong;

/**
 * KMeans for Resilient M3R Lite
 * @author kawatiya
 *
 * K1(Long): 0
 * V1(Long): Data ID (in 0~N-1)
 * K2(Long): New cluster ID of the data (in 0 to NC-1)
 * V2(Long): Data ID added to the custer (in 0~N-1)
 * K3(Long): Cluster ID (in 0~NC-1)
 * V3(Rail[Double]): New center of the cluster (Double value x ND)
 */
public class ResilientKMeansM3R implements Job[Long,Long,Long,Long,Long,Rail[Double]] {
    static def DEBUG(msg:String) { Console.OUT.println("Place "+here.id+": "+msg); }

    @x10.compiler.NonEscaping
    private val master = GlobalRef(this); // master instance
    private var engine:ResilientEngine[Long,Long,Long,Long,Long,Rail[Double]];

    val N :Long; // Number of points
    val NC:Long; // Number of clusters
    val ND:Long; // Dimensions of points
    val data:PlaceLocalHandle[Rail[Double]]; // ND*N values (not changed)

    transient var clusters:Rail[Double]; // ND*NC values
    transient var clusters_new:Rail[Double];
    transient val clusters_new_count:AtomicLong = new AtomicLong(); // number of updated clusters
    transient var diff:Double = Double.MAX_VALUE; // diff from the old clusters

    public def this(n:Long, nc:Long, nd: Long, d:Rail[Double]) {
        N = n; NC = nc; ND = nd;
        data = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>d); // deliver points data to all places
        clusters = new Rail[Double](ND*NC, (i:Long)=>d(i)); // use the first NC points as the initial cluster values
        clusters_new = new Rail[Double](ND*NC);
    }

    // K1=0, V1=data ID
    public def source() { // source(placeIndex:Long, numLivePlaces:Long)
        val h = here;
        clusters = at (master) { // set the latest cluster info into local job instance
            if (here==h) master().clusters_new_count.set(0); // reset the count in master
            master().clusters
        };
        val placeIndex = engine.placeIndex(h), numLivePlaces = engine.numLivePlaces();
        val startIndex = placeIndex * N / numLivePlaces;
        val endIndex = (placeIndex+1) * N / numLivePlaces;
        //DEBUG("source created (start="+startIndex+" end="+endIndex+")");
        return new Iterable[Pair[Long,Long]]() {
            public def iterator() = new Iterator[Pair[Long,Long]]() {
                var idata:Long = startIndex; //@@@@ this does not work?  0 is always set
                public def hasNext() = idata < endIndex;
                public def next() {
                    if (idata < startIndex) idata = startIndex; //@@@@ quick hack for the above bug
                    //DEBUG("source passed data "+idata+" (start="+startIndex+" end="+endIndex+")");
                    return Pair[Long,Long](0, idata++);
                }
            };
        };
    }

    // K1=0, V1=data ID, K2=cluster ID, V2=data ID belonging to that cluster
    public def mapper(k:Long, v:Long, msink:(Long,Long)=>void) {
        //DEBUG("map data "+v+" for clusters="+clusters);
        var dmin:Double = Double.MAX_VALUE;
        var idmin:Long = -1;
        // find the nearest cluster
        for (var i:Long = 0; i < NC; i++) {
            var d:Double = 0.0;
            for (var j:Long = 0; j <ND; j++) {
                val t:Double = data()(v*ND + j) - clusters(i*ND + j);
                d += t*t;
            }
            //DEBUG("data "+v+" cluster "+i+" diff="+d);
            if (d < dmin) { dmin = d; idmin = i; }
        }
        //DEBUG("mapper mapped data "+v+" to cluster "+idmin);
        msink(idmin, v); // nearest cluster ID and data ID
    }

    // K2=cluster ID
    public def partition(k:Long) = k;

    // K2=cluster ID, V2=data ID, K3=cluster ID, V3=new center of the cluster
    public def reducer(a:Long, b:Iterable[Long], output:ArrayList[Pair[Long, Rail[Double]]]) {
        if (b == null) return ; // no data to process
        var pos:Rail[Double] = new Rail[Double](ND, 0.0);
        var c:Long = 0;
        for (v in b) {
            c++; for (var j:Long = 0; j < ND; j++) pos(j) += data()(v*ND + j);
        }
        for (var j:Long = 0; j < ND; j++) pos(j) /= c;
        output.add(Pair(a as Long, pos));
    }

    // K3=cluster ID, V3=New center the cluster
    public def sink(s:Iterable[Pair[Long, Rail[Double]]]) {
        if (s == null) return; // no data to process
        //DEBUG("sink received "+s);
        at (master) {
            val m = master.getLocalOrCopy();
            val c_new = m.clusters_new;
            val c_new_count = m.clusters_new_count;
            var c:Long = -1;
            // set the new center of clusters to the master
            for (kv in s) {
                val k = kv.first;  // cluster ID
                val v = kv.second; // center of the cluster
                for (var j:Long = 0; j < ND; j++) c_new(k*ND + j) = v(j);
                c = c_new_count.incrementAndGet();
            }
            assert c <= NC;

            // the last comer does the convergency check
            if (c == NC) {
                var d:Double = 0.0;
                val c_old = m.clusters;
                for (var i:Long = 0; i < NC; i++) {
                    for (var j:Long = 0; j < ND; j++) {
                        var t:Double = c_new(i*ND + j) - c_old(i*ND + j);
                        d += t*t;
                    }
                }
                DEBUG("diff="+d+" clusters="+c_new);
                // m.clusters_new_count.set(0); // move this to source, since this may not be executed if a place is dead
                m.clusters_new = c_old; // swap the clusters and clusters_new
                m.clusters = c_new;
                m.diff = d;
            }
        }
    }

    // called only for the master
    public def stop() = (diff < 1.0e-8); // converged

    /*
     * Test routines
     */
    public static def calc_kmeans(n:Long, nc:Long, nd: Long, d:Rail[Double]):Rail[Double] {
        DEBUG("calc_kmeans");
        val job = new ResilientKMeansM3R(n, nc, nd, d);
        val engine = new ResilientEngine(job);
        job.engine = engine; // to make the engine accessible from job
        engine.run();
	// Console.OUT.println("==== test to call run twice"); job.clusters = new Rail[Double](job.ND*job.NC, (i:Long)=>job.data()(i)); job.diff = Double.MAX_VALUE; engine.run();
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
        val d = new Rail[Double](ND*N, (i:Long)=>rnd.nextDouble());

        val clusters = calc_kmeans(N, NC, ND, d);

        // print the result in clusters
        for (var i:Long = 0; i < NC; i++) {
            Console.OUT.print("Cluster["+i+"] :");
            for (var j:Long = 0; j < ND; j++) Console.OUT.print(" " + clusters(i*ND + j));
            Console.OUT.println();
        }
    }

    public static def testWithSimple(args:Rail[String]) {
        DEBUG("testWithSimple");
        val N  : Long = (args.size > 0) ? Long.parseLong(args(0)) : 8;
        val NC : Long = (args.size > 1) ? Long.parseLong(args(1)) : 4;
        val ND : Long = 1;
        Console.OUT.println("N = " + N);
        Console.OUT.println("num of Clusters = " + NC);
        Console.OUT.println("dimension = " + ND);

        val d = new Rail[Double](ND*N, (i:Long)=>i as Double); // 0 1 2 3 4 5 6 7
        val clusters = calc_kmeans(N, NC, ND, d);
        for (var i:Long = 0; i < NC; i++)
            Console.OUT.println("Cluster["+i+"] : " + clusters(i)); // 0.0 1.5 3.5 6.0
    }

    public static def testWithSimple2(args:Rail[String]) {
        DEBUG("testWithSimple2");
        val N  = 1000000, NC = 8, ND = 1;
        val d = new Rail[Double](ND*N, (i:Long)=>i as Double);
        val clusters = calc_kmeans(N, NC, ND, d);
        for (var i:Long = 0; i < NC; i++)
            Console.OUT.println("Cluster["+i+"] : " + clusters(i));
    }

    public static def main(args:Rail[String]) {
	testWithSimple(args); // 1000000 8 for larger test
//	testWithRandom(args);
    }
}
