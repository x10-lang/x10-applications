/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2013-2014.
 */
package com.ibm.m3rlite.example;

import com.ibm.m3rlite.Job;
import com.ibm.m3rlite.ResilientEngine;

import x10.util.Pair;
import x10.util.ArrayList;
import x10.util.logging.LogFactory;
import x10.io.File;

/**
 * <p>
 * Mapper Input
 *  K1: Long         (index number for each line) 
 *  V1: Rail[Int]    (actual training input set)
 * Mapper Output / Reducer Input
 *  K2: Long         (reduction key for sending a local learnt HMM) 
 *  V2: HMMModel     (a local learnt HMM from partial training data)
 * Reducer output
 *  K3: Long         (same as K2)
 *  V3: HMMModel     (AllGather learnt HMM and emit it to master)
 * 
 * 
 * @author tchiba
 */
public class ResilientHMM(S:Int, O:Int, N:Long, maxIter:Long, eps:Double, fileName:String) implements Job[Long,Rail[Int],Long,HMMModel,Long,HMMModel] {
	//val S:Int;			// number of states
	//val O:Int;			// number of observations
	//val N:Long;			// total number of lines
	//val fileName:String;	// input file name
	//val maxIter:Long;		// maximum iterations
	//val eps:Double;		// if delta < eps, break iteration loop
	
	private static val logger = LogFactory.getLog[ResilientHMM]();
	
	/* definition */
	public static type Obs = HMMModel.Obs; // actual type is Rail[Int]
	
	/* variables */
	var master:GlobalRef[ResilientHMM]; //master instance
	transient var engine:ResilientEngine[Long,Obs,Long,HMMModel,Long,HMMModel];
	
	var data:Rail[Obs] = null;
	var assignedLines:Long = 0;

	var currentIter:Long = 0;

	/* HMM parameters */
	public var black:HMMModel = HMMModel.makeRandomModel(S,O);
	public var red:HMMModel = HMMModel.makeRandomModel(S,O);
	public val copy = new HMMModel(S,O);
	var delta:Double = Double.MAX_VALUE;
	//val epsilon:Double = 0.001D;

	public def model() = black;
	
	/**
	 * source() is called at first of iteration.
	 * it checks live places and decides assigned range of data if needed. 
	 */
	public def source():Iterable[Pair[Long,Obs]] {
		val h = here;
		val t = at (master) {
			val m = master.getLocalOrCopy();
			if (h.id == 0) logger.info(String.format("source(): iteration=%1$d", [m.currentIter as Any]));
			return new Pair[Long,Long](m.engine.placeIndex(h), m.engine.numLivePlaces());
		};
		
		// at first, training data is loaded
		// TODO: for checking resiliency, loading(read file) occurs everytime...
		val myplaceid = t.first;
		val liveplaces = t.second;
		
		//logger.info(String.format("S=%1$d, O=%2$d, N=%3$d, filename=%4$s", 
		//		[S as Any, O, N, fileName]));	
		val start = (N/liveplaces) * myplaceid;
		val end = myplaceid+1==liveplaces ? start + N/liveplaces + N%liveplaces : start + N/liveplaces;
		
		data = new Rail[Obs](end-start);
		assignedLines = end-start; // re-assign data in each iteration. 
				
		//read file and extract own range of data
		val file = new File(fileName);
		var i:Long = 0;
		var idx:Long = 0;
		for (line_ in file.lines()) {
			if (i < start) { i++; continue;}
			if (i >= end) { break;}
			
			val line = line_.trim();
			if (line.length() == 0N) continue;
			
			val strs = line.split(" ");
			data(idx) = new Obs(strs.size, (j:Long)=>Int.parse(strs(j)));
			idx++;
			i++;
		}
		logger.info(String.format("source(): active places=%2$d, range of place(%1$d):(start=%3$d,end=%4$d), len=%5$d", 
				[myplaceid as Any, liveplaces, start, end, idx]));
		
		// initialize local parameter from master
		red.setToZero();
		val masterBlack = at (master) {
			return master().black;
		};
		copy.setTo(masterBlack);
				
		return new Iterable[Pair[Long, Obs]]() {
			public def iterator() = new Iterator[Pair[Long,Obs]]() {
				var idata:Long = 0;
				public def hasNext() = idata < end - start;
				public def next() {
					val pos = idata;
					idata++;
					return Pair[Long,Obs](pos, data(pos));
				}
			};
		};
	}
	
