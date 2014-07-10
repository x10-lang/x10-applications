/*
 */

import x10.io.File;
import x10.io.IOException;

public class Main {
   public static def main(args:Rail[String]) {
      val domain:Rail[Double] = new Rail[Double](2);
      for (var i:Int = 0n; i < 2n; ++i)
         domain(i) = 1.0;

	  var leakage:Double = 0.5;
	  val bufsize = 0.5;
	  val nprocs = Place.numPlaces() as Int;
	  var np:Int = 0n;
	  var mype:Int = 0n;
      var nstages:Int = 0n;      
      var strict:Int = -1n;
      var boundary_flag:Int = 0n;
      var seed:Double = 0n;
      val np_array:Rail[Int] = new Rail[Int](nprocs);
      val leakage_array:Rail[Double] = new Rail[Double](nprocs);
      var read_flag:Int = 0n;
      var nparticles:Int = 0n;

      if (args.size < 2) {
         Console.ERR.println("Usage:\nIn native X10, mpirun [-np NUM_PROC] <executable> NPARTICLES GLOBAL_LEAKAGE [-f INPUT FILE] [-r] [-b BOUNDARY CONDITION] [-m STRICT]\n");
         Console.ERR.println("In managed X10, X10_NPLACES=NUM_PROC $X10_PATH/bin/x10 -x10rt mpi <Main> NPARTICLES GLOBAL_LEAKAGE [-f INPUT FILE] [-r] [-b BOUNDARY CONDITION] [-m STRICT]\n");
      	 System.setExitCode(1n);
      	 return;
      }

      var i:Int;
	  for (i = 0n; i < args.size - 2; ++i) {
			if (  args(i).indexOf("-m") >= 0n
				|| args(i).indexOf("-M") >= 0n) {
				var mode:String;
				if (args(i).length() == 2n)
					mode = args(++i);
				else
					mode = args(i).substring(2n);
				
				if (mode.equals("strict"))
					strict = 1n;
				else if (mode.equals("nostrict"))
					strict = 0n;
				
				continue;
      }
	  if (  args(i).indexOf("-b") >= 0n
				|| args(i).indexOf("-B") >= 0n) {
				var bndry_string:String;
				if (args(i).length() == 2n)
					bndry_string = args(++i);
				else
					bndry_string = args(i).substring(2n);
				
				if (bndry_string.equals("reflect"))
					boundary_flag = MC_Cycle.BNDRY_REFLECT;
				else if (bndry_string.equals("leak"))
					boundary_flag = MC_Cycle.BNDRY_LEAK;
				else if (bndry_string.equals("periodic"))
					boundary_flag = MC_Cycle.BNDRY_PERIODIC;
				
				continue;
      }
			if (  args(i).equals("-r") 
				|| args(i).equals("-R")) {
				seed = 3333d;
				continue;
			}
			if (  args(i).indexOf("-f") >= 0n
				|| args(i).indexOf("-F") >= 0n) {
				var ifile:String;
				if (args(i).length() == 2n)
					ifile = args(++i);
				else
					ifile = args(i).substring(2n);
				
				val file:File;
				try {
					file = new File(ifile);
				} catch (IOException) {
					throw new Exception("Could not open file " + ifile);
				}
				Console.OUT.println("reading input file: " + ifile + "\n");

				try {
					val input = file.lines();
					if (Int.parse(input.next()) != nprocs) {
						throw new Exception("Error reading input file: "
											+ ifile
											+ ". header value != nprocs");
					}
					for (var j:Int= 0n; j < nprocs; ++j) {
						if (!input.hasNext()) {
							throw new Exception("Error reading input file: "
												+ ifile
												+ ". unexpected EOF encountered\n");
						}
						var line:String = input.next();
						val token = line.split(" ");
						for (pl in Place.places()) {
							np_array(pl.id) = Int.parse(token(0n));
							leakage_array(pl.id) = Double.parse(token(1n));
						}
                        read_flag = 1n;
					}
					 
				} catch (IOException) { 
					throw new Exception("Exception reading input file: " + ifile);
				}
		}
	  }

	  
	  if (read_flag == 0n) {
		  nparticles = Int.parse(args(i));
		  leakage = Double.parse(args(i+1n));
	  }

		val nps = nparticles;
	  	val particles  = PlaceLocalHandle.make[Rail[Particle]](Place.places(), ()=>new Rail[Particle](nps*(1+bufsize) as Int));
		// conversion to val
	  	val s = strict;
	  	val bf = boundary_flag;
	  	val se = seed;
	  	val flag = read_flag;
	  	val lkg = leakage;

		Place.places().broadcastFlat(()=>{
			var mc:MC;
			if (flag == 0n)
	  		   mc = new MC(s, bf, se, nps, lkg, bufsize, nprocs, here.id as Int);
			else
			   mc = new MC(s, bf, se, np_array, leakage_array, bufsize, nprocs, here.id as Int);
			
			mc.particles = particles;
        	new MC_Init().init(mc, domain);           
         init_particles(mc, mc.nparticles, mc.grid.coords);
		 	var mc_cycle:MC_Cycle = new MC_Cycle(mc, mc.MC_NONBLOCK);
		 	mc_cycle.cycle();
 	  });
   }

   static def init_particles(mc:MC, np:Int, mycoords:Rail[Double]):void {
       xc:Double = (mycoords(0) + mycoords(1)) / 2;
       yc:Double = (mycoords(2) + mycoords(3)) / 2;
       zc:Double = (mycoords(4) + mycoords(5)) / 2;
    
       for (var i:Int = 0n; i < np; ++i) {
// Console.OUT.println(xc + ", " + yc + ", " + zc);
          mc.particles()(i) = new Particle(xc, yc, zc, 0d, 0d, 0n, mc.mype);
       }
    }
}
