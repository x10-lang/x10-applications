/// \file
/// Handle command line arguments.

package comd;

import x10.io.Printer;

/// \page pg_running_comd Running CoMD
///
/// \section sec_command_line_options Command Line Options
///
/// CoMD accepts a number of command line options to set the parameters
/// of the simulation.  Every option has both a long form and a short
/// form.  The long and short form of the arguments are entirely
/// interchangeable and may be mixed. All the arguments are independent
/// with the exception of the \--potDir, \--potName, and \--potType,
/// (short forms -d, -n, and -t) arguments which are only relevant when
/// used in conjunction with \--doeam, (-e).
///
/// Supported options are:
///
/// | Long  Form    | Short Form  | Default Value | Description
/// | :------------ | :---------: | :-----------: | :----------
/// | \--help       | -h          | N/A           | print this message
/// | \--potDir     | -d          | pots          | potential directory
/// | \--potName    | -p          | Cu_u6.eam     | potential name
/// | \--potType    | -t          | funcfl        | potential type (funcfl or setfl)
/// | \--doeam      | -e          | N/A           | compute eam potentials (default is LJ)
/// | \--nx         | -x          | 20            | number of unit cells in x
/// | \--ny         | -y          | 20            | number of unit cells in y
/// | \--nz         | -z          | 20            | number of unit cells in z
/// | \--xproc      | -i          | 1             | number of ranks in x direction
/// | \--yproc      | -j          | 1             | number of ranks in y direction
/// | \--zproc      | -k          | 1             | number of ranks in z direction
/// | \--nSteps     | -N          | 100           | total number of time steps
/// | \--printRate  | -n          | 10            | number of steps between output
/// | \--dt         | -D          | 1             | time step (in fs)
/// | \--lat        | -l          | -1            | lattice parameter (Angstroms)
/// | \--temp       | -T          | 600           | initial temperature (K)
/// | \--delta      | -r          | 0             | initial delta (Angstroms)
///
/// Notes: 
/// 
/// The negative value for the lattice parameter (such as the default
/// value, -1) is interpreted as a flag to indicate that the lattice
/// parameter should be set from the potential. All supplied potentials
/// are for copper and have a lattice constant of 3.615
/// Angstroms. Setting the lattice parameter to any positive value will
/// override the values provided in the potential files.
///
/// The default potential name for the funcfl potential type is
/// Cu_u6.eam (Adams potential).  For the setfl type the default
/// potential name is Cu01.eam.alloy (Mishin potential).  Although these
/// will yield similar dynamics, the table have a very different number
/// of entries (500 vs. 10,000 points, respectively) This may give very
/// different performance, depending on the hardware.
///
/// The default temperature is 600K.  However, when using a perfect
/// lattice the system will rapidly cool to 300K due to equipartition of
/// energy.
///
/// 
/// \subsection ssec_example_command_lines Examples
///
/// All of the examples below assume:
/// - The current working directory contains a copy of the pots dir (or
///   a link to it).
/// - The CoMD bin directory is located in ../bin
///
/// Running in the examples directory will satisfy these requirements.
///
/// ------------------------------
///
/// The canonical base simulation, is 
///
///     $ mpirun -np 1 ../bin/CoMD-mpi 
/// 
/// Or, if the code was built without MPI:
///
///     $ ../bin/CoMD-serial
///
/// ------------------------------
///
/// \subsubsection cmd_examples_potential Changing Potentials
///
/// To run with the default (Adams) EAM potential, specify -e:
///
///     $ ../bin/CoMD-mpi -e 
///
/// ------------------------------
///
/// To run using the Mishin EAM potential contained in the setfl file
/// Cu01.eam.alloy. This potential uses much larger tables (10,000
/// entries vs. 500 for the Adams potential).
///
///     $ ../bin/CoMD-mpi -e -t setfl 
///
/// ------------------------------
///
/// Selecting the name of a setfl file without setting the appropriate
/// potential type
///
///     $ ../bin/CoMD-mpi -e -p Cu01.eam.alloy 
/// 
/// will result in an error message:
///
/// Only FCC Lattice type supported, not . Fatal Error.
/// 
/// Instead use:
///
///     $ ../bin/CoMD-mpi -e -t setfl -p Cu01.eam.alloy 
///
/// ------------------------------
///
/// \subsubsection cmd_example_struct Initial Structure Modifications
///
/// To change the lattice constant and run with an expanded or
/// compressed lattice:
///
///     $ ../bin/CoMD-mpi -l 3.5 
///
/// This can be useful to test that the potential is being correctly
/// evaluated as a function of interatomic spacing (the cold
/// curve). However, due to the high degree of symmetry of a perfect
/// lattice, this type of test is unlikely to detect errors in the force
/// computation.
///
/// ------------------------------
///
/// Initialize with zero temperature (zero instantaneous particle
/// velocity) but with a random displacements of the atoms (in this
/// case the maximum displacement is 0.1 Angstrom along each axis).  
/// 
///      $ ../bin/CoMD-mpi --delta 0.1 -T 0
///
/// Typical values of delta are in the range of 0.1 to 0.5 Angstroms.
/// Larger values of delta correspond to higher initial potential energy
/// which in turn produce higer temperatures as the structure
/// equilibrates.
///
/// ------------------------------
///
///
/// \subsubsection cmd_examples_scaling Scaling Examples
///
/// Simple shell scripts that demonstrate weak and strong scaling
/// studies are provided in the examples directory.
///
/// ------------------------------
///
/// Run the default global simulation size (32,000 atoms) distributed
/// over 8 cubic subdomains, an example of strong scaling.  If the
/// number of processors does not equal (i*j*k) the run will abort.
/// Notice that spaces are optional between short form options and their
/// arguments.
/// 
///     $ mpirun -np 8 ../bin/CoMD-mpi -i2 -j2 -k2
/// 
/// ------------------------------
///
/// Run a weak scaling example: the simulation is doubled in each
/// dimension from the default 20 x 20 x 20 and the number of subdomains
/// in each direction is also doubled.
///
///     $ mpirun -np 8 ../bin/CoMD-mpi -i2 -j2 -k2 -x 40 -y 40 -z 40
///
/// ------------------------------
///
/// The same weak scaling run, but for 10,000 timesteps, with output
/// only every 100 steps.
///
///     $ mpirun -np 8 ../bin/CoMD-mpi -i2 -j2 -k2 -x 40 -y 40 -z 40 -N 10000 -n 100
///

