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
 * Thrown to indicate an excessive artificial viscosity.
 */
public class ViscosityException extends Exception {
    /**
     * Construct a ViscosityException for given element number.
     *
     * @param elementNumber the number of the element for which viscosity was excessive
     */
    public def this(elementNumber:Long, q:Double) { super("Excessive artificial viscosity for element " + elementNumber + ": " + q); }
}

// vim:tabstop=4:shiftwidth=4:expandtab
