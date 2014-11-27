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
	@x10.compiler.NonEscaping
	private val master = GlobalRef(this); // master instance
	private var engine:ResilientEngine[Long,Obs,Long,HMMModel,Long,HMMModel];
	
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
	
	// for checking elapsed time 
	private var sTime:Double = 0D;    // updates at src() phase everytime
	private var lap_time:Double = 0D; // updates at each phase
	private var src_time:Double = 0D;
	private var map_time:Double = 0D;
	private var red_time:Double = 0D;
	private var snk_time:Double = 0D;
	
	
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
				logger.info(String.format("place(%d) is now killed at %s phase", [here.id as Any, check]));
				System.killHere();
				//throw new DeadPlaceException();
			}
		}
	}
	
	/**
	 * initialization, which is called only once in a job. 
	 * 1. setup master data of learning data
	 * 2. setup rule 
	 * 
	 * Constructor can be useful to setup, but if using spare place, 
	 * a new place is needed to load own rule with the new virtual place id. 
	 */
	private def initalize():void {
		//initalize rule
		val h = here;
		val myid = engine.placeIndex(h);
		this.myRule = at (master) {
			if (master().rule == null) return null;
			//else return master().rule(h.id); //copy from master
			else return master().rule(myid); //copy from master
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
		sTime = System.nanoTime(); //base time 
		val h = here;

		// at first, decide my assignment. 
		val myplaceid = engine.placeIndex(h);
		val liveplaces = engine.numLivePlaces();
		
		val current = myplaceid == 0 ? at(master){return master().currentIter;}:-1;
		/*
		if (myplaceid == 0){
			val current = at (master) { 
				val m = master.getLocalOrCopy();
				return m.currentIter;
			};
			logger.warn(String.format("%d,%f", [current as Any, wrapTime]));
			logger.info(String.format("source(): iteration=%d, livePlaces=%d, comptime=%f (s)", [current as Any, liveplaces, wrapTime]));
		}
		*/
		// initialize time variables
		if (myplaceid == 0) {
			logger.warn(String.format("ite=%d,src=%.3f,map=%.3f,red=%.3f,snk=%.3f,total=%.3f", 
				[current as Any,src_time,map_time,red_time,snk_time,lap_time]));
			src_time = 0D; map_time = 0D; red_time = 0D; snk_time = 0D;
			lap_time = 0D;
		}
		
		// check once in job duration
		if (!isCheckedRule) {
			logger.info("source(): initialize");
			initalize();
		}
		// here is stop check in source phase
		// check whether this place should be killed or not
		checkHere("source");
			
		val start = (N/liveplaces) * myplaceid;
		val end = myplaceid+1==liveplaces ? start + N/liveplaces + N%liveplaces : start + N/liveplaces;
		
		assignedLines = end-start; // re-assign data range in each iteration. 
		
		logger.info(String.format("source(%d):range:(start=%d,end=%d),livePlaces=%d",
				[myplaceid as Any, start, end, liveplaces]));
		
		// initialize(copy) local hmm parameter from master
		red.setToZero();
		val masterBlack = at (master) {
			return master().black;
		};
		copy.setTo(masterBlack);

		src_time = (System.nanoTime() - sTime)/(1000*1000*1000);
		lap_time += src_time;
		logger.info(String.format("source(%d): fin. src_time=%.3f,elapsed=%.3f(s)", 
				[myplaceid as Any, src_time,lap_time]));
		return new Iterable[Pair[Long, Obs]]() {
			public def iterator() = new Iterator[Pair[Long,Obs]]() {
				var cnt:Long = 0;
				public def hasNext() = cnt < (end - start);
				public def next() {
					val pos = start + cnt;
					val current_cnt = cnt;
					cnt++;
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
		val s = System.nanoTime();
		val e = (s - sTime)/(1000D*1000D*1000D);
		logger.trace(String.format("map() (%d/%d): elapsed=%.3f(s)", 
				[k as Any, assignedLines, e]));
		black.update(v,red);
		
		checkHere("map");
		
		if (assignedLines-1 == k) {
			val numLivePlaces = engine.numLivePlaces();
			val t = engine.placeIndex(here);
			for (dest in 0..(numLivePlaces-1)) {
				logger.debug(String.format("map(): emit local hmm (%d->%d)", [t as Any, dest]));
				msink(dest, red);
			}
			//map_time = (System.nanoTime() - s)/(1000D*1000D*1000D);
			lap_time = (System.nanoTime() - sTime)/(1000D*1000D*1000D);
			map_time = lap_time - src_time;
			logger.info(String.format("map(): fin. map_time=%.3f,elapsed=%.3f(s)", 
					[map_time as Any, lap_time]));
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
		val s1 = System.nanoTime();
		for (v in v2) {
			logger.debug(String.format("reducer(): process received hmm (k2=%d)", [k2 as Any]));
			black.setToSum(black, v);
		}
		checkHere("reduce");
		output.add(Pair(k2 as Long, black));
		//red_time = (System.nanoTime() - s1)/(1000D*1000D*1000D);
		lap_time = (System.nanoTime() - sTime)/(1000D*1000D*1000D);
		red_time = lap_time - map_time - src_time;
		logger.info(String.format("reduce(): fin. red_time=%.3f,elapsed=%.3f(s)", 
				[red_time as Any, lap_time]));
	}
	
	/**
	 * sink() finalizes All-Gathered HMM
	 *   - normalization
	 *   - check delta
	 *   - write the result HMM to master 
	 */
	public def sink(s:Iterable[Pair[Long, HMMModel]]) {
		val s1 = System.nanoTime();
		if (s == null) return;
		black.normalize();
		delta = copy.distance(black);
		checkHere("sink");
		// write results to master
		val h = here;
		val t = engine.placeIndex(h);
		// all reducer has same result, so it is enough to write this result
		// by only one place. place(0) is elected. 
		if (t == 0) at (master) {
			val m = master.getLocalOrCopy();
			logger.debug(String.format("sink():  new delta value = %.5f", [delta as Any]));
			m.delta = delta;
			m.currentIter++;
			m.black.setTo(black);
		}
		snk_time  = (System.nanoTime() - s1)/(1000D*1000D*1000D);
		lap_time = (System.nanoTime() - sTime)/(1000D*1000D*1000D);
		logger.info(String.format("sink(): fin. snk_time=%.3f, elapsed=%.3f(s)", 
				[snk_time as Any, lap_time]));
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
		val iterativeMode = opts("-i", false);
		val iterativeModeBool = iterativeMode == true ? "True":"False";
		
		logger.info(String.format("job parameter: S=%d,O=%d,N=%d,maxIter=%d,eps=%.5f,fileName=%s,iterativeMode=%s",
				[S as Any,O,N,maxIter,eps,fileName,iterativeModeBool]));
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
			
			Console.OUT.println("place("+dest+") will be killed at iteration="+value+" of "+key+" phase");
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
		if (logger.isInfoEnabled()) {
			val startHMM = job.black;
			logger.debug("initialized start random HMM");
			//startHMM.print(Console.ERR);
		}
		val engine = new ResilientEngine(job);
		job.engine = engine;
		
		val startTime = System.nanoTime();
		engine.run();
		val endTime = System.nanoTime();
		//job.black.print(Console.ERR);
		val elapsedTime = ((endTime-startTime)*1.0)/(1000*1000*1000);
		logger.info(String.format("training phase is finished. elapsed time = %f (sec)", [elapsedTime as Any]));
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
