/// \file
/// Compute forces for the Embedded Atom Model (EAM).
///
/// The Embedded Atom Model (EAM) is a widely used model of atomic
/// interactions in simple metals.
/// 
/// http://en.wikipedia.org/wiki/Embedded_atom_model
///
/// In the EAM, the total potential energy is written as a sum of a pair
/// potential and the embedding energy, F:
///
/// \f[
///   U = \sum_{ij} \varphi(r_{ij}) + \sum_i F({\bar\rho_i})
/// \f]
///
/// The pair potential \f$\varphi_{ij}\f$ is a two-body inter-atomic
/// potential, similar to the Lennard-Jones potential, and
/// \f$F(\bar\rho)\f$ is interpreted as the energy required to embed an
/// atom in an electron field with density \f$\bar\rho\f$.  The local
/// electon density at site i is calulated by summing the "effective
/// electron density" due to all neighbors of atom i:
///
/// \f[
/// \bar\rho_i = \sum_j \rho_j(r_{ij})
/// \f]
///
/// The force on atom i, \f${\bf F}_i\f$ is given by
///
/// \f{eqnarray*}{
///   {\bf F}_i & = & -\nabla_i \sum_{jk} U(r_{jk})\\
///       & = & - \sum_j\left\{
///                  \varphi'(r_{ij}) +
///                  [F'(\bar\rho_i) + F'(\bar\rho_j)]\rho'(r_{ij})
///                \right\} \hat{r}_{ij}
/// \f}
///
/// where primes indicate the derivative of a function with respect to
/// its argument and \f$\hat{r}_{ij}\f$ is a unit vector in the
/// direction from atom i to atom j.
///
/// The form of this force expression has two significant consequences.
/// First, unlike with a simple pair potential, it is not possible to
/// compute the potential energy and the forces on the atoms in a single
/// loop over the pairs.  The terms involving \f$ F'(\bar\rho) \f$
/// cannot be calculated until \f$ \bar\rho \f$ is known, but
/// calculating \f$ \bar\rho \f$ requires a loop over the pairs.  Hence
/// the EAM force routine contains three loops.
///
///   -# Loop over all pairs, compute the two-body
///   interaction and the electron density at each atom
///   -# Loop over all atoms, compute the embedding energy and its
///   derivative for each atom
///   -# Loop over all pairs, compute the embedding
///   energy contribution to the force and add to the two-body force
///
/// The second loop over pairs doubles the data motion requirement
/// relative to a simple pair potential.
///
/// The second consequence of the force expression is that computing the
/// forces on all atoms requires additional communication beyond the
/// coordinates of all remote atoms within the cutoff distance.  This is
/// again because of the terms involving \f$ F'(\bar\rho_j) \f$.  If
/// atom j is a remote atom, the local task cannot compute \f$
/// \bar\rho_j \f$.  (Such a calculation would require all the neighbors
/// of atom j, some of which can be up to 2 times the cutoff distance
/// away from a local atom---outside the typical halo exchange range.)
///
/// To obtain the needed remote density we introduce a second halo
/// exchange after loop number 2 to communicate \f$ F'(\bar\rho) \f$ for
/// remote atoms.  This provides the data we need to complete the third
/// loop, but at the cost of introducing a communication operation in
/// the middle of the force routine.
///
/// At least two alternate methods can be used to deal with the remote
/// density problem.  One possibility is to extend the halo exchange
/// radius for the atom exchange to twice the potential cutoff distance.
/// This is likely undesirable due to large increase in communication
/// volume.  The other possibility is to accumulate partial force terms
/// on the tasks where they can be computed.  In this method, tasks will
/// compute force contributions for remote atoms, then communicate the
/// partial forces at the end of the halo exchange.  This method has the
/// advantage that the communication is deffered until after the force
/// loops, but the disadvantage that three times as much data needs to
/// be set (three components of the force vector instead of a single
/// scalar \f$ F'(\bar\rho) \f$.

package comd;

import x10.io.Printer;
import x10.compiler.Inline;

public class Eam {
    /// Pointers to the data that is needed in the load and unload functions
    /// for the force halo exchange.
    /// \see loadForceBuffer
    /// \see unloadForceBuffer
    public static class ForceExchangeData {
    	var dfEmbed:Rail[MyTypes.real_t]; //<! derivative of embedding energy
    	var boxes:LinkCells.LinkCell;
    }

    /// Handles interpolation of tabular data.
    ///
    /// \see initInterpolationObject
    /// \see interpolate
    public static class InterpolationObject {
    	var n:Int;          //!< the number of values in the table
    	var x0:MyTypes.real_t;      //!< the starting ordinate range
    	var invDx:MyTypes.real_t;   //!< the inverse of the table spacing
    	var values:Rail[MyTypes.real_t]; //!< the abscissa values
    }

    /// Derived struct for an EAM potential.
    /// Uses table lookups for function evaluation.
    /// Polymorphic with BasePotential.
    /// \see BasePotential
    public static type EamPotential = CoMDTypes.BasePotential;
    
