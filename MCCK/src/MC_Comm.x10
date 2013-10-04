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
			
			async for (var j:Int = 0n; j < 6n; ++j) {
				val id = mc.grid.nabes(j);
				if (id < 0)
					continue;

				val pl:Place = Place.place(id);

   			np = mc.nparticles;
				val numRecv = myRecvCount(pl.id) as Long;
				
				if (numRecv == 0)
					continue;

				val numRecv2 = numRecv * 2;
				val numRecv3 = numRecv * 3;

            val tempP = new Rail[Double](numRecv3);
            val grefP= GlobalRail(tempP);

				val particlesRef = mc.particles;
				val particles:Rail[Particle] = particlesRef();

				async at (pl) {
					val from = sdispl(hid);
               val fromP = new Rail[Double](numRecv3);

					for (var i:Int = 0n; i < numRecv; ++i) {
						val particle:Particle = particlesRef()(from + i);
						fromP(i) = particle.x;
						fromP(numRecv + i) = particle.y;
						fromP(numRecv2 + i) = particle.z;
					}

               Rail.asyncCopy[Double](fromP, 0, grefP, 0, numRecv3);
				}
				val to = displ(pl.id);
				val end = to + numRecv;

				/** Currently, Particle object is initialized with the copied 
				 *  arguments because Rail.asyncCopy does not support the copy 
				 *  of user-defined types.
				 */
  	   	   for (var i:Int = to; i < end; ++i) {
					particles(i) = new Particle(grefP(i), grefP(numRecv + i), grefP(numRecv2 + i), 0d, 0d, 0n, mype);
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
