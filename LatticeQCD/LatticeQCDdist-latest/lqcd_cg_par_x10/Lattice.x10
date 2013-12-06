


public class Lattice {
	public val Nx : Long;
	public val Ny : Long;
	public val Nz : Long;
	public val Nt : Long;
	public val nsite : Long;
	public val offset_ux : Long;
	public val offset_uy : Long;
	public val offset_uz : Long;
	public val offset_ut : Long;
	public val Nxy : Long;
	public val Nxyz : Long;
	public val Nyzt : Long;
	public val Nxzt : Long;
	public val Nxyt : Long;
	public val XP = 0;
	public val XM = 1;
	public val YP = 2;
	public val YM = 3;
	public val ZP = 4;
	public val ZM = 5;
	public val TP = 6;
	public val TM = 7;

	def this(x : Long,y : Long,z : Long,t : Long)
	{
		Nx = x;
		Ny = y;
		Nz = z;
		Nt = t;

		nsite = x*y*z*t;

		offset_ux = 0;
		offset_uy = nsite;
		offset_uz = nsite*2;
		offset_ut = nsite*3;

		Nxy = x*y;
		Nxyz = x*y*z;
		Nyzt = y*z*t;
		Nxzt = x*z*t;
		Nxyt = x*y*t;
	}

}






