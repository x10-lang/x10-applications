CXX_FLAGS = -O2 -finline-functions

all: jacobi_seq jacobi_omp

jacobi_seq: jacobi.c
	$(CXX) $(CXX_FLAGS) jacobi.c -lm -o $@

jacobi_omp: jacobi.c
	$(CXX) $(CXX_FLAGS) -fopenmp jacobi.c -lm -o $@

clean:
	$(RM) jacobi_seq jacobi_omp
