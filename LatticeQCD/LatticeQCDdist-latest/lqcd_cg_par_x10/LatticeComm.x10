
import HalfWilsonVectorField;
import ParallelLattice;


class LatticeComm extends ParallelLattice{
	val bufSend = new Rail[HalfWilsonVectorField](8);
	val bufRecv = new Rail[HalfWilsonVectorField](8);

	def this(x : Long,y : Long,z : Long,t : Long, px : Long, py : Long, pz : Long, pt : Long)
	{
		super(x,y,z,t,px,py,pz,pt);

		bufSend(XP) = new HalfWilsonVectorField(1,y,z,t);
		bufRecv(XP) = new HalfWilsonVectorField(1,y,z,t);
		bufSend(XM) = new HalfWilsonVectorField(1,y,z,t);
		bufRecv(XM) = new HalfWilsonVectorField(1,y,z,t);

		bufSend(YP) = new HalfWilsonVectorField(x,1,z,t);
		bufRecv(YP) = new HalfWilsonVectorField(x,1,z,t);
		bufSend(YM) = new HalfWilsonVectorField(x,1,z,t);
		bufRecv(YM) = new HalfWilsonVectorField(x,1,z,t);

		bufSend(ZP) = new HalfWilsonVectorField(x,y,1,t);
		bufRecv(ZP) = new HalfWilsonVectorField(x,y,1,t);
		bufSend(ZM) = new HalfWilsonVectorField(x,y,1,t);
		bufRecv(ZM) = new HalfWilsonVectorField(x,y,1,t);

		bufSend(TP) = new HalfWilsonVectorField(x,y,z,1);
		bufRecv(TP) = new HalfWilsonVectorField(x,y,z,1);
		bufSend(TM) = new HalfWilsonVectorField(x,y,z,1);
		bufRecv(TM) = new HalfWilsonVectorField(x,y,z,1);
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

			// finish {
				// at(Place(iDest)) async {
				at(Place(iDest)) {
					// finish{
						Rail.asyncCopy(bufRef,0,bufRecv(dir).v(),0,bufRecv(dir).size);
					// }
				}
			// }
		}
	}
	def WaitRecv(dir : Long)
	{
		;
	}
}



