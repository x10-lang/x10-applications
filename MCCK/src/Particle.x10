
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

    def this(packed:PackedRepresentation) {
        this.x = packed.x;
        this.y = packed.y;
        this.z = packed.z;
        this.energy = packed.energy;
        this.angle = packed.angle;
        this.absorbed = packed.absorbed;
        this.proc = packed.proc;
    }

 	static def compare(p1:Particle, p2:Particle):Int {
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
     * A packed representation of an Particle, for use in
     * transferring bulk particle data between places.
     * This would be unnecessary if X10 allowed variable struct fields.
     */
    public static struct PackedRepresentation(x:Double, y:Double, z:Double, energy:Double, angle:Double, absorbed:Int, proc:Int) { 
        public def this(x:Double, y:Double, z:Double, energy:Double, angle:Double, absorbed:Int, proc:Int) {
            property(x, y, z, energy, angle, absorbed, proc);
        }
    }

    public def getPackedRepresentation() {
        return PackedRepresentation(x, y, z, energy, angle, absorbed, proc);
    }
	
	/**
	 * Does nothing. 
	 * Oritinal <tt>Particle_print</tt> was not called from anywhere.
	 */
	def print(p:Particle, np:int, nprocs:int):void {}
}
