X10_DIST ?= $(HOME)/x10-trunk/x10.dist

include $(X10_DIST)/../apgas.cpp/Make.rules


#############
# Variables #
#############

override CXXFLAGS += -g

###########
# Targets #
###########

ifdef USE_XLC
	override CXXFLAGS += -O3 -qinline -qarch=auto -qtune=auto -qhot
	CXX = xlC
else
	override CXXFLAGS += -O2 -finline-functions
	CXX = g++
endif

default:jacobi jacobi_array

jacobi: jacobi.cc
	$(CXX) $(CXXFLAGS) -lprofiler -o $@ jacobi.cc -lm $(APGAS_LINK_ARGS) 

jacobi_array: jacobi_array.cc
	$(CXX) $(CXXFLAGS) -o $@ jacobi_array.cc -lm $(APGAS_LINK_ARGS) 

clean:
	$(RM) jacobi jacobi_array

.PHONY: clean 
