/// \file
/// Parallel domain decomposition.  This version of CoMD uses a simple
/// spatial Cartesian domain decomposition.  The simulation box is
/// divided into equal size bricks by a grid that is xproc by yproc by
/// zproc in size.

package comd;

public class Decomposition {
    /// Domain decomposition information.
    public static class Domain {
    	// process-layout data
    	var procGrid:Rail[Long] = new Rail[Long](3);        		//!< number of processors in each dimension
    	var procCoord:Rail[Long] = new Rail[Long](3);       		//!< i,j,k for this processor

    	// global bounds data
    	var globalMin:MyTypes.real3 = new MyTypes.real3(3);     //!< minimum global coordinate (angstroms)
    	var globalMax:MyTypes.real3 = new MyTypes.real3(3);		//!< maximum global coordinate (angstroms)
    	var globalExtent:MyTypes.real3 = new MyTypes.real3(3);  //!< global size: globalMax - globalMin

    	// local bounds data
    	var localMin:MyTypes.real3 = new MyTypes.real3(3);      //!< minimum coordinate on local processor
    	var localMax:MyTypes.real3 = new MyTypes.real3(3);      //!< maximum coordinate on local processor
    	var localExtent:MyTypes.real3 = new MyTypes.real3(3);   //!< localMax - localMin
    }

    val par:Parallel;
    def this(par:Parallel) {
    	this.par = par;
    }
    /// \param [in] xproc x-size of domain decomposition grid.
    /// \param [in] yproc y-size of domain decomposition grid.
    /// \param [in] zproc z-size of domain decomposition grid.
    /// \param [in] globalExtent Size of the simulation domain (in Angstroms).
    public def initDecomposition(xproc:int, yproc:int, zproc:int, globalExtent:MyTypes.real3):Domain {
    	assert (xproc * yproc * zproc as Long) == par.getNRanks();

    	val dd = new Domain();
    	dd.procGrid(0) = xproc;
        dd.procGrid(1) = yproc;
        dd.procGrid(2) = zproc;
        // calculate grid coordinates i,j,k for this processor
    	var myRank:Long = par.getMyRank();
    	dd.procCoord(0) = myRank % dd.procGrid(0);
    	myRank /= dd.procGrid(0);
    	dd.procCoord(1) = myRank % dd.procGrid(1);
    	dd.procCoord(2) = myRank / dd.procGrid(1);

    	// initialialize global bounds
    	for (var i:Long = 0; i < 3; i++) {
    		dd.globalMin(i) = 0;
    		dd.globalMax(i) = globalExtent(i);
    		dd.globalExtent(i) = dd.globalMax(i) - dd.globalMin(i);
    	}
    
    	// initialize local bounds on this processor
    	for (var i:Long = 0; i < 3; i++) {
    		dd.localExtent(i) = dd.globalExtent(i) / dd.procGrid(i);
    		dd.localMin(i) = dd.globalMin(i) +  dd.procCoord(i)    * dd.localExtent(i);
    		dd.localMax(i) = dd.globalMin(i) + (dd.procCoord(i)+1) * dd.localExtent(i);
    	}

    	return dd;
    }

    /// \details
    /// Calculates the rank of the processor with grid coordinates
    /// (ix+dix, iy+diy, iz+diz) where (ix, iy, iz) are the grid coordinates
    /// of the local rank.  Assumes periodic boundary conditions.  The
    /// deltas cannot be smaller than -procGrid[ii].
    public def processorNum(domain:Domain, dix:Int, diy:Int, diz:Int):int {
    	val procCoord = domain.procCoord; // alias
    	val procGrid  = domain.procGrid;  // alias
    	val ix = (procCoord(0) + dix + procGrid(0)) % procGrid(0);
    	val iy = (procCoord(1) + diy + procGrid(1)) % procGrid(1);
    	val iz = (procCoord(2) + diz + procGrid(2)) % procGrid(2);

    	return (ix + procGrid(0) *(iy + procGrid(1)*iz)) as Int;
    }
}