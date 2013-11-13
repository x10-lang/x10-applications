/// \file
/// Main program
///
/// \mainpage CoMD: A Classical Molecular Dynamics Mini-app
///
/// CoMD is a reference implementation of typical classical molecular
/// dynamics algorithms and workloads.  It is created and maintained by
/// The Exascale Co-Design Center for Materials in Extreme Environments
/// (ExMatEx).  http://codesign.lanl.gov/projects/exmatex.  The
/// code is intended to serve as a vehicle for co-design by allowing
/// others to extend and/or reimplement it as needed to test performance of 
/// new architectures, programming models, etc.
///
/// The current version of CoMD is available from:
/// http://exmatex.github.io/CoMD
///
/// To contact the developers of CoMD send email to: exmatex-comd@llnl.gov.
///
/// This X10 version by Hiroki Murata, IBM Research, was translated in September 2013.
///
/// Table of Contents
/// =================
///
/// Click on the links below to browse the CoMD documentation.
///
/// \subpage pg_md_basics
///
/// \subpage pg_building_comd
///
/// \subpage pg_running_comd
///
/// \subpage pg_measuring_performance
///
/// \subpage pg_problem_selection_and_scaling
///
/// \subpage pg_verifying_correctness
///
/// \subpage pg_comd_architecture
///
/// \subpage pg_optimization_targets
///
/// \subpage pg_whats_new

package comd;

import x10.io.Printer;

public class CoMD {
    public static def main(args:Rail[String]):void {
    	// Prolog
    	val par = new Parallel();
    	par.initParallel(args);
    	val per = new PerformanceTimer(par);
    	per.profileStart(per.totalTimer);
    	val yaml = new YamlOutput(par);
    	initSubsystems(yaml);
    	par.timestampBarrier("Starting Initialization\n");

    	yaml.yamlAppInfo(yaml.yamlFile);
    	yaml.yamlAppInfo(Console.OUT);

        val mycmd = new MyCommand(par);
    	val cmd = mycmd.parseCommandLine(args);
    	if (cmd != null) { // return 2n;
    		mycmd.printCmdYaml(yaml.yamlFile, cmd);
    		mycmd.printCmdYaml(Console.OUT, cmd);

    		val dc = new Decomposition(par);
    		val lc = new LinkCells(par, per);
    		val rnd = new Random();
    		val he = new HaloExchange(par, per, dc, lc);
    		val ts = new TimeStep(par, per, lc, he);
    		val ia = new InitAtoms(par, per, lc, rnd, ts);
    		val ptv = new PrintThingsVar();
    		val sim:CoMDTypes.SimFlat = initSimulation(cmd, lc, par, dc, ia, he, per, ts);
    		if (sim.sanity == 0n) { //return sim.sanity;
    
    			printSimulationDataYaml(yaml.yamlFile, sim, lc, par, yaml);
    			printSimulationDataYaml(Console.OUT, sim, lc, par, yaml);

    			val validate:CoMDTypes.Validate = initValidate(sim, per, par, yaml); // atom counts, energy
    			par.timestampBarrier("Initialization Finished\n");

    			par.timestampBarrier("Starting simulation\n");

    			// This is the CoMD main loop
    			val nSteps:Int = sim.nSteps;
    			val printRate:Int = sim.printRate;
    			var iStep:Int = 0n;
    			per.profileStart(per.loopTimer);
    			for (; iStep<nSteps;)
    			{
    				per.startTimer(per.commReduceTimer);
    				sumAtoms(sim, per, par);
    				per.stopTimer(per.commReduceTimer);

    				printThings(sim, iStep, per.getElapsedTime(per.timestepTimer), ptv, par);

    				per.startTimer(per.timestepTimer);
    				ts.timeStep(sim, printRate, sim.dt);
    				per.stopTimer(per.timestepTimer);

    				iStep += printRate;
    			}
    			per.profileStop(per.loopTimer);

    			sumAtoms(sim, per, par);
    			printThings(sim, iStep, per.getElapsedTime(per.timestepTimer), ptv, par);
    			par.timestampBarrier("Ending simulation\n");

    			// Epilog
    			validateResult(validate, sim, par);
    			per.profileStop(per.totalTimer);

    			per.printPerformanceResults(sim.atoms.nGlobal);
    			per.printPerformanceResultsYaml(yaml.yamlFile);
    		}
    	}

    	finalizeSubsystems(yaml);

    	par.timestampBarrier("CoMD Ending\n");
    	par.destroyParallel();
  	}
    
