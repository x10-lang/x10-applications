/// \file
/// Functions to maintain link cell structures for fast pair finding.

package comd;

public class LinkCells {
    /// The maximum number of atoms that can be stored in a link cell.
    static val MAXATOMS = 64n; 

    /// Link cell data.  For convenience, we keep a copy of the localMin and
    /// localMax coordinates that are also found in the DomainsSt.
    public static class LinkCell {
    	var gridSize:Rail[Int] = new Rail[Int](3);     //!< number of boxes in each dimension on processor
    	var nLocalBoxes:Int;     //!< total number of local boxes on processor
    	var nHaloBoxes:Int;      //!< total number of remote halo/ghost boxes on processor
    	var nTotalBoxes:Int;     //!< total number of boxes on processor
    	//!< nLocalBoxes + nHaloBoxes
    	var localMin:MyTypes.real3 = new MyTypes.real3(3);      //!< minimum local bounds on processor
    	var localMax:MyTypes.real3 = new MyTypes.real3(3);      //!< maximum local bounds on processor
    	var boxSize:MyTypes.real3 = new MyTypes.real3(3);       //!< size of box in each dimension
    	var invBoxSize:MyTypes.real3 = new MyTypes.real3(3);    //!< inverse size of box in each dimension

    	var nAtoms:Rail[Int];         //!< total number of atoms in each box
    }
    
