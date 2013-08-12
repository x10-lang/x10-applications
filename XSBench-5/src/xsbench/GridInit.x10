package xsbench;

import x10.util.RailUtils;

public abstract class GridInit implements XSbench_header {
	
	// FIXME workaround for XTENLANG-3242
	private static val NGP_compare = (i:NuclideGridPoint, j:NuclideGridPoint)=>((i.energy == j.energy) ? 0N : ((i.energy > j.energy) ? 1N : -1N));
	
	// Generates randomized energy grid for each nuclide
	// Note that this is done as part of initialization (serial), so
	// rand() is used.
	public static def generate_grids(nuclide_grids:Rail[Rail[NuclideGridPoint]]):void {
		for (var i:Long = 0; i < nuclide_grids.size; ++i) {
			val nuclide_grids_i = nuclide_grids(i);
			for (var j:Long = 0; j < nuclide_grids_i.size; ++j) {
				nuclide_grids_i(j).randomize();
			}
		}
	}

	// Sorts the nuclide grids by energy (lowest -> highest)
	public static def sort_nuclide_grids(nuclide_grids:Rail[Rail[NuclideGridPoint]]):void {
		Console.OUT.print("Sorting Nuclide Energy Grids...\n");

		// FIXME workaround for XTENLANG-3242
		// val cmp = XSutils.NGP_compare;
		val cmp = NGP_compare;

		for (var i:Long = 0; i < nuclide_grids.size; ++i) {
			RailUtils.sort(nuclide_grids(i), cmp);
		}
	}
	
	// Allocates unionized energy grid, and assigns union of energy levels
	// from nuclide grids to it.
	public static def generate_energy_grid(nuclide_grids:Rail[Rail[NuclideGridPoint]]):Rail[GridPoint] {
		val n_isotopes = nuclide_grids.size;
		val n_gridpoints = nuclide_grids(0).size;
		
		Console.OUT.print("Generating Unionized Energy Grid...\n");
		
		val n_unionized_grid_points = n_isotopes * n_gridpoints;

		Console.OUT.print("Copying and Sorting all nuclide grids...\n");
		
		val n_grid_sorted = XSutils.gpmatrix(1, n_unionized_grid_points);
		
		// flatten rail of rails to use RailUtils.sort
		val n_grid_sorted_flat = n_grid_sorted(0);

		for (var i:Long = 0, j:Long = 0; i < n_isotopes; ++i, j += n_gridpoints) {
			Rail.copy(nuclide_grids(i), 0, n_grid_sorted_flat, j, n_gridpoints);
		}
		
		// FIXME workaround for XTENLANG-3242
		// val cmp = XSutils.NGP_compare;
		val cmp = NGP_compare;
		
		RailUtils.sort(n_grid_sorted_flat, cmp);
		
		Console.OUT.print("Assigning energies to unionized grid...\n");

		val energy_grid = new Rail[GridPoint](n_unionized_grid_points, (i:Long)=>new GridPoint(n_grid_sorted_flat(i).energy, new Rail[Int](n_isotopes)));
		
		XSutils.gpmatrix_free(n_grid_sorted);

		return energy_grid;
	}

	// Searches each nuclide grid for the closest energy level and assigns
	// pointer from unionized grid to the correct spot in the nuclide grid.
	// This process is time consuming, as the number of binary searches
	// required is:  binary searches = n_gridpoints * n_isotopes^2
	public static def set_grid_ptrs(energy_grid:Rail[GridPoint], nuclide_grids:Rail[Rail[NuclideGridPoint]]):void {
		val n_isotopes = nuclide_grids.size;
		val n_gridpoints = nuclide_grids(0).size;
		val nthreads = FakeOMP.omp_get_num_threads();
		val n_unionized_grid_points = n_isotopes * n_gridpoints;
		val n_unionized_grid_points_per_thread =  n_unionized_grid_points / nthreads;
		
		Console.OUT.print("Assigning pointers to Unionized Energy Grid...\n");


		if (XSBENCH_NO_ASYNC) {


		// NOTE single thread version
		// #pragma omp parallel for default(none) shared(energy_grid, nuclide_grids, n_isotopes, n_gridpoints)
		val thread = FakeOMP.omp_get_thread_num();
		for (var i:Long = 0; i < n_unionized_grid_points; ++i) {
			val quarry = energy_grid(i).energy;
			if (INFO && thread == 0N && i % 200 == 0)
				Console.OUT.printf("\rAligning Unionized Grid...(%.0f%% complete)", 100.0 * i as Double / n_unionized_grid_points_per_thread);
			for (var j:Long = 0; j < n_isotopes; ++j) {
				// j is the nuclide i.d.
				// log n binary search
				energy_grid(i).xs_ptrs(j) = XSutils.binary_search(nuclide_grids(j), quarry) as Int;
			}
		}


		} else /*!XSBENCH_NO_ASYNC*/ {


		// NOTE multi thread version
		// #pragma omp parallel for default(none) shared(energy_grid, nuclide_grids, n_isotopes, n_gridpoints)
		finish {
			for (var thread_:Int = 0N; thread_ < nthreads - 1; ++thread_) {
				val thread = thread_;
				async {
					for (var i:Long = n_unionized_grid_points_per_thread * thread; i < n_unionized_grid_points_per_thread * (thread + 1); ++i) {
						val quarry = energy_grid(i).energy;
						if (INFO && thread == 0N && i % 200 == 0)
							Console.OUT.printf("\rAligning Unionized Grid...(%.0f%% complete)", 100.0 * (i - n_unionized_grid_points_per_thread * thread) / n_unionized_grid_points_per_thread);
						for (var j:Long = 0; j < n_isotopes; ++j) {
							// j is the nuclide i.d.
							// log n binary search
							energy_grid(i).xs_ptrs(j) = XSutils.binary_search(nuclide_grids(j), quarry) as Int;
						}
					}
				}
			}
			/*async*/ {
				val thread = nthreads - 1N;
				for (var i:Long = n_unionized_grid_points_per_thread * thread; i < n_unionized_grid_points; ++i) {
					val quarry = energy_grid(i).energy;
					if (INFO && thread == 0N && i % 200 == 0)
						Console.OUT.printf("\rAligning Unionized Grid...(%.0f%% complete)", 100.0 * (i - n_unionized_grid_points_per_thread * thread) / (n_unionized_grid_points - n_unionized_grid_points_per_thread * thread));
					for (var j:Long = 0; j < n_isotopes; ++j) {
						// j is the nuclide i.d.
						// log n binary search
						energy_grid(i).xs_ptrs(j) = XSutils.binary_search(nuclide_grids(j), quarry) as Int;
					}
				}
			}
		}


		} /*!XSBENCH_NO_ASYNC*/


		Console.OUT.print("\n");

		//test
		// NOTE original code has a bug
		// if (false) {
		// 	for (var i:Long = 0; i < n_isotopes * n_gridpoints; ++i)
		//  		for (var j:Long = 0; j < n_isotopes; ++j)
		//  			Console.OUT.printf("E = %.4f\tNuclide %d->%p->%.4f\n", energy_grid(i).energy, j, energy_grid(i).xs_ptrs(j), (energy_grid(i).xs_ptrs(j))->energy);
		// }

	}
	
}