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

import x10.compiler.Inline;
import x10.compiler.Uncounted;
import x10.regionarray.Region;
import x10.util.Stack;
import x10.util.Team;
import x10.util.Timer;

/** Manages updates of ghost data for LULESH. */
public final class GhostManager {
    // LocalState is Unserializable to catch programming errors;
    // instances of this class should never be sent across Places.
    static class LocalState implements x10.io.Unserializable {
        /** PlaceLocalHandle to the Domain */
        public val domainPlh:PlaceLocalHandle[Domain];

        /**
         * Function to extract the data fields being managed from the domain
         */
        public val accessFields:(Domain) => Rail[Rail[Double]];

        /**
         * The number of elements along a 'side'
         */
        public val sideLength:Long;

        /** List of neighbors to which data must be sent. */
        public val neighborListSend:Rail[Long];

        /** List of neighbors from which data must be received. */
        public val neighborListRecv:Rail[Long];

        /** 
         * Count of neighbors which have send their updates to us this cycle.
         */
        public var neighborsReceivedCount:Long;

        /**
         * Precomputed Regions for packing data being sent to neighbors
         */
        val sendRegions:Rail[Region(3){rect}]{self!=null};

        /**
         * Precomputed Regions for unpacking data being received from neighbors
         */
        val recvRegions:Rail[Region(3){rect}]{self!=null};

        /**
         * Pre-allocated buffers for sending ghost data.
         */
        public val sendBuffers:Rail[Rail[Double]{self!=null}]{self!=null};

        /**
         * Pre-allocated buffers into which neighbors will place their data.
         * Each neighbor's removeRecvBuffers has a GlobalRail that points 
         * to element of recvBuffers they are assigned to use
         */
        public val recvBuffers:Rail[Rail[Double]{self!=null}]{self!=null};

        /**
         * GlobalRails pointing to the recvBuffer entry
         * for each neighbor in neighborListSend.
         */
        public val remoteRecvBuffers:Rail[GlobalRail[Double]]{self!=null};

        /**
         * GlobalRails pointing to the sendBuffer entry
         * for each neighbor in neighborListRecv.
         */
        public val remoteSendBuffers:Rail[GlobalRail[Double]]{self!=null};

        /**
         * The pending update functions recevied from neighbors for the current cycle
         */
        public val updateFunctions:Stack[()=>void]{self!=null};

        /**
         * The current phase of the computation with regard to ghost cell updates.
         * Places are assumed to progress together; in even phases, ghost cells are
         * used; in odd phases, ghost cells are updated.  No place may start phase 
         * P+2 before neighboring places have completed phase P.
         */
        public var currentPhase:Long;

        public var sendTime:Long = 0;
        public var processTime:Long = 0;
        public var waitTime:Long = 0;

        protected final def getRecvNeighborNumber(neighborId:Long) {
            for (i in 0..(neighborListRecv.size-1)) {
                if (neighborId == neighborListRecv(i)) {
                    return i;
                }
            }
            throw new IllegalArgumentException(here + " getRecvNeighborNumber for " + neighborId);
        }

        protected final def getSendNeighborNumber(neighborId:Long) {
            for (i in 0..(neighborListSend.size-1)) {
                if (neighborId == neighborListSend(i)) {
                    return i;
                }
            }
            throw new IllegalArgumentException(here + " getSendNeighborNumber for " + neighborId);
        }