    val par:Parallel;
    val per:PerformanceTimer;
    static val ix:Cell[Int] = new Cell[Int](0n); //OPT: Change to 'static'
	static val iy:Cell[Int] = new Cell[Int](0n); //OPT: Change to 'static'
	static val iz:Cell[Int] = new Cell[Int](0n); //OPT: Change to 'static'
    static val xyz:Rail[MyTypes.real_t] = new Rail[MyTypes.real_t](3);  //OPT: Change to 'static'
    def this (par:Parallel, per:PerformanceTimer) {
    	this.par = par;
    	this.per = per;
//OPT: Change to 'static'
//    	this.ix = new Cell[Int](0n);
//    	this.iy = new Cell[Int](0n);
//    	this.iz = new Cell[Int](0n);
//    	this.xyz = new Rail[MyTypes.real_t](3);
    }
    /// In CoMD 1.1, atoms are stored in link cells.  Link cells are widely
    /// used in classical MD to avoid an O(N^2) search for atoms that
    /// interact.  Link cells are formed by subdividing the local spatial
    /// domain with a Cartesian grid where the grid spacing in each
    /// direction is at least as big as he potential's cutoff distance.
    /// Because atoms don't interact beyond the potential cutoff, for an
    /// atom iAtom in any given link cell, we can be certain that all atoms
    /// that interact with iAtom are contained in the same link cell, or one
    /// of the 26 neighboring link cells.
    /// 
    /// CoMD chooses the link cell size (boxSize) on each axis to be the
    /// shortest possible distance, longer than cutoff, such that the local
    /// domain size divided by boxSize is an integer.  I.e., the link cells
    /// are commensurate with with the local domain size.  While this does
    /// not result in the smallest possible link cells, it does allow us to
    /// keep a strict separation between the link cells that are entirely
    /// inside the local domain and those that represent halo regions.
    ///
    /// The number of local link cells in each direction is stored in
    /// gridSize.  Local link cells have 3D grid coordinates (ix, iy, iz)
    /// where ix, iy, and iz can range from 0 to gridSize[iAxis]-1,
    /// whiere iAxis is 0 for x, 1 for y and 2 for the z direction.  The
    /// number of local link cells is thus nLocalBoxes =
    /// gridSize[0]*gridSize[1]*gridSize[2].
    ///
    /// The local link cells are surrounded by one complete shell of halo
    /// link cells.  The halo cells provide temporary storage for halo or
    /// "ghost" atoms that belong to other tasks, but whose coordinates are
    /// needed locally to complete the force calculation.  Halo link cells
    /// have at least one coordinate with a value of either -1 or
    /// gridSize[iAxis].
    ///
    /// Because CoMD stores data in ordinary 1D C arrays, a mapping is
    /// needed from the 3D grid coords to a 1D array index.  For the local
    /// cells we use the conventional mapping ix + iy*nx + iz*nx*ny.  This
    /// keeps all of the local cells in a contiguous region of memory
    /// starting from the beginning of any relevant array and makes it easy
    /// to iterate the local cells in a single loop.  Halo cells are mapped
    /// differently.  After the local cells, the two planes of link cells
    /// that are face neighbors with local cells across the -x or +x axis
    /// are next.  These are followed by face neighbors across the -y and +y
    /// axis (including cells that are y-face neighbors with an x-plane of
    /// halo cells), followed by all remaining cells in the -z and +z planes
    /// of halo cells.  The total number of link cells (on each rank) is
    /// nTotalBoxes.
    ///
    /// Data storage arrays that are used in association with link cells
    /// should be allocated to store nTotalBoxes*MAXATOMS items.  Data for
    /// the first atom in linkCell iBox is stored at index iBox*MAXATOMS.
    /// Data for subsequent atoms in the same link cell are stored
    /// sequentially, and the number of atoms in link cell iBox is
    /// nAtoms[iBox].
    ///
    /// \see getBoxFromTuple is the 3D->1D mapping for link cell indices.
    /// \see getTuple is the 1D->3D mapping
    ///
    /// \param [in] cutoff The cutoff distance of the potential.
    public def initLinkCells(domain:Decomposition.Domain, cutoff:MyTypes.real_t):LinkCell {
    	assert domain != null;
    	val ll = new LinkCell();

    	for (var i:Long = 0; i < 3; i++) {
    		ll.localMin(i) = domain.localMin(i);
    		ll.localMax(i) = domain.localMax(i);
    		ll.gridSize(i) = (domain.localExtent(i) / cutoff) as Int; // local number of boxes
    		ll.boxSize(i) = domain.localExtent(i) / (ll.gridSize(i) as MyTypes.real_t);
    		ll.invBoxSize(i) = (1.0/ll.boxSize(i)) as MyTypes.real_t;
    	}

    	ll.nLocalBoxes = ll.gridSize(0) * ll.gridSize(1) * ll.gridSize(2);
    
    	ll.nHaloBoxes = (2 * ((ll.gridSize(0) + 2) *
    		(ll.gridSize(1) + ll.gridSize(2) + 2) +
    		(ll.gridSize(1) * ll.gridSize(2)))) as Int;

    	ll.nTotalBoxes = ll.nLocalBoxes + ll.nHaloBoxes;
    
    	ll.nAtoms = new Rail[Int](ll.nTotalBoxes);
    	for (var iBox:Long=0; iBox<ll.nTotalBoxes; ++iBox)
    		ll.nAtoms(iBox) = 0n;

    	assert ((ll.gridSize(0) >= 2) && (ll.gridSize(1) >= 2) && (ll.gridSize(2) >= 2));
    	return ll;
    }

    /// \details
    /// Populates the nbrBoxes array with the 27 boxes that are adjacent to
    /// iBox.  The count is 27 instead of 26 because iBox is included in the
    /// list (as neighbor 13).  Caller is responsible to alloc and free
    /// nbrBoxes.
    /// \return The number of nbr boxes (always 27 in this implementation).
    static class Integer { var value:Int; }
    public def getNeighborBoxes(boxes:LinkCell, iBox:Int, nbrBoxes:Rail[Int]):Int {
    	getTuple(boxes, iBox, ix, iy, iz);
    
    	var count:Int = 0n;
    	for (var i:Int=ix.value-1n; i<=ix.value+1; i++)
    		for (var j:Int=iy.value-1n; j<=iy.value+1; j++)
    			for (var k:Int=iz.value-1n; k<=iz.value+1; k++)
    				nbrBoxes(count++) = getBoxFromTuple(boxes,i,j,k);
        return count;
    }

