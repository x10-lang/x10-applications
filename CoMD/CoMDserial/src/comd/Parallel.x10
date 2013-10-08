/// \file
/// Wrappers for MPI functions.  This should be the only compilation 
/// unit in the code that directly calls MPI functions.  To build a pure
/// serial version of the code with no MPI, do not define DO_MPI.  If
/// DO_MPI is not defined then all MPI functionality is replaced with
/// equivalent single task behavior.

package comd;

import x10.compiler.*;
import x10.util.Team;
import x10.util.Timer;

public class Parallel {

    static class RankReduceData {
    	var value:Double = 0.0;
    	var rank:Long = 0;
    }
    static val myRank = 0;
    static val nRanks = 1;
    /*#ifdef DO_MPI
    #ifdef SINGLE
    #define REAL_MPI_TYPE MPI_FLOAT
    #else
    #define REAL_MPI_TYPE MPI_DOUBLE
    #endif

    #endif*/
    val t:Timer;
    def this() {
        this.t = new Timer();
    }
    
    public def getNRanks():Long {
    	return nRanks;
    }

    public def getMyRank():Long {
    	return myRank;
    }
    
 	/// \details
    /// For now this is just a check for rank 0 but in principle it could be
    /// more complex.  It is also possible to suppress practically all
    /// output by causing this function to return 0 for all ranks.
    public def printRank():boolean {
    	if (myRank == 0) return true;
    	return false;
    }

    public def timestampBarrier(msg:String):void {
    	//barrierParallel();
    	if (!printRank()) return;
        //TODO rewrite the following 
    	//time_t t= time(NULL);
    	//char* timeString = ctime(&t);
    	//timeString[24] = '\0'; // clobber newline
    	//val t = new Timer();
        val timeString = (t.milliTime()/1000).toString();
        Console.OUT.printf("%s: %s\n", timeString, msg);
    }

    public def initParallel(args:Rail[String]):void {
    	//#ifdef DO_MPI
    	//MPI_Init(argc, argv);
    	//MPI_Comm_rank(MPI_COMM_WORLD, &myRank);
    	//MPI_Comm_size(MPI_COMM_WORLD, &nRanks);
    	//#endif
    }

    public def destroyParallel():void {
    	//#ifdef DO_MPI
    	//MPI_Finalize();
    	//#endif
    }

    public def barrierParallel():void {
    	//#ifdef DO_MPI
    	//MPI_Barrier(MPI_COMM_WORLD);
    	//#endif
    }

    /// \param [in]  sendBuf Data to send.
    /// \param [in]  sendLen Number of bytes to send.
    /// \param [in]  dest    Rank in MPI_COMM_WORLD where data will be sent.
    /// \param [out] recvBuf Received data.
    /// \param [in]  recvLen Maximum number of bytes to receive.
    /// \param [in]  source  Rank in MPI_COMM_WORLD from which to receive.
    /// \return Number of bytes received.
    public def sendReceiveParallel[T](sendBuf:Rail[T], sendLen:int, dest:int,
    recvBuf:Rail[T], recvLen:int, source:int):int {
    	//#ifdef DO_MPI
    	//int bytesReceived;
    	//MPI_Status status;
    	//MPI_Sendrecv(sendBuf, sendLen, MPI_BYTE, dest,   0,
    	//recvBuf, recvLen, MPI_BYTE, source, 0,
    	//MPI_COMM_WORLD, &status);
    	//MPI_Get_count(&status, MPI_BYTE, &bytesReceived);

   		//return bytesReceived;
    	//#else
    	assert source == dest;
    	//memcpy(recvBuf, sendBuf, sendLen);
    	val len = Math.min(sendLen, recvLen);
    	Rail.copy[T](sendBuf, 0, recvBuf, 0, len as Long);
    	return len;
    	//#endif
    }

