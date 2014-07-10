/// \file
/// Wrappers for MPI functions.  This should be the only compilation 
/// unit in the code that directly calls MPI functions.  To build a pure
/// serial version of the code with no MPI, do not define DO_MPI.  If
/// DO_MPI is not defined then all MPI functionality is replaced with
/// equivalent single task behavior.

package comd;

import x10.util.Team;
import x10.util.Timer;
import x10.util.concurrent.IntLatch;

public class Parallel {

    static class RankReduceData {
    	var value:Double = 0.0;
    	var rank:Long = 0n;
    }

    val t:Timer;
    val team:Team;

    val startLatch:PlaceLocalHandle[Rail[Latch2]];
    val finishLatch:PlaceLocalHandle[Rail[Latch2]];
    val perPLH:PlaceLocalHandle[Rail[PerformanceTimer]];
    
    def this() {
    	this.t = new Timer();
        this.team = Team.WORLD;
        this.startLatch = PlaceLocalHandle.make[Rail[Latch2]](Place.places(), ()=>new Rail[Latch2](Place.numPlaces()));
        this.finishLatch = PlaceLocalHandle.make[Rail[Latch2]](Place.places(), ()=>new Rail[Latch2](Place.numPlaces()));
        this.perPLH = PlaceLocalHandle.make[Rail[PerformanceTimer]](Place.places(), ()=>new Rail[PerformanceTimer](1));
    }
    
    public def getNRanks():Long {
        return team.size();
    }

    public def getMyRank():Long {
        return here.id();
    }
    
 	/// \details
    /// For now this is just a check for rank 0 but in principle it could be
    /// more complex.  It is also possible to suppress practically all
    /// output by causing this function to return 0 for all ranks.
    public def printRank():boolean {
        if (getMyRank() == 0) return true;
        return false;
    }

    public def timestampBarrier(msg:String):void {
    	barrierParallel();
    	if (!printRank()) return;
        val timeString = (t.milliTime()/1000).toString();
        Console.OUT.printf("%s: %s\n", timeString, msg);
    }

    //public def initParallel(args:Rail[String]):void {
    public def initParallel(args:Rail[String], par:Parallel, hep:HaloExchangePlh, pp:(args:Rail[String], par:Parallel, hep:HaloExchangePlh)=>void):void {
        Place.places().broadcastFlat(
            ()=>{
             for(var i:Int = 0n; i < Place.numPlaces() as Int; i++) { 
                  startLatch()(i) = new Latch2();
                  finishLatch()(i) = new Latch2();
                }
              pp(args, par, hep);});
    }

    public def destroyParallel():void {
    }

    public def barrierParallel():void {
        team.barrier();
    }

    /// \param [in]  sendBuf Data to send.
    /// \param [in]  sendLen Number of bytes to send.
    /// \param [in]  dest    Rank in MPI_COMM_WORLD where data will be sent.
    /// \param [out] recvBuf Received data.
    /// \param [in]  recvLen Maximum number of bytes to receive.
    /// \param [in]  source  Rank in MPI_COMM_WORLD from which to receive.
    /// \return Number of bytes received.
    public def sendReceiveParallel[T](sendBuf:PlaceLocalHandle[Rail[T]], sendLen:PlaceLocalHandle[Rail[Int]], dest:Int,
    		recvBuf:PlaceLocalHandle[Rail[T]], recvLen:Int, source:Int, recvdLen:PlaceLocalHandle[Rail[Int]]):int 
    {
    	val len:Int = sendLen()(0);
    	val me = here.id() as Int;
    	if (me == dest && me == source) {
    		Rail.copy[T](sendBuf(), 0, recvBuf(), 0, len as Long);
    		recvdLen()(0) = len;
    	} else {
    		finish {
    			//1. Trigger asyncCopy(me -> dest)
    			at (Place(dest)) async {
    				startLatch()(me).release(); //Notify the "dest" that "me" is ready to send
    			}

    			//2.1. Wait for the "source" ready to send
    			val recvBufferRef = GlobalRail(recvBuf());
              val recvdLenRef = GlobalRail(recvdLen());
    			startLatch()(source).sync(); //Wait for a notification from the "source"
    			// Now both recvBuf at "me" and sendBuf at the "source" are ready for asyncCopy

              //2.2. Perform asyncCopy(source -> me)
    			at (Place(source)) async {
                  val len2 = sendLen()(0);
    				finish {
                     Rail.asyncCopy[T](sendBuf(), 0, recvBufferRef, 0, len2 as Long);
    					Rail.asyncCopy[Int](sendLen(), 0, recvdLenRef, 0, 1);
                    }
    				//recvdLen.value = len2;
    				finishLatch()(me).release(); //Notify the "dest" of the completion of asyncCopy(me -> dest)
    			}
    
    			//3. Wait for a notification of the completion of asyncCopy(source -> me) 
    			finishLatch()(dest).sync();
    		}
    	}
    	return len;
   	}

    public def addIntParallel(sendBuf:Rail[Int], recvBuf:Rail[Int], count:Int):void {
        team.allreduce[Int](sendBuf, 0, recvBuf, 0, count as Long, Team.ADD);
    }

    public def addRealParallel(sendBuf:Rail[MyTypes.real_t], recvBuf:Rail[MyTypes.real_t], count:int):void {
       team.allreduce[MyTypes.real_t](sendBuf, 0, recvBuf, 0, count as Long, Team.ADD);
    }

    public def addDoubleParallel(sendBuf:Rail[Double], recvBuf:Rail[Double], count:Int):void {
       team.allreduce[Double](sendBuf, 0, recvBuf, 0, count as Long, Team.ADD);
    }

    public def maxIntParallel(sendBuf:Rail[int], recvBuf:Rail[int], count:int): void {
        team.allreduce[Int](sendBuf, 0, recvBuf, 0, count as Long, Team.MAX);
    }


    public def minRankDoubleParallel(sendBuf:Rail[RankReduceData], recvBuf:Rail[RankReduceData], count:int):void {
       val sendBuf2 = new Rail[Double](count);
       val recvBuf2 = new Rail[Double](count);
       for (var i:Int = 0n; i < count; i++) {
           sendBuf2(i) = sendBuf(i).value;
        }
       team.allreduce[Double](sendBuf2, 0, recvBuf2, 0, count as Long, Team.MIN);
       for (var i:Int = 0n; i < count; i++) {
           recvBuf(i).rank = team.indexOfMin(sendBuf(i).value, sendBuf(i).rank as Int);
           recvBuf(i).value = recvBuf2(i);
        }
    }

    public def maxRankDoubleParallel(sendBuf:Rail[RankReduceData], recvBuf:Rail[RankReduceData], count:int):void {
    	val sendBuf2 = new Rail[Double](count);
    	val recvBuf2 = new Rail[Double](count);
    	for (var i:Int = 0n; i < count; i++) {
    		sendBuf2(i) = sendBuf(i).value;
    	}
    	team.allreduce[Double](sendBuf2, 0, recvBuf2, 0, count as Long, Team.MAX);
    	for (var i:Int = 0n; i < count; i++) {
    		recvBuf(i).rank = team.indexOfMax(sendBuf(i).value, sendBuf(i).rank as Int);
    		recvBuf(i).value = recvBuf2(i);
    	}
    }

    /// \param [in] count Length of buf in bytes.
    public def bcastParallel[T](sendBuf:Rail[T], recvBuf:Rail[T], count:Long, root:Long):void {
        team.bcast[T](Place(root), sendBuf, 0, recvBuf, 0, count);
    }

    public def builtWithMpi():int {
    	return 1n;
    }
}
