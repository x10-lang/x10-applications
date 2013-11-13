/// \file
/// Communicate halo data such as "ghost" atoms with neighboring tasks.
/// In addition to ghost atoms, the EAM potential also needs to exchange
/// some force information.  Hence this file implements both an atom
/// exchange and a force exchange, each with slightly different
/// properties due to their different roles.
/// 
/// The halo exchange in CoMD 1.1 takes advantage of the Cartesian domain
/// decomposition as well as the link cell structure to quickly
/// determine what data needs to be sent.  
///
/// This halo exchange implementation is able to send data to all 26
/// neighboring tasks using only 6 messages.  This is accomplished by
/// sending data across the x-faces, then the y-faces, and finally
/// across the z-faces.  Some of the data that was received from the
/// x-faces is included in the y-face sends and so on.  This
/// accumulation of data allows data to reach edge neighbors and corner
/// neighbors by a two or three step process.
///
/// The advantage of this type of structured halo exchange is that it
/// minimizes the number of MPI messages to send, and maximizes the size
/// of those messages.
///
/// The disadvantage of this halo exchange is that it serializes message
/// traffic.  Only two messages can be in flight at once. The x-axis
/// messages must be received and processed before the y-axis messages
/// can begin.  Architectures with low message latency and many off node
/// network links would likely benefit from alternate halo exchange
/// strategies that send independent messages to each neighbor task.

package comd;
import x10.util.RailUtils;

public class HaloExchange {
    /// A polymorphic structure to store information about a halo exchange.
    /// This structure can be thought of as an abstract base class that
    /// specifies the interface and implements the communication patterns of
    /// a halo exchange.  Concrete sub-classes supply actual implementations
    /// of the loadBuffer, unloadBuffer, and destroy functions, that are
    /// specific to the actual data being exchanged.  If the subclass needs
    /// additional data members, these can be stored in a structure that is
    /// pointed to by parms.
    ///
    /// Designing the structure this way allows us to re-use the
    /// communication code for both atom data and partial force data.
    ///
    /// \see eamForce
    /// \see redistributeAtoms
    public static class HaloExchangeSt {
    	/// The MPI ranks of the six face neighbors of the local domain.
    	/// Ranks are stored in the order specified in HaloFaceOrder.
    	var nbrRank:Rail[Int];
    	/// //The maximum send/recv buffer size (in bytes) that will be needed
        /// The maximum send/recv buffer number that will be needed
    	/// for this halo exchange.
    	var bufCapacity:Int;
    	/// Pointer to a sub-class specific function to load the send buffer.
    	/// \param [in] parms The parms member of the structure.  This is a
    	///                   pointer to a sub-class specific structure that can
    	///                   be used by the load and unload functions to store
    	///                   sub-class specific data.
    	/// \param [in] data  A pointer to a structure that the contains the data
    	///                   that is needed by the loadBuffer function.  The
    	///                   loadBuffer function will cast the pointer to a
    	///                   concrete type that is appropriate for the data
    	///                   being exchanged.
    	/// \param [in] face  Specifies the face across which data is being sent.
    	/// \param [in] buf   The send buffer to be loaded
    	/// \return The number of bytes loaded into the send buffer.
        var loadBufferForAtoms:(AtomExchangeParms,CoMDTypes.SimFlat,Int,Rail[Int],Rail[MyTypes.real_t])=>Int;
        var loadBufferForForce:(ForceExchangeParms,Eam.ForceExchangeData,Int,Rail[MyTypes.real_t])=>Int;
    	/// Pointer to a sub-class specific function to unload the recv buffer.
    	/// \param [in] parms The parms member of the structure.  This is a
    	///                   pointer to a sub-class specific structure that can
    	///                   be used by the load and unload functions to store
    	///                   sub-class specific data.
    	/// \param [out] data A pointer to a structure that the contains the data
    	///                   that is needed by the unloadBuffer function.  The
    	///                   unloadBuffer function will cast the pointer to a
    	///                   concrete type that is appropriate for the data
    	///                   being exchanged.
    	/// \param [in] face  Specifies the face across which data is being sent.
    	/// \param [in] bufSize The number of bytes in the recv buffer.
    	/// \param [in] buf   The recv buffer to be unloaded.
        var unloadBufferForAtoms:(AtomExchangeParms,CoMDTypes.SimFlat,Int,Int,Rail[Int],Rail[MyTypes.real_t])=>Int;
        var unloadBufferForForce:(ForceExchangeParms,Eam.ForceExchangeData,Int,Int,Rail[MyTypes.real_t])=>Int;
    	/// Pointer to a function to deallocate any memory used by the
    	/// sub-class parms.  Essentially this is a virtual destructor.
        //var destroy:(ANY)=>void;
        /// A pointer to a sub-class specific structure that contains
    	/// additional data members needed by the sub-class.
        var parmsForAtom:AtomExchangeParms;
        var parmsForForce:ForceExchangeParms;
    }