	/**
	 * mapper() creates a HMM from local stored training data. 
	 * after completion of training, mapper distributes the own HMM 
	 * to all of other places (All-to-All). 
	 * each observation line contributes to the local HMM iteratively. 
	 *  1). read a new observation line.
	 *  2). do forward/backward algorithm for training. 
	 *  3). update(add-in) the result to local HMM. 
	 */
	public def mapper(k:Long, v:Obs, msink:(Long, HMMModel)=>void) {
		//logger.info(String.format("k1=%1$d, v1=%2$s", [k as Any, v]));
		black.update(v,red);
		
		if (assignedLines-1 == k) {
			logger.info(String.format("mapper(): complete to read training data (%1$d lines)", [(k+1) as Any]));
			val numLivePlaces = at (master) {
				val m = master.getLocalOrCopy();
				return m.engine.numLivePlaces();
			};
			for (dest in 0..(numLivePlaces-1)) {
				val t = here.id;
				logger.info(String.format("mapper(): emit local hmm (%1$d -> %2$d)", [t as Any, dest]));
				msink(dest, red);
			}
		}
	}
	
	/**
	 * partition key == place id
	 */
	public def partition(k:Long) = k;
	
	/**
	 * reducer() appends received learnt HMM result to local learnt HMM
	 */
	public def reducer(k2:Long, v2:Iterable[HMMModel], output:ArrayList[Pair[Long, HMMModel]]) {
		for (v in v2) {
			logger.info(String.format("reducer(): process received hmm (k2=%1$d)", [k2 as Any]));
			black.setToSum(black, v);
		}
		output.add(Pair(k2 as Long, black));
	}
	
	/**
	 * sink() finalizes All-Gathered HMM
	 *   - normalization
	 *   - check delta
	 *   - write the result HMM to master 
	 */
	public def sink(s:Iterable[Pair[Long, HMMModel]]) {
		if (s == null) return;
		black.normalize();
		delta = copy.distance(black);
		// write results to master
		if (here.id == 0) at (master) {
			logger.info(String.format("sink():  new delta value = %1$.5f", [delta as Any]));
			master().delta = delta;
			master().currentIter++;
			master().black.setTo(black);
		}
	}
	
	/**
	 * stop() checks iteration count and delta
	 */
	public def stop():boolean {
		val t = at (master) {
			return Pair[Long,Double](master().currentIter, master().delta);
		};
		if (t.first == maxIter) {
			logger.info("stop(): stop iteration(maxIter)");
			return true;
		}
		if (t.second == Double.NaN || t.second <= eps){
			logger.info("stop(): stop iteration(epsilon)");
			return true;
		}
		return false;
	}
	
	public static def runTestCase1(args:Rail[String]):HMMModel {
		val args0 = args.size > 0 ? args: ["10","6","100","10", "0.001","testdata/sample.dat"];
		try{
			val job = new ResilientHMM(
					Int.parse(args0(0)), 
					Int.parse(args0(1)), 
					Long.parse(args0(2)), 
					Long.parse(args0(3)),
					Double.parse(args0(4)),
					args0(5));
			job.master = GlobalRef[ResilientHMM](job);
			if (logger.isInfoEnabled()) {
				val startHMM = job.black;
				logger.info("initialized start random HMM");
				startHMM.print(Console.OUT);
			}
			val engine = new ResilientEngine(job);
			job.engine = engine;
			engine.run();
			return job.black;
		} catch(e:Exception) {
			e.printStackTrace();
		}
		return null;
	}
	
    public static def main(args: Rail[String]) {
    	logger.info("training phase is started.");
    	val startTime = System.nanoTime();
    	val learntHMM = runTestCase1(args);
    	learntHMM.print(Console.OUT);  	
    	val endTime = System.nanoTime();
    	
    	val elapsedTime = ((endTime-startTime)*1.0)/(1000*1000*1000);
    	logger.info(String.format("training phase is finished. elapsed time = %1f (sec)", [elapsedTime as Any]));
    }
}
