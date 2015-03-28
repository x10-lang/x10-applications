/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2013-2014.
 */
package com.ibm.m3rlite.example;

import x10.util.Random;
import x10.util.logging.LogFactory;
import x10.io.Printer;
import x10.array.DenseIterationSpace_2;

/**
 * A direct implementation of HMMs, forward and backward algorithms, and the 
 * Baum Welch forward/backward algorithm for HMM training.
 * 
 * <p>An HMM model is a triple <pi, trans, emit> where pi is a vector of  of 
 * size S, trans a transition probability matrix of size S x S, and emit a 
 * matrix of size S x O specifying the probability of emitting a symbol in a 
 * given state. All elements are doubles. 
 * 
 * <p> The code is based on Larry Rabiner "A Tutorial on Hidden Markov Models
 * and Selected Applications in Speech Recognition", Proceedings of the IEEE, 
 * Vol 77, No 2, February 1989. We have followed the same naming conventions
 * for model elements <pi,a,b> and indices, in order to make the correspondence
 * of the code with his description quite clear.
 * 
 * TODO: Look into representing probabilities with logs, to avoid underflow.
 * 
 * TODO: Look into whether its worth avoiding the allocation of the alpha and 
 * beta matrices for each sample, reusing matrices instead. Note: the length of
 * different samples may be different. Profile and determine.
 * 
 * @author vj
 * @author tchiba
 */
public class HMMModel(S:Int, O:Int) {

	private static val logger = LogFactory.getLog[HMMModel]();

	static type Probability = Double;
	
	static type Matrix = x10.array.Array_2[Probability];
	static type Matrix(m:Long, n:Long) = Matrix{self.numElems_1==m, self.numElems_2==n};
	
	static type Vector = x10.array.Array_1[Probability];
	static type Vectory(m:Long) = Vector;
	
	public static type Obs = Rail[Int/*(obs)*/];
	
	public val states = 0..(S-1);
	public val obs = 0..(O-1);
	public val SS = S as Long;
	public val OO = O as Long;
	
	/**
	 * a(i,j) specifies the probability of transition from state i to state j.
	 * Rows must sum to 1.0.
	 */
	public val a = new Matrix(SS,SS);
	/**
	 * b(i,j) specifies the probability of emitting symbol j in state i.
	 * We will assume that each state emits some symbols (two states may 
	 * emit the same symbol), hence the rows must sum to 1.0.
	 */
	public val b = new Matrix(SS,OO);
	/**
	 * pi(i) is the probability of starting in state j. Sum of vector should be 1.0.
	 */
	public val pi = new Vector(SS);  
	/**
	 * Generate a random model. Useful for initializing training, and also
	 * for estimating distance between two arbitrary HMMModel(S,O)'s.
	 */
	public static def makeRandomModel(S:Int,O:Int,seed:Long):HMMModel(S,O) {
		val model = new HMMModel(S,O);
		model.initRandom(seed);
		return model;
	}

	/**
	 * CustomModel can customize a transition,emit,and pi.
	 */
	public static def makeCustomModel(S:Int,O:Int,pi:Vector):HMMModel(S,O) {
		val model = new HMMModel(S,O);
		val ms = 1.0f/S, mo = 1.0f/O;
		
		x10.array.Array.copy(pi, model.pi);
		model.a.fill(ms);
		model.b.fill(mo);
		
		return model;
	}
	
	public static def makeCustomModel(S:Int,O:Int,pi:Vector, a:Matrix, b:Matrix):HMMModel(S,O) {
		val model = new HMMModel(S,O);
		val ms = 1.0f/S, mo = 1.0f/O;
		
		x10.array.Array.copy(pi, model.pi);
		x10.array.Array.copy(a, model.a);
		x10.array.Array.copy(b, model.b);
		
		return model;
	}
	
	/**
	 * The stupid model can start in any state, make a transition to any
	 * state and emit any symbol, with equal probability.
	 */
	public static def makeStupidModel(S:Int,O:Int):HMMModel(S,O) {
		val model = new HMMModel(S,O), ms = 1.0f/S, mo = 1.0f/O;
		model.pi.fill(ms);
		model.a.fill(ms);
		model.b.fill(mo);
		return model;
	}
	public static def makeRandomModel(S:Int,O:Int):HMMModel(S,O) {
		val model = new HMMModel(S,O);
		model.initRandom();
		return model;
	}
	public def copy():HMMModel(S,O) {
		val result = new HMMModel(S,O);
		result.setTo(this);
		return result;
	}
	public def setTo(src:HMMModel(S,O)) {
		x10.array.Array.copy(src.pi, pi);
		x10.array.Array.copy(src.a, a);
		x10.array.Array.copy(src.b, b);
	}
	public def setToSum(src1:HMMModel(S,O), src2:HMMModel(S,O)) {
		for(q in pi.indices()) pi(q) = src1.pi(q) + src2.pi(q);
		for(qr in a.indices()) a(qr) = src1.a(qr) + src2.a(qr);
		for(qo in b.indices()) b(qo) = src1.b(qo) + src2.b(qo);
	}
	public def addIn(src:HMMModel(S,O)) {
		setToSum(this,src);
	}
	public def setToZero() {
		pi.clear();
		a.clear();
		b.clear();
	}
	