    val per:PerformanceTimer;
    val par:Parallel;
    val dc:Decomposition;
    val lc:LinkCells;
    var sendBufMi0:Rail[Int];
    var sendBufMr0:Rail[MyTypes.real_t];
    var sendBufPi0:Rail[Int];
    var sendBufPr0:Rail[MyTypes.real_t];
    var recvBufMi0:Rail[Int];
    var recvBufMr0:Rail[MyTypes.real_t];
    var recvBufPi0:Rail[Int];
    var recvBufPr0:Rail[MyTypes.real_t];
    var sendBufM0:Rail[MyTypes.real_t];
    var sendBufP0:Rail[MyTypes.real_t];
    var recvBufM0:Rail[MyTypes.real_t];
    var recvBufP0:Rail[MyTypes.real_t];
    val tmp:Rail[AtomMsg];
//    static val tmp:Rail[AtomMsg] = new Rail[AtomMsg](LinkCells.MAXATOMS);
    val shift:MyTypes.real3;
    def this (par:Parallel, per:PerformanceTimer, dc:Decomposition, lc:LinkCells) {
        this.par = par;
    	this.per = per;
        this.dc = dc;
    	this.lc = lc;
        this.tmp = new Rail[AtomMsg](LinkCells.MAXATOMS);
        for (var i:Int = 0n; i < LinkCells.MAXATOMS; i++) {
            tmp(i) = new AtomMsg();
        }
        this.shift = new MyTypes.real3(3);
    }
    /// Don't change the order of the faces in this enum.
    val HALO_X_MINUS = 0n, HALO_X_PLUS = 1n,
    	HALO_Y_MINUS = 2n, HALO_Y_PLUS = 3n,
    	HALO_Z_MINUS = 4n, HALO_Z_PLUS = 5n;

    /// Don't change the order of the axes in this enum.
    val HALO_X_AXIS = 0n, HALO_Y_AXIS = 1n, HALO_Z_AXIS = 2n;

    /// Extra data members that are needed for the exchange of atom data.
    /// For an atom exchange, the HaloExchangeSt::parms will point to a
    /// structure of this type.
    public static class AtomExchangeParms {
    	var nCells:Rail[Int]				= new Rail[Int](6);        	//!< Number of cells in cellList for each face.
    	var cellList:Rail[Rail[Int]]		= new Rail[Rail[Int]](6);		//!< List of link cells from which to load data for each face.
    	var pbcFactor:Rail[Rail[MyTypes.real_t]]	= new Rail[Rail[MyTypes.real_t]](6);	//!< Whether this face is a periodic boundary.
    }

    /// Extra data members that are needed for the exchange of force data.
    /// For an force exchange, the HaloExchangeSt::parms will point to a
    /// structure of this type.
    public static class ForceExchangeParms {
    	var nCells:Rail[Int]				= new Rail[Int](6);     //!< Number of cells to send/recv for each face.
    	var sendCells:Rail[Rail[Int]]		= new Rail[Rail[Int]](6); //!< List of link cells to send for each face.
    	var recvCells:Rail[Rail[Int]]		= new Rail[Rail[Int]](6); //!< List of link cells to recv for each face.
    }

    /// A structure to package data for a single atom to pack into a
    /// send/recv buffer.  Also used for sorting atoms within link cells.
    public static class AtomMsg {
    	var gid:Int;
    	var valueType:Int;
    	var rx:MyTypes.real_t, ry:MyTypes.real_t, rz:MyTypes.real_t;
    	var px:MyTypes.real_t, py:MyTypes.real_t, pz:MyTypes.real_t;
    }

    /// Package data for the force exchange.
    public static class ForceMsg {
    	var dfEmbed:MyTypes.real_t;
    }

