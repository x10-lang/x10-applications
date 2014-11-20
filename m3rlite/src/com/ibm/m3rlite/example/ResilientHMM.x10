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
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.HashMap;
import x10.util.ArrayList;
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
public class ResilientHMM(S:Int, O:Int, N:Long, maxIter:Long, eps:Double, fileName:String,iterativeMode:Boolean) implements Job[Long,Rail[Int],Long,HMMModel,Long,HMMModel] {
	//val S:Int;			// number of states
	//val O:Int;			// number of observations
	//val N:Long;			// total number of lines
	//val fileName:String;	// input file name
	//val maxIter:Long;		// maximum iterations
	//val eps:Double;		// if delta < eps, break iteration loop
	//val iterativeMode:Boolean
	
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

	public def model() = black;
	
	public var rule:Rail[HashMap[String,ArrayList[Long]]] = null;
	private var myRule:HashMap[String,ArrayList[Long]] = null;
	private var isCheckedRule:Boolean = false;
	
	
	/**
	 * checkHere() is utility method for killing myself. 
	 * It checks loaded scenario. If matched, calls killHere() and then
	 * the place will be killed immediately. 
	 */
	private def checkHere(check:String) {
		if (myRule != null){
			val t = myRule.get(check);
			val current = at(master) { return master().currentIter; };
			if( myRule.get(check).contains(current) ) {
				logger.info(String.format("place(%1$d) is killed at %2$s phase", [here.id as Any, check]));
				System.killHere();
				//throw new DeadPlaceException();
			}
		}
	}
	
