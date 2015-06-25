/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2014-2015.
 */

import x10.array.Array_2;
import x10.compiler.Foreach;
import x10.compiler.Ifdef;
import x10.compiler.Inline;
import x10.compiler.StackAllocate;
import x10.compiler.StackAllocateUninitialized;
import x10.util.Team;
import x10.util.Timer;

/** 
 * X10 implementation of the LULESH proxy app, based on LULESH version 2.0.3.
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
public final class Lulesh {
    static PRINT_COMM_TIME = false;

    /** The simulation domain at each place. */
    protected val domainPlh:PlaceLocalHandle[Domain];

    /** Manager for nodal mass updates between all neighbors */
    protected val massGhostMgr:GhostManager;
    /** Manager for positions and velocity updates between all neighbors */
    protected val posVelGhostMgr:GhostManager;
    /** Manager for force updates between all neighbors */
    protected val forceGhostMgr:GhostManager;
    /** Manager for position gradient updates between plane neighbors */
    protected val gradientGhostMgr:GhostManager;

    static val NUM_LOOPS = 38;
    /** Time (in ns) spent executing each of the parallel loops in LULESH. */
    static val loopTimes = new Rail[Long](NUM_LOOPS);
    private @Inline def startLoop(i:Long) {
@Ifdef("__RECORD_LOOP_TIMES__") {
        loopTimes(i) -= Timer.nanoTime();
}
    }
    private @Inline def endLoop(i:Long) {
@Ifdef("__RECORD_LOOP_TIMES__") {
        loopTimes(i) += Timer.nanoTime();
}
    }

    private static val EXIT_CODE_INCORRECT_USAGE = 2n;

    public static def main(args:Rail[String]) {
        val placesPerSide = Math.cbrt((Place.numPlaces() as Double) + 0.5) as Int;
        if  (placesPerSide*placesPerSide*placesPerSide != Place.numPlaces() as Int) {
            Console.ERR.println("Num processors must be a cube of an integer (1, 8, 27, ...)");
            System.setExitCode(EXIT_CODE_INCORRECT_USAGE);
            return;
        }

        val opts = CommandLineOptions.parse(args);
        if (opts == null) {
            System.setExitCode(EXIT_CODE_INCORRECT_USAGE);
            return;
        }

        if (!opts.quiet) {
            Console.OUT.printf("Running problem size %d^3 per domain until completion\n", opts.nx);
            Console.OUT.printf("Num places: %d\n", Place.numPlaces());
            Console.OUT.printf("Num threads: %d\n", x10.xrx.Runtime.NTHREADS);
            Console.OUT.printf("Total number of elements: %d\n\n", Place.numPlaces()*opts.nx*opts.nx*opts.nx);
            Console.OUT.printf("To run other sizes, use -s <integer>.\n");
            Console.OUT.printf("To run a fixed number of iterations, use -i <integer>.\n");
            Console.OUT.printf("To run a more or less balanced region set, use -b <integer>.\n");
            Console.OUT.printf("To change the relative costs of regions, use -c <integer>.\n");
            Console.OUT.printf("To print out progress, use -p\n");
            Console.OUT.printf("To write an output file for VisIt, use -v\n");
            Console.OUT.printf("See help (-h) for more options\n\n");
        }

        new Lulesh(opts, placesPerSide).run(opts);
    }

    public def this(opts:CommandLineOptions, placesPerSide:Int) {
        val domainPlh = PlaceLocalHandle.make[Domain](Place.places(), 
            () => new Domain(opts.nx, opts.numReg, opts.balance, opts.cost, placesPerSide));
        this.domainPlh = domainPlh;

        // initialize ghost updates
        this.massGhostMgr = new GhostManager(
                () => domainPlh().loc.createNeighborList(false, true, true),
                () => domainPlh().loc.createNeighborList(false, true, true));
        this.posVelGhostMgr = new GhostManager(
                () => domainPlh().loc.createNeighborList(false, false, true),
                () => domainPlh().loc.createNeighborList(false, true, false));
        this.forceGhostMgr = new GhostManager(
                () => domainPlh().loc.createNeighborList(false, true, true),
                () => domainPlh().loc.createNeighborList(false, true, true));
        this.gradientGhostMgr = new GhostManager(
                () => domainPlh().loc.createNeighborList(true, true, true),
                () => domainPlh().loc.createNeighborList(true, true, true));
    }

    public def run(opts:CommandLineOptions) {
        finish for (place in Place.places()) at(place) async {
            val domain = domainPlh();

            if (PRINT_COMM_TIME) {
                printLoadImbalance(domain);
            }

            val nodesPerSide = domain.sizeX+1;
            val accessMass = (dom:Domain) => [dom.nodalMass];
            massGhostMgr.gatherBoundariesToCombine(domainPlh, accessMass, nodesPerSide); 
            massGhostMgr.waitAndCombineBoundaries(domainPlh, accessMass, nodesPerSide);

            Team.WORLD.barrier();

            val start = Timer.milliTime();

            //debug to see region sizes
            //for (var i:Long = 0; i < domain.numReg; i++)
            //    Console.OUT.println("region " + (i + 1) + " size " + domain.regElemSize(i));

            while((domain.time < domain.stopTime) && (domain.cycle < opts.its)) {
                timeIncrement(domain);

                lagrangeLeapFrog(domain);

                if (opts.showProg && !opts.quiet && here.equals(Place.FIRST_PLACE)) {
                    Console.OUT.printf("cycle = %d, time = %e, dt=%e\n",
                        domain.cycle, domain.time, domain.deltatime);
                }
            }

            val elapsedTimeMillis = Timer.milliTime() - start;
            domain.elapsedTimeMillis = Team.WORLD.allreduce(elapsedTimeMillis, Team.MAX);

            if (PRINT_COMM_TIME) {
                val printGhostManager = (name:String, mgr:GhostManager) => {
                    Console.OUT.printf("%d %10s ghosts wait %4d (ms) process %4d (ms) send %4d (ms)\n", here.id, name, mgr.localState().waitTime, mgr.localState().processTime, mgr.localState().sendTime);
                };
                printGhostManager("pos/vel", posVelGhostMgr);
                printGhostManager("force", forceGhostMgr);
                printGhostManager("gradient", gradientGhostMgr);
                Console.OUT.printf("%d allreduce %4d (ms)\n", here.id, domain.allreduceTime);
            }
        } // at(place) async

        val elapsedTime = (domainPlh().elapsedTimeMillis) / 1e3;
        verifyAndWriteFinalOutput(elapsedTime, domainPlh());

@Ifdef("__RECORD_LOOP_TIMES__") {
        Console.OUT.println("### Loop times (in microseconds) ###");
        for (i in 0..(NUM_LOOPS-1)) {
            Console.OUT.printf("%3ld %8ld\n", i, loopTimes(i) / 1000);
        }
}
    }

    /**
     * Compute and print the load imbalance between places in simulating
     * regions of different materials in applyMaterialPropertiesForElems
     */
    private def printLoadImbalance(domain:Domain) {
        var repTimesNumElem:Int = 0n;
        for (r in 0..(domain.numReg-1)) {
            val numElemReg = domain.regElemSize(r);
            var rep:Int;
            // Determine load imbalance for this region
            // round down the number with lowest cost
            if (r < domain.numReg/2)
                rep = 1n;
            // you don't get an expensive region unless you at least have 5 regions
            else if (r < (domain.numReg - (domain.numReg+15n)/20n))
                rep = 1n + domain.cost;
            // very expensive regions
            else
                rep = 10n * (1n + domain.cost);
            repTimesNumElem += rep * numElemReg;
        }
        val maxLoad = Team.WORLD.reduce(Place.FIRST_PLACE, repTimesNumElem, Team.MAX);
        val totalLoad = Team.WORLD.reduce(Place.FIRST_PLACE, repTimesNumElem, Team.ADD);
        if (here.equals(Place.FIRST_PLACE)) {
            val meanLoad = totalLoad/Place.numPlaces();
            Console.OUT.printf("region load max %d average %d imbalance %f\n", maxLoad, meanLoad, (maxLoad*1.0/meanLoad)-1.0);
        }
    }

    /* Work Routines */

    protected def timeIncrement(domain:Domain) {
        var targetDt:Double = domain.stopTime - domain.time;

        if (domain.dtfixed <= 0.0 && domain.cycle != 0n) {
            var ratio:Double;
            val oldDt = domain.deltatime;

            /* This will require a reduction in parallel */
            var gNewDt:Double = 1.0e+20;
            var newDt:Double;
            if (domain.dtcourant < gNewDt) {
                gNewDt = domain.dtcourant / 2.0;
            }
            if (domain.dthydro < gNewDt) {
                gNewDt = domain.dthydro * 2.0 / 3.0;
            }

            val start = Timer.milliTime();
            newDt = Team.WORLD.allreduce(gNewDt, Team.MIN);
            domain.allreduceTime += Timer.milliTime() - start;

            ratio = newDt / oldDt;
            if (ratio >= 1.0) {
                if (ratio < domain.deltatimemultlb) {
                    newDt = oldDt;
                } else if (ratio > domain.deltatimemultub) {
                    newDt = oldDt * domain.deltatimemultub;
                }
            }

            if (newDt > domain.dtmax) {
                newDt = domain.dtmax;
            }
            domain.deltatime = newDt;
        } else {
            // TODO: without this barrier, fixed timestep can deadlock - why?
            Team.WORLD.barrier();
        }

        /* TRY TO PREVENT VERY SMALL SCALING ON THE NEXT CYCLE */
        if ((targetDt > domain.deltatime) &&
            (targetDt < 4.0 * domain.deltatime / 3.0) ) {
            targetDt = 2.0 * domain.deltatime / 3.0;
        }

        if (targetDt < domain.deltatime) {
            domain.deltatime = targetDt;
        }

        domain.time += domain.deltatime;

        ++domain.cycle;
    }

    protected def lagrangeLeapFrog(domain:Domain) {
        lagrangeNodal(domain);

        lagrangeElements(domain);
@Ifdef("SEDOV_SYNC_POS_VEL_LATE") {

        val nodesPerSide = domain.sizeX+1;
        posVelGhostMgr.updateBoundaryData(domainPlh, 
            (dom:Domain) => [dom.x, dom.y, dom.z, dom.xd, dom.yd, dom.zd],
            nodesPerSide
        );
}

        calcTimeConstraintsForElems(domain);

@Ifdef("SEDOV_SYNC_POS_VEL_LATE") {
        posVelGhostMgr.waitForGhosts();
}
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

        calcAccelerationForNodes(domain);

        applyAccelerationBoundaryConditionsForNodes(domain);

        calcVelocityForNodes(domain, delt, u_cut);

        calcPositionForNodes(domain, delt);

@Ifdef("SEDOV_SYNC_POS_VEL_EARLY") {
        val nodesPerSide = domain.sizeX+1;
        posVelGhostMgr.updateBoundaryData(domainPlh,
            (dom:Domain) => [dom.x, dom.y, dom.z, dom.xd, dom.yd, dom.zd],
            nodesPerSide
        );
        posVelGhostMgr.waitForGhosts();
}
    }

    /**
     * Calculate element quantities (i.e. velocity gradient & q), and update
     * material states.
     */
    protected def lagrangeElements(domain:Domain) {
        val vnew = Unsafe.allocRailUninitialized[Double](domain.numElem); // new relative vol -- temp

        calcLagrangeElements(domain, vnew);

        calcQForElems(domain, vnew);

        applyMaterialPropertiesForElems(domain, vnew);

        updateVolumesForElems(domain, vnew);

        Unsafe.dealloc(vnew);
    }

    def calcTimeConstraintsForElems(domain:Domain) {
        // Initialize conditions to a very large value
        domain.dtcourant = 1.0e+20;
        domain.dthydro = 1.0e+20;

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
startLoop(0);
        domain.fx.clear();
        domain.fy.clear();
        domain.fz.clear();
        /*
        Foreach.block(0, domain.numNode-1, (i:Long)=> {
            domain.fx(i) = 0.0;
            domain.fy(i) = 0.0;
            domain.fz(i) = 0.0;
        });
        */
endLoop(0);

        calcVolumeForceForElems(domain);

        val nodesPerSide = domain.sizeX+1;
        val accessForce = (dom:Domain) => [dom.fx, dom.fy, dom.fz];
        forceGhostMgr.gatherBoundariesToCombine(domainPlh, 
            accessForce,
            nodesPerSide
        );
        forceGhostMgr.waitAndCombineBoundaries(domainPlh, accessForce, nodesPerSide);
    }

    /** Calculate the volume force contribution for each mesh element. */
    protected def calcVolumeForceForElems(domain:Domain) {
        val numElem = domain.numElem;
        if (numElem != 0) {
            val hgcoef = domain.hgcoef;
            val sigxx  = new Rail[Double](numElem);
            val sigyy  = new Rail[Double](numElem);
            val sigzz  = new Rail[Double](numElem);
            val determ = new Rail[Double](numElem);

            initStressTermsForElems(domain, sigxx, sigyy, sigzz);

            integrateStressForElems(domain, sigxx, sigyy, sigzz, determ);

            // check for negative element volume
startLoop(4);
            for (k in 0..(numElem-1)) {
                // TODO parallel loop
                if (determ(k) <= 0.0) {
                    throw new VolumeException(k, determ(k));
                }
            }
endLoop(4);

            calcHourglassControlForElems(domain, determ, hgcoef);

            Unsafe.dealloc(sigxx);
            Unsafe.dealloc(sigyy);
            Unsafe.dealloc(sigzz);
            Unsafe.dealloc(determ);
        }
    }

    /** Sum contributions to total stress tensor */
    protected def initStressTermsForElems(domain:Domain, sigxx:Rail[Double], 
                                sigyy:Rail[Double], sigzz:Rail[Double]) {
        // pull in the stresses appropriate to the hydro integration
startLoop(1);
        Foreach.block(0, domain.numElem-1, (i:Long)=> {
            sigxx(i) = sigyy(i) = sigzz(i) = -domain.p(i) - domain.q(i);
        });
endLoop(1);
    }

    /** 
     * call elemlib stress integration loop to produce nodal forces from
     * material stresses.
     */
    def integrateStressForElems(domain:Domain, sigxx:Rail[Double], 
                                sigyy:Rail[Double], sigzz:Rail[Double],
                                determ:Rail[Double]) {

        val numElem = domain.numElem;
        val numElem8 = numElem * 8;
        val fx_elem = Unsafe.allocRailUninitialized[Double](numElem8);
        val fy_elem = Unsafe.allocRailUninitialized[Double](numElem8);
        val fz_elem = Unsafe.allocRailUninitialized[Double](numElem8);

startLoop(2);
        Foreach.block(0, domain.numElem-1,
        (min_k:Long, max_k:Long) => {
            /** shape function derivatives */
            @StackAllocate val bStore = @StackAllocateUninitialized new Rail[Double](24);
            val B = Array_2.makeView[Double](bStore, 3, 8);
            @StackAllocate val x_local = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val y_local = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val z_local = @StackAllocateUninitialized new Rail[Double](8);

            for (k in min_k..max_k) {
                collectDomainNodesToElemNodes(domain, k, x_local, y_local, z_local);

                determ(k) = calcElemShapeFunctionDerivatives(x_local, y_local, 
                                                             z_local, B);

                calcElemNodeNormals(B, x_local, y_local, z_local);

                sumElemStressesToNodeForces(B, sigxx(k), sigyy(k), sigzz(k),
                                            fx_elem, fy_elem, fz_elem, k);
            }
        });
endLoop(2);

        // copy the data out of the temporary
        // arrays used above into the final forces field
startLoop(3);
        Foreach.block(0, domain.numNode-1,
        (min_g:Long, max_g:Long) => {
            for (gnode in min_g..max_g) {
                val count = domain.nodeElemCount(gnode);
                val elemStart = domain.nodeElemStart(gnode);
                var fx_tmp:Double = 0.0;
                var fy_tmp:Double = 0.0;
                var fz_tmp:Double = 0.0;
                for (i in 0..(count-1)) {
                    val elem = domain.nodeElemCornerList(elemStart+i);
                    fx_tmp += fx_elem(elem);
                    fy_tmp += fy_elem(elem);
                    fz_tmp += fz_elem(elem);
                }
                domain.fx(gnode) = fx_tmp;
                domain.fy(gnode) = fy_tmp;
                domain.fz(gnode) = fz_tmp;
            }
        });
endLoop(3);

        // force GC to reuse space for large temporary arrays
        Unsafe.dealloc(fx_elem);
        Unsafe.dealloc(fy_elem);
        Unsafe.dealloc(fz_elem);
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

        val fjxxi = 0.125 * ( (x6-x0) + (x5-x3) - (x7-x1) - (x4-x2) );
        val fjxet = 0.125 * ( (x6-x0) - (x5-x3) + (x7-x1) - (x4-x2) );
        val fjxze = 0.125 * ( (x6-x0) + (x5-x3) + (x7-x1) + (x4-x2) );

        val fjyxi = 0.125 * ( (y6-y0) + (y5-y3) - (y7-y1) - (y4-y2) );
        val fjyet = 0.125 * ( (y6-y0) - (y5-y3) + (y7-y1) - (y4-y2) );
        val fjyze = 0.125 * ( (y6-y0) + (y5-y3) + (y7-y1) + (y4-y2) );

        val fjzxi = 0.125 * ( (z6-z0) + (z5-z3) - (z7-z1) - (z4-z2) );
        val fjzet = 0.125 * ( (z6-z0) - (z5-z3) + (z7-z1) - (z4-z2) );
        val fjzze = 0.125 * ( (z6-z0) + (z5-z3) + (z7-z1) + (z4-z2) );

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
        // this need only be done for l = 0,1,2,3 since, by symmetry,
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

        val sumElemFaceNormal = (i:Long, j:Long, k:Long, l:Long) => {
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
        };

        sumElemFaceNormal(0, 1, 2, 3);
        sumElemFaceNormal(0, 4, 5, 1);
        sumElemFaceNormal(1, 5, 6, 2);
        sumElemFaceNormal(2, 6, 7, 3);
        sumElemFaceNormal(3, 7, 4, 0);
        sumElemFaceNormal(4, 7, 6, 5);
    }

    private @Inline def sumElemStressesToNodeForces(B:Array_2[Double],
                            stress_xx:Double, stress_yy:Double, stress_zz:Double,
                            fx:Rail[Double], fy:Rail[Double], fz:Rail[Double]) {
        for (i in 0..7) {
            fx(i) = -( stress_xx * B(0,i) );
            fy(i) = -( stress_yy * B(1,i) );
            fz(i) = -( stress_zz * B(2,i) );
        }
    }

    private @Inline def sumElemStressesToNodeForces(B:Array_2[Double],
                            stress_xx:Double, stress_yy:Double, stress_zz:Double,
                            fx:Rail[Double], fy:Rail[Double], fz:Rail[Double],
                            k:Long) {
        for (i in 0..7) {
            fx(k*8+i) = -( stress_xx * B(0,i) );
            fy(k*8+i) = -( stress_yy * B(1,i) );
            fz(k*8+i) = -( stress_zz * B(2,i) );
        }
    }

    /**
     * Compute a stiffness force for each element to damp spurious "hourglass"
     * energy modes.
     */
    protected def calcHourglassControlForElems(domain:Domain,
                                     determ:Rail[Double], hgcoef:Double) {
        val numElem = domain.numElem;
        val numElem8 = numElem * 8;
        val dvdx = Unsafe.allocRailUninitialized[Double](numElem8);
        val dvdy = Unsafe.allocRailUninitialized[Double](numElem8);
        val dvdz = Unsafe.allocRailUninitialized[Double](numElem8);
        val x8n  = Unsafe.allocRailUninitialized[Double](numElem8);
        val y8n  = Unsafe.allocRailUninitialized[Double](numElem8);
        val z8n  = Unsafe.allocRailUninitialized[Double](numElem8);

startLoop(5);
        Foreach.block(0, numElem-1,
        (min_i:Long, max_i:Long) => {
            @StackAllocate val x1 = @StackAllocate new Rail[Double](8);
            @StackAllocate val y1 = @StackAllocate new Rail[Double](8);
            @StackAllocate val z1 = @StackAllocate new Rail[Double](8);
            @StackAllocate val pfx = @StackAllocate new Rail[Double](8);
            @StackAllocate val pfy = @StackAllocate new Rail[Double](8);
            @StackAllocate val pfz = @StackAllocate new Rail[Double](8);
            for (i in min_i..max_i) {
                collectDomainNodesToElemNodes(domain, i, x1, y1, z1);

                calcElemVolumeDerivative(pfx, pfy, pfz, x1, y1, z1);

                /* load into temporary storage for FB Hour Glass control */
                for (ii in 0..7) {
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
        } );
endLoop(5);

        if (hgcoef > 0.0) {
            calcFBHourglassForceForElems(domain,
                                        determ, x8n, y8n, z8n, 
                                        dvdx, dvdy, dvdz,
                                        hgcoef);
        }

        // force GC to reuse space for large temporary arrays
        Unsafe.dealloc(dvdx);
        Unsafe.dealloc(dvdy);
        Unsafe.dealloc(dvdz);
        Unsafe.dealloc(x8n);
        Unsafe.dealloc(y8n);
        Unsafe.dealloc(z8n);
    }

    /**
     * Calculate the volume derivative of an element with respect to each of
     * its eight nodal coordinates.
     * @param dvdx on return, the volume derivative with respect to the x
     *   coordinates of each of the eight nodes
     * @param dvdy on return, the volume derivative with respect to y coords
     * @param dvdz on return, the volume derivative with respect to z coords
     * @param x the x coordinates of each of the eight nodes
     * @param y the y coordinates of each of the eight nodes
     * @param z the z coordinates of each of the eight nodes
     */
    private @Inline final def calcElemVolumeDerivative(dvdx:Rail[Double],
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
        voluDer(x, y, z, 6, 5, 4, 3, 2, 0, dvdx, dvdy, dvdz, 7);
    }

    private @Inline final def voluDer(x:Rail[Double], y:Rail[Double], z:Rail[Double],
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

        val numElem = domain.numElem;
        val numElem8 = numElem * 8;
        val fx_elem = Unsafe.allocRailUninitialized[Double](numElem8);
        val fy_elem = Unsafe.allocRailUninitialized[Double](numElem8);
        val fz_elem = Unsafe.allocRailUninitialized[Double](numElem8);

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

        // compute the hourglass modes

startLoop(6);
        Foreach.block(0, domain.numElem-1,
        (min_i:Long, max_i:Long) => {
            @StackAllocate val hourgamStore = @StackAllocateUninitialized new Rail[Double](32);
            val hourgam = Array_2.makeView[Double](hourgamStore, 8, 4);
            @StackAllocate val xd1 = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val yd1 = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val zd1 = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val hgfx = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val hgfy = @StackAllocateUninitialized new Rail[Double](8);
            @StackAllocate val hgfz = @StackAllocateUninitialized new Rail[Double](8);

            for (i2 in min_i..max_i) {
                val i3 = 8*i2;
                val volinv = 1.0 / determ(i2);
                for (i1 in 0..3) {
                    val hourmod = (a8n:Rail[Double]) => {
                        a8n(i3)   * gamma(i1,0) + a8n(i3+1) * gamma(i1,1) +
                        a8n(i3+2) * gamma(i1,2) + a8n(i3+3) * gamma(i1,3) +
                        a8n(i3+4) * gamma(i1,4) + a8n(i3+5) * gamma(i1,5) +
                        a8n(i3+6) * gamma(i1,6) + a8n(i3+7) * gamma(i1,7)
                    };

                    val hourmodx = hourmod(x8n);
                    val hourmody = hourmod(y8n);
                    val hourmodz = hourmod(z8n);

                    val setHourgam = (idx:Long) => {
                        hourgam(idx,i1) = gamma(i1,idx) 
                            - volinv * (dvdx(i3+idx) * hourmodx
                                      + dvdy(i3+idx) * hourmody
                                      + dvdz(i3+idx) * hourmodz);
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

                Rail.copy(hgfx, 0, fx_elem, i3, 8);
                Rail.copy(hgfy, 0, fy_elem, i3, 8);
                Rail.copy(hgfz, 0, fz_elem, i3, 8);
            }
        });
endLoop(6);

        // Collect the data from the local arrays into the final force arrays
startLoop(7);
        Foreach.block(0, domain.numNode-1,
        (min_g:Long, max_g:Long) => {
            for (gnode in min_g..max_g) {
                val count = domain.nodeElemCount(gnode);
                val elemStart = domain.nodeElemStart(gnode);
                var fx_tmp:Double = 0.0;
                var fy_tmp:Double = 0.0;
                var fz_tmp:Double = 0.0;
                for (i in 0..(count-1)) {
                    val elem = domain.nodeElemCornerList(elemStart+i);
                    fx_tmp += fx_elem(elem);
                    fy_tmp += fy_elem(elem);
                    fz_tmp += fz_elem(elem);
                }
                domain.fx(gnode) += fx_tmp;
                domain.fy(gnode) += fy_tmp;
                domain.fz(gnode) += fz_tmp;
            }
        });
endLoop(7);

        // force GC to reuse space for large temporary arrays
        Unsafe.dealloc(fx_elem);
        Unsafe.dealloc(fy_elem);
        Unsafe.dealloc(fz_elem);
    }

    private @Inline final def calcElemFBHourglassForce(
                       xd:Rail[Double], yd:Rail[Double], zd:Rail[Double],
                       hourgam:Array_2[Double], coefficient:Double,
                       hgfx:Rail[Double], hgfy:Rail[Double], hgfz:Rail[Double]) {
        @StackAllocate val hxx = @StackAllocate new Rail[Double](4);
        
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

    def calcAccelerationForNodes(domain:Domain) {
startLoop(8);
        Foreach.block(0, domain.numNode-1, (i:Long)=> {
            domain.xdd(i) = domain.fx(i) / domain.nodalMass(i);
            domain.ydd(i) = domain.fy(i) / domain.nodalMass(i);
            domain.zdd(i) = domain.fz(i) / domain.nodalMass(i);
        });
endLoop(8);
    }

    def applyAccelerationBoundaryConditionsForNodes(domain:Domain) {
        val size = domain.sizeX;
        val numNodeBC = (size+1)*(size+1);

        if (!domain.symmXempty()) {
startLoop(9);
            for (i in 0..(numNodeBC-1)) {
            //Foreach.block(0, numNodeBC-1, (i:Long)=> {
                domain.xdd(domain.symmX(i)) = 0.0;
            }
endLoop(9);
        }

        if (!domain.symmYempty()) {
startLoop(10);
            for (i in 0..(numNodeBC-1)) {
            //Foreach.block(0, numNodeBC-1, (i:Long)=> {
                domain.ydd(domain.symmY(i)) = 0.0;
            }
endLoop(10);
        }

        if (!domain.symmZempty()) {
startLoop(11);
            for (i in 0..(numNodeBC-1)) {
            //Foreach.block(0, numNodeBC-1, (i:Long)=> {
                domain.zdd(domain.symmZ(i)) = 0.0;
            }
endLoop(11);
        }
    }

    /** 
     * Advance velocity vector at each node. Applies a cutoff to
     * avoid spurious mesh motion due to floating point roundoff error.
     */
    def calcVelocityForNodes(domain:Domain, dt:Double, u_cut:Double) {
startLoop(12);
        Foreach.block(0, domain.numNode-1, (i:Long)=> {
            var xdtmp:Double = domain.xd(i) + domain.xdd(i) * dt;
            if (Math.abs(xdtmp) < u_cut) xdtmp = 0.0;
            domain.xd(i) = xdtmp;

            var ydtmp:Double = domain.yd(i) + domain.ydd(i) * dt;
            if (Math.abs(ydtmp) < u_cut) ydtmp = 0.0;
            domain.yd(i) = ydtmp;

            var zdtmp:Double = domain.zd(i) + domain.zdd(i) * dt;
            if (Math.abs(zdtmp) < u_cut) zdtmp = 0.0;
            domain.zd(i) = zdtmp;
        });
endLoop(12);
    }

    def calcPositionForNodes(domain:Domain, dt:Double) {
startLoop(13);
        Foreach.block(0, domain.numNode-1, (i:Long)=> {
            domain.x(i) += domain.xd(i) * dt;
            domain.y(i) += domain.yd(i) * dt;
            domain.z(i) += domain.zd(i) * dt;
        });
endLoop(13);
    }

    def calcLagrangeElements(domain:Domain, vnew:Rail[Double]) {
        val numElem = domain.numElem;
        if (numElem > 0) {
            val deltatime = domain.deltatime;

            domain.allocateStrains();

            calcKinematicsForElems(domain, vnew, deltatime);

            // element loop to do some stuff not included in the elemlib function.
startLoop(15);
            Foreach.block(0, numElem-1, (k:Long)=> {
                // calc strain rate and apply as constraint (only done in FB element)
                val vdov = domain.dxx(k) + domain.dyy(k) + domain.dzz(k);
                val vdovthird = vdov / 3.0;

                // make the rate of deformation tensor deviatoric
                domain.vdov(k) = vdov;
                domain.dxx(k) -= vdovthird;
                domain.dyy(k) -= vdovthird;
                domain.dzz(k) -= vdovthird;

                // See if any volumes are negative, and take appropriate action.
                if (vnew(k) <= 0.0)  {
                    throw new VolumeException(k, vnew(k));
                }
            } );
endLoop(15);
            domain.deallocateStrains();
        }
    }

    def calcKinematicsForElems(domain:Domain, vnew:Rail[Double], deltaTime:Double) {
startLoop(14);
        Foreach.block(0, domain.numElem-1,
        (min_k:Long, max_k:Long) => {
            /** shape function derivatives */
            @StackAllocate val bStore = @StackAllocate new Rail[Double](24);
            val B = Array_2.makeView[Double](bStore, 3, 8);
            @StackAllocate val D = @StackAllocate new Rail[Double](6);
            @StackAllocate val x_local = @StackAllocate new Rail[Double](8);
            @StackAllocate val y_local = @StackAllocate new Rail[Double](8);
            @StackAllocate val z_local = @StackAllocate new Rail[Double](8);
            @StackAllocate val xd_local = @StackAllocate new Rail[Double](8);
            @StackAllocate val yd_local = @StackAllocate new Rail[Double](8);
            @StackAllocate val zd_local = @StackAllocate new Rail[Double](8);

            for (k in min_k..max_k) {
                collectDomainNodesToElemNodes(domain, k, x_local, y_local, z_local);

                // volume calculations
                val volume = Domain.calcElemVolume(x_local, y_local, z_local);
                val relativeVolume = volume / domain.volo(k);
                vnew(k) = relativeVolume;
                domain.delv(k) = relativeVolume - domain.v(k);

                domain.arealg(k) = calcElemCharacteristicLength(x_local, y_local, z_local, volume);

                // get nodal velocities from global array and copy into local arrays.
                for (lnode in 0..7) {
                    val gnode = domain.nodeList(k*8 + lnode);
                    xd_local(lnode) = domain.xd(gnode);
                    yd_local(lnode) = domain.yd(gnode);
                    zd_local(lnode) = domain.zd(gnode);
                }

                val dt2 = 0.5 * deltaTime;
                for (j in 0..7) {
                    x_local(j) -= dt2 * xd_local(j);
                    y_local(j) -= dt2 * yd_local(j);
                    z_local(j) -= dt2 * zd_local(j);
                }

                val detJ = calcElemShapeFunctionDerivatives(x_local, y_local, z_local, B);

                calcElemVelocityGradient(xd_local, yd_local, zd_local, B, detJ, D);

                // put velocity gradient quantities into their global arrays
                domain.dxx(k) = D(0);
                domain.dyy(k) = D(1);
                domain.dzz(k) = D(2);
            }
        } );
endLoop(14);
    }

    private @Inline final def calcElemCharacteristicLength(
                            x:Rail[Double], 
                            y:Rail[Double],
                            z:Rail[Double],
                            volume:Double):Double {
        val areaFace = (i:Long, j:Long, k:Long, l:Long) => {
            val fx = (x(k) - x(i)) - (x(l) - x(j));
            val fy = (y(k) - y(i)) - (y(l) - y(j));
            val fz = (z(k) - z(i)) - (z(l) - z(j));
            val gx = (x(k) - x(i)) + (x(l) - x(j));
            val gy = (y(k) - y(i)) + (y(l) - y(j));
            val gz = (z(k) - z(i)) + (z(l) - z(j));
            val area = (fx*fx + fy*fy + fz*fz) * (gx*gx + gy*gy + gz*gz)
                     - (fx*gx + fy*gy + fz*gz) * (fx*gx + fy*gy + fz*gz);
            area
        };

        var charLength:Double = 0.0;
        charLength = Math.max(charLength, areaFace(0, 1, 2, 3));
        charLength = Math.max(charLength, areaFace(4, 5, 6, 7));
        charLength = Math.max(charLength, areaFace(0, 1, 5, 4));
        charLength = Math.max(charLength, areaFace(1, 2, 6, 5));
        charLength = Math.max(charLength, areaFace(2, 3, 7, 6));
        charLength = Math.max(charLength, areaFace(3, 0, 4, 7));

        charLength = 4.0 * volume / Math.sqrt(charLength);

        return charLength;
    }

    private @Inline final def calcElemVelocityGradient(xvel:Rail[Double], 
                                 yvel:Rail[Double],
                                 zvel:Rail[Double],
                                 b:Array_2[Double], 
                                 detJ:Double, d:Rail[Double]) {
        val inv_detJ = 1.0 / detJ;

        val dv = (v:Rail[Double], coordIdx:Long) => {
            inv_detJ * ( b(coordIdx,0) * (v(0)-v(6))
                       + b(coordIdx,1) * (v(1)-v(7))
                       + b(coordIdx,2) * (v(2)-v(4))
                       + b(coordIdx,3) * (v(3)-v(5)) )
        };

        d(0) = dv(xvel, 0);
        d(1) = dv(yvel, 1);
        d(2) = dv(zvel, 2);

        val dyddx = dv(yvel, 0);
        val dxddy = dv(xvel, 1);
        val dzddx = dv(zvel, 0);
        val dxddz = dv(xvel, 2);
        val dzddy = dv(zvel, 1);
        val dyddz = dv(yvel, 2);

        d(5) = 0.5 * (dxddy + dyddx);
        d(4) = 0.5 * (dxddz + dzddx);
        d(3) = 0.5 * (dzddy + dyddz);
    }

    /** 
     * Calculate artificial viscosity q for each element.
     * (Monotonic q option requires communication)
     * @see "R. B. Christensen. Godunov methods on a staggered mesh: An 
     * improved artificial viscosity. Lawrence Livermore National Laboratory 
     * Report, UCRL-JC-105-269, 1991. https://e-reports-ext.llnl.gov/pdf/219547.pdf"
     */
    protected def calcQForElems(domain:Domain, vnew:Rail[Double]) {
        val numElem = domain.numElem;

        if (numElem != 0) {
            val allElem = numElem            /* local elem */
              + 2*domain.sizeY*domain.sizeZ  /* X ghosts */
              + 2*domain.sizeX*domain.sizeZ  /* Y ghosts */
              + 2*domain.sizeX*domain.sizeY; /* Z ghosts */

            domain.allocateGradients(allElem); 

            /* Calculate velocity gradients */
            calcMonotonicQGradientsForElems(domain, vnew);

            val elementsPerSide = domain.sizeX;
            gradientGhostMgr.updatePlaneGhosts(domainPlh, 
                (dom:Domain) => [dom.delv_xi, dom.delv_eta, dom.delv_zeta],
                elementsPerSide
            );
            gradientGhostMgr.waitForGhosts();

            calcMonotonicQForElems(domain, vnew);

            // Free up memory
            domain.deallocateGradients();

            /* Don't allow excessive artificial viscosity */
            var idx:Long = -1; 
            for (i in 0..(numElem-1)) {
                if (domain.q(i) > domain.qstop) {
                    idx = i;
                    break;
                }
            }

            if (idx >= 0) {
                throw new ViscosityException(idx, domain.q(idx));
            }
        }
    }

    def calcMonotonicQGradientsForElems(domain:Domain, vnew:Rail[Double]) { 
startLoop(16);
        Foreach.block(0, domain.numElem-1, (i:Long)=> {
            val ptiny = 1.e-36;

            val n0 = domain.nodeList(i*8+0);
            val n1 = domain.nodeList(i*8+1);
            val n2 = domain.nodeList(i*8+2);
            val n3 = domain.nodeList(i*8+3);
            val n4 = domain.nodeList(i*8+4);
            val n5 = domain.nodeList(i*8+5);
            val n6 = domain.nodeList(i*8+6);
            val n7 = domain.nodeList(i*8+7);

            val x0 = domain.x(n0);
            val x1 = domain.x(n1);
            val x2 = domain.x(n2);
            val x3 = domain.x(n3);
            val x4 = domain.x(n4);
            val x5 = domain.x(n5);
            val x6 = domain.x(n6);
            val x7 = domain.x(n7);

            val y0 = domain.y(n0);
            val y1 = domain.y(n1);
            val y2 = domain.y(n2);
            val y3 = domain.y(n3);
            val y4 = domain.y(n4);
            val y5 = domain.y(n5);
            val y6 = domain.y(n6);
            val y7 = domain.y(n7);

            val z0 = domain.z(n0);
            val z1 = domain.z(n1);
            val z2 = domain.z(n2);
            val z3 = domain.z(n3);
            val z4 = domain.z(n4);
            val z5 = domain.z(n5);
            val z6 = domain.z(n6);
            val z7 = domain.z(n7);

            val xv0 = domain.xd(n0);
            val xv1 = domain.xd(n1);
            val xv2 = domain.xd(n2);
            val xv3 = domain.xd(n3);
            val xv4 = domain.xd(n4);
            val xv5 = domain.xd(n5);
            val xv6 = domain.xd(n6);
            val xv7 = domain.xd(n7);

            val yv0 = domain.yd(n0);
            val yv1 = domain.yd(n1);
            val yv2 = domain.yd(n2);
            val yv3 = domain.yd(n3);
            val yv4 = domain.yd(n4);
            val yv5 = domain.yd(n5);
            val yv6 = domain.yd(n6);
            val yv7 = domain.yd(n7);

            val zv0 = domain.zd(n0);
            val zv1 = domain.zd(n1);
            val zv2 = domain.zd(n2);
            val zv3 = domain.zd(n3);
            val zv4 = domain.zd(n4);
            val zv5 = domain.zd(n5);
            val zv6 = domain.zd(n6);
            val zv7 = domain.zd(n7);

            val vol = domain.volo(i) * vnew(i);
            val norm = 1.0 / ( vol + ptiny );

            val dxj = -0.25 * ((x0+x1+x5+x4) - (x3+x2+x6+x7));
            val dyj = -0.25 * ((y0+y1+y5+y4) - (y3+y2+y6+y7));
            val dzj = -0.25 * ((z0+z1+z5+z4) - (z3+z2+z6+z7));

            val dxi =  0.25 * ((x1+x2+x6+x5) - (x0+x3+x7+x4));
            val dyi =  0.25 * ((y1+y2+y6+y5) - (y0+y3+y7+y4));
            val dzi =  0.25 * ((z1+z2+z6+z5) - (z0+z3+z7+z4));

            val dxk =  0.25 * ((x4+x5+x6+x7) - (x0+x1+x2+x3));
            val dyk =  0.25 * ((y4+y5+y6+y7) - (y0+y1+y2+y3));
            val dzk =  0.25 * ((z4+z5+z6+z7) - (z0+z1+z2+z3));

            /* find delvk and delxk ( i cross j ) */

            var ax:Double = dyi*dzj - dzi*dyj;
            var ay:Double = dzi*dxj - dxi*dzj;
            var az:Double = dxi*dyj - dyi*dxj;

            domain.delx_zeta(i) = vol / Math.sqrt(ax*ax + ay*ay + az*az + ptiny);

            ax *= norm;
            ay *= norm;
            az *= norm;

            var dxv:Double = 0.25 * ((xv4+xv5+xv6+xv7) - (xv0+xv1+xv2+xv3));
            var dyv:Double = 0.25 * ((yv4+yv5+yv6+yv7) - (yv0+yv1+yv2+yv3));
            var dzv:Double = 0.25 * ((zv4+zv5+zv6+zv7) - (zv0+zv1+zv2+zv3));

            domain.delv_zeta(i) = ax*dxv + ay*dyv + az*dzv;

            /* find delxi and delvi ( j cross k ) */

            ax = dyj*dzk - dzj*dyk;
            ay = dzj*dxk - dxj*dzk;
            az = dxj*dyk - dyj*dxk;

            domain.delx_xi(i) = vol / Math.sqrt(ax*ax + ay*ay + az*az + ptiny);

            ax *= norm;
            ay *= norm;
            az *= norm;

            dxv = 0.25 * ((xv1+xv2+xv6+xv5) - (xv0+xv3+xv7+xv4));
            dyv = 0.25 * ((yv1+yv2+yv6+yv5) - (yv0+yv3+yv7+yv4));
            dzv = 0.25 * ((zv1+zv2+zv6+zv5) - (zv0+zv3+zv7+zv4));

            domain.delv_xi(i) = ax*dxv + ay*dyv + az*dzv;

            /* find delxj and delvj ( k cross i ) */

            ax = dyk*dzi - dzk*dyi;
            ay = dzk*dxi - dxk*dzi;
            az = dxk*dyi - dyk*dxi;

            domain.delx_eta(i) = vol / Math.sqrt(ax*ax + ay*ay + az*az + ptiny);

            ax *= norm;
            ay *= norm;
            az *= norm;

            dxv = -0.25 * ((xv0+xv1+xv5+xv4) - (xv3+xv2+xv6+xv7));
            dyv = -0.25 * ((yv0+yv1+yv5+yv4) - (yv3+yv2+yv6+yv7));
            dzv = -0.25 * ((zv0+zv1+zv5+zv4) - (zv3+zv2+zv6+zv7));

            domain.delv_eta(i) = ax*dxv + ay*dyv + az*dzv;
        } );
endLoop(16);
    }

    /** calculate the monotonic q for all regions */
    def calcMonotonicQForElems(domain:Domain, vnew:Rail[Double]) {
        // initialize parameters
        val ptiny = 1.e-36;
        for (r in 0..(domain.numReg-1)) {
            if (domain.regElemSize(r) > 0) {
                calcMonotonicQRegionForElems(domain, r, vnew, ptiny);
            }
        }
    }

    def calcMonotonicQRegionForElems(domain:Domain, r:Long, vnew:Rail[Double], ptiny:Double) {
        val monoq_limiter_mult = domain.monoq_limiter_mult;
        val monoq_max_slope = domain.monoq_max_slope;
        val qlc_monoq = domain.qlc_monoq;
        val qqc_monoq = domain.qqc_monoq;
        val regElemList = domain.regElemList(r);

startLoop(17);
        Foreach.block(0, domain.regElemSize(r)-1, (ielem:Long)=> {
            val i = regElemList(ielem);
            val bcMask = domain.elemBC(i);
            var delvm:Double = 0.0, delvp:Double = 0.0;

            /* phixi */
            var norm:Double = 1.0 / (domain.delv_xi(i) + ptiny);

            switch (bcMask & Domain.XI_M) {
                case Domain.XI_M_COMM: /* needs comm data */
                case 0n:               delvm = domain.delv_xi(domain.lxim(i));
                    break;
                case Domain.XI_M_SYMM: delvm = domain.delv_xi(i);
                    break;
                case Domain.XI_M_FREE: delvm = 0.0;
                    break;
                default:
                    throw new IllegalArgumentException("bcMask & Domain.XI_M");
            }
            switch (bcMask & Domain.XI_P) {
                case Domain.XI_P_COMM: /* needs comm data */
                case 0n:               delvp = domain.delv_xi(domain.lxip(i));
                    break;
                case Domain.XI_P_SYMM: delvp = domain.delv_xi(i);
                    break;
                case Domain.XI_P_FREE: delvp = 0.0;
                    break;
                default:
                    throw new IllegalArgumentException("bcMask & Domain.XI_P");
            }

            delvm = delvm * norm;
            delvp = delvp * norm;

            var phixi:Double = 0.5 * ( delvm + delvp );

            delvm *= monoq_limiter_mult;
            delvp *= monoq_limiter_mult;

            if (delvm < phixi) phixi = delvm;
            if (delvp < phixi) phixi = delvp;
            if (phixi < 0.0) phixi = 0.0;
            if (phixi > monoq_max_slope) phixi = monoq_max_slope;

            /* phieta */
            norm = 1.0 / (domain.delv_eta(i) + ptiny);

            switch (bcMask & Domain.ETA_M) {
                case Domain.ETA_M_COMM: /* needs comm data */
                case 0n:                delvm = domain.delv_eta(domain.letam(i));
                    break;
                case Domain.ETA_M_SYMM: delvm = domain.delv_eta(i);
                    break;
                case Domain.ETA_M_FREE: delvm = 0.0;
                    break;
                default:
                    throw new IllegalArgumentException("bcMask & Domain.ETA_M");
            }
            switch (bcMask & Domain.ETA_P) {
                case Domain.ETA_P_COMM: /* needs comm data */
                case 0n:                delvp = domain.delv_eta(domain.letap(i));
                    break;
                case Domain.ETA_P_SYMM: delvp = domain.delv_eta(i);
                    break;
                case Domain.ETA_P_FREE: delvp = 0.0;
                    break;
                default:
                    throw new IllegalArgumentException("bcMask & Domain.ETA_P");
            }

            delvm = delvm * norm;
            delvp = delvp * norm;

            var phieta:Double = 0.5 * (delvm + delvp);

            delvm *= monoq_limiter_mult;
            delvp *= monoq_limiter_mult;

            if (delvm  < phieta) phieta = delvm;
            if (delvp  < phieta) phieta = delvp;
            if (phieta < 0.0) phieta = 0.0;
            if (phieta > monoq_max_slope) phieta = monoq_max_slope;

            /* phizeta */
            norm = 1.0 / ( domain.delv_zeta(i) + ptiny );

            switch (bcMask & Domain.ZETA_M) {
                case Domain.ZETA_M_COMM: /* needs comm data */
                case 0n:                 delvm = domain.delv_zeta(domain.lzetam(i));
                    break;
                case Domain.ZETA_M_SYMM: delvm = domain.delv_zeta(i);
                    break;
                case Domain.ZETA_M_FREE: delvm = 0.0;
                    break;
                default:
                    throw new IllegalArgumentException("bcMask & Domain.ZETA_M");
            }
            switch (bcMask & Domain.ZETA_P) {
                case Domain.ZETA_P_COMM: /* needs comm data */
                case 0n:                 delvp = domain.delv_zeta(domain.lzetap(i));
                    break;
                case Domain.ZETA_P_SYMM: delvp = domain.delv_zeta(i);
                    break;
                case Domain.ZETA_P_FREE: delvp = 0.0;
                    break;
                default:
                    throw new IllegalArgumentException("bcMask & Domain.ZETA_P");
            }

            delvm = delvm * norm;
            delvp = delvp * norm;

            var phizeta:Double = 0.5 * (delvm + delvp);

            delvm *= monoq_limiter_mult;
            delvp *= monoq_limiter_mult;

            if (delvm   < phizeta) phizeta = delvm;
            if (delvp   < phizeta) phizeta = delvp;
            if (phizeta < 0.0) phizeta = 0.0;
            if (phizeta > monoq_max_slope) phizeta = monoq_max_slope;

            /* Remove length scale */

            var qlin:Double, qquad:Double;
            if (domain.vdov(i) > 0.0) {
                qlin  = 0.0;
                qquad = 0.0;
            } else {
                var delvxxi:Double   = domain.delv_xi(i)   * domain.delx_xi(i);
                var delvxeta:Double  = domain.delv_eta(i)  * domain.delx_eta(i);
                var delvxzeta:Double = domain.delv_zeta(i) * domain.delx_zeta(i);

                if (delvxxi   > 0.0) delvxxi   = 0.0;
                if (delvxeta  > 0.0) delvxeta  = 0.0;
                if (delvxzeta > 0.0) delvxzeta = 0.0;

                val rho = domain.elemMass(i) / (domain.volo(i) * vnew(i));

                qlin = -qlc_monoq * rho *
                        ( delvxxi   * (1.0 - phixi)
                        + delvxeta  * (1.0 - phieta)
                        + delvxzeta * (1.0 - phizeta) );

                qquad = qqc_monoq * rho *
                        ( delvxxi*delvxxi     * (1.0 - phixi*phixi)
                        + delvxeta*delvxeta   * (1.0 - phieta*phieta)
                        + delvxzeta*delvxzeta * (1.0 - phizeta*phizeta) );
            }

            domain.qq(i) = qquad;
            domain.ql(i) = qlin;
        } );
endLoop(17);
    }

    /** Update pressure and internal energy variables for the new timestep. */
    protected def applyMaterialPropertiesForElems(domain:Domain, vnew:Rail[Double]) {
        val numElem = domain.numElem;

        if (numElem != 0) {
            /* Expose all of the variables needed for material evaluation */
            val eosvmin = domain.eosvmin;
            val eosvmax = domain.eosvmax;

            // Bound the updated relative volumes with eosvmin/max
startLoop(18);
            Foreach.block(0, numElem-1, (i:Long)=> {
                if (eosvmin != 0.0) {
                    if (vnew(i) < eosvmin) vnew(i) = eosvmin;
                }

                if (eosvmax != 0.0) {
                    if (vnew(i) > eosvmax) vnew(i) = eosvmax;
                }

            // This check may not make perfect sense in LULESH, but
            // it's representative of something in the full code -
            // just leave it in, please
                var vc:Double = domain.v(i);
                if (eosvmin != 0.0) {
                    if (vc < eosvmin) vc = eosvmin;
                }
                if (eosvmax != 0.0) {
                    if (vc > eosvmax) vc = eosvmax;
                }
                if (vc <= 0.0) {
                    throw new VolumeException(i, vc);
                }
            });
endLoop(18); // fused loops 18-20

            for (r in 0..(domain.numReg-1)) {
                val numElemReg = domain.regElemSize(r);
                val regElemList = domain.regElemList(r);
                var rep:Int;
                // Determine load imbalance for this region
                // round down the number with lowest cost
                if (r < domain.numReg/2)
                    rep = 1n;
                // you don't get an expensive region unless you at least have 5 regions
                else if (r < (domain.numReg - (domain.numReg+15n)/20n))
                    rep = 1n + domain.cost;
                // very expensive regions
                else
                    rep = 10n * (1n + domain.cost);
                evalEOSForElems(domain, vnew, numElemReg, regElemList, rep);
            }
        }
    }

    /**
     * Update equation of state variables (pressure, energy, artificial
     * viscosity) for each element.
     */
    protected def evalEOSForElems(domain:Domain, vnewc:Rail[Double],
                        numElemReg:Long, regElemList:Rail[Long], rep:Int) {
        val e_cut = domain.e_cut;
        val p_cut = domain.p_cut;
        val ss4o3 = domain.ss4o3;
        val q_cut = domain.q_cut;

        val eosvmax = domain.eosvmax;
        val eosvmin = domain.eosvmin;
        val pmin    = domain.pmin;
        val emin    = domain.emin;
        val rho0    = domain.refdens;

        // These temporaries will be of different size for 
        // each call (due to different sized region element
        // lists)
        val work = Unsafe.allocRailUninitialized[Double](numElemReg);
        val p_new = Unsafe.allocRailUninitialized[Double](numElemReg);
        val e_new = Unsafe.allocRailUninitialized[Double](numElemReg);
        val q_new = Unsafe.allocRailUninitialized[Double](numElemReg);
        val bvc = Unsafe.allocRailUninitialized[Double](numElemReg);
        val pbvc = Unsafe.allocRailUninitialized[Double](numElemReg);

        //loop to add load imbalance based on region number 
        for(j in 0..(rep-1)) {
            /* compress data, minimal set */
startLoop(21);
            Foreach.block(0, numElemReg-1, (i:Long)=> {
                val elem = regElemList(i);
                val e_old = domain.e(elem);
                val delvc = domain.delv(elem);
                var p_old:Double = domain.p(elem);
                val q_old = domain.q(elem);
                val qq_old = domain.qq(elem);
                val ql_old = domain.ql(elem);
                var compression:Double = 1.0 / vnewc(elem) - 1.0;
                val vchalf = vnewc(elem) - delvc * 0.5;
                var compHalfStep:Double = 1.0 / vchalf - 1.0;

                if ( eosvmin != 0.0 ) {
                    if (vnewc(elem) <= eosvmin) { /* impossible due to calling func? */
                        compHalfStep = compression;
                    }
                }

                if (eosvmax != 0.0 ) {
                   if (vnewc(elem) >= eosvmax) { /* impossible due to calling func? */
                      p_old        = 0.0;
                      compression  = 0.0;
                      compHalfStep = 0.0;
                   }
                }

                work(i) = 0.0; 

                calcEnergyForElem(i, p_new, e_new, q_new, bvc, pbvc,
                             p_old, e_old, q_old, compression, compHalfStep,
                             vnewc, work, delvc, pmin,
                             p_cut, e_cut, q_cut, emin,
                             qq_old, ql_old, rho0, eosvmax,
                             elem);
            });
endLoop(21); // fused loops 21-32
        }

startLoop(33);
        Foreach.block(0, numElemReg-1, (i:Long)=> {
            val elem = regElemList(i);
            domain.p(elem) = p_new(i);
            domain.e(elem) = e_new(i);
            domain.q(elem) = q_new(i);

            calcSoundSpeedForElem(i, domain,
                          vnewc, rho0, e_new, p_new,
                          pbvc, bvc, ss4o3,
                          elem);
        });
endLoop(33); // fused loops 33-34

        Unsafe.dealloc(work);
        Unsafe.dealloc(p_new);
        Unsafe.dealloc(e_new);
        Unsafe.dealloc(q_new);
        Unsafe.dealloc(bvc);
        Unsafe.dealloc(pbvc);
    }

    private @Inline def calcEnergyForElem(i:Long, p_new:Rail[Double],
                e_new:Rail[Double], q_new:Rail[Double], 
                bvc:Rail[Double], pbvc:Rail[Double],
                p_old:Double, e_old:Double, q_old:Double,
                compression:Double, compHalfStep:Double,
                vnewc:Rail[Double], work:Rail[Double], 
                delvc:Double, pmin:Double,
                p_cut:Double, e_cut:Double, q_cut:Double, emin:Double,
                qq_old:Double, ql_old:Double,
                rho0:Double, eosvmax:Double,
                elem:Long) {

        var e:Double = e_old - 0.5 * delvc * (p_old + q_old)
                 + 0.5 * work(i);

        if (e < emin) {
            e = emin;
        }

        val pHalfStep = calcPressureForElem(i, bvc, pbvc, e, compHalfStep,
            vnewc, pmin, p_cut, eosvmax, elem);

        val vhalf = 1.0 / (1.0 + compHalfStep);

        var q:Double;
        if (delvc > 0.0) {
            q /* = qq_old = ql_old */ = 0.0;
        } else {
            var ssc:Double = ( pbvc(i) * e
                    + vhalf * vhalf * bvc(i) * pHalfStep ) 
                / rho0;

            if (ssc <= 0.1111111e-36) {
                ssc = 0.3333333e-18;
            } else {
                ssc = Math.sqrt(ssc);
            }

            q = (ssc*ql_old + qq_old);
        }

        e = e + 0.5 * delvc
              * (3.0*(p_old+q_old) - 4.0*(pHalfStep+q));

        e += 0.5 * work(i);

        if (Math.abs(e) < e_cut) {
            e = 0.0;
        }
        if (e < emin) {
            e = emin;
        }

        var p:Double = calcPressureForElem(i, bvc, pbvc, e, compression,
                        vnewc, pmin, p_cut, eosvmax, elem);

        val sixth = 1.0 / 6.0;

        var q_tilde:Double;

        if (delvc > 0.0) {
            q_tilde = 0.0;
        } else {
            var ssc:Double = (pbvc(i) * e
                    + vnewc(elem) * vnewc(elem) * bvc(i) * p )
                 / rho0;

            if (ssc <= 0.1111111e-36) {
                ssc = 0.3333333e-18;
            } else {
                ssc = Math.sqrt(ssc);
            }

            q_tilde = (ssc*ql_old + qq_old);
        }

        e = e - (  7.0*(p_old     + q_old)
                 - 8.0*(pHalfStep + q)
                 + (p + q_tilde)) * delvc*sixth;

        if (Math.abs(e) < e_cut) {
            e = 0.0;
        }
        if (e < emin) {
            e = emin;
        }

        p = calcPressureForElem(i, bvc, pbvc, e, compression,
                        vnewc, pmin, p_cut, eosvmax, elem);

        if (delvc <= 0.0) {
            var ssc:Double = (pbvc(i) * e
                    + vnewc(elem) * vnewc(elem) * bvc(i) * p )
                / rho0;

             if (ssc <= 0.1111111e-36) {
                ssc = 0.3333333e-18;
             } else {
                ssc = Math.sqrt(ssc);
             }

             q = (ssc*ql_old + qq_old);

             if (Math.abs(q) < q_cut) q = 0.0;
        }

        p_new(i) = p;
        e_new(i) = e;
        q_new(i) = q;
    }

    private @Inline def calcPressureForElem(i:Long, 
                bvc:Rail[Double], pbvc:Rail[Double],
                e_old:Double, compression:Double,
                vnewc:Rail[Double], pmin:Double,
                p_cut:Double, eosvmax:Double,
                elem:Long):Double {

        val c1s = 2.0 / 3.0;
        bvc(i) = c1s * (compression + 1.0);
        pbvc(i) = c1s;
      
        var p_new:Double = bvc(i) * e_old;

        if (Math.abs(p_new) < p_cut)
            p_new = 0.0;

        if (vnewc(elem) >= eosvmax) /* impossible condition here? */
            p_new = 0.0;

        if  (p_new < pmin)
            p_new = pmin;

        return p_new;
    }

    private @Inline def calcSoundSpeedForElem(i:Long,
                            domain:Domain, vnewc:Rail[Double], 
                            rho0:Double, enewc:Rail[Double],
                            pnewc:Rail[Double], pbvc:Rail[Double],
                            bvc:Rail[Double], ss4o3:Double,
                            elem:Long) {
        var ssTmp:Double = (pbvc(i) * enewc(i) + vnewc(elem) * 
                            vnewc(elem) * bvc(i) * pnewc(i)) / rho0;
        if (ssTmp <= 0.1111111e-36) {
            ssTmp = 0.3333333e-18;
        } else {
            ssTmp = Math.sqrt(ssTmp);
        }
        domain.ss(elem) = ssTmp;
    }

    def updateVolumesForElems(domain:Domain, vnew:Rail[Double]) {
startLoop(35);
        Foreach.block(0, domain.numElem-1, (i:Long)=> {
            var tmpV:Double = vnew(i);
            // cutoff to avoid spurious volume change due to rounding error
            if (Math.abs(tmpV - 1.0) < domain.v_cut) tmpV = 1.0;
            domain.v(i) = tmpV;
        });
endLoop(35);
    }

    /**
     * Calculate the Courant time constraint Delta t_{courant}.
     * This constraint is calculated only in elements whose volumes are 
     * changing; that is, vdov != 0.0.
     */
    def calcCourantConstraintForElems(domain:Domain, length:Long, regElemList:Rail[Long]) {
        val qqc2 = 64.0 * domain.qqc * domain.qqc;

startLoop(36);
        val dtcourant_new = Foreach.blockReduce(0, length-1,
        (i:Long)=> {
            val indx = regElemList(i);
            var dtf:Double;
            if (domain.vdov(indx) == 0.0) {
                // only calculate time constraint for element whose volume is changing
                dtf = Double.MAX_VALUE;
            } else {
                dtf = domain.ss(indx) * domain.ss(indx);
                if (domain.vdov(indx) < 0.0) {
                    dtf = dtf
                    + qqc2 * domain.arealg(indx) * domain.arealg(indx)
                    * domain.vdov(indx) * domain.vdov(indx);
                }
                dtf = Math.sqrt(dtf);
                dtf = domain.arealg(indx) / dtf;
            }
            dtf
        },
        (a:Double, b:Double) => Math.min(a,b), Double.MAX_VALUE);
endLoop(36);

        domain.dtcourant = Math.min(domain.dtcourant, dtcourant_new);
    }

    /**
     * Calculate the hydro timestep constraint Delta t_{hydro}.
     * This constraint is calculated only in elements whose volumes are 
     * changing. When an element is undergoing volume change, Delta t_{thydro}
     * for the element is some maximum allowable element volume change 
     * (prescribed) divided by vdov in the element.
     */
    def calcHydroConstraintForElems(domain:Domain, length:Long, regElemList:Rail[Long]) {
startLoop(37);
        val dthydro_new = Foreach.blockReduce(0, length-1, (i:Long)=> {
            val indx = regElemList(i);
            var dthydro_tmp:Double;
            if (domain.vdov(indx) == 0.0) {
                // only calculate hydro time constraint for element whose volume is changing
                dthydro_tmp = Double.MAX_VALUE;
            } else {
                dthydro_tmp = domain.dvovmax / (Math.abs(domain.vdov(indx))+1.0e-20);
            }
            dthydro_tmp
        },
        (a:Double, b:Double) => Math.min(a,b), Double.MAX_VALUE);
endLoop(37);

        domain.dthydro = Math.min(domain.dthydro, dthydro_new);
    }

    def verifyAndWriteFinalOutput(elapsedTime:Double, domain:Domain) {
        val nx = domain.sizeX;
        // GrindTime1 only takes a single domain into account, and is thus a good way to measure
        // processor speed independent of multi-place parallelism.
        // GrindTime2 takes into account speedups from multi-place parallelism 
        val grindTime1 = ((elapsedTime*1e6)/domain.cycle)/(nx*nx*nx);
        val grindTime2 = ((elapsedTime*1e6)/domain.cycle)/(nx*nx*nx*Place.numPlaces());

        var elemId:Long = 0;
        Console.OUT.printf("Run completed:  \n");
        Console.OUT.printf("   Problem size        =  %d \n",    nx);
        Console.OUT.printf("   Number of places    =  %d \n",    Place.numPlaces());
        Console.OUT.printf("   Iteration count     =  %d \n",    domain.cycle);
        Console.OUT.printf("   Final Origin Energy = %12.6e \n", domain.e(elemId));

        var maxAbsDiff:Double = 0.0;
        var totalAbsDiff:Double = 0.0;
        var maxRelDiff:Double = 0.0;

        for (j in 0..(nx-1)) {
            for (k in (j+1)..(nx-1)) {
                val absDiff = Math.abs(domain.e(j*nx+k) - domain.e(k*nx+j));
                totalAbsDiff += absDiff;

                maxAbsDiff = Math.max(maxAbsDiff, absDiff);

                val relDiff = absDiff / domain.e(k*nx+j);

                maxRelDiff  = Math.max(maxRelDiff, relDiff);
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

    /**
     * Get nodal coordinates from global arrays and copy into local arrays.
     * Nodes are numbered 0,1,2,3 travelling around the first face (-zeta)
     * counterclockwise as seen looking from the opposite face (+zeta).
     * By symmetry, the nodes of the other face directly opposite are numbered
     * 4,5,6,7.  The natural coordinates xi, eta, zeta are defined as follows:
     * xi:   -1 from center of face 0,3,7,4 to +1 on face 1,2,6,5
     * eta:  -1 from center of face 0,1,5,4 to +1 on face 3,2,6,7
     * zeta: -1 from center of face 0,1,2,3 to +1 on face 4,5,6,7
     */
    private @Inline final def collectDomainNodesToElemNodes(domain:Domain,
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
}

// TODO Precision specification

// vim:tabstop=4:shiftwidth=4:expandtab
