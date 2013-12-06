
import HalfWilsonVectorField;

import Lattice;
import LatticeBoundaryExchange;

public class LatticeBoundaryExchangeMultiPlace extends LatticeBoundaryExchange {
	def this(x : Long,y : Long,z : Long,t : Long)
	{
		super(x,y,z,t);
	}

	//implemente these 2 functions for multi-place
	def Send(dir : Long,rng : LongRange)
	{
		;
	}

	def WaitRecv(dir : Long,rng : LongRange)
	{
		;
	}

}



