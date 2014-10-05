
import HalfWilsonVectorField;
import ParallelLattice;

import x10.compiler.Pragma;

class LatticeComm extends ParallelLattice{
	val bufSend = new Rail[HalfWilsonVectorField](8);
	val bufRecv = new Rail[HalfWilsonVectorField](8);
	val recvCount : PlaceLocalHandle[Rail[Long]];
	val recvCountPrev : PlaceLocalHandle[Rail[Long]];

	def this(x : Long,y : Long,z : Long,t : Long, px : Long, py : Long, pz : Long, pt : Long,nid : Long)
	{
		super(x,y,z,t,px,py,pz,pt);

		bufSend(XP) = new HalfWilsonVectorField(1,y,z,t,nid);
		bufRecv(XP) = new HalfWilsonVectorField(1,y,z,t,nid);
		bufSend(XM) = new HalfWilsonVectorField(1,y,z,t,nid);
		bufRecv(XM) = new HalfWilsonVectorField(1,y,z,t,nid);

		bufSend(YP) = new HalfWilsonVectorField(x,1,z,t,nid);
		bufRecv(YP) = new HalfWilsonVectorField(x,1,z,t,nid);
		bufSend(YM) = new HalfWilsonVectorField(x,1,z,t,nid);
		bufRecv(YM) = new HalfWilsonVectorField(x,1,z,t,nid);

		bufSend(ZP) = new HalfWilsonVectorField(x,y,1,t,nid);
		bufRecv(ZP) = new HalfWilsonVectorField(x,y,1,t,nid);
		bufSend(ZM) = new HalfWilsonVectorField(x,y,1,t,nid);
		bufRecv(ZM) = new HalfWilsonVectorField(x,y,1,t,nid);

		bufSend(TP) = new HalfWilsonVectorField(x,y,z,1,nid);
		bufRecv(TP) = new HalfWilsonVectorField(x,y,z,1,nid);
		bufSend(TM) = new HalfWilsonVectorField(x,y,z,1,nid);
		bufRecv(TM) = new HalfWilsonVectorField(x,y,z,1,nid);

		recvCount = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8));
		recvCountPrev = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8));

		for(i in 0..7){
			recvCount()(i) = 0;
			recvCountPrev()(i) = 0;
		}
	}

	def SendBuffer(dir : Long) : HalfWilsonVectorField
	{
		if(decomp(dir) < 2){
			//we use same buffer for local boundary exchange
			return bufRecv(dir);
		}
		else{
			return bufSend(dir);
		}
	}
	def RecvBuffer(dir : Long) : HalfWilsonVectorField
	{
		return bufRecv(dir);
	}

	def Send(dir : Long)
	{
		if(decomp(dir) > 1){
		  val bufRef = GlobalRail(bufSend(dir).v());
			val iDest = neighbors()( (dir + 1 - 2*(dir & 1)) );

		  // Console.OUT.println(here.id + " to " + iDest);
			// @Pragma(Pragma.FINISH_ASYNC_AND_BACK) finish {
			// finish {
				// at(Place(iDest)) async {
				at(Place(iDest)) {
					val size = bufRecv(dir).size;
					// finish{
					// @Pragma(Pragma.FINISH_ASYNC) finish{
						Rail.asyncCopy(bufRef,0,bufRecv(dir).v(),0,size);
					// }
			//		finish{
			//			Rail.uncountedCopy(bufRef,0,bufRecv(dir).v(),0,size,()=>{recvCount()(dir)+=size;});
			//		}
				}
			// }
		}
	}


	def WaitRecv(dir : Long)
	{
//		if(decomp(dir) > 1){
//			val size = bufRecv(dir).size;
//			val t = recvCountPrev()(dir) + size;
//			while(recvCount()(dir) < t){
//				;
//			}
//			recvCountPrev()(dir) = t;
//		}
	}

	def Size(dir : Long) : Long
	{
		return bufRecv(dir).size;
	}
}