        protected def this(domainPlh:PlaceLocalHandle[Domain],
                           neighborListSend:Rail[Long],
                           neighborListRecv:Rail[Long],
                           sideLength:Long,
                           accessFields:(Domain) => Rail[Rail[Double]]) {
            this.domainPlh = domainPlh;
            this.neighborListSend = neighborListSend;
            this.neighborListRecv = neighborListRecv;
            this.neighborsReceivedCount = 0;
            this.updateFunctions = new Stack[()=>void]();
            this.currentPhase = 0;
            this.sideLength = sideLength;
            this.accessFields = accessFields;

            val numFields = accessFields(domainPlh()).size;
            val hereLoc = domainPlh().loc;
            val rr = this.recvRegions = new Rail[Region(3){rect}](neighborListRecv.size, (i:Long)=> {
                val neighborId = neighborListRecv(i);
                val neighborLoc = DomainLoc.make(neighborId, hereLoc.tp);
                DomainLoc.getBoundaryRegion(hereLoc, neighborLoc, sideLength-1)
            });
            this.recvBuffers = new Rail[Rail[Double]{self!=null}](neighborListRecv.size, 
                                                                  (i:Long) => new Rail[Double](rr(i).size() * numFields));

            val sr = this.sendRegions = new Rail[Region(3){rect}](neighborListSend.size, (i:Long)=> {
                val neighborId = neighborListSend(i);
                val neighborLoc = DomainLoc.make(neighborId, hereLoc.tp);
                DomainLoc.getBoundaryRegion(hereLoc, neighborLoc, sideLength-1)
            });
            this.sendBuffers = new Rail[Rail[Double]{self!=null}](neighborListSend.size, 
                                                                  (i:Long) => new Rail[Double](sr(i).size() * numFields));

            val dummy = GlobalRail[Double](new Rail[Double](0));
            this.remoteRecvBuffers = new Rail[GlobalRail[Double]](neighborListSend.size, dummy);
            this.remoteSendBuffers = new Rail[GlobalRail[Double]](neighborListRecv.size, dummy);
        }
    }

    public val localState:PlaceLocalHandle[LocalState];

    /**
     * Create a GhostManager to coordinate data exchange.
     * @param domainPlh The PlaceLocalHandle to the Domain containing the data to manage
     * @param initNeighborsSend function to compute the neighbors to which data should be sent
     * @param initNeighborsRecv function to compute the neighbors from which data should be received
     * @param sideLength the number of data elements along a 'side' 
     * @param accessFields a function to extract the fields being managed from a Domain.
     */
    public def this(domainPlh:PlaceLocalHandle[Domain],
                    initNeighborsSend:() => Rail[Long],
                    initNeighborsRecv:() => Rail[Long],
                    sideLength:Long,
                    accessFields:(Domain) => Rail[Rail[Double]]) {
        // First, create the LocalState of the GhostManager at each Place.
        val ls = PlaceLocalHandle.make[LocalState](Place.places(), () => { 
            new LocalState(domainPlh, initNeighborsSend(), initNeighborsRecv(), sideLength, accessFields)
        });
        this.localState = ls;

        // Now initialize remoteRecvBuffers with GlobalRails to target remote recvBuffer
        Place.places().broadcastFlat(()=> {
            val ls2 = ls();
            // The finish is required to prevent interactions between the specialized
            // finish implementation used by broadcastFlat and the implementation of resilient at.
            finish for (i in ls2.neighborListSend.range) {
              val senderId = here.id;
              ls2.remoteRecvBuffers(i) = at (Place(ls2.neighborListSend(i))) {
                  val ls3 = ls();
                  val bufIdx = ls3.getRecvNeighborNumber(senderId);
                  GlobalRail[Double](ls3.recvBuffers(bufIdx))
              };
            }
        });

        // Now initialize remoteSendBuffers with GlobalRails to source remote sendBuffer
        Place.places().broadcastFlat(()=> {
            val ls2 = ls();
            // The finish is required to prevent interactions between the specialized
            // finish implementation used by broadcastFlat and the implementation of resilient at.
            finish for (i in ls2.neighborListRecv.range) {
              val recvId = here.id;
              ls2.remoteSendBuffers(i) = at (Place(ls2.neighborListRecv(i))) {
                  val ls3 = ls();
                  val bufIdx = ls3.getSendNeighborNumber(recvId);
                  GlobalRail[Double](ls3.sendBuffers(bufIdx))
              };
            }
        });
    }

