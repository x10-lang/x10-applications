
import CUDAHalfWilsonVectorField;
import LatticeComm;

class CUDALatticeComm extends LatticeComm {
	val dbufSend = new Rail[CUDAHalfWilsonVectorField](8);
	val dbufRecv = new Rail[CUDAHalfWilsonVectorField](8);
	// val bufSend = new Rail[HalfWilsonVectorField](8);
	// val bufRecv = new Rail[HalfWilsonVectorField](8);
	// val recvCount : PlaceLocalHandle[Rail[Long]];
	// val recvCountPrev : PlaceLocalHandle[Rail[Long]];
	// val recvFlag : PlaceLocalHandle[Rail[Long]];
	// val refBuffers : PlaceLocalHandle[Rail[GlobalRail[Double]]];
	// var refInitDone : Long;

	def this(x : Long,y : Long,z : Long,t : Long, px : Long, py : Long, pz : Long, pt : Long,nid : Long)
	{
		super(x,y,z,t,px,py,pz,pt,nid);

		dbufSend(XP) = new CUDAHalfWilsonVectorField(1,y,z,t,nid);
		dbufRecv(XP) = new CUDAHalfWilsonVectorField(1,y,z,t,nid);
		dbufSend(XM) = new CUDAHalfWilsonVectorField(1,y,z,t,nid);
		dbufRecv(XM) = new CUDAHalfWilsonVectorField(1,y,z,t,nid);

		dbufSend(YP) = new CUDAHalfWilsonVectorField(x,1,z,t,nid);
		dbufRecv(YP) = new CUDAHalfWilsonVectorField(x,1,z,t,nid);
		dbufSend(YM) = new CUDAHalfWilsonVectorField(x,1,z,t,nid);
		dbufRecv(YM) = new CUDAHalfWilsonVectorField(x,1,z,t,nid);

		dbufSend(ZP) = new CUDAHalfWilsonVectorField(x,y,1,t,nid);
		dbufRecv(ZP) = new CUDAHalfWilsonVectorField(x,y,1,t,nid);
		dbufSend(ZM) = new CUDAHalfWilsonVectorField(x,y,1,t,nid);
		dbufRecv(ZM) = new CUDAHalfWilsonVectorField(x,y,1,t,nid);

		dbufSend(TP) = new CUDAHalfWilsonVectorField(x,y,z,1,nid);
		dbufRecv(TP) = new CUDAHalfWilsonVectorField(x,y,z,1,nid);
		dbufSend(TM) = new CUDAHalfWilsonVectorField(x,y,z,1,nid);
		dbufRecv(TM) = new CUDAHalfWilsonVectorField(x,y,z,1,nid);

		// recvCount = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8));
		// recvCountPrev = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8));
		// recvFlag = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8));

		// refBuffers = PlaceLocalHandle.make[Rail[GlobalRail[Double]]](Place.places(), ()=>new Rail[GlobalRail[Double]](8));

		// for(i in 0..7){
		// 	recvCount()(i) = 0;
		// 	recvCountPrev()(i) = 0;
		// }

		// refInitDone = 0;
	}

	// def initRef()
	// {
	// 	if(refInitDone == 0){
	// 		for(i in 0..7){
	// 			if(decomp(i) > 1){
	// 				val iDest = neighbors()( (i + 1 - 2*(i & 1)) );
	// 				refBuffers()(i) = at(Place(iDest)) new GlobalRail[Double](bufRecv(i).v());
	// 			}
	// 		}
	// 		refInitDone = 1;
	// 	}
	// }

	// def SendBuffer(dir : Long) : HalfWilsonVectorField
	// {
	// 	if(decomp(dir) < 2){
	// 		//we use same buffer for local boundary exchange
	// 		return bufRecv(dir);
	// 	}
	// 	else{
	// 		return bufSend(dir);
	// 	}
	// }

