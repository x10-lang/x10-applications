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

import x10.compiler.Ifdef;
import x10.compiler.Inline;
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
        finish for(place in PlaceGroup.WORLD) at(place) async {
            val domain = domainPlh();

            // Initial domain boundary communication 
            // TODO

            val start = Timer.milliTime();

            //debug to see region sizes
            //for(var i:Long = 0; i < domain.numReg; i++)
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

    def calcForceForNodes(domain:Domain) {

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
                val dtdvov = domain.dvovmax / (Math.abs(domain.vdov(indx))+1.0e-20) ;

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

    @Inline private static def sqrt(arg:float) { return Math.sqrtf(arg); }
    @Inline private static def sqrt(arg:double) { return Math.sqrt(arg); }
}

// Precision specification
public static type Real_t = Double; // floating point representation

// vim:tabstop=4:shiftwidth=4:expandtab
