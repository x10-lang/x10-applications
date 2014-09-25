/*
 */

public class MC_Comm {

   def init(mc:MC, comm_choice:Int): (MC, Rail[Int], Rail[Int])=>void {
      if (comm_choice == mc.MC_NONBLOCK)
         return nonblocking_exchange;
      else if (comm_choice == mc.MC_BLOCK) // so far, this condition is not used
         return blocking_exchange;
      else {
         throw new IllegalArgumentException("Invalid communication choice..." + comm_choice);
      }      
   }
   
   val nonblocking_exchange:(MC, Rail[Int], Rail[Int])=>void
          = (mc:MC, myRecvCount:Rail[Int], mySendCount:Rail[Int]) => {

        val displ = new Rail[Long](mc.nprocs);

        val numProcs:Int = mc.nprocs;
        val mype = mc.mype;
        var np:Int = mc.nparticles;

        /** now set the recv pointers locally on each proc. */
        displ(0) = np;
        for (i in 1..(numProcs-1)) {
            displ(i) = displ(i - 1) + myRecvCount(i - 1);
        }

        val particlesRef = mc.particles;
        val particles:Rail[Particle] = particlesRef();

        val numRecvs = new Rail[Long](6);
        val grefPs = new Rail[GlobalRail[Particle.PackedRepresentation]](6);
        val pls = new Rail[Place](6);

        for (i in 0..5) {
            val id = mc.grid.nabes(i);
            if (id < 0)
                continue;
            numRecvs(i) = myRecvCount(id) as Long; 
            grefPs(i) = GlobalRail(new Rail[Particle.PackedRepresentation](numRecvs(i)));
            pls(i) = Place(id);
        }

        val dest = here.id;

        finish {
            for (i in 0..5) {
                val id = mc.grid.nabes(i);
                val numRecv = numRecvs(i);
                if (id < 0 || numRecv == 0)
                    continue;

                val grefRecv = grefPs(i);
                at (pls(i)) async {
                    val packed = new Rail[Particle.PackedRepresentation](numRecv);
                    /*
                     * TODO send displacement is just scan of send count;
                     * should calculate once and store at each place
                     */
                    var senddispl:Long = 0;
                    for (proc in 0..(dest-1)) {
                        senddispl += MC_Cycle.mySendCount(proc);
                    }

                    for (j in 0..(numRecv-1)) {
                        val particle = particlesRef()(senddispl + j);
                        packed(j) = particle.getPackedRepresentation();
                    }

                    Rail.asyncCopy[Particle.PackedRepresentation](packed, 0, grefRecv, 0, numRecv);
                }
            }
        }

        for (i in 0..5) {
            val to = displ(i);
            val packed = grefPs(i)();
            for (j in 0..(numRecvs(i)-1)) {
                particles(j + to) = new Particle(packed(j));
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
                  at (Place(nabes(0))) (mc.particles()(sdispl(at (here) here.id) + ii));
          }
          for (i = 0n; i < myRecvCount(nabes(0)); ++i) {
              val ii = i;
              mc.particles()(mc.nparticles + displ(nabes(0)) + i) = 
                  at (Place(nabes(1))) (mc.particles()(sdispl(at (here) here.id) + ii));
          }
      }
      if (mycoords(1) % 2 == 0) {
          var i:Int;
          for (i = 0n; i < myRecvCount(nabes(3)); ++i) {
              val ii = i;
              mc.particles()(mc.nparticles + displ(nabes(3)) + i) = 
                  at (Place(nabes(2))) (mc.particles()(sdispl(at (here) here.id) + ii));
          }
          for (i = 0n; i < myRecvCount(nabes(2)); ++i) {
              val ii = i;
              mc.particles()(mc.nparticles + displ(nabes(2)) + i) = 
                  at (Place(nabes(3))) (mc.particles()(sdispl(at (here) here.id) + ii));
          }
      }
      if (mycoords(2) % 2 == 0) {
          var i:Int;
          for (i = 0n; i < myRecvCount(nabes(5)); ++i) {
              val ii = i;
              mc.particles()(mc.nparticles + displ(nabes(5)) + i) = 
                  at (Place(nabes(4))) (mc.particles()(sdispl(at (here) here.id) + ii));
          }
          for (i = 0n; i < myRecvCount(nabes(4)); ++i) {
              val ii = i;
              mc.particles()(mc.nparticles + displ(nabes(4)) + i) = 
                  at (Place(nabes(5))) (mc.particles()(sdispl(at (here) here.id) + ii));
          }
      }
      mc.nparticles += MC_Cycle.isum(myRecvCount, mc.nprocs);
   };
}
