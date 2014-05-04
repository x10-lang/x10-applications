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
import x10.util.Random;

/**
 * Represents the simulation domain for LULESH as an unstructured hexahedral
 * mesh with two centerings. The element centering (at the center of each
 * hexahedron) stores thermodynamic variables, such as energy and pressure.
 * The nodal centering (where the corners of hexahedrons intersect) stores
 * kinematics values, such as positions and velocities. 
 * @see "I. Karlin et al. LULESH Programming Model and Performance Ports 
    Overview, December 2012, pages 1-17, LLNL-TR-608824."
 */
public class Domain {
    // TODO persistent region, element and node members should be val not var

    // Cutoffs (treat as constants)
    /** energy tolerance */
    public val e_cut = 1.0e-7;
    /** pressure tolerance */
    public val p_cut = 1.0e-7;
    /** viscosity tolerance */
    public val q_cut = 1.0e-7;
    /** relative volume tolerance */
    public val v_cut = 1.0e-10;
    /** velocity tolerance */
    public val u_cut = 1.0e-7;

    // Other constants (usually settable, but hardcoded in this proxy app)
    /** hourglass control */
    public val hgcoef = 3.0;
    public val ss4o3 = 4.0 / 3.0;
    /** excessive q indicator */
    public val qstop = 1.0e+12;
    public val monoq_max_slope = 1.0;
    public val monoq_limiter_mult = 2.0;
    /** linear term coef for q */
    public val qlc_monoq = 0.5;
    /** quadratic term coef for q */
    public val qqc_monoq = 2.0 / 3.0;
    public val qqc = 2.0;
    public val eosvmax = 1.0e+9;
    public val eosvmin = 1.0e-9;
    /** pressure floor */
    public val pmin = 0.0;
    /** energy floor */
    public val emin = -1.0e+15;
    /** maximum allowable volume change */
    public val dvovmax = 0.1;
    /** reference density */
    public val m_refdens = 1.0;

    // These can be changed (requires recompile) if you want to run
    // with a fixed timestep, or to a different end time, but it's
    // probably easier/better to just run a fixed number of timesteps
    // using the -i flag in 2.x

    /** fixed time increment */
    public val dtfixed = -1.0e-6; // Negative means use courant condition
    /** end time for simulation */
    public val stoptime = 1.0e-2; // *Real_t(edgeElems*tp/45.0);

    /** courant constraint */
    public var dtcourant:Double;
    /** volume change constraint */
    public var dthydro:Double;
    /** variable time increment lower bound */
    public var deltatimemultlb:Double;
    /** variable time increment upper bound */
    public var deltatimemultub:Double;
    /** maximum allowable time increment */
    public var dtmax:Double;

    /** Energy */
    public var e:Rail[Double];
    /** Pressure */
    public var p:Rail[Double];
    /** Artificial viscosity */
    public var q:Rail[Double];
    /** Linear term for q */
    public var ql:Rail[Double];
    /** Quadratic term for q */
    public var qq:Rail[Double];

    /** reference volume */
    public var volo:Rail[Double];
    /** Relative volume */
    public var v:Rail[Double];
    public var delv:Rail[Double];
    /** volume derivative over volume */
    public var vdov:Rail[Double];
    /** Element characteristic length */
    public var arealg:Rail[Double];
    /** "sound speed" */
    public var ss:Rail[Double];
    /** Element mass */
    public var elemMass:Rail[Double];

    public val sizeX:Long;
    public val sizeY:Long;
    public val sizeZ:Long;
    public val numElem:Long;
    public val numNode:Long;

    /** iteration count for simulation */
    public var cycle:Int;
    /** current time */
    public var time:Double;
    /** variable time increment */
    public var deltatime:Double;

    /** Elapsed time for computation TODO remove this from Domain */
    public var elapsedTimeMillis:Long;

    /** length of cube mesh along side */
    public val nx:Long;
    /** Number of places per side of cubic decomposition */
    public val tp:Long;

    // mesh decomposition TODO use DistArray?
    public val colLoc:Long;
    public val rowLoc:Long;
    public val planeLoc:Long;

