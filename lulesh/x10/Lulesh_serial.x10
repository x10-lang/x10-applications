//@StackAllocate val v = @StackAllocateUninitialized new T(...);



import x10.compiler.Inline;
import x10.io.FileWriter;
//import x10.compiler.StackAllocate;
//import x10.compiler.StackAllocateUninitialized;
//import x10.lang.annotations.FieldAnnotation;
//import x10.lang.annotations.StatementAnnotation;
import x10.util.Pair;
import x10.util.Timer;
import x10.io.File;
import x10.array.Array_2;

public static type real4 = float;
public static type real8 = double ;
public static type real10 = double;

public static type Index_t = int;
public static type Real_t = double;
public static type Int_t = int;

public class Lulesh_serial {

static val domain:Domain_serial = new Domain_serial();
static val LULESH_SHOW_PROGRESS = false;
static val LULESH_OUTPUT_FILE = false;
static val VolumeError = -1n;
static class VolumeException extends Exception {}
static val QStopError = -2n;
static class QStopException extends Exception {}

static val XI_M:Int_t =        0x003n;
static val XI_M_SYMM:Int_t =   0x001n;
static val XI_M_FREE:Int_t =   0x002n;

static val XI_P:Int_t =        0x00cn;
static val XI_P_SYMM:Int_t =   0x004n;
static val XI_P_FREE:Int_t =   0x008n;

static val ETA_M:Int_t =       0x030n;
static val ETA_M_SYMM:Int_t =  0x010n;
static val ETA_M_FREE:Int_t =  0x020n;

static val ETA_P:Int_t =       0x0c0n;
static val ETA_P_SYMM:Int_t =  0x040n;
static val ETA_P_FREE:Int_t =  0x080n;

static val ZETA_M:Int_t =      0x300n;
static val ZETA_M_SYMM:Int_t = 0x100n;
static val ZETA_M_FREE:Int_t = 0x200n;

static val ZETA_P:Int_t =      0xc00n;
static val ZETA_P_SYMM:Int_t = 0x400n;
static val ZETA_P_FREE:Int_t = 0x800n;

@Inline public static def SQRT(arg:float) { return Math.sqrtf(arg); }
@Inline public static def SQRT(arg:double) { return Math.sqrt(arg); }

@Inline public static def TimeIncrement(){
	var targetdt:Real_t = domain.stoptime() - domain.time();
	
	if((domain.dtfixed() <= 0.0 as Real_t) && (domain.cycle() != 0 as Int_t)){
		var ratio:Real_t;
		var olddt:Real_t = domain.deltatime();
		
		var newdt:Real_t = 1.0e+20 as Real_t;
		if(domain.dtcourant() < newdt){
			newdt = domain.dtcourant() / 2.0 as Real_t;
		}
		if(domain.dthydro() < newdt){
			newdt = domain.dthydro() * (2.0 as Real_t) / (3.0 as Real_t);
		}
		
		ratio = newdt / olddt;
		
		if(ratio >= 1.0 as Real_t){
			if(ratio < domain.deltatimemultlb()){
				newdt = olddt;
			}
			else if(ratio > domain.deltatimemultub()){
				newdt = olddt * domain.deltatimemultub();
			}
		}
		
		if(newdt > domain.dtmax()){
			newdt = domain.dtmax();
		}
		domain.m_deltatime = newdt;
	}
		
		if((targetdt > domain.deltatime()) && (targetdt < ((4.0 as Real_t) * domain.deltatime() / (3.0 as Real_t)))){
			targetdt = (2.0 as Real_t) * domain.deltatime() / (3.0 as Real_t);
		}
		
		if(targetdt < domain.deltatime()){
			domain.m_deltatime = targetdt;
		}
		
		domain.m_time += domain.deltatime();
		
		++domain.m_cycle;
}

@Inline public static def InitStressTermsForElems(var numElem:Index_t, var sigxx:Rail[Real_t], var sigyy:Rail[Real_t], var sigzz:Rail[Real_t]){
	for(var i:Index_t = 0n; i < numElem; ++i){
		sigxx(i) = sigyy(i) = sigzz(i) = - domain.p(i) - domain.q(i);
	}
}

@Inline public static def CalcElemShapeFunctionDerivatives(val x:Rail[Real_t], val y:Rail[Real_t], val z:Rail[Real_t], val b:Array_2[Real_t], val p:int, val volume:Rail[Real_t]){
	val x0:Real_t = x(0);	val x1:Real_t = x(1);
	val x2:Real_t = x(2);	val x3:Real_t = x(3);
	val x4:Real_t = x(4);	val x5:Real_t = x(5);
	val x6:Real_t = x(6);	val x7:Real_t = x(7);
	
	val y0:Real_t = y(0);	val y1:Real_t = y(1);
	val y2:Real_t = y(2);	val y3:Real_t = y(3);
	val y4:Real_t = y(4);	val y5:Real_t = y(5);
	val y6:Real_t = y(6);	val y7:Real_t = y(7);
	
	val z0:Real_t = z(0);	val z1:Real_t = z(1);
	val z2:Real_t = z(2);	val z3:Real_t = z(3);
	val z4:Real_t = z(4);	val z5:Real_t = z(5);
	val z6:Real_t = z(6);	val z7:Real_t = z(7);
	
	var fjxxi:Real_t, fjxet:Real_t, fjxze:Real_t;
	var fjyxi:Real_t, fjyet:Real_t, fjyze:Real_t;
	var fjzxi:Real_t, fjzet:Real_t, fjzze:Real_t;
	var cjxxi:Real_t, cjxet:Real_t, cjxze:Real_t;
	var cjyxi:Real_t, cjyet:Real_t, cjyze:Real_t;
	var cjzxi:Real_t, cjzet:Real_t, cjzze:Real_t;
	
	fjxxi = .125 * ( (x6-x0) + (x5-x3) - (x7-x1) - (x4-x2) );
	fjxet = .125 * ( (x6-x0) - (x5-x3) + (x7-x1) - (x4-x2) );
	fjxze = .125 * ( (x6-x0) + (x5-x3) + (x7-x1) + (x4-x2) );
	
	fjyxi = .125 * ( (y6-y0) + (y5-y3) - (y7-y1) - (y4-y2) );
	fjyet = .125 * ( (y6-y0) - (y5-y3) + (y7-y1) - (y4-y2) );
	fjyze = .125 * ( (y6-y0) + (y5-y3) + (y7-y1) + (y4-y2) );
	
	fjzxi = .125 * ( (z6-z0) + (z5-z3) - (z7-z1) - (z4-z2) );
	fjzet = .125 * ( (z6-z0) - (z5-z3) + (z7-z1) - (z4-z2) );
	fjzze = .125 * ( (z6-z0) + (z5-z3) + (z7-z1) + (z4-z2) );
	
	cjxxi =   (fjyet * fjzze) - (fjzet * fjyze);
	cjxet = - (fjyxi * fjzze) + (fjzxi * fjyze);
	cjxze =   (fjyxi * fjzet) - (fjzxi * fjyet);
	
	cjyxi = - (fjxet * fjzze) + (fjzet * fjxze);
	cjyet =   (fjxxi * fjzze) - (fjzxi * fjxze);
	cjyze = - (fjxxi * fjzet) + (fjzxi * fjxet);
	
	cjzxi =   (fjxet * fjyze) - (fjyet * fjxze);
	cjzet = - (fjxxi * fjyze) + (fjyxi * fjxze);
	cjzze =   (fjxxi * fjyet) - (fjyxi * fjxet);
	
	b(0,0) = - cjxxi - cjxet - cjxze;
	b(0,1) =   cjxxi - cjxet - cjxze;
	b(0,2) =   cjxxi + cjxet - cjxze;
	b(0,3) = - cjxxi + cjxet - cjxze;
	b(0,4) = -b(0,2);
	b(0,5) = -b(0,3);
	b(0,6) = -b(0,0);
	b(0,7) = -b(0,1);
	
	b(1,0) = - cjyxi - cjyet - cjyze;
	b(1,1) =   cjyxi - cjyet - cjyze;
	b(1,2) =   cjyxi + cjyet - cjyze;
	b(1,3) = - cjyxi + cjyet - cjyze;
	b(1,4) = -b(1,2);
	b(1,5) = -b(1,3);
	b(1,6) = -b(1,0);
	b(1,7) = -b(1,1);
	
	b(2,0) = - cjzxi - cjzet - cjzze;
	b(2,1) =   cjzxi - cjzet - cjzze;
	b(2,2) =   cjzxi + cjzet - cjzze;
	b(2,3) = - cjzxi + cjzet - cjzze;
	b(2,4) = -b(2,2);
	b(2,5) = -b(2,3);
	b(2,6) = -b(2,0);
	b(2,7) = -b(2,1);
	
	volume(p) = (8. as Real_t) * ( fjxet * cjxet + fjyet * cjyet + fjzet * cjzet);
}

@Inline public static def SumElemFaceNormal(val p0:int, val p1:int, val p2:int, val p3:int, var normalXYZ:Array_2[Real_t],
 												  val x:Rail[Real_t], val y:Rail[Real_t], val z:Rail[Real_t])
{
	
	var bisectX0:Real_t = (0.5 as Real_t) * (x(p3) + x(p2) - x(p1) - x(p0));
	//Console.OUT.printf("x(1)****= %0.20f, x(2) = %0.20f", x(1), x(2));
	var bisectY0:Real_t = (0.5 as Real_t) * (y(p3) + y(p2) - y(p1) - y(p0));
	var bisectZ0:Real_t = (0.5 as Real_t) * (z(p3) + z(p2) - z(p1) - z(p0));
	var bisectX1:Real_t = (0.5 as Real_t) * (x(p2) + x(p1) - x(p3) - x(p0));
	var bisectY1:Real_t = (0.5 as Real_t) * (y(p2) + y(p1) - y(p3) - y(p0));
	var bisectZ1:Real_t = (0.5 as Real_t) * (z(p2) + z(p1) - z(p3) - z(p0));
	var areaX:Real_t = (0.25 as Real_t) * (bisectY0 * bisectZ1 - bisectZ0 * bisectY1);
	var areaY:Real_t = (0.25 as Real_t) * (bisectZ0 * bisectX1 - bisectX0 * bisectZ1);
	var areaZ:Real_t = (0.25 as Real_t) * (bisectX0 * bisectY1 - bisectY0 * bisectX1);
	
	normalXYZ(0,p0) += areaX;
	normalXYZ(0,p1) += areaX;
	normalXYZ(0,p2) += areaX;
	normalXYZ(0,p3) += areaX;
	
	normalXYZ(1,p0) += areaY;
	normalXYZ(1,p1) += areaY;
	normalXYZ(1,p2) += areaY;
	normalXYZ(1,p3) += areaY;
	
	normalXYZ(2,p0) += areaZ;
	normalXYZ(2,p1) += areaZ;
	normalXYZ(2,p2) += areaZ;
	normalXYZ(2,p3) += areaZ;
}

@Inline public static def CalcElemNodeNormals(var pfxyz:Array_2[Real_t],
												    val x:Rail[Real_t],
												    val y:Rail[Real_t],
												    val z:Rail[Real_t])
{
	
	for(var i:Index_t = 0n; i < 8n; ++i){
		pfxyz(0,i) = 0.0 as Real_t;
		pfxyz(1,i) = 0.0 as Real_t;
		pfxyz(2,i) = 0.0 as Real_t;
	}
	
	//Console.OUT.printf("x(1)****= %0.20f, x(2) = %0.20f", x(1), x(2));
	SumElemFaceNormal(0n, 1n, 2n, 3n, pfxyz, x, y, z);
	
	SumElemFaceNormal(0n, 4n, 5n, 1n, pfxyz, x, y, z);
	
	SumElemFaceNormal(1n, 5n, 6n, 2n, pfxyz, x, y, z);
	
	SumElemFaceNormal(2n, 6n, 7n, 3n, pfxyz, x, y, z);
	
	SumElemFaceNormal(3n, 7n, 4n, 0n, pfxyz, x, y, z);
	
	SumElemFaceNormal(4n, 7n, 6n, 5n, pfxyz, x, y, z);
	
}

@Inline public static def SumElemStressesToNodeForces(val B:Array_2[Real_t],
														     val stress_xx:Real_t,
														     val stress_yy:Real_t,
														     val stress_zz:Real_t,
														     val fx:Rail[Real_t],
														     val fy:Rail[Real_t],
														     val fz:Rail[Real_t])
{
	var pfx0:Real_t = B(0,0);	var pfx1:Real_t = B(0,1);
	var pfx2:Real_t = B(0,2);	var pfx3:Real_t = B(0,3);
	var pfx4:Real_t = B(0,4);	var pfx5:Real_t = B(0,5);
	var pfx6:Real_t = B(0,6);	var pfx7:Real_t = B(0,7);
	
	var pfy0:Real_t = B(1,0);	var pfy1:Real_t = B(1,1);
	var pfy2:Real_t = B(1,2);	var pfy3:Real_t = B(1,3);
	var pfy4:Real_t = B(1,4);	var pfy5:Real_t = B(1,5);
	var pfy6:Real_t = B(1,6);	var pfy7:Real_t = B(1,7);
	
	var pfz0:Real_t = B(2,0);	var pfz1:Real_t = B(2,1);
	var pfz2:Real_t = B(2,2);	var pfz3:Real_t = B(2,3);
	var pfz4:Real_t = B(2,4);	var pfz5:Real_t = B(2,5);
	var pfz6:Real_t = B(2,6);	var pfz7:Real_t = B(2,7);
	
	fx(0) = -( stress_xx * pfx0 );
	fx(1) = -( stress_xx * pfx1 );
	fx(2) = -( stress_xx * pfx2 );
	fx(3) = -( stress_xx * pfx3 );
	fx(4) = -( stress_xx * pfx4 );
	fx(5) = -( stress_xx * pfx5 );
	fx(6) = -( stress_xx * pfx6 );
	fx(7) = -( stress_xx * pfx7 );
	
	fy(0) = -( stress_yy * pfy0 );
	fy(1) = -( stress_yy * pfy1 );
	fy(2) = -( stress_yy * pfy2 );
	fy(3) = -( stress_yy * pfy3 );
	fy(4) = -( stress_yy * pfy4 );
	fy(5) = -( stress_yy * pfy5 );
	fy(6) = -( stress_yy * pfy6 );
	fy(7) = -( stress_yy * pfy7 );
	
	fz(0) = -( stress_zz * pfz0 );
	fz(1) = -( stress_zz * pfz1 );
	fz(2) = -( stress_zz * pfz2 );
	fz(3) = -( stress_zz * pfz3 );
	fz(4) = -( stress_zz * pfz4 );
	fz(5) = -( stress_zz * pfz5 );
	fz(6) = -( stress_zz * pfz6 );
	fz(7) = -( stress_zz * pfz7 );
}

@Inline public static def IntegrateStressForElems(var numElem:Index_t,
												        var sigxx:Rail[Real_t], var sigyy:Rail[Real_t], var sigzz:Rail[Real_t],
												        var determ:Rail[Real_t])
{
	var B:Array_2[Real_t] = new Array_2[Real_t](3,8);
	var x_local:Rail[Real_t] = new Rail[Real_t](8);
	var y_local:Rail[Real_t] = new Rail[Real_t](8);
	var z_local:Rail[Real_t] = new Rail[Real_t](8);
	var fx_local:Rail[Real_t] = new Rail[Real_t](8);
	var fy_local:Rail[Real_t] = new Rail[Real_t](8);
	var fz_local:Rail[Real_t] = new Rail[Real_t](8);
	
	for(var k:Index_t = 0n; k < numElem; ++k){
		val elemNodes = domain.nodelist();
		
		for(var lnode:Index_t = 0n; lnode < 8n; ++lnode){
			var gnode:Index_t = elemNodes(k,lnode);
			x_local(lnode) = domain.x(gnode);
			y_local(lnode) = domain.y(gnode);
			z_local(lnode) = domain.z(gnode);
		}
		
		CalcElemShapeFunctionDerivatives(x_local,y_local, z_local, B, k, determ);
		
		CalcElemNodeNormals(B, x_local, y_local, z_local);

		SumElemStressesToNodeForces(B, sigxx(k), sigyy(k), sigzz(k), fx_local, fy_local, fz_local);
				
		for(var lnode:Index_t = 0n; lnode < 8n; ++lnode){
			val gnode:Index_t = elemNodes(k,lnode);
			domain.m_fx(gnode) += fx_local(lnode);
			domain.m_fy(gnode) += fy_local(lnode);
			domain.m_fz(gnode) += fz_local(lnode);
		}
	}
}

@Inline public static def CollectDomainNodesToElemNodes(val i:Index_t, val elemToNode:Array_2[Index_t],
								                            var elemX:Rail[Real_t],
								                            var elemY:Rail[Real_t],
								                            var elemZ:Rail[Real_t])
{
	var nd0i:Index_t = elemToNode(i,0);
	var nd1i:Index_t = elemToNode(i,1);
	var nd2i:Index_t = elemToNode(i,2);
	var nd3i:Index_t = elemToNode(i,3);
	var nd4i:Index_t = elemToNode(i,4);
	var nd5i:Index_t = elemToNode(i,5);
	var nd6i:Index_t = elemToNode(i,6);
	var nd7i:Index_t = elemToNode(i,7);
	
	elemX(0) = domain.x(nd0i);
	elemX(1) = domain.x(nd1i);
	elemX(2) = domain.x(nd2i);
	elemX(3) = domain.x(nd3i);
	elemX(4) = domain.x(nd4i);
	elemX(5) = domain.x(nd5i);
	elemX(6) = domain.x(nd6i);
	elemX(7) = domain.x(nd7i);
	
	elemY(0) = domain.y(nd0i);
	elemY(1) = domain.y(nd1i);
	elemY(2) = domain.y(nd2i);
	elemY(3) = domain.y(nd3i);
	elemY(4) = domain.y(nd4i);
	elemY(5) = domain.y(nd5i);
	elemY(6) = domain.y(nd6i);
	elemY(7) = domain.y(nd7i);
	
	elemZ(0) = domain.z(nd0i);
	elemZ(1) = domain.z(nd1i);
	elemZ(2) = domain.z(nd2i);
	elemZ(3) = domain.z(nd3i);
	elemZ(4) = domain.z(nd4i);
	elemZ(5) = domain.z(nd5i);
	elemZ(6) = domain.z(nd6i);
	elemZ(7) = domain.z(nd7i);
}

@Inline public static def VoluDer(val x0:Real_t, val x1:Real_t, val x2:Real_t,
						             val x3:Real_t, val x4:Real_t, val x5:Real_t,
						             val y0:Real_t, val y1:Real_t, val y2:Real_t,
						             val y3:Real_t, val y4:Real_t, val y5:Real_t,
						             val z0:Real_t, val z1:Real_t, val z2:Real_t,
						             val z3:Real_t, val z4:Real_t, val z5:Real_t,
						             var dvdx:Rail[Real_t], var dvdy:Rail[Real_t], var dvdz:Rail[Real_t], val t:Index_t)
{
	val twelfth:Real_t = (1.0 as Real_t) / (12.0 as Real_t);
	
	dvdx(t) = 
		(y1 + y2) * (z0 + z1) - (y0 + y1) * (z1 + z2) +
		(y0 + y4) * (z3 + z4) - (y3 + y4) * (z0 + z4) -
		(y2 + y5) * (z3 + z5) + (y3 + y5) * (z2 + z5);
	dvdy(t) = 
		- (x1 + x2) * (z0 + z1) + (x0 + x1) * (z1 + z2) -
		(x0 + x4) * (z3 + z4) + (x3 + x4) * (z0 + z4) +
		(x2 + x5) * (z3 + z5) - (x3 + x5) * (z2 + z5);
	dvdz(t) = 
		- (y1 + y2) * (x0 + x1) + (y0 + y1) * (x1 + x2) -
		(y0 + y4) * (x3 + x4) + (y3 + y4) * (x0 + x4) +
		(y2 + y5) * (x3 + x5) - (y3 + y5) * (x2 + x5);
	
	dvdx(t) *= twelfth;
	dvdy(t) *= twelfth;
	dvdz(t) *= twelfth;
}

@Inline public static def CalcElemVolumeDerivative(var dvdx:Rail[Real_t],
										                var dvdy:Rail[Real_t],
										                var dvdz:Rail[Real_t],
										                val x:Rail[Real_t],
										                val y:Rail[Real_t],
										                val z:Rail[Real_t])
{
	//for giving arguments to VoluDer
	/*
	var dvdx_tmp:Rail[Rail[Real_t]] = new Rail[Rail[Real_t]]();
	var dvdy_tmp:Rail[Rail[Real_t]] = new Rail[Rail[Real_t]]();
	var dvdz_tmp:Rail[Rail[Real_t]] = new Rail[Rail[Real_t]]();
	

	for(var i:Index_t = 0n; i < 8n; ++i){
		(dvdx_tmp(i) as Rail[Real_t])(0) = dvdx(i);
		(dvdy_tmp(i) as Rail[Real_t])(0) = dvdy(i);
		(dvdz_tmp(i) as Rail[Real_t])(0) = dvdz(i);
	}
	 */
		
	VoluDer(x(1), x(2), x(3), x(4), x(5), x(7),
			 y(1), y(2), y(3), y(4), y(5), y(7),
			 z(1), z(2), z(3), z(4), z(5), z(7),
			 dvdx, dvdy, dvdz, 0n);
	VoluDer(x(0), x(1), x(2), x(7), x(4), x(6),
			y(0), y(1), y(2), y(7), y(4), y(6),
			z(0), z(1), z(2), z(7), z(4), z(6),
			dvdx, dvdy, dvdz, 3n);	
	VoluDer(x(3), x(0), x(1), x(6), x(7), x(5),
			y(3), y(0), y(1), y(6), y(7), y(5),
			z(3), z(0), z(1), z(6), z(7), z(5),
			dvdx, dvdy, dvdz, 2n);
	VoluDer(x(2), x(3), x(0), x(5), x(6), x(4),
			y(2), y(3), y(0), y(5), y(6), y(4),
			z(2), z(3), z(0), z(5), z(6), z(4),
			dvdx, dvdy, dvdz, 1n);
	VoluDer(x(7), x(6), x(5), x(0), x(3), x(1),
			y(7), y(6), y(5), y(0), y(3), y(1),
			z(7), z(6), z(5), z(0), z(3), z(1),
			dvdx, dvdy, dvdz, 4n);
	VoluDer(x(4), x(7), x(6), x(1), x(0), x(2),
			y(4), y(7), y(6), y(1), y(0), y(2),
			z(4), z(7), z(6), z(1), z(0), z(2),
			dvdx, dvdy, dvdz, 5n);
	VoluDer(x(5), x(4), x(7), x(2), x(1), x(3),
			y(5), y(4), y(7), y(2), y(1), y(3),
			z(5), z(4), z(7), z(2), z(1), z(3),
			dvdx, dvdy, dvdz, 6n);
	VoluDer(x(6), x(5), x(4), x(3), x(2), x(0),
			y(6), y(5), y(4), y(3), y(2), y(0),
			z(6), z(5), z(4), z(3), z(2), z(0),
			dvdx, dvdy, dvdz, 7n);
}

@Inline public static def CalcElemFBHourglassForce(var xd:Rail[Real_t], var yd:Rail[Real_t], var zd:Rail[Real_t], var hourgam0:Rail[Real_t],
												         var hourgam1:Rail[Real_t], var hourgam2:Rail[Real_t], var hourgam3:Rail[Real_t],
												         var hourgam4:Rail[Real_t], var hourgam5:Rail[Real_t], var hourgam6:Rail[Real_t],
												         var hourgam7:Rail[Real_t], var coefficient:Real_t,
												         var hgfx:Rail[Real_t], var hgfy:Rail[Real_t], var hgfz:Rail[Real_t])
{
	val i00:Index_t = 0n;
	val i01:Index_t = 1n;
	val i02:Index_t = 2n;
	val i03:Index_t = 3n;
	
	var h00:Real_t = 
		hourgam0(i00) * xd(0) + hourgam1(i00) * xd(1) +
		hourgam2(i00) * xd(2) + hourgam3(i00) * xd(3) +
		hourgam4(i00) * xd(4) + hourgam5(i00) * xd(5) +
		hourgam6(i00) * xd(6) + hourgam7(i00) * xd(7);
	
	var h01:Real_t =
		hourgam0(i01) * xd(0) + hourgam1(i01) * xd(1) +
		hourgam2(i01) * xd(2) + hourgam3(i01) * xd(3) +
		hourgam4(i01) * xd(4) + hourgam5(i01) * xd(5) +
		hourgam6(i01) * xd(6) + hourgam7(i01) * xd(7);
	
	var h02:Real_t =
		hourgam0(i02) * xd(0) + hourgam1(i02) * xd(1) +
		hourgam2(i02) * xd(2) + hourgam3(i02) * xd(3) +
		hourgam4(i02) * xd(4) + hourgam5(i02) * xd(5) +
		hourgam6(i02) * xd(6) + hourgam7(i02) * xd(7);
	
	var h03:Real_t =
		hourgam0(i03) * xd(0) + hourgam1(i03) * xd(1) +
		hourgam2(i03) * xd(2) + hourgam3(i03) * xd(3) +
		hourgam4(i03) * xd(4) + hourgam5(i03) * xd(5) +
		hourgam6(i03) * xd(6) + hourgam7(i03) * xd(7);
	
	hgfx(0) = coefficient * (hourgam0(i00) * h00 + hourgam0(i01) * h01 +
			                  hourgam0(i02) * h02 + hourgam0(i03) * h03);
	if(hgfx(0) != 0d){
		//Console.OUT.printf("hgfx 3333****=%0.20f", hgfx(0));
	}
	
	hgfx(1) = coefficient * (hourgam1(i00) * h00 + hourgam1(i01) * h01 +
			                  hourgam1(i02) * h02 + hourgam1(i03) * h03);
	
	hgfx(2) = coefficient * (hourgam2(i00) * h00 + hourgam2(i01) * h01 +
			                  hourgam2(i02) * h02 + hourgam2(i03) * h03);
	
	hgfx(3) = coefficient * (hourgam3(i00) * h00 + hourgam3(i01) * h01 +
			                  hourgam3(i02) * h02 + hourgam3(i03) * h03);
	
	hgfx(4) = coefficient * (hourgam4(i00) * h00 + hourgam4(i01) * h01 +
			                  hourgam4(i02) * h02 + hourgam4(i03) * h03);
	
	hgfx(5) = coefficient * (hourgam5(i00) * h00 + hourgam5(i01) * h01 +
			                  hourgam5(i02) * h02 + hourgam5(i03) * h03);
	
	hgfx(6) = coefficient * (hourgam6(i00) * h00 + hourgam6(i01) * h01 +
			                  hourgam6(i02) * h02 + hourgam6(i03) * h03);
	
	hgfx(7) = coefficient * (hourgam7(i00) * h00 + hourgam7(i01) * h01 +
			                  hourgam7(i02) * h02 + hourgam7(i03) * h03);
	
	h00 =
		hourgam0(i00) * yd(0) + hourgam1(i00) * yd(1) +
		hourgam2(i00) * yd(2) + hourgam3(i00) * yd(3) +
		hourgam4(i00) * yd(4) + hourgam5(i00) * yd(5) +
		hourgam6(i00) * yd(6) + hourgam7(i00) * yd(7);
	
	h01 =
		hourgam0(i01) * yd(0) + hourgam1(i01) * yd(1) +
		hourgam2(i01) * yd(2) + hourgam3(i01) * yd(3) +
		hourgam4(i01) * yd(4) + hourgam5(i01) * yd(5) +
		hourgam6(i01) * yd(6) + hourgam7(i01) * yd(7);
	
	h02 =
		hourgam0(i02) * yd(0) + hourgam1(i02) * yd(1) +
		hourgam2(i02) * yd(2) + hourgam3(i02) * yd(3) +
		hourgam4(i02) * yd(4) + hourgam5(i02) * yd(5) +
		hourgam6(i02) * yd(6) + hourgam7(i02) * yd(7);
	
	h03 =
		hourgam0(i03) * yd(0) + hourgam1(i03) * yd(1) +
		hourgam2(i03) * yd(2) + hourgam3(i03) * yd(3) +
		hourgam4(i03) * yd(4) + hourgam5(i03) * yd(5) +
		hourgam6(i03) * yd(6) + hourgam7(i03) * yd(7);
	
	hgfy(0) = coefficient * (hourgam0(i00) * h00 + hourgam0(i01) * h01 +
			                  hourgam0(i02) * h02 + hourgam0(i03) * h03);
	
	hgfy(1) = coefficient * (hourgam1(i00) * h00 + hourgam1(i01) * h01 +
			                  hourgam1(i02) * h02 + hourgam1(i03) * h03);
	
	hgfy(2) = coefficient * (hourgam2(i00) * h00 + hourgam2(i01) * h01 +
			                  hourgam2(i02) * h02 + hourgam2(i03) * h03);
	
	hgfy(3) = coefficient * (hourgam3(i00) * h00 + hourgam3(i01) * h01 +
			                  hourgam3(i02) * h02 + hourgam3(i03) * h03);
	
	hgfy(4) = coefficient * (hourgam4(i00) * h00 + hourgam4(i01) * h01 +
			                  hourgam4(i02) * h02 + hourgam4(i03) * h03);
	
	hgfy(5) = coefficient * (hourgam5(i00) * h00 + hourgam5(i01) * h01 +
			                  hourgam5(i02) * h02 + hourgam5(i03) * h03);
	
	hgfy(6) = coefficient * (hourgam6(i00) * h00 + hourgam6(i01) * h01 +
			                  hourgam6(i02) * h02 + hourgam6(i03) * h03);
	
	hgfy(7) = coefficient * (hourgam7(i00) * h00 + hourgam7(i01) * h01 +
			                  hourgam7(i02) * h02 + hourgam7(i03) * h03);
	
	h00 =
		hourgam0(i00) * zd(0) + hourgam1(i00) * zd(1) +
		hourgam2(i00) * zd(2) + hourgam3(i00) * zd(3) +
		hourgam4(i00) * zd(4) + hourgam5(i00) * zd(5) +
		hourgam6(i00) * zd(6) + hourgam7(i00) * zd(7);
	
	h01 =
		hourgam0(i01) * zd(0) + hourgam1(i01) * zd(1) +
		hourgam2(i01) * zd(2) + hourgam3(i01) * zd(3) +
		hourgam4(i01) * zd(4) + hourgam5(i01) * zd(5) +
		hourgam6(i01) * zd(6) + hourgam7(i01) * zd(7);
	
	h02 =
		hourgam0(i02) * zd(0) + hourgam1(i02) * zd(1) +
		hourgam2(i02) * zd(2) + hourgam3(i02) * zd(3) +
		hourgam4(i02) * zd(4) + hourgam5(i02) * zd(5) +
		hourgam6(i02) * zd(6) + hourgam7(i02) * zd(7);
	
	h03 =
		hourgam0(i03) * zd(0) + hourgam1(i03) * zd(1) +
		hourgam2(i03) * zd(2) + hourgam3(i03) * zd(3) +
		hourgam4(i03) * zd(4) + hourgam5(i03) * zd(5) +
		hourgam6(i03) * zd(6) + hourgam7(i03) * zd(7);
	
	hgfz(0) = coefficient * (hourgam0(i00) * h00 + hourgam0(i01) * h01 +
			                  hourgam0(i02) * h02 + hourgam0(i03) * h03);
	
	hgfz(1) = coefficient * (hourgam1(i00) * h00 + hourgam1(i01) * h01 +
			                  hourgam1(i02) * h02 + hourgam1(i03) * h03);
	
	hgfz(2) = coefficient * (hourgam2(i00) * h00 + hourgam2(i01) * h01 +
			                  hourgam2(i02) * h02 + hourgam2(i03) * h03);
	
	hgfz(3) = coefficient * (hourgam3(i00) * h00 + hourgam3(i01) * h01 +
			                  hourgam3(i02) * h02 + hourgam3(i03) * h03);
	
	hgfz(4) = coefficient * (hourgam4(i00) * h00 + hourgam4(i01) * h01 +
			                  hourgam4(i02) * h02 + hourgam4(i03) * h03);
	
	hgfz(5) = coefficient * (hourgam5(i00) * h00 + hourgam5(i01) * h01 +
			                  hourgam5(i02) * h02 + hourgam5(i03) * h03);
	
	hgfz(6) = coefficient * (hourgam6(i00) * h00 + hourgam6(i01) * h01 +
			                  hourgam6(i02) * h02 + hourgam6(i03) * h03);
	
	hgfz(7) = coefficient * (hourgam7(i00) * h00 + hourgam7(i01) * h01 +
			                  hourgam7(i02) * h02 + hourgam7(i03) * h03);
}

@Inline public static def CalcFBHourglassForceForElems(var determ:Rail[Real_t],
		                                                var x8n:Rail[Real_t], var y8n:Rail[Real_t], var z8n:Rail[Real_t],
		                                                var dvdx:Rail[Real_t], var dvdy:Rail[Real_t], var dvdz:Rail[Real_t],
		                                                var hourg:Real_t)
{
	var numElem:Index_t = domain.numElem();
	
	var hgfx:Rail[Real_t] = new Rail[Real_t](8);
	var hgfy:Rail[Real_t] = new Rail[Real_t](8);
	var hgfz:Rail[Real_t] = new Rail[Real_t](8);
	
   var coefficient:Real_t;
   
   var gamma:Array_2[Real_t] = new Array_2[Real_t](4,8);
   var hourgam0:Rail[Real_t] = new Rail[Real_t](4);
   var hourgam1:Rail[Real_t] = new Rail[Real_t](4);
   var hourgam2:Rail[Real_t] = new Rail[Real_t](4);
   var hourgam3:Rail[Real_t] = new Rail[Real_t](4);
   var hourgam4:Rail[Real_t] = new Rail[Real_t](4);
   var hourgam5:Rail[Real_t] = new Rail[Real_t](4);
   var hourgam6:Rail[Real_t] = new Rail[Real_t](4);
   var hourgam7:Rail[Real_t] = new Rail[Real_t](4);
   
   var xd1:Rail[Real_t] = new Rail[Real_t](8);
   var yd1:Rail[Real_t] = new Rail[Real_t](8);
   var zd1:Rail[Real_t] = new Rail[Real_t](8);
   
   gamma(0,0) =  1. as Real_t;
   gamma(0,1) =  1. as Real_t;
   gamma(0,2) = -1. as Real_t;
   gamma(0,3) = -1. as Real_t;
   gamma(0,4) = -1. as Real_t;
   gamma(0,5) = -1. as Real_t;
   gamma(0,6) =  1. as Real_t;
   gamma(0,7) =  1. as Real_t;
   gamma(1,0) =  1. as Real_t;
   gamma(1,1) = -1. as Real_t;
   gamma(1,2) = -1. as Real_t;
   gamma(1,3) =  1. as Real_t;
   gamma(1,4) = -1. as Real_t;
   gamma(1,5) =  1. as Real_t;
   gamma(1,6) =  1. as Real_t;
   gamma(1,7) = -1. as Real_t;
   gamma(2,0) =  1. as Real_t;
   gamma(2,1) = -1. as Real_t;
   gamma(2,2) =  1. as Real_t;
   gamma(2,3) = -1. as Real_t;
   gamma(2,4) =  1. as Real_t;
   gamma(2,5) = -1. as Real_t;
   gamma(2,6) =  1. as Real_t;
   gamma(2,7) = -1. as Real_t;
   gamma(3,0) = -1. as Real_t;
   gamma(3,1) =  1. as Real_t;
   gamma(3,2) = -1. as Real_t;
   gamma(3,3) =  1. as Real_t;
   gamma(3,4) =  1. as Real_t;
   gamma(3,5) = -1. as Real_t;
   gamma(3,6) =  1. as Real_t;
   gamma(3,7) = -1. as Real_t;
   
   for(var i2:Index_t = 0n; i2 < numElem; ++i2){
      val elemToNode = domain.nodelist();
      var i3:Index_t = 8n * i2;
      var volinv:Real_t = (1.0 as Real_t) / determ(i2);
      var ss1:Real_t, mass1:Real_t, volume13:Real_t;
      for(var i1:Index_t = 0n; i1 < 4; ++i1){
    	  var hourmodx:Real_t = 
    		  x8n(i3) * gamma(i1,0) + x8n(i3+1) * gamma(i1,1) +
    		  x8n(i3+2) * gamma(i1,2) + x8n(i3+3) * gamma(i1,3) +
    		  x8n(i3+4) * gamma(i1,4) + x8n(i3+5) * gamma(i1,5) +
    		  x8n(i3+6) * gamma(i1,6) + x8n(i3+7) * gamma(i1,7);
    	  
    	  var hourmody:Real_t = 
    		  y8n(i3) * gamma(i1,0) + y8n(i3+1) * gamma(i1,1) +
    		  y8n(i3+2) * gamma(i1,2) + y8n(i3+3) * gamma(i1,3) +
    		  y8n(i3+4) * gamma(i1,4) + y8n(i3+5) * gamma(i1,5) +
    		  y8n(i3+6) * gamma(i1,6) + y8n(i3+7) * gamma(i1,7);
    	  
    	  var hourmodz:Real_t = 
    		  z8n(i3) * gamma(i1,0) + z8n(i3+1) * gamma(i1,1) +
    		  z8n(i3+2) * gamma(i1,2) + z8n(i3+3) * gamma(i1,3) +
    		  z8n(i3+4) * gamma(i1,4) + z8n(i3+5) * gamma(i1,5) +
    		  z8n(i3+6) * gamma(i1,6) + z8n(i3+7) * gamma(i1,7);
    	  
    	  hourgam0(i1) = gamma(i1,0) - volinv * (dvdx(i3) * hourmodx + dvdy(i3) * hourmody + dvdz(i3) * hourmodz);
    	  hourgam1(i1) = gamma(i1,1) - volinv * (dvdx(i3+1) * hourmodx + dvdy(i3+1) * hourmody + dvdz(i3+1) * hourmodz);
    	  hourgam2(i1) = gamma(i1,2) - volinv * (dvdx(i3+2) * hourmodx + dvdy(i3+2) * hourmody + dvdz(i3+2) * hourmodz);
    	  hourgam3(i1) = gamma(i1,3) - volinv * (dvdx(i3+3) * hourmodx + dvdy(i3+3) * hourmody + dvdz(i3+3) * hourmodz);
    	  hourgam4(i1) = gamma(i1,4) - volinv * (dvdx(i3+4) * hourmodx + dvdy(i3+4) * hourmody + dvdz(i3+4) * hourmodz);
    	  hourgam5(i1) = gamma(i1,5) - volinv * (dvdx(i3+5) * hourmodx + dvdy(i3+5) * hourmody + dvdz(i3+5) * hourmodz);
    	  hourgam6(i1) = gamma(i1,6) - volinv * (dvdx(i3+6) * hourmodx + dvdy(i3+6) * hourmody + dvdz(i3+6) * hourmodz);
    	  hourgam7(i1) = gamma(i1,7) - volinv * (dvdx(i3+7) * hourmodx + dvdy(i3+7) * hourmody + dvdz(i3+7) * hourmodz);
      }
      ss1 = domain.ss(i2);
      mass1 = domain.elemMass(i2);
      volume13 = Math.cbrt(determ(i2));
      
      val n0si2 = elemToNode(i2, 0);
      val n1si2 = elemToNode(i2, 1);
      val n2si2 = elemToNode(i2, 2);
      val n3si2 = elemToNode(i2, 3);
      val n4si2 = elemToNode(i2, 4);
      val n5si2 = elemToNode(i2, 5);
      val n6si2 = elemToNode(i2, 6);
      val n7si2 = elemToNode(i2, 7);
      
      xd1(0) = domain.xd(n0si2);
      xd1(1) = domain.xd(n1si2);
      xd1(2) = domain.xd(n2si2);
      xd1(3) = domain.xd(n3si2);
      xd1(4) = domain.xd(n4si2);
      xd1(5) = domain.xd(n5si2);
      xd1(6) = domain.xd(n6si2);
      xd1(7) = domain.xd(n7si2);

      yd1(0) = domain.yd(n0si2);
      yd1(1) = domain.yd(n1si2);
      yd1(2) = domain.yd(n2si2);
      yd1(3) = domain.yd(n3si2);
      yd1(4) = domain.yd(n4si2);
      yd1(5) = domain.yd(n5si2);
      yd1(6) = domain.yd(n6si2);
      yd1(7) = domain.yd(n7si2);

      zd1(0) = domain.zd(n0si2);
      zd1(1) = domain.zd(n1si2);
      zd1(2) = domain.zd(n2si2);
      zd1(3) = domain.zd(n3si2);
      zd1(4) = domain.zd(n4si2);
      zd1(5) = domain.zd(n5si2);
      zd1(6) = domain.zd(n6si2);
      zd1(7) = domain.zd(n7si2);
      
      coefficient = - hourg * (0.01 as Real_t) * ss1 * mass1 / volume13;
      //Console.OUT.printf("coefficient ****=%0.20fhourg**** = %0.20f, ss1= %0.20f, mass1= %0.20f",coefficient, hourg, ss1, mass1);
      
      CalcElemFBHourglassForce(xd1,yd1,zd1,
    		  hourgam0,hourgam1,hourgam2,hourgam3,
    		  hourgam4,hourgam5,hourgam6,hourgam7,
    		  coefficient, hgfx, hgfy, hgfz);
      
      domain.m_fx(n0si2) += hgfx(0);
      domain.m_fy(n0si2) += hgfy(0);
      domain.m_fz(n0si2) += hgfz(0);
      
      domain.m_fx(n1si2) += hgfx(1);
      domain.m_fy(n1si2) += hgfy(1);
      domain.m_fz(n1si2) += hgfz(1);
      
      domain.m_fx(n2si2) += hgfx(2);
      domain.m_fy(n2si2) += hgfy(2);
      domain.m_fz(n2si2) += hgfz(2);
      
      domain.m_fx(n3si2) += hgfx(3);
      domain.m_fy(n3si2) += hgfy(3);
      domain.m_fz(n3si2) += hgfz(3);
      
      domain.m_fx(n4si2) += hgfx(4);
      domain.m_fy(n4si2) += hgfy(4);
      domain.m_fz(n4si2) += hgfz(4);
      
      domain.m_fx(n5si2) += hgfx(5);
      domain.m_fy(n5si2) += hgfy(5);
      domain.m_fz(n5si2) += hgfz(5);
      
      domain.m_fx(n6si2) += hgfx(6);
      domain.m_fy(n6si2) += hgfy(6);
      domain.m_fz(n6si2) += hgfz(6);
      
      domain.m_fx(n7si2) += hgfx(7);
      domain.m_fy(n7si2) += hgfy(7);
      domain.m_fz(n7si2) += hgfz(7);
   }
}

@Inline public static def CalcHourglassControlForElems(var determ:Rail[Real_t], val hgcoef:Real_t){
	var i:Index_t, ii:Index_t, jj:Index_t;
	var x1:Rail[Real_t] = new Rail[Real_t](8);
	var y1:Rail[Real_t] = new Rail[Real_t](8);
	var z1:Rail[Real_t] = new Rail[Real_t](8);
	var pfx:Rail[Real_t] = new Rail[Real_t](8);
	var pfy:Rail[Real_t] = new Rail[Real_t](8);
	var pfz:Rail[Real_t] = new Rail[Real_t](8);
	var numElem:Index_t = domain.numElem();
	var numElem8:Index_t = numElem * 8n;
	
	var dvdx:Rail[Real_t] = new Rail[Real_t](numElem8) ;
	var dvdy:Rail[Real_t] = new Rail[Real_t](numElem8) ;
	var dvdz:Rail[Real_t] = new Rail[Real_t](numElem8) ;
	var x8n:Rail[Real_t] = new Rail[Real_t](numElem8) ;
	var y8n:Rail[Real_t] = new Rail[Real_t](numElem8) ;
	var z8n:Rail[Real_t] = new Rail[Real_t](numElem8) ;
	
	for(i = 0n; i < numElem; ++i){
		val elemToNode = domain.nodelist();

		CollectDomainNodesToElemNodes(i, elemToNode, x1, y1, z1);

		CalcElemVolumeDerivative(pfx, pfy, pfz, x1, y1, z1); // kokode segumen
		
		for(ii = 0n; ii < 8n; ++ii){
			jj = 8n * i+ii;

			dvdx(jj) = pfx(ii);
			dvdy(jj) = pfy(ii);
			dvdz(jj) = pfz(ii);
			x8n(jj)  = x1(ii);
			y8n(jj)  = y1(ii);
			z8n(jj)  = z1(ii);
		}
		
		determ(i) = domain.volo(i) * domain.v(i);
		
		if(domain.v(i) <= (0.0 as Real_t)){
			Console.OUT.println("ApplyMaterialPropertiesForElems domain.v(" + i + ")= " + domain.v(i));
			System.setExitCode(VolumeError);
			throw new VolumeException();
		}
	}
	
	if(hgcoef > (0. as Real_t)){
		CalcFBHourglassForceForElems(determ,x8n,y8n,z8n,dvdx,dvdy,dvdz,hgcoef);
	}
	return;
}

@Inline public static def CalcVolumeForceForElems(){
	numElem:Index_t = domain.numElem();
    if (numElem != 0n) {
		val hgcoef = domain.hgcoef();

		var sigxx:Rail[Real_t] = new Rail[Real_t](numElem);
		var sigyy:Rail[Real_t] = new Rail[Real_t](numElem);
		var sigzz:Rail[Real_t] = new Rail[Real_t](numElem);
		var determ:Rail[Real_t] = new Rail[Real_t](numElem);
		
		/* Sum contributions to total stress tensor */
//		var start:Long = Timer.milliTime();
		InitStressTermsForElems(numElem, sigxx, sigyy, sigzz);
//		Console.OUT.println("        InitStressTerm time = " + (Timer.milliTime() - start));
		// call elemlib stress integration loop to produce nodal forces from
		// material stresses.
//		start = Timer.milliTime();
		IntegrateStressForElems( numElem, sigxx, sigyy, sigzz, determ);
//		Console.OUT.println("        IntegrateStress time = " + (Timer.milliTime() - start));
		
		for(var k:Index_t = 0n; k < numElem; ++k){
			if(determ(k) <= (0.0 as Real_t)){
				//Console.OUT.println("CalcVolumeForceForElems determ(" + k + ") = " + determ(k));
				System.setExitCode(VolumeError) ;
				throw new VolumeException();
			}
		}
		
//		start = Timer.milliTime();
		CalcHourglassControlForElems(determ, hgcoef) ;
//		Console.OUT.println("        HourglassControlCalc time = " + (Timer.milliTime() - start));
    }
}

@Inline public static def CalcForceForNodes(){
	var numNode:Index_t = domain.numNode() ;

	for (var i:Index_t = 0n; i < numNode; ++i) {
		domain.m_fx(i) = (0.0 as Real_t) ;
		domain.m_fy(i) = (0.0 as Real_t) ;
		domain.m_fz(i) = (0.0 as Real_t) ;
	}
	
	/* Calcforce calls partial, force, hourq */
//	var start:Long = Timer.milliTime();
	CalcVolumeForceForElems() ;
//	Console.OUT.println("      VolumeForceCalc time = " + (Timer.milliTime() - start));

	/* Calculate Nodal Forces at domain boundaries */
	/* problem->commSBN->Transfer(CommSBN::forces); */
}

@Inline public static def CalcAccelerationForNodes(){
	var numNode:Index_t = domain.numNode();
	for(var i:Index_t = 0n; i < numNode; ++i){
		domain.m_xdd(i) = domain.fx(i) / domain.nodalMass(i);
		domain.m_ydd(i) = domain.fy(i) / domain.nodalMass(i);
		domain.m_zdd(i) = domain.fz(i) / domain.nodalMass(i);
	}
}

@Inline public static def ApplyAccelerationBoundaryConditionsForNodes(){
	val numNodeBC = (domain.sizeX()+1)*(domain.sizeX()+1) ;
	for(var i:Index_t = 0n ; i < numNodeBC ; ++i)
		domain.m_xdd(domain.symmX(i)) = (0.0 as Real_t) ;

	for(var i:Index_t= 0n ; i < numNodeBC ; ++i)
		domain.m_ydd(domain.symmY(i)) = (0.0 as Real_t) ;

	for(var i:Index_t= 0n ; i < numNodeBC ; ++i)
		domain.m_zdd(domain.symmZ(i)) = (0.0 as Real_t) ;
}

@Inline public static def CalcVelocityForNodes(val dt:Real_t, val u_cut:Real_t){
	var numNode: Index_t = domain.numNode();
	
	for(var i:Index_t = 0n; i < numNode; ++i){
		var xdtmp:Real_t, ydtmp:Real_t, zdtmp:Real_t;
		
		xdtmp = domain.xd(i) + domain.xdd(i) * dt;
		//if(xdtmp != 0d){Console.OUT.printf("dt**** = %0.30f", dt);}
		
		if(Math.abs(xdtmp) < u_cut) { xdtmp = 0.0 as Real_t;}
		domain.m_xd(i) = xdtmp;
		
		ydtmp = domain.yd(i) + domain.ydd(i) * dt;
		if(Math.abs(ydtmp) < u_cut) ydtmp = 0.0 as Real_t;
		domain.m_yd(i) = ydtmp;
		
		zdtmp = domain.zd(i) + domain.zdd(i) * dt;
		if(Math.abs(zdtmp) < u_cut) zdtmp = 0.0 as Real_t;
		domain.m_zd(i) = zdtmp;
	}
}

@Inline public static def CalcPositionForNodes(val dt:Real_t){
	val numNode:Index_t = domain.numNode();
	
	for(var i:Index_t = 0n; i < numNode; ++i){
		domain.m_x(i) += domain.xd(i) * dt;
		domain.m_y(i) += domain.yd(i) * dt;
		domain.m_z(i) += domain.zd(i) * dt;
	}
}

@Inline public static def LagrangeNodal(){
	val delt:Real_t = domain.deltatime();
	var u_cut:Real_t = domain.u_cut();
	
	/* time of boundary condition evaluation is beginning of step for force and
	 * acceleration boundary conditions. */
//	var start:Long = Timer.milliTime();
	CalcForceForNodes();
//	Console.OUT.println("    ForceCalc time = " + (Timer.milliTime() - start));
	
//	start = Timer.milliTime();
	CalcAccelerationForNodes();
//	Console.OUT.println("    AccelCalc time = " + (Timer.milliTime() - start));

//	start = Timer.milliTime();
	ApplyAccelerationBoundaryConditionsForNodes();
//	Console.OUT.println("    AccelBC time = " + (Timer.milliTime() - start));

//	start = Timer.milliTime();
	CalcVelocityForNodes( delt, u_cut );
//	Console.OUT.println("    VelocityCalc time = " + (Timer.milliTime() - start));
	
//	start = Timer.milliTime();
	CalcPositionForNodes( delt );
//	Console.OUT.printf("    PositionCalc time = %f\n", (Timer.milliTime() - start));
	
	return;
}

@Inline public static def TripleProduct(val x1:Real_t, val y1:Real_t, val z1:Real_t, val x2:Real_t, val y2:Real_t, val z2:Real_t, val x3:Real_t, val y3:Real_t, val z3:Real_t):Real_t {
	return ((x1)*((y2)*(z3) - (z2)*(y3)) + (x2)*((z1)*(y3) - (y1)*(z3)) + (x3)*((y1)*(z2) - (z1)*(y2)));
}

@Inline public static def CalcElemVolume(val x0:Real_t, val x1:Real_t,
								             val x2:Real_t, val x3:Real_t,
								             val x4:Real_t, val x5:Real_t,
		                                  val x6:Real_t, val x7:Real_t,
		                                  val y0:Real_t, val y1:Real_t,
		                                  val y2:Real_t, val y3:Real_t,
		                                  val y4:Real_t, val y5:Real_t,
		                                  val y6:Real_t, val y7:Real_t,
		                                  val z0:Real_t, val z1:Real_t,
		                                  val z2:Real_t, val z3:Real_t,
		                                  val z4:Real_t, val z5:Real_t,
		                                  val z6:Real_t, val z7:Real_t):Real_t
{
	var twelveth:Real_t = (1.0 as Real_t) / (12.0 as Real_t);
	
	val dx61 = x6 - x1;
	val dy61 = y6 - y1;
	val dz61 = z6 - z1;
	
	val dx70 = x7 - x0;
	val dy70 = y7 - y0;
	val dz70 = z7 - z0;
	
	val dx63 = x6 - x3;
	val dy63 = y6 - y3;
	val dz63 = z6 - z3;
	
	val dx20 = x2 - x0;
	val dy20 = y2 - y0;
	val dz20 = z2 - z0;

	val dx50 = x5 - x0;
	val dy50 = y5 - y0;
	val dz50 = z5 - z0;

	val dx64 = x6 - x4;
	val dy64 = y6 - y4;
	val dz64 = z6 - z4;

	val dx31 = x3 - x1;
	val dy31 = y3 - y1;
	val dz31 = z3 - z1;

	val dx72 = x7 - x2;
	val dy72 = y7 - y2;
	val dz72 = z7 - z2;

	val dx43 = x4 - x3;
	val dy43 = y4 - y3;
	val dz43 = z4 - z3;

	val dx57 = x5 - x7;
	val dy57 = y5 - y7;
	val dz57 = z5 - z7;

	val dx14 = x1 - x4;
	val dy14 = y1 - y4;
	val dz14 = z1 - z4;

	val dx25 = x2 - x5;
	val dy25 = y2 - y5;
	val dz25 = z2 - z5;
	
	var volume:Real_t =
		TripleProduct(dx31 + dx72, dx63, dx20,
				dy31 + dy72, dy63, dy20,
				dz31 + dz72, dz63, dz20) +
		TripleProduct(dx43 + dx57, dx64, dx70,
				dy43 + dy57, dy64, dy70,
				dz43 + dz57, dz64, dz70) +
		TripleProduct(dx14 + dx25, dx61, dx50,
				dy14 + dy25, dy61, dy50,
				dz14 + dz25, dz61, dz50);
	volume *= twelveth;

	return volume ;
}
		                                  
@Inline public static def CalcElemVolume( val x:Rail[Real_t], val y:Rail[Real_t], val z:Rail[Real_t] ):Real_t
{
	return CalcElemVolume( x(0), x(1), x(2), x(3), x(4), x(5), x(6), x(7),
					         y(0), y(1), y(2), y(3), y(4), y(5), y(6), y(7),
					         z(0), z(1), z(2), z(3), z(4), z(5), z(6), z(7));
}

@Inline public static def AreaFace(val x0:Real_t, val x1:Real_t,
		val x2:Real_t, val x3:Real_t,
		val y0:Real_t, val y1:Real_t,
		val y2:Real_t, val y3:Real_t,
		val z0:Real_t, val z1:Real_t,
		val z2:Real_t, val z3:Real_t):Real_t
{
		val fx = (x2 - x0) - (x3 - x1);
		val fy = (y2 - y0) - (y3 - y1);
		val fz = (z2 - z0) - (z3 - z1);
		val gx = (x2 - x0) + (x3 - x1);
		val gy = (y2 - y0) + (y3 - y1);
		val gz = (z2 - z0) + (z3 - z1);
		val area =
			(fx * fx + fy * fy + fz * fz) *
			(gx * gx + gy * gy + gz * gz) -
			(fx * gx + fy * gy + fz * gz) *
				(fx * gx + fy * gy + fz * gz);
		return area ;
}

@Inline public static def CalcElemCharacteristicLength( val x:Rail[Real_t],
                                                val y:Rail[Real_t],
                                                val z:Rail[Real_t],
                                                val volume:Real_t):Real_t
{
            var a:Real_t = (0.0 as Real_t);
            var charLength:Real_t = (0.0 as Real_t); 

            a = AreaFace(x(0),x(1),x(2),x(3),
                y(0),y(1),y(2),y(3),
                z(0),z(1),z(2),z(3)) ;
            charLength = Math.max(a,charLength) ;

            a = AreaFace(x(4),x(5),x(6),x(7),
                y(4),y(5),y(6),y(7),
                z(4),z(5),z(6),z(7)) ;
            charLength = Math.max(a,charLength) ;

            a = AreaFace(x(0),x(1),x(5),x(4),
                y(0),y(1),y(5),y(4),
                z(0),z(1),z(5),z(4)) ;
            charLength = Math.max(a,charLength) ;

            a = AreaFace(x(1),x(2),x(6),x(5),
                y(1),y(2),y(6),y(5),
                z(1),z(2),z(6),z(5)) ;
            charLength = Math.max(a,charLength) ;

            a = AreaFace(x(2),x(3),x(7),x(6),
                y(2),y(3),y(7),y(6),
                z(2),z(3),z(7),z(6)) ;
            charLength = Math.max(a,charLength) ;

            a = AreaFace(x(3),x(0),x(4),x(7),
                y(3),y(0),y(4),y(7),
                z(3),z(0),z(4),z(7)) ;
            charLength = Math.max(a,charLength) ;

            charLength = (4.0 as Real_t) * volume / SQRT(charLength);

            return charLength;
}

@Inline public static def CalcElemVelocityGrandient( val xvel:Rail[Real_t],
                        				                  val yvel:Rail[Real_t],
                        				                  val zvel:Rail[Real_t],
                        				                  val b:Array_2[Real_t],
                        				                  val detJ:Real_t,
                        				                  val d:Rail[Real_t])
{
	val inv_detJ:Real_t = (1.0 as Real_t) / detJ;
	var dyddx:Real_t, dxddy:Real_t, dzddx:Real_t, dxddz:Real_t, dzddy:Real_t, dyddz:Real_t;
	
	d(0) = inv_detJ * ( b(0,0) * (xvel(0)-xvel(6))
			+ b(0,1) * (xvel(1)-xvel(7))
			+ b(0,2) * (xvel(2)-xvel(4))
			+ b(0,3) * (xvel(3)-xvel(5)) );

	d(1) = inv_detJ * ( b(1,0) * (yvel(0)-yvel(6))
			+ b(1,1) * (yvel(1)-yvel(7))
			+ b(1,2) * (yvel(2)-yvel(4))
			+ b(1,3) * (yvel(3)-yvel(5)) );

	d(2) = inv_detJ * ( b(2,0) * (zvel(0)-zvel(6))
			+ b(2,1) * (zvel(1)-zvel(7))
			+ b(2,2) * (zvel(2)-zvel(4))
			+ b(2,3) * (zvel(3)-zvel(5)) );
	/*if(d(0) != 0d){
		Console.OUT.printf("inv_detJ***** = %0.30f, b(0,0)= %0.30f, b(0,1)= %0.30f, b(0,2)= %0.30f, xvel(0)= %0.30f", inv_detJ, b(0,0), b(0,1), b(0,2),xvel(0));
	}*/

	dyddx  = inv_detJ * ( b(0,0) * (yvel(0)-yvel(6))
			+ b(0,1) * (yvel(1)-yvel(7))
			+ b(0,2) * (yvel(2)-yvel(4))
			+ b(0,3) * (yvel(3)-yvel(5)) );

	dxddy  = inv_detJ * ( b(1,0) * (xvel(0)-xvel(6))
			+ b(1,1) * (xvel(1)-xvel(7))
			+ b(1,2) * (xvel(2)-xvel(4))
			+ b(1,3) * (xvel(3)-xvel(5)) );

	dzddx  = inv_detJ * ( b(0,0) * (zvel(0)-zvel(6))
			+ b(0,1) * (zvel(1)-zvel(7))
			+ b(0,2) * (zvel(2)-zvel(4))
			+ b(0,3) * (zvel(3)-zvel(5)) );

	dxddz  = inv_detJ * ( b(2,0) * (xvel(0)-xvel(6))
			+ b(2,1) * (xvel(1)-xvel(7))
			+ b(2,2) * (xvel(2)-xvel(4))
			+ b(2,3) * (xvel(3)-xvel(5)) );

	dzddy  = inv_detJ * ( b(1,0) * (zvel(0)-zvel(6))
			+ b(1,1) * (zvel(1)-zvel(7))
			+ b(1,2) * (zvel(2)-zvel(4))
			+ b(1,3) * (zvel(3)-zvel(5)) );

	dyddz  = inv_detJ * ( b(2,0) * (yvel(0)-yvel(6))
			+ b(2,1) * (yvel(1)-yvel(7))
			+ b(2,2) * (yvel(2)-yvel(4))
			+ b(2,3) * (yvel(3)-yvel(5)) );
	d(5)  = ( .5 as Real_t) * ( dxddy + dyddx );
	d(4)  = ( .5 as Real_t) * ( dxddz + dzddx );
	d(3)  = ( .5 as Real_t) * ( dzddy + dyddz );
}

@Inline public static def CalcKinematicsForElems(var numElem:Index_t, var dt:Real_t){
   var B:Array_2[Real_t] = new Array_2[Real_t](3, 8);
   var D:Rail[Real_t] = new Rail[Real_t](6);
   var x_local:Rail[Real_t] = new Rail[Real_t](8);
   var y_local:Rail[Real_t] = new Rail[Real_t](8);
   var z_local:Rail[Real_t] = new Rail[Real_t](8);
   var xd_local:Rail[Real_t] = new Rail[Real_t](8);
   var yd_local:Rail[Real_t] = new Rail[Real_t](8);
   var zd_local:Rail[Real_t] = new Rail[Real_t](8);
   var detJ:Rail[Real_t] = new Rail[Real_t](1);
   detJ(0) = 0.0 as Real_t;
  
   for(var k:Index_t = 0n; k < numElem; ++k){
      var volume:Real_t;
      var relativeVolume:Real_t;
      val elemToNode = domain.nodelist();
      
      for(var lnode:Index_t = 0n; lnode < 8n; ++lnode){
         var gnode:Index_t = elemToNode(k, lnode);
         x_local(lnode) = domain.x(gnode);
         y_local(lnode) = domain.y(gnode);
         z_local(lnode) = domain.z(gnode);
      }
      
      // volume calculations
      volume = CalcElemVolume(x_local, y_local, z_local );
      relativeVolume = volume / domain.volo(k);
      domain.m_vnew(k) = relativeVolume;
      domain.m_delv(k) = relativeVolume - domain.v(k);
      
      // set characteristic length
      domain.m_arealg(k) = CalcElemCharacteristicLength(x_local,
      											              y_local,
      											              z_local,
      													       volume);
      
      // get nodal velocities from global array and copy into local arrays.
      for( var lnode:Index_t = 0n ; lnode < 8n ; ++lnode )
      {
         val gnode = elemToNode(k, lnode);
         xd_local(lnode) = domain.xd(gnode);
         yd_local(lnode) = domain.yd(gnode);
         zd_local(lnode) = domain.zd(gnode);
      }
      
      val dt2 = (0.5 as Real_t) * dt;
      for ( var j:Index_t = 0n ; j < 8n ; ++j )
      {
         x_local(j) -= dt2 * xd_local(j);
         y_local(j) -= dt2 * yd_local(j);
         z_local(j) -= dt2 * zd_local(j);
      }
      
      CalcElemShapeFunctionDerivatives( x_local, y_local, z_local, B, 0n, detJ );
      
      CalcElemVelocityGrandient( xd_local, yd_local, zd_local, B, detJ(0), D );
      
      domain.m_dxx(k) = D(0);
      domain.m_dyy(k) = D(1);
      domain.m_dzz(k) = D(2);
   }
}

@Inline public static def CalcLagrangeElements(val deltatime:Real_t) {
   val numElem = domain.numElem();
   if (numElem > 0) {
      CalcKinematicsForElems(numElem, deltatime) ;

      // element loop to do some stuff not included in the elemlib function.
      for ( var k:Index_t=0n ; k<numElem ; ++k )
      {
         // calc strain rate and apply as constraint (only done in FB element)
         val vdov = domain.dxx(k) + domain.dyy(k) + domain.dzz(k) ;
         val vdovthird = vdov/(3.0 as Real_t) ;

         // make the rate of deformation tensor deviatoric
         domain.m_vdov(k) = vdov ;
         domain.m_dxx(k) -= vdovthird ;
         domain.m_dyy(k) -= vdovthird ;
         domain.m_dzz(k) -= vdovthird ;

         // See if any volumes are negative, and take appropriate action.
         if (domain.vnew(k) <= (0.0 as Real_t))
          {
        	 Console.OUT.println("CalcLagrangeElements vnew(" + k + ") = " + domain.vnew(k));
            System.setExitCode(VolumeError) ;
            throw new VolumeException();
         }
      }
   }
}

@Inline public static def SUM4(val a:Real_t, val b:Real_t, val c:Real_t, val d:Real_t):Real_t {
   return a + b + c + d;
}

@Inline public static def CalcMonotonicQGradientsForElems() {
        val numElem:Index_t = domain.numElem() ;
        val ptiny = (1.e-36 as Real_t) ;

        for (var i:Index_t = 0n ; i < numElem ; ++i ) {
          var ax:Real_t;
          var ay:Real_t;
          var az:Real_t;
          var dxv:Real_t;
          var dyv:Real_t;
          var dzv:Real_t;

          val elemToNode = domain.nodelist();
          val n0 = elemToNode(i, 0) ;
          val n1 = elemToNode(i, 1) ;
          val n2 = elemToNode(i, 2) ;
          val n3 = elemToNode(i, 3) ;
          val n4 = elemToNode(i, 4) ;
          val n5 = elemToNode(i, 5) ;
          val n6 = elemToNode(i, 6) ;
          val n7 = elemToNode(i, 7) ;

          val x0 = domain.x(n0) ;
          val x1 = domain.x(n1) ;
          val x2 = domain.x(n2) ;
          val x3 = domain.x(n3) ;
          val x4 = domain.x(n4) ;
          val x5 = domain.x(n5) ;
          val x6 = domain.x(n6) ;
          val x7 = domain.x(n7) ;

          val y0 = domain.y(n0) ;
          val y1 = domain.y(n1) ;
          val y2 = domain.y(n2) ;
          val y3 = domain.y(n3) ;
          val y4 = domain.y(n4) ;
          val y5 = domain.y(n5) ;
          val y6 = domain.y(n6) ;
          val y7 = domain.y(n7) ;

          val z0 = domain.z(n0) ;
          val z1 = domain.z(n1) ;
          val z2 = domain.z(n2) ;
          val z3 = domain.z(n3) ;
          val z4 = domain.z(n4) ;
          val z5 = domain.z(n5) ;
          val z6 = domain.z(n6) ;
          val z7 = domain.z(n7) ;

          val xv0 = domain.xd(n0) ;
          val xv1 = domain.xd(n1) ;
          val xv2 = domain.xd(n2) ;
          val xv3 = domain.xd(n3) ;
          val xv4 = domain.xd(n4) ;
          val xv5 = domain.xd(n5) ;
          val xv6 = domain.xd(n6) ;
          val xv7 = domain.xd(n7) ;

          val yv0 = domain.yd(n0) ;
          val yv1 = domain.yd(n1) ;
          val yv2 = domain.yd(n2) ;
          val yv3 = domain.yd(n3) ;
          val yv4 = domain.yd(n4) ;
          val yv5 = domain.yd(n5) ;
          val yv6 = domain.yd(n6) ;
          val yv7 = domain.yd(n7) ;

          val zv0 = domain.zd(n0) ;
          val zv1 = domain.zd(n1) ;
          val zv2 = domain.zd(n2) ;
          val zv3 = domain.zd(n3) ;
          val zv4 = domain.zd(n4) ;
          val zv5 = domain.zd(n5) ;
          val zv6 = domain.zd(n6) ;
          val zv7 = domain.zd(n7) ;

          val vol = domain.volo(i)*domain.vnew(i) ;
          val norm = (1.0 as Real_t) / ( vol + ptiny ) ;

          val dxj = (-0.25 as Real_t)*(SUM4(x0,x1,x5,x4) - SUM4(x3,x2,x6,x7)) ;
          val dyj = (-0.25 as Real_t)*(SUM4(y0,y1,y5,y4) - SUM4(y3,y2,y6,y7)) ;
          val dzj = (-0.25 as Real_t)*(SUM4(z0,z1,z5,z4) - SUM4(z3,z2,z6,z7)) ;

          val dxi = ( 0.25 as Real_t)*(SUM4(x1,x2,x6,x5) - SUM4(x0,x3,x7,x4)) ;
          val dyi = ( 0.25 as Real_t)*(SUM4(y1,y2,y6,y5) - SUM4(y0,y3,y7,y4)) ;
          val dzi = ( 0.25 as Real_t)*(SUM4(z1,z2,z6,z5) - SUM4(z0,z3,z7,z4)) ;

          val dxk = ( 0.25 as Real_t)*(SUM4(x4,x5,x6,x7) - SUM4(x0,x1,x2,x3)) ;
          val dyk = ( 0.25 as Real_t)*(SUM4(y4,y5,y6,y7) - SUM4(y0,y1,y2,y3)) ;
          val dzk = ( 0.25 as Real_t)*(SUM4(z4,z5,z6,z7) - SUM4(z0,z1,z2,z3)) ;

          /* find delvk and delxk ( i cross j ) */

          ax = dyi*dzj - dzi*dyj ;
          ay = dzi*dxj - dxi*dzj ;
          az = dxi*dyj - dyi*dxj ;

          domain.m_delx_zeta(i) = vol / SQRT(ax*ax + ay*ay + az*az + ptiny) ;

          ax *= norm ;
          ay *= norm ;
          az *= norm ;

          dxv = (0.25 as Real_t)*(SUM4(xv4,xv5,xv6,xv7) - SUM4(xv0,xv1,xv2,xv3)) ;
          dyv = (0.25 as Real_t)*(SUM4(yv4,yv5,yv6,yv7) - SUM4(yv0,yv1,yv2,yv3)) ;
          dzv = (0.25 as Real_t)*(SUM4(zv4,zv5,zv6,zv7) - SUM4(zv0,zv1,zv2,zv3)) ;

          domain.m_delv_zeta(i) = ax*dxv + ay*dyv + az*dzv ;

          /* find delxi and delvi ( j cross k ) */

          ax = dyj*dzk - dzj*dyk ;
          ay = dzj*dxk - dxj*dzk ;
          az = dxj*dyk - dyj*dxk ;

          domain.m_delx_xi(i) = vol / SQRT(ax*ax + ay*ay + az*az + ptiny) ;

          ax *= norm ;
          ay *= norm ;
          az *= norm ;

          dxv = (0.25 as Real_t)*(SUM4(xv1,xv2,xv6,xv5) - SUM4(xv0,xv3,xv7,xv4)) ;
          dyv = (0.25 as Real_t)*(SUM4(yv1,yv2,yv6,yv5) - SUM4(yv0,yv3,yv7,yv4)) ;
          dzv = (0.25 as Real_t)*(SUM4(zv1,zv2,zv6,zv5) - SUM4(zv0,zv3,zv7,zv4)) ;

          domain.m_delv_xi(i) = ax*dxv + ay*dyv + az*dzv ;

          /* find delxj and delvj ( k cross i ) */

          ax = dyk*dzi - dzk*dyi ;
          ay = dzk*dxi - dxk*dzi ;
          az = dxk*dyi - dyk*dxi ;

          domain.m_delx_eta(i) = vol / SQRT(ax*ax + ay*ay + az*az + ptiny) ;

          ax *= norm ;
          ay *= norm ;
          az *= norm ;

          dxv = (-0.25 as Real_t)*(SUM4(xv0,xv1,xv5,xv4) - SUM4(xv3,xv2,xv6,xv7)) ;
          dyv = (-0.25 as Real_t)*(SUM4(yv0,yv1,yv5,yv4) - SUM4(yv3,yv2,yv6,yv7)) ;
          dzv = (-0.25 as Real_t)*(SUM4(zv0,zv1,zv5,zv4) - SUM4(zv3,zv2,zv6,zv7)) ;

          domain.m_delv_eta(i) = ax*dxv + ay*dyv + az*dzv ;
        }
}

@Inline public static def CalcMonotonicQRegionForElems(// parameters
          var qlc_monoq:Real_t,
          var qqc_monoq:Real_t,
          var monoq_limiter_mult:Real_t,
          var monoq_max_slope:Real_t,
          var ptiny:Real_t,

          // the elementset length
          var elength:Index_t )
      {
        for ( var ielem:Index_t = 0n ; ielem < elength; ++ielem ) {
          var qlin:Real_t; 
          var qquad:Real_t;
          var phixi:Real_t;
          var phieta:Real_t;
          var phizeta:Real_t;
          val i = domain.matElemlist(ielem);
          val bcMask = domain.elemBC(i) ;
          var delvm:Real_t = 0. as Real_t;
          var delvp:Real_t = 0. as Real_t;

          /*  phixi     */
          var norm:Real_t = (1. as Real_t) / ( domain.delv_xi(i) + ptiny ) ;

          switch (bcMask & XI_M) {
          case 0n:         delvm = domain.delv_xi(domain.lxim(i)) ; break ;
          case XI_M_SYMM: delvm = domain.delv_xi(i) ;            break ;
          case XI_M_FREE: delvm = (0.0 as Real_t) ;                break ;
          default:        /* ERROR */ ;                        break ;
          }
          switch (bcMask & XI_P) {
          case 0n:         delvp = domain.delv_xi(domain.lxip(i)) ; break ;
          case XI_P_SYMM: delvp = domain.delv_xi(i) ;            break ;
          case XI_P_FREE: delvp = (0.0 as Real_t) ;                break ;
          default:        /* ERROR */ ;                        break ;
          }

          delvm = delvm * norm ;
          delvp = delvp * norm ;

          phixi = (.5 as Real_t) * ( delvm + delvp ) ;

          delvm *= monoq_limiter_mult ;
          delvp *= monoq_limiter_mult ;

          if ( delvm < phixi ) phixi = delvm ;
          if ( delvp < phixi ) phixi = delvp ;
          if ( phixi < (0. as Real_t)) phixi = (0. as Real_t) ;
          if ( phixi > monoq_max_slope) phixi = monoq_max_slope;

          /*  phieta     */
          norm = (1. as Real_t) / ( domain.delv_eta(i) + ptiny ) ;

          switch (bcMask & ETA_M) {
          case 0n:          delvm = domain.delv_eta(domain.letam(i)) ; break ;
          case ETA_M_SYMM: delvm = domain.delv_eta(i) ;             break ;
          case ETA_M_FREE: delvm = (0.0 as Real_t) ;                  break ;
          default:         /* ERROR */ ;                          break ;
          }
          switch (bcMask & ETA_P) {
          case 0n:          delvp = domain.delv_eta(domain.letap(i)) ; break ;
          case ETA_P_SYMM: delvp = domain.delv_eta(i) ;             break ;
          case ETA_P_FREE: delvp = (0.0 as Real_t) ;                  break ;
          default:         /* ERROR */ ;                          break ;
          }

          delvm = delvm * norm ;
          delvp = delvp * norm ;

          phieta = (.5 as Real_t) * ( delvm + delvp ) ;

          delvm *= monoq_limiter_mult ;
          delvp *= monoq_limiter_mult ;

          if ( delvm  < phieta ) phieta = delvm ;
          if ( delvp  < phieta ) phieta = delvp ;
          if ( phieta < (0. as Real_t)) phieta = (0. as Real_t) ;
          if ( phieta > monoq_max_slope)  phieta = monoq_max_slope;

          /*  phizeta     */
          norm = (1. as Real_t) / ( domain.delv_zeta(i) + ptiny ) ;

          switch (bcMask & ZETA_M) {
          case 0n:           delvm = domain.delv_zeta(domain.lzetam(i)) ; break ;
          case ZETA_M_SYMM: delvm = domain.delv_zeta(i) ;              break ;
          case ZETA_M_FREE: delvm = (0.0 as Real_t) ;                    break ;
          default:          /* ERROR */ ;                            break ;
          }
          switch (bcMask & ZETA_P) {
          case 0n:           delvp = domain.delv_zeta(domain.lzetap(i)) ; break ;
          case ZETA_P_SYMM: delvp = domain.delv_zeta(i) ;              break ;
          case ZETA_P_FREE: delvp = (0.0 as Real_t) ;                    break ;
          default:          /* ERROR */ ;                            break ;
          }

          delvm = delvm * norm ;
          delvp = delvp * norm ;

          phizeta = (.5 as Real_t) * ( delvm + delvp ) ;

          delvm *= monoq_limiter_mult ;
          delvp *= monoq_limiter_mult ;

          if ( delvm   < phizeta ) phizeta = delvm ;
          if ( delvp   < phizeta ) phizeta = delvp ;
          if ( phizeta < (0. as Real_t)) phizeta = (0. as Real_t);
          if ( phizeta > monoq_max_slope  ) phizeta = monoq_max_slope;

          /* Remove length scale */

          if ( domain.vdov(i) > (0. as Real_t) )  {
            qlin  = (0. as Real_t) ;
            qquad = (0. as Real_t) ;
          }
          else {
            var delvxxi:Real_t = domain.delv_xi(i)   * domain.delx_xi(i)   ;
            var delvxeta:Real_t = domain.delv_eta(i)  * domain.delx_eta(i)  ;
            var delvxzeta:Real_t = domain.delv_zeta(i) * domain.delx_zeta(i) ;

            if ( delvxxi   > (0. as Real_t) ) delvxxi   = (0. as Real_t) ;
            if ( delvxeta  > (0. as Real_t) ) delvxeta  = (0. as Real_t) ;
            if ( delvxzeta > (0. as Real_t) ) delvxzeta = (0. as Real_t) ;

            val rho = domain.elemMass(i) / (domain.volo(i) * domain.vnew(i)) ;

            qlin = -qlc_monoq * rho *
            (  delvxxi   * ((1. as Real_t) - phixi) +
                delvxeta  * ((1. as Real_t) - phieta) +
                delvxzeta * ((1. as Real_t) - phizeta)  ) ;

            qquad = qqc_monoq * rho *
            (  delvxxi*delvxxi     * ((1. as Real_t) - phixi*phixi) +
                delvxeta*delvxeta   * ((1. as Real_t) - phieta*phieta) +
                delvxzeta*delvxzeta * ((1. as Real_t) - phizeta*phizeta)  ) ;
          }

          domain.m_qq(i) = qquad ;
          domain.m_ql(i) = qlin  ;
        }
}

@Inline public static def CalcMonotonicQForElems() {  
        //
        // initialize parameters
        // 
        val ptiny        = (1.e-36 as Real_t) ;
        val monoq_max_slope    = domain.monoq_max_slope() ;
        val monoq_limiter_mult = domain.monoq_limiter_mult() ;

        //
        // calculate the monotonic q for pure regions
        //
        val elength:Index_t = domain.numElem() ;
        if (elength > 0n) {
          val qlc_monoq = domain.qlc_monoq();
          val qqc_monoq = domain.qqc_monoq();
          CalcMonotonicQRegionForElems(// parameters
              qlc_monoq,
              qqc_monoq,
              monoq_limiter_mult,
              monoq_max_slope,
              ptiny,

              // the elemset length
              elength );
        }
}  

@Inline public static def CalcQForElems() {
        val qstop = domain.qstop() ;
        val numElem:Index_t = domain.numElem() ;

        //
        // MONOTONIC Q option
        //

        /* Calculate velocity gradients */
        CalcMonotonicQGradientsForElems() ;

        /* Transfer veloctiy gradients in the first order elements */
        /* problem->commElements->Transfer(CommElements::monoQ) ; */
        CalcMonotonicQForElems() ;

        /* Don't allow excessive artificial viscosity */
        if (numElem != 0n) {
          var idx:Index_t = -1n; 
          for (var i:Index_t=0n; i<numElem; ++i) {
            if ( domain.q(i) > qstop ) {
              idx = i ;
              break ;
            }
          }

          if(idx >= 0) {
        	  Console.OUT.println("CalcQForElems idx = " + idx);
            System.setExitCode(QStopError) ;
            throw new QStopException();
          }
        }
}

@Inline public static def CalcPressureForElems(var p_new:Rail[Real_t], var bvc:Rail[Real_t],
                                               var pbvc:Rail[Real_t], var e_old:Rail[Real_t],
                                               var compression:Rail[Real_t], var vnewc:Rail[Real_t],
                                               var pmin:Real_t,
                                               var p_cut:Real_t, var eosvmax:Real_t,
                                               var length:Index_t)
{
   var cls:Real_t = (2.0 as Real_t) / (3.0 as Real_t);
   for(var i:Index_t = 0n; i < length; ++i){
      bvc(i) = cls * (compression(i) + (1. as Real_t));
      pbvc(i) = cls;
   }
   
   for(var i:Index_t = 0n; i < length; ++i){
      p_new(i) = bvc(i) * e_old(i);
      if(Math.abs(p_new(i)) < p_cut){
         p_new(i) = 0.0 as Real_t;
      }
      
      if(vnewc(i) >= eosvmax){
         p_new(i) = 0.0 as Real_t;
      }
      
      if(p_new(i) < pmin){
         p_new(i) = pmin;
      }
   }
}

@Inline public static def CalcEnergyForElems(var p_new:Rail[Real_t], var e_new:Rail[Real_t], var q_new:Rail[Real_t],
                                             var bvc:Rail[Real_t], var pbvc:Rail[Real_t],
                                             var p_old:Rail[Real_t], var e_old:Rail[Real_t], var q_old:Rail[Real_t],
                                             var compression:Rail[Real_t], var compHalfStep:Rail[Real_t],
                                             var vnewc:Rail[Real_t], var work:Rail[Real_t], var delvc:Rail[Real_t], var pmin:Real_t,
                                             var p_cut:Real_t, var e_cut:Real_t, q_cut:Real_t, var emin:Real_t,
                                             var qq:Rail[Real_t], var ql:Rail[Real_t],
                                             var rho0:Real_t,
                                             var eosvmax:Real_t,
                                             val length:Index_t)
{
   val sixth = (1.0 as Real_t) / (6.0 as Real_t);
   var pHalfStep:Rail[Real_t] = new Rail[Real_t](length);
   
   for(var i:Index_t = 0n; i < length; ++i){
      e_new(i) = e_old(i) - (0.5 as Real_t) * delvc(i) * (p_old(i) + q_old(i)) + (0.5 as Real_t) * work(i);
      
      if(e_new(i) < emin){
         e_new(i) = emin;
      }
   }
   
   CalcPressureForElems(pHalfStep, bvc, pbvc, e_new, compHalfStep, vnewc,
   						pmin, p_cut, eosvmax, length);
   
   for(var i:Index_t = 0n; i < length; ++i){
      var vhalf:Real_t = (1. as Real_t) / ( (1. as Real_t) + compHalfStep(i) );
      
      if(delvc(i) > 0. as Real_t){
         q_new(i) = 0. as Real_t;
      }else{
         var ssc:Real_t = ( pbvc(i) * e_new(i) + vhalf * vhalf * bvc(i) * pHalfStep(i) ) / rho0;
         
         if( ssc <= 0. as Real_t){
            ssc = .333333e-36 as Real_t;
         }else{
            ssc = SQRT(ssc);
         }
         
         q_new(i) = (ssc * ql(i) + qq(i));
      }
      
      e_new(i) = e_new(i) + (0.5 as Real_t) * delvc(i)
           * ( (3.0 as Real_t) * (p_old(i) + q_old(i))
                - (4.0 as Real_t) * (pHalfStep(i) + q_new(i)) );
   }
   
   for(var i:Index_t = 0n; i < length; ++i){
      e_new(i) += (0.5 as Real_t) * work(i);
      
      if(Math.abs(e_new(i)) < e_cut){
         e_new(i) = 0. as Real_t;
      }
      if(e_new(i) < emin){
         e_new(i) = emin;
      }
   }
   
   CalcPressureForElems(p_new, bvc, pbvc, e_new, compression, vnewc,
   						pmin, p_cut, eosvmax, length);
   
   for(var i:Index_t = 0n; i < length; ++i){
      var q_tilde:Real_t;
      
      if(delvc(i) > (0. as Real_t)){
         q_tilde = 0. as Real_t;
      }else{
         var ssc:Real_t = ( pbvc(i) * e_new(i) + vnewc(i) * vnewc(i) * bvc(i) * p_new(i) ) / rho0;
         
         if(ssc <= 0. as Real_t){
            ssc = .333333e-36 as Real_t;
         }else{
            ssc = SQRT(ssc);
         }
         
         q_tilde = (ssc * ql(i) + qq(i));
      }
      
      e_new(i) = e_new(i) - ( (7.0 as Real_t) * (p_old(i) + q_old(i))
                                 - (8.0 as Real_t) * (pHalfStep(i) + q_new(i))
                                      + (p_new(i) + q_tilde)) * delvc(i) * sixth;
      
      if(Math.abs(e_new(i)) < e_cut){
         e_new(i) = 0. as Real_t;
      }
      if(e_new(i) < emin){
         e_new(i) = emin;
      }
   }
   
   CalcPressureForElems(p_new, bvc, pbvc, e_new, compression, vnewc,
   						pmin, p_cut, eosvmax, length);
   
   for( var i:Index_t = 0n; i < length; ++i){
      if(delvc(i) <= 0. as Real_t){
         var ssc:Real_t = ( pbvc(i) * e_new(i) + vnewc(i) * vnewc(i) * bvc(i) * p_new(i) ) / rho0;
         
         if(ssc <= 0. as Real_t){
            ssc = 0.333333e-36 as Real_t;
         }else{
            ssc = SQRT(ssc);
         }
         
         q_new(i) = (ssc * ql(i) + qq(i));
         
         if(Math.abs(q_new(i)) < q_cut){
            q_new(i) = 0. as Real_t;
         }
      }
   }
   
   return;
}

@Inline public static def CalcSoundSpeedForElems(val vnewc:Rail[Real_t], val rho0:Real_t, val enewc:Rail[Real_t],
   val pnewc:Rail[Real_t], val pbvc:Rail[Real_t],
   val bvc:Rail[Real_t], val ss4o3:Real_t, val nz:Index_t)
{
   for (var i:Index_t = 0n; i < nz ; ++i) {
      val iz = domain.matElemlist(i);
      var ssTmp:Real_t = (pbvc(i) * enewc(i) + vnewc(i) * vnewc(i) *
                     bvc(i) * pnewc(i)) / rho0;
      if (ssTmp <= (1.111111e-36 as Real_t)) {
         ssTmp = (1.111111e-36 as Real_t);
       }
      domain.m_ss(iz) = SQRT(ssTmp);
   }
}

@Inline public static def EvalEOSForElems(var vnewc:Rail[Real_t], val length:Index_t) {
        val  e_cut = domain.e_cut();
        val  p_cut = domain.p_cut();
        val  ss4o3 = domain.ss4o3();
        val  q_cut = domain.q_cut();

        val eosvmax = domain.eosvmax() ;
        val eosvmin = domain.eosvmin() ;
        val pmin    = domain.pmin() ;
        val emin    = domain.emin() ;
        val rho0    = domain.refdens() ;

        var e_old:Rail[Real_t] = new Rail[Real_t](length) ;
        var delvc:Rail[Real_t] = new Rail[Real_t](length) ;
        var p_old:Rail[Real_t] = new Rail[Real_t](length) ;
        var q_old:Rail[Real_t] = new Rail[Real_t](length) ;
        var compression:Rail[Real_t] = new Rail[Real_t](length) ;
        var compHalfStep:Rail[Real_t] = new Rail[Real_t](length) ;
        var qq:Rail[Real_t] = new Rail[Real_t](length) ;
        var ql:Rail[Real_t] = new Rail[Real_t](length) ;
        var work:Rail[Real_t] = new Rail[Real_t](length) ;
        var p_new:Rail[Real_t] = new Rail[Real_t](length) ;
        var e_new:Rail[Real_t] = new Rail[Real_t](length) ;
        var q_new:Rail[Real_t] = new Rail[Real_t](length) ;
        var bvc:Rail[Real_t] = new Rail[Real_t](length) ;
        var pbvc:Rail[Real_t] = new Rail[Real_t](length) ;
        //@StatementAnnotation @StackAllocate val pbvc = @StackAllocateUninitialized new Rail[Real_t](8n) ;

        /* compress data, minimal set */
        for (var i:Index_t=0n; i<length; ++i) {
          val zidx = domain.matElemlist(i) ;
          e_old(i) = domain.e(zidx) ;
        }

        for (var i:Index_t=0n; i<length; ++i) {
          val zidx = domain.matElemlist(i) ;
          delvc(i) = domain.delv(zidx) ;
        }

        for (var i:Index_t=0n; i<length; ++i) {
          val zidx = domain.matElemlist(i) ;
          p_old(i) = domain.p(zidx) ;
        }

        for (var i:Index_t=0n; i<length; ++i) {
          val zidx = domain.matElemlist(i) ;
          q_old(i) = domain.q(zidx) ;
        }

        for (var i:Index_t = 0n; i < length ; ++i) {
          var vchalf:Real_t ;
          compression(i) = (1. as Real_t) / vnewc(i) - (1. as Real_t);
          vchalf = vnewc(i) - delvc(i) * (.5 as Real_t);
          compHalfStep(i) = (1. as Real_t) / vchalf - (1. as Real_t);
        }

        /* Check for v > eosvmax or v < eosvmin */
        if ( eosvmin != (0.0 as Real_t) ) {
          for(var i:Index_t=0n ; i<length ; ++i) {
            if (vnewc(i) <= eosvmin) { /* impossible due to calling func? */
              compHalfStep(i) = compression(i) ;
            }
          }
        }
        if ( eosvmax != (0.0 as Real_t) ) {
          for(var i:Index_t=0n ; i<length ; ++i) {
            if (vnewc(i) >= eosvmax) { /* impossible due to calling func? */
              p_old(i)        = (0.0 as Real_t) ;
              compression(i)  = (0.0 as Real_t) ;
              compHalfStep(i) = (0.0 as Real_t) ;
            }
          }
        }

        for (var i:Index_t = 0n ; i < length ; ++i) {
          val zidx = domain.matElemlist(i) ;
          qq(i) = domain.qq(zidx) ;
          ql(i) = domain.ql(zidx) ;
          work(i) = (0.0 as Real_t) ; 
        }
        
        val lengthL:Long = length;
        CalcEnergyForElems(p_new, e_new, q_new, bvc, pbvc,
            p_old, e_old,  q_old, compression, compHalfStep,
            vnewc, work,  delvc, pmin,
            p_cut, e_cut, q_cut, emin,
            qq, ql, rho0, eosvmax, length);


        for (var i:Index_t=0n; i<length; ++i) {
          val zidx = domain.matElemlist(i) ;
          domain.m_p(zidx) = p_new(i) ;
        }

        for (var i:Index_t=0n; i<length; ++i) {
          val zidx = domain.matElemlist(i) ;
          domain.m_e(zidx) = e_new(i) ;
        }

        for (var i:Index_t=0n; i<length; ++i) {
          val zidx = domain.matElemlist(i) ;
          domain.m_q(zidx) = q_new(i) ;
        }

        CalcSoundSpeedForElems(vnewc, rho0, e_new, p_new,
            pbvc, bvc, ss4o3, length) ;
}

@Inline public static def ApplyMaterialPropertiesForElems() {
        val length = domain.numElem() ;

        if (length != 0n) {
          /* Expose all of the variables needed for material evaluation */
          val eosvmin = domain.eosvmin() ;
          val eosvmax = domain.eosvmax() ;
          var vnewc:Rail[Real_t] = new Rail[Real_t](length) ;

          for (var i:Index_t=0n ; i<length ; ++i) {
            val zn = domain.matElemlist(i) ;
            vnewc(i) = domain.vnew(zn) ;
          }

          if (eosvmin != (0.0 as Real_t)) {
            for(var i:Index_t=0n ; i<length ; ++i) {
              if (vnewc(i) < eosvmin)
                vnewc(i) = eosvmin ;
            }
          }

          if (eosvmax != (0.0 as Real_t)) {
            for(var i:Index_t=0n ; i<length ; ++i) {
              if (vnewc(i) > eosvmax)
                vnewc(i) = eosvmax ;
            }
          }

          for (var i:Index_t=0n; i<length; ++i) {
            val zn = domain.matElemlist(i) ;
            var vc:Real_t = domain.v(zn) ;
            if (eosvmin != (0. as Real_t)) {
              if (vc < eosvmin)
                vc = eosvmin ;
            }
            if (eosvmax != (0. as Real_t)) {
              if (vc > eosvmax)
                vc = eosvmax ;
            }
            if (vc <= 0.) {
            	Console.OUT.println("ApplyMaterialPropertiesForElems vc= " + vc);
              System.setExitCode(VolumeError) ;
              throw new VolumeException();
            }
          }

          EvalEOSForElems(vnewc, length);
        }
}

@Inline public static def UpdateVolumesForElems() {
        val numElem = domain.numElem();
        if (numElem != 0n) {
          val v_cut = domain.v_cut();

          for(var i:Index_t=0n ; i<numElem ; ++i) {
            var tmpV:Real_t ;
            tmpV = domain.vnew(i) ;

            if ( Math.abs(tmpV - (1.0 as Real_t)) < v_cut )
              tmpV = (1.0 as Real_t) ;
            domain.m_v(i) = tmpV ;
          }
        }

        return ;
}

@Inline public static def LagrangeElements() {
        val deltatime = domain.deltatime() ;

        CalcLagrangeElements(deltatime) ;

        /* Calculate Q.  (Monotonic q option requires communication) */
        CalcQForElems() ;

        ApplyMaterialPropertiesForElems() ;

        UpdateVolumesForElems() ;
}

@Inline public static def CalcCourantConstraintForElems() {
        var dtcourant:Real_t = (1.0e+20 as Real_t) ;
        var courant_elem:Index_t = -1n ;
        val qqc = domain.qqc() ;
        val length = domain.numElem() ;

        val  qqc2 = (64.0 as Real_t) * qqc * qqc ;

        for (var i:Index_t = 0n ; i < length ; ++i) {
          val indx = domain.matElemlist(i) ;

          var dtf:Real_t = domain.ss(indx) * domain.ss(indx) ;

          if ( domain.vdov(indx) < (0. as Real_t) ) {

            dtf = dtf
            + qqc2 * domain.arealg(indx) * domain.arealg(indx)
            * domain.vdov(indx) * domain.vdov(indx) ;
          }

          dtf = SQRT(dtf) ;

          dtf = domain.arealg(indx) / dtf ;

          /* determine minimum timestep with its corresponding elem */
          if (domain.vdov(indx) != (0. as Real_t)) {
        	  //Console.OUT.printf("arealg***** = %0.30f", domain.arealg(indx));
            if ( dtf < dtcourant ) {
              dtcourant = dtf ;
              courant_elem = indx ;
            }
          }
        }

        /* Don't try to register a time constraint if none of the elements
         * were active */
        if (courant_elem != -1n) {
          domain.m_dtcourant = dtcourant ;
        }

        return ;
}

@Inline public static def CalcHydroConstraintForElems() {
        var dthydro:Real_t = (1.0e+20 as Real_t) ;
        var hydro_elem:Index_t = -1n ;
        val dvovmax = domain.dvovmax() ;
        val length = domain.numElem() ;

        for (var i:Index_t = 0n ; i < length ; ++i) {
          val indx = domain.matElemlist(i) ;

          if (domain.vdov(indx) != (0.0 as Real_t)) {
            val dtdvov = dvovmax / (Math.abs(domain.vdov(indx))+(1.e-20 as Real_t)) ;
            if ( dthydro > dtdvov ) {
              dthydro = dtdvov ;
              hydro_elem = indx ;
            }
          }
        }

        if (hydro_elem != -1n) {
          domain.m_dthydro = dthydro ;
        }

        return ;
}

@Inline public static def CalcTimeConstraintsForElems() {
        /* evaluate time constraint */
        CalcCourantConstraintForElems() ;

        /* check hydro constraint */
        CalcHydroConstraintForElems() ;
}

@Inline public static def LagrangeLeapFrog() {
        /* calculate nodal forces, accelerations, velocities, positions, with
         * applied boundary conditions and slide surface considerations */
//          var start:Long = Timer.milliTime();  //***時間測定開始
        LagrangeNodal(); //***メソッド呼び出し
//        Console.OUT.println("  LagrangeNodal time = " + (Timer.milliTime() - start));

        /* calculate element quantities (i.e. velocity gradient & q), and update
         * material states */
//          start = Timer.milliTime();
        LagrangeElements();
//        Console.OUT.println("  LagrangeElements time = " + (Timer.milliTime() - start));

//          start = Timer.milliTime();
        CalcTimeConstraintsForElems();
//        Console.OUT.println("  TimeConstraints time = " + (Timer.milliTime() - start));
        // LagrangeRelease() ;  Creation/destruction of temps may be important to capture 
}

public static def main(args: Rail[String]) {
    var edgeElems:Index_t = 45n;
    var edgeNodes:Index_t = edgeElems+1n;
    
    var tx:Real_t, ty:Real_t, tz:Real_t;
    var nidx:Index_t, zidx:Index_t;
    var domElems:Index_t;
    
    domain.m_sizeX = edgeElems;
    domain.m_sizeY = edgeElems;
    domain.m_sizeZ = edgeElems;
    
    domain.m_numElem = edgeElems*edgeElems*edgeElems;
    domain.m_numNode = edgeNodes*edgeNodes*edgeNodes;
    
    domElems = domain.numElem();
    
    domain.AllocateElemPersistent(domain.numElem());
    domain.AllocateElemTemporary (domain.numElem());

    domain.AllocateNodalPersistent(domain.numNode());
    domain.AllocateNodesets(edgeNodes*edgeNodes);
    
    nidx = 0n;
    tz = 0. as Real_t;
    for(var plane:Index_t = 0n; plane < edgeNodes; ++plane){
    	ty = 0. as Real_t;
    	for(var row:Index_t = 0n; row < edgeNodes; ++row){
    		tx = 0. as Real_t;
    		for(var col:Index_t = 0n; col < edgeNodes; ++col){
    			domain.m_x(nidx) = tx;
    			domain.m_y(nidx) = ty;
    			domain.m_z(nidx) = tz;
    			++nidx;
    			tx = (1.125 as Real_t) * ((col+1) as Real_t) / (edgeElems as Real_t);
    		}
    		ty = (1.125 as Real_t) * ((row+1) as Real_t) / (edgeElems as Real_t);
    	}
    	tz = (1.125 as Real_t) * ((plane+1) as Real_t) / (edgeElems as Real_t);
    }
    
    nidx = 0n;
    zidx = 0n;
    for(var plane:Index_t = 0n; plane < edgeElems; ++plane){
    	for(var row:Index_t = 0n; row < edgeElems; ++row){
    		for(var col:Index_t = 0n; col < edgeElems; ++col){
    			val localNode = domain.nodelist();
    			localNode(zidx, 0) = nidx;
    			localNode(zidx, 1) = nidx + 1n;
    			localNode(zidx, 2) = nidx + edgeNodes + 1n;
    			localNode(zidx, 3) = nidx + edgeNodes;
    			localNode(zidx, 4) = nidx + edgeNodes*edgeNodes;
    			localNode(zidx, 5) = nidx + edgeNodes*edgeNodes + 1n;
    			localNode(zidx, 6) = nidx + edgeNodes*edgeNodes + edgeNodes + 1n;
    			localNode(zidx, 7) = nidx + edgeNodes*edgeNodes + edgeNodes;
    			++zidx;
    			++nidx;
    		}
    		++nidx;
    	}
    	nidx += edgeNodes;
    }
    
    for(var i:Index_t=0n; i < domElems; ++i){
    	domain.m_matElemlist(i) = i;
    }
    
    domain.m_dtfixed = (-1.0e-7 as Real_t);
    domain.m_deltatime = (1.0e-7 as Real_t);
    domain.m_deltatimemultlb = (1.1 as Real_t);
    domain.m_deltatimemultub = (1.2 as Real_t);
    domain.m_stoptime  = (1.0e-2 as Real_t);
    domain.m_dtcourant = (1.0e+20 as Real_t);
    domain.m_dthydro   = (1.0e+20 as Real_t);
    domain.m_dtmax     = (1.0e-2 as Real_t);
    domain.m_time    = (0. as Real_t);
    domain.m_cycle   = 0n;

    domain.m_e_cut = (1.0e-7 as Real_t);
    domain.m_p_cut = (1.0e-7 as Real_t);
    domain.m_q_cut = (1.0e-7 as Real_t);
    domain.m_u_cut = (1.0e-7 as Real_t);
    domain.m_v_cut = (1.0e-10 as Real_t);

    domain.m_hgcoef      = (3.0 as Real_t);
    domain.m_ss4o3       = (4.0 as Real_t)/(3.0 as Real_t);

    domain.m_qstop              =  (1.0e+12 as Real_t);
    domain.m_monoq_max_slope    =  (1.0 as Real_t);
    domain.m_monoq_limiter_mult =  (2.0 as Real_t);
    domain.m_qlc_monoq          = (0.5 as Real_t);
    domain.m_qqc_monoq          = (2.0 as Real_t)/(3.0 as Real_t);
    domain.m_qqc                = (2.0 as Real_t);

    domain.m_pmin =  (0. as Real_t);
    domain.m_emin = (-1.0e+15 as Real_t);

    domain.m_dvovmax =  (0.1 as Real_t);

    domain.m_eosvmax =  (1.0e+9 as Real_t);
    domain.m_eosvmin =  (1.0e-9 as Real_t);

    domain.m_refdens =  (1.0 as Real_t);
    
    for(var i:Index_t = 0n; i < domElems; ++i){
    	var x_local:Rail[Real_t] = new Rail[Real_t](8);
    	var y_local:Rail[Real_t] = new Rail[Real_t](8);
    	var z_local:Rail[Real_t] = new Rail[Real_t](8);
    	var elemToNode:Array_2[Index_t] = domain.nodelist() ;
    	for( var lnode:Index_t=0n ; lnode<8 ; ++lnode )
    	{
    		val gnode = elemToNode(i, lnode);
    		x_local(lnode) = domain.x(gnode);
    		y_local(lnode) = domain.y(gnode);
    		z_local(lnode) = domain.z(gnode);
    	}
    	
    	var volume:Real_t = CalcElemVolume(x_local, y_local, z_local);
    	domain.m_volo(i) = volume;
    	domain.m_elemMass(i) = volume;
    	for(var j:Index_t = 0n; j < 8n; ++j){
    		var idx:Index_t = elemToNode(i, j);
    		domain.m_nodalMass(idx) += volume / 8.0 as Real_t;
    	}
    }
    
    domain.m_e(0) = 3.948746e+7 as Real_t;
    
    nidx = 0n;
    for(var i:Index_t = 0n; i < edgeNodes; ++i){
    	var planeInc:Index_t = i*edgeNodes*edgeNodes;
    	var rowInc:Index_t = i*edgeNodes;
    	for(var j:Index_t = 0n; j < edgeNodes; ++j){
    		domain.m_symmX(nidx) = planeInc + j*edgeNodes;
    		domain.m_symmY(nidx) = planeInc + j;
    		domain.m_symmZ(nidx) = rowInc + j;
    		++nidx;
    	}
    }
    
    domain.m_lxim(0) = 0n;
    for(var i:Index_t = 1n; i < domElems; ++i){
    	domain.m_lxim(i) = i-1n;
    	domain.m_lxip(i-1n) = i;
    }
    domain.m_lxip(domElems-1n) = domElems-1n;
    
    for (var i:Index_t = 0n; i<edgeElems; ++i) {
       domain.m_letam(i) = i ; 
       domain.m_letap(domElems-edgeElems+i) = domElems-edgeElems+i ;
    }
    
    for(var i:Index_t = edgeElems; i < domElems; ++i){
       domain.m_letam(i) = i-edgeElems ;
       domain.m_letap(i-edgeElems) = i ;
    }
    for(var i:Index_t = 0n; i < edgeElems*edgeElems; ++i){
       domain.m_lzetam(i) = i ;
       domain.m_lzetap(domElems-edgeElems*edgeElems+i) = domElems-edgeElems*edgeElems+i ;
    }
    for(var i:Index_t = edgeElems*edgeElems; i < domElems; ++i){
    	domain.m_lzetam(i) = i - edgeElems*edgeElems;
    	domain.m_lzetap(i-edgeElems*edgeElems) = i;
    }
    
    for(var i:Index_t = 0n; i < domElems; ++i){
    	domain.m_elemBC(i) = 0n;
    }
    
    for(var i:Index_t = 0n; i < edgeElems; ++i){
    	var planeInc:Index_t = i*edgeElems*edgeElems;
    	var rowInc:Index_t = i*edgeElems;
    	for(var j:Index_t = 0n; j < edgeElems; ++j){
    		domain.m_elemBC(planeInc + j*edgeElems) |= XI_M_SYMM;
    		domain.m_elemBC(planeInc+j*edgeElems+edgeElems-1n) |= XI_P_FREE;
    		domain.m_elemBC(planeInc+j) |= ETA_M_SYMM;
    		domain.m_elemBC(planeInc+j+edgeElems*edgeElems-edgeElems) |= ETA_P_FREE;
    		domain.m_elemBC(rowInc+j) |= ZETA_M_SYMM;
    		domain.m_elemBC(rowInc+j+domElems-edgeElems*edgeElems) |= ZETA_P_FREE;
    	}
    }
    
    var iter:int = 0n;
    //var kaisu: int = 0n;

var starttime:Long = Timer.milliTime();
/*if LULESH_OUTPUT_FILE*/
val outputFile = "/tmp/luleshX10output";
val outputHandle = new File(outputFile);
val outputPrinter = outputHandle.printer(Boolean.TRUE);
/**/
    while(domain.time() < domain.stoptime()){
    	
//    	var start:Long = Timer.milliTime();
    	TimeIncrement() ;
//    	Console.OUT.println("TI time = " + (Timer.milliTime() - start));
//    	start = Timer.milliTime();
    	LagrangeLeapFrog() ;
//    	Console.OUT.println("LagrangeLeapfrog time = " + (Timer.milliTime() - start));
    	
    	if (LULESH_SHOW_PROGRESS) {
    		Console.OUT.println("time =" + domain.time().toString() + ", dt=" + domain.deltatime().toString());
    	}
    	
    	iter++;
/*if LULESH_OUTPUT_FILE*/
        outputPrinter.printf("Iteration %d\n", iter);
    	for(var index:int = 0n; index < domain.numElem(); index++){
    		outputPrinter.printf("x=%f, y=%f, z=%f, fx=%f, fy=%f, fz=%f\n", domain.x(index), domain.y(index), domain.z(index), domain.fx(index), domain.fy(index), domain.fz(index));
    	}
/**/
    }
/*if LULESH_OUTPUT_FILE*/
    outputPrinter.flush();
    outputPrinter.close();
/**/
    Console.OUT.println("total time = " + ((Timer.milliTime() - starttime) / 1000n));
}

    
}