    /// \details
    /// Finds the appropriate link cell for an atom based on the spatial
    /// coordinates and stores data in that link cell.
    /// \param [in] gid   The global of the atom.
    /// \param [in] iType The species index of the atom.
    /// \param [in] x     The x-coordinate of the atom.
    /// \param [in] y     The y-coordinate of the atom.
    /// \param [in] z     The z-coordinate of the atom.
    /// \param [in] px    The x-component of the atom's momentum.
    /// \param [in] py    The y-component of the atom's momentum.
    /// \param [in] pz    The z-component of the atom's momentum.
    public def putAtomInBox(boxes:LinkCell, atoms:InitAtoms.Atoms,
    	gid:Int, iType:Int,
    	x:MyTypes.real_t, y:MyTypes.real_t, z:MyTypes.real_t,
    	px:MyTypes.real_t, py:MyTypes.real_t, pz:MyTypes.real_t):void {
        xyz(0) = x;
        xyz(1) = y;
        xyz(2) = z;
        
    	// Find correct box.
//OPT: Array flattening
//    	val iBox = getBoxFromCoord(boxes, xyz);
    	val iBox = getBoxFromCoord(boxes, x, y, z);
    	var iOff:Int = iBox*MAXATOMS;
    	iOff += boxes.nAtoms(iBox);
    
    	// assign values to array elements
    	if (iBox < boxes.nLocalBoxes)
    		atoms.nLocal++;
    	boxes.nAtoms(iBox)++;
    	atoms.gid(iOff) = gid;
    	atoms.iSpecies(iOff) = iType;

//OPT: Array flattening
//    	atoms.r(iOff)(0) = x;
//    	atoms.r(iOff)(1) = y;
//    	atoms.r(iOff)(2) = z;
		val iOff3 = iOff*3;
    	atoms.r(iOff3) = x;
    	atoms.r(iOff3+1) = y;
    	atoms.r(iOff3+2) = z;
//End of OPT: Array flattening
    
//OPT: Array flattening
//    	atoms.p(iOff)(0) = px;
//    	atoms.p(iOff)(1) = py;
//    	atoms.p(iOff)(2) = pz;
    	atoms.p(iOff3) = px;
    	atoms.p(iOff3+1) = py;
    	atoms.p(iOff3+2) = pz;
//End of OPT: Array flattening
    }

    /// Calculates the link cell index from the grid coords.  The valid
    /// coordinate range in direction ii is [-1, gridSize[ii]].  Any
    /// coordinate that involves a -1 or gridSize[ii] is a halo link cell.
    /// Because of the order in which the local and halo link cells are
    /// stored the indices of the halo cells are special cases.
    /// \see initLinkCells for an explanation of storage order.
    public def getBoxFromTuple(boxes:LinkCell, ix:Int, iy:Int, iz:Int):int {
    	var iBox:Int = 0n;
    	//const int* gridSize = boxes->gridSize; // alias
    
    	// Halo in Z+
    	if (iz == boxes.gridSize(2))
    	{
    		iBox = (boxes.nLocalBoxes + 2*boxes.gridSize(2)*boxes.gridSize(1) + 2*boxes.gridSize(2)*(boxes.gridSize(0)+2) +
    			(boxes.gridSize(0)+2)*(boxes.gridSize(1)+2) + (boxes.gridSize(0)+2)*(iy+1) + (ix+1)) as Int;
    	}
    	// Halo in Z-
    	else if (iz == -1n)
    	{
    		iBox = (boxes.nLocalBoxes + 2*boxes.gridSize(2)*boxes.gridSize(1) + 2*boxes.gridSize(2)*(boxes.gridSize(0)+2) +
    			(boxes.gridSize(0)+2)*(iy+1) + (ix+1)) as Int;
    	}
    	// Halo in Y+
    	else if (iy == boxes.gridSize(1))
    	{
    		iBox = (boxes.nLocalBoxes + 2*boxes.gridSize(2)*boxes.gridSize(1) + boxes.gridSize(2)*(boxes.gridSize(0)+2) +
    			(boxes.gridSize(0)+2)*iz + (ix+1)) as Int;
    	}
    	// Halo in Y-
    	else if (iy == -1n)
    	{
    		iBox = (boxes.nLocalBoxes + 2*boxes.gridSize(2)*boxes.gridSize(1) + iz*(boxes.gridSize(0)+2) + (ix+1)) as Int;
    	}
    	// Halo in X+
    	else if (ix == boxes.gridSize(0))
    	{
    		iBox = boxes.nLocalBoxes + boxes.gridSize(1)*boxes.gridSize(2) + iz*boxes.gridSize(1) + iy;
    	}
    	// Halo in X-
    	else if (ix == -1n)
    	{
    		iBox = boxes.nLocalBoxes + iz*boxes.gridSize(1) + iy;
    	}
    	// local link celll.
    	else
    	{
    		iBox = ix + boxes.gridSize(0)*iy + boxes.gridSize(0)*boxes.gridSize(1)*iz;
    	}
    	assert iBox >= 0;
    	assert iBox < boxes.nTotalBoxes;

    	return iBox;
    }

