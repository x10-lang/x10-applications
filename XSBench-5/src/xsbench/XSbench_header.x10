package xsbench;

public interface XSbench_header {

	// use async if false
	public static val XSBENCH_NO_ASYNC = System.getenv("XSBENCH_NO_ASYNC") != null;
	
	public static class GridPoint {
		val energy:Double;
		val xs_ptrs:Rail[Int];
		def this(energy:Double, xs_ptrs:Rail[Int]) {
			this.energy = energy;
			this.xs_ptrs = xs_ptrs;
		}
	}

	public static class NuclideGridPoint {
		var energy:Double;
		
		var total_xs:Double;
		var elastic_xs:Double;
		var absorbtion_xs:Double;
		var fission_xs:Double;
		var nu_fission_xs:Double;
		
		public final def randomize():void {
			energy = FakeRandom.rand();
			total_xs = FakeRandom.rand();
			elastic_xs = FakeRandom.rand();
			absorbtion_xs = FakeRandom.rand();
			fission_xs = FakeRandom.rand();
			nu_fission_xs = FakeRandom.rand();			
		}
	}
	
	// Variable to add extra flops at each lookup from unionized grid.
	public static val ADD_EXTRAS = false;
	public static val EXTRA_FLOPS = 0;
	public static val EXTRA_LOADS = 0;

	// I/O Specifiers
	public static val INFO = true;
	public static val DEBUG = true;
	public static val SAVE = true;
	public static val PRINT_PAPI_INFO = true;

}
