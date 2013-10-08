/// \file
/// Frequently needed typedefs.

package comd;

public class MyTypes {
    public static type real_t = Double;	// determines whether single or double precision
    public static val real_t0 = 0.0;
    public static val FMT1 = "%g";
    public static val EMT1 = "%e";
    public static type real3 = Rail[real_t]{self.size == 3};
    public static def zeroReal3(a:real3):void {
    	a(0) = real_t0;
    	a(1) = real_t0;
    	a(2) = real_t0;
    }
}