	def SendDeviceBuffer(dir : Long) : CUDAHalfWilsonVectorField
	{
	  if(decomp(dir) < 2){
	    //we use same buffer for local boundary exchange
	    return dbufRecv(dir);
	  }
	  else{
	    return dbufSend(dir);
	  }
	}

	// def RecvBuffer(dir : Long) : HalfWilsonVectorField
	// {
	// 	return bufRecv(dir);
	// }

	def RecvDeviceBuffer(dir : Long) : CUDAHalfWilsonVectorField
	{
		return dbufRecv(dir);
	}
	def RecvToDevice()
	{
	  // H2D
	  finish {
	    if(decomp(XP) > 1){
	      Rail.asyncCopy(bufRecv(XP).v(), 0, dbufRecv(XP).v()(), 0, bufRecv(XP).size);
	      Rail.asyncCopy(bufRecv(XM).v(), 0, dbufRecv(XM).v()(), 0, bufRecv(XM).size);
	    }
	    if(decomp(YP) > 1){
	      Rail.asyncCopy(bufRecv(YP).v(), 0, dbufRecv(YP).v()(), 0, bufRecv(YP).size);
	      Rail.asyncCopy(bufRecv(YM).v(), 0, dbufRecv(YM).v()(), 0, bufRecv(YM).size);
	    }
	    if(decomp(ZP) > 1){
	      Rail.asyncCopy(bufRecv(ZP).v(), 0, dbufRecv(ZP).v()(), 0, bufRecv(ZP).size);
	      Rail.asyncCopy(bufRecv(ZM).v(), 0, dbufRecv(ZM).v()(), 0, bufRecv(ZM).size);
	    }
	    if(decomp(TP) > 1){
	      Rail.asyncCopy(bufRecv(TP).v(), 0, dbufRecv(TP).v()(), 0, bufRecv(TP).size);
	      Rail.asyncCopy(bufRecv(TM).v(), 0, dbufRecv(TM).v()(), 0, bufRecv(TM).size);
	    }
	  }
	}

	// def Send(dir : Long)
	// {
	// 	if(decomp(dir) > 1){
	// 		val bufRef = GlobalRail(bufSend(dir).v());
	// 		val iDest = neighbors()( (dir + 1 - 2*(dir & 1)) );

	// 		finish {
	// 			at(Place(iDest)) async {
	// 				val size = bufRecv(dir).size;
	// 				finish{
	// 					Rail.asyncCopy[Double](bufRef,0,bufRecv(dir).v(),0,size);
	// 				}
	// 		//		finish{
	// 		//			Rail.uncountedCopy[Double](bufRef,0,bufRecv(dir).v(),0,size,()=>{recvCount()(dir)+=size;});
	// 		//		}
	// 			}
	// 		}
	// 	}
	// }

	def PutDevice(dir : Long)
	{
	  // D2H
	  finish {
            Rail.asyncCopy(dbufSend(dir).v()(), 0, bufSend(dir).v(), 0, bufSend(dir).size);
	  }

	  Put(dir);
	}

	// def Put(dir : Long)
	// {
	// 	val size = bufSend(dir).size;
	// 	Rail.asyncCopy[Double](bufSend(dir).v(),0,refBuffers()(dir),0,size);
	// }

	def WaitDeviceRecv(dir : Long)
	{
	  WaitRecv(dir);

	  if(decomp(dir) > 1){
	    // H2D
	    finish {
              Rail.asyncCopy(bufRecv(dir).v(), 0, dbufRecv(dir).v()(), 0, bufRecv(dir).size);
	    }
	  }
	}

// 	def WaitRecv(dir : Long)
// 	{
// //		if(decomp(dir) > 1){
// //			val size = bufRecv(dir).size;
// //			val t = recvCountPrev()(dir) + size;
// //			while(recvCount()(dir) < t){
// //				;
// //			}
// //			recvCountPrev()(dir) = t;
// //		}
// 	}

	// def Size(dir : Long) : Long
	// {
	// 	return bufRecv(dir).size;
	// }
}