    /// Move an atom from one link cell to another.
    /// \param iId [in]  The index with box iBox of the atom to be moved.
    /// \param iBox [in] The index of the link cell the particle is moving from.
    /// \param jBox [in] The index of the link cell the particle is moving to.
    public def moveAtom(boxes:LinkCell, atoms:InitAtoms.Atoms, iId:Int, iBox:Int, jBox:Int):void {
    	val nj = boxes.nAtoms(jBox);
    	copyAtom(boxes, atoms, iId, iBox, nj, jBox);
    	boxes.nAtoms(jBox)++;

    	assert boxes.nAtoms(jBox) < MAXATOMS;

    	boxes.nAtoms(iBox)--;
    	val ni = boxes.nAtoms(iBox);
    	if (ni != 0n) copyAtom(boxes, atoms, ni, iBox, iId, iBox);

    	if (jBox > boxes.nLocalBoxes)
    		--atoms.nLocal;
    
    	return;
    }

    /// \details
    /// This is the first step in returning data structures to a consistent
    /// state after the atoms move each time step.  First we discard all
    /// atoms in the halo link cells.  These are all atoms that are
    /// currently stored on other ranks and so any information we have about
    /// them is stale.  Next, we move any atoms that have crossed link cell
    /// boundaries into their new link cells.  It is likely that some atoms
    /// will be moved into halo link cells.  Since we have deleted halo
    /// atoms from other tasks, it is clear that any atoms that are in halo
    /// cells at the end of this routine have just transitioned from local
    /// to halo atoms.  Such atom must be sent to other tasks by a halo
    /// exchange to avoid being lost.
    /// \see redistributeAtoms
    public def updateLinkCells(boxes:LinkCell, atoms:InitAtoms.Atoms):void {
    	emptyHaloCells(boxes);
    
    	for (var iBox:int=0n; iBox<boxes.nLocalBoxes; ++iBox) {
    		val iOff = iBox*MAXATOMS;
    		var ii:Int=0n;
    		while (ii < boxes.nAtoms(iBox)) {
//    			val jBox = getBoxFromCoord(boxes, atoms.r(iOff+ii));
				val index = (iOff+ii)*3;
    			val jBox = getBoxFromCoord(boxes, atoms.r(index), atoms.r(index+1), atoms.r(index+2));
    			if (jBox != iBox)
    				moveAtom(boxes, atoms, ii, iBox, jBox);
    			else
    				++ii;
    		}
    	}
    }

    /// \return The largest number of atoms in any link cell.
    public def maxOccupancy(s:CoMDTypes.SimFlat):int {
    
    	var localMax:Rail[Int] = new Rail[Int](1);
        localMax(0) = 0n;
    	for (var ii:Int=0n; ii<s.boxes.nLocalBoxes; ++ii)
    		localMax(0) = Math.max(localMax(0), s.boxes.nAtoms(ii));

    	var globalMax:Rail[Int] = new Rail[Int](1);
    	per.startTimer(per.commReduceTimer);
    	par.maxIntParallel(localMax, globalMax, 1n);
    	per.stopTimer(per.commReduceTimer);

    	return globalMax(0);
    }

