/// \file
/// Initialize the atom configuration.

package comd;

public class InitAtoms {
    /// Atom data
    public static class Atoms {
    	// atom-specific data
    	var nLocal:Int;    //!< total number of atoms on this processor
    	var nGlobal:Int;   //!< total number of atoms in simulation

    	var gid:Rail[Int];      //!< A globally unique id for each atom
    	var iSpecies:Rail[Int]; //!< the species index of the atom

		//OPT: Array flattening (r, p, f: MyTypes.real3 -> real_t)
    	var r:Rail[MyTypes.real_t];     //!< positions
    	var p:Rail[MyTypes.real_t];     //!< momenta of atoms
    	var f:Rail[MyTypes.real_t];     //!< forces 
    	var U:Rail[MyTypes.real_t];     //!< potential energy per atom
    }

    val par:Parallel;
    val per:PerformanceTimer;
    val lc:LinkCells;
    val rnd:Random;
    val ts:TimeStep;
    public def this (par:Parallel, per:PerformanceTimer, lc:LinkCells, rnd:Random, ts:TimeStep) {
    	this.par = par;
    	this.per = per;
        this.lc = lc;
    	this.rnd = rnd;
        this.ts = ts;
    }
    /// \details
    /// Call functions such as createFccLattice and setTemperature to set up
    /// initial atom positions and momenta.
    public def initAtomsMain(boxes:LinkCells.LinkCell):Atoms {
    	val atoms = new Atoms();

    	val maxTotalAtoms = LinkCells.MAXATOMS*boxes.nTotalBoxes;

    	atoms.gid = new Rail[Int](maxTotalAtoms);
    	atoms.iSpecies = new Rail[Int](maxTotalAtoms);
		val maxTotalAtoms3 = maxTotalAtoms*3; //OPT: Array flattening (r, p, f: MyTypes.real3 -> real_t)
    	atoms.r = new Rail[MyTypes.real_t](maxTotalAtoms3); //OPT: Array flattening
    	atoms.p = new Rail[MyTypes.real_t](maxTotalAtoms3); //OPT: Array flattening
    	atoms.f = new Rail[MyTypes.real_t](maxTotalAtoms3); //OPT: Array flattening
    	atoms.U = new Rail[MyTypes.real_t](maxTotalAtoms);

    	atoms.nLocal = 0n;
    	atoms.nGlobal = 0n;

    	for (var iOff:Long = 0; iOff < maxTotalAtoms; iOff++)
    	{
    		atoms.gid(iOff) = 0n;
    		atoms.iSpecies(iOff) = 0n;
//OPT: Array flattening (r)
//    		atoms.r(iOff) = new MyTypes.real3(3);
			val iOff3 = iOff * 3;
    		atoms.r(iOff3) = MyTypes.real_t0;
    		atoms.r(iOff3+1) = MyTypes.real_t0;
    		atoms.r(iOff3+2) = MyTypes.real_t0;
//OPT: Array flattening (p)
//    		atoms.p(iOff) = new MyTypes.real3(3);
    		atoms.p(iOff3) = MyTypes.real_t0;
    		atoms.p(iOff3+1) = MyTypes.real_t0;
    		atoms.p(iOff3+2) = MyTypes.real_t0;
//OPT: Array flattening (f)
//    		atoms.f(iOff) = new MyTypes.real3(3);
    		atoms.f(iOff3) = MyTypes.real_t0;
    		atoms.f(iOff3+1) = MyTypes.real_t0;
    		atoms.f(iOff3+2) = MyTypes.real_t0;
//    		MyTypes.zeroReal3(atoms.r(iOff));
//    		MyTypes.zeroReal3(atoms.p(iOff));
//    		MyTypes.zeroReal3(atoms.f(iOff));
    		atoms.U(iOff) = 0.0f;
    	}

    	return atoms;
    }

