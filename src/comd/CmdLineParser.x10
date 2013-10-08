/// \file
/// A parser for command line arguments.
///
/// A general purpose command line parser that uses getopt_long() to parse
/// the command line.
///
/// \author Sriram Swaminarayan
/// \date July 24, 2007
/// This X10 version by Hiroki Murata, IBM Research, was translated in September 2013.

package comd;

public class CmdLineParser {

    static class WrappedValue { var s:String; var i:Int; var f:Float; var d:Double; var c:Char;} 

    static class MyOption {
    	var help:String;
    	var longArg:String;
    	var shortArg:Char;
    	var argFlag:Int;
    	var valueType:Char;
    	var sz:Int;
    	var ptr:WrappedValue;
    	var next:MyOption;
    }

    var longest:int = 1n;
    var myargs:MyOption = null;
    var iBase:Int = 129n;

    def myOptionAlloc(longOption:String, shortOption:Char,
    	has_arg:int, valueType:Char, dataPtr:WrappedValue, dataSize:Int, help:String):MyOption {
        val o = new MyOption();
        o.help = help;
        o.longArg = longOption;
        if (shortOption != '\0') o.shortArg = shortOption;
        else {
            o.shortArg = iBase as Char;
            iBase++;
        }
        o.argFlag = has_arg;
        o.valueType = valueType;
        o.ptr = dataPtr;
        o.sz = dataSize;
        if(longOption != null) longest = (longest>(longOption.length())?longest:(longOption.length()));
        return o;
    }

    def nextOption(o:MyOption):MyOption {
        return o.next;
    }
    def lastOption(o:MyOption):MyOption {
    	if (o == null) return o;
        var p:MyOption = o;
    	while(nextOption(p) != null) p = nextOption(p);
    	return p;
    }

    def findOption(o:MyOption, shortArg:Char):MyOption {
    	var p:MyOption = o;
    	while(p != null) {
    		if (p.shortArg == shortArg) return p;
    		p = nextOption(p);
    	}
    	return null;
    }

    public def addArg(longOption:String, shortOption:Char,
    	has_arg:Int, valueType:Char, dataPtr:WrappedValue, dataSize:Int, help:String):void {
    	val o = myOptionAlloc(longOption,shortOption,has_arg,valueType,dataPtr,dataSize, help);
    	if (myargs == null) myargs = o;
    	else {
    		val p = lastOption(myargs);
    		p.next = o;
    	}
    }

    public def printArgs():void {
    	var o:MyOption = myargs;
    	var shortArg:Char;
        Console.OUT.printf("\n"
        				  +"Arguments are: \n");
        val longestRail = new Rail[Any](1);
        longestRail(0) = longest;
        val s = String.format("   --%%-%ds", longestRail);
        while(o != null) {
        	if(o.shortArg < '\255') shortArg = o.shortArg;
        	else shortArg = '-';
        Console.OUT.printf(s,o.longArg);
        Console.OUT.printf(" -%c  arg=%1d type=%c  %s\n",shortArg,o.argFlag,o.valueType,o.help);
        o = nextOption(o);
        }
        Console.OUT.printf("\n\n");
        return;
    }

    class option {
    	var name:String;
    	var has_arg:Int;
    	var flag:Int;
    	var value:Char;
    }
    class optionIndex {
    	var value:Long = 0;
    }
    var optind:Long = 0;
    var optarg:String;
    def getopt_long(args:Rail[String], optString:String, longopts:Rail[option], longindex:optionIndex):Char {
        for (i in (optind..(args.size-1))) {
        	if (args(i).charAt(0n) == '-') {
        		if (args(i).charAt(1n) == '-') {
                    for (var j:Long = 0; j < longopts.size; j++) {
                        if (args(i).equals("--" + longopts(j).name)) {
                        	if (longopts(j).has_arg != 0n) {
                                optarg = args(i + 1);
                                optind = i + 2; 
                        	} else {
                                optind = i + 1;
                        	}
                            return longopts(j).value;
                        }
                    }
                    return '?';
        		}
        		for (var j:Long = 0; j < optString.length(); j++) {
                    if (args(i).charAt(1n) == optString.charAt(j as Int)) {
                        if (j + 1 < optString.length() && optString.charAt((j + 1) as Int) == ':') {
                        	optarg = args(i + 1);
                            optind = i + 2;
                        } else {
                            optind = i + 1;
                        }
                        return optString.charAt(j as Int);
                    }
        		}
        		return '?';
        	}
        	return ((-1) as Char);
        }
        return ((-1) as Char);
    }
    public def processArgs(args:Rail[String]):void {
    	if (myargs == null) return;
    	var o:MyOption = myargs;
        var n:Int = 0n;
    	while(o != null)
    		{n++;o=nextOption(o);}
    	o = myargs;
    	var sArgs:String = "";
    	val opts = new Rail[option](n);
    	for (var i:Long=0; i<n; i++) {
            opts(i) = new option();
    		opts(i).name	= o.longArg;
    		opts(i).has_arg = o.argFlag;
    		opts(i).flag    = 0n;
    		opts(i).value   = o.shortArg;
    		sArgs = sArgs + o.shortArg;
    		if (o.argFlag == 1n) sArgs = sArgs + ":";
            o = nextOption(o);
    	}
    	while(true) {

    		val option_index:optionIndex = new optionIndex();

    		val c = getopt_long (args, sArgs, opts, option_index);
    		if (c == ((-1) as Char)) break;
    		o = findOption(myargs,c);
    		if (o == null) {
    			Console.OUT.printf("\n\n"
    							  +"    invalid switch : -%c in getopt()\n"
    							  +"\n\n",
      							  c);
    			break;
    		}      
    		if(o.argFlag == 0n) {
    			o.ptr.i = 1n;
    		} else {
    			switch(o.valueType) {
    			case 'i':
    				o.ptr.i = Int.parseInt(optarg);
    				break;
    			case 'f':
    				o.ptr.f = Float.parseFloat(optarg);
    				break;
    			case 'd':
                    o.ptr.d = Double.parseDouble(optarg);
                    break;
    			case 's':
                    o.ptr.s = optarg;
                    break;
    			case 'c':
                    o.ptr.c = optarg.charAt(0n);
                    break;
    			default:
    				Console.OUT.printf("\n\n"
    								  +"    invalid type : %c in getopt()\n"
    								  +"    valid values are 'e', 'z'. 'i','d','f','s', and 'c'\n"
    								  +"\n\n",
      								  c);      
    			}
    		}
    	}

    	return;
    }
}