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

    public def this(opts:CommandLineOptions) {
        this.opts = opts;
        this.domainPlh = PlaceLocalHandle.make[Domain](PlaceGroup.WORLD, 
            () => new Domain(opts.nx, opts.numReg, opts.balance, opts.cost));
    }

    public def run() {
        finish for (place in PlaceGroup.WORLD) at(place) async {
            val domain = domainPlh();

/*
            fieldData = &Domain::nodalMass ;

            // Initial domain boundary communication 
            CommRecv(*locDom, MSG_COMM_SBN, 1,
                    locDom->sizeX() + 1, locDom->sizeY() + 1, locDom->sizeZ() + 1,
                    true, false) ;
            CommSend(*locDom, MSG_COMM_SBN, 1, &fieldData,
                    locDom->sizeX() + 1, locDom->sizeY() + 1, locDom->sizeZ() +  1,
                    true, false) ;
            CommSBN(*locDom, 1, &fieldData) ;

            Team.WORLD.barrier();
*/
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

    public static @Inline def calcElemVolume(x:Rail[Double], y:Rail[Double], z:Rail[Double]):Double {
        val dx61 = x(6) - x(1);
        val dy61 = y(6) - y(1);
        val dz61 = z(6) - z(1);

        val dx70 = x(7) - x(0);
        val dy70 = y(7) - y(0);
        val dz70 = z(7) - z(0);

        val dx63 = x(6) - x(3);
        val dy63 = y(6) - y(3);
        val dz63 = z(6) - z(3);

        val dx20 = x(2) - x(0);
        val dy20 = y(2) - y(0);
        val dz20 = z(2) - z(0);

        val dx50 = x(5) - x(0);
        val dy50 = y(5) - y(0);
        val dz50 = z(5) - z(0);

        val dx64 = x(6) - x(4);
        val dy64 = y(6) - y(4);
        val dz64 = z(6) - z(4);

        val dx31 = x(3) - x(1);
        val dy31 = y(3) - y(1);
        val dz31 = z(3) - z(1);

        val dx72 = x(7) - x(2);
        val dy72 = y(7) - y(2);
        val dz72 = z(7) - z(2);

        val dx43 = x(4) - x(3);
        val dy43 = y(4) - y(3);
        val dz43 = z(4) - z(3);

        val dx57 = x(5) - x(7);
        val dy57 = y(5) - y(7);
        val dz57 = z(5) - z(7);

        val dx14 = x(1) - x(4);
        val dy14 = y(1) - y(4);
        val dz14 = z(1) - z(4);

        val dx25 = x(2) - x(5);
        val dy25 = y(2) - y(5);
        val dz25 = z(2) - z(5);

        val tripleProduct = 
            (x1:Double, y1:Double, z1:Double, 
             x2:Double, y2:Double, z2:Double, 
             x3:Double, y3:Double, z3:Double) => 
            {
                (x1)*((y2)*(z3) - (z2)*(y3)) 
              + (x2)*((z1)*(y3) - (y1)*(z3))
              + (x3)*((y1)*(z2) - (z1)*(y2))
            };

        val volume = tripleProduct(dx31 + dx72, dx63, dx20,
                                   dy31 + dy72, dy63, dy20,
                                   dz31 + dz72, dz63, dz20)
                   + tripleProduct(dx43 + dx57, dx64, dx70,
                                   dy43 + dy57, dy64, dy70,
                                   dz43 + dz57, dz64, dz70)
                   + tripleProduct(dx14 + dx25, dx61, dx50,
                                   dy14 + dy25, dy61, dy50,
                                   dz14 + dz25, dz61, dz50);

        return volume / 12.0;
    }

    /* Work Routines */

    protected def timeIncrement(domain:Domain) {
        var targetdt:Double = domain.stoptime - domain.time;

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
            newDt = gNewDt;
            Team.WORLD.allreduce(newDt, Team.MIN);

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
     * material states.
     */
    protected def lagrangeElements(domain:Domain) {
        val vnew = new Rail[Double](domain.numElem); // new relative vol -- temp

        calcLagrangeElements(domain, vnew);

        calcQForElems(domain, vnew);

        applyMaterialPropertiesForElems(domain, vnew);

        updateVolumesForElems(domain, vnew, domain.v_cut, domain.numElem);
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

    /** Calculate the volume force contribution for each mesh element. */
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
        val fx_local = new Rail[Double](8);
        val fy_local = new Rail[Double](8);
        val fz_local = new Rail[Double](8);
        // TODO these should be stack-allocated inside the loop over k
        val B = new Array_2[Double](3, 8); // shape function derivatives
        val x_local = new Rail[Double](8);
        val y_local = new Rail[Double](8);
        val z_local = new Rail[Double](8);

        // TODO parallel loop
        for (k in 0..(numElem-1)) {
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
        for (i in 0..7) {
            fx(i) = -( stress_xx * B(0,i) );
            fy(i) = -( stress_yy * B(1,i) );
            fz(i) = -( stress_zz * B(2,i) );
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
        val dvdx = new Rail[Double](numElem8);
        val dvdy = new Rail[Double](numElem8);
        val dvdz = new Rail[Double](numElem8);
        val x8n  = new Rail[Double](numElem8);
        val y8n  = new Rail[Double](numElem8);
        val z8n  = new Rail[Double](numElem8);
        // TODO these should be stack-allocated inside the loop over i
        val x1 = new Rail[Double](8);
        val y1 = new Rail[Double](8);
        val z1 = new Rail[Double](8);
        val pfx = new Rail[Double](8);
        val pfy = new Rail[Double](8);
        val pfz = new Rail[Double](8);

        // TODO parallel loop
        for (i in 0..(numElem-1)) {

            collectDomainNodesToElemNodes(domain, i, x1, y1, z1);

            calcElemVolumeDerivative(pfx, pfy, pfz, x1, y1, z1);

            /* load into temporary storage for FB Hour Glass control */
            for (ii in 0..7){
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

    @Inline def calcElemVolumeDerivative(dvdx:Rail[Double],
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

    @Inline def voluDer(x:Rail[Double], y:Rail[Double], z:Rail[Double],
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
        val hourgam = new Array_2[Double](8,4);
        val xd1 = new Rail[Double](8);
        val yd1 = new Rail[Double](8);
        val zd1 = new Rail[Double](8);
        val hgfx = new Rail[Double](8);
        val hgfy = new Rail[Double](8);
        val hgfz = new Rail[Double](8);
        // TODO parallel loop
        for (i2 in 0..(numElem-1)) {
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
        // TODO parallel for
        for (i in 0..(domain.numNode-1)) {
            domain.xdd(i) = domain.fx(i) / domain.nodalMass(i);
            domain.ydd(i) = domain.fy(i) / domain.nodalMass(i);
            domain.zdd(i) = domain.fz(i) / domain.nodalMass(i);
        }
    }

    def applyAccelerationBoundaryConditionsForNodes(domain:Domain) {
        val size = domain.sizeX;
        val numNodeBC = (size+1)*(size+1);

        if (!domain.symmXempty()) {
            // TODO parallel for
            for (i in 0..(numNodeBC-1))
                domain.xdd(domain.symmX(i)) = 0.0;
        }

        if (!domain.symmYempty()) {
            // TODO parallel for
            for (i in 0..(numNodeBC-1))
                domain.ydd(domain.symmY(i)) = 0.0;
        }

        if (!domain.symmZempty()) {
            // TODO parallel for
            for (i in 0..(numNodeBC-1))
                domain.zdd(domain.symmZ(i)) = 0.0;
        }
    }

    /** 
     * Advance velocity vector at each node. Applies a cutoff to
     * avoid spurious mesh motion due to floating point roundoff error.
     */
    def calcVelocityForNodes(domain:Domain, dt:Double, u_cut:Double) {
        // TODO parallel for
        for (i in 0..(domain.numNode-1)) {
            var xdtmp:Double = domain.xd(i) + domain.xdd(i) * dt;
            if (Math.abs(xdtmp) < u_cut) xdtmp = 0.0;
            domain.xd(i) = xdtmp;

            var ydtmp:Double = domain.yd(i) + domain.ydd(i) * dt;
            if (Math.abs(ydtmp) < u_cut) ydtmp = 0.0;
            domain.yd(i) = ydtmp;

            var zdtmp:Double = domain.zd(i) + domain.zdd(i) * dt;
            if (Math.abs(zdtmp) < u_cut) zdtmp = 0.0;
            domain.zd(i) = zdtmp;
        }
    }

    def calcPositionForNodes(domain:Domain, dt:Double) {
        // TODO parallel for
        for (i in 0..(domain.numNode-1)) {
            domain.x(i) += domain.xd(i) * dt;
            domain.y(i) += domain.yd(i) * dt;
            domain.z(i) += domain.zd(i) * dt;
        }
    }

    def calcLagrangeElements(domain:Domain, vnew:Rail[Double]) {
        val numElem = domain.numElem;
        if (numElem > 0) {
            val deltatime = domain.deltatime;

            domain.allocateStrains();

            calcKinematicsForElems(domain, vnew, deltatime);

            // element loop to do some stuff not included in the elemlib function.
            // TODO parallel for
            for (k in 0..(numElem-1)) {
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
            }
            domain.deallocateStrains();
        }
    }

    def calcKinematicsForElems(domain:Domain, vnew:Rail[Double], deltaTime:Double) {
        // TODO these should be stack-allocated inside the loop over k
        val B = new Array_2[Double](3,8); /** shape function derivatives */
        val D = new Rail[Double](6);
        val x_local = new Rail[Double](8);
        val y_local = new Rail[Double](8);
        val z_local = new Rail[Double](8);
        val xd_local = new Rail[Double](8);
        val yd_local = new Rail[Double](8);
        val zd_local = new Rail[Double](8);
        // TODO parallel loop
        for (k in 0..(domain.numElem-1)) {
            collectDomainNodesToElemNodes(domain, k, x_local, y_local, z_local);

            // volume calculations
            val volume = calcElemVolume(x_local, y_local, z_local);
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
    }

    private @Inline def calcElemCharacteristicLength(
                            x:Rail[Double], 
                            y:Rail[Double],
                            z:Rail[Double],
                            volume:Double):Double {
        var charLength:Double = 0.0;
        charLength = Math.max(charLength, areaFace(x, y, z, 0, 1, 2, 3));
        charLength = Math.max(charLength, areaFace(x, y, z, 4, 5, 6, 7));
        charLength = Math.max(charLength, areaFace(x, y, z, 0, 1, 5, 4));
        charLength = Math.max(charLength, areaFace(x, y, z, 1, 2, 6, 5));
        charLength = Math.max(charLength, areaFace(x, y, z, 2, 3, 7, 6));
        charLength = Math.max(charLength, areaFace(x, y, z, 3, 0, 4, 7));

        charLength = 4.0 * volume / Math.sqrt(charLength);

        return charLength;
    }

    private @Inline def areaFace(x:Rail[Double], y:Rail[Double], z:Rail[Double],
                                 i:Long, j:Long, k:Long, l:Long):Double {
        val fx = (x(k) - x(i)) - (x(l) - x(j));
        val fy = (y(k) - y(i)) - (y(l) - y(j));
        val fz = (z(k) - z(i)) - (z(l) - z(j));
        val gx = (x(k) - x(i)) + (x(l) - x(j));
        val gy = (y(k) - y(i)) + (y(l) - y(j));
        val gz = (z(k) - z(i)) + (z(l) - z(j));
        val area = (fx*fx + fy*fy + fz*fz) * (gx*gx + gy*gy + gz*gz)
                 - (fx*gx + fy*gy + fz*gz) * (fx*gx + fy*gy + fz*gz);
        return area;
    }

    def calcElemVelocityGradient(xvel:Rail[Double], 
                                 yvel:Rail[Double],
                                 zvel:Rail[Double],
                                 b:Array_2[Double], 
                                 detJ:Double, d:Rail[Double]) {
        val inv_detJ = 1.0 / detJ;

        d(0) = inv_detJ * ( b(0,0) * (xvel(0)-xvel(6))
                          + b(0,1) * (xvel(1)-xvel(7))
                          + b(0,2) * (xvel(2)-xvel(4))
                          + b(0,3) * (xvel(3)-xvel(5)) );

        d(1) = inv_detJ * ( b(1,0) * (yvel(0)-yvel(6))
                          + b(1,1) * (yvel(1)-yvel(7))
                          + b(1,2) * (yvel(2)-yvel(4))
                          + b(1,3) * (yvel(3)-yvel(5)) );

        d(2) = inv_detJ * ( b(2,0) * (zvel(0)-zvel(6))
                          + b(2,1) * (zvel(1)-zvel(7))
                          + b(2,2) * (zvel(2)-zvel(4))
                          + b(2,3) * (zvel(3)-zvel(5)) );

        val dyddx = inv_detJ * ( b(0,0) * (yvel(0)-yvel(6))
                               + b(0,1) * (yvel(1)-yvel(7))
                               + b(0,2) * (yvel(2)-yvel(4))
                               + b(0,3) * (yvel(3)-yvel(5)) );

        val dxddy = inv_detJ * ( b(1,0) * (xvel(0)-xvel(6))
                               + b(1,1) * (xvel(1)-xvel(7))
                               + b(1,2) * (xvel(2)-xvel(4))
                               + b(1,3) * (xvel(3)-xvel(5)) );

        val dzddx = inv_detJ * ( b(0,0) * (zvel(0)-zvel(6))
                               + b(0,1) * (zvel(1)-zvel(7))
                               + b(0,2) * (zvel(2)-zvel(4))
                               + b(0,3) * (zvel(3)-zvel(5)) );

        val dxddz = inv_detJ * ( b(2,0) * (xvel(0)-xvel(6))
                               + b(2,1) * (xvel(1)-xvel(7))
                               + b(2,2) * (xvel(2)-xvel(4))
                               + b(2,3) * (xvel(3)-xvel(5)) );

        val dzddy = inv_detJ * ( b(1,0) * (zvel(0)-zvel(6))
                               + b(1,1) * (zvel(1)-zvel(7))
                               + b(1,2) * (zvel(2)-zvel(4))
                               + b(1,3) * (zvel(3)-zvel(5)) );

        val dyddz = inv_detJ * ( b(2,0) * (yvel(0)-yvel(6))
                                + b(2,1) * (yvel(1)-yvel(7))
                                + b(2,2) * (yvel(2)-yvel(4))
                                + b(2,3) * (yvel(3)-yvel(5)) );
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
              + 2*domain.sizeX*domain.sizeY  /* plane ghosts */
              + 2*domain.sizeX*domain.sizeZ  /* row ghosts */
              + 2*domain.sizeY*domain.sizeZ; /* col ghosts */

            domain.allocateGradients(allElem);

/*    
            CommRecv(domain, MSG_MONOQ, 3,
                   domain.sizeX(), domain.sizeY(), domain.sizeZ(),
                   true, true);
*/    

            /* Calculate velocity gradients */
            calcMonotonicQGradientsForElems(domain, vnew);

            /* Transfer velocity gradients in the first order elements */
            /* problem->commElements->Transfer(CommElements::monoQ); */
/* 
            Domain_member fieldData[3];

            fieldData[0] = &Domain::delv_xi;
            fieldData[1] = &Domain::delv_eta;
            fieldData[2] = &Domain::delv_zeta;

            CommSend(domain, MSG_MONOQ, 3, fieldData,
                   domain.sizeX(), domain.sizeY(), domain.sizeZ(),
                   true, true);

            CommMonoQ(domain);
*/      

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
        val numElem = domain.numElem;
        // TODO parallel for
        for (i in 0..(numElem-1)) {
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
        }
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

        // TODO parallel for
        for (ielem in 0..(domain.regElemSize(r)-1)) {
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
        }
    }

    /** Update pressure and internal energy variables for the new timestep. */
    protected def applyMaterialPropertiesForElems(domain:Domain, vnew:Rail[Double]) {
        val numElem = domain.numElem;

        if (numElem != 0) {
            /* Expose all of the variables needed for material evaluation */
            val eosvmin = domain.eosvmin;
            val eosvmax = domain.eosvmax;

            // Bound the updated relative volumes with eosvmin/max
            if (eosvmin != 0.0) {
                // TODO parallel loop
                for (i in 0..(numElem-1)) {
                    if (vnew(i) < eosvmin) vnew(i) = eosvmin;
                }
            }

            if (eosvmax != 0.0) {
                // TODO parallel loop
                for (i in 0..(numElem-1)) {
                    if (vnew(i) > eosvmax) vnew(i) = eosvmax;
                }
            }

            // This check may not make perfect sense in LULESH, but
            // it's representative of something in the full code -
            // just leave it in, please
            // TODO parallel loop
            for (i in 0..(numElem-1)) {
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
            }

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
        val e_old = new Rail[Double](numElemReg);
        val delvc = new Rail[Double](numElemReg);
        val p_old = new Rail[Double](numElemReg);
        val q_old = new Rail[Double](numElemReg);
        val compression = new Rail[Double](numElemReg);
        val compHalfStep = new Rail[Double](numElemReg);
        val qq_old = new Rail[Double](numElemReg);
        val ql_old = new Rail[Double](numElemReg);
        val work = new Rail[Double](numElemReg);
        val p_new = new Rail[Double](numElemReg);
        val e_new = new Rail[Double](numElemReg);
        val q_new = new Rail[Double](numElemReg);
        val bvc = new Rail[Double](numElemReg);
        val pbvc = new Rail[Double](numElemReg);

        //loop to add load imbalance based on region number 
        for(j in 0..(rep-1)) {
            /* compress data, minimal set */
            // TODO parallel for
            for (i in 0..(numElemReg-1)) {
                val elem = regElemList(i);
                e_old(i) = domain.e(elem);
                delvc(i) = domain.delv(elem);
                p_old(i) = domain.p(elem);
                q_old(i) = domain.q(elem);
                qq_old(i) = domain.qq(elem);
                ql_old(i) = domain.ql(elem);
            }

            // TODO parallel for
            for (i in 0..(numElemReg-1)) {
                val elem = regElemList(i);
                compression(i) = 1.0 / vnewc(elem) - 1.0;
                val vchalf = vnewc(elem) - delvc(i) * 0.5;
                compHalfStep(i) = 1.0 / vchalf - 1.0;
            }

            /* Check for v > eosvmax or v < eosvmin */
            if ( eosvmin != 0.0 ) {
            // TODO parallel for
            for (i in 0..(numElemReg-1)) {
                val elem = regElemList(i);
                if (vnewc(elem) <= eosvmin) { /* impossible due to calling func? */
                    compHalfStep(i) = compression(i);
                }
            }

            if (eosvmax != 0.0 ) {
                // TODO parallel for
                for (i in 0..(numElemReg-1)) {
                   val elem = regElemList(i);
                   if (vnewc(elem) >= eosvmax) { /* impossible due to calling func? */
                      p_old(i)        = 0.0;
                      compression(i)  = 0.0;
                      compHalfStep(i) = 0.0;
                   }
                }
             }

            // TODO parallel for
            for (i in 0..(numElemReg-1)) {
                work(i) = 0.0; 
            }
        }

        calcEnergyForElems(p_new, e_new, q_new, bvc, pbvc,
                         p_old, e_old, q_old, compression, compHalfStep,
                         vnewc, work, delvc, pmin,
                         p_cut, e_cut, q_cut, emin,
                         qq_old, ql_old, rho0, eosvmax,
                         numElemReg, regElemList);
        }

        // TODO parallel for
        for (i in 0..(numElemReg-1)) {
            val elem = regElemList(i);
            domain.p(elem) = p_new(i);
            domain.e(elem) = e_new(i);
            domain.q(elem) = q_new(i);
        }

        calcSoundSpeedForElems(domain,
                          vnewc, rho0, e_new, p_new,
                          pbvc, bvc, ss4o3,
                          numElemReg, regElemList);
    }

    private @Inline def calcEnergyForElems(p_new:Rail[Double],
                e_new:Rail[Double], q_new:Rail[Double], 
                bvc:Rail[Double], pbvc:Rail[Double],
                p_old:Rail[Double], e_old:Rail[Double], q_old:Rail[Double],
                compression:Rail[Double], compHalfStep:Rail[Double],
                vnewc:Rail[Double], work:Rail[Double], 
                delvc:Rail[Double], pmin:Double,
                p_cut:Double, e_cut:Double, q_cut:Double, emin:Double,
                qq_old:Rail[Double], ql_old:Rail[Double],
                rho0:Double, eosvmax:Double,
                length:Long, regElemList:Rail[Long]) {
        val pHalfStep = new Rail[Double](length);

        // TODO parallel for
        for (i in 0..(length-1)) {
            e_new(i) = e_old(i) - 0.5 * delvc(i) * (p_old(i) + q_old(i))
                     + 0.5 * work(i);

            if (e_new(i) < emin) {
                e_new(i) = emin;
            }
        }

        calcPressureForElems(pHalfStep, bvc, pbvc, e_new, compHalfStep, vnewc,
                            pmin, p_cut, eosvmax, length, regElemList);

        // TODO parallel for
        for (i in 0..(length-1)) {
            val vhalf = 1.0 / (1.0 + compHalfStep(i));

            if (delvc(i) > 0.0) {
                q_new(i) /* = qq_old(i) = ql_old(i) */ = 0.0;
            } else {
                var ssc:Double = ( pbvc(i) * e_new(i)
                        + vhalf * vhalf * bvc(i) * pHalfStep(i) ) 
                    / rho0;

                if (ssc <= 0.1111111e-36) {
                    ssc = 0.3333333e-18;
                } else {
                    ssc = Math.sqrt(ssc);
                }

                q_new(i) = (ssc*ql_old(i) + qq_old(i));
            }

            e_new(i) = e_new(i) 
                     + 0.5 * delvc(i) 
                     * (3.0*(p_old(i)+q_old(i)) - 4.0*(pHalfStep(i)+q_new(i)));
        }

        // TODO parallel for
        for (i in 0..(length-1)) {
            e_new(i) += 0.5 * work(i);

            if (Math.abs(e_new(i)) < e_cut) {
                e_new(i) = 0.0;
            }
            if (e_new(i) < emin) {
                e_new(i) = emin;
            }
        }

        calcPressureForElems(p_new, bvc, pbvc, e_new, compression, vnewc,
                            pmin, p_cut, eosvmax, length, regElemList);

        // TODO parallel for
        for (i in 0..(length-1)) {
            val sixth = 1.0 / 6.0;
            val elem = regElemList(i);
            var q_tilde:Double;

            if (delvc(i) > 0.0) {
                q_tilde = 0.0;
            } else {
                var ssc:Double = (pbvc(i) * e_new(i)
                        + vnewc(elem) * vnewc(elem) * bvc(i) * p_new(i) )
                     / rho0;

                if (ssc <= 0.1111111e-36) {
                    ssc = 0.3333333e-18;
                } else {
                    ssc = Math.sqrt(ssc);
                }

                q_tilde = (ssc*ql_old(i) + qq_old(i));
            }

            e_new(i) = e_new(i) - (  7.0*(p_old(i)     + q_old(i))
                                   - 8.0*(pHalfStep(i) + q_new(i))
                                   + (p_new(i) + q_tilde)) * delvc(i)*sixth;

            if (Math.abs(e_new(i)) < e_cut) {
                e_new(i) = 0.0;
            }
            if (e_new(i) < emin) {
                e_new(i) = emin;
            }
        }

        calcPressureForElems(p_new, bvc, pbvc, e_new, compression, vnewc,
                            pmin, p_cut, eosvmax, length, regElemList);

        // TODO parallel for
        for (i in 0..(length-1)) {
            val elem = regElemList(i);

            if (delvc(i) <= 0.0) {
                var ssc:Double = (pbvc(i) * e_new(i)
                        + vnewc(elem) * vnewc(elem) * bvc(i) * p_new(i) )
                    / rho0;

             if (ssc <= 0.1111111e-36) {
                ssc = 0.3333333e-18;
             } else {
                ssc = Math.sqrt(ssc);
             }

             q_new(i) = (ssc*ql_old(i) + qq_old(i));

             if (Math.abs(q_new(i)) < q_cut) q_new(i) = 0.0;
          }
        }
    }

    def calcPressureForElems(p_new:Rail[Double], 
                bvc:Rail[Double], pbvc:Rail[Double],
                e_old:Rail[Double], compression:Rail[Double],
                vnewc:Rail[Double], pmin:Double,
                p_cut:Double,eosvmax:Double,
                length:Long, regElemList:Rail[Long]) {
        // TODO parallel for
        for (i in 0..(length-1)) {
            val c1s = 2.0 / 3.0;
            bvc(i) = c1s * (compression(i) + 1.0);
            pbvc(i) = c1s;
        }

        // TODO parallel for
        for (i in 0..(length-1)) {
            val elem = regElemList(i);
          
            p_new(i) = bvc(i) * e_old(i);

            if (Math.abs(p_new(i)) < p_cut)
                p_new(i) = 0.0;

            if (vnewc(elem) >= eosvmax) /* impossible condition here? */
                p_new(i) = 0.0;

            if  (p_new(i) <  pmin)
                p_new(i) = pmin;
        }
    }

    def calcSoundSpeedForElems(domain:Domain, vnewc:Rail[Double], 
                            rho0:Double, enewc:Rail[Double],
                            pnewc:Rail[Double], pbvc:Rail[Double],
                            bvc:Rail[Double], ss4o3:Double,
                            len:Long, regElemList:Rail[Long]) {
        // TODO parallel for
        for (i in 0..(len-1)) {
            val elem = regElemList(i);
            var ssTmp:Double = (pbvc(i) * enewc(i) + vnewc(elem) * 
                                vnewc(elem) * bvc(i) * pnewc(i)) / rho0;
            if (ssTmp <= 0.1111111e-36) {
                ssTmp = 0.3333333e-18;
            } else {
                ssTmp = Math.sqrt(ssTmp);
            }
            domain.ss(elem) = ssTmp;
        }
    }

    def updateVolumesForElems(domain:Domain, vnew:Rail[Double], 
                              v_cut:Double, length:Long) {
        if (length != 0) {
            // TODO parallel for
            for (i in 0..(length-1)) {
                var tmpV:Double = vnew(i);
                // cutoff to avoid spurious volume change due to rounding error
                if (Math.abs(tmpV - 1.0) < v_cut) tmpV = 1.0;
                domain.v(i) = tmpV;
            }
        }
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
            dtf = Math.sqrt(dtf);
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

        var elemId:Long = 0;
        Console.OUT.printf("Run completed:  \n");
        Console.OUT.printf("   Problem size        =  %i \n",    nx);
        Console.OUT.printf("   Place.MAX_PLACES    =  %i \n",    Place.MAX_PLACES);
        Console.OUT.printf("   Iteration count     =  %i \n",    domain.cycle);
        Console.OUT.printf("   Final Origin Energy = %12.6e \n", domain.e(elemId));

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
}

// TODO Precision specification

// vim:tabstop=4:shiftwidth=4:expandtab
