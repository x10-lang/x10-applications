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

/**
 * Manage ghost data exchange across Boundaries of all 
 * different types (planar, edge, corner).
 */
public final class BoundaryGhostManager extends GhostManager {

    static final class BoundaryLocalState extends LocalState {
        /**
         * Boundary data received from other places, held for later combination
         * with boundary data computed locally.
         * TODO: Eventually this should be done directly from the recvBuffers.
         */
        val boundaryData:Rail[Rail[Double]];

        protected def this(domainPlh:PlaceLocalHandle[Domain],
                           neighborListSend:Rail[Long], 
                           neighborListRecv:Rail[Long],
                           sideLength:Long,
                           accessFields:(Domain) => Rail[Rail[Double]],
                           recvBufferSize:(Long)=>Long) {
            super(domainPlh, neighborListSend, neighborListRecv, sideLength, accessFields, recvBufferSize);
            this.boundaryData = new Rail[Rail[Double]](neighborListRecv.size);
        }
    }

    protected def this(domainPlh:PlaceLocalHandle[Domain], 
                       initNeighborsSend:() => Rail[Long], 
                       initNeighborsRecv:() => Rail[Long],
                       sideLength:Long,
                       accessFields:(Domain) => Rail[Rail[Double]],
                       recvBufferSize:(Long)=>Long) {
        super(PlaceLocalHandle.make[LocalState](Place.places(), 
                                               () => new BoundaryLocalState(domainPlh, 
                                                                            initNeighborsSend(), 
                                                                            initNeighborsRecv(),
                                                                            sideLength,
                                                                            accessFields,
                                                                            recvBufferSize)));
    }

    public static def make(domainPlh:PlaceLocalHandle[Domain],
                           initNeighborsSend:() => Rail[Long], 
                           initNeighborsRecv:() => Rail[Long],
                           sideLength:Long,
                           accessFields:(Domain) => Rail[Rail[Double]],
                           recvBufferSize:(Long)=>Long) {
        return new BoundaryGhostManager(domainPlh, initNeighborsSend, initNeighborsRecv, sideLength, 
                                        accessFields, recvBufferSize);
    }


    private def getNeighborNumber(neighborId:Long) = localState().getNeighborNumber(neighborId);

    /** 
     * Wait for all boundary data to be received from neighboring places,
     * and then combine it with boundary data computed at this place.
     * Switch ghost manager phase from sending to using ghost data.
     */
    public final def waitAndCombineBoundaries() {
        val t1 = Timer.milliTime();
        val ls:BoundaryLocalState = localState() as BoundaryLocalState;
        processUpdateFunctions();
        val t2 = Timer.milliTime();
        ls.processTime += (t2 - t1);
        when (allNeighborsReceived()) {
            val t3 = Timer.milliTime();
            ls.waitTime += (t3 - t2);
            processUpdateFunctions();
            val boundaryData = ls.boundaryData;
            for (i in 0..(boundaryData.size-1)) {
                if (boundaryData(i) != null) {
                    ls.domainPlh().accumulateBoundaryData(ls.neighborListRecv(i), boundaryData(i), 
                                                          ls.accessFields, ls.sideLength);
                    boundaryData(i) = null;
                }
            }
            ls.currentPhase++;
            ls.neighborsReceivedCount = 0;
            val t4 = Timer.milliTime();
            ls.processTime += (t4 - t3);
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
            val boundaryData = sourceDom.gatherBoundaryData(neighbors(i), src_ls.accessFields, 
                                                            src_ls.sideLength);
            at(Place(neighbors(i))) @Uncounted async {
                postUpdateFunction(phase, ()=>{
                    val dst_ls = localState();
                    dst_ls.domainPlh().updateBoundaryData(sourceId, boundaryData, dst_ls.accessFields, 
                                                          dst_ls.sideLength);
                });
            }
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
        val phase = src_ls.currentPhase;
        val neighbors = src_ls.neighborListSend;
        for (i in 0..(neighbors.size-1)) {
            val boundaryData = sourceDom.gatherBoundaryData(neighbors(i), src_ls.accessFields, src_ls.sideLength);
            at(Place(neighbors(i))) @Uncounted async {
                postUpdateFunction(phase, ()=>{
                    val bd = (localState() as BoundaryLocalState).boundaryData;
                    bd(getNeighborNumber(sourceId)) = boundaryData;
                });
            }
        }
        src_ls.sendTime += Timer.milliTime() - start;
    }
}
