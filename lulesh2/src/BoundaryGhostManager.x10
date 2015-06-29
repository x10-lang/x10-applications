/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2014.
 */

import x10.compiler.Uncounted;
import x10.util.Timer;
import x10.util.Stack;
import x10.compiler.Inline;
import x10.regionarray.Region;

/**
 * Manage ghost data exchange across Boundaries of all 
 * different types (planar, edge, corner).
 */
public final class BoundaryGhostManager extends GhostManager {

    protected def this(domainPlh:PlaceLocalHandle[Domain], 
                       initNeighborsSend:() => Rail[Long], 
                       initNeighborsRecv:() => Rail[Long],
                       sideLength:Long,
                       accessFields:(Domain) => Rail[Rail[Double]]) {
        super(PlaceLocalHandle.make[LocalState](Place.places(), 
                                               () => new LocalState(domainPlh, 
                                                                    initNeighborsSend(), 
                                                                    initNeighborsRecv(),
                                                                    sideLength,
                                                                    accessFields)));
    }

    public static def make(domainPlh:PlaceLocalHandle[Domain],
                           initNeighborsSend:() => Rail[Long], 
                           initNeighborsRecv:() => Rail[Long],
                           sideLength:Long,
                           accessFields:(Domain) => Rail[Rail[Double]]) {
        return new BoundaryGhostManager(domainPlh, initNeighborsSend, initNeighborsRecv, 
                                        sideLength, accessFields);
    }


    /** 
     * Wait for all boundary data to be received from neighboring places,
     * and then combine it with boundary data computed at this place.
     * Switch ghost manager phase from sending to using ghost data.
     *
     * Since gatherBoundariesToCombine does not need to push an update function
     * we can skip calling processUpdateFunctions here (stack will always be empty).
     */
    public final def waitAndCombineBoundaries() {
        val t1 = Timer.milliTime();
        val ls = localState();
        when (allNeighborsReceived()) {
            val t2 = Timer.milliTime();
            ls.waitTime += (t2 - t1);
            val dom = ls.domainPlh();
            for (i in 0..(ls.recvBuffers.size-1)) {
                dom.accumulateBoundaryData(ls.neighborListRecv(i), ls.recvRegions(i), 
                                           ls.recvBuffers(i), ls.accessFields, ls.sideLength);
            }
            ls.currentPhase++;
            ls.neighborsReceivedCount = 0;
            val t3 = Timer.milliTime();
            ls.processTime += (t3 - t2);
        }
    }

    /**
     * Update boundary data at all neighboring places, overwriting with data
     * from this place's boundary region.
     */
    public def updateBoundaryData() {
        val start = Timer.milliTime();
        val src_ls = localState();
        atomic src_ls.currentPhase++;
        val sourceId = here.id;
        val sourceDom = src_ls.domainPlh();
        val phase = src_ls.currentPhase;
        val neighbors = src_ls.neighborListSend;
        for (i in 0..(neighbors.size-1)) {
            val data = src_ls.sendBuffers(i);
            sourceDom.gatherBoundaryData(neighbors(i), src_ls.sendRegions(i), data, 
                                         src_ls.accessFields, src_ls.sideLength);
            Rail.uncountedCopy(data, 0, src_ls.remoteRecvBuffers(i), 0, data.size, ()=> {
                postUpdateFunction(phase, ()=>{
                    val dst_ls = localState();
                    val sendNum = dst_ls.getNeighborNumber(sourceId);
                    dst_ls.domainPlh().updateBoundaryData(sourceId, dst_ls.recvRegions(sendNum), 
                                                          dst_ls.recvBuffers(sendNum), 
                                                          dst_ls.accessFields, dst_ls.sideLength);
                });
           });
        }
        localState().sendTime += Timer.milliTime() - start;
    }

    /**
     * Send boundary data from this place to neighboring places to be combined
     * later by waitAndCombineBoundaries.
     * @see waitAndCombineBoundaries
     */
    public def gatherBoundariesToCombine() {
        val start = Timer.milliTime();
        val src_ls = localState();
        atomic src_ls.currentPhase++;
        val sourceId = here.id;
        val sourceDom = src_ls.domainPlh();
        val neighbors = src_ls.neighborListSend;
        for (i in 0..(neighbors.size-1)) {
            val data = src_ls.sendBuffers(i);
            sourceDom.gatherBoundaryData(neighbors(i), src_ls.sendRegions(i), data,
                                         src_ls.accessFields, src_ls.sideLength);
            Rail.uncountedCopy(data, 0, src_ls.remoteRecvBuffers(i), 0, data.size, ()=> {
                val dst_ls = localState();
                atomic dst_ls.neighborsReceivedCount++;
            });
        }
        src_ls.sendTime += Timer.milliTime() - start;
    }
}