    // Node-centered
    // coordinates
    public var x:Rail[Double];
    public var y:Rail[Double];
    public var z:Rail[Double];
    // velocities
    public var xd:Rail[Double];
    public var yd:Rail[Double];
    public var zd:Rail[Double];
    // accelerations
    public var xdd:Rail[Double];
    public var ydd:Rail[Double];
    public var zdd:Rail[Double];
    // forces
    public var fx:Rail[Double];
    public var fy:Rail[Double];
    public var fz:Rail[Double];
    /** mass */
    public var nodalMass:Rail[Double];
    // symmetry plane nodesets
    public var symmX:Rail[Double];
    public var symmY:Rail[Double];
    public var symmZ:Rail[Double];

    // Element-centered

    // Region information

    /** Number of distinct regions */
    public val numReg:Int;
    /** Extra cost of more expensive regions */
    public val cost:Int;
    /** Size of region sets */
    public var regElemSize:Rail[Long];
    /** Region (material) number per domain element */
    public var regNumList:Rail[Long];
    /** Region indexset */
    public var regElemList:Rail[Rail[Long]];

    /** elemToNode connectivity */
    public var nodelist:Rail[Long];

    /* element connectivity across each face */
    public var lxim:Rail[Long];
    public var lxip:Rail[Long];
    public var letam:Rail[Long];
    public var letap:Rail[Long];
    public var lzetam:Rail[Long];
    public var lzetap:Rail[Long];

    /** symmetry/free-surface flags for each element face */
    public var elemBC:Rail[Int];

    // Stuff needed for boundary conditions
    // 2 BCs on each of 6 hexahedral faces (12 bits)
    static val XI_M        :Int = 0x00007n;
    static val XI_M_SYMM   :Int = 0x00001n;
    static val XI_M_FREE   :Int = 0x00002n;
    static val XI_M_COMM   :Int = 0x00004n;

    static val XI_P        :Int = 0x00038n;
    static val XI_P_SYMM   :Int = 0x00008n;
    static val XI_P_FREE   :Int = 0x00010n;
    static val XI_P_COMM   :Int = 0x00020n;

    static val ETA_M       :Int = 0x001c0n;
    static val ETA_M_SYMM  :Int = 0x00040n;
    static val ETA_M_FREE  :Int = 0x00080n;
    static val ETA_M_COMM  :Int = 0x00100n;

    static val ETA_P       :Int = 0x00e00n;
    static val ETA_P_SYMM  :Int = 0x00200n;
    static val ETA_P_FREE  :Int = 0x00400n;
    static val ETA_P_COMM  :Int = 0x00800n;

    static val ZETA_M      :Int = 0x07000n;
    static val ZETA_M_SYMM :Int = 0x01000n;
    static val ZETA_M_FREE :Int = 0x02000n;
    static val ZETA_M_COMM :Int = 0x04000n;

    static val ZETA_P      :Int = 0x38000n;
    static val ZETA_P_SYMM :Int = 0x08000n;
    static val ZETA_P_FREE :Int = 0x10000n;
    static val ZETA_P_COMM :Int = 0x20000n;

