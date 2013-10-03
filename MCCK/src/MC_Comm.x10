import x10.regionarray.DistArray;
import x10.regionarray.Dist;
import x10.regionarray.Region;

public class MC_Comm {

   def init(mc:MC, comm_choice:Int): (MC, Rail[Int], Rail[Int])=>void {
      if (comm_choice == mc.MC_NONBLOCK)
         return nonblocking_exchange;
// so far, this condition is not used
      else if (comm_choice == mc.MC_BLOCK)
         return blocking_exchange;
      else {
         Console.OUT.println("Invalid communication choice...");
         System.setExitCode(1n);
         return null;
      }      
   }
   
   val nonblocking_exchange:(MC, Rail[Int], Rail[Int])=>void
      	= (mc:MC, myRecvCount:Rail[Int], mySendCount:Rail[Int]) => {

		val displ:Rail[Int] = new Rail[Int](mc.nprocs);
		val sdispl:Rail[Int] = new Rail[Int](mc.nprocs);

      val numProcs:Int = mc.nprocs;
		val mype = mc.mype;
		var np:Int = mc.nparticles;

		displ(0) = np;	
      
   	/** now set the recv pointers locally on each proc. */
   	for (var i:Int = 1n; i < numProcs; ++i)
   	  	displ(i) = displ(i - 1n) + myRecvCount(i - 1n);
       
   	for (var i:Int = 1n; i < numProcs; ++i)
   	  	sdispl(i) = sdispl(i - 1n) + mySendCount(i - 1n);
		
 		finish async {
			val h = here;
   		val hid = here.id;
			
/*
  	  	 	async for (pl in Place.places()) {
*/
			for (var j:Int = 0n; j < 6n; ++j) {
				val id = mc.grid.nabes(j);
				if (id < 0)
					continue;

				val pl:Place = Place.place(id);
/*
  	     	   if (pl.id == hid)
  	           	  continue;
*/					

   			np = mc.nparticles;
				val numRecv = myRecvCount(pl.id) as Long;
				
				if (numRecv == 0)
					continue;

            val tempX = new Rail[Double](numRecv);
            val tempY = new Rail[Double](numRecv);
            val tempZ = new Rail[Double](numRecv);
/*
            val tempEnergy = new Rail[Double](numRecv);
            val tempAngle = new Rail[Double](numRecv);
            val tempAbsorbed = new Rail[Int](numRecv);
            val tempProc = new Rail[Int](numRecv);
*/

            val grefX = GlobalRail(tempX);
            val grefY = GlobalRail(tempY);
            val grefZ = GlobalRail(tempZ);
/*
            val grefEnergy = GlobalRail(tempEnergy);
            val grefAngle = GlobalRail(tempAngle);
            val grefAbsorbed = GlobalRail(tempAbsorbed);
            val grefProc = GlobalRail(tempProc);
*/

				val particlesRef = mc.particles;
				val particles:Rail[Particle] = particlesRef();

				async at (pl) {
					val from = sdispl(at (h) hid);
					
               val fromX = new Rail[Double](numRecv);
               val fromY = new Rail[Double](numRecv);
               val fromZ = new Rail[Double](numRecv);
/*
               val fromEnergy = new Rail[Double](numRecv);
               val fromAngle = new Rail[Double](numRecv);
               val fromAbsorbed = new Rail[Int](numRecv);
               val fromProc = new Rail[Int](numRecv);
*/

					for (var i:Int = 0n; i < numRecv; ++i) {
						val particle:Particle = particlesRef()(from + i);

                  fromX(i) = particle.x;
                  fromY(i) = particle.y;
                  fromZ(i) = particle.z;
/*
                  fromEnergy(i) = particle.energy;
                  fromAngle(i) = particle.angle;
                  fromAbsorbed(i) = particle.absorbed;
                  fromProc(i) = particle.proc;
*/
					}
               Rail.asyncCopy[Double](fromX, 0, grefX, 0, numRecv);
               Rail.asyncCopy[Double](fromY, 0, grefY, 0, numRecv);
               Rail.asyncCopy[Double](fromZ, 0, grefZ, 0, numRecv);
/*
               Rail.asyncCopy[Double](fromEnergy, 0, grefEnergy, 0, numRecv);
               Rail.asyncCopy[Double](fromAngle, 0, grefAngle, 0, numRecv);
               Rail.asyncCopy[Int](fromAbsorbed, 0, grefAbsorbed, 0, numRecv);
               Rail.asyncCopy[Int](fromProc, 0, grefProc, 0, numRecv);
*/
				}

				val to = displ(pl.id);
				val end = to + numRecv;

				/** Currently, Particle object is initialized with the copied 
				 *  arguments because Rail.asyncCopy does not support the copy 
				 *  of user-defined types.
				 */
  	   	   for (var i:Int = to; i < end; ++i) {
					particles(i) = new Particle(grefX(i), grefY(i), grefZ(i), 0d, 0d, 0n, mype);
				}
  	      }
      }
 	  	mc.nparticles += MC_Cycle.isum(myRecvCount, mc.nprocs);
    };
    
	
    /** 3D Cartesian ordered checkerboard blocking communication */
    val blocking_exchange:(MC, Rail[Int], Rail[Int])=>void 
  			= (mc:MC, myRecvCount:Rail[Int], mySendCount:Rail[Int]) => {
   				
      mycoords:Rail[Int] = mc.grid.proc_coords;  
   	  nabes:Rail[Int] = mc.grid.nabes;
   
      val displ:Rail[Int] = new Rail[Int](mc.nprocs);
   	  val sdispl:Rail[Int] = new Rail[Int](mc.nprocs);
   
   	  /**now set the recv pointers locally on each proc. */
   	  for (var i:Int = 1n; i < mc.nprocs; ++i) 
   		 displ(i) = displ(i - 1n) + myRecvCount(i - 1n);

      /** now set the recv pointers locally on each proc. */
      for (var i:Int = 1n; i < mc.nprocs; ++i) 
         sdispl(i) = sdispl(i - 1n) + mySendCount(i - 1n);
      
      /** Left/right ordered exchange */
      if (mycoords(0) % 2 == 0) {
    	  var i:Int;
    	  for (i = 0n; i < myRecvCount(nabes(1)); ++i) {
    		  val ii = i;
    		  mc.particles()(mc.nparticles + displ(nabes(1)) + i) = 
    			  at (Place.place(nabes(0))) (mc.particles()(sdispl(at (here) here.id) + ii));
    	  }
    	  for (i = 0n; i < myRecvCount(nabes(0)); ++i) {
    		  val ii = i;
    		  mc.particles()(mc.nparticles + displ(nabes(0)) + i) = 
    			  at (Place.place(nabes(1))) (mc.particles()(sdispl(at (here) here.id) + ii));
    	  }
      }
      if (mycoords(1) % 2 == 0) {
    	  var i:Int;
    	  for (i = 0n; i < myRecvCount(nabes(3)); ++i) {
    		  val ii = i;
    		  mc.particles()(mc.nparticles + displ(nabes(3)) + i) = 
    			  at (Place.place(nabes(2))) (mc.particles()(sdispl(at (here) here.id) + ii));
    	  }
    	  for (i = 0n; i < myRecvCount(nabes(2)); ++i) {
    		  val ii = i;
    		  mc.particles()(mc.nparticles + displ(nabes(2)) + i) = 
    			  at (Place.place(nabes(3))) (mc.particles()(sdispl(at (here) here.id) + ii));
    	  }
      }
      if (mycoords(2) % 2 == 0) {
    	  var i:Int;
    	  for (i = 0n; i < myRecvCount(nabes(5)); ++i) {
    		  val ii = i;
    		  mc.particles()(mc.nparticles + displ(nabes(5)) + i) = 
    			  at (Place.place(nabes(4))) (mc.particles()(sdispl(at (here) here.id) + ii));
    	  }
    	  for (i = 0n; i < myRecvCount(nabes(4)); ++i) {
    		  val ii = i;
    		  mc.particles()(mc.nparticles + displ(nabes(4)) + i) = 
    			  at (Place.place(nabes(5))) (mc.particles()(sdispl(at (here) here.id) + ii));
    	  }
      }
      mc.nparticles += MC_Cycle.isum(myRecvCount, mc.nprocs);
   };
}
