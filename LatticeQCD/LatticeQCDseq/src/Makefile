X10_FLAGS	= -O -NO_CHECKS
X10RUN_FLAGS	=

X10CPP_TARGET = SolveWilsonX10c++
X10_TARGET = SolveWilson

all: build-cpp build-java

build-cpp:	$(X10CPP_TARGET)
$(X10CPP_TARGET):	$(X10_TARGET).x10
	x10c++ $(X10_FLAGS) -o $(X10CPP_TARGET) $(X10_TARGET).x10 

build-java:	$(X10_TARGET)
$(X10_TARGET):	$(X10_TARGET).x10
	x10c $(X10_FLAGS) -o $(X10_TARGET).jar $(X10_TARGET).x10 

run-java:	$(X10_TARGET).jar
	x10 $(X10RUN_FLAGS) -cp $(X10_TARGET).jar $(X10_TARGET)

run-cpp:	$(X10CPP_TARGET)
	./$(X10CPP_TARGET)

.PHONY: clean
clean:
	rm -rf $(X10CPP_TARGET) $(X10_TARGET).jar $(X10_TARGET).h $(X10_TARGET).cc $(X10_TARGET)_____* xxx_main_xxx.cc