    /// Initialized the main CoMD data stucture, SimFlat, based on command
    /// line input from the user.  Also performs certain sanity checks on
    /// the input to screen out certain non-sensical inputs.
    ///
    /// Simple data members such as the time step dt are initialized
    /// directly, substructures such as the potential, the link cells, the
    /// atoms, etc., are initialized by calling additional initialization
    /// functions (initPotential(), initLinkCells(), initAtoms(), etc.).
    /// Initialization order is set by the natural dependencies of the
    /// substructure such as the atoms need the link cells so the link cells
    /// must be initialized before the atoms.
    public static def initSimulation(cmd:MyCommand.Command,
    		lc:LinkCells, par:Parallel, dc:Decomposition, ia:InitAtoms,
    		he:HaloExchange, per:PerformanceTimer, ts:TimeStep):CoMDTypes.SimFlat
    {
    	val sim = new CoMDTypes.SimFlat();
    	sim.nSteps = cmd.nSteps.i;
    	sim.printRate = cmd.printRate.i;
    	sim.dt = cmd.dt.d;
    	sim.domain = null;
    	sim.boxes = null;
    	sim.atoms = null;
    	sim.ePotential = MyTypes.real_t0;
    	sim.eKinetic = MyTypes.real_t0;
    	sim.atomExchange = null;
    	sim.pot = initPotential(cmd.doeam.i, cmd.potDir.s, cmd.potName.s, cmd.potType.s, par, per, he, lc);
    	var latticeConstant:MyTypes.real_t = cmd.lat.d as MyTypes.real_t;
    	if (cmd.lat.d < MyTypes.real_t0)
    		latticeConstant = sim.pot.lat;

    	// ensure input parameters make sense.
    	val ret = sanityChecks(cmd, sim.pot.cutoff, latticeConstant, sim.pot.latticeType, par);
    	if (ret != 0n) {
    		sim.sanity = ret;
    		return sim;
    	}
        sim.species = new Rail[CoMDTypes.SpeciesData](1);
    	sim.species(0) = initSpecies(sim.pot);

    	var globalExtent:MyTypes.real3 = new MyTypes.real3(3);
    	globalExtent(0) = cmd.nx.i * latticeConstant;
    	globalExtent(1) = cmd.ny.i * latticeConstant;
    	globalExtent(2) = cmd.nz.i * latticeConstant;

    	sim.domain = dc.initDecomposition(
    		cmd.xproc.i, cmd.yproc.i, cmd.zproc.i, globalExtent);

    	sim.boxes = lc.initLinkCells(sim.domain, sim.pot.cutoff);

    	sim.atoms = ia.initAtomsMain(sim.boxes);

    	// create lattice with desired temperature and displacement.
    	ia.createFccLattice(cmd.nx.i, cmd.ny.i, cmd.nz.i, latticeConstant, sim);

    	ia.setTemperature(sim, cmd.temperature.d as MyTypes.real_t);
    	ia.randomDisplacements(sim, cmd.initialDelta.d as MyTypes.real_t);

    	sim.atomExchange = he.initAtomHaloExchange(sim.domain, sim.boxes);

    	// Forces must be computed before we call the time stepper.
    	per.startTimer(per.redistributeTimer);
    	ts.redistributeAtoms(sim);
    	per.stopTimer(per.redistributeTimer);

    	per.startTimer(per.computeForceTimer);
    	ts.computeForce(sim);
    	per.stopTimer(per.computeForceTimer);

    	ts.kineticEnergy(sim);

    	return sim;
    }

    /// frees all data associated with *ps and frees *ps
    public def destroySimulation(ps:CoMDTypes.SimFlat):void
    {
    	return;
    }

    public static def initSubsystems(yaml:YamlOutput):void {
    	yaml.yamlBegin();
    }

    public static def finalizeSubsystems(yaml:YamlOutput):void
    {
    	yaml.yamlEnd();
    }

    /// decide whether to get LJ or EAM potentials
    public static def initPotential(doeam:Int, potDir:String, potName:String, potType:String, par:Parallel, per:PerformanceTimer, he:HaloExchange, lc:LinkCells):CoMDTypes.BasePotential
    {
    	val pot:CoMDTypes.BasePotential;
    
    	if (doeam != 0n) {
    		val e = new Eam(par, per, he, lc);
    		pot = e.initEamPot(potDir, potName, potType);
    	}
    	else {
    		val ljf = new LjForce(lc);
    		pot = ljf.initLjPot();
    	}
    	assert pot != null;
    	return pot;
    }

    public static def initSpecies(pot:CoMDTypes.BasePotential):CoMDTypes.SpeciesData
    {
        val species = new CoMDTypes.SpeciesData();

    	species.name = pot.name;
    	species.atomicNo = pot.atomicNo;
    	species.mass = pot.mass;

    	return species;
    }