    val par:Parallel;
    val per:PerformanceTimer;
    val he:HaloExchange;
    val lc:LinkCells;
    //val nbrBoxes:Rail[Int];
    //val dr:MyTypes.real3;
    //val phiTmp:Cell[MyTypes.real_t],
        //dPhi:Cell[MyTypes.real_t],
        //rhoTmp:Cell[MyTypes.real_t],
    	//dRho:Cell[MyTypes.real_t],
        //fEmbed:Cell[MyTypes.real_t],
        //dfEmbed:Cell[MyTypes.real_t];
    def this (par:Parallel, per:PerformanceTimer, he:HaloExchange, lc:LinkCells) {
    	this.par = par;
    	this.per = per;
    	this.he = he;
    	this.lc = lc;
    	//this.nbrBoxes = new Rail[Int](27);
    	//this.dr = new MyTypes.real3(3);
    	//this.phiTmp = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	//this.dPhi = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	//this.rhoTmp = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	//this.dRho = new Cell[MyTypes.real_t](MyTypes.real_t0);
        //this.fEmbed = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	//this.dfEmbed = new Cell[MyTypes.real_t](MyTypes.real_t0);
    }
    
    /// Allocate and initialize the EAM potential data structure.
    ///
    /// \param [in] dir   The directory in which potential table files are found.
    /// \param [in] file  The name of the potential table file.
    /// \param [in] type  The file format of the potential file (setfl or funcfl).
    public def initEamPot(dir:String, file:String, valueType:String):CoMDTypes.BasePotential 
    {
        val pot = new CoMDTypes.BasePotential();
        assert pot != null;
        val eamForceFunc = (s:CoMDTypes.SimFlat)=>eamForce(s);
        val eamPrintFunc = (out:Printer, pot:CoMDTypes.BasePotential)=>eamPrint(out, pot);
        pot.force = eamForceFunc;
    	pot.print = eamPrintFunc;
    	//pot.destroy = eamDestroy;
    	pot.phi = null;
    	pot.rho = null;
    	pot.f   = null;

    	// Initialization of the next three items requires information about
    	// the parallel decomposition and link cells that isn't available
    	// with the potential is initialized.  Hence, we defer their
    	// initialization until the first time we call the force routine.
    	//pot.dfEmbed = null;
    	//pot.rhobar  = null;
    	pot.forceExchange = null;
    
    	if (par.getMyRank() == 0)
    	{
    		if (valueType.equals("setfl"))
    			eamReadSetfl(pot, dir, file);
    		else if (valueType.equals("funcfl"))
    			eamReadFuncfl(pot, dir, file);
    		else
    			typeNotSupported("initEamPot", valueType);
    	}
   		eamBcastPotential(pot, par);
    
    	return pot;
    }

