
How to run XSBench version 5

Mikio Takeuchi
IBM Research - Tokyo

2013.8.12



0.  XSBench command line options

./XSBench <#threads> <H-Msize (small or large)>

#threads defaults to #processors
H-Msize defaults to large



1.  OpenMP version  (in src-orig/)


1a. Building

make


1b. Running

./XSBench 1 small


1c.  Cleaning

make clean



2.  X10 version with Managed X10 (in src/)


2a. Building

x10c -O -NO_CHECKS -o XSBench.jar xsbench/*.x10


2b. Running

x10 -cp XSBench.jar xsbench.Main 1 small


2c. Cleaning

rm XSBench.jar



3.  X10 version with Native X10 (in src/)


3a. Building

x10c++ -O -NO_CHECKS -o XSBench -d tmp-x10c++ xsbench/*.x10


3b. Running

./XSBench 1 small


3c. Cleaning

rm XSBench
rm -r tmp-x10c++



--- end of file ---
