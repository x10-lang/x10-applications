
public class Particle {
	var x:Double;
	var y:Double;
	var z:Double;

	var energy:Double;
	var angle:Double;
	var absorbed:Int;
	var proc:Int;
	
	def this(x:Double, y:Double, z:Double, energy:Double,
				angle:Double, absorbed:Int, proc:Int) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.energy = energy;
		this.angle = angle;
		this.absorbed = absorbed;
		this.proc = proc;
	}

 	static def compare(val p1:Particle, val p2:Particle):Int {
 		if (p1.absorbed == 1n && p2.absorbed == 0n) 
 			return 1n;
 		else if (p1.absorbed == 0n && p2.absorbed == 1n) 
 			return -1n;
		
 		if (p1.proc > p2.proc)
 			return 1n;
 		else if (p1.proc < p2.proc)
 			return -1n;
 		else
 			return 0n;
 	}
	
	/**
	 * Does nothing. 
	 * Oritinal <tt>Particle_print</tt> was not called from anywhere.
	 */
	def print(p:Particle, np:int, nprocs:int):void {}
}
