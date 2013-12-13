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

		val particlesRef = mc.particles;
		val particles:Rail[Particle] = particlesRef();

		val numRecvs = new Rail[Long](6);
		val grefPs = new Rail[GlobalRail[Double]](6);
		val pls = new Rail[Place](6);

		for (var i:Long = 0; i < 6; ++i) {
			val id = mc.grid.nabes(i);
			if (id < 0)
				continue;
			numRecvs(i) = myRecvCount(id) as Long; 
			grefPs(i) = GlobalRail(new Rail[Double](3*numRecvs(i)));
			pls(i) = Place.place(id);
		}

 		finish async {
			val h = here;
   		val hid = here.id;
			
			async for (var j:Int = 0n; j < 6n; ++j) {
				val id = mc.grid.nabes(j);
				if (id < 0 || numRecvs(j) == 0)
					continue;

				val numRecv2 = numRecvs(j) * 2;
				val numRecv3 = numRecvs(j) * 3;

				val k = j;
				async at (pls(k)) {
					val from = sdispl(hid);
               val fromP = new Rail[Double](numRecv3);

					for (var i:Int = 0n; i < numRecvs(k); ++i) {
						val particle:Particle = particlesRef()(from + i);
						fromP(i) = particle.x;
						fromP(numRecvs(k) + i) = particle.y;
						fromP(numRecv2 + i) = particle.z;
					}

               Rail.asyncCopy[Double](fromP, 0l, grefPs(k), 0l, numRecv3);
				}
  	      }
      }
		for (var j:Long = 0; j < 6; ++j) {
			val to = displ(pls(j).id);
			val end = to + numRecvs(j);

			val numRecv2 = numRecvs(j) << 2;
  		   for (var i:Int = to; i < end; ++i) {
				particles(i) = new Particle(grefPs(j)(i), grefPs(j)(numRecvs(j) + i), grefPs(j)(numRecv2 + i), 0d, 0d, 0n, mype);
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
