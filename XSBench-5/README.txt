
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

make build-java

2b. Running

make APPFLAG="1 small" run-java


2c. Cleaning

make clean



3.  X10 version with Native X10 (in src/)


3a. Building

make build-cpp

3b. Running

make APPFLAG="1 small" run-cpp

3c. Cleaning

make clean



--- end of file ---
