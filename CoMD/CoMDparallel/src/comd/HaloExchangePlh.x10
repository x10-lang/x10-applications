package comd;

public class HaloExchangePlh {
    var sendBufMir0:PlaceLocalHandle[Rail[MyTypes.real_t]]; // Buffer to pack sendBufMi0 and sendBufMr0
    var sendBufPir0:PlaceLocalHandle[Rail[MyTypes.real_t]]; // Buffer to pack sendBufPi0 and sendBufPr0
    var recvBufMir0:PlaceLocalHandle[Rail[MyTypes.real_t]]; // Buffer to pack recvBufMi0 and recvBufMr0
    var recvBufPir0:PlaceLocalHandle[Rail[MyTypes.real_t]]; // Buffer to pack recvBufMi0 and recvBufPr0
/*
    var sendBufMi0:PlaceLocalHandle[Rail[Int]];
    var sendBufMr0:PlaceLocalHandle[Rail[MyTypes.real_t]];
    var sendBufPi0:PlaceLocalHandle[Rail[Int]];
    var sendBufPr0:PlaceLocalHandle[Rail[MyTypes.real_t]];
    var recvBufMi0:PlaceLocalHandle[Rail[Int]];
    var recvBufMr0:PlaceLocalHandle[Rail[MyTypes.real_t]];
    var recvBufPi0:PlaceLocalHandle[Rail[Int]];
    var recvBufPr0:PlaceLocalHandle[Rail[MyTypes.real_t]];
*/
    var sendBufM0:PlaceLocalHandle[Rail[MyTypes.real_t]];
    var sendBufP0:PlaceLocalHandle[Rail[MyTypes.real_t]];
    var recvBufM0:PlaceLocalHandle[Rail[MyTypes.real_t]];
    var recvBufP0:PlaceLocalHandle[Rail[MyTypes.real_t]];
    
/*
    var nRecvMi:PlaceLocalHandle[Rail[Int]];
    var nRecvMr:PlaceLocalHandle[Rail[Int]];
    var nRecvPi:PlaceLocalHandle[Rail[Int]];
    var nRecvPr:PlaceLocalHandle[Rail[Int]];
*/
	var nRecvMir:PlaceLocalHandle[Rail[Int]];
	var nRecvPir:PlaceLocalHandle[Rail[Int]];
	
    var nRecvM:PlaceLocalHandle[Rail[Int]];
    var nRecvP:PlaceLocalHandle[Rail[Int]];
    
/*
    var nSendMi:PlaceLocalHandle[Rail[Int]];
    var nSendMr:PlaceLocalHandle[Rail[Int]];
    var nSendPi:PlaceLocalHandle[Rail[Int]];
    var nSendPr:PlaceLocalHandle[Rail[Int]];
*/
    var nSendMir:PlaceLocalHandle[Rail[Int]];
    var nSendPir:PlaceLocalHandle[Rail[Int]];

    var nSendM:PlaceLocalHandle[Rail[Int]];
    var nSendP:PlaceLocalHandle[Rail[Int]];

    public def initHaloExchangePlh (args:Rail[String]): Int {
    	val par = new Parallel();
    	val per = new PerformanceTimer(par);
    	val dc = new Decomposition(par);
    	val lc = new LinkCells(par, per);
    	val he = new HaloExchange(par, per, dc, lc, this);
    
    	val mycmd = new MyCommand(par);
    	val cmd = mycmd.parseCommandLine(args);
    	if (cmd != null) { // return 2n;
    		val pot = initPotentialSerial(cmd.doeam.i, cmd.potDir.s, cmd.potName.s, cmd.potType.s, par, per, he, lc);
        	var latticeConstant:MyTypes.real_t = cmd.lat.d as MyTypes.real_t;
        	if (cmd.lat.d < MyTypes.real_t0)
        	latticeConstant = pot.lat;
        	var globalExtent:MyTypes.real3 = new MyTypes.real3(3);
        	globalExtent(0) = cmd.nx.i * latticeConstant;
        	globalExtent(1) = cmd.ny.i * latticeConstant;
        	globalExtent(2) = cmd.nz.i * latticeConstant;
        	val domain = dc.initDecomposition(
        	cmd.xproc.i, cmd.yproc.i, cmd.zproc.i, globalExtent);
        	val boxes = lc.initLinkCells(domain, pot.cutoff);

        	var size0:Long = (boxes.gridSize(1)+2)*(boxes.gridSize(2)+2);
        	var size1:Long = (boxes.gridSize(0)+2)*(boxes.gridSize(2)+2);
        	var size2:Long = (boxes.gridSize(0)+2)*(boxes.gridSize(1)+2);
        	var maxSize:Int = Math.max(size0, size1) as Int;
        	maxSize = Math.max(size1, size2) as Int;
        	val bufAtomCapacity = (maxSize*2*LinkCells.MAXATOMS) as Int;
/*
        	sendBufMi0 = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](bufAtomCapacity * 2));
        	sendBufMr0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufAtomCapacity * 6));
        	sendBufPi0 = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](bufAtomCapacity * 2));
        	sendBufPr0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufAtomCapacity * 6));
        	recvBufMi0 = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](bufAtomCapacity * 2));
        	recvBufMr0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufAtomCapacity * 6));
        	recvBufPi0 = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](bufAtomCapacity * 2));
        	recvBufPr0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufAtomCapacity * 6));
*/
        	sendBufMir0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufAtomCapacity * 8));
        	sendBufPir0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufAtomCapacity * 8));
        	recvBufMir0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufAtomCapacity * 8));
        	recvBufPir0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufAtomCapacity * 8));
        
        	size0 = (boxes.gridSize(1))*(boxes.gridSize(2));
        	size1 = ((boxes.gridSize(0)+2)*(boxes.gridSize(2))) as Int;
        	size2 = ((boxes.gridSize(0)+2)*(boxes.gridSize(1)+2)) as Int;
        	maxSize = Math.max(size0, size1) as Int;
        	maxSize = Math.max(size1, size2) as Int;
        	val bufForceCapacity = (maxSize)*LinkCells.MAXATOMS;
        	sendBufM0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufForceCapacity));
        	sendBufP0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufForceCapacity));
        	recvBufM0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufForceCapacity));
        	recvBufP0 = PlaceLocalHandle.make[Rail[MyTypes.real_t]](Place.places(), ()=>new Rail[MyTypes.real_t](bufForceCapacity));
        
/*
           nRecvMi = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nRecvMr = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nRecvPi = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nRecvPr = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
*/
           nRecvMir = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nRecvPir = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nRecvM = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nRecvP = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));

/*
           nSendMi = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nSendMr = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nSendPi = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nSendPr = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
*/
           nSendMir = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nSendPir = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));

           nSendM = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));
           nSendP = PlaceLocalHandle.make[Rail[Int]](Place.places(), ()=>new Rail[Int](1n));

           return 0n;
    	}
      	return 2n;
    }

    /// copy from CoMD
    /// decide whether to get LJ or EAM potentials
    public static def initPotentialSerial(doeam:Int, potDir:String, potName:String, potType:String, par:Parallel, per:PerformanceTimer, he:HaloExchange, lc:LinkCells):CoMDTypes.BasePotential
    {
    	val pot:CoMDTypes.BasePotential;
    
    	if (doeam != 0n) {
    		val e = new Eam(par, per, he, lc);
    		pot = e.initEamPotSerial(potDir, potName, potType);
    	}
    	else {
    		val ljf = new LjForce(lc);
    		pot = ljf.initLjPot();
    	}
    	assert pot != null;
    	return pot;
    }
}