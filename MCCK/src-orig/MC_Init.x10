import x10.io.FileReader;
import x10.io.File;
import x10.io.IOException;
import x10.regionarray.Array;
import x10.regionarray.Region;
import x10.regionarray.DistArray;
import x10.regionarray.Dist;
import x10.util.Random;
import x10.util.Team;
import x10.compiler.Native;
import x10.compiler.NativeCPPInclude;

//@NativeCPPInclude("time.h")
public class MC_Init {
   private var mc:MC;
    
	val bufsize:Double = 1.5;
/*
	@Native("c++", "time(NULL)")
	@Native("java", "System.currentTimeMillis()")
	static native def time():Double;

	@Native("c++", "srand((#1))")
	@Native("java", "new java.util.Random((long)(#1))")
	static native def srand(seed:Double):void;

	@Native("c++", "rand()")
	@Native("java", "(int)(Math.random()*2100000000)")
	static native def rand():Int;
*/
	def init(mcobj:MC, size:Rail[Double]):void {
      mc = mcobj;
      setup_grid();
      
//      if (mc.seed == 0d)
//  		mc.seed = time() * mc.mype;
		mc.seed = System.currentTimeMillis() * mc.mype;
	}

    var factorized:Rail[Int] = new Rail[Int](20000);
    var counter:Int = 0n;
    
    /**
     * returns an interger to tell how many
     * factors consist of.
     */
    private def fact(value:Int, div:Int):void {
       if (value == 0n || value == 1n)          
          return;
       
       else if (value % div == 0n) {
          factorized(div) += 1n;
          ++counter;
          fact(value/div, div);
          return;
       }
       else
          fact(value, div+1n);
    }
    
    private def getDim():Rail[Int] {
       fact(Place.MAX_PLACES as Int, 2n);
       var packed:Rail[Int] = new Rail[Int](counter);
       
       var index:Int = 0n;
       for (var i:Int = 0n; i < factorized.size; ++i) {
          for (var j:Int = 0n; j < factorized(i); ++j)
             packed(index++) = i;
       }
       
       var dim:Rail[Int] = new Rail[Int](3n);
       index = 0n;
       if (counter < 3n) {
       	 for (var i:Int = 0n; i < packed.size; ++i)
    		 	dim(index++) = packed(i);
       	  
       	 for (var i:Int = index; i < 3n; ++i)
       	   dim(i) = 1n;
       }
       else if (counter == 3n) {
          dim = packed;
       }
       else if (counter > 3n) {
          var begin:Int = 0n;
          var end:Int = counter - 1n;
          
          while (counter != 3n) {
             packed(begin++) *= packed(end--);
             if (begin >= end) {
                begin = 0n;
                end = counter -1n;
             }
             --counter;
          }
			 for (var i:Int = 0n; i < 3n; ++i)
				dim(i) = packed(i); 
       }
    
       return dim;
    }

