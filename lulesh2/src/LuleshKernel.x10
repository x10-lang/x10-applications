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

import x10.array.Array_2;
import x10.compiler.Foreach;
import x10.compiler.Inline;
import x10.compiler.StackAllocate;
import x10.compiler.StackAllocateUninitialized;
import x10.compiler.WorkerLocal;

/**
 * This class extracts the hourglass force calculation kernel as a standalone
 * program. It is not used in any way by the LULESH application (Lulesh.x10), 
 * but it is useful for testing parallel iteration patterns.
 * The hourglass force calculation loop is the most complicated loop in LULESH
 * and accounts for around 20% of the runtime, making it a key target for
 * loop optimizations.
 */
public class LuleshKernel {
    static val ITERS = 5000;
    static val SIZE = 30;

    val domain:Domain;
    val fx_elem:Rail[Double];
    val fy_elem:Rail[Double];
    val fz_elem:Rail[Double];

    public static def main(args:Rail[String]) {
        new LuleshKernel().run();
    }

    public def this() {
        domain = new Domain(SIZE, 1n, 1n, 1n, 1n);

        val numElem = domain.numElem;
        val numElem8 = numElem * 8;
        fx_elem = new Rail[Double](numElem8);
        fy_elem = new Rail[Double](numElem8);
        fz_elem = new Rail[Double](numElem8);
    }

    public def run() {
        val numElem = domain.numElem;
        val numElem8 = numElem * 8;
        val dvdx = new Rail[Double](numElem8);
        val dvdy = new Rail[Double](numElem8);
        val dvdz = new Rail[Double](numElem8);
        val x8n  = new Rail[Double](numElem8);
        val y8n  = new Rail[Double](numElem8);
        val z8n  = new Rail[Double](numElem8);
        val determ = new Rail[Double](numElem, 1.0);
        val hgcoef = 1.0;

        val start = System.nanoTime();
        for (i in 1..ITERS) {
            calcFBHourglassForceForElems(domain,
                                            determ, x8n, y8n, z8n, dvdx, dvdy, dvdz,
                                            hgcoef);
        }
        val stop = System.nanoTime();
        Console.OUT.printf("LULESH hourglass force kernel grid size: %d X10_NTHREADS: %d time per iteration: %g ms\n", SIZE, x10.xrx.Runtime.NTHREADS, ((stop-start) as Double) / 1e6 / ITERS);
    }

