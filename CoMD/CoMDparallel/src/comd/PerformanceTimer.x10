package comd;

import x10.io.File;
import x10.io.Printer;
import x10.lang.Math;
import x10.util.Timer;
import x10.compiler.Inline;
/// \file
/// Performance timer functions.
///
/// Use the timer functionality to collect timing and number of calls
/// information for chosen computations (such as force calls) and
/// communication (such as sends, receives, reductions).  Timing results
/// are reported at the end of the run showing overall timings and
/// statistics of timings across ranks.
///
/// A new timer can be added as follows:
/// -# add new handle to the TimerHandle in performanceTimers.h
/// -# provide a corresponding name in timerName
///
/// Note that the order of the handles and names must be the
/// same. This order also determines the order in which the timers are
/// printed. Names can contain leading spaces to show a hierarchical
/// ordering.  Timers with zero calls are omitted from the report.
///
/// Raw timer data is obtained from the getTime() and getTick()
/// functions.  The supplied portable versions of these functions can be
/// replaced with platform specific versions for improved accuracy or
/// lower latency.
/// \see TimerHandle
/// \see getTime
/// \see getTick
///

public class PerformanceTimer {
    /// Timer handles
    static val totalTimer = 0n;
    static val loopTimer = 1n;
    static val timestepTimer = 2n;
    static val positionTimer = 3n;
    static val velocityTimer = 4n;
    static val redistributeTimer = 5n;
    static val atomHaloTimer = 6n;
    static val computeForceTimer = 7n;
    static val eam0 = 8n;
    static val eam1 = 9n;
    static val eam2 = 10n;
    static val eamHaloTimer = 11n;
    static val eam3 = 12n;
    static val commHaloTimer = 13n;
    static val commReduceTimer = 14n;
    static val numberOfTimers = 15n;

    val timerName = [
                     "total",
                  	 "loop",
                     "timestep",
                     "  position",
                     "  velocity",
                     "  redistribute",
                     "    atomHalo",
                     "  force",
                     "    eam0",
                     "    eam1",
                     "    ema2",
                     "    eamHalo",
                     "    eam3",
                     "commHalo",
                     "commReduce"];
    /// Use the startTimer and stopTimer macros for timers in code regions
    /// that may be performance sensitive.  These can be compiled away by
    /// defining NTIMING.  If you are placing a timer anywere outside of a
    /// tight loop, consider calling profileStart and profileStop instead.
    ///
    /// Place calls as follows to collect time for code pieces.
    /// Time is collected everytime this portion of code is executed. 
    ///
    ///     ...
    ///     startTimer(computeForceTimer);
    ///     computeForce(sim);
    ///     stopTimer(computeForceTimer);
    ///     ...
    ///
    val NTIMING = false;
    @Inline public def startTimer(handle:int) {
    	if (!NTIMING) {
            profileStart(handle);
    	}
    }
    @Inline public def stopTimer(handle:int) {
        if (!NTIMING) {
        	profileStop(handle);
        }
    }
    /// Timer data collected.  Also facilitates computing averages and
    /// statistics.
    static class Timers {
        var start:Long;     	//!< call start time
        var total:Long;     	//!< current total time
    	var count:Long;     	//!< current call count
    	var elapsed:Long;   	//!< lap time
    
    	var minRank:Long;       //!< rank with min value
    	var maxRank:Long;       //!< rank with max value

    	var minValue:double;    //!< min over ranks
    	var maxValue:double;    //!< max over ranks
    	var average:double;     //!< average over ranks
    	var stdev:double;       //!< stdev across ranks
    }
    val perfTimer:Rail[Timers];
    val p:Parallel;
    val t:Timer;
    public def this (par:Parallel) {
        this.perfTimer = new Rail[Timers](numberOfTimers);
        for (i in 0..(numberOfTimers-1)) {
            this.perfTimer(i) = new Timers();
        }
        this.p = par;
        this.t = new Timer();
    }
    
    public def profileStart(handle:int):void {
    	perfTimer(handle).start = getTime();
    }