    /// \details
    /// When called in proper sequence by redistributeAtoms, the atom halo
    /// exchange helps serve three purposes:
    /// - Send ghost atom data to neighbor tasks.
    /// - Shift atom coordinates by the global simulation size when they cross
    ///   periodic boundaries.  This shift is performed in loadAtomsBuffer.
    /// - Transfer ownership of atoms between tasks as the atoms move across
    ///   spatial domain boundaries.  This transfer of ownership occurs in
    ///   two places.  The former owner gives up ownership when
    ///   updateLinkCells moves a formerly local atom into a halo link cell.
    ///   The new owner accepts ownership when unloadAtomsBuffer calls
    ///   putAtomInBox to place a received atom into a local link cell.
    ///
    /// This constructor does the following:
    ///
    /// - Sets the bufCapacity to hold the largest possible number of atoms
    ///   that can be sent across a face.
    /// - Initialize function pointers to the atom-specific versions
    /// - Sets the number of link cells to send across each face.
    /// - Builds the list of link cells to send across each face.  As
    ///   explained in the comments for mkAtomCellList, this list must
    ///   include any link cell, local or halo, that could possibly contain
    ///   an atom that needs to be sent across the face.  Atoms that need to
    ///   be sent include "ghost atoms" that are located in local link
    ///   cells that correspond to halo link cells on receiving tasks as well as
    ///   formerly local atoms that have just moved into halo link cells and
    ///   need to be sent to the rank that owns the spatial domain the atom
    ///   has moved into.
    /// - Sets a coordinate shift factor for each face to account for
    ///   periodic boundary conditions.  For most faces the factor is zero.
    ///   For faces on the +x, +y, or +z face of the simulation domain
    ///   the factor is -1.0 (to shift the coordinates by -1 times the
    ///   simulation domain size).  For -x, -y, and -z faces of the
    ///   simulation domain, the factor is +1.0.
    ///
    /// \see redistributeAtoms
    public def initAtomHaloExchange(domain:Decomposition.Domain, boxes:LinkCells.LinkCell):HaloExchangeSt
    {
    	val hh:HaloExchangeSt = initHaloExchange(domain);
    	val loadAtomsBufferFunc = (parms:AtomExchangeParms,s:CoMDTypes.SimFlat,face:Int,bufi:Rail[Int],bufr:Rail[MyTypes.real_t])=>loadAtomsBuffer(parms,s,face,bufi,bufr);
    	val unloadAtomsBufferFunc = (parms:AtomExchangeParms, s:CoMDTypes.SimFlat, face:Int, bufSize:Int, bufi:Rail[Int],bufr:Rail[MyTypes.real_t])=>unloadAtomsBuffer(parms,s,face,bufSize,bufi,bufr);
   		val size0 = (boxes.gridSize(1)+2)*(boxes.gridSize(2)+2);
    	val size1 = (boxes.gridSize(0)+2)*(boxes.gridSize(2)+2);
    	val size2 = (boxes.gridSize(0)+2)*(boxes.gridSize(1)+2);
    	var maxSize:Int = Math.max(size0, size1) as Int;
    	maxSize = Math.max(size1, size2) as Int;
    	hh.bufCapacity = (maxSize*2*LinkCells.MAXATOMS) as Int;
    	sendBufMi0 = new Rail[Int](hh.bufCapacity * 2);
    	sendBufMr0 = new Rail[MyTypes.real_t](hh.bufCapacity * 6);
    	sendBufPi0 = new Rail[Int](hh.bufCapacity * 2);
    	sendBufPr0 = new Rail[MyTypes.real_t](hh.bufCapacity * 6);
    	recvBufMi0 = new Rail[Int](hh.bufCapacity * 2);
    	recvBufMr0 = new Rail[MyTypes.real_t](hh.bufCapacity * 6);
    	recvBufPi0 = new Rail[Int](hh.bufCapacity * 2);
    	recvBufPr0 = new Rail[MyTypes.real_t](hh.bufCapacity * 6);
    
    	hh.loadBufferForAtoms = loadAtomsBufferFunc;
        hh.loadBufferForForce = null;
    	hh.unloadBufferForAtoms = unloadAtomsBufferFunc;
    	hh.unloadBufferForForce = null;
    	//hh.destroy = destroyAtomsExchange;

    	val parms:AtomExchangeParms = new AtomExchangeParms();

    	parms.nCells(HALO_X_MINUS) = (2*(boxes.gridSize(1)+2)*(boxes.gridSize(2)+2)) as Int;
    	parms.nCells(HALO_Y_MINUS) = (2*(boxes.gridSize(0)+2)*(boxes.gridSize(2)+2)) as Int;
    	parms.nCells(HALO_Z_MINUS) = (2*(boxes.gridSize(0)+2)*(boxes.gridSize(1)+2)) as Int;
    	parms.nCells(HALO_X_PLUS)  = parms.nCells(HALO_X_MINUS);
    	parms.nCells(HALO_Y_PLUS)  = parms.nCells(HALO_Y_MINUS);
    	parms.nCells(HALO_Z_PLUS)  = parms.nCells(HALO_Z_MINUS);

    	for (var ii:Int=0n; ii<6; ++ii)
    		parms.cellList(ii) = mkAtomCellList(boxes, ii, parms.nCells(ii));

    	for (var ii:Int=0n; ii<6; ++ii)
    	{
    		parms.pbcFactor(ii) = new Rail[MyTypes.real_t](3);
    		for (var jj:Int=0n; jj<3; ++jj)
    		parms.pbcFactor(ii)(jj) = MyTypes.real_t0;
    	}
    	if (domain.procCoord(HALO_X_AXIS) == 0)                       parms.pbcFactor(HALO_X_MINUS)(HALO_X_AXIS) = +1.0 as MyTypes.real_t;
    	if (domain.procCoord(HALO_X_AXIS) == domain.procGrid(HALO_X_AXIS)-1) parms.pbcFactor(HALO_X_PLUS)(HALO_X_AXIS)  = -1.0 as MyTypes.real_t;
    	if (domain.procCoord(HALO_Y_AXIS) == 0)                       parms.pbcFactor(HALO_Y_MINUS)(HALO_Y_AXIS) = +1.0 as MyTypes.real_t;
    	if (domain.procCoord(HALO_Y_AXIS) == domain.procGrid(HALO_Y_AXIS)-1) parms.pbcFactor(HALO_Y_PLUS)(HALO_Y_AXIS)  = -1.0 as MyTypes.real_t;
    	if (domain.procCoord(HALO_Z_AXIS) == 0)                       parms.pbcFactor(HALO_Z_MINUS)(HALO_Z_AXIS) = +1.0 as MyTypes.real_t;
    	if (domain.procCoord(HALO_Z_AXIS) == domain.procGrid(HALO_Z_AXIS)-1) parms.pbcFactor(HALO_Z_PLUS)(HALO_Z_AXIS)  = -1.0 as MyTypes.real_t;
    
    	hh.parmsForAtom = parms;
    	return hh;
    }