    public def addIntParallel(sendBuf:Rail[Int], recvBuf:Rail[Int], count:Int):void {
    	//#ifdef DO_MPI
    	//MPI_Allreduce(sendBuf, recvBuf, count, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
    	//allreduce[Int](sendBuf, 0, recvBuf, 0, count as Long, Team.ADD);
    	//#else
    	Rail.copy[Int](sendBuf, 0, recvBuf, 0, count as Long);
    	//#endif
    }
    public def addIntParallel1(sendBuf:Int):Int {
        //allrecude[Int](sendBuf, Team.ADD);
        return sendBuf;
    }
    public def addRealParallel(sendBuf:Rail[MyTypes.real_t], recvBuf:Rail[MyTypes.real_t], count:int):void {
    	//#ifdef DO_MPI
    	//MPI_Allreduce(sendBuf, recvBuf, count, REAL_MPI_TYPE, MPI_SUM, MPI_COMM_WORLD);
    	//public def allreduce[Float] (sendBuf, 0, recvBuf, 0, count as Long, Team.ADD)
    	//#else
    	Rail.copy[MyTypes.real_t](sendBuf, 0, recvBuf, 0, count as Long);
    	//#endif
    }

    public def addDoubleParallel(sendBuf:Rail[Double], recvBuf:Rail[Double], count:Int):void {
    	//#ifdef DO_MPI
    	//MPI_Allreduce(sendBuf, recvBuf, count, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);
    	//#else
    	Rail.copy[Double](sendBuf, 0, recvBuf, 0, count as Long);
    	//#endif
    }

    public def maxIntParallel(sendBuf:Rail[int], recvBuf:Rail[int], count:int): void {
    	//#ifdef DO_MPI
    	//MPI_Allreduce(sendBuf, recvBuf, count, MPI_INT, MPI_MAX, MPI_COMM_WORLD);
    	//#else
    	Rail.copy[Int](sendBuf, 0, recvBuf, 0, count as Long);
    	//#endif
    }


    public def minRankDoubleParallel(sendBuf:Rail[RankReduceData], recvBuf:Rail[RankReduceData], count:int):void {
    	//#ifdef DO_MPI
    	//MPI_Allreduce(sendBuf, recvBuf, count, MPI_DOUBLE_INT, MPI_MINLOC, MPI_COMM_WORLD);
    	//#else
    	//for (ii in 0..(count-1)) {
        //    recvBuf(ii) = new RankReduceData();
    	//	recvBuf(ii).value = sendBuf(ii).value;
    	//	recvBuf(ii).rank = sendBuf(ii).rank;
    	//}
        Rail.copy[RankReduceData](sendBuf, 0, recvBuf, 0, count as Long);
    	//#endif
    }

    public def maxRankDoubleParallel(sendBuf:Rail[RankReduceData], recvBuf:Rail[RankReduceData], count:int):void {
    	//#ifdef DO_MPI
    	//MPI_Allreduce(sendBuf, recvBuf, count, MPI_DOUBLE_INT, MPI_MAXLOC, MPI_COMM_WORLD);
    	//#else
    	//for (ii in 0..(count-1)) {
    	//	recvBuf(ii) = new RankReduceData();
    	//	recvBuf(ii).value = sendBuf(ii).value;
    	//	recvBuf(ii).rank = sendBuf(ii).rank;
    	//}
        Rail.copy[RankReduceData](sendBuf, 0, recvBuf, 0, count as Long);
    	//#endif
    }

    /// \param [in] count Length of buf in bytes.
    public def bcastParallel[T](sendBuf:Rail[T], recvBuf:Rail[T], count:Long, root:Long):void {
    	//#ifdef DO_MPI
    	//MPI_Bcast(buf, count, MPI_BYTE, root, MPI_COMM_WORLD);
    	//public def bcast[T] (root:Place, src:Rail[T], src_off:Long, dst:Rail[T], dst_off:Long, count:Long) : void;
    	//#endif
    	Rail.copy[T](sendBuf, 0, recvBuf, 0, count as Long);
    }

    public def builtWithMpi():int {
    	//#ifdef DO_MPI
    	//return 1;
    	//#else
    	return 0n;
    	//#endif
    }



}