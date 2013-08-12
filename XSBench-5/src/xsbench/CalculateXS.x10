package xsbench;

import x10.util.RailUtils;

public abstract class CalculateXS implements XSbench_header {
	
	// Calculates the microscopic cross section for a given nuclide & energy
	public static def calculate_micro_xs(p_energy:Double, nuc:Int,
			energy_grid:Rail[GridPoint],
			nuclide_grids:Rail[Rail[NuclideGridPoint]],
			idx:Long,
			xs_vector:Rail[Double]):void {
		
		// pull ptr from energy grid
		val grid = nuclide_grids(nuc);
		val low = energy_grid(idx).xs_ptrs(nuc);
		val high = low + 1;
		
		val grid_high = grid(high);
		val grid_low = grid(low);
		
		// calculate the re-useable interpolation factor
		val f = (grid_high.energy - p_energy) / (grid_high.energy - grid_low.energy);

		// Total XS
		xs_vector(0) = grid_high.total_xs - f * (grid_high.total_xs - grid_low.total_xs);
		
		if (ADD_EXTRAS) {
			Do_flops.do_flops();
			Do_flops.do_loads(nuc, nuclide_grids);
		}
		
		// Elastic XS
		xs_vector(1) = grid_high.elastic_xs - f * (grid_high.elastic_xs - grid_low.elastic_xs);
		
		if (ADD_EXTRAS) {
			Do_flops.do_flops();
			Do_flops.do_loads(nuc+1N, nuclide_grids);	
		}
		
		// Absorbtion XS
		xs_vector(2) = grid_high.absorbtion_xs - f * (grid_high.absorbtion_xs - grid_low.absorbtion_xs);
		
		if (ADD_EXTRAS) {
			Do_flops.do_flops();
			Do_flops.do_loads(nuc+2N, nuclide_grids);	
		}
		
		// Fission XS
		xs_vector(3) = grid_high.fission_xs - f * (grid_high.fission_xs - grid_low.fission_xs);
		
		if (ADD_EXTRAS) {
			Do_flops.do_flops();
			Do_flops.do_loads(nuc+3N, nuclide_grids);	
		}
		
		// Nu Fission XS
		xs_vector(4) = grid_high.nu_fission_xs - f * (grid_high.nu_fission_xs - grid_low.nu_fission_xs);
		
		if (ADD_EXTRAS) {
			Do_flops.do_flops();
			Do_flops.do_loads(nuc+4N, nuclide_grids);	
		}
		
		//test
		if (false) {
			if (FakeOMP.omp_get_thread_num() == 0N) {
				Console.OUT.printf("Lookup: Energy = %f, nuc = %d\n", p_energy, nuc);
				Console.OUT.printf("e_h = %f e_l = %f\n", grid_high.energy, grid_low.energy);
				Console.OUT.printf("xs_h = %f xs_l = %f\n", grid_high.elastic_xs, grid_low.elastic_xs);
				Console.OUT.printf("total_xs = %f\n\n", xs_vector(1));
			}
		}
		
	}
	
	
	// Calculates macroscopic cross section based on a given material & energy
	public static def calculate_macro_xs(p_energy:Double, mat:Long,
			concs:Rail[Rail[Double]],
			energy_grid:Rail[GridPoint],
			nuclide_grids:Rail[Rail[NuclideGridPoint]],
			mats:Rail[Rail[Int]],
			macro_xs_vector:Rail[Double]{size==5}):void {
		val xs_vector = new Rail[Double](5);

		// cleans out macro_xs_vector
		macro_xs_vector.clear();

		// binary search for energy on unionized energy grid (UEG)
		val idx = grid_search(p_energy, energy_grid);	
		
		// Once we find the pointer array on the UEG, we can pull the data
		// from the respective nuclide grids, as well as the nuclide
		// concentration data for the material
		// Each nuclide from the material needs to have its micro-XS array
		// looked up & interpolatied (via calculate_micro_xs). Then, the
		// micro XS is multiplied by the concentration of that nuclide
		// in the material, and added to the total macro XS array.
		val mats_mat = mats(mat);
		val concs_mat = concs(mat);
		for (var j:Long = 0; j < mats_mat.size; ++j) {
			val p_nuc = mats_mat(j);	// the nuclide we are looking up
			val conc = concs_mat(j);	// the concentration of the nuclide in the material
			calculate_micro_xs(p_energy, p_nuc, energy_grid, nuclide_grids, idx, xs_vector);
			// for (var k:Int = 0; k < macro_xs_vector.size; ++k)
			// 	macro_xs_vector(k) += xs_vector(k) * conc;
			RailUtils.map(macro_xs_vector, xs_vector, macro_xs_vector, (a:Double,b:Double)=>a+b*conc);
		}
		
		//test
		if (false) {
			for (var k:Long = 0; k < macro_xs_vector.size; ++k) {
				Console.OUT.printf("Energy: %f, Material: %d, XSVector[%d]: %f\n", p_energy, mat, k, macro_xs_vector(k));
			}
		}
		
	}
	
	
	// (fixed) binary search for energy on unionized energy grid
	// returns lower index
	public static def grid_search(quarry:Double, A:Rail[GridPoint]):Long {
		var lowerLimit:Long = 0;
		var upperLimit:Long = A.size - 1;
		var length:Long = upperLimit - lowerLimit;

		while (length > 1) {
			val examinationPoint = lowerLimit + (length / 2);
			if (A(examinationPoint).energy > quarry)
				upperLimit = examinationPoint;
			else
				lowerLimit = examinationPoint;
			length = upperLimit - lowerLimit;
		}
		
		return lowerLimit;
	}

}