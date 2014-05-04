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

import x10.array.Array_2;
import x10.compiler.Ifdef;
import x10.compiler.Inline;
import x10.compiler.StackAllocate;
import x10.util.Team;
import x10.util.Timer;

/** 
 * X10 implementation of LULESH proxy app, based on LULESH version 2.0.3.
 * <p>
 * Various command line options (see ./lulesh2.0 -h)
 *  -q              : quiet mode - suppress stdout
 *  -i <iterations> : number of cycles to run
 *  -s <size>       : length of cube mesh along side
 *  -r <numregions> : Number of distinct regions (def: 11)
 *  -b <balance>    : Load balance between regions of a domain (def: 1)
 *  -c <cost>       : Extra cost of more expensive regions (def: 1)
 *  -f <filepieces> : Number of file parts for viz output (def: np/9)
 *  -p              : Print out progress
 *  -v              : Output viz file (requires compiling with -DVIZ_MESH
 *  -h              : This message
 * </p>
 * @see <a href="https://codesign.llnl.gov/lulesh.php">Co-design at Lawrence
    Livermore National Lab - LULESH</a>
 * @see "Hydrodynamics Challenge Problem, Lawrence Livermore National 
 *  Laboratory. Technical Report, LLNL-TR-490254"
 * @see "I. Karlin, J. Keasler, R. Neely. LULESH 2.0 Updates and Changes. 
 *  August 2013, pages 1-9, LLNL-TR-641973."
 * @see "I. Karlin et al. LULESH Programming Model and Performance Ports 
    Overview, December 2012, pages 1-17, LLNL-TR-608824."
 */
public class Lulesh {
    /** The command line options that were passed to this instance of LULESH. */
    protected val opts:CommandLineOptions;

    /** The simulation domain at each place. */
    protected val domainPlh:PlaceLocalHandle[Domain];

    public static def main(args:Rail[String]) {
        val opts = CommandLineOptions.parse(args);
        if (opts == null) return;

        if (!opts.quiet) {
            Console.OUT.printf("Running problem size %d^3 per domain until completion\n", opts.nx);
            Console.OUT.printf("Num places: %d\n", Place.MAX_PLACES);
            Console.OUT.printf("Num threads: %d\n", Runtime.NTHREADS);
            Console.OUT.printf("Total number of elements: %lld\n\n", Place.MAX_PLACES*opts.nx*opts.nx*opts.nx);
            Console.OUT.printf("To run other sizes, use -s <integer>.\n");
            Console.OUT.printf("To run a fixed number of iterations, use -i <integer>.\n");
            Console.OUT.printf("To run a more or less balanced region set, use -b <integer>.\n");
            Console.OUT.printf("To change the relative costs of regions, use -c <integer>.\n");
            Console.OUT.printf("To print out progress, use -p\n");
            Console.OUT.printf("To write an output file for VisIt, use -v\n");
            Console.OUT.printf("See help (-h) for more options\n\n");
        }

        new Lulesh(opts).run();
    }

    public static calcElemVolume(x:Rail[Double], y:Rail[Double], z:Rail[Double]):Double {
        // TODO
        return 0.0;
    }

    public def this(opts:CommandLineOptions) {
        this.opts = opts;
        this.domainPlh = PlaceLocalHandle.make[Domain](PlaceGroup.WORLD, 
            () => new Domain(opts.nx, opts.numReg, opts.balance, opts.cost));
    }

    public def run() {
        finish for (place in PlaceGroup.WORLD) at(place) async {
            val domain = domainPlh();

            // Initial domain boundary communication 
            // TODO

            val start = Timer.milliTime();

            //debug to see region sizes
            //for (var i:Long = 0; i < domain.numReg; i++)
            //    Console.OUT.println("region " + (i + 1) + " size " + domain.regElemSize(i));

            while((domain.time < domain.stoptime) && (domain.cycle < opts.its)) {

                timeIncrement(domain);

                lagrangeLeapFrog(domain);

                if (opts.showProg && !opts.quiet) {
                    Console.OUT.printf("cycle = %d, time = %e, dt=%e\n",
                        domain.cycle, domain.time, domain.deltatime);
                }
            }

            domain.elapsedTimeMillis = Timer.milliTime() - start;
            Team.WORLD.allreduce(domain.elapsedTimeMillis, Team.MAX);
        } // at(place) async

        val elapsedTime = (domainPlh().elapsedTimeMillis) / 1e3;
        verifyAndWriteFinalOutput(elapsedTime, domainPlh(), opts.nx);
    }

    /* Work Routines */

