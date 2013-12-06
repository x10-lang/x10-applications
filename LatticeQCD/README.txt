How to run Lattice QCD

Koichi Shirahata
Intern at IBM Research - Tokyo

2013.12.6


source code of LatticeQCD run on
-one place one thread (sequential) is in LatticeQCDseq
-parallel on single place is in LatticeQCDsingleplace
-multiple places is in LatticeQCDdist


Index
1.  C++ version  (in LatticeQCDseq/src-orig/)
2.  OpenMP version  (in LatticeQCDparallel/src-orig/)
3.  X10 version with Managed X10 of sequential version (in LatticeQCDseq/src/)
4.  X10 version with Native X10 of sequential version (in LatticeQCDseq/src/)
5.  X10 version with Managed X10 in parallel on single place (in LatticeQCDparallel/src/)
6.  X10 version with Native X10 in parallel on single place (in LatticeQCDparallel/src/)
7.  X10 version with Managed X10 on multiple places (in LatticeQCDdist/src/)
8.  X10 version with Native X10 on multiple places (in LatticeQCDdist/src/)

9.  latest X10 with Native X10 on multiple places (in LatticeQCDdist-latest)



1.  C++ version  (in LatticeQCDseq/src-orig/)


1a. Building

make c++


1b. Running

./solv_wilson


1c.  Cleaning

make clean



2.  OpenMP version  (in LatticeQCDparallel/src-orig/)


2a. Building

make omp


2b. Running

./solv_wilson

#before running in OpenMP, set the number of threads to run
e.g. export OMP_NUM_THREADS=4


2c.  Cleaning

make clean



3.  X10 version with Managed X10 of sequential version (in LatticeQCDseq/src/)


3a. Building

make build-java


3b. Running

make run-java


3c. Cleaning

make clean



4.  X10 version with Native X10 of sequential version (in LatticeQCDseq/src/)


4a. Building

make build-cpp


4b. Running

make run-cpp


4c. Cleaning

make clean



5.  X10 version with Managed X10 in parallel on single place (in LatticeQCDparallel/src/)


5a. Building

make build-java


5b. Running

make run-java

#before running in x10, set the number of threads to run
e.g. export X10_NTHREADS=4


5c. Cleaning

make clean



6.  X10 version with Native X10 in parallel on single place (in LatticeQCDparallel/src/)


6a. Building

make build-cpp


6b. Running

make run-cpp

#before running in x10, set the number of threads to run
e.g. export X10_NTHREADS=4


6c. Cleaning

make clean



7.  X10 version with Managed X10 on multiple places (in LatticeQCDdist/src/)


7a. Building

make build-java


7b. Running

make run-java

#before running in x10, set the number of places and number of threads to run
e.g. export X10_NPLACES=2
e.g. export X10_NTHREADS=4


7c. Cleaning

make clean



8.  X10 version with Native X10 on multiple places (in LatticeQCDdist/src/)


8a. Building

make build-cpp


8b. Running

make run-cpp

#before running in x10, set the number of places and number of threads to run
e.g. export X10_NPLACES=2
e.g. export X10_NTHREADS=4


8c. Cleaning

make clean


--- end of file ---
