How to run MCCK

Michihiro Horie
IBM Research - Tokyo

2013.10.08

================================

0.  MCCK command line options

./MCCK <number of particles> <leakage>

leakage should be less than 1

================================

1.  MPI version  (in src-orig/)


1a. Building

make


1b. Running

./a.out 100000 0.5


1c.  Cleaning

make clean

=================================

2.  X10 version with Native/Managed X10  (in src/)


2a. Preparing hostfile

You need a hostfile under ~/. A hostfile has host names in each line such as
node1
node2
node3
 :


2b. Building

make 

2c. Running

make run-cpp
or
make run-java


2d.  Cleaning

make clean

