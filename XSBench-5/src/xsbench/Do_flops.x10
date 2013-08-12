package xsbench;

// Note that this file needs to be compiled separately with the -O0 flag
// to prevent the compiler from optimizing away the flops. The included
// makefile takes this into account.

public abstract class Do_flops implements XSbench_header {
	
	// Does a extra, arbitrary flops.
	public static def do_flops():void {
		var a:Double = 1.33;
		val b = 2.34;		
		for (var i:Long = 0; i < EXTRA_FLOPS; ++i) {
			a = a * b;
		}
	}

	// Does extra, random memory loads
	public static def do_loads(nuc_:Int, nuclide_grids:Rail[Rail[NuclideGridPoint]]):void {
		if (EXTRA_LOADS <= 0) return;
		val n_isotopes = nuclide_grids.size;
		val n_gridpoints = nuclide_grids(0).size;
		val nuc = nuc_ % n_isotopes;
		val tmp = new Cell[ULong](nuc as ULong);
		for (var i:Long = 0; i < EXTRA_LOADS; ++i) {
			val idx = rn_int(tmp) % n_gridpoints;
			val load = nuclide_grids(nuc)(idx).total_xs;
		}
	}

	// Park & Miller Multiplicative Conguential Algorithm
	// From "Numerical Recipes" Second Edition
	// This variant is used to find integers, rather than floats.
	public static def rn_int(seed:Cell[ULong]):Int {
		val a = 16807UL;
		val m = 2147483647UL;
		val n1 = a * seed() % m;
		seed(n1);
		// return n1 as Int;
		return n1 as Any as Int;
	}
	
}
