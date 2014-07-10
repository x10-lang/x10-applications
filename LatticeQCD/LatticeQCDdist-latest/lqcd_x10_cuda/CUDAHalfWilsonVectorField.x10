import x10.array.Array_1;

public class CUDAHalfWilsonVectorField extends CUDAParallelComplexField {
	def this(x:Long, y:Long, z:Long, t:Long, nid:Long)
	{
		super(x,y,z,t,3,2,1,nid);
	}
}
