
import HalfWilsonVectorField;

import Lattice;

import LatticeBoundaryExchange;

public class LatticeBoundaryExchangeLocal extends LatticeBoundaryExchange {
	def this(x : Long,y : Long,z : Long,t : Long)
	{
		super(x,y,z,t);
	}

	def SendBuffer(dir : Long) : HalfWilsonVectorField
	{
		//we use same buffer for local boundary exchange
		return bufRecv(dir);
	}
	def RecvBuffer(dir : Long) : HalfWilsonVectorField
	{
		return bufRecv(dir);
	}


	//we do nothig for comm
	def Send(dir : Long,rng : LongRange)
	{
		;
	}

	def WaitRecv(dir : Long,rng : LongRange)
	{
		;
	}

}



