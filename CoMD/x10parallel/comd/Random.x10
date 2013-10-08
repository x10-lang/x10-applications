/// \file
///  Simple random number generators for uniform and Gaussian
///  distributions.  The generator in lcg61 and the hash in mkSeed aren't
///  really industrial strength, but they're more than good enough for
///  present purposes.

package comd;
import x10.lang.Math;
public class Random {
    /// \details
    ///  Use the Box-Muller method to sample a Gaussian distribution with
    ///  zero mean and unit variance.  To ensure the same input seed always
    ///  generates the same returned value we do not use the standard
    ///  technique of saving one of the two generated randoms for the next
    ///  call.
    ///
    ///  \param [in,out] seed  Seed for generator.
    ///
    ///  \return A pseudo-random number in the interval (-infinity, infinity).
    public class WrappedULong {
        var value:ULong;
    }
    public def gasdev(seed:WrappedULong):MyTypes.real_t
    {
    	var rsq:MyTypes.real_t,v1:MyTypes.real_t,v2:MyTypes.real_t;
    	do 
    	{
    		v1 = (2.0*lcg61(seed)-1.0) as MyTypes.real_t;
    		v2 = (2.0*lcg61(seed)-1.0) as MyTypes.real_t;
    		rsq = v1*v1+v2*v2;
    	} while (rsq >= 1.0 || rsq == MyTypes.real_t0);

    	return ((v2 as Double)* Math.sqrt(-2.0*Math.log(rsq as Double)/rsq)) as MyTypes.real_t;
    } 
    
    /// \details
    ///  A 61-bit prime modulus linear congruential generator with
    /// modulus = 2^61 -1.
    ///
    ///  \param [in,out] seed  Seed for generator.
    ///
    ///  \return A pseudo-random number in the interval [0, 1].
    public def lcg61(seed:WrappedULong):Double
    {
    	val convertToDouble:Double = 1.0/2305843009213693951ul;

    	seed.value *= 437799614237992725ul;
    	seed.value %= 2305843009213693951ul;

    	return seed.value*convertToDouble;
    }

    /// \details
    ///  Forms a 64-bit seed for lcg61 from the combination of 2 32-bit Knuth
    ///  multiplicative hashes, then runs off 10 values to pass up the worst
    ///  of the early low-bit correlations.
    ///
    ///  \param [in] id An id number such as an atom gid that is unique to
    ///  each entity that requires random numbers.
    ///
    ///  \param [in] callSite A unique number for each call site in the code
    ///  that needs to generate random seeds.  Using a different value for
    ///  callSite allows different parts of the code to obtain different 
    ///  random streams for the same id.
    /// 
    ///  \return A 64-bit seed that is unique to the id and call site.
    public def mkSeed(id:UInt, callSite:UInt):WrappedULong
    {
    val s1:UInt = id * 2654435761un;
    val s2:UInt = (id+callSite) * 2654435761un;

    val iSeed = new WrappedULong();
    iSeed.value = (0x100000000ul * s1) + s2;
    for (var jj:Int=0n; jj<10n; ++jj)
    lcg61(iSeed);
    
    return iSeed;
    }
}