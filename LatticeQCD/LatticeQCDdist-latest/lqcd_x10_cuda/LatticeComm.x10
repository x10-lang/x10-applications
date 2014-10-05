
import HalfWilsonVectorField;
import ParallelLattice;
//debug
import ParallelComplexField;

// import x10.regionarray.*;

class LatticeComm extends ParallelLattice{
	val bufSend = new Rail[HalfWilsonVectorField](8);
	val bufRecv = new Rail[HalfWilsonVectorField](8);
	val recvFlag : PlaceLocalHandle[Rail[Long]];
	val refBuffers : PlaceLocalHandle[Rail[GlobalRail[Double]]];
	var refInitDone : Long;

	val counts : PlaceLocalHandle[Rail[Long]];
	val recvCounts : PlaceLocalHandle[Rail[Long]];

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

		recvFlag = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8));
//debug
		counts = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8, 0));
		recvCounts = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](8, 0));

		refBuffers = PlaceLocalHandle.make[Rail[GlobalRail[Double]]](Place.places(), ()=>new Rail[GlobalRail[Double]](8));

		refInitDone = 0;
	}

	def initRef()
	{
		if(refInitDone == 0){
			for(i in 0..7){
				if(decomp(i) > 1){
					val iDest = neighbors()( (i + 1 - 2*(i & 1)) );
//debug
					refBuffers()(i) = at(Place(iDest)) new GlobalRail[Double](bufRecv(i).v());
					// refBuffers()(i) = at(Place(neighbors()(i))) new GlobalRail[Double](bufRecv(i).v());
				}
			}
			refInitDone = 1;
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

	    finish {
	      at(Place(iDest)) async {
	      // at(Place(iDest)) {
		val size = bufRecv(dir).size;
		finish{
		  Rail.asyncCopy(bufRef,0,bufRecv(dir).v(),0,size);
		}
		// finish{
		  // Rail.uncountedCopy(bufRef, 0, bufRecv(dir).v(), 0, size, ()=>{recvCount()(dir)+=size;});
		// }
	      }
	    }
	  }
	}

	def Put(dir : Long)
	{
	  val size = bufSend(dir).size;
//debug
	  Rail.asyncCopy(bufSend(dir).v(), 0, refBuffers()(dir), 0, size);
	  // Rail.uncountedCopy(bufSend(dir).v(), 0, refBuffers()(dir), 0, size, ()=>{
	  //   atomic counts()(dir) += 1;
	  //   atomic recvCounts()(dir) += 1;
	  // });

	}

	def WaitSend(dir : Long)
	{
	  if(decomp(dir) > 1){
	    val iDest = neighbors()( (dir + 1 - 2*(dir & 1)) );

	    at (Place(iDest)) {
	      while (counts()(dir) < 1) {
		Runtime.probe();
	      }
	      atomic counts()(dir) -= 1;
	    }
	  }
	}

	def WaitRecv(dir : Long)
	{
	  if(decomp(dir) > 1){
	    while (recvCounts()(dir) < 1){
	      Runtime.probe();
	    }
	    atomic recvCounts()(dir) -= 1;
	  }
	}

	def Size(dir : Long) : Long
	{
		return bufRecv(dir).size;
	}
}
