How to run Lattice QCD

Koichi Shirahata
Intern at IBM Research - Tokyo

2013.10.4


1.  C++ version  (in src-orig/)


1a. Building

make c++


1b. Running

./solv_wilson


1c.  Cleaning

make clean



2.  OpenMP version  (in src-orig/)


2a. Building

make omp


2b. Running

./solv_wilson

#before running in OpenMP, set the number of threads to run
e.g. export OMP_NUM_THREADS=4


1c.  Cleaning

make clean



3.  X10 version with Managed X10 (in src/)


3a. Building

make build-java


3b. Running

make run-java

#before running in x10, set the number of threads to run
e.g. export X10_NTHREADS=4


3c. Cleaning

make clean



4.  X10 version with Native X10 (in src/)


4a. Building

make build-cpp


4b. Running

make run-cpp

#before running in x10, set the number of threads to run
e.g. export X10_NTHREADS=4


4c. Cleaning

make clean



--- end of file ---