    public def this(nx:Long, nr:Int, balance:Int, cost:Int) {
        this.nx = nx;
        this.numReg = nr;
        this.cost = cost;
        val edgeElems = nx;
        val edgeNodes = edgeElems+1;
        val grid = MeshDecomposition.getPlaceGridLoc();
        this.tp = grid.placesPerSide;
        this.colLoc = grid.col;
        this.rowLoc = grid.row;
        this.planeLoc = grid.plane;

        // Initialize Sedov Mesh

        // construct a uniform box for this processor

        this.sizeX = edgeElems;
        this.sizeY = edgeElems;
        this.sizeZ = edgeElems;
        this.numElem = edgeElems*edgeElems*edgeElems;
        this.numNode = edgeNodes*edgeNodes*edgeNodes;

        allocateElemPersistent(numElem);

        allocateNodePersistent(numNode);

        setupBoundaryNodesets(edgeNodes);

        createRegionIndexSets(nr, balance);

        setupSymmetryPlanes(edgeNodes);

        setupElementConnectivities(edgeElems);

        setupBoundaryConditions(edgeElems);

        // Initial conditions
        deltatimemultlb = 1.1;
        deltatimemultub = 1.2;
        dtcourant = 1.0e+20;
        dthydro   = 1.0e+20;
        dtmax     = 1.0e-2;
        time  = 0.0;
        cycle = 0n;

        // initialize field data 
        for (i in 0..(numElem-1)) {
            val x_local = new Rail[Double](8);
            val y_local = new Rail[Double](8);
            val z_local = new Rail[Double](8);
            val elemStart = 8*i;
            for(lnode in 0..7) {
                val gnode = nodelist(elemStart+lnode);
                x_local(lnode) = x(gnode);
                y_local(lnode) = y(gnode);
                z_local(lnode) = z(gnode);
            }

            // volume calculations
            val volume = Lulesh.calcElemVolume(x_local, y_local, z_local);
            volo(i) = volume;
            elemMass(i) = volume;
            for (j in 0..7) {
                val idx = nodelist(elemStart+j);
                nodalMass(idx) += volume / 8.0;
            }
        }

        // deposit initial energy
        // An energy of 3.948746e+7 is correct for a problem with
        // 45 zones along a side - we need to scale it
        val ebase = 3.948746e+7;
        val scale = (nx * tp) / 45.0;
        val einit = ebase*scale*scale*scale;
        if (rowLoc + colLoc + planeLoc == 0) {
            // Dump into the first zone (which we know is in the corner)
            // of the domain that sits at the origin
            e(0) = einit;
        }
        //set initial deltatime base on analytic CFL calculation
        deltatime = (0.5 * Math.cbrt(volo(0))) / Math.sqrt(2.0) * einit;
    }

    /** Allocate element-centered quantities */
    private @NonEscaping def allocateElemPersistent(numElem:Long):void {
        nodelist = new Rail[Long](8*numElem);

        // elem connectivities through face
        lxim = new Rail[Long](numElem);
        lxip = new Rail[Long](numElem);
        letam = new Rail[Long](numElem);
        letap = new Rail[Long](numElem);
        lzetam = new Rail[Long](numElem);
        lzetap = new Rail[Long](numElem);

        e = new Rail[Double](numElem);
        p = new Rail[Double](numElem);

        q = new Rail[Double](numElem);
        ql = new Rail[Double](numElem);
        qq = new Rail[Double](numElem);

        v = new Rail[Double](numElem);

        volo = new Rail[Double](numElem);
        delv = new Rail[Double](numElem);
        vdov = new Rail[Double](numElem);

        arealg = new Rail[Double](numElem);

        ss = new Rail[Double](numElem);
        elemMass = new Rail[Double](numElem);
    }

    /** Allocate node-centered quantities */
    private @NonEscaping def allocateNodePersistent(numNode:Long):void {
        x = new Rail[Double](numNode);  // coordinates
        y = new Rail[Double](numNode);
        z = new Rail[Double](numNode);

        xd = new Rail[Double](numNode); // velocities
        yd = new Rail[Double](numNode);
        zd = new Rail[Double](numNode);

        xdd = new Rail[Double](numNode); // accelerations
        ydd = new Rail[Double](numNode);
        zdd = new Rail[Double](numNode);

        fx = new Rail[Double](numNode); // forces
        fy = new Rail[Double](numNode);
        fz = new Rail[Double](numNode);

        nodalMass = new Rail[Double](numNode); // mass
    }

