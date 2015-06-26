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
 * Manage ghost data exchange across Boundaries
 */
public final class BoundaryGhostManager extends GhostManager {

    static final class BoundaryLocalState extends LocalState {
        /**
         * Boundary data received from other places, held for later combination
         * with boundary data computed locally.
         * TODO: Eventually this should be done directly from the recvBuffers.
         */
        val boundaryData:Rail[Rail[Double]];

        protected def this(neighborListSend:Rail[Long], 
                           neighborListRecv:Rail[Long],
                           recvBufferSize:(Long)=>Long) {
            super(neighborListSend, neighborListRecv, recvBufferSize);
            this.boundaryData = new Rail[Rail[Double]](neighborListRecv.size);
        }
    }

    protected def this(initNeighborsSend:() => Rail[Long], 
                    initNeighborsRecv:() => Rail[Long],
                    recvBufferSize:(Long)=>Long) {
        super(PlaceLocalHandle.make[LocalState](Place.places(), 
                                               () => new BoundaryLocalState(initNeighborsSend(), 
                                                                            initNeighborsRecv(),
                                                                            recvBufferSize)));
    }

    public static def make(initNeighborsSend:() => Rail[Long], 
                           initNeighborsRecv:() => Rail[Long],
                           recvBufferSize:(Long)=>Long) {
        return new BoundaryGhostManager(initNeighborsSend, initNeighborsRecv, recvBufferSize);
    }



    private def getNeighborNumber(neighborId:Long) = localState().getNeighborNumber(neighborId);

    /** 
     * Wait for all boundary data to be received from neighboring places,
     * and then combine it with boundary data computed at this place.
     * Switch ghost manager phase from sending to using ghost data.
     */
    public final def waitAndCombineBoundaries(domainPlh:PlaceLocalHandle[Domain],
            accessFields:(dom:Domain) => Rail[Rail[Double]],
            sideLength:Long) {
        val t1 = Timer.milliTime();
        processUpdateFunctions();
        val t2 = Timer.milliTime();
        localState().processTime += (t2 - t1);
        when (allNeighborsReceived()) {
            val t3 = Timer.milliTime();
            localState().waitTime += (t3 - t2);
            processUpdateFunctions();
            val boundaryData = (localState() as BoundaryLocalState).boundaryData;
            for (i in 0..(boundaryData.size-1)) {
                if (boundaryData(i) != null) {
                    domainPlh().accumulateBoundaryData(localState().neighborListRecv(i), boundaryData(i), accessFields, sideLength);
                    boundaryData(i) = null;
                }
            }
            localState().currentPhase++;
            localState().neighborsReceivedCount = 0;
            val t4 = Timer.milliTime();
            localState().processTime += (t4 - t3);
        }
    }

    /**
     * Update boundary data at all neighboring places, overwriting with data
     * from this place's boundary region.
     * @param domainPlh domain data at each place
     * @param accessFields a closure which returns an array of the fields to be
     *   updated as Rail[Rail[Double]]
     * @param sideLength the length of each side of the boundary region
     */
    public def updateBoundaryData(domainPlh:PlaceLocalHandle[Domain], 
                        accessFields:(dom:Domain) => Rail[Rail[Double]],
                        sideLength:Long) {
        val start = Timer.milliTime();
        atomic localState().currentPhase++;
        val sourceId = here.id;
        val sourceDom = domainPlh();
        val phase = localState().currentPhase;
        val neighbors = localState().neighborListSend;
        for (i in 0..(neighbors.size-1)) {
            val boundaryData = sourceDom.gatherBoundaryData(neighbors(i), accessFields, sideLength);
            at(Place(neighbors(i))) @Uncounted async {
                postUpdateFunction(phase, ()=>{ 
                    domainPlh().updateBoundaryData(sourceId, boundaryData, accessFields, sideLength); 
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
    public def gatherBoundariesToCombine(domainPlh:PlaceLocalHandle[Domain], 
                        accessFields:(dom:Domain) => Rail[Rail[Double]],
                        sideLength:Long) {
        val start = Timer.milliTime();
        atomic localState().currentPhase++;
        val sourceId = here.id;
        val sourceDom = domainPlh();
        val phase = localState().currentPhase;
        val neighbors = localState().neighborListSend;
        for (i in 0..(neighbors.size-1)) {
            val boundaryData = sourceDom.gatherBoundaryData(neighbors(i), accessFields, sideLength);
            at(Place(neighbors(i))) @Uncounted async {
                postUpdateFunction(phase, ()=>{
                    val bd = (localState() as BoundaryLocalState).boundaryData;
                    bd(getNeighborNumber(sourceId)) = boundaryData;
                });
            }
        }
        localState().sendTime += Timer.milliTime() - start;
    }
}
