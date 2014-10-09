Exact CNS_NoSpec proxy app

This code solves a constant coefficient compressible Navier
Stokes equations using high-order finite dfferent methods.
The algorithm uses domain decomposition with MPI for data
distribution.  It also support hybrid parallelization
using OMP.

It is intended to be a simple example of the types of
stencil operation found in more realistic combustion application.
It is NOT intended to be reprentative of the computational
work associated with real combustion applciations.

******************  BUILDING THE CODE ************************

The code is written in Fortran 90 with a couple of c routines
that perform I/O. Assumes GNU compilers are available
(e.g. gfortran, gcc)

To build the code:

cd MiniApps/CNS_NoSpec
make

This should produce a file:

main.Linux.gfortran.exe

This is a serial version.

To build the MPI parallel version set

MPI  := t

in the makefile.  This may require some effort in telling
the make system where MPI is on the system. Look in 
Tool/F_mk at the file GMakeMPI.mak for examples of how
to specify where MPI libraries and includes are located
on your machine.  If you have problem contact Vince Beckner
(VEBeckner@lbl.gov).

The resulting executable is

main.Linux.gfortran.mpi.exe

The application part of the code is in MiniApps/AMR_Adv_Diff_F90
but the build uses a subset of BoxLib which is in Src/F_Baselib

*******************  RUNNING THE CODE  ************************

The code runs for 5 time steps in  3d.

3d inputs file: inputs_3d

To run in serial type:

main.Linux.gfortran.exe inputs_3d

To run in parallel run main.Linux.gfortran.mpi.exe with whatever
script you use to launch parallel jobs.  For example,

mpiexec -n 8 main.Linux.gfortran.mpi.exe inputs_3d

The code generates plotfiles that can be viewed with Visit.

The inputs can be changed to modify problem -- see comments
in inputs_3d


**************************************************************

BoxLib Version 2014-02-28, Copyright (c) 2014, The Regents of the
University of California, through Lawrence Berkeley National
Laboratory (subject to receipt of any required approvals from the U.S.
Dept. of Energy).  All rights reserved.

If you have questions about your rights to use or distribute this
software, please contact Berkeley Lab's Technology Transfer Department
at  TTD@lbl.gov.

NOTICE.  This software is owned by the U.S. Department of Energy.  As
such, the U.S. Government has been granted for itself and others
acting on its behalf a paid-up, nonexclusive, irrevocable, worldwide
license in the Software to reproduce, prepare derivative works, and
perform publicly and display publicly.  Beginning five (5) years after
the date permission to assert copyright is obtained from the U.S.
Department of Energy, and subject to any subsequent five (5) year
renewals, the U.S. Government is granted for itself and others acting
on its behalf a paid-up, nonexclusive, irrevocable, worldwide license
in the Software to reproduce, prepare derivative works, distribute
copies to the public, perform publicly and display publicly, and to
permit others to do so.