	public def initRandom():void { initRandom(new Random(0)); }
	def initRandom(seed:Long):void { initRandom(new Random(seed)); }
	def initRandom(rand:Random):void {
		a.map(a, (Probability)=>rand.nextDouble());
		b.map(b, (Probability)=>rand.nextDouble());
		pi.map(pi, (Probability)=>rand.nextDouble());
		normalize();
	}

	/**
	 * Normalize this model. 
	 * <p>The sum of the pi vector must be one -- they are
	 * probabilities. 
	 * <p>The sum of each row in emit must be 1 -- each state emits a symbol with
	 * some probability.
	 * <p>The sum of each row in trans must be 1 -- each state transitions to 
	 * another with some probability.
	 */
	def normalize() {
		for (i in states) {
			var sum:Double = 0.0; for (j in states) sum += a(i,j);
			for (j in states) a(i,j) /= sum;
		}
		for (i in states) {
			var sum:Double = 0.0; for (o in obs) sum += b(i,o);
			for (o in obs) b(i,o) /= sum;
		}
		// var sum:Double = 0.0; for (i in states) sum += pi(i);
		val sum = pi.reduce((x:Double,y:Double)=>x+y, 0.0);
		for (i in states) pi(i) /= sum;
	}

	/**
	 * Determine the distance between two models. Takes the sum
	 * of the square-roots of the distance of the transition and emit
	 * matrices. Works only for two HMMModel(S,O)'s. 
	 * 
	 * <p>Other distance metrics have also been defined and should be investigated.
	 */
	public def distance(t:HMMModel(S,O)):Double {
		var x:Double = 0.0;
				
		for (qr in a.indices()) {
			val a = t.a(qr) - a(qr);
			x += a*a;
		}
		var y:Double = 0.0;
		
		for (qo in b.indices()) {
			val a = t.b(qo) - b(qo);
			y += a*a;
		}
		return Math.sqrt(x) + Math.sqrt(y);
	}

	/**
	 * Given an observation o of length tmax, compute in alpha(t,q), for t in 
	 * min..min+tmax-1, q in states, the probability that the process has generated the 
	 * prefix x(min)..x(t) and entered state q. This is easily computed with 
	 * dynamic programming, the so-called "forward algorithm" for HMMs.
	 * <p> See Rabiner tutorial, page 262
	 */
	public def forward(x:Obs):Matrix {
		val alpha = new Matrix(x.size, SS);
		forward(x, alpha);
		return alpha;
	}
	
	public def forward(O:Obs, alpha:Matrix):void {
		val min = O.range().min, max = O.range().max;
		if (O(min) >= 144) {
			if (logger.isTraceEnabled()) {
				logger.trace(" golden obs=" + O);
			}
		}
		for (i in states) alpha(min, i) = pi(i)*b(i,O(min));
		for (t in O.range()) {
			for (j in states) {
				if (t+1 <= max){
					var prob:Double = 0.0;
					for (i in states) prob += alpha(t,i)*a(i,j);
					alpha(t+1,j) = prob*b(j,O(t+1));
				}
			}
		}
	}
	
	public static struct StateAndProb(state:Int, prob:Double) {
		public def toString():String="<SP s=" + state + " p=" + prob+">";
	}
	
	/**
	 * Return the state at the end of the single best sequence of states
	 * that exhibits the observation x, together with the probability
	 * of that state. See Rabiner tutorial, page 264. We do not keep
	 * track of the whole most probable sequence, just the final state.
	 */
	public def viterbi(x:Obs):StateAndProb = viterbi(x, new Matrix(x.size, SS));
	def viterbi(O:Obs, delta:Matrix):StateAndProb {
		val min = O.range().min, max = O.range().max;
		for (i in states) delta(min,i) = pi(i)*b(i,O(min));
		for (t in O.range()) {
			for (j in states) {
				if (t > min) {
					var maxIndex:Long = 0, maxVal:Double = 0.0;
					for (i in states) {
						val v = delta(t-1, i)*a(i,j);
						if (v > maxVal) {
							maxIndex = i;
							maxVal = v;
						}
					}
					delta(t,j) = maxVal*b(j,O(t));
				}
			}
		}
		var maxIndex:Int = 1N; 
		var maxVal:Double = delta(max,maxIndex);
		for (i in states) {
			if (i > 1) {
				if (delta(max,i) > maxVal) {
					maxIndex = i as Int;
					maxVal = delta(max,i);
				}
			}
		}
		return StateAndProb(maxIndex, maxVal);
	}

	
	/**
	 * Given an observation x of length tmax, compute in beta(t,q), for t in 
	 * min..tmax, q in states, the probability that the process starting in state q 
	 * at time t can generate the suffix x(t+1)...x(tmax). This is easily 
	 * computed with dynamic programming, the so-called "backward algorithm"
	 * for HMMs.
	 * <p> See Rabiner tutorial, p 263
	 */
	public def backward(o:Obs):Matrix {
		//val beta = new Matrix(x10.regionarray.Region.make(o.range(),states));
		val beta = new Matrix(o.size, SS);
		backward(o, beta);
		return beta;
	}
	
