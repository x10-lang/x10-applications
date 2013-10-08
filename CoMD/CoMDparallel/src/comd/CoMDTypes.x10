/// \file
/// CoMD data structures.

package comd;

import x10.io.Printer;

public class CoMDTypes {
    /// The base struct from which all potentials derive.  Think of this as an
    /// abstract base class.
    ///
    /// CoMD uses the following units:
    ///  - distance is in Angstroms
    ///  - energy is in eV
    ///  - time is in fs
    ///  - force in in eV/Angstrom
    ///
    ///  The choice of distance, energy, and time units means that the unit
    ///  of mass is eV*fs^2/Angstrom^2.  Hence, we must convert masses that
    ///  are input in AMU (atomic mass units) into internal mass units.
    public static class BasePotential {
    	var cutoff:MyTypes.real_t;         		//!< potential cutoff distance in Angstroms
    	var mass:MyTypes.real_t;            	//!< mass of atoms in intenal units
    	var lat:MyTypes.real_t;             	//!< lattice spacing (angs) of unit cell
    	var latticeType:String;    				//!< lattice type, e.g. FCC, BCC, etc.
    	var name:String;	   					//!< element name
    	var atomicNo:Int;	   					//!< atomic number  
    	var force:(SimFlat)=>Int;				//!< function pointer to force routine
    	var print:(Printer, BasePotential)=>Int;
    	var destroy:(BasePotential)=>void;		//!< destruction of the potential
    
    	var sigma:MyTypes.real_t;				//!< from LjPotential				
    	var epsilon:MyTypes.real_t;				//!< from LjPotential

    	var phi:Eam.InterpolationObject;  		//!< Pair energy
    	var rho:Eam.InterpolationObject;  		//!< Electron Density
    	var f:Eam.InterpolationObject;    		//!< Embedding Energy

    	var rhobar:Rail[MyTypes.real_t];        //!< per atom storage for rhobar
    	var dfEmbed:Rail[MyTypes.real_t];       //!< per atom storage for derivative of Embedding
    	var forceExchange:HaloExchange.HaloExchangeSt;
    	var forceExchangeData:Eam.ForceExchangeData;
    }
    
    /// species data: chosen to match the data found in the setfl/funcfl files
    public static class SpeciesData {
    	var name:String;   //!< element name
    	var atomicNo:Int;  //!< atomic number  
    	var mass:MyTypes.real_t;     //!< mass in internal units
    }
    
    /// Simple struct to store the initial energy and number of atoms. 
    /// Used to check energy conservation and atom conservation. 
    public static class Validate {
    	var eTot0:Double; //<! Initial total energy
    	var nAtoms0:Int;  //<! Initial global number of atoms
    }

    /// 
    /// The fundamental simulation data structure with MAXATOMS in every
    /// link cell.
    ///
    public static class SimFlat {
    	var nSteps:Int;            //<! number of time steps to run
    	var printRate:Int;         //<! number of steps between output
    	var dt:MyTypes.real_t;             //<! time step

    	var domain:Decomposition.Domain;        //<! domain decomposition data

    	var boxes:LinkCells.LinkCell;       //<! link-cell data

    	var atoms:InitAtoms.Atoms;          //<! atom data (positions, momenta, ...)

    	var species:Rail[SpeciesData];  //<! species data (per species, not per atom)

    	var ePotential:MyTypes.real_t;     //!< the total potential energy of the system
    	var eKinetic:MyTypes.real_t;       //!< the total kinetic energy of the system

    	var pot:BasePotential;	  //!< the potential

    	var atomExchange:HaloExchange.HaloExchangeSt;
    
    	var sanity:Int;						//!< sanity check code: 0 is OK
    }

}