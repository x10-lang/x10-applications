
public class MyRand {
	var myrand_next : Long;

	def this(s : Long)
	{
		myrand_next = s;
	}
	def this()
	{
		myrand_next = 0;
	}

	def get_int() : Long
	{
		var myrand : Long;
		myrand_next = myrand_next*1103515245 + 12345;
		myrand = (myrand_next/65536) & 32767;

		return myrand;
	}

	def get_double() : Double
	{
		var d : Double;
		d = get_int() / 32767.0;
		return d;

	}
}





