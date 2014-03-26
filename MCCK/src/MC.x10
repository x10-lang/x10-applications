/*
 */

import x10.regionarray.Array;
import x10.regionarray.Region;

public class MC {
   public static val MC_NONBLOCK:int = -1n;
   public static val MC_MADRE:Int = -2n;
   public static val MC_BLOCK:Int = -3n;
   
   // val size:Int;

	public var particles:PlaceLocalHandle[Rail[Particle]];

   public var nparticles:Int;
   
   var np_array:Rail[Int] = null;

   var leakage_array:Rail[Double] = null;

   var nprocs:Int;
   
   var mype:Int;
   
   var boundary_flag:Int;
   
   var strict:Int;
   
   var leakage:Double;

   var seed:Double;
   
   var sizep:Int;
   
   
   /**
 	*  Matrix is used to define the mapping between Place and coordination of space.
 	*/
   public static type Matrix=Array[Int]{self.rank==3};
   public static type Matrix(r:Region)=Matrix{}; 

	// Initialized in MC_Init
   var matrix:Matrix;
   
	// Initialized in MC_Init
   var grid:Grid;
	
   def this(s:Int, bf:Int, se:Double, nps:Int, lkg:Double, bufsize:Double, npros:Int, mp:Int) {
	   if (s == -1n)
	   	strict = 0n;
	   if (bf == 0n)
	     boundary_flag = MC_Cycle.BNDRY_REFLECT;

	   seed = se;
		nparticles = nps;
		leakage = lkg;
	   sizep = ((1.0 + bufsize) * nparticles) as Int;
	   nprocs = npros;
		mype = mp;
   }
   
   def this(s:Int, bf:Int, se:Double, nps_array:Rail[Int], lkg_array:Rail[Double], bufsize:Double, npros:Int, mp:Int) {
	   
   }
}
