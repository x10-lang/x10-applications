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

/**
 * Thrown to indicate an invalid (e.g. negative) volume element. 
 */
public class VolumeException extends Exception {
    /**
     * Construct a VolumeException for given element number.
     *
     * @param elementNumber the number of the element for which volume was invalid
     */
    public def this(elementNumber:Long, volume:Double) { super("Invalid volume for element " + elementNumber + ": " + volume); }
}

// vim:tabstop=4:shiftwidth=4:expandtab