    protected def timeIncrement(domain:Domain) {
        var targetdt:Double = domain.stoptime - domain.time;

        if (domain.dtfixed <= 0.0 && domain.cycle != 0n) {
            var ratio:Double;
            val olddt = domain.deltatime;

            /* This will require a reduction in parallel */
            var gnewDt:Double = 1.0e+20;
            var newDt:Double;
            if (domain.dtcourant < gnewDt) {
                gnewDt = domain.dtcourant / 2.0;
            }
            if (domain.dthydro < gnewDt) {
                gnewDt = domain.dthydro * 2.0 / 3.0;
            }
            newDt = gnewDt;
            Team.WORLD.allreduce(newDt, Team.MIN);

            ratio = newDt / olddt;
            if (ratio >= 1.0) {
                if (ratio < domain.deltatimemultlb) {
                    newDt = olddt;
                } else if (ratio > domain.deltatimemultub) {
                    newDt = olddt * domain.deltatimemultub;
                }
            }

            if (newDt > domain.dtmax) {
                newDt = domain.dtmax;
            }
            domain.deltatime = newDt;
        }

        /* TRY TO PREVENT VERY SMALL SCALING ON THE NEXT CYCLE */
        if ((targetdt > domain.deltatime) &&
            (targetdt < 4.0 * domain.deltatime / 3.0) ) {
            targetdt = 2.0 * domain.deltatime / 3.0;
        }

        if (targetdt < domain.deltatime) {
            domain.deltatime = targetdt;
        }

        domain.time += domain.deltatime;

        ++domain.cycle;
    }

    protected def lagrangeLeapFrog(domain:Domain) {
        lagrangeNodal(domain);

        lagrangeElements(domain);
/*
        @Ifdef("SEDOV_SYNC_POS_VEL_LATE") {
        commRecv(domain, MSG_SYNC_POS_VEL, 6,
                domain.sizeX() + 1, domain.sizeY() + 1, domain.sizeZ() + 1,
                false, false);

        val fieldData:Rail[Rail[Double]] = new Rail[Rail[Double]](6);
        fieldData(0) = domain.x;
        fieldData(1) = domain.y;
        fieldData(2) = domain.z;
        fieldData(3) = domain.xd;
        fieldData(4) = domain.yd;
        fieldData(5) = domain.zd;

        commSend(domain, MSG_SYNC_POS_VEL, 6, fieldData,
                domain.sizeX() + 1, domain.sizeY() + 1, domain.sizeZ() + 1,
                false, false);
        }
*/

        calcTimeConstraintsForElems(domain);
/*
        @Ifdef("SEDOV_SYNC_POS_VEL_LATE") {
        commSyncPosVel(domain);
        }
*/
    }

    /**
     * Calculate nodal forces, accelerations, velocities, positions, with
     * applied boundary conditions and slide surface considerations 
     */
    protected def lagrangeNodal(domain:Domain) {
        val delt = domain.deltatime;
        var u_cut:Double = domain.u_cut;

        // time of boundary condition evaluation is beginning of step for force 
        // and acceleration boundary conditions. 
        calcForceForNodes(domain);

/*
        @Ifdef("SEDOV_SYNC_POS_VEL_EARLY") {
        CommRecv(domain, MSG_SYNC_POS_VEL, 6,
                domain.sizeX() + 1, domain.sizeY() + 1, domain.sizeZ() + 1,
                false, false);
        }
*/

        calcAccelerationForNodes(domain);

        applyAccelerationBoundaryConditionsForNodes(domain);

        calcVelocityForNodes(domain, delt, u_cut);

        calcPositionForNodes(domain, delt);

/*
        @Ifdef("SEDOV_SYNC_POS_VEL_EARLY") {
        val fieldData:Rail[Rail[Double]] = new Rail[Rail[Double]](6);
        fieldData(0) = domain.x;
        fieldData(1) = domain.y;
        fieldData(2) = domain.z;
        fieldData(3) = domain.xd;
        fieldData(4) = domain.yd;
        fieldData(5) = domain.zd;


        CommSend(domain, MSG_SYNC_POS_VEL, 6, fieldData,
                domain.sizeX() + 1, domain.sizeY() + 1, domain.sizeZ() + 1,
                false, false);

        CommSyncPosVel(domain);
        }
 */
    }

    /**
     * Calculate element quantities (i.e. velocity gradient & q), and update
     * material states 
     */
    protected def lagrangeElements(domain:Domain) {
        val vnew = new Rail[Double](domain.numElem); // new relative vol -- temp

        calcLagrangeElements(domain, vnew);

        calcQForElems(domain, vnew);

        applyMaterialPropertiesForElems(domain, vnew);

        updateVolumesForElems(domain, vnew, domain.v_cut, domain.numElem);
    }

    def calcTimeConstraintsForElems(domain:Domain) {
        for (r in 0..(domain.numReg-1)) {
            /* evaluate time constraint */
            calcCourantConstraintForElems(domain, domain.regElemSize(r),
                                    domain.regElemList(r));

            /* check hydro constraint */
            calcHydroConstraintForElems(domain, domain.regElemSize(r),
                                    domain.regElemList(r));
        }
    }

    protected def calcForceForNodes(domain:Domain) {
/*
        CommRecv(domain, MSG_COMM_SBN, 3,
               domain.sizeX() + 1, domain.sizeY() + 1, domain.sizeZ() + 1,
               true, false);
*/
        // TODO parallel loop
        for (i in 0..(domain.numNode-1)) {
            domain.fx(i) = 0.0;
            domain.fy(i) = 0.0;
            domain.fz(i) = 0.0;
        }

        calcVolumeForceForElems(domain);
/*
        Domain_member fieldData(3);
        fieldData(0) = &Domain::fx;
        fieldData(1) = &Domain::fy;
        fieldData(2) = &Domain::fz;

        CommSend(domain, MSG_COMM_SBN, 3, fieldData,
               domain.sizeX() + 1, domain.sizeY() + 1, domain.sizeZ() +  1,
               true, false);
        CommSBN(domain, 3, fieldData);
*/
    }

