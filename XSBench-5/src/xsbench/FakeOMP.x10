package xsbench;

import x10.compiler.Native;

public abstract class FakeOMP implements XSbench_header {
	
	private static val num_threads = new Cell[Int](1N);
	
	/**
	 * return the number of available processors
	 */
	@Native("java", "java.lang.Runtime.getRuntime().availableProcessors()")
	public static def omp_get_num_procs():Int = 1N;

	/**
	 * set the number of threads used by this program.
	 * (note that multi thread mode is not supported yet)
	 */
	public static def omp_set_num_threads(nthreads:Int):void {
		if (!XSBENCH_NO_ASYNC) num_threads(nthreads);
	}
	
	/**
	 * return the number of threads
	 */
	public static def omp_get_num_threads():Int = num_threads();
	
	/**
	 * return the current thread id [0..nthreads)
	 */
	public static def omp_get_thread_num():Int = 0N;
	
	/**
	 * return the wall clock time in second as double
	 */
	public static def omp_get_wtime():Double = System.currentTimeMillis() / 1000.0;
	
}