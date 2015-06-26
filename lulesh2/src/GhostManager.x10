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

/** Manages updates of ghost data for LULESH. */
public abstract class GhostManager {
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
         * Pre-allocated buffers for sending ghost data.
         */
        public val sendBuffers:Rail[Rail[Double]{self!=null}]{self!=null};

        /**
         * Pre-allocated buffers into which neighbors will place their data.
         * Other Place's removeRecvBuffers contain GlobalRails pointing to these.
         */
        public val recvBuffers:Rail[Rail[Double]{self!=null}]{self!=null};

        /**
         * GlobalRails pointing to the recvBuffer entry
         * for each neighbor in neighbotListSend.
         */
        public val remoteRecvBuffers:Rail[GlobalRail[Double]];

        /**
         * The pending update functions recevied from neighbors for the current cycle
         */
        public val updateFunctions:Stack[()=>void];

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

        protected final def getNeighborNumber(neighborId:Long) {
            for (i in 0..(neighborListRecv.size-1)) {
                if (neighborId == neighborListRecv(i)) {
                    return i;
                }
            }
            throw new IllegalArgumentException(here + " getNeighborNumber for " + neighborId);
        }

        protected def this(neighborListSend:Rail[Long], 
                        neighborListRecv:Rail[Long],
                        recvBufferSize:(Long)=>Long) {
            this.neighborListSend = neighborListSend;
            this.neighborListRecv = neighborListRecv;
            this.neighborsReceivedCount = 0;
            this.updateFunctions = new Stack[()=>void]();
            this.currentPhase = 0;
            this.recvBuffers = new Rail[Rail[Double]{self!=null}](neighborListRecv.size, 
                                                      (i:Long) => new Rail[Double](recvBufferSize(i)));
            this.sendBuffers = new Rail[Rail[Double]{self!=null}](neighborListRecv.size, 
                                                      (i:Long) => new Rail[Double](recvBufferSize(i)));
            val dummy = GlobalRail[Double](new Rail[Double](0));
            this.remoteRecvBuffers = new Rail[GlobalRail[Double]](neighborListSend.size, dummy);
        }
    }

    public val localState:PlaceLocalHandle[LocalState];

    /**
     * Create a new GhostManager for ghost updates between all places.
     */
    protected def this(ls:PlaceLocalHandle[LocalState]) {
        this.localState = ls;

        // Initialize remoteRecvBuffers with GlobalRails to target remote recvBuffer
        Place.places().broadcastFlat(()=> {
            val ls2 = ls();
            // The finish is needed to prevent interactions between the specialized
            // finish implementation used by broadcastFlat and the implementation of resilient at.
            finish for (i in ls2.neighborListSend.range) {
              val senderId = here.id;
              ls2.remoteRecvBuffers(i) = at (Place(ls2.neighborListSend(i))) {
                  val ls3 = ls();
                  val bufIdx = ls3.getNeighborNumber(senderId);
                  GlobalRail[Double](ls3.recvBuffers(bufIdx))
              };
            }
        });
    }

    /** 
     * Wait for all ghosts to be received and then return.
     * Used to switch ghost manager phase from sending to using ghost data.
     */
    public final def waitForGhosts() {
        val t1 = Timer.milliTime();
        processUpdateFunctions();
        val t2 = Timer.milliTime();
        localState().processTime += (t2 - t1);
        when (allNeighborsReceived()) {
            val t3 = Timer.milliTime();
            localState().waitTime += (t3 - t2);
            processUpdateFunctions();
            localState().currentPhase++;
            localState().neighborsReceivedCount = 0;
            val t4 = Timer.milliTime();
            localState().processTime += (t4 - t3);
        }
    }

    protected final def allNeighborsReceived():Boolean {
        val received = localState().neighborsReceivedCount;
        val expected = localState().neighborListRecv.size;
        return received == expected;
    }

    protected final def processUpdateFunctions() {
        val functions = localState().updateFunctions;
        while (true) {
            var f:()=>void = null;
            atomic { if (!functions.isEmpty()) f = functions.pop(); }
            if (f == null) break;
            f();
        }
    }

    protected final @Inline def postUpdateFunction(posterPhase:Long, updateFunction:()=>void) {
        val state = localState();
        if (posterPhase == state.currentPhase) {
            updateFunction();
            atomic { state.neighborsReceivedCount++; }
        } else {
            atomic {
                state.updateFunctions.push(updateFunction);
                state.neighborsReceivedCount++;
            }
        }
    }
}