    /** Calcforce calls partial, force, hourq */
    protected def calcVolumeForceForElems(domain:Domain) {
        val numElem = domain.numElem;
        if (numElem != 0) {
            val hgcoef = domain.hgcoef;
            val sigxx  = new Rail[Double](numElem);
            val sigyy  = new Rail[Double](numElem);
            val sigzz  = new Rail[Double](numElem);
            val determ = new Rail[Double](numElem);

            initStressTermsForElems(domain, sigxx, sigyy, sigzz, numElem);

            integrateStressForElems(domain, sigxx, sigyy, sigzz, determ, numElem,
                                    domain.numNode);

            // check for negative element volume
            // TODO parallel loop
            for (k in 0..(numElem-1)) {
                if (determ(k) <= 0.0) {
                    throw new VolumeException(k, determ(k));
                }
            }

            calcHourglassControlForElems(domain, determ, hgcoef);
        }
    }

    /** Sum contributions to total stress tensor */
    protected def initStressTermsForElems(domain:Domain, sigxx:Rail[Double], 
                                sigyy:Rail[Double], sigzz:Rail[Double],
                                numElem:Long) {
        // pull in the stresses appropriate to the hydro integration

        // TODO parallel loop
        for (i in 0..(numElem-1)) {
            sigxx(i) = sigyy(i) = sigzz(i) = -domain.p(i) - domain.q(i);
        }
    }

    /** 
     * call elemlib stress integration loop to produce nodal forces from
     * material stresses.
     */
    def integrateStressForElems(domain:Domain, sigxx:Rail[Double], 
                                sigyy:Rail[Double], sigzz:Rail[Double],
                                determ:Rail[Double], numElem:Long, 
                                numNode:Long) {

        val numElem8 = numElem * 8;
        @StackAllocate val fx_local = @StackAllocate new Rail[Double](8);
        @StackAllocate val fy_local = @StackAllocate new Rail[Double](8);
        @StackAllocate val fz_local = @StackAllocate new Rail[Double](8);

        // TODO parallel loop
        for (k in 0..(numElem-1)) {
            val B = new Array_2[Double](3, 8); // shape function derivatives
            @StackAllocate val x_local = @StackAllocate new Rail[Double](8);
            @StackAllocate val y_local = @StackAllocate new Rail[Double](8);
            @StackAllocate val z_local = @StackAllocate new Rail[Double](8);

            collectDomainNodesToElemNodes(domain, k, x_local, y_local, z_local);

            determ(k) = calcElemShapeFunctionDerivatives(x_local, y_local, 
                                                         z_local, B);

            calcElemNodeNormals(B, x_local, y_local, z_local);

            sumElemStressesToNodeForces(B, sigxx(k), sigyy(k), sigzz(k),
                                        fx_local, fy_local, fz_local);

            // copy nodal force contributions to global force arrray.
            for (lnode in 0..7) {
                val gnode = domain.nodeList(k*8 + lnode);
                domain.fx(gnode) += fx_local(lnode);
                domain.fy(gnode) += fy_local(lnode);
                domain.fz(gnode) += fz_local(lnode);
            }
        }
    }

