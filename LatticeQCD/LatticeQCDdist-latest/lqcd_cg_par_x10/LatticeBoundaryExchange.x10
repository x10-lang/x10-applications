
import HalfWilsonVectorField;
import Lattice;


class LatticeBoundaryExchange extends Lattice{
	val bufSend = new Rail[HalfWilsonVectorField](8);
	val bufRecv = new Rail[HalfWilsonVectorField](8);
	val rank : Long;
	val nprocs : Long;
	val npx : Long;
	val npy : Long;
	val npz : Long;
	val npt : Long;
	val ipx : Long;
	val ipy : Long;
	val ipz : Long;
	val ipt : Long;
	val neighbors = new Rail[Long](8);
	val decomp = new Rail[Long](8);
	val XP = 0;
	val XM = 1;
	val YP = 2;
	val YM = 3;
	val ZP = 4;
	val ZM = 5;
	val TP = 6;
	val TM = 7;

	def this(x : Long,y : Long,z : Long,t : Long, px : Long, py : Long, pz : Long, pt : Long, myrank : Long)
	{
		super(x,y,z,t);

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

		rank = myrank;
		npx = px;
		npy = py;
		npz = pz;
		npt = pt;
		decomp(XP) = npx;
		decomp(XM) = npx;
		decomp(YP) = npy;
		decomp(YM) = npy;
		decomp(ZP) = npz;
		decomp(ZM) = npz;
		decomp(TP) = npt;
		decomp(TM) = npt;
		nprocs = npx*npy*npz*npt;

		ipx = rank % npx;
		ipy = (rank / npx) % npy;
		ipz = (rank / npx / npy) % npz;
		ipt = rank / npx / npy / npz;

		neighbors(XP) = (ipx + 1) % npx + (ipy) * npx + (ipz) * npx*npy + (ipt) * npx*npy*npz;
		neighbors(XM) = (ipx - 1 + npx) % npx + (ipy) * npx + (ipz) * npx*npy + (ipt) * npx*npy*npz;
		neighbors(YP) = (ipx) % npx + (ipy + 1) * npx + (ipz) * npx*npy + (ipt) * npx*npy*npz;
		neighbors(YM) = (ipx) % npx + (ipy - 1 + npy) * npx + (ipz) * npx*npy + (ipt) * npx*npy*npz;
		neighbors(ZP) = (ipx) % npx + (ipy) * npx + (ipz + 1) * npx*npy + (ipt) * npx*npy*npz;
		neighbors(ZM) = (ipx) % npx + (ipy) * npx + (ipz - 1 + npz) * npx*npy + (ipt) * npx*npy*npz;
		neighbors(TP) = (ipx) % npx + (ipy) * npx + (ipz) * npx*npy + (ipt + 1) * npx*npy*npz;
		neighbors(TM) = (ipx) % npx + (ipy) * npx + (ipz) * npx*npy + (ipt - 1 + npt) * npx*npy*npz;
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

	def Send(dir : Long,rng : LongRange)
	{
		;
	}
	def WaitRecv(dir : Long,rng : LongRange)
	{
		;
	}
}