    public def profileStop(handle:int):void {
    	perfTimer(handle).count += 1;
        val delta = getTime() - perfTimer(handle).start;
    	perfTimer(handle).total += delta;
    	perfTimer(handle).elapsed += delta;
    }

    /// \details
    /// Return elapsed time (in seconds) since last call with this handle
    /// and clear for next lap.
    public def getElapsedTime(handle:int):double {
    	val etime = getTick() * (perfTimer(handle).elapsed as double);
    	perfTimer(handle).elapsed = 0l;

    	return etime;
    }

    /// \details
    /// The report contains two blocks.  The upper block is performance
    /// information for the printRank.  The lower block is statistical
    /// information over all ranks.
    public def printPerformanceResults(nGlobalAtoms:int):void {
    	// Collect timer statistics overall and across ranks
       timerStats();
    	if (!p.printRank())
    	return;

    	// only print timers with non-zero values.
    	val tick = getTick();
    	val loopTime = perfTimer(loopTimer).total*tick;
    
    	Console.OUT.printf("\n\nTimings for Rank %d\n", p.getMyRank());
    	Console.OUT.printf("        Timer        # Calls    Avg/Call (s)   Total (s)    %% Loop\n");
    	Console.OUT.printf("___________________________________________________________________\n");
    	for (ii in 0..(numberOfTimers-1)) {
    		val totalTime = perfTimer(ii).total*tick;
    		if (perfTimer(ii).count > 0)
    		Console.OUT.printf("%-16s%12d     %8.4f      %8.4f    %8.2f\n", 
    			timerName(ii),
    			perfTimer(ii).count,
    			totalTime/(perfTimer(ii).count as double),
    			totalTime,
    			totalTime/loopTime*100.0);
    	}
    	Console.OUT.printf("\nTiming Statistics Across %d Ranks:\n", p.getNRanks());
    	Console.OUT.printf("        Timer        Rank: Min(s)       Rank: Max(s)      Avg(s)    Stdev(s)\n");
    	Console.OUT.printf("_____________________________________________________________________________\n");
    	for (ii in 0..(numberOfTimers-1)) {
    		if (perfTimer(ii).count > 0) {
    			Console.OUT.printf("%-16s%6d:%10.4f  %6d:%10.4f", 
    				timerName(ii), 
    				perfTimer(ii).minRank, perfTimer(ii).minValue*tick,
    				perfTimer(ii).maxRank, perfTimer(ii).maxValue*tick
    				);
    			Console.OUT.printf("  %10.4f  %10.4f\n", 
    				perfTimer(ii).average*tick, perfTimer(ii).stdev*tick);
    		}
    	}
    	val atomsPerTask = nGlobalAtoms/(p.getNRanks() as float);
    	val atomRate = perfTimer(computeForceTimer).average * tick * 1e6 /
    		(atomsPerTask * perfTimer(computeForceTimer).count);
    	Console.OUT.printf("\n---------------------------------------------------\n");
    	Console.OUT.printf(" Average atom update rate: %6.2f us/atom/task\n", atomRate);
    	Console.OUT.printf("---------------------------------------------------\n\n");
    }

    public def printPerformanceResultsYaml(out:Printer):void {
    	if (! p.printRank())
    	return;
    
    	val tick = getTick();
    	val loopTime = perfTimer(loopTimer).total*tick;

    	out.printf("\nPerformance Results:\n");
    	out.printf("  TotalRanks: %d\n", p.getNRanks());
    	out.printf("  ReportingTimeUnits: seconds\n");
    	out.printf("Performance Results For Rank %d:\n", p.getMyRank());
    	for (ii in 0..(numberOfTimers-1)) {
    		if (perfTimer(ii).count > 0) {
    			val totalTime = perfTimer(ii).total*tick;
    			out.printf("  Timer: %s\n", timerName(ii));
    			out.printf("    CallCount: %d\n", perfTimer(ii).count); 
    			out.printf("    AvgPerCall: %8.4f\n", totalTime/(perfTimer(ii).count as double));
    			out.printf("    Total: %8.4f\n", totalTime);
    			out.printf("    PercentLoop: %8.2f\n", totalTime/loopTime*100);
    		}
    	}

    	out.printf("Performance Results Across Ranks:\n");
    	for (ii in 0..(numberOfTimers-1)) {
    		if (perfTimer(ii).count > 0) {
    			out.printf("  Timer: %s\n", timerName(ii));
    			out.printf("    MinRank: %d\n", perfTimer(ii).minRank);
    			out.printf("    MinTime: %8.4f\n", perfTimer(ii).minValue*tick);     
    			out.printf("    MaxRank: %d\n", perfTimer(ii).maxRank);
    			out.printf("    MaxTime: %8.4f\n", perfTimer(ii).maxValue*tick);
    			out.printf("    AvgTime: %8.4f\n", perfTimer(ii).average*tick);
    			out.printf("    StdevTime: %8.4f\n", perfTimer(ii).stdev*tick);
    		}
    	}
    	out.printf("\n");
    }

