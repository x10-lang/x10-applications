/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2014.
 */

/**
 * Handles command line options to LULESH.
 */
public class CommandLineOptions {
    var quiet:Boolean = false;    // -q
    var its:Int = 9999999n;       // -i
    var nx:Long = 30;             // -s
    var numReg:Int = 11n;         // -r
    var balance:Int = 1n;         // -b
    var cost:Int = 1n;            // -c
    var numFiles:Int = ((Place.numPlaces()+10)/9) as Int; // -f
    var showProg:Boolean = false; // -p
    var viz:Boolean = false;      // -v

    /** Parse command line options for LULESH. */
    public static def parse(args:Rail[String]):CommandLineOptions {
        val opts = new CommandLineOptions();

        for (var i:Long = 0; i<args.size; i++) {
            if (args(i).equals("-q")) {
                opts.quiet = true;
            } else if (args(i).equals("-i")) {
                opts.its = parseIntValue(args, i++, "iterations");
            } else if (args(i).equals("-s")) {
                opts.nx = parseIntValue(args, i++, "size, sidelength");
            } else if (args(i).equals("-r")) {
                opts.numReg = parseIntValue(args, i++, "numregions");
            } else if (args(i).equals("-f")) {
                opts.numFiles = parseIntValue(args, i++, "numfilepieces");
            } else if (args(i).equals("-b")) {
                opts.balance = parseIntValue(args, i++, "balance");
            } else if (args(i).equals("-c")) {
                opts.cost = parseIntValue(args, i++, "cost");
            } else if (args(i).equals("-v")) {
                opts.viz = true;
            } else if (args(i).equals("-p")) {
                opts.showProg = true;
            } else if (args(i).equals("-h")) {
                printHelp();
                return null;
            } else {
                printHelp();
                Console.ERR.println("Unknown command line argument: " + args(i));
                return null;
            }
        }
        return opts;
    }

    /** 
     * Given an argument of the format "-arg <argVal>", attempts to parse
     * an integer value from <argVal>.
     * It is assumed that arg is args(argIdx) and argVal is args(argIdx+1).
     * @return the parsed Int value if successful
     * @throws IllegalArgumentException if the value could not be parsed
     */
    private static def parseIntValue(args:Rail[String], argIdx:Long, desc:String):Int {
        try {
            return Int.parseInt(args(argIdx+1));
        } catch (e:Exception) {
            throw new IllegalArgumentException("Error on option "
                + args(argIdx) + " <" + desc + "> integer value required after argument");
        }
    }

    /** Prints usage options for LULESH. */
    protected static def printHelp() {
        Console.OUT.printf("Usage: lulesh [opts]\n");
        Console.OUT.printf(" where [opts] is one or more of:\n");
        Console.OUT.printf(" -q              : quiet mode - suppress all stdout\n");
        Console.OUT.printf(" -i <iterations> : number of cycles to run\n");
        Console.OUT.printf(" -s <size>       : length of cube mesh along side\n");
        Console.OUT.printf(" -r <numregions> : Number of distinct regions (def: 11)\n");
        Console.OUT.printf(" -b <balance>    : Load balance between regions of a domain (def: 1)\n");
        Console.OUT.printf(" -c <cost>       : Extra cost of more expensive regions (def: 1)\n");
        Console.OUT.printf(" -f <numfiles>   : Number of files to split viz dump into (def: (np+10)/9)\n");
        Console.OUT.printf(" -p              : Print out progress\n");
        Console.OUT.printf(" -v              : Output viz file (requires compiling with -DVIZ_MESH\n");
        Console.OUT.printf(" -h              : This message\n");
        Console.OUT.printf("\n");
    }
}
// vim:tabstop=4:shiftwidth=4:expandtab
