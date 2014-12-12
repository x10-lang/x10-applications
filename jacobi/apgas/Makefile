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

jacobi: jacobi.cc
	$(CXX) $(CXXFLAGS) -o $@ jacobi.cc -lm $(APGAS_LINK_ARGS) 

clean:
	$(RM) jacobi

.PHONY: clean 