	private def setup_grid():void {
       mc.grid = new Grid();
       val dim:Rail[Int] = getDim();

       var dx:Int;
       var dy:Int;
       var dz:Int;
       
       val states1 = 0..dim(0l);
       val states2 = 0..dim(1l);
       val states3 = 0..dim(2l);
       val s = Region.make(states1, states2, states3);
       
       mc.matrix = new MC.Matrix(s);
       
       var p:Place = Place.FIRST_PLACE;
       
       var xh:Int = -1n;
       var yh:Int = -1n;
       var zh:Int = -1n;
       
//       mc.mype = here.id as Int;
       
//Console.OUT.println(dim(0) + ", " + dim(1) + ", " + dim(2));
       /**
        * every places has to know the relation of matrix <=> place
        */
       for (var i:Int = 0n; i < dim(0); ++i) {
          for (var j:Int = 0n; j < dim(1); ++j) {
             for (var k:Int = 0n; k < dim(2); ++k) {
                if (i == 0n && j == 0n && k == 0n) 
                   p = Place.FIRST_PLACE;
                
                mc.matrix(i,j,k) = p.id() as Int;
//Console.OUT.println("(" + i + ", " + j + ", " + k + "): " + mc.matrix(i,j,k));
                
                if (p.id() == here.id) {
                   xh = i;
                   yh = j;
                   zh = k;
                }
                p = p.next();
             }
          }
       }

     /**
      * defines nabes
      */
      mc.grid.proc_coords(0n) = xh;
      mc.grid.proc_coords(1n) = yh;
      mc.grid.proc_coords(2n) = zh;
                          
      if (xh == 0n) {
         mc.grid.nabes(0n) = -1n;
			if (xh == dim(0n) - 1n)
         	mc.grid.nabes(1n) = -1n;
			else	
         	mc.grid.nabes(1n) = mc.matrix(xh + 1n, yh, zh);

//Console.OUT.println("xh=" + xh + ", yh=" + yh + ", zh=" + zh + ", " + mc.grid.nabes(1n));
      }
      else if (xh == dim(0n) - 1n) {
      	 mc.grid.nabes(0n) = mc.matrix(xh - 1n, yh, zh);
         mc.grid.nabes(1n) = -1n;
      }
      else {
         mc.grid.nabes(0n) = mc.matrix(xh - 1n, yh, zh);
         mc.grid.nabes(1n) = mc.matrix(xh + 1n, yh, zh);
      }
      
      if (yh == 0n) {
         mc.grid.nabes(2n) = -1n;

			if (yh == dim(1n) - 1n)
         	mc.grid.nabes(3n) = -1n;
			else	
         	mc.grid.nabes(3n) = mc.matrix(xh, yh + 1n, zh);
      }
      else if (yh == dim(1n) - 1n) {
         mc.grid.nabes(2n) = mc.matrix(xh, yh - 1n, zh);
         mc.grid.nabes(3n) = -1n;
      }
      else {
         mc.grid.nabes(2n) = mc.matrix(xh, yh - 1n, zh);
         mc.grid.nabes(3n) = mc.matrix(xh, yh + 1n, zh);
      }
                       
      if (zh == 0n) {
         mc.grid.nabes(4n) = -1n;

			if (zh == dim(2n) - 1n)
         	mc.grid.nabes(5n) = -1n;
			else	
         	mc.grid.nabes(5n) = mc.matrix(xh, yh, zh + 1n);
      }
      else if (zh == dim(2n) - 1n) {
      	 mc.grid.nabes(4n) = mc.matrix(xh, yh, zh - 1n);
         mc.grid.nabes(5n) = -1n;
      }
      else {
         mc.grid.nabes(4n) = mc.matrix(xh, yh, zh - 1n);
         mc.grid.nabes(5n) = mc.matrix(xh, yh, zh + 1n);
      }

/*
	Console.OUT.println(here.id + ":grid=");
	for (var i:Int =0n; i < 6; ++i)
		Console.OUT.print(i + ":" + mc.grid.nabes(i) + ", ");
	Console.OUT.println();
*/

       for (var i:Int = 0n; i < dim.size; ++i) 
       	  mc.grid.size(i) = dim(i) / dim(i);
       
       dx = (mc.grid.size(0n) / dim(0n)) as Int;
       dy = (mc.grid.size(1n) / dim(1n)) as Int;
       dz = (mc.grid.size(2n) / dim(2n)) as Int;

       mc.grid.coords(0n) = mc.grid.proc_coords(0n) * dx;
       mc.grid.coords(1n) = mc.grid.coords(0n) + dx;
       
       mc.grid.coords(2n) = mc.grid.proc_coords(1n) * dy;
       mc.grid.coords(3n) = mc.grid.coords(2n) + dy;

       mc.grid.coords(4n) = mc.grid.proc_coords(2n) * dz;
       mc.grid.coords(5n) = mc.grid.coords(4n) + dz;
	}
	
	
// 	private def getParameters(args:Rail[String], mc:MC):void {
//     	var read_flag:Int = 0n;
// 
// 		if (args.size == 0L) {
// 			Console.OUT.println("Usage:\nIn native X10, mpirun [-np NUM_PROC] <executable> NPARTICLES GLOBAL_LEAKAGE [-f INPUT FILE] [-r] [-b BOUNDARY CONDITION] [-m STRICT]\n");
// 			Console.OUT.println("In managed X10, X10_NPLACES=NUM_PROC $X10_PATH/bin/x10 -x10rt mpi <Main> NPARTICLES GLOBAL_LEAKAGE [-f INPUT FILE] [-r] [-b BOUNDARY CONDITION] [-m STRICT]\n");
// 			System.setExitCode(1n);
// 			return;
// 		}
// 
// 		var i:Int;
// 		for (i = 0n; i < args.size - 2; ++i) {
// 			if (  args(i).indexOf("-m") >= 0n
// 				|| args(i).indexOf("-M") >= 0n) {
// 				var mode:String;
// 				if (args(i).length() == 2n)
// 					mode = args(++i);
// 				else
// 					mode = args(i).substring(2n);
// 				
// 				if (mode.equals("strict"))
// 					mc.strict = 1n;
// 				else if (mode.equals("nostrict"))
// 					mc.strict = 0n;
// 				
// 				continue;
// 			}
// 			if (  args(i).indexOf("-b") >= 0n
// 				|| args(i).indexOf("-B") >= 0n) {
// 				var bndry_string:String;
// 				if (args(i).length() == 2n)
// 					bndry_string = args(++i);
// 				else
// 					bndry_string = args(i).substring(2n);
// 				
// 				if (bndry_string.equals("reflect"))
// 					mc.boundary_flag = mc.BNDRY_REFLECT;
// 				else if (bndry_string.equals("leak"))
// 					mc.boundary_flag = mc.BNDRY_LEAK;
// 				else if (bndry_string.equals("periodic"))
// 					mc.boundary_flag = mc.BNDRY_PERIODIC;
// 				
// 				continue;
// 			}
// 			if (  args(i).equals("-r") 
// 				|| args(i).equals("-R")) {
// 				mc.seed = 3333;
// 				continue;
// 			}
// 			if (  args(i).indexOf("-f") >= 0n
// 				|| args(i).indexOf("-F") >= 0n) {
// 				var ifile:String;
// 				if (args(i).length() == 2n)
// 					ifile = args(++i);
// 				else
// 					ifile = args(i).substring(2n);
// 				
// 				val file:File;
// 				try {
// 					file = new File(ifile);
// 				} catch (IOException) {
// 					Runtime.println("Could not open file\n");
// 					System.setExitCode(1n);
// 					return;
// 				}
// 				Console.OUT.println("reading input file: " + ifile + "\n");
// 
// 				try {
// 					val input = file.lines();
// 					if (Int.parse(input.next()) != mc.nprocs) {
// 						Console.OUT.println("Error reading input file: "
// 											+ ifile
// 											+ ". header value != nprocs\n");
// 						System.setExitCode(1n);
// 						return;
// 					}
// 					for (var j:Int= 0n; j < mc.nprocs; ++j) {
// 						if (!input.hasNext()) {
// 							Console.OUT.println("Error reading input file: "
// 												+ ifile
// 												+ ". unexpected EOF encountered\n");
// 							System.setExitCode(1n);
// 							return;
// 						}
// 						var line:String = input.next();
// 						val token = line.split(" ");
// 						for (pl in Place.places()) {
// 							at (pl) { 
// 								mc.np_array(here.id) = Int.parse(token(0n));
// 								mc.leakage_array(here.id) = Double.parse(token(1n));
// 							}
// 						}
//                         read_flag = 1n;
// 					}
// 					 
// 				} catch (IOException) { 
// 					System.setExitCode(1n);
// 					Runtime.println("Exception at " + here);
// 					return;
// 				} 
// 			}
// 		}
// 		
// 		if (read_flag == 0n) {
// 			mc.nparticles = Int.parse(args(i));
// 			mc.leakage = Double.parse(args(i+1n));
// 		}
// 	}
}