    /// The force exchange is considerably simpler than the atom exchange.
    /// In the force case we only need to exchange data that is needed to
    /// complete the force calculation.  Since the atoms have not moved we
    /// only need to send data from local link cells and we are guaranteed
    /// that the same atoms exist in the same order in corresponding halo
    /// cells on remote tasks.  The only tricky part is the size of the
    /// plane of local cells that needs to be sent grows in each direction.
    /// This is because the y-axis send must send some of the data that was
    /// received from the x-axis send, and the z-axis must send some data
    /// from the y-axis send.  This accumulation of data to send is
    /// responsible for data reaching neighbor cells that share only edges
    /// or corners.
    ///
    /// \see eam.c for an explanation of the requirement to exchange
    /// force data.
    public def initForceHaloExchange(domain:Decomposition.Domain, boxes:LinkCells.LinkCell):HaloExchangeSt
    {
    	val hh:HaloExchangeSt = initHaloExchange(domain);
    	val loadForceBufferFunc = (parms:ForceExchangeParms, data:Eam.ForceExchangeData, face:Int, buf:Rail[MyTypes.real_t])=>loadForceBuffer(parms,data,face,buf);
    	val unloadForceBufferFunc = (parms:ForceExchangeParms, data:Eam.ForceExchangeData, face:Int, bufSize:Int, buf:Rail[MyTypes.real_t])=>unloadForceBuffer(parms,data,face,bufSize,buf);
    	hh.loadBufferForAtoms = null;
    	hh.loadBufferForForce = loadForceBufferFunc;
    	hh.unloadBufferForAtoms = null;
    	hh.unloadBufferForForce = unloadForceBufferFunc;

    	val size0 = (boxes.gridSize(1))*(boxes.gridSize(2));
    	val size1 = ((boxes.gridSize(0)+2)*(boxes.gridSize(2))) as Int;
    	val size2 = ((boxes.gridSize(0)+2)*(boxes.gridSize(1)+2)) as Int;
    	var maxSize:Int = Math.max(size0, size1);
    	maxSize = Math.max(size1, size2);
    	hh.bufCapacity = (maxSize)*LinkCells.MAXATOMS;
    	sendBufM0 = new Rail[MyTypes.real_t](hh.bufCapacity);
    	sendBufP0 = new Rail[MyTypes.real_t](hh.bufCapacity);
    	recvBufM0 = new Rail[MyTypes.real_t](hh.bufCapacity);
    	recvBufP0 = new Rail[MyTypes.real_t](hh.bufCapacity);

    	val parms = new ForceExchangeParms();

    	parms.nCells(HALO_X_MINUS) = (boxes.gridSize(1)  )*(boxes.gridSize(2)  );
    	parms.nCells(HALO_Y_MINUS) = ((boxes.gridSize(0)+2)*(boxes.gridSize(2)  )) as Int;
    	parms.nCells(HALO_Z_MINUS) = ((boxes.gridSize(0)+2)*(boxes.gridSize(1)+2)) as Int;
    	parms.nCells(HALO_X_PLUS)  = parms.nCells(HALO_X_MINUS);
    	parms.nCells(HALO_Y_PLUS)  = parms.nCells(HALO_Y_MINUS);
    	parms.nCells(HALO_Z_PLUS)  = parms.nCells(HALO_Z_MINUS);

    	for (var ii:Int=0n; ii<6; ++ii)
    	{
    		parms.sendCells(ii) = mkForceSendCellList(boxes, ii, parms.nCells(ii));
    		parms.recvCells(ii) = mkForceRecvCellList(boxes, ii, parms.nCells(ii));
    	}
    
    	hh.parmsForForce = parms;
    	return hh;
    }

    public def haloExchange(haloExchange:HaloExchangeSt, data:CoMDTypes.SimFlat):void
    {
    	for (var iAxis:Int=0n; iAxis<3; ++iAxis)
    		exchangeData(haloExchange, data, iAxis);
    }
    public def haloExchange(haloExchange:HaloExchangeSt, data:Eam.ForceExchangeData):void
    {
    	for (var iAxis:Int=0n; iAxis<3; ++iAxis)
    		exchangeData(haloExchange, data, iAxis);
    }
    
    // Base class constructor.
    public def initHaloExchange(domain:Decomposition.Domain):HaloExchangeSt
    {
        val hh = new HaloExchangeSt();
        hh.nbrRank = new Rail[Int](6);

        // Rank of neighbor task for each face.
    	hh.nbrRank(HALO_X_MINUS) = dc.processorNum(domain, -1n,  0n,  0n);
    	hh.nbrRank(HALO_X_PLUS)  = dc.processorNum(domain, +1n,  0n,  0n);
    	hh.nbrRank(HALO_Y_MINUS) = dc.processorNum(domain,  0n, -1n,  0n);
    	hh.nbrRank(HALO_Y_PLUS)  = dc.processorNum(domain,  0n, +1n,  0n);
    	hh.nbrRank(HALO_Z_MINUS) = dc.processorNum(domain,  0n,  0n, -1n);
    	hh.nbrRank(HALO_Z_PLUS)  = dc.processorNum(domain,  0n,  0n, +1n);
    	hh.bufCapacity = 0n; // will be set by sub-class.

    	return hh;
    }

    /// This is the function that does the heavy lifting for the
    /// communication of halo data.  It is called once for each axis and
    /// sends and receives two message.  Loading and unloading of the
    /// buffers is in the hands of the sub-class virtual functions.
    ///
    /// \param [in] iAxis     Axis index.
    /// \param [in, out] data Pointer to data that will be passed to the load and
    ///                       unload functions

