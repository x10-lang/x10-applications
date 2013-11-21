TARGET = lulesh

CXX = g++44

$(TARGET): $(TARGET).cc
	$(CXX) -O2 -finline-functions $< -lm -o $@

clean:
	rm -f *~ $(TARGET)