    /**
     * Volume calculation involves extra work for numerical consistency 
     * @return jacobian determinant (volume)
     */
    protected @Inline def calcElemShapeFunctionDerivatives(
                            x:Rail[Double], y:Rail[Double], z:Rail[Double],
                            b:Array_2[Double]):Double {
        val x0 = x(0);   val x1 = x(1);
        val x2 = x(2);   val x3 = x(3);
        val x4 = x(4);   val x5 = x(5);
        val x6 = x(6);   val x7 = x(7);

        val y0 = y(0);   val y1 = y(1);
        val y2 = y(2);   val y3 = y(3);
        val y4 = y(4);   val y5 = y(5);
        val y6 = y(6);   val y7 = y(7);

        val z0 = z(0);   val z1 = z(1);
        val z2 = z(2);   val z3 = z(3);
        val z4 = z(4);   val z5 = z(5);
        val z6 = z(6);   val z7 = z(7);

        val fjxxi = 0.125 * ( (x6-x0) + (x5-x4) - (x7-x2) - (x4-x3) );
        val fjxet = 0.125 * ( (x6-x0) - (x5-x4) + (x7-x2) - (x4-x3) );
        val fjxze = 0.125 * ( (x6-x0) + (x5-x4) + (x7-x2) + (x4-x3) );

        val fjyxi = 0.125 * ( (y6-y0) + (y5-y4) - (y7-y2) - (y4-y3) );
        val fjyet = 0.125 * ( (y6-y0) - (y5-y4) + (y7-y2) - (y4-y3) );
        val fjyze = 0.125 * ( (y6-y0) + (y5-y4) + (y7-y2) + (y4-y3) );

        val fjzxi = 0.125 * ( (z6-z0) + (z5-z4) - (z7-z2) - (z4-z3) );
        val fjzet = 0.125 * ( (z6-z0) - (z5-z4) + (z7-z2) - (z4-z3) );
        val fjzze = 0.125 * ( (z6-z0) + (z5-z4) + (z7-z2) + (z4-z3) );

        // compute cofactors
        val cjxxi =    (fjyet * fjzze) - (fjzet * fjyze);
        val cjxet =  - (fjyxi * fjzze) + (fjzxi * fjyze);
        val cjxze =    (fjyxi * fjzet) - (fjzxi * fjyet);

        val cjyxi =  - (fjxet * fjzze) + (fjzet * fjxze);
        val cjyet =    (fjxxi * fjzze) - (fjzxi * fjxze);
        val cjyze =  - (fjxxi * fjzet) + (fjzxi * fjxet);

        val cjzxi =    (fjxet * fjyze) - (fjyet * fjxze);
        val cjzet =  - (fjxxi * fjyze) + (fjyxi * fjxze);
        val cjzze =    (fjxxi * fjyet) - (fjyxi * fjxet);

        // calculate partials :
        // this need only be done for l = 0,1,2,3   since , by symmetry ,
        // (6,7,4,5) = - (0,1,2,3) .
        b(0,0) =   -  cjxxi  -  cjxet  -  cjxze;
        b(0,1) =      cjxxi  -  cjxet  -  cjxze;
        b(0,2) =      cjxxi  +  cjxet  -  cjxze;
        b(0,3) =   -  cjxxi  +  cjxet  -  cjxze;
        b(0,4) = -b(0,2);
        b(0,5) = -b(0,3);
        b(0,6) = -b(0,0);
        b(0,7) = -b(0,1);

        b(1,0) =   -  cjyxi  -  cjyet  -  cjyze;
        b(1,1) =      cjyxi  -  cjyet  -  cjyze;
        b(1,2) =      cjyxi  +  cjyet  -  cjyze;
        b(1,3) =   -  cjyxi  +  cjyet  -  cjyze;
        b(1,4) = -b(1,2);
        b(1,5) = -b(1,3);
        b(1,6) = -b(1,0);
        b(1,7) = -b(1,1);

        b(2,0) =   -  cjzxi  -  cjzet  -  cjzze;
        b(2,1) =      cjzxi  -  cjzet  -  cjzze;
        b(2,2) =      cjzxi  +  cjzet  -  cjzze;
        b(2,3) =   -  cjzxi  +  cjzet  -  cjzze;
        b(2,4) = -b(2,2);
        b(2,5) = -b(2,3);
        b(2,6) = -b(2,0);
        b(2,7) = -b(2,1);

        return 8.0 * (fjxet * cjxet + fjyet * cjyet + fjzet * cjzet);
    }

    @Inline def calcElemNodeNormals(pf:Array_2[Double],
                    x:Rail[Double], y:Rail[Double], z:Rail[Double]) {
        pf.clear();
        sumElemFaceNormal(pf, 0, 1, 2, 3, x, y, z);
        sumElemFaceNormal(pf, 0, 4, 5, 1, x, y, z);
        sumElemFaceNormal(pf, 1, 5, 6, 2, x, y, z);
        sumElemFaceNormal(pf, 2, 6, 7, 3, x, y, z);
        sumElemFaceNormal(pf, 3, 7, 4, 0, x, y, z);
        sumElemFaceNormal(pf, 4, 7, 6, 5, x, y, z);
    }

    private @Inline def sumElemFaceNormal(pf:Array_2[Double],
                            i:Long, j:Long, k:Long, l:Long,
                            x:Rail[Double], y:Rail[Double], z:Rail[Double]) {

        val bisectX0 = 0.5 * (x(l) + x(k) - x(j) - x(i));
        val bisectY0 = 0.5 * (y(l) + y(k) - y(j) - y(i));
        val bisectZ0 = 0.5 * (z(l) + z(k) - z(j) - z(i));
        val bisectX1 = 0.5 * (x(k) + x(j) - x(l) - x(i));
        val bisectY1 = 0.5 * (y(k) + y(j) - y(l) - y(i));
        val bisectZ1 = 0.5 * (z(k) + z(j) - z(l) - z(i));
        val areaX = 0.25 * (bisectY0 * bisectZ1 - bisectZ0 * bisectY1);
        val areaY = 0.25 * (bisectZ0 * bisectX1 - bisectX0 * bisectZ1);
        val areaZ = 0.25 * (bisectX0 * bisectY1 - bisectY0 * bisectX1);

        pf(0,i) += areaX;
        pf(0,j) += areaX;
        pf(0,k) += areaX;
        pf(0,l) += areaX;

        pf(1,i) += areaY;
        pf(1,j) += areaY;
        pf(1,k) += areaY;
        pf(1,l) += areaY;

        pf(2,i) += areaZ;
        pf(2,j) += areaZ;
        pf(2,k) += areaZ;
        pf(2,l) += areaZ;
    }