    /// Calculate potential energy and forces for the EAM potential.
    ///
    /// Three steps are required:
    ///
    ///   -# Loop over all atoms and their neighbors, compute the two-body
    ///   interaction and the electron density at each atom
    ///   -# Loop over all atoms, compute the embedding energy and its
    ///   derivative for each atom
    ///   -# Loop over all atoms and their neighbors, compute the embedding
    ///   energy contribution to the force and add to the two-body force
    /// 
    static class WrappedReal_t { var value:MyTypes.real_t; }
    public def eamForce(s:CoMDTypes.SimFlat):int
    {
/*
		var total:Double = 0;
		val start = System.nanoTime();
*/
    	// OPT: loop invariant references
    	val atoms:InitAtoms.Atoms = s.atoms;
    	val boxes:LinkCells.LinkCell = s.boxes;
    	val nLocalBoxes = boxes.nLocalBoxes;
    	val nTotalBoxes = boxes.nTotalBoxes;
    	val nAtoms = boxes.nAtoms;
    	val atoms_r = atoms.r;
    	val atoms_f = atoms.f;
    	val atoms_U = atoms.U;
    	val nbrBoxes:Rail[Int] = new Rail[Int](27);
    	val phiTmp = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	val dPhi = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	val rhoTmp = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	val dRho = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	val fEmbed = new Cell[MyTypes.real_t](MyTypes.real_t0);
    	val dfEmbed = new Cell[MyTypes.real_t](MyTypes.real_t0);

    	val pot:EamPotential = s.pot as EamPotential;
    	assert pot != null;

    	// set up halo exchange and internal storage on first call to forces.
    	if (pot.forceExchange == null)
    	{
    		val maxTotalAtoms = LinkCells.MAXATOMS*nTotalBoxes;
    		pot.dfEmbed = new Rail[MyTypes.real_t](maxTotalAtoms);
    		pot.rhobar  = new Rail[MyTypes.real_t](maxTotalAtoms);
    		pot.forceExchange = he.initForceHaloExchange(s.domain, boxes);
    		pot.forceExchangeData = new ForceExchangeData();
    		pot.forceExchangeData.dfEmbed = pot.dfEmbed;
    		pot.forceExchangeData.boxes = boxes;
    	}
    	// OPT: loop invariant references
    	val potDfEmbed = pot.dfEmbed;
    	val potRhobar = pot.rhobar;
    
    	val rCut2:MyTypes.real_t = (pot.cutoff*pot.cutoff) as MyTypes.real_t;

    	// zero forces / energy / rho /rhoprime
    	var etot:MyTypes.real_t = MyTypes.real_t0;
        for (var iBox:Int=0n; iBox<nTotalBoxes*LinkCells.MAXATOMS; iBox++) {
			//OPT: Array index
			val iBox3=iBox*3;
        	atoms_f(iBox3) = MyTypes.real_t0;
        	atoms_f(iBox3+1) = MyTypes.real_t0;
        	atoms_f(iBox3+2) = MyTypes.real_t0;
        }
        atoms_U.clear();
        potDfEmbed.clear();
        potRhobar.clear();

    	for (var iBox:Int=0n; iBox<nLocalBoxes; iBox++)
    	{
    		var nIBox:Int = nAtoms(iBox);
			// OPT: MH-20131008
    		var nNbrBoxes:Int = lc.getNeighborBoxes(boxes, iBox, nbrBoxes);
    		// loop over neighbor boxes of iBox (some may be halo boxes)
    		for (var jTmp:Int=0n; jTmp<nNbrBoxes; jTmp++)
    		{
    			var jBox:Int = nbrBoxes(jTmp);
    			if (jBox < iBox ) continue;

    			var nJBox:Int = nAtoms(jBox);
    			// loop over atoms in iBox
    			var ii:Int = 0n;
    			for (var iOff:Int=LinkCells.MAXATOMS*iBox; ii<nIBox; ii++,iOff++)
    			{
					val iOff3 = iOff*3; //OPT: Loop invariant
    				// loop over atoms in jBox
    				var ij:Int = 0n;
    				for (var jOff:Int=LinkCells.MAXATOMS*jBox; ij<nJBox; ij++,jOff++)
    				{
    					if ( (iBox==jBox) &&(ij <= ii) ) continue;
						
						val jOff3 = jOff*3; //OPT: Loop invariant
    					var r2:Double = 0.0;
//OPT: Loop unrolling + array flattening
//   					for (var k:Int=0n; k<3; k++)
//    					{
//    						dr(k)=s.atoms.r(iOff3+k) - s.atoms.r(jOff3+k);
//    						r2+=dr(k)*dr(k);
//    					}
    					val dr0 =atoms_r(iOff3) - atoms_r(jOff3);
    					r2+=dr0*dr0;
    					val dr1 =atoms_r(iOff3+1) - atoms_r(jOff3+1);
    					r2+=dr1*dr1;
    					val dr2 =atoms_r(iOff3+2) - atoms_r(jOff3+2);
    					r2+=dr2*dr2;
//End of OPT: Loop unrolling + array flattening

    					if(r2>rCut2) continue;

    					val r:Double = Math.sqrt(r2);
    					interpolate(pot.phi, r, phiTmp, dPhi);
    					interpolate(pot.rho, r, rhoTmp, dRho);

//OPT: Loop unrolling + array flattening
//    					for (var k:Int=0n; k<3n; k++)
//    					{
//							val cal = (dPhi.value*dr(k)/r) as MyTypes.real_t;
//    						s.atoms.f(iOff3+k) -= cal;
//    						s.atoms.f(jOff3+k) += cal;
//    					}
						var cal:MyTypes.real_t = (dPhi.value*dr0/r) as MyTypes.real_t;
    					atoms_f(iOff3) -= cal;
    					atoms_f(jOff3) += cal;
						cal = (dPhi.value*dr1/r) as MyTypes.real_t;
    					atoms_f(iOff3+1) -= cal;
    					atoms_f(jOff3+1) += cal;
						cal = (dPhi.value*dr2/r) as MyTypes.real_t;
    					atoms_f(iOff3+2) -= cal;
    					atoms_f(jOff3+2) += cal;
//End of OPT: Loop unrolling + array flattening

    					// update energy terms
    					// calculate energy contribution based on whether
    					// the neighbor box is local or remote
						val phi = phiTmp.value; //OPT: CSE

    					if (jBox < nLocalBoxes)
    						etot += phi; //OPT: CSE
    					else
    						etot += 0.5*phi; //OPT: CSE

    					atoms_U(iOff) += 0.5*phi; //OPT: CSE
    					atoms_U(jOff) += 0.5*phi; //OPT: CSE
					
						val rho = rhoTmp.value; //OPT: CSE
    					// accumulate rhobar for each atom
    					potRhobar(iOff) += rho; //OPT: CSE
    					potRhobar(jOff) += rho; //OPT: CSE

    				} // loop over atoms in jBox
    			} // loop over atoms in iBox
    		} // loop over neighbor boxes
    	} // loop over local boxes

/*
		total += (System.nanoTime() - start)/1000000d;
		Console.ERR.println("Interpolate: " + total + " (ms)");
*/

    	// Compute Embedding Energy
    	// loop over all local boxes
    	for (var iBox:Int=0n; iBox<nLocalBoxes; iBox++)
    	{
    		var nIBox:Int =  nAtoms(iBox);

    		// loop over atoms in iBox
    		var ii:Int = 0n;
    		for (var iOff:Int=LinkCells.MAXATOMS*iBox; ii<nIBox; ii++,iOff++)
    		{
    			interpolate(pot.f, potRhobar(iOff), fEmbed, dfEmbed);
    			potDfEmbed(iOff) = dfEmbed.value; // save derivative for halo exchange
    			etot += fEmbed.value; 
    			atoms_U(iOff) += fEmbed.value;
    		}
    	}

    	// exchange derivative of the embedding energy with repsect to rhobar
    	per.startTimer(per.eamHaloTimer);
    	he.haloExchange(pot.forceExchange, pot.forceExchangeData);
    	per.stopTimer(per.eamHaloTimer);

    	// third pass
    	// loop over local boxes
    	for (var iBox:Int=0n; iBox<nLocalBoxes; iBox++)
    	{
    		val nIBox:Int =  nAtoms(iBox);
    		val nNbrBoxes:Int = lc.getNeighborBoxes(boxes, iBox, nbrBoxes);
    		// loop over neighbor boxes of iBox (some may be halo boxes)
    		for (var jTmp:Int=0n; jTmp<nNbrBoxes; jTmp++)
    		{
    			val jBox:Int = nbrBoxes(jTmp);
    			if(jBox < iBox) continue;

    			val nJBox:Int = nAtoms(jBox);
    			// loop over atoms in iBox
    			var ii:Int = 0n;
    			for (var iOff:Int=LinkCells.MAXATOMS*iBox; ii<nIBox; ii++,iOff++)
    			{
    				val iOff3 = iOff*3; //OPT: Array flattening
    				// loop over atoms in jBox
                    var ij:Int = 0n;
    				for (var jOff:Int=LinkCells.MAXATOMS*jBox; ij<nJBox; ij++,jOff++)
    				{ 
    					if ((iBox==jBox) && (ij <= ii))  continue;
    
    					val jOff3 = jOff*3; //OPT: Array flattening
    					var r2:Double = 0.0;
//OPT: Loop unrolling + array flattening
//    					for (var k:Int=0n; k<3; k++)
//    					{
//    						dr(k)=s.atoms.r(iOff*3+k)-s.atoms.r(jOff*3+k);
//    						r2+=dr(k)*dr(k);
//    					}
  						val dr0 = atoms_r(iOff3)-atoms_r(jOff3);
  						r2+=dr0*dr0;
  						val dr1 = atoms_r(iOff3+1)-atoms_r(jOff3+1);
  						r2+=dr1*dr1;
  						val dr2 = atoms_r(iOff3+2)-atoms_r(jOff3+2);
  						r2+=dr2*dr2;
//End of OPT: Loop unrolling + array flattening

    					if(r2>=rCut2) continue;

    					val r:MyTypes.real_t = Math.sqrt(r2);// as MyTypes.real_t;

    					interpolate(pot.rho, r, rhoTmp, dRho);

//OPT: Loop unrolling + array flattening
//    					for (var k:Int=0n; k<3; k++)
//    					{
////    						s.atoms.f(iOff*3+k) -= (s.pot.dfEmbed(iOff)+s.pot.dfEmbed(jOff))*dRho.value*dr(k)/r;
////    						s.atoms.f(jOff*3+k) += (s.pot.dfEmbed(iOff)+s.pot.dfEmbed(jOff))*dRho.value*dr(k)/r;
//							val cal = (s.pot.dfEmbed(iOff)+s.pot.dfEmbed(jOff))*dRho.value*dr(k)/r;
//    						s.atoms.f(iOff*3+k) -= cal;
//    						s.atoms.f(jOff*3+k) += cal;
//    					}
						var cal:MyTypes.real_t = (potDfEmbed(iOff)+potDfEmbed(jOff))*dRho.value*dr0/r;
  						atoms_f(iOff3) -= cal;
  						atoms_f(jOff3) += cal;
						cal = (potDfEmbed(iOff)+potDfEmbed(jOff))*dRho.value*dr1/r;
  						atoms_f(iOff3+1) -= cal;
  						atoms_f(jOff3+1) += cal;
						cal = (potDfEmbed(iOff)+potDfEmbed(jOff))*dRho.value*dr2/r;
  						atoms_f(iOff3+2) -= cal;
  						atoms_f(jOff3+2) += cal;
//End of OPT: Loop unrolling + array flattening

    				} // loop over atoms in jBox
    			} // loop over atoms in iBox
    		} // loop over neighbor boxes
    	} // loop over local boxes

    	s.ePotential = etot;

    	return 0n;
    }