    /** 
     * Setup region index sets. For now, these are constant sized
     * throughout the run, but could be changed every cycle to 
     * simulate effects of ALE on the Lagrange solver.
     * @param balance the balance parameter used to determine the relative
     *    weights of all regions, sourced from the -b command line parameter
     */
    private @NonEscaping def createRegionIndexSets(nr:Int, balance:Int) {
        // TODO everything
        regNumList = new Rail[Long](numElem);
        regElemSize = new Rail[Long](nr);
        regElemList = new Rail[Rail[Long]](nr);

        val rand = new Random(here.id);

        var nextIndex:Long = 0;
        if (numReg == 1n) {
            // Fill out the regNumList with material numbers, which are always
            // the region index plus one 
            while (nextIndex < numElem) {
                this.regNumList(nextIndex) = 1;
                nextIndex++;
            }
            regElemSize(0) = 0;
        } else {
            // distribute the elements

            // Determine the relative weights of all the regions.
            var lastReg:Long = -1;
            var costDenominator:Int = 0n; // Total sum of all regions' weights
            val regBinEnd = new Rail[Int](numReg); // Chance of hitting a given region is (regBinEnd(i) - regBinEnd(i-1))/costDenominator
            for (i in 0..(numReg-1)) {
                regElemSize(i) = 0;
                costDenominator += Math.pow((i+1), balance);  
                regBinEnd(i) = costDenominator;  
            }
            // Until all elements are assigned
            while (nextIndex < numElem) {
                // pick the region
                var regionVar:Long = rand.nextInt() % costDenominator;
                var i:Long = 0;
                while(regionVar >= regBinEnd(i))
                    i++;
                // Rotate the regions based on place ID.  Rotation is 
                // here.id % NumRegions . This makes each domain have a
                // different region with the highest representation
                var regionNum:Long = ((i + here.id) % numReg) + 1;
                // make sure we don't pick the same region twice in a row
                while(regionNum == lastReg) {
                    regionVar = rand.nextInt() % costDenominator;
                    i = 0;
                    while(regionVar >= regBinEnd(i))
                        i++;
                    regionNum = ((i + here.id) % numReg) + 1;
                }

                // Pick the bin size of the region and determine the number of elements.
                val binSize = rand.nextInt() % 1000;
                var elements:Long;
                if (binSize < 773) {
                    elements = rand.nextInt() % 15 + 1;
                } else if (binSize < 937) {
                    elements = rand.nextInt() % 16 + 16;
                } else if (binSize < 970) {
                    elements = rand.nextInt() % 32 + 32;
                } else if (binSize < 974) {
                    elements = rand.nextInt() % 64 + 64;
                } else if (binSize < 978) {
                    elements = rand.nextInt() % 128 + 128;
                } else if (binSize < 981) {
                    elements = rand.nextInt() % 256 + 256;
                } else {
                    elements = rand.nextInt() % 1537 + 512;
                }
                val runTo = elements + nextIndex;
                // Store the elements.  If we hit the end before we run out of elements then just stop.
                while (nextIndex < runTo && nextIndex < numElem) {
                    this.regNumList(nextIndex) = regionNum;
                    nextIndex++;
                }
                lastReg = regionNum;
            }
        }
        // Convert regNumList to region index sets
        // First, count size of each region 
        for (i in 0..(numElem-1)) {
            val r = this.regNumList(i)-1;  // region index == regnum-1
            regElemSize(r)++;
        }
        // Second, allocate each region index set
        for (i in 0..(numReg-1)) {
            regElemList(i) = new Rail[Long](regElemSize(i));
            regElemSize(i) = 0;
        }
        // Third, fill index sets
        for (i in 0..(numElem-1)) {
            val r = regNumList(i)-1;       // region index == regnum-1
            val regndx = regElemSize(r)++; // Note increment
            regElemList(r)(regndx) = i;
        }
    }

    private @NonEscaping def setupBoundaryNodesets(edgeNodes:Long) {
        if (colLoc == 0)
            symmX = new Rail[Double](edgeNodes*edgeNodes);
        if (rowLoc == 0)
            symmY = new Rail[Double](edgeNodes*edgeNodes);
        if (planeLoc == 0)
            symmZ = new Rail[Double](edgeNodes*edgeNodes);
    }

    /** Setup symmetry nodesets */
    private @NonEscaping def setupSymmetryPlanes(edgeNodes:Long) {
        var nidx:Long = 0;
        for (i in 0..(edgeNodes-1)) {
            val planeInc = i*edgeNodes*edgeNodes;
            val rowInc   = i*edgeNodes;
            for (j in 0..(edgeNodes-1)) {
                if (planeLoc == 0) {
                    symmZ(nidx) = rowInc   + j;
                }
                if (rowLoc == 0) {
                    symmY(nidx) = planeInc + j;
                }
                if (colLoc == 0) {
                    symmX(nidx) = planeInc + j*edgeNodes;
                }
                ++nidx;
            }
        }
    }

