X10_ROOT ~= $(HOME)/x10-2-4-branch

DISTDIR = $(X10_ROOT)/x10.dist
X10_RUNTIME_DIR = $(X10_ROOT)/x10.runtime
APGAS_DIR = $(X10_ROOT)/apgas.cpp

#########################
# User-servicable Parts #
#########################

include $(X10_RUNTIME_DIR)/Make.rules

FIND ?= find
XARGS ?= xargs
X10RT_LIB ?= x10rt_sockets

#############
# Variables #
#############

override CXXFLAGS += -I$(APGAS_DIR)/src -I$(APGAS_DIR)/src-crx -I$(DISTDIR)/include

APGAS_LINK_ARGS = -L$(APGAS_DIR) -lapgas -Wl,--rpath -Wl,$(APGAS_DIR) \
	-L$(DISTDIR)/lib -l$(X10RT_LIB) -Wl,--rpath -Wl,$(DISTDIR)/lib

###########
# Targets #
###########

override CXXFLAGS += -O2 -finline-functions

jacobi: jacobi.cc
	$(CXX) $(CXXFLAGS) -o $@ jacobi.cc -lm $(APGAS_LINK_ARGS) 

clean:
	$(RM) jacobi

.PHONY: clean 