    private final def allNeighborsReceived():Boolean {
        val received = localState().neighborsReceivedCount;
        val expected = localState().neighborListRecv.size;
        return received == expected;
    }

    private final def processUpdateFunctions() {
        val functions = localState().updateFunctions;
        while (true) {
            var f:()=>void = null;
            atomic { if (!functions.isEmpty()) f = functions.pop(); }
            if (f == null) break;
            f();
        }
    }

    private final @Inline def postUpdateFunction(posterPhase:Long, updateFunction:()=>void) {
        val ls = localState();
        if (posterPhase == ls.currentPhase) {
            updateFunction();
            atomic ls.neighborsReceivedCount++;
        } else {
            atomic {
                ls.updateFunctions.push(updateFunction);
                ls.neighborsReceivedCount++;
            }
        }
    }

    /** 
     * Wait for all ghosts to be received and then return.
     * Used to switch ghost manager phase from sending to using ghost data.
     */
    public final def waitForGhosts() {
        val t1 = Timer.nanoTime();
        val ls = localState();
        processUpdateFunctions();
        val t2 = Timer.nanoTime();
        ls.processTime += (t2 - t1);
        when (allNeighborsReceived()) {
            val t3 = Timer.nanoTime();
            ls.waitTime += (t3 - t2);
            processUpdateFunctions();
            ls.currentPhase++;
            ls.neighborsReceivedCount = 0;
            ls.processTime += Timer.nanoTime() - t3;
        }
    }


    /**
     * Send boundary data from this place to neighboring places to be 
     * combined later by waitAndCombineBoundaries.
     * @see waitAndCombineBoundaries
     */
    public def gatherBoundariesToCombine() {
        val start = Timer.nanoTime();
        val src_ls = localState();
        atomic src_ls.currentPhase++;
        val sourceDom = src_ls.domainPlh();
        val sourceId = here.id;
        for (i in src_ls.neighborListSend.range) {
            val data = src_ls.sendBuffers(i);
            sourceDom.gatherData(data, src_ls.sendRegions(i), src_ls.accessFields, src_ls.sideLength);
            Rail.uncountedCopy(data, 0, src_ls.remoteRecvBuffers(i), 0, data.size, ()=> {
                val dst_ls = localState();
                atomic dst_ls.neighborsReceivedCount++;
            });
        }
        src_ls.sendTime += Timer.nanoTime() - start;
    }

    /** 
     * Wait for all boundary data to be received from neighboring places,
     * and then combine it with boundary data computed at this place.
     * Switch ghost manager phase from sending to using ghost data.
     */
    public final def waitAndCombineBoundaries() {
        val t1 = Timer.nanoTime();
        val ls = localState();
        when (allNeighborsReceived()) {
            val t2 = Timer.nanoTime();
            ls.waitTime += (t2 - t1);
            val dom = ls.domainPlh();
            for (i in ls.recvBuffers.range) {
                dom.accumulateBoundaryData(ls.recvBuffers(i), ls.recvRegions(i), ls.accessFields, ls.sideLength);
            }
            ls.currentPhase++;
            ls.neighborsReceivedCount = 0;
            ls.processTime += Timer.nanoTime() - t2;
        }
    }