	def backward(O:Obs, beta:Matrix):void {
		for (q in states) beta(O.size-1,q) = 1.0;
		
		for (t0 in O.range()) {
			for (i in states) {
				if (t0 > 0) {
					val t = O.size-1-t0; // count down
					for (j in states) beta(t,i) += a(i,j)*b(j,O(t+1))*beta(t+1,j);
				}
			}
		}
	}
	
	public def update(x:Obs, result:HMMModel):void {
		val temp = new HMMModel(S,O);
		
		val alpha = forward(x), beta = backward(x), min = x.range().min;
		val prob = likelihood(x, alpha);
		if (logger.isTraceEnabled()) {
			logger.trace("x=" + x + " prob=" + prob);

			for (i in x.range()) {
				var sum:Double = 0.0;
				for (j in states) {
					sum += alpha(i,j)*beta(i,j);
				}
				assert (Math.abs(sum-prob) <= 0.1) : 
					"update: x=" + x + " i=" + i + " sum(gamma)=" + sum + " prob=" + prob + " diff=" + (sum-prob);
			}
		}
		val gamma = new Matrix(x.size, SS);
		for (ti in gamma.indices()) {
			gamma(ti) = alpha(ti) * beta(ti) / prob;
		}
		
		if (logger.isTraceEnabled()) {
			print2(Console.ERR, alpha, " alpha:");
			print2b(Console.ERR, beta, " beta:");
			print2(Console.ERR, gamma, " gamma:");
		}
		temp.setToZero();
		for (i in states) temp.pi(i) = gamma(0,i);

		for (i in states) {
			for (j in states) {
				var sum:Double = 0.0, sum2:Double = 0.0;
				for (t in x.range()) {
					if (t < x.size-1) {
						sum += alpha(t,i)*a(i,j)*b(j,x(t+1))*beta(t+1,j);
						sum2 += gamma(t,i);
					}
				}
				temp.a(i,j) = sum/(prob*sum2);
			} 
		} 

		for (j in states) {
			for (k in obs) {
				var sum1:Double = 0.0,sum2:Double = 0.0;
				for (t in x.range()) {
					if (x(t) == k as Int) sum1 += gamma(t,j);
					sum2 += gamma(t,j);
				}
				temp.b(j,k) = sum1/sum2;
			}
		}
		if (logger.isTraceEnabled()) {
			temp.print(Console.ERR, "update: model contribution for " + x);
		}
		result.addIn(temp);
	}
	
	
	/**
	 * Accumulate in result the contribution due to each observation in xs. The
	 * workhorse of the Baum Welch forward/backward algorithm for training an 
	 * HMM. 
	 * <p> See Rabiner tutorial, p 264 and 265.
	 */
	public def update(xs:Rail[Obs], result:HMMModel):void {
		val temp = new HMMModel(S,O);
		for (x in xs) {
			if (x == null) continue;
			
			val alpha = forward(x), beta = backward(x), min = x.range().min;
			val prob = likelihood(x, alpha);
			if (logger.isTraceEnabled()) {
				logger.trace("x=" + x + " prob=" + prob);

				for (i in x.range()) {
					var sum:Double = 0.0;
					for (j in states) {
						sum += alpha(i,j)*beta(i,j);
					}
					assert (Math.abs(sum-prob) <= 0.1) : 
						"update: x=" + x + " i=" + i + " sum(gamma)=" + sum + " prob=" + prob + " diff=" + (sum-prob);
				}
			}
			val gamma = new Matrix(x.size, SS);
			for (ti in gamma.indices()) {
				gamma(ti) = alpha(ti) * beta(ti) / prob;
			}
			
			if (logger.isTraceEnabled()) {
				print2(Console.ERR, alpha, " alpha:");
				print2b(Console.ERR, beta, " beta:");
				print2(Console.ERR, gamma, " gamma:");
			}
			temp.setToZero();
			for (i in states) temp.pi(i) = gamma(0,i);

			for (i in states) {
				for (j in states) {
					var sum:Double = 0.0, sum2:Double = 0.0;
					for (t in x.range()) {
						if (t < x.size-1) {
							sum += alpha(t,i)*a(i,j)*b(j,x(t+1))*beta(t+1,j);
							sum2 += gamma(t,i);
						}
					}
					temp.a(i,j) = sum/(prob*sum2);
				} 
			} 

			for (j in states) {
				for (k in obs) {
					var sum1:Double = 0.0,sum2:Double = 0.0;
					for (t in x.range()) {
						if (x(t) == k as Int) sum1 += gamma(t,j);
						sum2 += gamma(t,j);
					}
					temp.b(j,k) = sum1/sum2;
				}
			}
			if (logger.isTraceEnabled()) {
				temp.print(Console.ERR, "update: model contribution for " + x);
			}
			result.addIn(temp);
		}
	}

