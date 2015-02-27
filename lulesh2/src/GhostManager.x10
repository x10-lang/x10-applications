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

/** Manages updates of ghost data for LULESH. */
public class GhostManager {
    static class LocalState {
        /** List of neighbors to which data must be sent. */
        public val neighborListSend:Rail[Long];
        /** List of neighbors from which data must be received. */
        public val neighborListRecv:Rail[Long];
        /** 
         * Count of neighbors which have given us update functions this cycle.
         */
        public var neighborsReceivedCount:Long;
        /**
         * The update function recevied from each neighbor for the current cycle
         */
        public val updateFunctions:Rail[()=>void];
        /**
         * The current phase of the computation with regard to ghost cell updates.
         * Places are assumed to progress together; in even phases, ghost cells are
         * used; in odd phases, ghost cells are updated.  No place may start phase 
         * P+2 before neighboring places have completed phase P.
         */
        public var currentPhase:Long;

        /**
         * Boundary data received from other places, held for later combination
         * with boundary data computed locally.
         */
        var boundaryData:Rail[Rail[Double]];

        public var sendTime:Long = 0;
        public var waitTime:Long = 0;

        public def this(neighborListSend:Rail[Long], neighborListRecv:Rail[Long]) {
            this.neighborListSend = neighborListSend;
            this.neighborListRecv = neighborListRecv;
            this.neighborsReceivedCount = 0;
            this.updateFunctions = new Rail[()=>void](neighborListRecv.size);
            this.currentPhase = 0;
            this.boundaryData = new Rail[Rail[Double]](neighborListRecv.size);
        }
    }

    public val localState:PlaceLocalHandle[LocalState];

    /**
     * Create a new GhostManager for ghost updates between all places.
     * @param initNeighborsSend a closure that, when executed at a given place,
     *     returns a list of the neighboring places to which to send
     * @param initNeighborsRecv a closure that, when executed at a given place,
     *     returns a list of the neighboring places from which to receive
     */
    public def this(initNeighborsSend:() => Rail[Long], initNeighborsRecv:() => Rail[Long]) {
        this.localState = PlaceLocalHandle.make[LocalState](Place.places(), () => new LocalState(initNeighborsSend(), initNeighborsRecv()));
    }

    /** 
     * Wait for all ghosts to be received and then return.
     * Used to switch ghost manager phase from sending to using ghost data.
     */
    public final def waitForGhosts() {
        val start = Timer.milliTime();
        when (allNeighborsReceived()) {
            processUpdateFunctions();
            localState().currentPhase++;
            resetNeighborsReceived();
        }
        localState().waitTime += Timer.milliTime() - start;
    }

    /** 
     * Wait for all boundary data to be received from neighboring places,
     * and then combine it with boundary data computed at this place.
     * Switch ghost manager phase from sending to using ghost data.
     */
    public final def waitAndCombineBoundaries(domainPlh:PlaceLocalHandle[Domain],
            accessFields:(dom:Domain) => Rail[Rail[Double]],
            sideLength:Long) {
        val start = Timer.milliTime();
        when (allNeighborsReceived()) {
            processUpdateFunctions();
            val boundaryData = localState().boundaryData;
            for (i in 0..(boundaryData.size-1)) {
                if (boundaryData(i) != null) {
                    domainPlh().accumulateBoundaryData(localState().neighborListRecv(i), boundaryData(i), accessFields, sideLength);
                    boundaryData(i) = null;
                }
            }
            localState().currentPhase++;
            resetNeighborsReceived();
        }
        localState().waitTime += Timer.milliTime() - start;
    }

    private def allNeighborsReceived():Boolean {
        val received = localState().neighborsReceivedCount;
        val expected = localState().updateFunctions.size;
        return received == expected;
    }

    private def setNeighborReceived(neighborId:Long, updateFunction:()=>void) {
        val neighbors = localState().neighborListRecv;
        val functions = localState().updateFunctions;
        for (i in 0..(neighbors.size-1)) {
            if (neighborId == neighbors(i)) {
                atomic {
                    functions(i) = updateFunction;
                    localState().neighborsReceivedCount++;
                }
                break;
            }
        }
    }

    private def resetNeighborsReceived() {
        val functions = localState().updateFunctions;
        atomic {
            localState().neighborsReceivedCount = 0;
            functions.clear();
        }
    }

    private def processUpdateFunctions() {
        val functions = localState().updateFunctions;
        for (f in functions) {
            f();
        }
    }

    private def getNeighborNumber(neighborId:Long) {
        val neighbors = localState().neighborListRecv;
        for (i in 0..(neighbors.size-1)) {
            if (neighborId == neighbors(i)) {
                return i;
            }
        }
        throw new IllegalArgumentException(here + " getNeighborNumber for " + neighborId);
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
            @Uncounted at(Place(neighbors(i))) async {
                setNeighborReceived(sourceId, ()=>{
                    domainPlh().updateBoundaryData(sourceId, boundaryData, accessFields, sideLength);
                });
            }

        }
        localState().sendTime += Timer.milliTime() - start;
    }

    /**
     * Update ghost data for plane boundaries at neighboring places with plane
     * boundary data from this place.  Plane ghost data are stored contiguously
     * for each plane *after* all locally-managed data at each place. 
     */
    public def updatePlaneGhosts(domainPlh:PlaceLocalHandle[Domain], 
                        accessFields:(dom:Domain) => Rail[Rail[Double]],
                        sideLength:Long) {
        val start = Timer.milliTime();
        atomic localState().currentPhase++;
        val sourceId = here.id;
        val sourceDom = domainPlh();
        val phase = localState().currentPhase;
        val neighbors = localState().neighborListSend;
        for (i in 0..(neighbors.size-1)) {
            val ghosts = sourceDom.gatherGhosts(neighbors(i), accessFields, sideLength);
            @Uncounted at(Place(neighbors(i))) async {
                setNeighborReceived(sourceId, ()=>{
                    var ghostOffset:Long = sideLength*sideLength*sideLength;
                    val ghostRegionSize = (sideLength)*(sideLength);
                    ghostOffset += getNeighborNumber(sourceId) * ghostRegionSize;
                    domainPlh().updateGhosts(ghosts, accessFields, ghostRegionSize, ghostOffset);
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
            @Uncounted at(Place(neighbors(i))) async {
                setNeighborReceived(sourceId, ()=>{
                    // hold boundary data for later accumulation
                    localState().boundaryData(getNeighborNumber(sourceId)) = boundaryData;
                });
            }
        }
        localState().sendTime += Timer.milliTime() - start;
    }
}
