package com.ibm.m3rlite.example;
import com.ibm.m3rlite.Job;
import x10.util.Pair;
import x10.util.ArrayList;
import com.ibm.m3rlite.Engine;

import x10.util.Random;



public class KMeansClustering
	implements Job[Long,Long,Long,Long,Long,Rail[Double]]
{
	val data : PlaceLocalHandle[Rail[Double]];
	val clusters : PlaceLocalHandle[Rail[Double]];
	val clusters_prev : PlaceLocalHandle[Rail[Double]];
	val bounds : PlaceLocalHandle[Rail[Long]];
	var N : Long;
	var NC : Long;
	var ND : Long;
	var icheck : GlobalCell[Long];

	public def this(n:Long, nc:Long, nd: Long)
	{
		N = n;
		NC = nc;
		ND = nd;

		data = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](nd*n));
		clusters = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](nd*nc));
		clusters_prev = PlaceLocalHandle.make[Rail[Double]](Place.places(), ()=>new Rail[Double](nd*nc));
		bounds = PlaceLocalHandle.make[Rail[Long]](Place.places(), ()=>new Rail[Long](2));

		icheck = GlobalCell.make[Long](0L);
	}

	public def initBounds()
	{
		finish for(p in Place.places()) at(p) async {
			bounds()(0) = p.id() * N / Place.numPlaces();
			bounds()(1) = (p.id() + 1) * N / Place.numPlaces();
		}
	}

	public def initRandom()
	{
		//currently each place has all data and cluster

		finish for(p in Place.places()) at(p) async {
			var i : Long;
			var j : Long;

			//initialize data
			val rnd = new Random(100);
			for(i=0;i<N;i++){
				for(j=0;j<ND;j++){
					data()(i*ND + j) = rnd.nextDouble();
				}
			}
			//initial clusters
			for(i=0;i<NC;i++){
				for(j=0;j<ND;j++){
					clusters()(i*ND + j) = rnd.nextDouble();
					clusters_prev()(i*ND + j) = clusters()(i*ND + j);
				}
			}
		}
	}

	public def stop():Boolean=icheck() > 0;


	//(K1 = 0, V1 = data ID)
	public def source()= new Iterable[Pair[Long,Long]]() {
		public def iterator() = new Iterator[Pair[Long,Long]]() {
			var idata:Long = bounds()(0);
			public def hasNext() = idata < bounds()(1);
			public def next() = Pair[Long,Long](0,idata++);
		};
	};
	public def partition(k:Long)=k % Place.numPlaces();

	public def sink(s:Iterable[Pair[Long, Rail[Double] ]]): void {
		//distribute center of cluster to all places
		finish for(p in Place.places()) at(p) async {
			val clusters_g = GlobalRef(clusters());

			var j : Long;
			for(kv in s){
				for(j=0;j<ND;j++){
					clusters_g()(kv.first*ND + j) = kv.second(j);
				}
			}
		}

		//convergency check
		var d : Double = 0.0;
		var i : Long;
		var j : Long;
		for(i=0;i<NC;i++){
			for(j=0;j<ND;j++){
				var t : Double = clusters()(i*ND + j) - clusters_prev()(i*ND + j);
				clusters_prev()(i*ND + j) = clusters()(i*ND + j);
				d += t*t;
			}
		}

		//Console.OUT.println("  diff = " + d);
		if(d < 1.0e-8){	//converged
			icheck() = 1;
		}
	}

	// (K2 = cluster ID, V2 = data ID belonging to that cluster)
	public def mapper(k:Long, v:Long, s:(Long,Long)=>void):void {
		var dmin : Double = Double.MAX_VALUE;
		var idmin : Long = -1;
		var i : Long;
		var j : Long;

		//find nearest center of cluster
		for(i=0;i<NC;i++){
			var d : Double = 0.0;
			for(j=0;j<ND;j++){
				val t : Double = clusters()(i*ND + j) - data()(v*ND + j);
				d += t*t;
			}
			if(d < dmin){
				dmin = d;
				idmin = i;
			}
		}
		//nearest cluster id, node id
		s(idmin,v);
	}

	// (K3 = cluster ID, V3 = center of cluster)
	public def reducer(a:Long, b:Iterable[Long], sink:ArrayList[Pair[Long, Rail[Double]]]): void {
		var sum:Double=0.0; 
		var j : Long;

		if (b !=null){
			//update center of clusters
			var pos:Rail[Double] = new Rail[Double](ND,(i:Long)=> 0.0);
			for (x in b){
				sum += 1.0;
				for(j=0;j<ND;j++){
					pos(j) += data()(x*ND + j);
				}
			}
			for(j=0;j<ND;j++){
				pos(j) /= sum;
			}
			sink.add(Pair(a as Long, pos));
		}
	}

	public static def test0(args:Rail[String]){
		val N : Long = args.size > 0 ? Long.parseLong(args(0)) : 1000;
		val NC : Long = args.size > 1 ? Long.parseLong(args(1)) : 10;
		val ND : Long = args.size > 2 ? Long.parseLong(args(2)) : 2;
		var i : Long;
		var j : Long;

		val h=new KMeansClustering(N,NC,ND);

		Console.OUT.println("N = " + N);
		Console.OUT.println("num of Clusters = " + NC);
		Console.OUT.println("dimension = " + ND);

		h.initBounds();
		h.initRandom();

		new Engine(h).run();

		at (Place.places()(0)){
			var ii : Long;
			var jj : Long;

			for(ii=0;ii<NC;ii++){
				Console.OUT.print("Cluster["+ii+"] : ");
				for(jj=0;jj<ND;jj++){
					Console.OUT.print(h.clusters()(ii*ND + jj) + "  ");
				}
				Console.OUT.println(" ");
			}
		}

	}
	public static def main(args:Rail[String]) {
		test0(args);
	}

}