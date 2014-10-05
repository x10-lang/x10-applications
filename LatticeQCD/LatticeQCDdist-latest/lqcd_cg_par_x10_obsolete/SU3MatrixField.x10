import x10.io.File;
import x10.io.FileNotFoundException;

import ParallelComplexField;

import ParallelLattice;

import MyRand;

public class SU3MatrixField extends ParallelComplexField {
	def this(x : Long,y : Long,z : Long,t : Long,nid : Long)
	{
		super(x,y,z,t,3,3,4,nid);
	}

	def SetUnit()
	{
		for(i in 0..(nsite*Nfld-1)){
			v()(i*18     ) = 1.0;			v()(i*18 + 1 ) = 0.0;
			v()(i*18 + 2 ) = 0.0;			v()(i*18 + 3 ) = 0.0;
			v()(i*18 + 4 ) = 0.0;			v()(i*18 + 5 ) = 0.0;

			v()(i*18 + 6 ) = 0.0;			v()(i*18 + 7 ) = 0.0;
			v()(i*18 + 8 ) = 1.0;			v()(i*18 + 9 ) = 0.0;
			v()(i*18 + 10) = 0.0;			v()(i*18 + 11) = 0.0;

			v()(i*18 + 12) = 0.0;			v()(i*18 + 13) = 0.0;
			v()(i*18 + 14) = 0.0;			v()(i*18 + 15) = 0.0;
			v()(i*18 + 16) = 1.0;			v()(i*18 + 17) = 0.0;
		}
	}

	def LoadConf(fileName:String, pl : ParallelLattice)
	{
		val file = new File(fileName);
		val reader = file.openRead();
		var d : Double;
		var is : Long;

		val sx = pl.netPos()(0) * Nx;
		val ex = pl.netPos()(0) * Nx + Nx - 1;
		val sy = pl.netPos()(1) * Ny;
		val ey = pl.netPos()(1) * Ny + Ny - 1;
		val sz = pl.netPos()(2) * Nz;
		val ez = pl.netPos()(2) * Nz + Nz - 1;
		val st = pl.netPos()(3) * Nt;
		val et = pl.netPos()(3) * Nt + Nt - 1;

		is = 0;
		for(t in 0..(pl.Lt-1)){
			for(z in 0..(pl.Lz-1)){
				for(y in 0..(pl.Ly-1)){
					for(x in 0..(pl.Lx-1)){
						if(x >= sx && x <= ex && y >= sy && y <= ey && z >= sz && z <= ez && t >= st && t <= et){
							for(i in 0..3){
								for(idf in 0..17){
									d = Double.parse(reader.readLine().trim());
									v()((is + i*nsite)*18 + idf) = d;
								}
							}
							is = is + 1;
						}
						else{
							for(i in 0..(4*18-1)){
								d = Double.parse(reader.readLine().trim());
							}
						}
					}
				}
			}
		}
		reader.close();
	}



	def RandomConf(s : Long, pl : ParallelLattice)
	{
		var myrand : MyRand = new MyRand(s);
		var d : Double;
		var is : Long;

		val sx = pl.netPos()(0) * Nx;
		val ex = pl.netPos()(0) * Nx + Nx - 1;
		val sy = pl.netPos()(1) * Ny;
		val ey = pl.netPos()(1) * Ny + Ny - 1;
		val sz = pl.netPos()(2) * Nz;
		val ez = pl.netPos()(2) * Nz + Nz - 1;
		val st = pl.netPos()(3) * Nt;
		val et = pl.netPos()(3) * Nt + Nt - 1;

		is = 0;
		for(i in 0..3){
			for(t in 0..(pl.Lt-1)){
				for(z in 0..(pl.Lz-1)){
					for(y in 0..(pl.Ly-1)){
						for(x in 0..(pl.Lx-1)){
							if(x >= sx && x <= ex && y >= sy && y <= ey && z >= sz && z <= ez && t >= st && t <= et){
								for(idf in 0..17){
									d = myrand.get_double();
									v()(is) = d*2.0 - 1;
									is = is + 1;
								}
							}
							else{
								for(idf in 0..17){
									d = myrand.get_double();
								}
							}
						}
					}
				}
			}
		}
	}
}
