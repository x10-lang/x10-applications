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
 * GhostManager specialized for the case of data that is only 
 * exchanged between neighboring Domains that share a plane.
 */
public final class PlaneGhostManager extends GhostManager {

    public static def make(domainPlh:PlaceLocalHandle[Domain], sideLength:Long, 
                           accessFields:(Domain) => Rail[Rail[Double]]) {
        return new PlaneGhostManager(domainPlh, sideLength, accessFields);
    }

    protected def this(domainPlh:PlaceLocalHandle[Domain], sideLength:Long,
                       accessFields:(Domain) => Rail[Rail[Double]]) {
        super(PlaceLocalHandle.make[LocalState](Place.places(), () => {
            val neighbors = domainPlh().loc.createNeighborList(true, true, true);
            return new LocalState(domainPlh, neighbors, neighbors, sideLength, accessFields);
        }));
    }

    /**
     * Update ghost data for plane boundaries at neighboring places with plane
     * boundary data from this place.  Plane ghost data are stored contiguously
     * for each plane *after* all locally-managed data at each place. 
     */
    public def updatePlaneGhosts() {
        val start = Timer.milliTime();
        val src_ls = localState();
        atomic src_ls.currentPhase++;
        val sourceId = here.id;
        val sourceDom = src_ls.domainPlh();
        val phase = src_ls.currentPhase;
        val neighbors = src_ls.neighborListSend;
        for (i in 0..(neighbors.size-1)) {
            val ghosts = src_ls.sendBuffers(i);
            sourceDom.gatherGhosts(neighbors(i), src_ls.sendRegions(i), src_ls.accessFields, src_ls.sideLength, ghosts);
            val target = src_ls.remoteRecvBuffers(i);
            Rail.uncountedCopy(ghosts, 0, target, 0, ghosts.size, ()=> {
                postUpdateFunction(phase,  ()=>{
                    val dst_ls = localState();
                    val sideLength = dst_ls.sideLength;
                    var ghostOffset:Long = sideLength*sideLength*sideLength;
                    val ghostRegionSize = sideLength*sideLength;
                    val neighborIdx = dst_ls.getNeighborNumber(sourceId);
                    ghostOffset += neighborIdx * ghostRegionSize;
                    dst_ls.domainPlh().updateGhosts(dst_ls.recvBuffers(neighborIdx), 
                                                    dst_ls.accessFields, 
                                                    ghostRegionSize, ghostOffset);
                });
            });
        }
        src_ls.sendTime += Timer.milliTime() - start;
    }
}
