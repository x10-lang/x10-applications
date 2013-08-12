// Material data is hard coded into the functions in this file.
// Note that there are 12 materials present in H-M (large or small)

package xsbench;

public abstract class Materials implements XSbench_header {
	
	// NOTE: immutable data
	private static val num_nucs_ = [
	                                0N,
	                                5N,
	                                4N,
	                                4N,
	                                27N,
	                                21N,
	                                21N,
	                                21N,
	                                21N,
	                                21N,
	                                9N,
	                                9N
	                                ];
	private static val num_nucs_Sml = new Rail[Int](num_nucs_.size, (i:Long)=>(i == 0) ?  34N : num_nucs_(i));
	private static val num_nucs_Lrg = new Rail[Int](num_nucs_.size, (i:Long)=>(i == 0) ? 321N : num_nucs_(i));

	
	// num_nucs represents the number of nuclides that each material contains
	public static def load_num_nucs(n_isotopes:Long):Rail[Int] {
		// val num_nucs = new Rail[Int](12);
		// 
		// // Material 0 is a special case (fuel). The H-M small reactor uses
		// // 34 nuclides, while H-M larges uses 300.
		// if (n_isotopes == 68)
		// 	num_nucs(0)  = 34N; // HM Small is 34, H-M Large is 321
		// else
		// 	num_nucs(0)  = 321N; // HM Small is 34, H-M Large is 321
		// 
		// num_nucs(1)  = 5N;
		// num_nucs(2)  = 4N;
		// num_nucs(3)  = 4N;
		// num_nucs(4)  = 27N;
		// num_nucs(5)  = 21N;
		// num_nucs(6)  = 21N;
		// num_nucs(7)  = 21N;
		// num_nucs(8)  = 21N;
		// num_nucs(9)  = 21N;
		// num_nucs(10) = 9N;
		// num_nucs(11) = 9N;

		val num_nucs:Rail[Int];
		
		// Material 0 is a special case (fuel). The H-M small reactor uses
		// 34 nuclides, while H-M larges uses 300.
		if (n_isotopes == 68)
			num_nucs = num_nucs_Sml; // HM Small is 34, H-M Large is 321
		else
			num_nucs = num_nucs_Lrg; // HM Small is 34, H-M Large is 321

		return num_nucs;
	}


	// NOTE: immutable data
	// Small H-M has 34 fuel nuclides
	private static val mats0_Sml = [ 58N, 59N, 60N, 61N, 40N, 42N, 43N, 44N, 45N, 46N, 1N, 2N, 3N, 7N,
	                                 8N, 9N, 10N, 29N, 57N, 47N, 48N, 0N, 62N, 15N, 33N, 34N, 52N, 53N, 
	                                 54N, 55N, 56N, 18N, 23N, 41N ]; //fuel
	// Large H-M has 300 fuel nuclides
	private static val mats0_Lrg = new Rail[Int](321, (i:Long)=>(i < mats0_Sml.size) ? mats0_Sml(i) : (34N + i as Int)); //fuel
	
	// These are the non-fuel materials	
	private static val mats1 = [ 63N, 64N, 65N, 66N, 67N ]; // cladding
	private static val mats2 = [ 24N, 41N, 4N, 5N ]; // cold borated water
	private static val mats3 = [ 24N, 41N, 4N, 5N ]; // hot borated water
	private static val mats4 = [ 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N, 27N, 28N, 29N,
	                             30N, 31N, 32N, 26N, 49N, 50N, 51N, 11N, 12N, 13N, 14N, 6N, 16N,
	                             17N ]; // RPV
	private static val mats5 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
	                             49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // lower radial reflector
	private static val mats6 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
	                             49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // top reflector / plate
	private static val mats7 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
	                             49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // bottom plate
	private static val mats8 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
	                             49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // bottom nozzle
	private static val mats9 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
	                             49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // top nozzle
	private static val mats10 = [ 24N, 41N, 4N, 5N, 63N, 64N, 65N, 66N, 67N ]; // top of FA's
	private static val mats11 = [ 24N, 41N, 4N, 5N, 63N, 64N, 65N, 66N, 67N ]; // bottom FA's

	
	private static val mats_Sml = [ mats0_Sml, mats1, mats2, mats3, mats4, mats5, mats6, mats7, mats8, mats9, mats10, mats11 ];
	private static val mats_Lrg = [ mats0_Lrg, mats1, mats2, mats3, mats4, mats5, mats6, mats7, mats8, mats9, mats10, mats11 ];

