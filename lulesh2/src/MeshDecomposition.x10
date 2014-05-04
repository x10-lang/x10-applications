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

/** Performs mesh decomposition for the LULESH proxy app. */
public class MeshDecomposition {
    /** Represents a place's location in the place grid. */
    public static struct PlaceGridLoc(placesPerSide:Int, col:Int, row:Int, plane:Int) {
        public def this(placesPerSide:Int, col:Int, row:Int, plane:Int) {
            property(placesPerSide, col, row, plane);
        }
    }

    /** Gets the location of the current place in the place grid. */
    public static def getPlaceGridLoc():PlaceGridLoc {
        // TODO use PlaceGroup
        val myId = here.id as Int;
        val numPlaces = Place.MAX_PLACES as Int;

        val placesPerSide = Math.cbrt((Place.MAX_PLACES as Double) + 0.5) as Int;
        assert (placesPerSide*placesPerSide*placesPerSide == Place.MAX_PLACES as Int) 
            : "Num processors must be a cube of an integer (1, 8, 27, ...)\n";

        val dx = placesPerSide;
        val dy = placesPerSide;
        val dz = placesPerSide;

        // temporary test
        assert (dx*dy*dz == numPlaces) : "error -- must have as many domains as procs";
        val remainder = dx*dy*dz % numPlaces;

        var myDom:Int;
        if (myId < remainder) {
            myDom = myId*(1n + (dx*dy*dz / numPlaces));
        } else {
            myDom = remainder * (1n + (dx*dy*dz / numPlaces))
                  + (myId - remainder)*(dx*dy*dz/numPlaces);
        }

        return new PlaceGridLoc(placesPerSide,
                                myDom % dx,
                                (myDom / dx) % dy,
                                myDom / (dx*dy));
    }
}
