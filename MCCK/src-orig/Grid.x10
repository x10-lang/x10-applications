
public class Grid {
   var size:Rail[Double];
   var coords:Rail[Double];
   var nabes:Rail[Int];
   var proc_coords:Rail[Int];
   
   def this() {
      size = new Rail[Double](3);
      coords = new Rail[Double](6);
      nabes = new Rail[Int](6);
      proc_coords = new Rail[Int](3);
   }
}