	/**
	 * The probability of this HMM generating the observation x is calculated.
	 * It is simply the sum over all states q of the probabilities of starting 
	 * from any state and terminating q having exhibited x. These probabilities
	 * are calculated by the forward algorithm, hence we simply need to sum
	 * the last row in the alpha matrix.
	 */
	public def likelihood(x:Obs):Probability = likelihood(x,forward(x));
	def likelihood(x:Obs, alpha:Matrix):Probability {
		var prob:Double = 0.0;
		val max = x.range().max;
		for (r in states) prob += alpha(max,r);
		return prob;
	}
	
	/**
	 * Averaged log likelihood of the observations.
	 */
	public def entropy(d:Rail[Obs]):Double {
		var result:Double = 0.0;
		for (x in d) {
			if (x != null) {
				result += Math.log(likelihood(x));
			}
		}
		return -result/d.size;
	}
	
	/**
	 * Select an entry in a(index,...) based on toss.
	 * Consider the entries (which are probabilities) being used to lay out
	 * segments on the number line, end-to-end. The size of the j'th segments is the
	 * value of a(index,j). Then we find which segment toss falls into. 
	 */
	def select(u:Matrix, index:Int, var toss:Probability):Int {
		var i:Long = 0;
		// var i:Long = u.region.min(1);
		while (toss > u(index,i)) { toss -= u(index,i); i++; }
		assert i <= u.numElems_2;
		// assert i <= u.region.max(1);
		return i as Int;
	}

	/**
	 * Select an entry in a based on toss.
	 * Consider the entries (which are probabilities) being used to lay out
	 * segments on the number line, end-to-end. The size of the j'th segment is the
	 * value of the j'th entry. Then we find which segment toss falls.
	 * into. 
	 */
	def select(u:Vector, var toss:Probability):Int {
		var i:Long = 0;
		while (toss > u(i)) { toss -= u(i); i++; }
		assert i < u.size;
		return i as Int;
	}

	/**
	 * Generate an observation sequence of the given size from this model.
	 * This is done by selecting a start state based on the initial probability
	 * distribution pi, and then making n-1 transitions, again based on the
	 * transition probabilities specified by the model (trans). In each state we record
	 * the symbol emitted by the state (again, by using the probability distribution
	 * specified by emit). 
	 * 
	 * <p>The resulting sequence should have higher probability of being emitted
	 * by this HMM than any arbitrary sequence.
	 * <p> See Rabiner Tutorial, p 261.
	 */
	public def genObsSequence(n:Int):Obs {
		val rand = new Random(), result = new Obs(n as Long);
		var state:Int = select(pi, rand.nextDouble()); // starting state
		for (i in result.range()) {
			result(i) = select(b,state,rand.nextDouble());
			if (i as Int == n-1N) break;
			state = select(a,state,rand.nextDouble());
		}
		return result;
	}

	public def print(p:Printer):void { print(p, ""); }
	public def print(p:Printer, s:String):void {
		p.println(s);
		p.println("<HMMModel #" + hashCode() + " S=" + S + " O=" + O + ":");
		print1(p, pi, " pi: " ); 
		print2(p, a, " a:");
		//print2b(p, b, " b:");
		print2(p, b, " b:");
		p.println(">");
	}

	public static def print1(p:Printer, a:Vector, name:String) {
		p.print(name);
		p.print("[ ");
		for (q in a.indices()) {
			p.printf("%.2f ", a(q));
		}
		p.println("]");
	}
	public static def print2[T](p:Printer, a:T, name:String) {T <: Matrix} {
		p.println(name);
		for (j in 0..(a.numElems_2-1)) {
			for (i in 0..(a.numElems_1-1)) {
				p.printf("%1.2f ", a(i,j));
			}
			p.println();
		}
		p.println();
	}
	
	/* print2b is special one. */
	public static def print2b[T](p:Printer, a:T, name:String) {T <: Matrix} {
		p.println(name);
	}
}

public type HMMModel(S:Int, O:Int) = HMMModel{self.S==S, self.O==O};