    public def exchangeData(haloExchange:HaloExchangeSt, data:CoMDTypes.SimFlat, iAxis:Int):void 
    {
    	val faceM:Int = 2n*iAxis;
    	val faceP:Int = faceM+1n;

    	val sendBufMi = sendBufMi0;
    	val sendBufMr = sendBufMr0;
    	val sendBufPi = sendBufPi0;
    	val sendBufPr = sendBufPr0;
    	val recvBufMi = recvBufMi0;
    	val recvBufMr = recvBufMr0;
    	val recvBufPi = recvBufPi0;
    	val recvBufPr = recvBufPr0;
        
        val nSendM = haloExchange.loadBufferForAtoms(haloExchange.parmsForAtom, data, faceM, sendBufMi, sendBufMr);
    	val nSendP = haloExchange.loadBufferForAtoms(haloExchange.parmsForAtom, data, faceP, sendBufPi, sendBufPr);

    	val nbrRankM = haloExchange.nbrRank(faceM);
    	val nbrRankP = haloExchange.nbrRank(faceP);

    	val nRecvMi:Int, nRecvMr:Int, nRecvPi:Int, nRecvPr:Int;
    	per.startTimer(per.commHaloTimer);
    	nRecvPi = par.sendReceiveParallel[Int](sendBufMi, nSendM*2n, nbrRankM, recvBufPi, haloExchange.bufCapacity*2n, nbrRankP);
    	nRecvPr = par.sendReceiveParallel[MyTypes.real_t](sendBufMr, nSendM*6n, nbrRankM, recvBufPr, haloExchange.bufCapacity*6n, nbrRankP);
    	nRecvMi = par.sendReceiveParallel[Int](sendBufPi, nSendP*2n, nbrRankP, recvBufMi, haloExchange.bufCapacity*2n, nbrRankM);
    	nRecvMr = par.sendReceiveParallel[MyTypes.real_t](sendBufPr, nSendP*6n, nbrRankP, recvBufMr, haloExchange.bufCapacity*6n, nbrRankM);
    	per.stopTimer(per.commHaloTimer);
        assert nRecvPi * 3n == nRecvPr;
        assert nRecvMi * 3n == nRecvMr;
    	haloExchange.unloadBufferForAtoms(haloExchange.parmsForAtom, data, faceM, nRecvMi/2n, recvBufMi, recvBufMr);
    	haloExchange.unloadBufferForAtoms(haloExchange.parmsForAtom, data, faceP, nRecvPi/2n, recvBufPi, recvBufPr);
    }

    public def exchangeData(haloExchange:HaloExchangeSt, data:Eam.ForceExchangeData, iAxis:Int):void 
    {
    	val faceM:Int = 2n*iAxis;
    	val faceP:Int = faceM+1n;

    	val sendBufM = sendBufM0;
    	val sendBufP = sendBufP0;
    	val recvBufM = recvBufM0;
    	val recvBufP = recvBufP0;

    	val nSendM = haloExchange.loadBufferForForce(haloExchange.parmsForForce, data, faceM, sendBufM);
    	val nSendP = haloExchange.loadBufferForForce(haloExchange.parmsForForce, data, faceP, sendBufP);

    	val nbrRankM = haloExchange.nbrRank(faceM);
    	val nbrRankP = haloExchange.nbrRank(faceP);

    	val nRecvM:Int, nRecvP:Int;
    	per.startTimer(per.commHaloTimer);
    	nRecvP = par.sendReceiveParallel[MyTypes.real_t](sendBufM, nSendM, nbrRankM, recvBufP, haloExchange.bufCapacity, nbrRankP);
    	nRecvM = par.sendReceiveParallel[MyTypes.real_t](sendBufP, nSendP, nbrRankP, recvBufM, haloExchange.bufCapacity, nbrRankM);
    	per.stopTimer(per.commHaloTimer);
    
    	haloExchange.unloadBufferForForce(haloExchange.parmsForForce, data, faceM, nRecvM, recvBufM);
    	haloExchange.unloadBufferForForce(haloExchange.parmsForForce, data, faceP, nRecvP, recvBufP);
    }

    /// Make a list of link cells that need to be sent across the specified
    /// face.  For each face, the list must include all cells, local and
    /// halo, in the first two planes of link cells.  Halo cells must be
    /// included in the list of link cells to send since local atoms may
    /// have moved from local cells into halo cells on this time step.
    /// (Actual remote atoms should have been deleted, so the halo cells
    /// should contain only these few atoms that have just crossed.)
    /// Sending these atoms will allow them to be reassigned to the task
    /// that covers the spatial domain they have moved into.
    ///
    /// Note that link cell grid coordinates range from -1 to gridSize[iAxis].
    /// \see initLinkCells for an explanation link cell grid coordinates.
    ///
    /// \param [in] boxes  Link cell information.
    /// \param [in] iFace  Index of the face data will be sent across.
    /// \param [in] nCells Number of cells to send.  This is used for a
    ///                    consistency check.
    /// \return The list of cells to send.  Caller is responsible to free
    /// the list.
    public def mkAtomCellList(boxes:LinkCells.LinkCell, iFace:Int, nCells:Int):Rail[Int]
    {
    	val list = new Rail[Int](nCells);
    	var xBegin:Int = -1n;
    	var xEnd:Int   = boxes.gridSize(0)+1n;
    	var yBegin:Int = -1n;
    	var yEnd:Int   = boxes.gridSize(1)+1n;
    	var zBegin:Int = -1n;
    	var zEnd:Int   = boxes.gridSize(2)+1n;

    	if (iFace == HALO_X_MINUS) xEnd = xBegin+2n;
    	if (iFace == HALO_X_PLUS)  xBegin = xEnd-2n;
    	if (iFace == HALO_Y_MINUS) yEnd = yBegin+2n;
    	if (iFace == HALO_Y_PLUS)  yBegin = yEnd-2n;
    	if (iFace == HALO_Z_MINUS) zEnd = zBegin+2n;
    	if (iFace == HALO_Z_PLUS)  zBegin = zEnd-2n;

    	var count:Int = 0n;
    	for (var ix:Int=xBegin; ix<xEnd; ++ix)
    		for (var iy:Int=yBegin; iy<yEnd; ++iy)
    			for (var iz:Int=zBegin; iz<zEnd; ++iz)
    				list(count++) = lc.getBoxFromTuple(boxes, ix, iy, iz);
    	assert count == nCells;
    	return list;
    }