    public def eamPrint(out:Printer, pot:CoMDTypes.BasePotential):Int
    {
    	out.printf("  Potential type  : EAM\n");
    	out.printf("  Species name    : %s\n", pot.name);
    	out.printf("  Atomic number   : %d\n", pot.atomicNo);
    	out.printf("  Mass            : "+MyTypes.FMT1+" amu\n", pot.mass/Constants.amuToInternalMass); // print in amu
    	out.printf("  Lattice type    : %s\n", pot.latticeType);
    	out.printf("  Lattice spacing : "+MyTypes.FMT1+" Angstroms\n", pot.lat);
    	out.printf("  Cutoff          : "+MyTypes.FMT1+" Angstroms\n", pot.cutoff);
    	return 0n;
    }

    /// Broadcasts an EamPotential from rank 0 to all other ranks.
    /// If the table coefficients are read from a file only rank 0 does the
    /// read.  Hence we need to broadcast the potential to all other ranks.
    static class Buffer {
    	var cutoff:MyTypes.real_t, mass:MyTypes.real_t, lat:MyTypes.real_t;
    	var latticeType:String;
    	var name:String;
    	var atomicNo:Int;
    }
    public def eamBcastPotential(pot:EamPotential, par:Parallel):void
    {
    	assert pot != null;
    
    	val buf = new Rail[Buffer](1);
    	if (par.getMyRank() == 0)
    	{
    		buf(0) = new Buffer();
    		buf(0).cutoff   = pot.cutoff;
    		buf(0).mass     = pot.mass;
    		buf(0).lat      = pot.lat;
    		buf(0).atomicNo = pot.atomicNo;
    		buf(0).latticeType = pot.latticeType;
    		buf(0).name = pot.name;
    	}
    	val rbuf = new Rail[Buffer](1);
    	par.bcastParallel[Buffer](buf, rbuf, 1, 0);
    	pot.cutoff   = rbuf(0).cutoff;
    	pot.mass     = rbuf(0).mass;
    	pot.lat      = rbuf(0).lat;
    	pot.atomicNo = rbuf(0).atomicNo;
    	pot.latticeType = rbuf(0).latticeType;
    	pot.name = rbuf(0).name;
    	bcastInterpolationObject(pot.phi);
    	bcastInterpolationObject(pot.rho);
    	bcastInterpolationObject(pot.f);
    }

