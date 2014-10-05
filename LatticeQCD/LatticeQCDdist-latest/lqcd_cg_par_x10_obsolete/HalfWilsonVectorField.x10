import ParallelComplexField;

public class HalfWilsonVectorField extends ParallelComplexField {
	def this(x : Long,y : Long,z : Long,t : Long,nid : long)
	{
		super(x,y,z,t,3,2,1,nid);
	}
}
