For the serial run,

You can give two parameters of the number of particles and leakage.
For example, give "200000 0.2" in the "X10 program arguments" in 
the Application tab in the run configuration pane.

=================================
For the parallel run,

You need a hostfile under ~/. A hostfile has host names in each line such as
node1
node2
node3
 :

Then, type
$make 
$make run-cpp

You can give two parameters to MCCK: the number of particles and leakage. 
You can also give the number of places. "make run-cpp" runs in one place, 
and uses 2000000 for the number of partilces and 0.2 for the leakage.

You can change these configurations by editing the line of "APPFLAG" in the
Makefile.
