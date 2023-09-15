	PROJECT	= bsde
	CXX	= g++
	CXXFLAGS= -std=c++0x -fopenmp -Wall -Isrc
	CXXOPT  = -O3 
	LDLIBS = -lpng
	RM	= rm -f
	CSRC	= src/io_png.c
	CXXSRC	= src/libdenoising.cpp src/lib.cpp src/bsde.cpp
	COBJ	= $(CSRC:.c=.o)
	CXXOBJ	= $(CXXSRC:.cpp=.o)
	OBJ	= $(COBJ) $(CXXOBJ)
	BIN	= ipol-$(PROJECT)

delault: $(BIN)

$(BIN): $(OBJ)
	$(CXX) $(CXXFLAGS) $(CXXOPT) $^ -o $@ $(LDLIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(CXXOPT) -c -o $@ $<

%.o: %.c
	$(CXX) $(CXXFLAGS) $(CXXOPT) -c -o $@ $<
clean:
	$(RM) $(OBJ)

distclean: clean
	$(RM) $(BIN) ex*.png 

tests:
	@echo Example 1.
	./$(BIN) samples/lena.png 20 ex1_in.png ex1_out.png 1 0.0
	@echo Example 2.
	./$(BIN) samples/lena.png 10 ex2_in.png ex2_out.png 0 0.4
	@echo \n