	// Assigns an array of nuclide ID's to each material
	public static def load_mats(num_nucs:Rail[Int], n_isotopes:Long):Rail[Rail[Int]] {
		
		// val mats = new Rail[Rail[Int]](12, (i:Long)=>new Rail[Int](num_nucs(i)));
		// 
		// NOTE: immutable data
		// // Small H-M has 34 fuel nuclides
		// val mats0_Sml = [ 58N, 59N, 60N, 61N, 40N, 42N, 43N, 44N, 45N, 46N, 1N, 2N, 3N, 7N,
		// 	8N, 9N, 10N, 29N, 57N, 47N, 48N, 0N, 62N, 15N, 33N, 34N, 52N, 53N, 
		// 	54N, 55N, 56N, 18N, 23N, 41N ]; //fuel
		// // Large H-M has 300 fuel nuclides
		// val mats0_Lrg = new Rail[Int](321); //fuel
		// Rail.copy(mats0_Sml, 0, mats0_Lrg, 0, mats0_Sml.size);
		// for (var i:Long = mats0_Sml.size; i < mats0_Lrg.size; ++i) {
		// 	mats0_Lrg(i) = 34N + i as Int; // H-M large adds nuclides to fuel only
		// }
		// 
		// // These are the non-fuel materials	
		// val mats1 = [ 63N, 64N, 65N, 66N, 67N ]; // cladding
		// val mats2 = [ 24N, 41N, 4N, 5N ]; // cold borated water
		// val mats3 = [ 24N, 41N, 4N, 5N ]; // hot borated water
		// val mats4 = [ 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N, 27N, 28N, 29N,
		// 	30N, 31N, 32N, 26N, 49N, 50N, 51N, 11N, 12N, 13N, 14N, 6N, 16N,
		// 	17N ]; // RPV
		// val mats5 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
		// 	49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // lower radial reflector
		// val mats6 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
		// 	49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // top reflector / plate
		// val mats7 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
		// 	49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // bottom plate
		// val mats8 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
		// 	49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // bottom nozzle
		// val mats9 = [ 24N, 41N, 4N, 5N, 19N, 20N, 21N, 22N, 35N, 36N, 37N, 38N, 39N, 25N,
		// 	49N, 50N, 51N, 11N, 12N, 13N, 14N ]; // top nozzle
		// val mats10 = [ 24N, 41N, 4N, 5N, 63N, 64N, 65N, 66N, 67N ]; // top of FA's
		// val mats11 = [ 24N, 41N, 4N, 5N, 63N, 64N, 65N, 66N, 67N ]; // bottom FA's
		// 
		// 
		// // H-M large v small dependency
		// if (n_isotopes == 68)
		// 	Rail.copy(mats0_Sml, 0, mats(0), 0, num_nucs(0) as Long);	
		// else
		// 	Rail.copy(mats0_Lrg, 0, mats(0), 0, num_nucs(0) as Long);
		// 
		// // Copy other materials
		// Rail.copy(mats1, 0, mats(1), 0, num_nucs(1) as Long);	
		// Rail.copy(mats2, 0, mats(2), 0, num_nucs(2) as Long);	
		// Rail.copy(mats3, 0, mats(3), 0, num_nucs(3) as Long);	
		// Rail.copy(mats4, 0, mats(4), 0, num_nucs(4) as Long);	
		// Rail.copy(mats5, 0, mats(5), 0, num_nucs(5) as Long);	
		// Rail.copy(mats6, 0, mats(6), 0, num_nucs(6) as Long);	
		// Rail.copy(mats7, 0, mats(7), 0, num_nucs(7) as Long);	
		// Rail.copy(mats8, 0, mats(8), 0, num_nucs(8) as Long);	
		// Rail.copy(mats9, 0, mats(9), 0, num_nucs(9) as Long);	
		// Rail.copy(mats10, 0, mats(10), 0, num_nucs(10) as Long);	
		// Rail.copy(mats11, 0, mats(11), 0, num_nucs(11) as Long);	

		val mats:Rail[Rail[Int]];
		
		// H-M large v small dependency
		if (n_isotopes == 68)
			mats = mats_Sml;	
		else
			mats = mats_Lrg;

		// test
		if (false) {
			for (var i:Long = 0; i < mats.size; ++i) {
				val mats_i = mats(i);
				for (var j:Long = 0; j < mats_i.size; ++j) {
					Console.OUT.printf("material %d - Nuclide %d: %d\n", i, j, mats_i(j));
				}
			}
		}

		return mats;
	}
	
	
	// Creates a randomized array of 'concentrations' of nuclides in each mat
	public static def load_concs(num_nucs:Rail[Int]):Rail[Rail[Double]] {
		
		val concs = new Rail[Rail[Double]](num_nucs.size, (i:Long)=>new Rail[Double](num_nucs(i), (Long)=>FakeRandom.rand()));
		
		// test
		if (false) {
			for (var i:Long = 0; i < concs.size; ++i) {
				val concs_i = concs(i);
				for (var j:Long = 0; j < concs_i.size; ++j) {
					Console.OUT.printf("concs[%d][%d] = %f\n", i, j, concs_i(j));
				}
			}
		}

		return concs;
	}