    /// Builds a structure to store interpolation data for a tabular
    /// function.  Interpolation must be supported on the range
    /// \f$[x_0, x_n]\f$, where \f$x_n = n*dx\f$.
    ///
    /// \see interpolate
    /// \see bcastInterpolationObject
    /// \see destroyInterpolationObject
    ///
    /// \param [in] n    number of values in the table.
    /// \param [in] x0   minimum ordinate value of the table.
    /// \param [in] dx   spacing of the ordinate values.
    /// \param [in] data abscissa values.  An array of size n. 
    public def initInterpolationObject(n:Int, x0:MyTypes.real_t, dx:MyTypes.real_t, data:Rail[MyTypes.real_t]):InterpolationObject
    {
    	val table = new InterpolationObject();
    	assert table != null;

    	table.values = new Rail[MyTypes.real_t](n+3);
    	assert table.values != null;

    	table.n = n;
    	table.invDx = (1.0/dx);// as MyTypes.real_t;
    	table.x0 = x0;

    	for (var ii:Int=0n; ii<n; ++ii)
    		table.values(ii+1) = data(ii); // shift table.values
    
    		table.values(0) = table.values(1); // shift table.values
    		table.values(n+2) = table.values(n+1) = table.values(n); // shift table.values

    	return table;
    }

    /// Interpolate a table to determine f(r) and its derivative f'(r).
    ///
    /// The forces on the particle are much more sensitive to the derivative
    /// of the potential than on the potential itself.  It is therefore
    /// absolutely essential that the interpolated derivatives are smooth
    /// and continuous.  This function uses simple quadratic interpolation
    /// to find f(r).  Since quadric interpolants don't have smooth
    /// derivatives, f'(r) is computed using a 4 point finite difference
    /// stencil.
    ///
    /// Interpolation is used heavily by the EAM force routine so this
    /// function is a potential performance hot spot.  Feel free to
    /// reimplement this function (and initInterpolationObject if necessay)
    /// with any higher performing implementation of interpolation, as long
    /// as the alternate implmentation that has the required smoothness
    /// properties.  Cubic splines are one common alternate choice.
    ///
    /// \param [in] table Interpolation table.
    /// \param [in] r Point where function value is needed.
    /// \param [out] f The interpolated value of f(r).
    /// \param [out] df The interpolated value of df(r)/dr.
	// OPT: MH-20131008
    @Inline public static def interpolate(table:InterpolationObject, r:MyTypes.real_t, f:Cell[MyTypes.real_t], df:Cell[MyTypes.real_t]):void
    {
//		var total:Double = 0;
//		val start = System.nanoTime();

    	//const real_t* tt = table.values; // alias

		val tt:Rail[MyTypes.real_t] = table.values;	//OPT: CSE
    
    	var r1:MyTypes.real_t = r;
    	if ( r < table.x0 ) r1 = table.x0;

    	r1 = (r1-table.x0)*(table.invDx) ;
    	var ii:Long = Math.floor(r1) as Long;
    	if (ii > table.n)
    	{
    		ii = table.n;
    		r1 = table.n / table.invDx;
    	}
    	// reset r to fractional distance
    	r1 = (r1 - Math.floor(r1));

		//OPT: CSE (table.values with tt)
    	val g1 = tt(ii+2) - tt(ii); // shift table.values
    	val g2 = tt(ii+3) - tt(ii+1);   // shift table.values

    	f.value = (tt(ii+1) + 0.5*r1*(g1 + r1*(tt(ii+2) + tt(ii) - 2.0*tt(ii+1))));

    	df.value = (0.5*(g1 + r1*(g2-g1))*table.invDx); 

//		total += (System.nanoTime() - start)/1000000d;
//		Console.ERR.println("Interpolate: " + total + " (ms)");
    }

