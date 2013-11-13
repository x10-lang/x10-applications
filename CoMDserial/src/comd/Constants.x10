/// \file
/// Contains constants for unit conversions.
///
/// The units for this code are:
///     - Time in femtoseconds (fs)
///     - Length in Angstroms (Angs)
///     - Energy in electron Volts (eV)
///     - Mass read in as Atomic Mass Units (amu) and then converted for
///       consistency (energy*time^2/length^2)
/// Values are taken from NIST, http://physics.nist.gov/cuu/Constants/

package comd;

public class Constants {
    /// 1 amu in kilograms
    static val amuInKilograms:Double = 1.660538921e-27;

    /// 1 fs in seconds
    static val fsInSeconds:Double = 1.0e-15;

    /// 1 Ang in meters
    static val AngsInMeters:Double = 1.0e-10;

    /// 1 eV in Joules
    static val eVInJoules:Double = 1.602176565e-19;

    /// Internal mass units are eV * fs^2 / Ang^2
    static val amuToInternalMass:Double =
    	amuInKilograms * AngsInMeters * AngsInMeters
    	/ (fsInSeconds * fsInSeconds  * eVInJoules);

    /// Boltmann constant in eV's
    static val kB_eV:Double = 8.6173324e-5;  // eV/K

    /// Hartrees to eVs
    static val hartreeToEv:Double = 27.21138505;

    /// Bohrs to Angstroms
    static val bohrToAngs:Double = 0.52917721092;
}