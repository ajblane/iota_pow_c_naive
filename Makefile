OUT ?= ./build
SRC := src

CFLAGS = -Wall -fPIC
LDFLAGS = 


TESTS = pow_c

TESTS := $(addprefix $(OUT)/test-, $(TESTS))

all: $(TESTS)
.DEFAULT_GOAL := all

OBJS =  \
	curl.o \
	constants.o \
	trinary.o 

OBJS += pow_c_naive.o 

OBJS := $(addprefix $(OUT)/, $(OBJS))

$(OUT)/test-%: $(OUT)/test-%.o $(OBJS) 
	$(CC) -o $@ $^ $(LDFLAGS)

$(OUT)/test-%.o: tests/test-%.c
	$(CC) -o $@ $(CFLAGS) -I $(SRC) -c $<

$(OUT)/%.o: $(SRC)/%.c
	$(CC) -o $@ $(CFLAGS) -c $<

check:
	./$(OUT)/test-pow_c

clean:
	$(RM) -r $(OUT)/*


