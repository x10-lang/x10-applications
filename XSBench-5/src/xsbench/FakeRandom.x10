package xsbench;

public abstract class FakeRandom {
	
	private static val random = new x10.util.Random();
	
	public static def srand(seed:Long):void {
		random.setSeed(seed);
	}
	
	public static def rand():Double = random.nextInt() as Double;

}
