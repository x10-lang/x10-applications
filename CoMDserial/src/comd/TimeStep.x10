/// \file
/// Leapfrog time integrator

package comd;

public class TimeStep {

    val par:Parallel;
    val per:PerformanceTimer;
    val lc:LinkCells;
    val he:HaloExchange;
    val eLocal:Rail[MyTypes.real_t];
    val eSum:Rail[MyTypes.real_t];
    def this (par:Parallel, per:PerformanceTimer, lc:LinkCells, he:HaloExchange) {
    	this.par = par;
    	this.per = per;
    	this.lc = lc;
    	this.he = he;
        this.eLocal = new Rail[MyTypes.real_t](2);
        this.eSum = new Rail[MyTypes.real_t](2);
    }
/// Advance the simulation time to t+dt using a leap frog method
/// (equivalent to velocity verlet).
///
/// Forces must be computed before calling the integrator the first time.
///
///  - Advance velocities half time step using forces
///  - Advance positions full time step using velocities
///  - Update link cells and exchange remote particles
///  - Compute forces
///  - Update velocities half time step using forces
///
/// This leaves positions, velocities, and forces at t+dt, with the
/// forces ready to perform the half step velocity update at the top of
/// the next call.
///
/// After nSteps the kinetic energy is computed for diagnostic output.
    public def timeStep(s:CoMDTypes.SimFlat, nSteps:Int, dt:MyTypes.real_t):Double
    {
    	for (var ii:Int=0n; ii<nSteps; ++ii)
    	{
    
    		per.startTimer(per.velocityTimer);
    		advanceVelocity(s, s.boxes.nLocalBoxes, (0.5*dt) as MyTypes.real_t); 
    		per.stopTimer(per.velocityTimer);

    		per.startTimer(per.positionTimer);
    		advancePosition(s, s.boxes.nLocalBoxes, dt);
    		per.stopTimer(per.positionTimer);

    		per.startTimer(per.redistributeTimer);
    		redistributeAtoms(s);
    		per.stopTimer(per.redistributeTimer);

    		per.startTimer(per.computeForceTimer);
    		computeForce(s);
    		per.stopTimer(per.computeForceTimer);

    		per.startTimer(per.velocityTimer);
    		advanceVelocity(s, s.boxes.nLocalBoxes, (0.5*dt) as MyTypes.real_t); 
    		per.stopTimer(per.velocityTimer);
    	}

    	kineticEnergy(s);

    	return s.ePotential;
    }

    public def computeForce(s:CoMDTypes.SimFlat):void
    {
    	s.pot.force(s);
    }


    public def advanceVelocity(s:CoMDTypes.SimFlat, nBoxes:Int, dt:MyTypes.real_t):void
    {
    	for (var iBox:Int=0n; iBox<nBoxes; iBox++)
    	{
    		for (var iOff:Int=lc.MAXATOMS*iBox,ii:Int=0n; ii<s.boxes.nAtoms(iBox); ii++,iOff++)
    		{
				//OPT: Array flattening
				val iOff3 = iOff * 3;
    			s.atoms.p(iOff3) += dt*s.atoms.f(iOff3);
    			s.atoms.p(iOff3+1) += dt*s.atoms.f(iOff3+1);
    			s.atoms.p(iOff3+2) += dt*s.atoms.f(iOff3+2);
    		}
    	}
    }

    public def advancePosition(s:CoMDTypes.SimFlat, nBoxes:Int, dt:MyTypes.real_t):void
    {
    	for (var iBox:Int=0n; iBox<nBoxes; iBox++)
    	{
    		for (var iOff:Int=lc.MAXATOMS*iBox,ii:Int=0n; ii<s.boxes.nAtoms(iBox); ii++,iOff++)
    		{
    			val iSpecies = s.atoms.iSpecies(iOff);
	// OPT: MH-20131010
//    			val invMass:MyTypes.real_t = (1.0/s.species(iSpecies).mass) as MyTypes.real_t;
    			val invMass = (1.0/s.species(iSpecies).mass) as MyTypes.real_t;
//    			s.atoms.r(iOff)(0) += dt*s.atoms.p(iOff)(0)*invMass;
//    			s.atoms.r(iOff)(1) += dt*s.atoms.p(iOff)(1)*invMass;
//    			s.atoms.r(iOff)(2) += dt*s.atoms.p(iOff)(2)*invMass;
				val tmp = dt*invMass; //OPT: CSE
				//OPT: Array flattening (s.atoms.r and s.atoms.p)
				val iOff3 = iOff*3;
    			s.atoms.r(iOff3) += s.atoms.p(iOff3)*tmp;
    			s.atoms.r(iOff3+1) += s.atoms.p(iOff3+1)*tmp;
    			s.atoms.r(iOff3+2) += s.atoms.p(iOff3+2)*tmp;
    		}
    	}
    }

    /// Calculates total kinetic and potential energy across all tasks.  The
    /// local potential energy is a by-product of the force routine.
    public def kineticEnergy(s:CoMDTypes.SimFlat):void
    {
    	eLocal(0) = s.ePotential;
    	eLocal(1) = 0;
    	for (var iBox:Int=0n; iBox<s.boxes.nLocalBoxes; iBox++)
    	{
    		for (var iOff:Int=LinkCells.MAXATOMS*iBox,ii:Int=0n; ii<s.boxes.nAtoms(iBox); ii++,iOff++)
    		{
    			val iSpecies = s.atoms.iSpecies(iOff);
    			val invMass:MyTypes.real_t = (0.5/s.species(iSpecies).mass) as MyTypes.real_t;
    			//OPT: Array flattening (s.atoms.p)
				val iOff3 = iOff * 3;
    			eLocal(1) += ( s.atoms.p(iOff3) * s.atoms.p(iOff3) +
    			s.atoms.p(iOff3+1) * s.atoms.p(iOff3+1) +
    			s.atoms.p(iOff3+2) * s.atoms.p(iOff3+2) )*invMass;
    		}
    	}

    	per.startTimer(per.commReduceTimer);
    	par.addRealParallel(eLocal, eSum, 2n);
    	per.stopTimer(per.commReduceTimer);

    	s.ePotential = eSum(0);
    	s.eKinetic = eSum(1);
    }

    /// \details
    /// This function provides one-stop shopping for the sequence of events
    /// that must occur for a proper exchange of halo atoms after the atom
    /// positions have been updated by the integrator.
    ///
    /// - updateLinkCells: Since atoms have moved, some may be in the wrong
    ///   link cells.
    /// - haloExchange (atom version): Sends atom data to remote tasks. 
    /// - sort: Sort the atoms.
    ///
    /// \see updateLinkCells
    /// \see initAtomHaloExchange
    /// \see sortAtomsInCell
    public def redistributeAtoms(sim:CoMDTypes.SimFlat):void
    {
    	lc.updateLinkCells(sim.boxes, sim.atoms);

    	per.startTimer(per.atomHaloTimer);
    	he.haloExchange(sim.atomExchange, sim);

    	per.stopTimer(per.atomHaloTimer);

    	for (var ii:Int=0n; ii<sim.boxes.nTotalBoxes; ++ii)
    		he.sortAtomsInCell(sim.atoms, sim.boxes, ii);
    }
}