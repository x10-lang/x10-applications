package xsbench;

public abstract class Main implements XSbench_header {
	
    public static def main(args: Rail[String]):void {
    	
    	// =====================================================================
    	// Initialization & Command Line Read-In
    	// =====================================================================
    	
    	val version = 5;
    	val n_isotopes:Long; // H-M Large is 355, H-M Small is 68
    	val n_gridpoints = 11303;
    	val lookups = 15000000;
    	val nthreads:Int;
    	val max_procs = FakeOMP.omp_get_num_procs();
    	val HM:String;
    	val bgq_mode:Int;
    	
    	// rand() is only used in the serial initialization stages.
    	// A custom RNG is used in parallel portions.
    	FakeRandom.srand(System.currentTimeMillis());

    	// Process CLI Fields
    	// Usage:   ./XSBench <# threads> <H-M Size ("Small or "Large")> <BGQ mode>
    	// # threads - The number of threads you wish to run
    	// H-M Size -  The problem size (small = 68 nuclides, large = 355 nuclides)
    	// BGQ Mode -  Number of ranks - no real effect, save for stamping the
    	//             results.txt printout
    	// Note - No arguments are required - default parameters will be used if
    	//        no arguments are given.

    	if (args.size == 1) {
    		nthreads = Int.parse(args(0));	// first arg sets # of threads
    		n_isotopes = 355;			// defaults to H-M Large
    		bgq_mode = 0N;				// defaults to invalid BG/Q mode
    	}
    	else if (args.size == 2) {
    		nthreads = Int.parse(args(0));	// first arg sets # of threads
    		// second arg species small or large H-M benchmark
    		if (args(1).equalsIgnoreCase("small"))
    			n_isotopes = 68;
    		else
    			n_isotopes = 355;
    		bgq_mode = 0N;				// defaults to invalid BG/Q mode
    	}
    	else if (args.size == 3) {
    		nthreads = Int.parse(args(0));	// first arg sets # of threads
    		// second arg species small or large H-M benchmark
    		if (args(1).equalsIgnoreCase("small"))
    			n_isotopes = 68;
    		else
    			n_isotopes = 355;
    		bgq_mode = Int.parse(args(2));  // BG/Q mode (16,8,4,2,1) 
    	}
    	else {
    		nthreads = max_procs;		// defaults to full CPU usage
    		n_isotopes = 355;			// defaults to H-M Large
    		bgq_mode = 0N;				// defaults to invalid BG/Q mode
    	}

    	// Sets H-M size name
    	if (n_isotopes == 68)
    		HM = "Small";
    	else
    		HM = "Large";

    	// Set number of OpenMP Threads
    	FakeOMP.omp_set_num_threads(nthreads); 
    	
    	// =====================================================================
    	// Print-out of Input Summary
    	// =====================================================================
    	
    	XSutils.logo(version);
    	XSutils.center_print("INPUT SUMMARY", 79);
    	XSutils.border_print();
    	Console.OUT.printf("Materials:                    %d\n", 12);
    	Console.OUT.printf("H-M Benchmark Size:           %s\n", HM);
    	Console.OUT.printf("Total Isotopes:               %d\n", n_isotopes);
    	Console.OUT.print("Gridpoints (per Nuclide):     "); XSutils.fancy_int(n_gridpoints);
    	Console.OUT.print("Unionized Energy Gridpoints:  "); XSutils.fancy_int(n_isotopes*n_gridpoints);
    	Console.OUT.print("XS Lookups:                   "); XSutils.fancy_int(lookups);
    	Console.OUT.printf("Threads:                      %d\n", nthreads);
    	Console.OUT.printf("Est. Memory Usage (MB):       UNKNOWN\n");
    	if (EXTRA_FLOPS > 0)
    		Console.OUT.printf("Extra Flops:                  %d\n", EXTRA_FLOPS);
    	if (EXTRA_LOADS > 0)
    		Console.OUT.printf("Extra Loads:                  %d\n", EXTRA_LOADS);
    	XSutils.border_print();
    	XSutils.center_print("INITIALIZATION", 79);
    	XSutils.border_print();
    	
    	// =====================================================================
    	// Prepare Nuclide Energy Grids, Unionized Energy Grid, & Material Data
    	// =====================================================================

    	// Allocate & fill energy grids
    	Console.OUT.print("Generating Nuclide Energy Grids...\n");
    	
    	val nuclide_grids = XSutils.gpmatrix(n_isotopes, n_gridpoints);
    	
    	GridInit.generate_grids(nuclide_grids);	
    	
    	// Sort grids by energy
    	GridInit.sort_nuclide_grids(nuclide_grids);

    	// Prepare Unionized Energy Grid Framework
    	val energy_grid = GridInit.generate_energy_grid(nuclide_grids); 	

    	// Double Indexing. Filling in energy_grid with pointers to the
    	// nuclide_energy_grids.
    	GridInit.set_grid_ptrs(energy_grid, nuclide_grids);
    	
    	// Get material data
    	Console.OUT.print("Loading Mats...\n");
    	val num_nucs = Materials.load_num_nucs(n_isotopes);
    	val mats = Materials.load_mats(num_nucs, n_isotopes);
    	val concs = Materials.load_concs(num_nucs);

    	// =====================================================================
    	// Cross Section (XS) Parallel Lookup Simulation Begins
    	// =====================================================================
    	
    	XSutils.border_print();
    	XSutils.center_print("SIMULATION", 79);
    	XSutils.border_print();

    	val omp_start = FakeOMP.omp_get_wtime();
    	
    	// #ifdef __PAPI
    	// int eventset = PAPI_NULL; 
    	// int num_papi_events;
    	// counter_init(&eventset, &num_papi_events);
    	// #endif


    	if (XSBENCH_NO_ASYNC) {


    	// NOTE single thread version
    	// OpenMP compiler directives - declaring variables as shared or private
    	// #pragma omp parallel default(none) private(i, thread, p_energy, mat, seed) shared(max_procs, n_isotopes, n_gridpoints, energy_grid, nuclide_grids, lookups, nthreads, mats, concs, num_nucs)
    	{	
    		val macro_xs_vector = new Rail[Double](5);
    		val thread = FakeOMP.omp_get_thread_num();
    		val seed = new Cell[ULong]((thread+1N)*19N+17N);
    		// #pragma omp for
    		for (var i:Long = 0; i < lookups; ++i) {
    			// Status text
    			if (INFO && thread == 0N && i % 1000 == 0)
    				Console.OUT.printf("\rCalculating XS's... (%.0f%% completed)", i / (lookups / nthreads as Double) * 100.0);
    			
    			// Randomly pick an energy and material for the particle
    			val p_energy = XSutils.rn(seed);
    			val mat = Materials.pick_mat(seed); 
    			
    			// This returns the macro_xs_vector, but we're not going
    			// to do anything with it in this program, so return value
    			// is written over.
    			CalculateXS.calculate_macro_xs(p_energy, mat, concs, energy_grid, nuclide_grids, mats, macro_xs_vector);
    		}
    	}


    	} else /*!XSBENCH_NO_ASYNC*/ {


    	// NOTE multi thread version
    	// OpenMP compiler directives - declaring variables as shared or private
    	// #pragma omp parallel default(none) private(i, thread, p_energy, mat, seed) shared(max_procs, n_isotopes, n_gridpoints, energy_grid, nuclide_grids, lookups, nthreads, mats, concs, num_nucs)
    	finish {
    		val lookups_per_thread = lookups / nthreads;
    		for (var thread_:Int = 0N; thread_ < nthreads-1N; ++thread_) {
    			val thread = thread_;
    			async {
    				val macro_xs_vector = new Rail[Double](5);
    				val seed = new Cell[ULong]((thread+1N)*19N+17N);
    				// #pragma omp for
    				for (var i:Long = lookups_per_thread * thread; i < lookups_per_thread * (thread + 1); ++i) {
    					// Status text
    					if (INFO && thread == 0N && i % 1000 == 0)
    						Console.OUT.printf("\rCalculating XS's... (%.0f%% completed)", 100.0 * (i - lookups_per_thread * thread) / lookups_per_thread);
    			
    					// Randomly pick an energy and material for the particle
    					val p_energy = XSutils.rn(seed);
    					val mat = Materials.pick_mat(seed); 
    			
    					// This returns the macro_xs_vector, but we're not going
    					// to do anything with it in this program, so return value
    					// is written over.
    					CalculateXS.calculate_macro_xs(p_energy, mat, concs, energy_grid, nuclide_grids, mats, macro_xs_vector);
    				}
    			}
    		}
    		/*async*/ {
    			val thread = nthreads - 1N;
    			val macro_xs_vector = new Rail[Double](5);
    			val seed = new Cell[ULong]((thread+1N)*19N+17N);
    			// #pragma omp for
    			for (var i:Long = lookups_per_thread * thread; i < lookups; ++i) {
    				// Status text
    				if (INFO && thread == 0N && i % 1000 == 0)
    					Console.OUT.printf("\rCalculating XS's... (%.0f%% completed)", 100.0 * (i - lookups_per_thread * thread) / (lookups - lookups_per_thread * thread));
    					
    				// Randomly pick an energy and material for the particle
    				val p_energy = XSutils.rn(seed);
    				val mat = Materials.pick_mat(seed); 
    				
    				// This returns the macro_xs_vector, but we're not going
    				// to do anything with it in this program, so return value
    				// is written over.
    				CalculateXS.calculate_macro_xs(p_energy, mat, concs, energy_grid, nuclide_grids, mats, macro_xs_vector);
    			}
    		}
    	}


    	} /*!XSBENCH_NO_ASYNC*/


    	// TODO ditributed version
    	// create read only copy of concs, energy_grid, nuclide_grids, mats 
    	
    	Console.OUT.print("\n");
    	Console.OUT.print("Simulation complete.\n");

    	val omp_end = FakeOMP.omp_get_wtime();
    	
    	// =====================================================================
    	// Print / Save Results and Exit
    	// =====================================================================
    	
    	XSutils.border_print();
    	XSutils.center_print("RESULTS", 79);
    	XSutils.border_print();

    	// Print the results
    	Console.OUT.printf("Threads:     %d\n", nthreads);
    	if (EXTRA_FLOPS > 0)
    		Console.OUT.printf("Extra Flops: %d\n", EXTRA_FLOPS);
    	if (EXTRA_LOADS > 0)
    		Console.OUT.printf("Extra Loads: %d\n", EXTRA_LOADS);
    	Console.OUT.printf("Runtime:     %.3f seconds\n", omp_end - omp_start);
    	Console.OUT.print("Lookups:     "); XSutils.fancy_int(lookups);
    	Console.OUT.print("Lookups/s:   ");	XSutils.fancy_int((lookups as Double / (omp_end - omp_start)) as Long);
    	XSutils.border_print();

    	// For bechmarking, output lookup/s data to file
    	if (SAVE) {
    		val out = new x10.io.Printer(new x10.io.File("results.txt").openWrite(true));
    		out.printf("c%d\t%d\t%.0f\n", [bgq_mode as Any, nthreads, lookups as Double / (omp_end - omp_start)]);
    		out.close();
    	}
    	
    	// #ifdef __PAPI
    	// counter_stop(&eventset, num_papi_events);
    	// #endif
    }
}