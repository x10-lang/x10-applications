CXXFLAGS = -O2 -finline-functions

all: jacobi_seq jacobi_omp

jacobi_seq: jacobi.c
	$(CXX) $(CXXFLAGS) jacobi.c -lm -o $@

jacobi_omp: jacobi.c
	$(CXX) $(CXXFLAGS) -fopenmp jacobi.c -lm -o $@

clean:
	$(RM) jacobi_seq jacobi_omp
