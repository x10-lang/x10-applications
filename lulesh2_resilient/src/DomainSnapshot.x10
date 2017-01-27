/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2015.
 */

import x10.util.resilient.localstore.Cloneable;
import x10.util.HashMap;

class DomainSnapshot implements Cloneable {
    private var data:Rail[Double];
    
    public def this(domain:Domain) {
        val numNode = domain.x.size as Long;
        val numElem = domain.e.size as Long;        
        data = new Rail[Double](6*numNode + 6*numElem + 8);
        var srcOff:Long = 0;
        data(srcOff++) = numNode;
        data(srcOff++) = numElem;
        
        data(srcOff++) = domain.dtcourant;
        data(srcOff++) = domain.dthydro;
        data(srcOff++) = domain.cycle;
        data(srcOff++) = domain.time;
        data(srcOff++) = domain.deltatime;
        
        data(srcOff++) = domain.startTimeMillis;
        
        Rail.copy(domain.x , 0, data, srcOff, numNode); srcOff += numNode;
        Rail.copy(domain.y , 0, data, srcOff, numNode); srcOff += numNode;
        Rail.copy(domain.z , 0, data, srcOff, numNode); srcOff += numNode;
        Rail.copy(domain.xd, 0, data, srcOff, numNode); srcOff += numNode;
        Rail.copy(domain.yd, 0, data, srcOff, numNode); srcOff += numNode;
        Rail.copy(domain.zd, 0, data, srcOff, numNode); srcOff += numNode;
        
        
        Rail.copy(domain.e , 0, data, srcOff, numElem); srcOff += numElem;
        Rail.copy(domain.p , 0, data, srcOff, numElem); srcOff += numElem;
        Rail.copy(domain.q , 0, data, srcOff, numElem); srcOff += numElem;
        Rail.copy(domain.ql, 0, data, srcOff, numElem); srcOff += numElem;
        Rail.copy(domain.qq, 0, data, srcOff, numElem); srcOff += numElem;
        Rail.copy(domain.v , 0, data, srcOff, numElem);
    }
    
    public def this(allDate:Rail[Double]) {
        this.data = allDate;
    }

    public def clone():Cloneable {
        return new DomainSnapshot(new Rail[Double](data));
    }
       
    public def populateDomain(domain:Domain){
        var srcOff:Long = 0;   
        val numNode = data(srcOff++) as Long;
        val numElem = data(srcOff++) as Long;
        
        domain.dtcourant = data(srcOff++);
        domain.dthydro = data(srcOff++);
        domain.cycle = data(srcOff++) as Int;
        domain.time = data(srcOff++);
        domain.deltatime = data(srcOff++);
        
        domain.startTimeMillis = data(srcOff++) as Long;
        
        Rail.copy(data, srcOff, domain.x , 0, numNode); srcOff += numNode;
        Rail.copy(data, srcOff, domain.y , 0, numNode); srcOff += numNode;
        Rail.copy(data, srcOff, domain.z , 0, numNode); srcOff += numNode;
        Rail.copy(data, srcOff, domain.xd, 0, numNode); srcOff += numNode;
        Rail.copy(data, srcOff, domain.yd, 0, numNode); srcOff += numNode;
        Rail.copy(data, srcOff, domain.zd, 0, numNode); srcOff += numNode;
        
        
        Rail.copy(data, srcOff, domain.e , 0, numElem); srcOff += numElem;
        Rail.copy(data, srcOff, domain.p , 0, numElem); srcOff += numElem;
        Rail.copy(data, srcOff, domain.q , 0, numElem); srcOff += numElem;
        Rail.copy(data, srcOff, domain.ql, 0, numElem); srcOff += numElem;
        Rail.copy(data, srcOff, domain.qq, 0, numElem); srcOff += numElem;
        Rail.copy(data, srcOff, domain.v , 0, numElem);
    }
}
// vim:tabstop=4:shiftwidth=4:expandtab