    /** Setup element connectivities */
    private @NonEscaping def setupElementConnectivities(edgeElems:Long) {
        lxim(0) = 0;
        for (i in 1..(numElem-1)) {
            lxim(i)   = i-1;
            lxip(i-1) = i;
        }
        lxip(numElem-1) = numElem-1;

        for (i in 0..(edgeElems-1)) {
            letam(i) = i; 
            letap(numElem-edgeElems+i) = numElem-edgeElems+i;
        }
        for (i in edgeElems..(numElem-1)) {
            letam(i) = i-edgeElems;
            letap(i-edgeElems) = i;
        }

        for (i in 0..(edgeElems*edgeElems-1)) {
            lzetam(i) = i;
            lzetap(numElem-edgeElems*edgeElems+i) = numElem-edgeElems*edgeElems+i;
        }
        for (i in (edgeElems*edgeElems)..(numElem-1)) {
            lzetam(i) = i - edgeElems*edgeElems;
            lzetap(i-edgeElems*edgeElems) = i;
        }
    }

    /** Setup symmetry planes and free surface boundary arrays */
    private @NonEscaping def setupBoundaryConditions(edgeElems:Long) {
        val rowMin = (rowLoc != 0);
        val rowMax = (rowLoc != tp-1);
        val colMin = (colLoc != 0);
        val colMax = (colLoc != tp-1);
        val planeMin = (planeLoc != 0);
        val planeMax = (planeLoc != tp-1);

        // offsets to ghost locations
        val ghostIdx = new Rail[Long](6, Int.MIN_VALUE);

        var pidx:Long = numElem;
        if (planeMin) {
            ghostIdx(0) = pidx;
            pidx += sizeX*sizeY;
        }

        if (planeMax) {
            ghostIdx(1) = pidx;
            pidx += sizeX*sizeY;
        }

        if (rowMin) {
            ghostIdx(2) = pidx;
            pidx += sizeX*sizeZ;
        }

        if (rowMax) {
            ghostIdx(3) = pidx;
            pidx += sizeX*sizeZ;
        }

        if (colMin) {
            ghostIdx(4) = pidx;
            pidx += sizeY*sizeZ;
        }

        if (colMax) {
            ghostIdx(5) = pidx;
        }

        // symmetry plane or free surface BCs
        elemBC = new Rail[Int](numElem);
        for (i in 0..(edgeElems-1)) {
            val planeInc = i*edgeElems*edgeElems;
            val rowInc   = i*edgeElems;
            for (j in 0..(edgeElems-1)) {
                if (planeLoc == 0) {
                    elemBC(rowInc+j) |= ZETA_M_SYMM;
                } else {
                    elemBC(rowInc+j) |= ZETA_M_COMM;
                    lzetam(rowInc+j) = ghostIdx(0) + rowInc + j;
                }

                if (planeLoc == tp-1) {
                    elemBC(rowInc+j+numElem-edgeElems*edgeElems) |=
                        ZETA_P_FREE;
                } else {
                    elemBC(rowInc+j+numElem-edgeElems*edgeElems) |=
                        ZETA_P_COMM;
                    lzetap(rowInc+j+numElem-edgeElems*edgeElems) =
                    ghostIdx(1) + rowInc + j;
                }

                if (rowLoc == 0) {
                    elemBC(planeInc+j) |= ETA_M_SYMM;
                } else {
                    elemBC(planeInc+j) |= ETA_M_COMM;
                    letam(planeInc+j) = ghostIdx(2) + rowInc + j;
                }

                if (rowLoc == tp-1) {
                    elemBC(planeInc+j+edgeElems*edgeElems-edgeElems) |= 
                        ETA_P_FREE;
                } else {
                    elemBC(planeInc+j+edgeElems*edgeElems-edgeElems) |= 
                        ETA_P_COMM;
                    letap(planeInc+j+edgeElems*edgeElems-edgeElems) =
                    ghostIdx(3) +  rowInc + j;
                }

                if (colLoc == 0) {
                    elemBC(planeInc+j*edgeElems) |= XI_M_SYMM;
                } else {
                    elemBC(planeInc+j*edgeElems) |= XI_M_COMM;
                    lxim(planeInc+j*edgeElems) = ghostIdx(4) + rowInc + j;
                }

                if (colLoc == tp-1) {
                    elemBC(planeInc+j*edgeElems+edgeElems-1) |= XI_P_FREE;
                } else {
                    elemBC(planeInc+j*edgeElems+edgeElems-1) |= XI_P_COMM;
                    lxip(planeInc+j*edgeElems+edgeElems-1) =
                        ghostIdx(5) + rowInc + j;
                }
            }
        }
    }
}
// vim:tabstop=4:shiftwidth=4:expandtab