    /// Creates atom positions on a face centered cubic (FCC) lattice with
    /// nx * ny * nz unit cells and lattice constant lat.
    /// Set momenta to zero.
    public def createFccLattice(nx:Int, ny:Int, nz:Int, lat:MyTypes.real_t, s:CoMDTypes.SimFlat):void
    {
    
    	val nb = 4n; // number of atoms in the basis
    	val basis:Rail[Rail[Float]] = new Rail[Rail[Float]](4);
    	for (var i:Long = 0; i < 4; i++) {
    		basis(i) = new Rail[Float](3);
    	}
    	basis(0)(0) = 0.25f; basis(0)(1) = 0.25f; basis(0)(2) = 0.25f;
    	basis(1)(0) = 0.25f; basis(1)(1) = 0.75f; basis(1)(2) = 0.75f;
    	basis(2)(0) = 0.75f; basis(2)(1) = 0.25f; basis(2)(2) = 0.75f;
    	basis(3)(0) = 0.75f; basis(3)(1) = 0.75f; basis(3)(2) = 0.25f;
    
        val a = [["a", "b", "c"],["d","e","f"]];

    	// create and place atoms
    	var begin:Rail[Int] = new Rail[Int](3);
    	var end:Rail[Int] = new Rail[Int](3);
    	for (var ii:Long=0; ii<3; ++ii)
    	{
    		begin(ii) = Math.floor(s.domain.localMin(ii)/lat) as Int;
    		end(ii)   = Math.ceil (s.domain.localMax(ii)/lat) as Int;
    	}

    	val px:MyTypes.real_t = MyTypes.real_t0;
    	val py:MyTypes.real_t = MyTypes.real_t0;
    	val pz:MyTypes.real_t = MyTypes.real_t0;

    	for (var ix:Int=begin(0); ix<end(0); ++ix)
    		for (var iy:Int=begin(1); iy<end(1); ++iy)
    			for (var iz:Int=begin(2); iz<end(2); ++iz)
    				for (var ib:Int=0n; ib<nb; ++ib)
    				{
    					val rx:MyTypes.real_t = (ix+basis(ib)(0)) * lat;
    					val ry:MyTypes.real_t = (iy+basis(ib)(1)) * lat;
    					val rz:MyTypes.real_t = (iz+basis(ib)(2)) * lat;
    					if (rx < s.domain.localMin(0) || rx >= s.domain.localMax(0)) continue;
    					if (ry < s.domain.localMin(1) || ry >= s.domain.localMax(1)) continue;
    					if (rz < s.domain.localMin(2) || rz >= s.domain.localMax(2)) continue;
    					val id:Int = ib+nb*(iz+nz*(iy+ny*(ix)));
    					lc.putAtomInBox(s.boxes, s.atoms, id, 0n, rx, ry, rz, px, py, pz);
    				}
    
    	// set total atoms in simulation
    	per.startTimer(per.commReduceTimer);
        val src:Rail[Int] = new Rail[Int](1);
        val dst:Rail[Int] = new Rail[Int](1);
        src(0) = s.atoms.nLocal;
    	par.addIntParallel(src, dst, 1n);
    	s.atoms.nGlobal = dst(0);
    	per.stopTimer(per.commReduceTimer);

    	assert s.atoms.nGlobal == nb*nx*ny*nz;
    }

    /// Sets the center of mass velocity of the system.
    /// \param [in] newVcm The desired center of mass velocity.
    public def setVcm(s:CoMDTypes.SimFlat, newVcm:Rail[MyTypes.real_t]):void
    {
    	val oldVcm:Rail[MyTypes.real_t] = new Rail[MyTypes.real_t](3);
    	computeVcm(s, oldVcm);

    	val vShift:Rail[MyTypes.real_t] = new Rail[MyTypes.real_t](3);
    	vShift(0) = (newVcm(0) - oldVcm(0));
    	vShift(1) = (newVcm(1) - oldVcm(1));
    	vShift(2) = (newVcm(2) - oldVcm(2));

    	for (var iBox:Int=0n; iBox<s.boxes.nLocalBoxes; ++iBox)
    	{
    		var ii:Int = 0n;
    		for (var iOff:Int=LinkCells.MAXATOMS*iBox; ii<s.boxes.nAtoms(iBox); ++ii, ++iOff)
    		{
    			val iSpecies:Int = s.atoms.iSpecies(iOff);
    			val mass:MyTypes.real_t = s.species(iSpecies).mass;

//OPT: Array flattening (s.atoms.p)
				val iOff3 = iOff*3;
    			s.atoms.p(iOff3) += mass * vShift(0);
    			s.atoms.p(iOff3+1) += mass * vShift(1);
    			s.atoms.p(iOff3+2) += mass * vShift(2);
    		}
    	}
    }