    /// Returns current time as a 64-bit integer.  This portable version
    /// returns the number of microseconds since mindight, Jamuary 1, 1970.
    /// Hence, timing data will have a resolution of 1 microsecond.
    /// Platforms with access to calls with lower latency or higher
    /// resolution (such as a cycle counter) may wish to replace this
    /// implementation and change the conversion factor in getTick as
    /// appropriate.
    /// \see getTick for the conversion factor between the integer time
    /// units of this function and seconds.
    def getTime():Long {
    	return t.nanoTime() / 1000;
    }

    /// Returns the factor for converting the integer time reported by
    /// getTime into seconds.  The portable getTime returns values in units
    /// of microseconds so the conversion is simply 1e-6.
    /// \see getTime
    static def getTick():double {
    	val seconds_per_cycle = 1.0e-6;
    	return seconds_per_cycle; 
    }

    /// Collect timer statistics across ranks.
    def timerStats():void {
       val sendBuf = new Rail[double](numberOfTimers);
    	val recvBuf = new Rail[double](numberOfTimers);
    	// Determine average of each timer across ranks
    	for (ii in 0..(numberOfTimers-1))
    		sendBuf(ii) = (perfTimer(ii).total as double);
    	p.addDoubleParallel(sendBuf, recvBuf, numberOfTimers);

    	for (ii in 0..(numberOfTimers-1))
    		perfTimer(ii).average = recvBuf(ii) / p.getNRanks();

    	// Determine min and max across ranks and which rank
    	val reduceSendBuf = new Rail[Parallel.RankReduceData](numberOfTimers);
    	val reduceRecvBuf = new Rail[Parallel.RankReduceData](numberOfTimers);
    	for (ii in 0..(numberOfTimers-1)) {
            reduceSendBuf(ii) = new Parallel.RankReduceData();
            reduceRecvBuf(ii) = new Parallel.RankReduceData();
    		reduceSendBuf(ii).value = (perfTimer(ii).total as double);
    		reduceSendBuf(ii).rank = p.getMyRank();
    	}
    	p.minRankDoubleParallel(reduceSendBuf, reduceRecvBuf, numberOfTimers);   
    	for (ii in 0..(numberOfTimers-1)) {
    		perfTimer(ii).minValue = reduceRecvBuf(ii).value;
    		perfTimer(ii).minRank = reduceRecvBuf(ii).rank;
    	}
    	p.maxRankDoubleParallel(reduceSendBuf, reduceRecvBuf, numberOfTimers);   
    	for (ii in 0..(numberOfTimers-1)) {
    		perfTimer(ii).maxValue = reduceRecvBuf(ii).value;
    		perfTimer(ii).maxRank = reduceRecvBuf(ii).rank;
    	}
    
    	// Determine standard deviation
    	for (ii in 0..(numberOfTimers-1)) {
    		val temp = (perfTimer(ii).total as double) - perfTimer(ii).average;
    		sendBuf(ii) = temp * temp;
    	}
    	p.addDoubleParallel(sendBuf, recvBuf, numberOfTimers);
    	val m = new Math();
    	for (ii in 0..(numberOfTimers-1)) {
    		perfTimer(ii).stdev = m.sqrt(recvBuf(ii) / (p.getNRanks() as double));
    	}
    }

}