    private @Inline def sumElemStressesToNodeForces(B:Array_2[Double],
                            stress_xx:Double, stress_yy:Double, stress_zz:Double,
                            fx:Rail[Double], fy:Rail[Double], fz:Rail[Double]) {
        for(i in 0..7) {
            fx(i) = -( stress_xx * B(0,i) );
            fy(i) = -( stress_yy * B(1,i) );
            fz(i) = -( stress_zz * B(2,i) );
        }
    }

    private def calcHourglassControlForElems(domain:Domain,
                                     determ:Rail[Double], hgcoef:Double) {
        val numElem = domain.numElem;
        val numElem8 = numElem * 8;
        val dvdx = new Rail[Double](numElem8);
        val dvdy = new Rail[Double](numElem8);
        val dvdz = new Rail[Double](numElem8);
        val x8n  = new Rail[Double](numElem8);
        val y8n  = new Rail[Double](numElem8);
        val z8n  = new Rail[Double](numElem8);

        // TODO parallel loop
        for (i in 0..(numElem-1)) {
            @StackAllocate val x1 = @StackAllocate new Rail[Double](8);
            @StackAllocate val y1 = @StackAllocate new Rail[Double](8);
            @StackAllocate val z1 = @StackAllocate new Rail[Double](8);
            @StackAllocate val pfx = @StackAllocate new Rail[Double](8);
            @StackAllocate val pfy = @StackAllocate new Rail[Double](8);
            @StackAllocate val pfz = @StackAllocate new Rail[Double](8);

            collectDomainNodesToElemNodes(domain, i, x1, y1, z1);

            calcElemVolumeDerivative(pfx, pfy, pfz, x1, y1, z1);

            /* load into temporary storage for FB Hour Glass control */
            for(ii in 0..7){
                val jj = 8*i+ii;

                dvdx(jj) = pfx(ii);
                dvdy(jj) = pfy(ii);
                dvdz(jj) = pfz(ii);
                x8n(jj)  = x1(ii);
                y8n(jj)  = y1(ii);
                z8n(jj)  = z1(ii);
            }

            determ(i) = domain.volo(i) * domain.v(i);

            /* Do a check for negative volumes */
            if (domain.v(i) <= 0.0) {
                throw new VolumeException(i, domain.v(i));
            }
        }

        if (hgcoef > 0.0) {
            calcFBHourglassForceForElems(domain,
                                        determ, x8n, y8n, z8n, dvdx, dvdy, dvdz,
                                        hgcoef, numElem, domain.numNode);
        }
    }

    def calcElemVolumeDerivative(dvdx:Rail[Double],
                                 dvdy:Rail[Double],
                                 dvdz:Rail[Double],
                                 x:Rail[Double],
                                 y:Rail[Double],
                                 z:Rail[Double]) {
        voluDer(x, y, z, 1, 2, 3, 4, 5, 7, dvdx, dvdy, dvdz, 0);
        voluDer(x, y, z, 0, 1, 2, 7, 4, 6, dvdx, dvdy, dvdz, 3);
        voluDer(x, y, z, 3, 0, 1, 6, 7, 5, dvdx, dvdy, dvdz, 2);
        voluDer(x, y, z, 2, 3, 0, 5, 6, 4, dvdx, dvdy, dvdz, 1);
        voluDer(x, y, z, 7, 6, 5, 0, 3, 1, dvdx, dvdy, dvdz, 4);
        voluDer(x, y, z, 4, 7, 6, 1, 0, 2, dvdx, dvdy, dvdz, 5);
        voluDer(x, y, z, 5, 4, 7, 2, 1, 3, dvdx, dvdy, dvdz, 6);
        voluDer(x, y, z, 6, 5, 4, 3, 2, 1, dvdx, dvdy, dvdz, 7);
    }

    def voluDer(x:Rail[Double], y:Rail[Double], z:Rail[Double],
        i:Long, j:Long, k:Long, l:Long, m:Long, n:Long,
        dvdx:Rail[Double], dvdy:Rail[Double], dvdz:Rail[Double], ii:Long) {

        dvdx(ii) =   (y(j) + y(k)) * (z(i) + z(j)) - (y(i) + y(j)) * (z(j) + z(k))
                   + (y(i) + y(m)) * (z(l) + z(m)) - (y(l) + y(m)) * (z(i) + z(m))
                   - (y(k) + y(n)) * (z(l) + z(n)) + (y(l) + y(n)) * (z(k) + z(n));

        dvdy(ii) = - (x(j) + x(k)) * (z(i) + z(j)) + (x(i) + x(j)) * (z(j) + z(k))
                   - (x(i) + x(m)) * (z(l) + z(m)) + (x(l) + x(m)) * (z(i) + z(m))
                   + (x(k) + x(n)) * (z(l) + z(n)) - (x(l) + x(n)) * (z(k) + z(n));

        dvdz(ii) = - (y(j) + y(k)) * (x(i) + x(j)) + (y(i) + y(j)) * (x(j) + x(k))
                   - (y(i) + y(m)) * (x(l) + x(m)) + (y(l) + y(m)) * (x(i) + x(m))
                   + (y(k) + y(n)) * (x(l) + x(n)) - (y(l) + y(n)) * (x(k) + x(n));

        val twelfth = 1.0 / 12.0;
        dvdx(ii) *= twelfth;
        dvdy(ii) *= twelfth;
        dvdz(ii) *= twelfth;
    }

