/// \file
/// Computes forces for the 12-6 Lennard Jones (LJ) potential.
///
/// The Lennard-Jones model is not a good representation for the
/// bonding in copper, its use has been limited to constant volume
/// simulations where the embedding energy contribution to the cohesive
/// energy is not included in the two-body potential
///
/// The parameters here are taken from Wolf and Phillpot and fit to the
/// room temperature lattice constant and the bulk melt temperature
/// Ref: D. Wolf and S.Yip eds. Materials Interfaces (Chapman & Hall
///      1992) Page 230.
///
/// Notes on LJ:
///
/// http://en.wikipedia.org/wiki/Lennard_Jones_potential
///
/// The total inter-atomic potential energy in the LJ model is:
///
/// \f[
///   E_{tot} = \sum_{ij} U_{LJ}(r_{ij})
/// \f]
/// \f[
///   U_{LJ}(r_{ij}) = 4 \epsilon
///           \left\{ \left(\frac{\sigma}{r_{ij}}\right)^{12}
///           - \left(\frac{\sigma}{r_{ij}}\right)^6 \right\}
/// \f]
///
/// where \f$\epsilon\f$ and \f$\sigma\f$ are the material parameters in the potential.
///    - \f$\epsilon\f$ = well depth
///    - \f$\sigma\f$   = hard sphere diameter
///
///  To limit the interation range, the LJ potential is typically
///  truncated to zero at some cutoff distance. A common choice for the
///  cutoff distance is 2.5 * \f$\sigma\f$.
///  This implementation can optionally shift the potential slightly
///  upward so the value of the potential is zero at the cuotff
///  distance.  This shift has no effect on the particle dynamics.
///
///
/// The force on atom i is given by
///
/// \f[
///   F_i = -\nabla_i \sum_{jk} U_{LJ}(r_{jk})
/// \f]
///
/// where the subsrcipt i on the gradient operator indicates that the
/// derivatives are taken with respect to the coordinates of atom i.
/// Liberal use of the chain rule leads to the expression
///
/// \f{eqnarray*}{
///   F_i &=& - \sum_j U'_{LJ}(r_{ij})\hat{r}_{ij}\\
///       &=& \sum_j 24 \frac{\epsilon}{r_{ij}} \left\{ 2 \left(\frac{\sigma}{r_{ij}}\right)^{12}
///               - \left(\frac{\sigma}{r_{ij}}\right)^6 \right\} \hat{r}_{ij}
/// \f}
///
/// where \f$\hat{r}_{ij}\f$ is a unit vector in the direction from atom
/// i to atom j.
/// 
///

package comd;
import x10.io.Printer;

public class LjForce {
    static val POT_SHIFT = 1.0 as MyTypes.real_t;

    /// Derived struct for a Lennard Jones potential.
    /// Polymorphic with BasePotential.
    /// \see BasePotential
    val lc:LinkCells;
    val my:MyTypes;
    val nbrBoxes:Rail[Int];
    val dr:Rail[MyTypes.real_t];
    def this (lc:LinkCells) {
    	this.lc = lc;
        this.my = new MyTypes();
        this.nbrBoxes = new Rail[Int](27);
        this.dr = new Rail[MyTypes.real_t](3);
    }
    /// Initialize an Lennard Jones potential for Copper.
    public def initLjPot(): CoMDTypes.BasePotential
    {
    	val pot = new CoMDTypes.BasePotential();
    	val ljForceMainFunc = (s:CoMDTypes.SimFlat)=>ljForceMain(s);
    	val ljPrintFunc = (out:Printer, pot:CoMDTypes.BasePotential)=>ljPrint(out, pot);
    	pot.force = ljForceMainFunc;
    	pot.print = ljPrintFunc;
    	//pot.destroy = ljDestroy;
    	pot.sigma = 2.315 as MyTypes.real_t;	// Angstrom
    	pot.epsilon = 0.167 as MyTypes.real_t;	// eV
    	pot.mass = (63.55 * Constants.amuToInternalMass) as MyTypes.real_t; // Atomic Mass Units (amu)

    	pot.lat = 3.615 as MyTypes.real_t;                      // Equilibrium lattice const in Angs
    	pot.latticeType = "FCC";       // lattice type, i.e. FCC, BCC, etc.
    	pot.cutoff = (2.5 * pot.sigma) as MyTypes.real_t;          // Potential cutoff in Angs

    	pot.name = "Cu";
    	pot.atomicNo = 29n;

    	return pot;
    }

