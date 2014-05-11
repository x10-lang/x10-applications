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

import x10.compiler.NonEscaping;
import x10.util.ArrayList;

/** 
 * Represents a domain's location in the grid decomposition for LULESH.
*/
public class DomainLoc(
    /** The (place) ID for this domain. */
    id:Int,
    /** Number of places per side of cubic decomposition */
    tp:Int,
    /** X location of this domain in the grid. */ 
    x:Int,
    /** Y location of this domain in the grid. */
    y:Int,
    /** Z location of this domain in the grid. */
    z:Int) {

    // neighbor types
    public static val NEIGHBOR_PLANE = 1n;
    public static val NEIGHBOR_EDGE = 2n;
    public static val NEIGHBOR_CORNER = 3n;
    public static val NOT_NEIGHBOR = -1n;

    public var planeNeighbors:Long;
    public var edgeNeighbors:Long;
    public var cornerNeighbors:Long;

    /** Create a new DomainLoc for the given place in the grid. */
    public static def make(placeId:Long, placesPerSide:Int):DomainLoc {
        // TODO use PlaceGroup
        val id = placeId as Int;
        val numPlaces = Place.MAX_PLACES as Int;

        assert (placesPerSide*placesPerSide*placesPerSide == numPlaces);

        val dx = placesPerSide;
        val dy = placesPerSide;
        val dz = placesPerSide;

        // temporary test
        assert (dx*dy*dz == numPlaces) : "error -- must have as many domains as procs";
        val remainder = dx*dy*dz % numPlaces;

        var myDom:Int;
        if (id < remainder) {
            myDom = id*(1n + (dx*dy*dz / numPlaces));
        } else {
            myDom = remainder * (1n + (dx*dy*dz / numPlaces))
                  + (id - remainder)*(dx*dy*dz/numPlaces);
        }

        return new DomainLoc(id, placesPerSide,
                                myDom % dx,
                                (myDom / dx) % dy,
                                myDom / (dx*dy));
    }

    private def this(id:Int, placesPerSide:Int, x:Int, y:Int, z:Int) {
        property(id, placesPerSide, x, y, z);
    }

    public def isFirstDomain() {
        return (x + y + z) == 0n;
    }

    public def createNeighborList(planeOnly:Boolean) {
        val p = tp * tp;
        val r = tp;
        val c = 1;
        val max = tp-1;

        val nl = new ArrayList[Long](26);
        if (z > 0  ) nl.add(id - p        );
        if (z < max) nl.add(id + p        );
        if (y > 0  ) nl.add(id     - r    );
        if (y < max) nl.add(id     + r    );
        if (x > 0  ) nl.add(id         - c);
        if (x < max) nl.add(id         + c);
        planeNeighbors = nl.size();

        if (!planeOnly) {
            /* transfer between domains connected only by an edge */
            if (z > 0   && y   > 0  ) nl.add(id - p - r    );
            if (z > 0   && y   < max) nl.add(id - p + r    );
            if (z < max && y   > 0  ) nl.add(id + p - r    );
            if (z < max && y   < max) nl.add(id + p + r    );
            if (z > 0   && x   > 0  ) nl.add(id - p     - c);
            if (z > 0   && x   < max) nl.add(id - p     + c);
            if (z < max && x   > 0  ) nl.add(id + p     - c);
            if (z < max && x   < max) nl.add(id + p     + c);
            if (y > 0   && x   > 0  ) nl.add(id     - r - c);
            if (y > 0   && x   < max) nl.add(id     - r + c);
            if (y < max && x   > 0  ) nl.add(id     + r - c);
            if (y < max && x   < max) nl.add(id     + r + c);
            edgeNeighbors = nl.size() - planeNeighbors;

            /* receive data from domains connected only by a corner */
            if (z > 0   && y > 0   && x > 0  ) nl.add(id - p - r - c);
            if (z > 0   && y > 0   && x < max) nl.add(id - p - r + c);
            if (z > 0   && y < max && x > 0  ) nl.add(id - p + r - c);
            if (z > 0   && y < max && x < max) nl.add(id - p + r + c);
            if (z < max && y > 0   && x > 0  ) nl.add(id + p - r - c);
            if (z < max && y > 0   && x < max) nl.add(id + p - r + c);
            if (z < max && y < max && x > 0  ) nl.add(id + p + r - c);
            if (z < max && y < max && x < max) nl.add(id + p + r + c);

            cornerNeighbors = nl.size() - edgeNeighbors - planeNeighbors;
        } else {
            edgeNeighbors = 0;
            cornerNeighbors = 0;
        }

        return nl.toRail();
    }

    public def getNeighborType(neighbor:DomainLoc) {
        val xDiff = Math.abs(x - neighbor.x);
        if (xDiff > 1) return NOT_NEIGHBOR;
        val yDiff = Math.abs(y - neighbor.y);
        if (yDiff > 1) return NOT_NEIGHBOR;
        val zDiff = Math.abs(z - neighbor.z);
        if (zDiff > 1) return NOT_NEIGHBOR;
        val diff = xDiff + yDiff + zDiff;

        // could just return diff; this is for readability
        if (diff == 1n) return NEIGHBOR_PLANE;
        if (diff == 2n) return NEIGHBOR_EDGE;
        if (diff == 3n) return NEIGHBOR_CORNER;

        return NOT_NEIGHBOR; // error, or same domain?
    }
}