    /// Broadcasts an InterpolationObject from rank 0 to all other ranks.
    ///
    /// It is commonly the case that the data needed to create the
    /// interpolation table is available on only one task (for example, only
    /// one task has read the data from a file).  Broadcasting the table
    /// eliminates the need to put broadcast code in multiple table readers.
    ///
    /// \see eamBcastPotential
    static class InterpolationBuffer {
    	var n:Int;
    	var x0:MyTypes.real_t, invDx:MyTypes.real_t;
    }
    public def bcastInterpolationObject(table:InterpolationObject):void
    {
    	val buf = new Rail[InterpolationBuffer](1);

    	if (par.getMyRank() == 0)
    	{
            buf(0) = new InterpolationBuffer();
    		buf(0).n     = table.n;
    		buf(0).x0    = table.x0;
    		buf(0).invDx = table.invDx;
    	}
    	val rbuf = new Rail[InterpolationBuffer](1);
    	par.bcastParallel[InterpolationBuffer](buf, rbuf, 1, 0);

    	val buf2:Rail[MyTypes.real_t];
    	if (par.getMyRank() == 0)
    	{
        	buf2 = table.values;
    	}
    	else
    	{
            buf2 = null;
    	}
    	val valuesSize = table.n+3;
    	val rbuf2 = new Rail[MyTypes.real_t](table.n+3);
    	par.bcastParallel(buf2, rbuf2, valuesSize, 0);
    	
    	if (par.getMyRank() != 0)
    	{
    		assert table == null;
    		table.n      = rbuf(0).n;
    		table.x0     = rbuf(0).x0;
    		table.invDx  = rbuf(0).invDx;
    		table.values = rbuf2;
    	}
    }

    public def printTableData(table:InterpolationObject, fileName:String):void
    {
    	if (!par.printRank()) return;

    	val file = new x10.io.File(fileName);
    	val potData = new x10.io.Printer(file.openWrite(true));
    	val dR:MyTypes.real_t = (1.0/table.invDx) as MyTypes.real_t;
    	for (var i:Int = 0n; i<table.n; i++)
    	{
    		val r:MyTypes.real_t = table.x0+i*dR;
    		potData.printf("%d %e %e\n", i, r, table.values(i+1)); // shift table.values
    	}
    	potData.close();
    }
    
    /// Reads potential data from a setfl file and populates
    /// corresponding members and InterpolationObjects in an EamPotential.
    ///
    /// setfl is a file format for tabulated potential functions used by
    /// the original EAM code DYNAMO.  A setfl file contains EAM
    /// potentials for multiple elements.
    ///
    /// The contents of a setfl file are:
    ///
    /// | Line Num | Description
    /// | :------: | :----------
    /// | 1 - 3    | comments
    /// | 4        | ntypes type1 type2 ... typen
    /// | 5        | nrho     drho     nr   dr   rcutoff
    /// | F, rho   | Following line 5 there is a block for each atom type with F, and rho.
    /// | b1       | ielem(i)   amass(i)     latConst(i)    latType(i)
    /// | b2       | embedding function values F(rhobar) starting at rhobar=0
    /// |   ...    | (nrho values. Multiple values per line allowed.)
    /// | bn       | electron density, starting at r=0
    /// |   ...    | (nr values. Multiple values per line allowed.)
    /// | repeat   | Return to b1 for each atom type.
    /// | phi      | phi_ij for (1,1), (2,1), (2,2), (3,1), (3,2), (3,3), (4,1), ..., 
    /// | p1       | pair potential between type i and type j, starting at r=0
    /// |   ...    | (nr values. Multiple values per line allowed.)
    /// | repeat   | Return to p1 for each phi_ij
    ///
    /// Where:
    ///    -  ntypes        :      number of element types in the potential  
    ///    -  nrho          :      number of points the embedding energy F(rhobar)
    ///    -  drho          :      table spacing for rhobar 
    ///    -  nr            :      number of points for rho(r) and phi(r)
    ///    -  dr            :      table spacing for r in Angstroms
    ///    -  rcutoff       :      cut-off distance in Angstroms
    ///    -  ielem(i)      :      atomic number for element(i)
    ///    -  amass(i)      :      atomic mass for element(i) in AMU
    ///    -  latConst(i)   :      lattice constant for element(i) in Angstroms
    ///    -  latType(i)    :      lattice type for element(i)  
    ///
    /// setfl format stores r*phi(r), so we need to converted to the pair
    /// potential phi(r).  In the file, phi(r)*r is in eV*Angstroms.
    /// NB: phi is not defined for r = 0
    ///
    /// F(rhobar) is in eV.
    ///
    public def eamReadSetfl(pot:EamPotential, dir:String, potName:String):void
    {
    	var tmp:String = dir+"/"+potName;

    	val potFile = new x10.io.File(tmp);
    	if (potFile == null)
    		fileNotFound("eamReadSetfl", tmp);

    	val lineOfFile = potFile.lines();
   
    	// read the first 3 lines (comments)
    	tmp = lineOfFile.next();
    	tmp = lineOfFile.next();
    	tmp = lineOfFile.next();
    
    	// line 4
    	tmp = lineOfFile.next();
    	var words:Rail[String] = tmp.split(" *");
    	val nElems = Int.parseInt(words(0));
    	if( nElems != 1n )
    	notAlloyReady("eamReadSetfl");

    	//line 5
    	tmp = lineOfFile.next();
    	words = tmp.split(" *");
    	val nRho = Int.parseInt(words(0));
    	val dRho = Double.parseDouble(words(1));
    	val nR = Int.parseInt(words(2));
    	val dR = Double.parseDouble(words(3));
    	val cutoff = Double.parseDouble(words(4));
    	pot.cutoff = cutoff as MyTypes.real_t;

    	// **** THIS CODE IS RESTRICTED TO ONE ELEMENT
    	// Per-atom header 
    	tmp = lineOfFile.next();
    	words = tmp.split(" *");
    	val nAtomic = Int.parseInt(words(0));
    	val mass = Double.parseDouble(words(1));
    	val lat = Double.parseDouble(words(2));
    	val latticeType = words(3);
    	pot.atomicNo = nAtomic;
    	pot.lat = lat as MyTypes.real_t;
    	pot.mass = (mass * Constants.amuToInternalMass) as MyTypes.real_t;  // file has mass in AMU.
    	pot.latticeType = latticeType;
    
    	// allocate read buffer
    	val bufSize = Math.max(nRho, nR);
    	val buf = new Rail[MyTypes.real_t](bufSize);
    	var x0:MyTypes.real_t = MyTypes.real_t0;

    	// Read embedding energy F(rhobar)
        var word:String;
    	for (var ii:Int=0n; ii<nRho; ++ii)
    	{
    		tmp = lineOfFile.next();
    		word = tmp.trim();
    		buf(ii) = Double.parseDouble(word) as MyTypes.real_t;
    	}
    	pot.f = initInterpolationObject(nRho, x0, dRho as MyTypes.real_t, buf);

    	// Read electron density rho(r)
    	for (var ii:Int=0n; ii<nR; ++ii)
    	{
    		tmp = lineOfFile.next();
    		word = tmp.trim();
    		buf(ii) = Double.parseDouble(word) as MyTypes.real_t;
    	}
    	pot.rho = initInterpolationObject(nR, x0, dR as MyTypes.real_t, buf);

    	// Read phi(r)*r and convert to phi(r)
    	for (var ii:Int=0n; ii<nR; ++ii) {
    		tmp = lineOfFile.next();
    		word = tmp.trim();
    		buf(ii) = Double.parseDouble(word) as MyTypes.real_t;
    	}
    	for (var ii:Int=1n; ii<nR; ++ii)
    	{
    		var r:MyTypes.real_t = (x0 + ii*dR) as MyTypes.real_t;
    		buf(ii) /= r;
    	}
    	buf(0) = buf(1) + (buf(1) - buf(2)); // Linear interpolation to get phi[0].
    	pot.phi = initInterpolationObject(nR, x0, dR as MyTypes.real_t, buf);

    	// write to text file for comparison, currently commented out
    	/*    printPot(pot.f, "SetflDataF.txt"); */
    	/*    printPot(pot.rho, "SetflDataRho.txt"); */
    	/*    printPot(pot.phi, "SetflDataPhi.txt");  */
    }