    /// The loadBuffer function for a halo exchange of atom data.  Iterates
    /// link cells in the cellList and load any atoms into the send buffer.
    /// This function also shifts coordinates of the atoms by an appropriate
    /// factor if they are being sent across a periodic boundary.
    ///
    /// \see HaloExchangeSt::loadBuffer for an explanation of the loadBuffer
    /// parameters.
    
    public def loadAtomsBuffer(parms:AtomExchangeParms, s:CoMDTypes.SimFlat, face:Int, bufi:Rail[Int], bufr:Rail[MyTypes.real_t]):Int
    {
    	val pbcFactor = parms.pbcFactor(face);
    	shift(0) = pbcFactor(0) * s.domain.globalExtent(0);
    	shift(1) = pbcFactor(1) * s.domain.globalExtent(1);
    	shift(2) = pbcFactor(2) * s.domain.globalExtent(2);
    
    	val nCells:Int = parms.nCells(face);
    	val cellList:Rail[Int] = parms.cellList(face);
    	var nBuf:Int = 0n;
        var nBufi:Int;
        var nBufr:Int;
    	for (var iCell:Int=0n; iCell<nCells; ++iCell)
    	{
    		val iBox = cellList(iCell);
    		val iOff = iBox*LinkCells.MAXATOMS;
    		for (var ii:Int=iOff; ii<iOff+s.boxes.nAtoms(iBox); ++ii)
    		{
                nBufi = nBuf * 2n;
                nBufr = nBuf * 6n;
                bufi(nBufi++)	= s.atoms.gid(ii);
                bufi(nBufi)		= s.atoms.iSpecies(ii);
/*
                bufr(nBufr++)	= s.atoms.r(ii)(0) + shift(0);
                bufr(nBufr++)	= s.atoms.r(ii)(1) + shift(1);
                bufr(nBufr++)	= s.atoms.r(ii)(2) + shift(2);
*/
					val ii3 = ii * 3;
                bufr(nBufr++)	= s.atoms.r(ii3) + shift(0);
                bufr(nBufr++)	= s.atoms.r(ii3+1) + shift(1);
                bufr(nBufr++)	= s.atoms.r(ii3+2) + shift(2);
                bufr(nBufr++)	= s.atoms.p(ii3);
                bufr(nBufr++)	= s.atoms.p(ii3+1);
                bufr(nBufr)		= s.atoms.p(ii3+2);
    			++nBuf;
    		}
    	}
    	return nBuf;
    }

    /// The unloadBuffer function for a halo exchange of atom data.
    /// Iterates the receive buffer and places each atom that was received
    /// into the link cell that corresponds to the atom coordinate.  Note
    /// that this naturally accomplishes transfer of ownership of atoms that
    /// have moved from one spatial domain to another.  Atoms with
    /// coordinates in local link cells automatically become local
    /// particles.  Atoms that are owned by other ranks are automatically
    /// placed in halo kink cells.
    /// \see HaloExchangeSt::unloadBuffer for an explanation of the
    /// unloadBuffer parameters.
    
    public def unloadAtomsBuffer(parms:AtomExchangeParms, s:CoMDTypes.SimFlat, face:Int, bufSize:Int, bufi:Rail[Int], bufr:Rail[MyTypes.real_t]):Int
    {
    	val nBuf:Int = bufSize;
        var iii:Int;
        var iir:Int;
    	for (var ii:Int=0n; ii<nBuf; ++ii)
    	{
            iii = ii*2n;
            iir = ii*6n;
    		val gid:Int   = bufi(iii++);
    		val valueType:Int  = bufi(iii);
    		val rx:MyTypes.real_t = bufr(iir++);
    		val ry:MyTypes.real_t = bufr(iir++);
    		val rz:MyTypes.real_t = bufr(iir++);
    		val px:MyTypes.real_t = bufr(iir++);
    		val py:MyTypes.real_t = bufr(iir++);
    		val pz:MyTypes.real_t = bufr(iir++);
    		lc.putAtomInBox(s.boxes, s.atoms, gid, valueType, rx, ry, rz, px, py, pz);
//    		LinkCells.putAtomInBox(s.boxes, s.atoms, gid, valueType, rx, ry, rz, px, py, pz);
    	}
    	return nBuf;
    }

    /*void destroyAtomsExchange(void* vparms)
    {
    AtomExchangeParms* parms = (AtomExchangeParms*) vparms;

    for (int ii=0; ii<6; ++ii)
    {
    free(parms.pbcFactor(ii));
    free(parms.cellList(ii));
    }
    }*/