    /// Copy atom iAtom in link cell iBox to atom jAtom in link cell jBox.
    /// Any data at jAtom, jBox is overwritten.  This routine can be used to
    /// re-order atoms within a link cell.
    public def copyAtom(boxes:LinkCell, atoms:InitAtoms.Atoms, iAtom:Int, iBox:Int, jAtom:Int, jBox:Int):void {
    	val iOff = MAXATOMS*iBox+iAtom;
    	val jOff = MAXATOMS*jBox+jAtom;
    	atoms.gid(jOff) = atoms.gid(iOff);
    	atoms.iSpecies(jOff) = atoms.iSpecies(iOff);
//OPT: Array flattening (atoms.r, atoms.p, atoms.f)
//    	atoms.r(jOff) = atoms.r(iOff);
//    	atoms.p(jOff) = atoms.p(iOff);
    	atoms.f(jOff) = atoms.f(iOff);
		val iOff3 = iOff*3;
		val jOff3 = jOff*3;
    	atoms.r(jOff3) = atoms.r(iOff3);
    	atoms.r(jOff3+1) = atoms.r(iOff3+1);
    	atoms.r(jOff3+2) = atoms.r(iOff3+2);
    	atoms.p(jOff3) = atoms.p(iOff3);
    	atoms.p(jOff3+1) = atoms.p(iOff3+1);
    	atoms.p(jOff3+2) = atoms.p(iOff3+2);
    	atoms.f(jOff3) = atoms.f(iOff3);
    	atoms.f(jOff3+1) = atoms.f(iOff3+1);
    	atoms.f(jOff3+2) = atoms.f(iOff3+2);
//End of OPT: Array flattening (atoms.r, atoms.p, atoms.f)
    	atoms.U(jOff) = atoms.U(iOff);
    }

    /// Get the index of the link cell that contains the specified
    /// coordinate.  This can be either a halo or a local link cell.
    ///
    /// Because the rank ownership of an atom is strictly determined by the
    /// atom's position, we need to take care that all ranks will agree which
    /// rank owns an atom.  The conditionals at the end of this function are
    /// special care to ensure that all ranks make compatible link cell
    /// assignments for atoms that are near a link cell boundaries.  If no
    /// ranks claim an atom in a local cell it will be lost.  If multiple
    /// ranks claim an atom it will be duplicated.
//OPT: Array flattening
//    public static def getBoxFromCoord(boxes:LinkCell, rr:MyTypes.real3 ):int {
    public def getBoxFromCoord(boxes:LinkCell, rr:Double, rr1:Double, rr2:Double ):int {
    
//    	var ix:Int = (Math.floor((rr(0) - boxes.localMin(0))*boxes.invBoxSize(0))) as Int;
//    	var iy:Int = (Math.floor((rr(1) - boxes.localMin(1))*boxes.invBoxSize(1))) as Int;
//    	var iz:Int = (Math.floor((rr(2) - boxes.localMin(2))*boxes.invBoxSize(2))) as Int;
    	var ix:Int = (Math.floor((rr - boxes.localMin(0))*boxes.invBoxSize(0))) as Int;
    	var iy:Int = (Math.floor((rr1 - boxes.localMin(1))*boxes.invBoxSize(1))) as Int;
    	var iz:Int = (Math.floor((rr2 - boxes.localMin(2))*boxes.invBoxSize(2))) as Int;
    
    	// For each axis, if we are inside the local domain, make sure we get
    	// a local link cell.  Otherwise, make sure we get a halo link cell.
    	if (rr < boxes.localMax(0)) //OPT: Array flattening (rr)
    	{
    		if (ix == boxes.gridSize(0)) ix = boxes.gridSize(0) - 1n;
    	}
    	else
    		ix = boxes.gridSize(0); // assign to halo cell
    	if (rr1 < boxes.localMax(1)) //OPT: Array flattening (rr1)
    	{
    		if (iy == boxes.gridSize(1)) iy = boxes.gridSize(1) - 1n;
    	}
    	else
    		iy = boxes.gridSize(1);
    	if (rr2 < boxes.localMax(2)) //OPT: Array flattening (rr2)
    	{
    		if (iz == boxes.gridSize(2)) iz = boxes.gridSize(2) - 1n;
    	}
    	else
    		iz = boxes.gridSize(2);
    
    	return getBoxFromTuple(boxes, ix, iy, iz);
    }

