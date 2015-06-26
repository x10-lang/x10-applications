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
 * Manage ghost data exchange across Planes.
 */
public final class PlaneGhostManager extends GhostManager {

    public static def make(initNeighborsSend:() => Rail[Long], 
                           initNeighborsRecv:() => Rail[Long],
                           recvBufferSize:(Long)=>Long) {
        return new PlaneGhostManager(initNeighborsSend, initNeighborsRecv, recvBufferSize);
    }

    protected def this(initNeighborsSend:() => Rail[Long], 
                       initNeighborsRecv:() => Rail[Long],
                       recvBufferSize:(Long)=>Long) {
        super(PlaceLocalHandle.make[LocalState](Place.places(), () => new LocalState(initNeighborsSend(), 
                                                                                     initNeighborsRecv(),
                                                                                     recvBufferSize)));
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
            val ghosts = localState().sendBuffers(i);
            sourceDom.gatherGhosts(neighbors(i), accessFields, sideLength, ghosts);
            val target = localState().remoteRecvBuffers(i);
            Rail.uncountedCopy(ghosts, 0, target, 0, ghosts.size, ()=> {
                postUpdateFunction(phase,  ()=>{
                    var ghostOffset:Long = sideLength*sideLength*sideLength;
                    val ghostRegionSize = (sideLength)*(sideLength);
                    val neighborIdx = localState().getNeighborNumber(sourceId);
                    ghostOffset += neighborIdx * ghostRegionSize;
                    domainPlh().updateGhosts(localState().recvBuffers(neighborIdx), 
                                             accessFields, ghostRegionSize, ghostOffset);
                });
            });
        }
        localState().sendTime += Timer.milliTime() - start;
    }
}