	// NOTE: immutable data
	private static val dist = [
	                           0.140,	// fuel
	                           0.052,	// cladding
	                           0.275,	// cold, borated water
	                           0.134,	// hot, borated water
	                           0.154,	// RPV
	                           0.064,	// Lower, radial reflector
	                           0.066,	// Upper reflector / top plate
	                           0.055,	// bottom plate
	                           0.008,	// bottom nozzle
	                           0.015,	// top nozzle
	                           0.025,	// top of fuel assemblies
	                           0.013	// bottom of fuel assemblies
	                           ];
	
	// picks a material based on a probabilistic distribution
	public static def pick_mat(seed:Cell[ULong]):Long {
		// I have a nice spreadsheet supporting these numbers. They are
		// the fractions (by volume) of material in the core. Not a 
		// *perfect* approximation of where XS lookups are going to occur,
		// but this will do a good job of biasing the system nonetheless.

		// Also could be argued that doing fractions by weight would be 
		// a better approximation, but volume does a good enough job for now.

		// NOTE: immutable data
		// val dist = new Rail[Double](12);
		// dist(0)  = 0.140;	// fuel
		// dist(1)  = 0.052;	// cladding
		// dist(2)  = 0.275;	// cold, borated water
		// dist(3)  = 0.134;	// hot, borated water
		// dist(4)  = 0.154;	// RPV
		// dist(5)  = 0.064;	// Lower, radial reflector
		// dist(6)  = 0.066;	// Upper reflector / top plate
		// dist(7)  = 0.055;	// bottom plate
		// dist(8)  = 0.008;	// bottom nozzle
		// dist(9)  = 0.015;	// top nozzle
		// dist(10) = 0.025;	// top of fuel assemblies
		// dist(11) = 0.013;	// bottom of fuel assemblies
		
		// val roll = FakeRandom.rand();
		val roll = XSutils.rn(seed);

		// makes a pick based on the distro
		for (var i:Long = 0; i < dist.size; ++i) {
			var running:Double = 0;
			for (var j:Long = i; j > 0; --j)
				running += dist(j);
			if (roll < running)
				return i;
		}

		return 0;
	}

}
