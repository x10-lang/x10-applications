/// \file
/// Write simulation information in YAML format.
///
/// Information regarding platform, run parameters, performance, etc.,
/// are written to a file whose name is generated from the CoMDVariant
/// and the time of the run.  This provides a simple mechanism to track
/// and compare performance etc.
///
/// There are much more sophisticated libraries and routines available
/// to handle YAML, but this simple implemenation handles everything we
/// really need.

package comd;

import x10.io.File;
import x10.io.Printer;
import x10.util.Timer;

public class YamlOutput {
	var yamlFile:Printer;
	static val CoMDVersion = "1.1";
	//static val CoMDVariant = "CoMD-serial";
	static val CoMDVariant = "CoMD-parallel";
    val par:Parallel;
    def this(par:Parallel) {
        this.par = par;
    }

	public def getTimeString():String {
		//time_t rawtime;
		//struct tm* timeinfo;
		//time(&rawtime);
		val t = new Timer();
		//timeinfo = localtime(&rawtime);

		//sprintf(timestring,
		//		"%4d-%02i-%02d, %02d:%02d:%02d",
		//		timeinfo->tm_year+1900,
		//		timeinfo->tm_mon+1,
		//		timeinfo->tm_mday,
		//      timeinfo->tm_hour,
		//		timeinfo->tm_min,
		//		timeinfo->tm_sec);
		return (t.milliTime()/1000).toString();
	}

	public def yamlBegin():void {
		if (! par.printRank())
			return;
		//char filename[64];
		//time_t rawtime;
		//time (&rawtime);
		val t = new Timer();
		//struct tm* ptm = localtime(&rawtime);
		//char sdate[25];
		//use tm_mon+1 because tm_mon is 0 .. 11 instead of 1 .. 12
		//sprintf (sdate,"%04d:%02d:%02d-%02d:%02d:%02d",
		//		ptm->tm_year + 1900, ptm->tm_mon+1,
		//		ptm->tm_mday, ptm->tm_hour, ptm->tm_min,ptm->tm_sec);
		//sprintf(filename, "%s.%s.yaml", CoMDVariant, sdate);
		//yamlFile = fopen(filename, "w");
		val filename = CoMDVariant + "." + getTimeString() + ".yaml";
		val file = new File(filename);
		yamlFile = new x10.io.Printer(file.openWrite(true));
	}

	public def yamlAppInfo(out:Printer):void {
		if (! par.printRank())
			return;
		printSeparator(out);
		//fprintf(file,"Mini-Application Name    : %s\n", CoMDVariant);
		//fprintf(file,"Mini-Application Version : %s\n", CoMDVersion);
		//fprintf(file,"Platform:\n");
		//fprintf(file,"  hostname: %s\n",         CoMD_HOSTNAME);
		//fprintf(file,"  kernel name: %s\n",      CoMD_KERNEL_NAME);
		//fprintf(file,"  kernel release: %s\n",   CoMD_KERNEL_RELEASE);
		//fprintf(file,"  processor: %s\n",        CoMD_PROCESSOR);
		//fprintf(file,"Build:\n");
		//fprintf(file,"  CC: %s\n",               CoMD_COMPILER);
		//fprintf(file,"  compiler version: %s\n", CoMD_COMPILER_VERSION);
		//fprintf(file,"  CFLAGS: %s\n",           CoMD_CFLAGS);
		//fprintf(file,"  LDFLAGS: %s\n",          CoMD_LDFLAGS);
		//fprintf(file,"  using MPI: %s\n",        builtWithMpi() ? "true":"false");
		//fprintf(file,"  Threading: none\n");
		//fprintf(file,"  Double Precision: %s\n", (sizeof(real_t)==sizeof(double)?"true":"false"));
		out.printf("Run Date/Time: %s\n", getTimeString());
		out.printf("\n");
		out.flush();
	}

	public def yamlEnd():void {
		if (! par.printRank())
			return;

		yamlFile.close();
	}

	public def printSeparator(out:Printer):void {
		//fprintf(file,"=========================================================================\n");
		out.printf("\n");
	}
}