/// \details Initialize a Command structure with default values, then
/// parse any command line arguments that were supplied to overwrite
/// defaults.
///
/// \param [in] argc the number of command line arguments
/// \param [in] argv the command line arguments array

public class MyCommand {
	
    static class Command {
    	var potDir:CmdLineParser.WrappedValue		= new CmdLineParser.WrappedValue();	//!< the directory where EAM potentials reside
    	var potName:CmdLineParser.WrappedValue		= new CmdLineParser.WrappedValue();	//!< the name of the potential
    	var potType:CmdLineParser.WrappedValue		= new CmdLineParser.WrappedValue();	//!< the type of the potential (funcfl or setfl)
    	var doeam:CmdLineParser.WrappedValue		= new CmdLineParser.WrappedValue();	//!< a flag to determine whether we're running EAM potentials
    	var nx:CmdLineParser.WrappedValue			= new CmdLineParser.WrappedValue();	//!< number of unit cells in x
    	var ny:CmdLineParser.WrappedValue			= new CmdLineParser.WrappedValue();	//!< number of unit cells in y
    	var nz:CmdLineParser.WrappedValue			= new CmdLineParser.WrappedValue();	//!< number of unit cells in z
    	var xproc:CmdLineParser.WrappedValue		= new CmdLineParser.WrappedValue();	//!< number of processors in x direction
    	var yproc:CmdLineParser.WrappedValue		= new CmdLineParser.WrappedValue();	//!< number of processors in y direction
    	var zproc:CmdLineParser.WrappedValue		= new CmdLineParser.WrappedValue();	//!< number of processors in z direction
    	var nSteps:CmdLineParser.WrappedValue		= new CmdLineParser.WrappedValue();	//!< number of time steps to run
    	var printRate:CmdLineParser.WrappedValue	= new CmdLineParser.WrappedValue();	//!< number of steps between output
    	var dt:CmdLineParser.WrappedValue			= new CmdLineParser.WrappedValue();	//!< time step (in femtoseconds)
    	var lat:CmdLineParser.WrappedValue			= new CmdLineParser.WrappedValue();	//!< lattice constant (in Angstroms)
    	var temperature:CmdLineParser.WrappedValue	= new CmdLineParser.WrappedValue();	//!< simulation initial temperature (in Kelvin)
    	var initialDelta:CmdLineParser.WrappedValue	= new CmdLineParser.WrappedValue();	//!< magnitude of initial displacement from lattice (in Angstroms)
    }

    val par:Parallel;
    def this (par:Parallel) {
    	this.par = par;
    }
    