    /// Set the number of atoms to zero in all halo link cells.
    public def emptyHaloCells(boxes:LinkCell):void {
    	for (var ii:Int=boxes.nLocalBoxes; ii<boxes.nTotalBoxes; ++ii)
    		boxes.nAtoms(ii) = 0n;
    }

    /// Get the grid coordinates of the link cell with index iBox.  Local
    /// cells are easy as they use a standard 1D->3D mapping.  Halo cell are
    /// special cases.
    /// \see initLinkCells for information on link cell order.
    /// \param [in]  iBox Index to link cell for which tuple is needed.
    /// \param [out] ixp  x grid coord of link cell.
    /// \param [out] iyp  y grid coord of link cell.
    /// \param [out] izp  z grid coord of link cell.
    //public def getTuple(boxes:LinkCell, iBox:Int, ixp:Integer, iyp:Integer, izp:Integer):void {
    public def getTuple(boxes:LinkCell, iBox:Int, ixp:Cell[Int], iyp:Cell[Int], izp:Cell[Int]):void {
    	var ix:Int, iy:Int, iz:Int;
    	val gridSize:Rail[Int] = boxes.gridSize; // alias
    
    	// If a local box
    	if( iBox < boxes.nLocalBoxes)
    	{
    		ix = iBox % gridSize(0);
    		val t_iBox = iBox / gridSize(0);
    		iy = t_iBox % gridSize(1);
    		iz = t_iBox / gridSize(1);
    	}
    	// It's a halo box
    	else 
    	{
    		var ink:Int = iBox - boxes.nLocalBoxes;
    		if (ink < 2*gridSize(1)*gridSize(2))
    		{
    			if (ink < gridSize(1)*gridSize(2)) 
    			{
    				ix = 0n;
    			}
    			else 
    			{
    				ink -= gridSize(1)*gridSize(2);
    				ix = gridSize(0) + 1n;
    			}
    			iy = 1n + ink % gridSize(1);
    			iz = 1n + ink / gridSize(1);
    		}
    		else if (ink < (2 * gridSize(2) * (gridSize(1) + gridSize(0) + 2))) 
    		{
    			ink -= 2 * gridSize(2) * gridSize(1);
    			if (ink < ((gridSize(0) + 2) *gridSize(2))) 
    			{
    				iy = 0n;
    			}
    			else 
    			{
    				ink -= (gridSize(0) + 2) * gridSize(2);
    				iy = gridSize(1) + 1n;
    			}
    			ix = (ink % (gridSize(0) + 2)) as Int;
    			iz = (1 + ink / (gridSize(0) + 2)) as Int;
    		}
    		else 
    		{
    			ink -= 2 * gridSize(2) * (gridSize(1) + gridSize(0) + 2);
    			if (ink < ((gridSize(0) + 2) * (gridSize(1) + 2))) 
    			{
    				iz = 0n;
    			}
    			else 
    			{
    				ink -= (gridSize(0) + 2) * (gridSize(1) + 2);
    				iz = gridSize(2) + 1n;
    			}
    			ix = (ink % (gridSize(0) + 2)) as Int;
    			iy = (ink / (gridSize(0) + 2)) as Int;
    		}
    
    		// Calculated as off by 1
    		ix--;
    		iy--;
    		iz--;
    	}
    
    	ixp.value = ix;
    	iyp.value = iy;
    	izp.value = iz;
    }

}