    public static def initValidate(sim:CoMDTypes.SimFlat, per:PerformanceTimer, par:Parallel, yaml:YamlOutput):CoMDTypes.Validate
    {
    	sumAtoms(sim, per, par);
    	val valid = new CoMDTypes.Validate();
    	valid.eTot0 = (sim.ePotential + sim.eKinetic) / sim.atoms.nGlobal;
    	valid.nAtoms0 = sim.atoms.nGlobal;

    	if (par.printRank())
    	{
    		Console.OUT.printf("\n");
    		yaml.printSeparator(Console.OUT);
    		Console.OUT.printf("Initial energy : %14.12f, atom count : %d \n", 
    			valid.eTot0, valid.nAtoms0);
    		Console.OUT.printf("\n");
    	}
    	return valid;
    }

    public static def validateResult(valid:CoMDTypes.Validate, sim:CoMDTypes.SimFlat, par:Parallel):void
    {
    	if (par.printRank())
    	{
    		val eFinal:MyTypes.real_t = (sim.ePotential + sim.eKinetic) / sim.atoms.nGlobal;

    		val nAtomsDelta = (sim.atoms.nGlobal - valid.nAtoms0);

    		Console.OUT.printf("\n");
    		Console.OUT.printf("\n");
    		Console.OUT.printf("Simulation Validation:\n");

    		Console.OUT.printf("  Initial energy  : %14.12f\n", valid.eTot0);
    		Console.OUT.printf("  Final energy    : %14.12f\n", eFinal);
    		Console.OUT.printf("  eFinal/eInitial : %f\n", eFinal/valid.eTot0);
    		if ( nAtomsDelta == 0n)
    		{
    			Console.OUT.printf("  Final atom count : %d, no atoms lost\n",
    				sim.atoms.nGlobal);
    		}
    		else
    		{
    			Console.OUT.printf("#############################\n");
    			Console.OUT.printf("# WARNING: %6d atoms lost #\n", nAtomsDelta);
    			Console.OUT.printf("#############################\n");
    		}
    	}
    }
    static val src = new Rail[Int](1);
    static val dst = new Rail[Int](1);
    public static def sumAtoms(s:CoMDTypes.SimFlat, per:PerformanceTimer, par:Parallel):void
    {
    	// sum atoms across all processers
    	s.atoms.nLocal = 0n;
    	for (var i:Int = 0n; i < s.boxes.nLocalBoxes; i++)
    	{
    		s.atoms.nLocal += s.boxes.nAtoms(i);
    	}
    	per.startTimer(per.commReduceTimer);
        src(0) = s.atoms.nLocal;
        par.addIntParallel(src, dst, 1n);
        s.atoms.nGlobal = dst(0);
        per.stopTimer(per.commReduceTimer);
    }

    /// Prints current time, energy, performance etc to monitor the state of
    /// the running simulation.  Performance per atom is scaled by the
    /// number of local atoms per process this should give consistent timing
    /// assuming reasonable load balance
    private static class PrintThingsVar {
    	// keep track previous value of iStep so we can calculate number of steps.
    	var iStepPrev:Int = -1n;
    	var firstCall:Int = 1n;
    }
    public static def printThings(s:CoMDTypes.SimFlat, iStep:Int, elapsedTime:Double, ptv:PrintThingsVar, par:Parallel):void
    {
    	val nEval:Int = iStep - ptv.iStepPrev; // gives nEval = 1 for zeroth step.
    	ptv.iStepPrev = iStep;
    
    	if (! par.printRank() )
    		return;
    
    	if (ptv.firstCall != 0n)
    	{
    		ptv.firstCall = 0n;
    		Console.OUT.printf(
    			"#                                                                                         Performance\n" 
    	   	   +"#  Loop   Time(fs)       Total Energy   Potential Energy     Kinetic Energy  Temperature   (us/atom)     # Atoms\n");
    	}

    	val time:MyTypes.real_t = iStep*s.dt;
    	val eTotal:MyTypes.real_t = (s.ePotential+s.eKinetic) / s.atoms.nGlobal;
    	val eK:MyTypes.real_t = s.eKinetic / s.atoms.nGlobal;
    	val eU:MyTypes.real_t = s.ePotential / s.atoms.nGlobal;
    	val Temp:MyTypes.real_t = ((s.eKinetic / s.atoms.nGlobal) / (Constants.kB_eV * 1.5)) as MyTypes.real_t;

    	val timePerAtom:Double = 1.0e6*elapsedTime/(nEval*s.atoms.nLocal);

    	Console.OUT.printf(" %6d %10.2f %18.12f %18.12f ", iStep, time, eTotal, eU);
    	Console.OUT.printf("%18.12f %12.4f %10.4f %12d\n", eK, Temp, timePerAtom, s.atoms.nGlobal);
    }