    /// Reads potential data from a funcfl file and populates
    /// corresponding members and InterpolationObjects in an EamPotential.
    /// 
    /// funcfl is a file format for tabulated potential functions used by
    /// the original EAM code DYNAMO.  A funcfl file contains an EAM
    /// potential for a single element.
    /// 
    /// The contents of a funcfl file are:
    ///
    /// | Line Num | Description
    /// | :------: | :----------
    /// | 1        | comments
    /// | 2        | elem amass latConstant latType
    /// | 3        | nrho   drho   nr   dr    rcutoff
    /// | 4        | embedding function values F(rhobar) starting at rhobar=0
    /// |    ...   | (nrho values. Multiple values per line allowed.)
    /// | x'       | electrostatic interation Z(r) starting at r=0
    /// |    ...   | (nr values. Multiple values per line allowed.)
    /// | y'       | electron density values rho(r) starting at r=0
    /// |    ...   | (nr values. Multiple values per line allowed.)
    ///
    /// Where:
    ///    -  elem          :   atomic number for this element
    ///    -  amass         :   atomic mass for this element in AMU
    ///    -  latConstant   :   lattice constant for this elemnent in Angstroms
    ///    -  lattticeType  :   lattice type for this element (e.g. FCC) 
    ///    -  nrho          :   number of values for the embedding function, F(rhobar)
    ///    -  drho          :   table spacing for rhobar
    ///    -  nr            :   number of values for Z(r) and rho(r)
    ///    -  dr            :   table spacing for r in Angstroms
    ///    -  rcutoff       :   potential cut-off distance in Angstroms
    ///
    /// funcfl format stores the "electrostatic interation" Z(r).  This needs to
    /// be converted to the pair potential phi(r).
    /// using the formula 
    /// \f[phi = Z(r) * Z(r) / r\f]
    /// NB: phi is not defined for r = 0
    ///
    /// Z(r) is in atomic units (i.e., sqrt[Hartree * bohr]) so it is
    /// necesary to convert to eV.
    ///
    /// F(rhobar) is in eV.
    ///
    public def eamReadFuncfl(pot:EamPotential, dir:String, potName:String):void
    {
    	var tmp:String = dir+"/"+potName;

    	val potFile = new x10.io.File(tmp);
    	if (potFile == null) 
    		fileNotFound("eamReadSetfl", tmp);
    	val lineOfFile = potFile.lines();

    	// line 1
    	tmp = lineOfFile.next();
    	pot.name = tmp.substring(0n, 3n);

    	// line 2
    	tmp = lineOfFile.next();
        for (var j:Int = 0n; j < 4n; j++) {
            tmp = tmp.trim();
            val i = tmp.indexOf(" ");
            var word:String;
            if (i == -1n) {
                word = tmp;
            } else {
                word = tmp.substring(0n, i);
                tmp = tmp.substring(i);
            }
            switch (j) {
            	case 0n:
            		pot.atomicNo = Int.parseInt(word);
                    break;
            	case 1n:
            		pot.mass = (Double.parseDouble(word)*Constants.amuToInternalMass) as MyTypes.real_t;
           			break;
            	case 2n:
            		pot.lat = Double.parseDouble(word) as MyTypes.real_t;
           			break;
            	case 3n:
            		pot.latticeType = word;
           			break;
            	default:
            }
        }

    	// line 3
    	tmp = lineOfFile.next();
    	var nRho:Int = 0n, dRho:Double = 0.0, nR:Int = 0n, dR:Double = 0.0;
    	for (var j:Int = 0n; j < 5n; j++) {
    		tmp = tmp.trim();
    		val i = tmp.indexOf(" ");
    		var word:String;
    		if (i == -1n) {
    			word = tmp;
    		} else {
    			word = tmp.substring(0n, i);
    			tmp = tmp.substring(i);
    		}
    		switch (j) {
    			case 0n:
    				nRho = Int.parseInt(word);
    				break;
    			case 1n:
    				dRho = Double.parseDouble(word);
    				break;
    			case 2n:
    				nR = Int.parseInt(word);
    				break;
    			case 3n:
    				dR = Double.parseDouble(word);
    				break;
    			case 4n:
    				pot.cutoff = Double.parseDouble(word) as MyTypes.real_t;
    				break;
    			default:
    		}
   		}
    	val x0 = MyTypes.real_t0; // tables start at zero.

    	// allocate read buffer
    	val bufSize = Math.max(nRho, nR);
    	val buf = new Rail[MyTypes.real_t](bufSize);
    	var word:String;
    
    	// read embedding energy
    	tmp = lineOfFile.next();
    	for (var ii:Int=0n; ii<nRho; ++ii)
    	{
    		tmp = tmp.trim();
            val i = tmp.indexOf(' ');
            if (i == -1n) {
            	word = tmp;
            } else {
            	word = tmp.substring(0n, i);
            }
    		buf(ii) = Double.parseDouble(word) as MyTypes.real_t;
            if (i == -1n) {
            	tmp = lineOfFile.next();
            } else {
            	tmp = tmp.substring(i);
            }
    	}
    	pot.f = initInterpolationObject(nRho, x0, dRho as MyTypes.real_t, buf);

    	// read Z(r) and convert to phi(r)
    	for (var ii:Int=0n; ii<nRho; ++ii)
    	{
    		tmp = tmp.trim();
    		val i = tmp.indexOf(' ');
    		if (i == -1n) {
    			word = tmp;
    		} else {
    			word = tmp.substring(0n, i);
    		}
            buf(ii) = Double.parseDouble(word) as MyTypes.real_t;
    		if (i == -1n) {
    			tmp = lineOfFile.next();
    		} else {
    			tmp = tmp.substring(i);
    		}
    	}

    	for (var ii:Int=1n; ii<nR; ++ii)
    	{
    		var r:MyTypes.real_t = (x0 + ii*dR) as MyTypes.real_t;
    		buf(ii) *= buf(ii) / r;
    		buf(ii) *= (Constants.hartreeToEv * Constants.bohrToAngs) as MyTypes.real_t; // convert to eV
    	}
    	buf(0) = buf(1) + (buf(1) - buf(2)); // linear interpolation to get phi[0].
    	pot.phi = initInterpolationObject(nR, x0, dR as MyTypes.real_t, buf);

    	// read electron density rho
        for (var ii:Int=0n; ii<nRho; ++ii)
        {
        	tmp = tmp.trim();
        	val i = tmp.indexOf(' ');
        	if (i == -1n) {
        		word = tmp;
        	} else {
        		word = tmp.substring(0n, i);
        	}
            buf(ii) = Double.parseDouble(word) as MyTypes.real_t;
            if (i == -1n) {
                if (! lineOfFile.hasNext()) break;
            	tmp = lineOfFile.next();
            } else {
            	tmp = tmp.substring(i);
            }
        }

    	pot.rho = initInterpolationObject(nR, x0, dR as MyTypes.real_t, buf);

    	/*    printPot(pot.f,   "funcflDataF.txt"); */
    	/*    printPot(pot.rho, "funcflDataRho.txt"); */
    	/*    printPot(pot.phi, "funcflDataPhi.txt"); */
    }

    public def fileNotFound(callSite:String, filename:String):void
    {
    	Console.OUT.printf("%s: Can't open file %s.  Fatal Error.\n", callSite, filename);
        val fileNotFound = -1;
        assert fileNotFound == 0;
    }

    public def notAlloyReady(callSite:String):void
    {
    	Console.OUT.printf("%s: CoMD 1.1 does not support alloys and cannot\n"
    					  +"   read setfl files with multiple species.  Fatal Error.\n", callSite);
        val notAlloyReady = -1;
        assert notAlloyReady == 0;
    }

    public def typeNotSupported(callSite:String, valueType:String):void
    {
    	Console.OUT.printf("%s: Potential type %s not supported. Fatal Error.\n", callSite, valueType);
        val typeNotSupported = -1;
        assert typeNotSupported == 0;
    }
}
