package xsbench;

public abstract class XSutils implements XSbench_header {
	
	// Allocates nuclide matrix
	public static def gpmatrix(m:Long, n:Long) = new Rail[Rail[NuclideGridPoint]](m, (Long)=>new Rail[NuclideGridPoint](n, (Long)=>new NuclideGridPoint()));

	// Frees nuclide matrix
	public static def gpmatrix_free(M:Rail[Rail[NuclideGridPoint]]):void {}
	
	// Compare function for two grid points. Used for sorting during init
	public static val NGP_compare = (i:NuclideGridPoint, j:NuclideGridPoint)=>((i.energy == j.energy) ? 0N : ((i.energy > j.energy) ? 1N : -1N));
	
	// Prints program logo
	public static def logo(version:Long):void {
		border_print();
		Console.OUT.print(
				"                   __   __ ___________                 _                        \n" +
				"                   \\ \\ / //  ___| ___ \\               | |                       \n" +
				"                    \\ V / \\ `--.| |_/ / ___ _ __   ___| |__                     \n" +
				"                    /   \\  `--. \\ ___ \\/ _ \\ '_ \\ / __| '_ \\                    \n" +
				"                   / /^\\ \\/\\__/ / |_/ /  __/ | | | (__| | | |                   \n" +
				"                   \\/   \\/\\____/\\____/ \\___|_| |_|\\___|_| |_|                   \n\n"
		);
		border_print();
		center_print("Developed at Argonne National Laboratory", 79);
		val v = String.format("Version: %d", [version as Any]);
		center_print(v, 79);
		border_print();
	}
	
	// Prints Section titles in center of 80 char terminal
	public static def center_print(s:String, width:Long):void {
		val length = s.length() as Long;
		for (var i:Long=0; i<=(width-length)/2; ++i) {
			Console.OUT.print(" ");
		}
		Console.OUT.println(s);
	}
	
	public static def border_print():void {
		Console.OUT.print("================================================================================\n");
	}
	
	// Prints comma separated integers - for ease of reading
	public static def fancy_int(a:Long):void {
		if (a < 1000)
			Console.OUT.printf("%d\n", a);
		else if (a >= 1000 && a < 1000000)
			Console.OUT.printf("%d,%03d\n", a / 1000, a % 1000);
		else if (a >= 1000000 && a < 1000000000)
			Console.OUT.printf("%d,%03d,%03d\n", a / 1000000, (a % 1000000) / 1000, a % 1000);
		else if (a >= 1000000000)
			Console.OUT.printf("%d,%03d,%03d,%03d\n", a / 1000000000, (a % 1000000000) / 1000000, (a % 1000000) / 1000, a % 1000);
		else
			Console.OUT.printf("%d\n", a);
	}
	
	// Binary Search function for nuclide grid
	// Returns ptr to energy less than the quarry that is closest to the quarry
	public static def binary_search(A:Rail[NuclideGridPoint], quarry:Double):Long {
		val n = A.size;
		var min:Long = 0;
		var max:Long = n-1;
		var mid:Long;
		
		// checks to ensure we're not reading off the end of the grid
		if (A(0).energy > quarry)
			return 0;
		else if (A(n-1).energy < quarry)
			return n-2;
		
		// Begins binary search	
		while (max >= min) {
			mid = min + Math.floor((max-min) / 2.0) as Long;
			if (A(mid).energy < quarry)
				min = mid+1;
			else if (A(mid).energy > quarry)
				max = mid-1;
			else
				return mid;
		}
		return max;
	}
	
	// Park & Miller Multiplicative Conguential Algorithm
	// From "Numerical Recipes" Second Edition
	public static def rn(seed:Cell[ULong]):Double {
		val a = 16807UL;
		val m = 2147483647UL;
		val n1 = a * seed() % m;
		seed(n1);
		return n1 as Double / m;
	}

}