    /// Make a list of link cells that need to send data across the
    /// specified face.  Note that this list must be compatible with the
    /// corresponding recv list to ensure that the data goes to the correct
    /// atoms.
    ///
    /// \see initLinkCells for information about the conventions for grid
    /// coordinates of link cells.
    public def mkForceSendCellList(boxes:LinkCells.LinkCell, face:Int, nCells:Int):Rail[Int]
    {
    	val list = new Rail[Int](nCells);
    	var xBegin:Int = 0n, xEnd:Int = 0n, yBegin:Int = 0n, yEnd:Int = 0n, zBegin:Int = 0n, zEnd:Int = 0n;

    	val nx = boxes.gridSize(0);
    	val ny = boxes.gridSize(1);
    	val nz = boxes.gridSize(2);
    	switch(face)
    	{
    	case HALO_X_MINUS:
    		xBegin=0n;    xEnd=1n;    yBegin=0n;    yEnd=ny;   zBegin=0n;    zEnd=nz;
    		break;
    	case HALO_X_PLUS:
    		xBegin=nx-1n; xEnd=nx;   yBegin=0n;    yEnd=ny;   zBegin=0n;    zEnd=nz;
    		break;
    	case HALO_Y_MINUS:
    		xBegin=-1n;   xEnd=nx+1n; yBegin=0n;    yEnd=1n;    zBegin=0n;    zEnd=nz;
    		break;
    	case HALO_Y_PLUS:
    		xBegin=-1n;   xEnd=nx+1n; yBegin=ny-1n; yEnd=ny;   zBegin=0n;    zEnd=nz;
    		break;
    	case HALO_Z_MINUS:
    		xBegin=-1n;   xEnd=nx+1n; yBegin=-1n;   yEnd=ny+1n; zBegin=0n;    zEnd=1n;
    		break;
    	case HALO_Z_PLUS:
    		xBegin=-1n;   xEnd=nx+1n; yBegin=-1n;   yEnd=ny+1n; zBegin=nz-1n; zEnd=nz;
    		break;
    	default:
    		assert 1==0;
    	}
    
    	var count:Int = 0n;
    	for (var ix:Int=xBegin; ix<xEnd; ++ix)
    		for (var iy:Int=yBegin; iy<yEnd; ++iy)
    			for (var iz:Int=zBegin; iz<zEnd; ++iz)
    				list(count++) = lc.getBoxFromTuple(boxes, ix, iy, iz);
    
    	assert count == nCells;
    	return list;
    }

    /// Make a list of link cells that need to receive data across the
    /// specified face.  Note that this list must be compatible with the
    /// corresponding send list to ensure that the data goes to the correct
    /// atoms.
    ///
    /// \see initLinkCells for information about the conventions for grid
    /// coordinates of link cells.
    public def mkForceRecvCellList(boxes:LinkCells.LinkCell, face:Int, nCells:Int):Rail[Int]
    {
    	val list = new Rail[Int](nCells);
    	var xBegin:Int = 0n, xEnd:Int = 0n, yBegin:Int = 0n, yEnd:Int = 0n, zBegin:Int = 0n, zEnd:Int = 0n;

    	val nx = boxes.gridSize(0);
    	val ny = boxes.gridSize(1);
    	val nz = boxes.gridSize(2);
    	switch(face)
    	{
    	case HALO_X_MINUS:
    		xBegin=-1n; xEnd=0n;    yBegin=0n;  yEnd=ny;   zBegin=0n;  zEnd=nz;
    		break;
    	case HALO_X_PLUS:
    		xBegin=nx; xEnd=nx+1n; yBegin=0n;  yEnd=ny;   zBegin=0n;  zEnd=nz;
    		break;
    	case HALO_Y_MINUS:
    		xBegin=-1n; xEnd=nx+1n; yBegin=-1n; yEnd=0n;    zBegin=0n;  zEnd=nz;
    		break;
    	case HALO_Y_PLUS:
    		xBegin=-1n; xEnd=nx+1n; yBegin=ny; yEnd=ny+1n; zBegin=0n;  zEnd=nz;
    		break;
    	case HALO_Z_MINUS:
    		xBegin=-1n; xEnd=nx+1n; yBegin=-1n; yEnd=ny+1n; zBegin=-1n; zEnd=0n;
    		break;
    	case HALO_Z_PLUS:
    		xBegin=-1n; xEnd=nx+1n; yBegin=-1n; yEnd=ny+1n; zBegin=nz; zEnd=nz+1n;
    		break;
    	default:
    		assert 1==0;
    	}
    
    	var count:Int = 0n;
    	for (var ix:Int=xBegin; ix<xEnd; ++ix)
    		for (var iy:Int=yBegin; iy<yEnd; ++iy)
    			for (var iz:Int=zBegin; iz<zEnd; ++iz)
    				list(count++) = lc.getBoxFromTuple(boxes, ix, iy, iz);
    
    	assert(count == nCells);
    	return list;
    }

    /// The loadBuffer function for a force exchange.
    /// Iterate the send list and load the derivative of the embedding
    /// energy with respect to the local density into the send buffer.
    ///
    /// \see HaloExchangeSt::loadBuffer for an explanation of the loadBuffer
    /// parameters.
    
    // remove ANY
    public def loadForceBuffer(parms:ForceExchangeParms, data:Eam.ForceExchangeData, face:Int, buf:Rail[MyTypes.real_t]):Int
    {
    	val nCells = parms.nCells(face);
    	val cellList = parms.sendCells(face);
    	var nBuf:Int = 0n;
    	for (var iCell:Int=0n; iCell<nCells; ++iCell)
    	{
    		val iBox = cellList(iCell);
    		val iOff = iBox*LinkCells.MAXATOMS;
    		for (var ii:Int=iOff; ii<iOff+data.boxes.nAtoms(iBox); ++ii)
    		{
    			buf(nBuf) = data.dfEmbed(ii);
    			++nBuf;
    		}
    	}
        return nBuf;
    }

