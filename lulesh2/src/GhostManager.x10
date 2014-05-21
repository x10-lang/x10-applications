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

/** Manages ghost cell updates of cell data for LULESH. */
public class GhostManager {
    static class LocalState {
        public val neighborList:Rail[Long];
        public val neighborsReceived:Rail[Boolean];
        /**
         * The current phase of the computation with regard to ghost cell updates.
         * Places are assumed to progress together; in even phases, ghost cells are
         * used; in odd phases, ghost cells are updated.  No place may start phase 
         * P+2 before neighboring places have completed phase P.
         */
        public var currentPhase:Long;
        public def this(neighbors:Rail[Long]) {
            this.neighborList = neighbors;
            this.neighborsReceived = new Rail[Boolean](neighbors.size);
            this.currentPhase = 0;
        }
    }

    private val localState:PlaceLocalHandle[LocalState];

    /**
     * Create a new GhostManager for ghost updates between all places.
     * @param initNeighbors a closure that, when executed on a given place,
     *     returns a list of the neighboring places
     */
    public def this(initNeighbors:() => Rail[Long]) {
        this.localState = PlaceLocalHandle.make[LocalState](PlaceGroup.WORLD, () => new LocalState(initNeighbors()));
    }

    /** 
     * Wait for all ghosts to be received and then return.
     * Used to switch ghost manager phase from sending to using ghost data.
     */
    public final def waitForGhosts() {
        when (allNeighborsReceived()) {
            localState().currentPhase++;
            resetNeighborsReceived();
        }
    }

    private def allNeighborsReceived():Boolean {
        val received = localState().neighborsReceived;
        for (i in 0..(received.size-1)) {
            if (! received(i)) return false;
        }
        return true;
    }

    private def setNeighborReceived(neighborId:Long) {
        val neighbors = localState().neighborList;
        val received = localState().neighborsReceived;
        for (i in 0..(neighbors.size-1)) {

            if (neighborId == neighbors(i)) {
                atomic received(i) = true;
                break;
            }
        }
    }

    private def resetNeighborsReceived() {
        val received = localState().neighborsReceived;
        atomic {
            for (i in 0..(received.size-1)) {
                received(i) = false;
            }
        }
    }

    private def getNeighborNumber(neighborId:Long) {
        val neighbors = localState().neighborList;
        for (i in 0..(neighbors.size-1)) {
            if (neighborId == neighbors(i)) {
                return i;
            }
        }
        throw new IllegalArgumentException(here + " getNeighborNumber for " + neighborId);
    }

    public def updateBoundaryData(domainPlh:PlaceLocalHandle[Domain], 
                        accessFields:(dom:Domain) => Rail[Rail[Double]],
                        perEdge:Long) {
        atomic localState().currentPhase++;
        val sourceId = here.id;
        val sourceDom = domainPlh();
        val phase = localState().currentPhase;
        val neighbors = localState().neighborList;
        for (i in 0..(neighbors.size-1)) {
            val boundaryData = sourceDom.gatherBoundaryData(neighbors(i), accessFields, perEdge);
            at(Place(neighbors(i))) async {
                when (localState().currentPhase == phase);
                domainPlh().updateBoundaryData(sourceId, boundaryData, accessFields, perEdge);
                setNeighborReceived(sourceId);
            }

        }
    }

    public def updatePlaneGhosts(domainPlh:PlaceLocalHandle[Domain], 
                        accessFields:(dom:Domain) => Rail[Rail[Double]],
                        perEdge:Long) {
        atomic localState().currentPhase++;
        val sourceId = here.id;
        val sourceDom = domainPlh();
        val phase = localState().currentPhase;
        val neighbors = localState().neighborList;
        for (i in 0..(neighbors.size-1)) {
            val ghosts = sourceDom.gatherGhosts(neighbors(i), accessFields, perEdge);
            at(Place(neighbors(i))) async {
                when (localState().currentPhase == phase);
                var ghostOffset:Long = perEdge*perEdge*perEdge;
                val ghostRegionSize = (perEdge-2)*(perEdge-2);
                ghostOffset += getNeighborNumber(sourceId) * ghostRegionSize;
                domainPlh().updateGhosts(ghosts, accessFields, ghostRegionSize, ghostOffset);
                setNeighborReceived(sourceId);
            }
        }
    }

    public def combineBoundaries(domainPlh:PlaceLocalHandle[Domain], 
                        accessFields:(dom:Domain) => Rail[Rail[Double]],
                        perEdge:Long) {
        atomic localState().currentPhase++;
        val sourceId = here.id;
        val sourceDom = domainPlh();
        val phase = localState().currentPhase;
        val neighbors = localState().neighborList;
        for (i in 0..(neighbors.size-1)) {
            val boundaryData = sourceDom.gatherBoundaryData(neighbors(i), accessFields, perEdge);
            at(Place(neighbors(i))) async {
                when (localState().currentPhase == phase);
                domainPlh().accumulateBoundaryData(sourceId, boundaryData, accessFields, perEdge);
                setNeighborReceived(sourceId);
            }

        }
    }
}