	public def parseCommandLine(args:Rail[String]):Command {
		val cmd = new Command();

        cmd.potDir.s = "pots";
		cmd.potName.s = "\0";
		cmd.potType.s = "funcfl";
		cmd.doeam.i = 0n;
		cmd.nx.i = 20n;
		cmd.ny.i = 20n;
		cmd.nz.i = 20n;
		cmd.xproc.i = 1n;
		cmd.yproc.i = 1n;
		cmd.zproc.i = 1n;
		cmd.nSteps.i = 100n;
		cmd.printRate.i = 10n;
		cmd.dt.d = 1.0;
		cmd.lat.d = -1.0;
		cmd.temperature.d = 600.0;
		cmd.initialDelta.d = 0.0;

		val help:CmdLineParser.WrappedValue = new CmdLineParser.WrappedValue();
        help.i = 0n;

		// add arguments for processing.  Please update the html documentation too!
        val clp = new CmdLineParser();

		clp.addArg("help",       'h', 0n, 'i',  help,             0n,             "print this message");
		clp.addArg("potDir",     'd', 1n, 's',  cmd.potDir,    cmd.potDir.s.length(),  "potential directory");
        clp.addArg("potName",    'p', 1n, 's',  cmd.potName,   cmd.potName.s.length(), "potential name");
        clp.addArg("potType",    't', 1n, 's',  cmd.potType,   cmd.potType.s.length(), "potential type (funcfl or setfl)");
        clp.addArg("doeam",      'e', 0n, 'i',  cmd.doeam,        0n,             "compute eam potentials");
        clp.addArg("nx",         'x', 1n, 'i',  cmd.nx,           0n,             "number of unit cells in x");
        clp.addArg("ny",         'y', 1n, 'i',  cmd.ny,           0n,             "number of unit cells in y");
        clp.addArg("nz",         'z', 1n, 'i',  cmd.nz,           0n,             "number of unit cells in z");
        clp.addArg("xproc",      'i', 1n, 'i',  cmd.xproc,        0n,             "processors in x direction");
        clp.addArg("yproc",      'j', 1n, 'i',  cmd.yproc,        0n,             "processors in y direction");
        clp.addArg("zproc",      'k', 1n, 'i',  cmd.zproc,        0n,             "processors in z direction");
        clp.addArg("nSteps",     'N', 1n, 'i',  cmd.nSteps,       0n,             "number of time steps");
        clp.addArg("printRate",  'n', 1n, 'i',  cmd.printRate,    0n,             "number of steps between output");
        clp.addArg("dt",         'D', 1n, 'd',  cmd.dt,           0n,             "time step (in fs)");
        clp.addArg("lat",        'l', 1n, 'd',  cmd.lat,          0n,             "lattice parameter (Angstroms)");
        clp.addArg("temp",       'T', 1n, 'd',  cmd.temperature,  0n,             "initial temperature (K)");
        clp.addArg("delta",      'r', 1n, 'd',  cmd.initialDelta, 0n,             "initial delta (Angstroms)");

		clp.processArgs(args);

		// If user didn't set potName, set type dependent default.
		if (cmd.potName.s == "\0"); 
		{
			if (cmd.potType.s.equals("setfl"))
				cmd.potName.s = "Cu01.eam.alloy";
			if (cmd.potType.s.equals("funcfl"))
				cmd.potName.s = "Cu_u6.eam";
		}
		
		if (help.i == 1n)
		{
			clp.printArgs();
            return null;
		}

		return cmd;
	}

	public def printCmdYaml(out:Printer, cmd:Command):void {
		if (! par.printRank())
			return;
		out.printf(
				"Command Line Parameters:\n"
				+"  doeam: %d\n"
				+"  potDir: %s\n"
				+"  potName: %s\n"
				+"  potType: %s\n",
				    cmd.doeam.i,
				    cmd.potDir.s,
				    cmd.potName.s,
				    cmd.potType.s
				    );
		out.printf(
				"  nx: %d\n"
				+"  ny: %d\n"
				+"  nz: %d\n"
				+"  xproc: %d\n"
				+"  yproc: %d\n"
				+"  zproc: %d\n",
				cmd.nx.i, cmd.ny.i, cmd.nz.i,
				cmd.xproc.i, cmd.yproc.i, cmd.zproc.i
		);
		out.printf(
				"  Lattice constant: %g Angstroms\n"
				+"  nSteps: %d\n"
				+"  printRate: %d\n"
				+"  Time step: %g fs\n"
				+"  Initial Temperature: %g K\n"
				+"  Initial Delta: %g Angstroms\n"
				+"\n",
				cmd.lat.d,
				cmd.nSteps.i,
				cmd.printRate.i,
				cmd.dt.d,
				cmd.temperature.d,
				cmd.initialDelta.d
		);
		out.flush();
	}
}