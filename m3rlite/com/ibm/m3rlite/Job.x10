package com.ibm.m3rlite;
import x10.util.Pair;
import x10.util.ArrayList;

/**
 * A Job provides all the user-supplied code needed by the engine to execute
 * a map shuffle reduce job. 
 * 
 * A Job is executed in all places. 
 * The Job object will be serialized across all places and used in each place.
 * If it needs to access distributed data-structures it must use PlaceLocalHandle
 * or GlobalRef appropriately to ensure that these data-structures can be accessed
 * from any place.
 * 
 * @author vj
 * 
 */
public interface Job[K1,V1,K2,V2,K3,V3] {
	/**
	 * Return the partition to which the key belongs. 
	 */
	def partition(k:K2):Long;
	
	/**
	 * Return true if the job should terminate. Called after all engines at 
	 * all places have finished the reduce cycle. 
	 */
	def stop():Boolean;
	
	/**
	 * Each Job supplies a (distributed) data source for use by the MRLite engine.
	 * The engine will invoke the source() method in each place to obtain the data
	 * at that place. 
	 * The returned value may be null.
	 */
	def source():Iterable[Pair[K1,V1]];
	
	/**
	 * Each Job supplies a data sink. This consumes the (K3, V3) pairs supplied
	 * by the reduce at each place. 
	 * 
	 * Call may be made with null input -- indicates that the map reduce phase
	 * is locally over.
	 * 
	 */
	def sink(Iterable[Pair[K3,V3]]):void;
	
	/**
	 * Each Job supplies a mapper. A mapper translates a (K1, V1) pair into
	 * zero or more (K2, V2) pairs which are fed to a MapperSink.
	 * 
	 * <p>The user supplied code for mapper can assume that multiple invocations 
	 * (in a given place) are made by the same X10 worker,
	 * and only one worker will invoke the mapper method per place. (That is,
	 * MRLite implements single-threaded mappers/reducers per place.) Hence the 
	 * body of the mapper method does not need to be thread-safe. 
	 * 
	 * <p>Further, the mapper code may assume that it is being invoked in all places 
	 * by activities registered on a common clock. Hence the code can use
	 * Clock.advanceAll() to coordinate with all other mappers. It is the user's
	 * responsibility to ensure that mappers execute exactly the same number
	 * of Clock.advanaceAll() at each place.
	 * TODO: remove this restriction.
	 * <p>This is an experimental feature -- an attempt to exploit a global control
	 * construct within mappers.
	 */
	def mapper(K1, V1, (K2,V2)=>void):void;
	
	/**
	 * A reducer takes a K2 key and a sequence of V2 values, and adds resulting
	 * (K3, V3) pairs, if any to the supplied ArrayList.
	 * 
	 * <p>The user supplied code for reducer can assume that multiple invocations 
	 * (in a given place) are made by the same X10 worker,
	 * and only one worker will invoke the reducer method per place. (That is,
	 * MRLite implements single-threaded mappers/reducers per place) Hence the
	 * body of the reducer method does not need to be thread-safe. 
	 * 
	 * <p>Further, the mapper code may assume that it is being invoked in all places 
	 * by activities registered on a common clock. Hence the code can use
	 * Clock.advanceAll() to coordinate with all other mappers. It is the user's
	 * responsibility to ensure that mappers execute exactly the same number
	 * of Clock.advanaceAll() at each place.
	 * TODO: remove this restriction.
	 * 
	 * <p>This is an experimental feature -- an attempt to exploit a global control
	 * construct within reducers.
	 */
	def reducer(K2,Iterable[V2], ArrayList[Pair[K3,V3]]):void;
}