CPP		= g++

CPP_FLAGS	= -O2 -finline-functions
OMP_FLAGS	= -fopenmp

CPP_TARGET	= solv_wilson
OMP_TARGET	= solv_wilson_omp

all: c++ omp

c++: solv_wilson.cpp
	$(CPP) $(CPP_FLAGS) -o $(CPP_TARGET) $(CPP_TARGET).cpp

omp: solv_wilson_omp.cpp
	$(CPP) $(CPP_FLAGS) $(OMP_FLAGS) -o $(OMP_TARGET) $(OMP_TARGET).cpp

clean:
	rm -rf $(CPP_TARGET) $(OMP_TARGET) 