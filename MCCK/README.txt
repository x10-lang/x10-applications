==============================================================================
         		Monte Carlo Communication Kernel
				MCCK Release 1.0
==============================================================================
Contact Information
==============================================================================

Organization:     Center for Exascale Simulation of Advanced Reactors (CESAR)
		  Mathematics and Computer Science Division
                  Argonne National Laboratory

Development Lead: Kyle Felker <felker@mcs.anl.gov>

==============================================================================
What is MCCK?
==============================================================================

MCCK is a tool for modeling the communication pattern of domain decomposed 
Monte Carlo neutron transport simulations on the largest distributed memory 
supercomputing resources. The goal of the mini-application is to gauge the 
relevant performance regimes of the algorithm and evaluate the benefits of 
various memory management techniques.

In particular, this C/MPI code is configured with the optional capability to
offload the particle exchange operations to the Memory-Aware Data Redistribution 
Engine (MADRE) package.

More information can be found in docs/MCCKmanual.pdf

==============================================================================
Quick Start Guide
==============================================================================

MCCK requires a C and MPI compiler. 

Download----------------------------------------------------------------------

	The latest stable version of MCCK can be downloaded from

	https://cesar.mcs.anl.gov/content/software/neutronics

	Once downloaded, you can decompress MCCK using the following
	command on a linux or Mac OSX system:

	>$ tar -zxvf mcck-1.0.tgz

	This will create the mcck-1.0/ directory

       	The source code is found in mcck-1.0/src/ 

Compilation-------------------------------------------------------------------

	To compile MCCK with default settings (without using MADRE), use the 
	following command:

	>$ make
	
	In the top level directory, ensure that your desired C/MPI compiler is
	correctly defined in Makefile.h "MPICC" variable.

	If compilation completes successfully, the executable "Main" will be placed
	in main/ subdirectory. 

Running-----------------------------------------------------------------------

	See instructions in docs/MCCKmanual.pdf