    /// Sets the temperature of system.
    ///
    /// Selects atom velocities randomly from a boltzmann (equilibrium)
    /// distribution that corresponds to the specified temperature.  This
    /// random process will typically result in a small, but non zero center
    /// of mass velocity and a small difference from the specified
    /// temperature.  For typical MD runs these small differences are
    /// unimportant, However, to avoid possible confusion, we set the center
    /// of mass velocity to zero and scale the velocities to exactly match
    /// the input temperature.
    public def setTemperature(s:CoMDTypes.SimFlat, temperature:MyTypes.real_t):void 
    {
    	// set initial velocities for the distribution
    	for (var iBox:Int=0n; iBox<s.boxes.nLocalBoxes; ++iBox)
    	{
    		for (var iOff:Int=LinkCells.MAXATOMS*iBox, ii:Int=0n; ii<s.boxes.nAtoms(iBox); ++ii, ++iOff)
    		{
    			val iType:Int = s.atoms.iSpecies(iOff);
    			val mass:MyTypes.real_t = s.species(iType).mass;
    			val sigma:MyTypes.real_t = Math.sqrt(Constants.kB_eV * temperature/mass) as MyTypes.real_t;
    			val seed = rnd.mkSeed(s.atoms.gid(iOff) as UInt, 123un);
//OPT: CSE (mass*sigma with tmp)
				val iOff3 = iOff*3;
				val tmp=mass*sigma;
//OPT: Array flattening (s.atoms.p)
    			s.atoms.p(iOff3) = tmp * rnd.gasdev(seed);
    			s.atoms.p(iOff3+1) = tmp * rnd.gasdev(seed);
    			s.atoms.p(iOff3+2) = tmp * rnd.gasdev(seed);
    		}
    	}
    	// compute the resulting temperature
    	// kinetic energy  = 3/2 kB * Temperature 
    	if (temperature == MyTypes.real_t0) return;
    	val vZero:MyTypes.real3 = new MyTypes.real3(3);
    	MyTypes.zeroReal3(vZero);
    	setVcm(s, vZero);
    	ts.kineticEnergy(s);
    	var temp:MyTypes.real_t = ((s.eKinetic/s.atoms.nGlobal)/Constants.kB_eV/1.5) as MyTypes.real_t;
    	// scale the velocities to achieve the target temperature
    	var scaleFactor:MyTypes.real_t = Math.sqrt(temperature/temp) as MyTypes.real_t;
    	for (var iBox:Int=0n; iBox<s.boxes.nLocalBoxes; ++iBox)
    	{
    		var ii:Int = 0n;
    		for (var iOff:Int=LinkCells.MAXATOMS*iBox; ii<s.boxes.nAtoms(iBox); ++ii, ++iOff)
    		{
//OPT: Array flattening (s.atoms.p)
				val iOff3 = iOff * 3;
    			s.atoms.p(iOff3) *= scaleFactor;
    			s.atoms.p(iOff3+1) *= scaleFactor;
    			s.atoms.p(iOff3+2) *= scaleFactor;
    		}
    	}
    	ts.kineticEnergy(s);
    	temp = (s.eKinetic/s.atoms.nGlobal/Constants.kB_eV/1.5) as MyTypes.real_t;
    }

    /// Add a random displacement to the atom positions.
    /// Atoms are displaced by a random distance in the range
    /// [-delta, +delta] along each axis.
    /// \param [in] delta The maximum displacement (along each axis).
    public def randomDisplacements(s:CoMDTypes.SimFlat, delta:MyTypes.real_t):void
    {
    	for (var iBox:Int=0n; iBox<s.boxes.nLocalBoxes; ++iBox)
    	{
            var ii:Int = 0n;
    		for (var iOff:Int=LinkCells.MAXATOMS*iBox; ii<s.boxes.nAtoms(iBox); ++ii, ++iOff)
    		{
    			val seed = rnd.mkSeed(s.atoms.gid(iOff) as UInt, 457un);
//OPT: Array flattening (s.atoms.r)
//    			s.atoms.r(iOff)(0) += ((2.0*rnd.lcg61(seed)-1.0) * delta) as MyTypes.real_t;
//    			s.atoms.r(iOff)(1) += ((2.0*rnd.lcg61(seed)-1.0) * delta) as MyTypes.real_t;
//    			s.atoms.r(iOff)(2) += ((2.0*rnd.lcg61(seed)-1.0) * delta) as MyTypes.real_t;
				val iOff3 = iOff * 3;
    			s.atoms.r(iOff3) += ((2.0*rnd.lcg61(seed)-1.0) * delta) as MyTypes.real_t;
    			s.atoms.r(iOff3+1) += ((2.0*rnd.lcg61(seed)-1.0) * delta) as MyTypes.real_t;
    			s.atoms.r(iOff3+2) += ((2.0*rnd.lcg61(seed)-1.0) * delta) as MyTypes.real_t;
    		}
    	}
    }

    /// Computes the center of mass velocity of the system.
    public def computeVcm(s:CoMDTypes.SimFlat, vcm:Rail[MyTypes.real_t]):void 
    {
     
    	var vcmLocal:Rail[MyTypes.real_t] = new Rail[MyTypes.real_t](4);
    	var vcmSum:Rail[MyTypes.real_t] = new Rail[MyTypes.real_t](4);

    	// sum the momenta and particle masses 
    	for (var iBox:Int=0n; iBox<s.boxes.nLocalBoxes; ++iBox)
    	{
    		var ii:Int = 0n;
    		for (var iOff:Int=LinkCells.MAXATOMS*iBox; ii<s.boxes.nAtoms(iBox); ++ii, ++iOff)
    		{
//OPT: Array flattening (s.atoms.p)
				val iOff3 = iOff * 3;
    			vcmLocal(0) += s.atoms.p(iOff3);
    			vcmLocal(1) += s.atoms.p(iOff3+1);
    			vcmLocal(2) += s.atoms.p(iOff3+2);

    			var iSpecies:Int = s.atoms.iSpecies(iOff);
    			vcmLocal(3) += s.species(iSpecies).mass;
    		}
    	}

    	per.startTimer(per.commReduceTimer);
    	par.addRealParallel(vcmLocal, vcmSum, 4n);
    	per.stopTimer(per.commReduceTimer);

    	val totalMass:MyTypes.real_t = vcmSum(3);
    	vcm(0) = vcmSum(0)/totalMass;
    	vcm(1) = vcmSum(1)/totalMass;
    	vcm(2) = vcmSum(2)/totalMass;
    }

}