    public def ljPrint(out:Printer, pot:CoMDTypes.BasePotential):Int
    {
    	out.printf("  Potential type   : Lennard-Jones\n");
    	out.printf("  Species name     : %s\n", pot.name);
    	out.printf("  Atomic number    : %d\n", pot.atomicNo);
    	out.printf("  Mass             : "+MyTypes.FMT1+" amu\n", pot.mass / Constants.amuToInternalMass); // print in amu
    	out.printf("  Lattice Type     : %s\n", pot.latticeType);
    	out.printf("  Lattice spacing  : "+MyTypes.FMT1+" Angstroms\n", pot.lat);
    	out.printf("  Cutoff           : "+MyTypes.FMT1+" Angstroms\n", pot.cutoff);
    	out.printf("  Epsilon          : "+MyTypes.FMT1+" eV\n", pot.epsilon);
    	out.printf("  Sigma            : "+MyTypes.FMT1+" Angstroms\n", pot.sigma);
    	return 0n;
    }

    public def ljForceMain(s:CoMDTypes.SimFlat):Int
    {
        val pot = s.pot;
    	val sigma:MyTypes.real_t = pot.sigma;
    	val epsilon:MyTypes.real_t = pot.epsilon;
    	val rCut:MyTypes.real_t = pot.cutoff;
    	val rCut2:MyTypes.real_t = rCut*rCut;

    	// zero forces and energy
    	var ePot:MyTypes.real_t = MyTypes.real_t0;
    	s.ePotential = MyTypes.real_t0;
    	val fSize = s.boxes.nTotalBoxes*LinkCells.MAXATOMS;
    	for (var ii:Int=0n; ii<fSize; ++ii)
    	{
    		my.zeroReal3(s.atoms.f(ii));
    		s.atoms.U(ii) = MyTypes.real_t0;
    	}
    
    	val s6:MyTypes.real_t = sigma*sigma*sigma*sigma*sigma*sigma;

    	val rCut6:MyTypes.real_t = s6 / (rCut2*rCut2*rCut2);
    	val eShift:MyTypes.real_t = (POT_SHIFT * rCut6 * (rCut6 - 1.0)) as MyTypes.real_t;

    	// loop over local boxes
    	for (var iBox:Int=0n; iBox<s.boxes.nLocalBoxes; iBox++)
    	{
    		val nIBox = s.boxes.nAtoms(iBox);
    		if ( nIBox == 0n ) continue;
    		val nNbrBoxes = lc.getNeighborBoxes(s.boxes, iBox, nbrBoxes);
    		// loop over neighbors of iBox
    		for (var jTmp:Int=0n; jTmp<nNbrBoxes; jTmp++)
    		{
    			val jBox = nbrBoxes(jTmp);
    
    			assert jBox>=0;
    
    			val nJBox = s.boxes.nAtoms(jBox);
    			if ( nJBox == 0n ) continue;
    
    			// loop over atoms in iBox
    			for (var iOff:Int=iBox*LinkCells.MAXATOMS,ii:Int=0n; ii<nIBox; ii++,iOff++)
    			{
    				val iId = s.atoms.gid(iOff);
    				// loop over atoms in jBox
    				for (var jOff:Int=LinkCells.MAXATOMS*jBox,ij:Int=0n; ij<nJBox; ij++,jOff++)
    				{
    					val jId:Int = s.atoms.gid(jOff);  
    					if (jBox < s.boxes.nLocalBoxes && jId <= iId )
    						continue; // don't double count local-local pairs.
    					var r2:MyTypes.real_t = MyTypes.real_t0;
    					for (var m:Int=0n; m<3; m++)
    					{
    						dr(m) = s.atoms.r(iOff)(m)-s.atoms.r(jOff)(m);
    						r2+=dr(m)*dr(m);
    					}
    
    					if ( r2 > rCut2) continue;

    					// Important note:
    					// from this point on r actually refers to 1.0/r
    					r2 = (1.0/r2) as MyTypes.real_t;
    					val r6:MyTypes.real_t = s6 * (r2*r2*r2);
    					val eLocal:MyTypes.real_t = (r6 * (r6 - 1.0) - eShift) as MyTypes.real_t;
    					s.atoms.U(iOff) += (0.5*eLocal) as MyTypes.real_t;
    					s.atoms.U(jOff) += (0.5*eLocal) as MyTypes.real_t;

    					// calculate energy contribution based on whether
    					// the neighbor box is local or remote
    					if (jBox < s.boxes.nLocalBoxes)
    						ePot += eLocal;
    					else
    						ePot += 0.5 * eLocal;

    					// different formulation to avoid sqrt computation
    					var fr:MyTypes.real_t = (-4.0*epsilon*r6*r2*(12.0*r6 - 6.0)) as MyTypes.real_t;
    					for (var m:Int=0n; m<3; m++)
    					{
    						s.atoms.f(iOff)(m) -= dr(m)*fr;
    						s.atoms.f(jOff)(m) += dr(m)*fr;
    					}
    				} // loop over atoms in jBox
    			} // loop over atoms in iBox
    		} // loop over neighbor boxes
    	} // loop over local boxes in system

    	ePot = (ePot*4.0*epsilon) as MyTypes.real_t;
    	s.ePotential = ePot;

    	return 0n;
    }
}