    /**
     * Collective exchange and combine of boundary data as an
     * get-based alternative to gatherBoundariesToCombine; waitAndCombineBoundaries.
     *
     * The internal steps are:
     *  (a) pack my data into send buffers
     *  (b) global barrier
     *  (c) get data from neighbors
     *  (d) unpack & accumulate data from neighbors
     * It assumes that there is at least one other collective operation between
     * calls to exhangeAndCombinedBoundaryData (to avoid needing a barrier before
     * updating the sendBuffers).
     */
    public final def exchangeAndCombineBoundaryData() {
        val t1 = Timer.nanoTime();
        val ls = localState();
        val dom = ls.domainPlh();

        // (a) pack my outgoing data into the send buffers
        for (i in ls.neighborListSend.range) {
            val data = ls.sendBuffers(i);
            dom.gatherData(data, ls.sendRegions(i), ls.accessFields, ls.sideLength);
        }

        // (b) wait for everyone else to have packed their data
        val t2 = Timer.nanoTime();
        ls.processTime += (t2 - t1);
        Team.WORLD.barrier();
        val t3 = Timer.nanoTime();
        ls.waitTime += (t3 - t2);

        // (c) get the packed data from my neighbors
        finish {
            for (i in ls.neighborListRecv.range) {
                Rail.asyncCopy(ls.remoteSendBuffers(i), 0, ls.recvBuffers(i), 0, ls.recvBuffers(i).size);
            }
        }
        val t4 = Timer.nanoTime();
        ls.sendTime += (t4 - t3);

        // (d) combine
        for (i in ls.recvBuffers.range) {
            dom.accumulateBoundaryData(ls.recvBuffers(i), ls.recvRegions(i), ls.accessFields, ls.sideLength);
        }
       ls.processTime += (Timer.nanoTime() - t4);
    }


   /**
     * Update boundary data at all neighboring places, overwriting with data
     * from this place's boundary region.
     * 
     * This method updates (overwrites) boundary data at neighboring places
     * with boundary data from this place. It is combined with
     * a subsequent call to waitForGhosts to implement a full exchange of the
     * boundary ghost data between neighbors.
     */
    public def updateBoundaryData() {
        val start = Timer.nanoTime();
        val src_ls = localState();
        atomic src_ls.currentPhase++;
        val sourceId = here.id;
        val sourceDom = src_ls.domainPlh();
        val phase = src_ls.currentPhase;
        for (i in src_ls.neighborListSend.range) {
            val data = src_ls.sendBuffers(i);
            sourceDom.gatherData(data, src_ls.sendRegions(i), src_ls.accessFields, src_ls.sideLength);
            Rail.uncountedCopy(data, 0, src_ls.remoteRecvBuffers(i), 0, data.size, ()=> {
                postUpdateFunction(phase, ()=>{
                    val dst_ls = localState();
                    val sender = dst_ls.getRecvNeighborNumber(sourceId);
                    dst_ls.domainPlh().updateBoundaryData(dst_ls.recvBuffers(sender), dst_ls.recvRegions(sender), 
                                                          dst_ls.accessFields, dst_ls.sideLength);
                });
            });
        }
        localState().sendTime += Timer.nanoTime() - start;
    }

    /**
     * Collective exchange of boundary data as an
     * get-based alternative to updateBoundaryData; waitForGhosts
     *
     * The internal steps are:
     *  (a) pack my data into send buffers
     *  (b) global barrier
     *  (c) get data from neighbors
     *  (d) unpack & accumulate data from neighbors
     * It assumes that there is at least one other collective operation between
     * calls to exhangeBoundaryData (to avoid needing a barrier before
     * updating the sendBuffers).
     */
    public final def exchangeBoundaryData() {
        val t1 = Timer.nanoTime();
        val ls = localState();
        val dom = ls.domainPlh();

        // (a) pack my outgoing data into the send buffers
        for (i in ls.neighborListSend.range) {
            dom.gatherData(ls.sendBuffers(i), ls.sendRegions(i), ls.accessFields, ls.sideLength);
        }

        // (b) wait for everyone else to have packed their data
        val t2 = Timer.nanoTime();
        ls.processTime += (t2 - t1);
        Team.WORLD.barrier();
        val t3 = Timer.nanoTime();
        ls.waitTime += (t3 - t2);

        // (c) get the packed data from my neighbors
        finish {
            for (i in ls.neighborListRecv.range) {
                Rail.asyncCopy(ls.remoteSendBuffers(i), 0, ls.recvBuffers(i), 0, ls.recvBuffers(i).size);
            }
        }
        val t4 = Timer.nanoTime();
        ls.sendTime += (t4 - t3);

        // (d) combine
        for (i in ls.recvBuffers.range) {
            dom.updateBoundaryData(ls.recvBuffers(i), ls.recvRegions(i), ls.accessFields, ls.sideLength);
        }
        ls.processTime += (Timer.nanoTime() - t4);
    }