    /** Calculates the Flanagan-Belytschko anti-hourglass force. */
    def calcFBHourglassForceForElems(domain:Domain,
           determ:Rail[Double],
           x8n:Rail[Double], y8n:Rail[Double], z8n:Rail[Double],
           dvdx:Rail[Double], dvdy:Rail[Double], dvdz:Rail[Double],
           hourg:Double, numElem:Long,
           numNode:Long) {

        val numElem8 = numElem * 8;

        val gamma = new Array_2[Double](4,8);

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

        // compute the hourglass modes

        // TODO these should be stack-allocated inside the loop over i2
        val hourgam = new Array_2[Double](4,8);
        val xd1 = new Rail[Double](8);
        val yd1 = new Rail[Double](8);
        val zd1 = new Rail[Double](8);
        val hgfx = new Rail[Double](8);
        val hgfy = new Rail[Double](8);
        val hgfz = new Rail[Double](8);
        // TODO parallel loop
        for(i2 in 0..(numElem-1)) {
            val i3 = 8*i2;
            val volinv = 1.0 / determ(i2);
            for (i1 in 0..3) {
                val hourmodx =
                    x8n(i3)   * gamma(i1,0) + x8n(i3+1) * gamma(i1,1) +
                    x8n(i3+2) * gamma(i1,2) + x8n(i3+3) * gamma(i1,3) +
                    x8n(i3+4) * gamma(i1,4) + x8n(i3+5) * gamma(i1,5) +
                    x8n(i3+6) * gamma(i1,6) + x8n(i3+7) * gamma(i1,7);

                val hourmody =
                    y8n(i3)   * gamma(i1,0) + y8n(i3+1) * gamma(i1,1) +
                    y8n(i3+2) * gamma(i1,2) + y8n(i3+3) * gamma(i1,3) +
                    y8n(i3+4) * gamma(i1,4) + y8n(i3+5) * gamma(i1,5) +
                    y8n(i3+6) * gamma(i1,6) + y8n(i3+7) * gamma(i1,7);

                val hourmodz =
                    z8n(i3)   * gamma(i1,0) + z8n(i3+1) * gamma(i1,1) +
                    z8n(i3+2) * gamma(i1,2) + z8n(i3+3) * gamma(i1,3) +
                    z8n(i3+4) * gamma(i1,4) + z8n(i3+5) * gamma(i1,5) +
                    z8n(i3+6) * gamma(i1,6) + z8n(i3+7) * gamma(i1,7);

                hourgam(0,i1) = gamma(i1,0) - volinv*(dvdx(i3  ) * hourmodx +
                                                      dvdy(i3  ) * hourmody +
                                                      dvdz(i3  ) * hourmodz );

                hourgam(1,i1) = gamma(i1,1) - volinv*(dvdx(i3+1) * hourmodx +
                                                      dvdy(i3+1) * hourmody +
                                                      dvdz(i3+1) * hourmodz );

                hourgam(2,i1) = gamma(i1,2) - volinv*(dvdx(i3+2) * hourmodx +
                                                      dvdy(i3+2) * hourmody +
                                                      dvdz(i3+2) * hourmodz );

                hourgam(3,i1) = gamma(i1,3) - volinv*(dvdx(i3+3) * hourmodx +
                                                      dvdy(i3+3) * hourmody +
                                                      dvdz(i3+3) * hourmodz );

                hourgam(4,i1) = gamma(i1,4) - volinv*(dvdx(i3+4) * hourmodx +
                                                      dvdy(i3+4) * hourmody +
                                                      dvdz(i3+4) * hourmodz );

                hourgam(5,i1) = gamma(i1,5) - volinv*(dvdx(i3+5) * hourmodx +
                                                      dvdy(i3+5) * hourmody +
                                                      dvdz(i3+5) * hourmodz );

                hourgam(6,i1) = gamma(i1,6) - volinv*(dvdx(i3+6) * hourmodx +
                                                      dvdy(i3+6) * hourmody +
                                                      dvdz(i3+6) * hourmodz );

                hourgam(7,i1) = gamma(i1,7) - volinv*(dvdx(i3+7) * hourmodx +
                                                      dvdy(i3+7) * hourmody +
                                                      dvdz(i3+7) * hourmodz );
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

            domain.fx(n0si2) += hgfx(0);
            domain.fy(n0si2) += hgfy(0);
            domain.fz(n0si2) += hgfz(0);

            domain.fx(n1si2) += hgfx(1);
            domain.fy(n1si2) += hgfy(1);
            domain.fz(n1si2) += hgfz(1);

            domain.fx(n2si2) += hgfx(2);
            domain.fy(n2si2) += hgfy(2);
            domain.fz(n2si2) += hgfz(2);

            domain.fx(n3si2) += hgfx(3);
            domain.fy(n3si2) += hgfy(3);
            domain.fz(n3si2) += hgfz(3);

            domain.fx(n4si2) += hgfx(4);
            domain.fy(n4si2) += hgfy(4);
            domain.fz(n4si2) += hgfz(4);

            domain.fx(n5si2) += hgfx(5);
            domain.fy(n5si2) += hgfy(5);
            domain.fz(n5si2) += hgfz(5);

            domain.fx(n6si2) += hgfx(6);
            domain.fy(n6si2) += hgfy(6);
            domain.fz(n6si2) += hgfz(6);

            domain.fx(n7si2) += hgfx(7);
            domain.fy(n7si2) += hgfy(7);
            domain.fz(n7si2) += hgfz(7);
        }
    }

    private @Inline def calcElemFBHourglassForce(
                       xd:Rail[Double], yd:Rail[Double], zd:Rail[Double],
                       hourgam:Array_2[Double], coefficient:Double,
                       hgfx:Rail[Double], hgfy:Rail[Double], hgfz:Rail[Double]) {
        @StackAllocate val hxx = @StackAllocate new Rail[Double](4);
        for (i in 0..3) {
            hxx(i) = hourgam(0,i) * xd(0) + hourgam(1,i) * xd(1) +
                     hourgam(2,i) * xd(2) + hourgam(3,i) * xd(3) +
                     hourgam(4,i) * xd(4) + hourgam(5,i) * xd(5) +
                     hourgam(6,i) * xd(6) + hourgam(7,i) * xd(7);
        }
        for (i in 0..7) {
            hgfx(i) = coefficient *
                    (hourgam(i,0) * hxx(0) + hourgam(i,1) * hxx(1) +
                     hourgam(i,2) * hxx(2) + hourgam(i,3) * hxx(3));
        }
        for (i in 0..3) {
            hxx(i) = hourgam(0,i) * yd(0) + hourgam(1,i) * yd(1) +
                     hourgam(2,i) * yd(2) + hourgam(3,i) * yd(3) +
                     hourgam(4,i) * yd(4) + hourgam(5,i) * yd(5) +
                     hourgam(6,i) * yd(6) + hourgam(7,i) * yd(7);
        }
        for (i in 0..7) {
            hgfy(i) = coefficient *
                    (hourgam(i,0) * hxx(0) + hourgam(i,1) * hxx(1) +
                     hourgam(i,2) * hxx(2) + hourgam(i,3) * hxx(3));
        }
        for (i in 0..3) {
            hxx(i) = hourgam(0,i) * zd(0) + hourgam(1,i) * zd(1) +
                     hourgam(2,i) * zd(2) + hourgam(3,i) * zd(3) +
                     hourgam(4,i) * zd(4) + hourgam(5,i) * zd(5) +
                     hourgam(6,i) * zd(6) + hourgam(7,i) * zd(7);
        }
        for (i in 0..7) {
            hgfz(i) = coefficient *
                    (hourgam(i,0) * hxx(0) + hourgam(i,1) * hxx(1) +
                     hourgam(i,2) * hxx(2) + hourgam(i,3) * hxx(3));
        }
    }

    def calcAccelerationForNodes(domain:Domain) {

    }

    def applyAccelerationBoundaryConditionsForNodes(domain:Domain) {

    }

    def calcVelocityForNodes(domain:Domain, dt:Double, u_cut:Double) {

    }

    def calcPositionForNodes(domain:Domain, dt:Double) {

    }

    def calcLagrangeElements(domain:Domain, vnew:Rail[Double]) {

    }

    /** Calculate Q.  (Monotonic q option requires communication) */
    def calcQForElems(domain:Domain, vnew:Rail[Double]) {

    }

    def applyMaterialPropertiesForElems(domain:Domain, vnew:Rail[Double]) {

    }

    def updateVolumesForElems(domain:Domain, vnew:Rail[Double], 
                              v_cut:Double, length:Long) {

    }

    def calcCourantConstraintForElems(domain:Domain, length:Long, regElemList:Rail[Long]) {
        val qqc2 = 64.0 * domain.qqc * domain.qqc;
        var dtcourant_tmp:Double = domain.dtcourant;
        var courant_elem:Long  = -1;    

        // TODO parallel reduction
        for (i in 0..(length-1)) {
            val indx = regElemList(i);
            var dtf:Double = domain.ss(indx) * domain.ss(indx);

            if (domain.vdov(indx) < 0.0) {
                dtf = dtf
                + qqc2 * domain.arealg(indx) * domain.arealg(indx)
                * domain.vdov(indx) * domain.vdov(indx);
            }

            dtf = sqrt(dtf);
            dtf = domain.arealg(indx) / dtf;

            if (domain.vdov(indx) != 0.0) {
                if (dtf < dtcourant_tmp) {
                    dtcourant_tmp = dtf;
                    courant_elem  = indx;
                }
            }
        }

        if (courant_elem != -1) {
          domain.dtcourant = dtcourant_tmp;
        }
    }

    def calcHydroConstraintForElems(domain:Domain, length:Long, regElemList:Rail[Long]) {
        var dthydro_tmp:Double = domain.dtcourant;
        var hydro_elem:Long  = -1;

        // TODO parallel reduction
        for (i in 0..(length-1)) {
            val indx = regElemList(i);

            if (domain.vdov(indx) != 0.0) {
                val dtdvov = domain.dvovmax / (Math.abs(domain.vdov(indx))+1.0e-20);

                if (dthydro_tmp > dtdvov) {
                    dthydro_tmp = dtdvov;
                    hydro_elem  = indx;
                }
            }
        }

        if (hydro_elem != -1) {
          domain.dthydro = dthydro_tmp;
        }
    }

    def verifyAndWriteFinalOutput(elapsedTime:Double, 
                                         domain:Domain, nx:Long) {
        // GrindTime1 only takes a single domain into account, and is thus a good way to measure
        // processor speed independent of multi-place parallelism.
        // GrindTime2 takes into account speedups from multi-place parallelism 
        val grindTime1 = ((elapsedTime*1e6)/domain.cycle)/(nx*nx*nx);
        val grindTime2 = ((elapsedTime*1e6)/domain.cycle)/(nx*nx*nx*Place.MAX_PLACES);

        var ElemId:Long = 0;
        Console.OUT.printf("Run completed:  \n");
        Console.OUT.printf("   Problem size        =  %i \n",    nx);
        Console.OUT.printf("   Place.MAX_PLACES    =  %i \n",    Place.MAX_PLACES);
        Console.OUT.printf("   Iteration count     =  %i \n",    domain.cycle);
        Console.OUT.printf("   Final Origin Energy = %12.6e \n", domain.e(ElemId));

        var maxAbsDiff:Double = 0.0;
        var totalAbsDiff:Double = 0.0;
        var maxRelDiff:Double = 0.0;

        for (j in 0..(nx-1)) {
            for (k in (j+1)..(nx-1)) {
                val absDiff = Math.abs(domain.e(j*nx+k) - domain.e(k*nx+j));
                totalAbsDiff += absDiff;

                if (maxAbsDiff < absDiff) maxAbsDiff = absDiff;

                val relDiff = absDiff / domain.e(k*nx+j);

                if (maxRelDiff < relDiff)  maxRelDiff = relDiff;
            }
        }

        // Quick symmetry check
        Console.OUT.println("   Testing Plane 0 of Energy Array at " + here);
        Console.OUT.printf("        maxAbsDiff   = %12.6e\n",   maxAbsDiff  );
        Console.OUT.printf("        totalAbsDiff = %12.6e\n",   totalAbsDiff);
        Console.OUT.printf("        maxRelDiff   = %12.6e\n\n", maxRelDiff  );

        // Timing information
        Console.OUT.printf("\nElapsed time         = %10.2f (s)\n", elapsedTime);
        Console.OUT.printf("Grind time (us/z/c)  = %10.8g (per dom)  (%10.8g overall)\n", grindTime1, grindTime2);
        Console.OUT.printf("FOM                  = %10.8g (z/s)\n\n", 1000.0/grindTime2); // zones per second
    }

    /** get nodal coordinates from global arrays and copy into local arrays */
    @Inline def collectDomainNodesToElemNodes(domain:Domain,
                                   elemIdx:Long,
                                   elemX:Rail[Double],
                                   elemY:Rail[Double],
                                   elemZ:Rail[Double]) {
        val nd0i = domain.nodeList(elemIdx*8+0);
        val nd1i = domain.nodeList(elemIdx*8+1);
        val nd2i = domain.nodeList(elemIdx*8+2);
        val nd3i = domain.nodeList(elemIdx*8+3);
        val nd4i = domain.nodeList(elemIdx*8+4);
        val nd5i = domain.nodeList(elemIdx*8+5);
        val nd6i = domain.nodeList(elemIdx*8+6);
        val nd7i = domain.nodeList(elemIdx*8+7);

        elemX(0) = domain.x(nd0i);
        elemX(1) = domain.x(nd1i);
        elemX(2) = domain.x(nd2i);
        elemX(3) = domain.x(nd3i);
        elemX(4) = domain.x(nd4i);
        elemX(5) = domain.x(nd5i);
        elemX(6) = domain.x(nd6i);
        elemX(7) = domain.x(nd7i);

        elemY(0) = domain.y(nd0i);
        elemY(1) = domain.y(nd1i);
        elemY(2) = domain.y(nd2i);
        elemY(3) = domain.y(nd3i);
        elemY(4) = domain.y(nd4i);
        elemY(5) = domain.y(nd5i);
        elemY(6) = domain.y(nd6i);
        elemY(7) = domain.y(nd7i);

        elemZ(0) = domain.z(nd0i);
        elemZ(1) = domain.z(nd1i);
        elemZ(2) = domain.z(nd2i);
        elemZ(3) = domain.z(nd3i);
        elemZ(4) = domain.z(nd4i);
        elemZ(5) = domain.z(nd5i);
        elemZ(6) = domain.z(nd6i);
        elemZ(7) = domain.z(nd7i);
    }

    @Inline private static def sqrt(arg:float) { return Math.sqrtf(arg); }
    @Inline private static def sqrt(arg:double) { return Math.sqrt(arg); }
}

// Precision specification
public static type Real_t = Double; // floating point representation

// vim:tabstop=4:shiftwidth=4:expandtab
