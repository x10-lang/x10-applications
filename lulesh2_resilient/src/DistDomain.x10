/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2015.
 */

class DistDomain {
    static VERBOSE = System.getenv("LULESH_VERBOSE") != null;
    public var domainPlh:PlaceLocalHandle[Domain];
    public var places:PlaceGroup;
    
    public def this(dPlh:PlaceLocalHandle[Domain], places:PlaceGroup) {
        this.domainPlh = dPlh;
        this.places = places;
    }

    public def remake(newPg:PlaceGroup, opts:CommandLineOptions) {
        val oldPlaces = places;
        PlaceLocalHandle.destroy(oldPlaces, domainPlh, (Place)=>true);
    
        val numPlaces = newPg.size();
    
        val placesPerSide = Math.cbrt((numPlaces as Double) + 0.5) as Int;
        if  (placesPerSide <= 0 || placesPerSide*placesPerSide*placesPerSide != numPlaces as Int) {
            throw new Exception("Num of restore processors must be a cube of an integer (1, 8, 27, ...)");
        }
        places = newPg;
        domainPlh = PlaceLocalHandle.make[Domain](places, 
            () => new Domain(opts.nx, opts.numReg, opts.balance, opts.cost, placesPerSide, places));
    }
}
// vim:tabstop=4:shiftwidth=4:expandtab