    /// Print information about the simulation in a format that is (mostly)
    /// YAML compliant.
    public static def printSimulationDataYaml(file:Printer, s:CoMDTypes.SimFlat,
    		lc:LinkCells, par:Parallel, yaml:YamlOutput):void
    {
    	// All ranks get maxOccupancy
    	val maxOcc:Int = lc.maxOccupancy(s);

    	// Only rank 0 prints
    	if (! par.printRank())
    		return;
    
    	file.printf("Simulation data: \n");
    	file.printf("  Total atoms        : %d\n", 
    		s.atoms.nGlobal);
    	file.printf("  Min global bounds  : [ %14.10f, %14.10f, %14.10f ]\n",
    		s.domain.globalMin(0), s.domain.globalMin(1), s.domain.globalMin(2));
    	file.printf("  Max global bounds  : [ %14.10f, %14.10f, %14.10f ]\n",
    		s.domain.globalMax(0), s.domain.globalMax(1), s.domain.globalMax(2));
    	yaml.printSeparator(file);
    	file.printf("Decomposition data: \n");
    	file.printf("  Processors         : %6d,%6d,%6d\n", 
    		s.domain.procGrid(0), s.domain.procGrid(1), s.domain.procGrid(2));
    	file.printf("  Local boxes        : %6d,%6d,%6d = %8d\n", 
    		s.boxes.gridSize(0), s.boxes.gridSize(1), s.boxes.gridSize(2), 
    		s.boxes.gridSize(0)*s.boxes.gridSize(1)*s.boxes.gridSize(2));
    	file.printf("  Box size           : [ %14.10f, %14.10f, %14.10f ]\n", 
    		s.boxes.boxSize(0), s.boxes.boxSize(1), s.boxes.boxSize(2));
    	file.printf("  Box factor         : [ %14.10f, %14.10f, %14.10f ] \n", 
    		s.boxes.boxSize(0)/s.pot.cutoff,
    		s.boxes.boxSize(1)/s.pot.cutoff,
    		s.boxes.boxSize(2)/s.pot.cutoff);
    	file.printf("  Max Link Cell Occupancy: %d of %d\n",
    		maxOcc, lc.MAXATOMS);
    	yaml.printSeparator(file);
    	file.printf("Potential data: \n");
    }

    /// Check that the user input meets certain criteria.
    public static def sanityChecks(cmd:MyCommand.Command, cutoff:Double, latticeConst:Double, latticeType:String, par:Parallel):Int
    {
    	var failCode:Int = 0n;

    	// Check that domain grid matches number of ranks. (fail code 1)
    	val nProcs:Int = cmd.xproc.i * cmd.yproc.i * cmd.zproc.i;
    	if (nProcs != (par.getNRanks() as Int))
    	{
    		failCode |= 1;
    		if (par.printRank() )
    		Console.OUT.printf(
    			"\nNumber of MPI ranks must match xproc * yproc * zproc\n");
    	}

    	// Check whether simuation is too small (fail code 2)
    	val minx:Double = 2*cutoff*cmd.xproc.i;
    	val miny:Double = 2*cutoff*cmd.yproc.i;
    	val minz:Double = 2*cutoff*cmd.zproc.i;
    	val sizex:Double = cmd.nx.i*latticeConst;
    	val sizey:Double = cmd.ny.i*latticeConst;
    	val sizez:Double = cmd.nz.i*latticeConst;

    	if ( sizex < minx || sizey < miny || sizez < minz)
    	{
    		failCode |= 2;
    		if (par.printRank())
    			Console.OUT.printf("\nSimulation too small.\n"
    							  +"  Increase the number of unit cells to make the simulation\n"
    							  +"  at least (%3.2f, %3.2f. %3.2f) Ansgstroms in size\n",
                                   minx, miny, minz);
    	}

    	// Check for supported lattice structure (fail code 4)
    	if (latticeType.compareToIgnoreCase("FCC") != 0n)
    	{
    		failCode |= 4;
    		if ( par.printRank() )
    		Console.OUT.printf(
    			"\nOnly FCC Lattice type supported, not %s. Fatal Error.\n",
                latticeType);
    	}
    	val checkCode = new Rail[Int](1), castedCheckCode = new Rail[Int](1);
    	checkCode(0) = failCode;
    	par.bcastParallel[Int](checkCode, castedCheckCode, checkCode.size, 0);
    	// This assertion can only fail if different tasks failed different
    	// sanity checks.  That should not be possible.
    	assert castedCheckCode(0) == failCode;
    
    	return failCode;
    }
}