    /** 
     * Calculates the Flanagan-Belytschko anti-hourglass force. 
     * @see "D. P. Flanagan and T. Belytschko. A uniform strain hexahedron 
     * and quadrilateral with orthogonal hourglass control. Int. J. Num. 
     * Methods in Engineering, pages 679–706, March 1981."
     */
    protected def calcFBHourglassForceForElems(domain:Domain,
           determ:Rail[Double],
           x8n:Rail[Double], y8n:Rail[Double], z8n:Rail[Double],
           dvdx:Rail[Double], dvdy:Rail[Double], dvdz:Rail[Double],
           hourg:Double) {

        // initialize hourglass gamma
        @StackAllocate val gammaStore = @StackAllocateUninitialized new Rail[Double](32);
        val gamma = Array_2.makeView[Double](gammaStore, 4, 8);
        gamma(0,0) =  1.0;
        gamma(0,1) =  1.0;
        gamma(0,2) = -1.0;
        gamma(0,3) = -1.0;
        gamma(0,4) = -1.0;
        gamma(0,5) = -1.0;
        gamma(0,6) =  1.0;
        gamma(0,7) =  1.0;
        gamma(1,0) =  1.0;
        gamma(1,1) = -1.0;
        gamma(1,2) = -1.0;
        gamma(1,3) =  1.0;
        gamma(1,4) = -1.0;
        gamma(1,5) =  1.0;
        gamma(1,6) =  1.0;
        gamma(1,7) = -1.0;
        gamma(2,0) =  1.0;
        gamma(2,1) = -1.0;
        gamma(2,2) =  1.0;
        gamma(2,3) = -1.0;
        gamma(2,4) =  1.0;
        gamma(2,5) = -1.0;
        gamma(2,6) =  1.0;
        gamma(2,7) = -1.0;
        gamma(3,0) = -1.0;
        gamma(3,1) =  1.0;
        gamma(3,2) = -1.0;
        gamma(3,3) =  1.0;
        gamma(3,4) =  1.0;
        gamma(3,5) = -1.0;
        gamma(3,6) =  1.0;
        gamma(3,7) = -1.0;
/*
        final class LocalData {
            val hourgam = new Array_2[Double](8,4);
            val xd1 = new Rail[Double](8);
            val yd1 = new Rail[Double](8);
            val zd1 = new Rail[Double](8);
            val hgfx = new Rail[Double](8);
            val hgfy = new Rail[Double](8);
            val hgfz = new Rail[Double](8);
        }
        val l = new WorkerLocal[LocalData](() => new LocalData());
*/
        // compute the hourglass modes
        val body = (min_i:Long, max_i:Long) => {
/*
            val local = l();
            val hourgam = local.hourgam;
            val xd1 = local.xd1;
            val yd1 = local.yd1;
            val zd1 = local.zd1;
            val hgfx = local.hgfx;
            val hgfy = local.hgfy;
            val hgfz = local.hgfz;
*/
            @StackAllocate val hourgamStore = @StackAllocateUninitialized new Rail[Double](32);
            val hourgam = Array_2.makeView[Double](hourgamStore, 8, 4);
            @StackAllocate val xd1 = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val yd1 = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val zd1 = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val hgfx = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val hgfy = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val hgfz = @StackAllocateUninitialized new Rail[Double](8);
/*
            val hourgamStore = new Rail[Double](32);
            val hourgam = Array_2.makeView[Double](hourgamStore, 8, 4);
            val xd1 = new Rail[Double](8);
            val yd1 = new Rail[Double](8);
            val zd1 = new Rail[Double](8);
            val hgfx = new Rail[Double](8);
            val hgfy = new Rail[Double](8);
            val hgfz = new Rail[Double](8);
*/
            var i3:Long = 8*min_i;
            for (i2 in min_i..max_i) {
                val volinv = 1.0 / determ(i2);
                for (i1 in 0..3) {
                    val i3f = i3;
                    val hourmod = (a8n:Rail[Double]) => {
                        a8n(i3f)   * gamma(i1,0) + a8n(i3f+1) * gamma(i1,1) +
                        a8n(i3f+2) * gamma(i1,2) + a8n(i3f+3) * gamma(i1,3) +
                        a8n(i3f+4) * gamma(i1,4) + a8n(i3f+5) * gamma(i1,5) +
                        a8n(i3f+6) * gamma(i1,6) + a8n(i3f+7) * gamma(i1,7)
                    };

                    val hourmodx = hourmod(x8n);
                    val hourmody = hourmod(y8n);
                    val hourmodz = hourmod(z8n);

                    val setHourgam = (idx:Long) => {
                        hourgam(idx,i1) = gamma(i1,idx) 
                            - volinv * (dvdx(i3f+idx) * hourmodx
                                      + dvdy(i3f+idx) * hourmody
                                      + dvdz(i3f+idx) * hourmodz);
                    };

                    // TODO can re-roll this loop?
                    setHourgam(0);
                    setHourgam(1);
                    setHourgam(2);
                    setHourgam(3);
                    setHourgam(4);
                    setHourgam(5);
                    setHourgam(6);
                    setHourgam(7);
                }

                /* compute forces */
                /* store forces into h arrays (force arrays) */
                val ss1 = domain.ss(i2);
                val mass1 = domain.elemMass(i2);
                val volume13 = Math.cbrt(determ(i2));

                val n0si2 = domain.nodeList(i3+0);
                val n1si2 = domain.nodeList(i3+1);
                val n2si2 = domain.nodeList(i3+2);
                val n3si2 = domain.nodeList(i3+3);
                val n4si2 = domain.nodeList(i3+4);
                val n5si2 = domain.nodeList(i3+5);
                val n6si2 = domain.nodeList(i3+6);
                val n7si2 = domain.nodeList(i3+7);

                xd1(0) = domain.xd(n0si2);
                xd1(1) = domain.xd(n1si2);
                xd1(2) = domain.xd(n2si2);
                xd1(3) = domain.xd(n3si2);
                xd1(4) = domain.xd(n4si2);
                xd1(5) = domain.xd(n5si2);
                xd1(6) = domain.xd(n6si2);
                xd1(7) = domain.xd(n7si2);

                yd1(0) = domain.yd(n0si2);
                yd1(1) = domain.yd(n1si2);
                yd1(2) = domain.yd(n2si2);
                yd1(3) = domain.yd(n3si2);
                yd1(4) = domain.yd(n4si2);
                yd1(5) = domain.yd(n5si2);
                yd1(6) = domain.yd(n6si2);
                yd1(7) = domain.yd(n7si2);

                zd1(0) = domain.zd(n0si2);
                zd1(1) = domain.zd(n1si2);
                zd1(2) = domain.zd(n2si2);
                zd1(3) = domain.zd(n3si2);
                zd1(4) = domain.zd(n4si2);
                zd1(5) = domain.zd(n5si2);
                zd1(6) = domain.zd(n6si2);
                zd1(7) = domain.zd(n7si2);

                val coefficient = -hourg * 0.01 * ss1 * mass1 / volume13;

                calcElemFBHourglassForce(xd1, yd1, zd1, hourgam,
                      coefficient, hgfx, hgfy, hgfz);

                for (i in 0..7) fx_elem(i) = hgfx(i);
                for (i in 0..7) fy_elem(i) = hgfy(i);
                for (i in 0..7) fz_elem(i) = hgfz(i);
            }
            i3 += 8;
        };

        val numElem = domain.numElem;

        //Foreach.sequential(0, numElem-1, body);
        //Foreach.basic(0, numElem, (i:Long) => {body(i, i);});
        Foreach.block(0, numElem-1, body);
        //Foreach.bisect(0, numElem, body);
    }

    private @Inline final def calcElemFBHourglassForce(
                       xd:Rail[Double], yd:Rail[Double], zd:Rail[Double],
                       hourgam:Array_2[Double], coefficient:Double,
                       hgfx:Rail[Double], hgfy:Rail[Double], hgfz:Rail[Double]) {
        @StackAllocate val hxx = @StackAllocateUninitialized new Rail[Double](4);
        
        val calcForce = (v:Rail[Double], force:Rail[Double]) => {
            for (i in 0..3) {
                hxx(i) = hourgam(0,i) * v(0) + hourgam(1,i) * v(1) +
                         hourgam(2,i) * v(2) + hourgam(3,i) * v(3) +
                         hourgam(4,i) * v(4) + hourgam(5,i) * v(5) +
                         hourgam(6,i) * v(6) + hourgam(7,i) * v(7);
            }
            for (i in 0..7) {
                force(i) = coefficient *
                        (hourgam(i,0) * hxx(0) + hourgam(i,1) * hxx(1) +
                         hourgam(i,2) * hxx(2) + hourgam(i,3) * hxx(3));
            }
        };

        calcForce(xd, hgfx);
        calcForce(yd, hgfy);
        calcForce(zd, hgfz);
    }
}