    /// The unloadBuffer function for a force exchange.
    /// Data is received in an order that naturally aligns with the atom
    /// storage so it is simple to put the data where it belongs.
    ///
    /// \see HaloExchangeSt::unloadBuffer for an explanation of the
    /// unloadBuffer parameters.
    
    public def unloadForceBuffer(parms:ForceExchangeParms, data:Eam.ForceExchangeData, face:Int, bufSize:Int, buf:Rail[MyTypes.real_t]):Int
    {
    	val nCells = parms.nCells(face);
    	val cellList = parms.recvCells(face);
    	var iBuf:Int = 0n;
    	for (var iCell:Int=0n; iCell<nCells; ++iCell)
    	{
    		val iBox = cellList(iCell);
    		val iOff = iBox*LinkCells.MAXATOMS;
    		for (var ii:Int=iOff; ii<iOff+data.boxes.nAtoms(iBox); ++ii)
    		{
    			data.dfEmbed(ii) = buf(iBuf);
    			++iBuf;
    		}
    	}
    	return iBuf;
    }

    /// \details
    /// The force exchange assumes that the atoms are in the same order in
    /// both a given local link cell and the corresponding remote cell(s).
    /// However, the atom exchange does not guarantee this property,
    /// especially when atoms cross a domain decomposition boundary and move
    /// from one task to another.  Trying to maintain the atom order during
    /// the atom exchange would immensely complicate that code.  Instead, we
    /// just sort the atoms after the atom exchange.
    public def sortAtomsInCell(atoms:InitAtoms.Atoms, boxes:LinkCells.LinkCell, iBox:Int):void
    {
    	val nAtoms = boxes.nAtoms(iBox);
    	val begin = iBox*LinkCells.MAXATOMS;
    	val end = begin + nAtoms;
    	var iTmp:Int = 0n;
    	for (var ii:Int=begin; ii<end; ++ii, ++iTmp)
    	{
    		tmp(iTmp).gid  = atoms.gid(ii);
    		tmp(iTmp).valueType = atoms.iSpecies(ii);
/*
    		tmp(iTmp).rx =   atoms.r(ii)(0);
    		tmp(iTmp).ry =   atoms.r(ii)(1);
    		tmp(iTmp).rz =   atoms.r(ii)(2);
*/
			val ii3 = ii * 3;
    		tmp(iTmp).rx =   atoms.r(ii3);
    		tmp(iTmp).ry =   atoms.r(ii3+1);
    		tmp(iTmp).rz =   atoms.r(ii3+2);
    		tmp(iTmp).px =   atoms.p(ii3);
    		tmp(iTmp).py =   atoms.p(ii3+1);
    		tmp(iTmp).pz =   atoms.p(ii3+2);
    	}
        qsort(tmp, 0l, nAtoms - 1);
    	iTmp = 0n;
    	for (var ii:Int=begin; ii<end; ++ii, ++iTmp)
    	{
    		atoms.gid(ii)   = tmp(iTmp).gid;
    		atoms.iSpecies(ii) = tmp(iTmp).valueType;
/*
    		atoms.r(ii)(0)  = tmp(iTmp).rx;
    		atoms.r(ii)(1)  = tmp(iTmp).ry;
    		atoms.r(ii)(2)  = tmp(iTmp).rz;
*/
			val ii3 = ii * 3;
    		atoms.r(ii3)  = tmp(iTmp).rx;
    		atoms.r(ii3+1)  = tmp(iTmp).ry;
    		atoms.r(ii3+2)  = tmp(iTmp).rz;
    		atoms.p(ii3)  = tmp(iTmp).px;
    		atoms.p(ii3+1)  = tmp(iTmp).py;
    		atoms.p(ii3+2)  = tmp(iTmp).pz;
    	}
    }

    ///  A function suitable for passing to qsort to sort atoms by gid.
    ///  Because every atom in the simulation is supposed to have a unique
    ///  id, this function checks that the atoms have different gids.  If
    ///  that assertion ever fails it is a sign that something has gone
    ///  wrong elsewhere in the code.
    private static def sortAtomsById(a:AtomMsg, b:AtomMsg):Int
    {
    	val aId = a.gid;
    	val bId = b.gid;
    	//assert aId != bId;

    	if (aId < bId) return -1n;
    	else if (aId > bId) return 1n;
    	return 0n;
    }
    
    private static def qsort(a:Rail[AtomMsg], lo:Long, hi:Long):void {
    	if (hi <= lo) 
    	return;

    	var l:Long = lo - 1;
    	var h:Long = hi;
    	var temp:AtomMsg;

    	while (true) {
    		while (sortAtomsById(a(++l), a(hi))<0);
    		while (sortAtomsById(a(hi), a(--h))<0 && h>lo);

    		if (l >= h) 
    			break;

    		temp = a(l);
    		a(l) = a(h);
    		a(h) = temp;
    	}
    	temp = a(l);
    	a(l) = a(hi);
    	a(hi) = temp;

    	qsort(a, lo, h-1n);
    	qsort(a, l+1n, hi);
    }
}