   /**
     * Plane ghost data are stored contiguously
     * for each plane *after* all locally-managed data at each place.
     *
     * This method updates ghost data for plane boundaries at neighboring
     * places with plane boundary data from this place. It is combined with
     * a subsequent call to waitForGhosts to implement a full exchange of the
     * Plane ghost data between neighbors.
     */
    public def updatePlaneGhosts() {
        val start = Timer.nanoTime();
        val src_ls = localState();
        atomic src_ls.currentPhase++;
        val sourceId = here.id;
        val sourceDom = src_ls.domainPlh();
        val phase = src_ls.currentPhase;
        for (i in src_ls.neighborListSend.range) {
            val data = src_ls.sendBuffers(i);
            sourceDom.gatherData(data, src_ls.sendRegions(i), src_ls.accessFields, src_ls.sideLength);
            Rail.uncountedCopy(data, 0, src_ls.remoteRecvBuffers(i), 0, data.size, ()=> {
                postUpdateFunction(phase,  ()=>{
                    val dst_ls = localState();
                    val sideLength = dst_ls.sideLength;
                    val localDataSize = sideLength*sideLength*sideLength;
                    val ghostRegionSize = sideLength*sideLength;
                    val sender = dst_ls.getRecvNeighborNumber(sourceId);
                    val ghostOffset = localDataSize + sender * ghostRegionSize;
                    dst_ls.domainPlh().updateGhosts(dst_ls.recvBuffers(sender), 
                                                    dst_ls.accessFields, 
                                                    ghostRegionSize, ghostOffset);
                });
            });
        }
        src_ls.sendTime += Timer.nanoTime() - start;
    }

    /**
     * Plane ghost data are stored contiguously
     * for each plane *after* all locally-managed data at each place.
     * 
     * This method implements a collective get-based exchange of Plane
     * ghost data as an alternate to the sequence updatePlaneGhosts; waitForGhosts).
     *
     * The steps are:
     *  (a) pack my data into send buffers
     *  (b) global barrier
     *  (c) get data from neighbors
     *  (d) unpack & accumulate data from neighbors
     * It assumes that there is at least one other collective operation between
     * calls to exhangePlaneGhosts (to avoid needing a barrier before updating the
     * sendBuffers).
     */
    public final def exchangePlaneGhosts() {
        val t1 = Timer.nanoTime();
        val ls = localState();
        val dom = ls.domainPlh();

        // (a) pack my outgoing data into the send buffers
        for (i in ls.neighborListSend.range) {
            dom.gatherData(ls.sendBuffers(i), ls.sendRegions(i), ls.accessFields, ls.sideLength);
        }

        // (b) wait for everyone else to have packed their data
        val t2 = Timer.nanoTime();
        ls.processTime += (t2 - t1);
        Team.WORLD.barrier();
        val t3 = Timer.nanoTime();
        ls.waitTime += (t3 - t2);

        // (c) get the packed data from my neighbors
        finish {
            for (i in ls.neighborListRecv.range) {
                Rail.asyncCopy(ls.remoteSendBuffers(i), 0, ls.recvBuffers(i), 0, ls.recvBuffers(i).size);
            }
        }
        val t4 = Timer.nanoTime();
        ls.sendTime += (t4 - t3);

        // (d) combine
        val sideLength = ls.sideLength;
        val localDataSize = sideLength*sideLength*sideLength;
        val ghostRegionSize = sideLength*sideLength;
        for (i in ls.recvBuffers.range) {
            val ghostOffset = localDataSize + i * ghostRegionSize;
            dom.updateGhosts(ls.recvBuffers(i), ls.accessFields, ghostRegionSize, ghostOffset);
        }
        ls.processTime += (Timer.nanoTime() - t4);
    }
}