	/**
	 * initialization, which is called only once in a job. 
	 * 1. setup master data of learning data
	 * 2. setup rule 
	 */
	private def initalize():void {
		//initalize rule
		val h = here;
		this.myRule = at (master) {
			if (master().rule == null) return null;
			else return master().rule(h.id); //copy from master
		};
		//initalize data source
		data = new Rail[Obs](N);
		val file = new File(fileName);
		var i:Long = 0;
		for (line_ in file.lines()) {
			val line = line_.trim();
			if (line.length() == 0N) continue;
			
			val strs = line.split(" ");
			data(i) = new Obs(strs.size, (j:Long)=>Int.parse(strs(j)));
			i++;
			if (i == N) break;
		}
		isCheckedRule = true;
	}
	
	
	/**
	 * source() is called at first of iteration.
	 * it checks live places and decides assigned range of data if needed. 
	 */
	public def source():Iterable[Pair[Long,Obs]] {
		val h = here;
		// check once in job duration
		if (!isCheckedRule) {
			logger.debug("source(): initialize");
			initalize();
		}
		// here is stop check in source phase
		// check whether this place should be killed or not
		checkHere("source");
		
		val t = at (master) {
			val m = master.getLocalOrCopy();
			if (m.engine.placeIndex(h) == 0){
				logger.info(String.format("source(): iteration=%1$d, livePlaces=%2$d", [m.currentIter as Any, m.engine.numLivePlaces()]));
			}
			return new Pair[Long,Long](m.engine.placeIndex(h), m.engine.numLivePlaces());
		};
		
		// at first, decide my assignment. 
		val myplaceid = t.first;
		val liveplaces = t.second;
			
		val start = (N/liveplaces) * myplaceid;
		val end = myplaceid+1==liveplaces ? start + N/liveplaces + N%liveplaces : start + N/liveplaces;
		
		assignedLines = end-start; // re-assign data in each iteration. 
		
		logger.debug(String.format("source():range of place(%1$d):(start=%2$d,end=%3$d),livePlaces=%4$d",
				[myplaceid as Any, start, end, liveplaces]));
		
		// initialize(copy) local hmm parameter from master
		red.setToZero();
		val masterBlack = at (master) {
			return master().black;
		};
		copy.setTo(masterBlack);
				
		return new Iterable[Pair[Long, Obs]]() {
			public def iterator() = new Iterator[Pair[Long,Obs]]() {
				var idata:Long = start;
				var cnt:Long = 0;
				public def hasNext() = idata < end;
				public def next() {
					val pos = idata;
					val current_cnt = cnt;
					idata++; cnt++;
					return Pair[Long,Obs](current_cnt, data(pos));
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
		logger.trace(String.format("k1=%1$d, v1=%2$s", [k as Any, v]));
		black.update(v,red);
		
		checkHere("map");
		
		if (assignedLines-1 == k) {
			logger.debug(String.format("mapper(): complete to read training data (%1$d lines)", [(k+1) as Any]));
			val numLivePlaces = at (master) {
				val m = master.getLocalOrCopy();
				return m.engine.numLivePlaces();
			};
			for (dest in 0..(numLivePlaces-1)) {
				val t = here.id;
				logger.debug(String.format("mapper(): emit local hmm (%1$d -> %2$d)", [t as Any, dest]));
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
			logger.debug(String.format("reducer(): process received hmm (k2=%1$d)", [k2 as Any]));
			black.setToSum(black, v);
		}
		checkHere("reduce");
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
		val h = here;
		val t = at (master) {
			val m = master.getLocalOrCopy();
			return m.engine.placeIndex(h);
		};
		// all reducer has same result, so it is enough to write this result
		// by only one place. place(0) is elected. 
		if (t == 0) at (master) {
			logger.debug(String.format("sink():  new delta value = %1$.5f", [delta as Any]));
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
			logger.debug("stop(): stop iteration(maxIter)");
			return true;
		}
		// if iterativeMode is true, system does not check eps.
		// it means computation will continue till maxIter
		if (!iterativeMode) {
			if (t.second == Double.NaN || t.second <= eps){
				logger.debug("stop(): stop iteration(epsilon)");
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 
	 */
	public static def runTestCase1(args:Rail[String]):HMMModel {
		val job = createJob(args);
		job.master = GlobalRef[ResilientHMM](job);
		if (logger.isInfoEnabled()) {
			val startHMM = job.black;
			logger.debug("initialized start random HMM");
			startHMM.print(Console.ERR);
		}
		val engine = new ResilientEngine(job);
		job.engine = engine;
		engine.run();
		return job.black;
	}
		
	
	public static def getConfig(args:Rail[String]):OptionsParser {
		val opts = new OptionsParser(args,
				[
				 Option("h", "help", "this information"),
				 Option("i", "iterative", "ignore eps, only use iteration count(for resiliency test)")
				 ], 
				 [
				  Option("s", "states", "number of hidden states"),
				  Option("o", "obs", "number of observations"),
				  Option("n", "numline", "total number of learning data lines"),
				  Option("m", "maxIters", "maximum iteration"),
				  Option("e", "epsilon", "convergence criterion"),
				  Option("f", "fileName", "input file name"),
				  Option("t", "testScenario", "scenario for resilient test")
				  ]);
		return opts;
	}
	
	public static def createJob(args:Rail[String]):ResilientHMM {
		val opts = getConfig(args);
		//default value or user-specified value
		val S = opts("-s", 2N);
		val O = opts("-o", 6N);
		val N = opts("-n", 100);
		val maxIter = opts("-m", 10N);
		val eps = opts("-e", 0.01D);
		val fileName = opts("-f", "testdata/sample.dat");
		val iterativeMode = opts("-i");
		
		logger.info(String.format("job parameter: S=%1$d,O=%2$d,N=%3$d,maxIter=%4$d,eps=%5$.5f,fileName=%6$s,iterativeMode=%7$s",
				[S as Any,O,N,maxIter,eps,fileName,iterativeMode]));
		val job = new ResilientHMM(S,O,N,maxIter,eps,fileName,iterativeMode);
		return job;
	}
	
	private static def testWithScenario(confFile:String, args:Rail[String]) {
		// check active places and prepare rules 
		val places = Place.places().numPlaces();
		val rules = new Rail[HashMap[String,ArrayList[Long]]](places);
		for (i in 0..(places-1)) {
			val t = new HashMap[String,ArrayList[Long]]();
			t.put("source",new ArrayList[Long](0));
			t.put("map",new ArrayList[Long](0));
			t.put("reduce",new ArrayList[Long](0));
			t.put("sink",new ArrayList[Long](0));
			rules(i) = t;	
		}
		// initialize rules
		val f = new File(confFile);
		for (line in f.lines()) {
			val strs = line.split(","); // e.g. 1,map,10 or 0,reduce,2
			val dest = Long.parse(strs(0));
			val key = strs(1);
			val value = Long.parse(strs(2));
			
			Console.OUT.println("dest="+dest+", key="+key+", value="+value);
			if (dest >= places) throw new Exception("Error in parsing scenario file");
			val myhashmap = rules(dest);
			val mylist = myhashmap.remove(key);
			mylist.add(value);
			myhashmap.put(key, mylist);
			
			rules(dest) = myhashmap;
		}
		finish async { doTest(rules, args); };
	}

	public static def doTest(rules:Rail[HashMap[String,ArrayList[Long]]], args:Rail[String]):void {
		val job = createJob(args);
		job.rule = rules;
		job.master = GlobalRef[ResilientHMM](job);
		if (logger.isInfoEnabled()) {
			val startHMM = job.black;
			logger.debug("initialized start random HMM");
			startHMM.print(Console.ERR);
		}
		val engine = new ResilientEngine(job);
		job.engine = engine;
		
		val startTime = System.nanoTime();
		engine.run();
		val endTime = System.nanoTime();
		job.black.print(Console.ERR);
		val elapsedTime = ((endTime-startTime)*1.0)/(1000*1000*1000);
		logger.info(String.format("training phase is finished. elapsed time = %1f (sec)", [elapsedTime as Any]));
	}
	
	public static def main(args:Rail[String]) {
		val conf = getConfig(args);
		if (conf("-h")) {
			Console.OUT.println(conf.usage(""));
			return;
		}
		val scenario = conf("-t", "./test.scenario");
		testWithScenario(scenario, args);
	}
}
