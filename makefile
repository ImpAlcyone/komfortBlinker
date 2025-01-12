DEBUG = 1
IDIR = ./include
CC=gcc
CFLAGS=-I$(IDIR) -pedantic -std=c17

ifeq ($(DEBUG), 1)
	CFLAGS += -g -O0 -DDEBUG
else
	CFLAGS += -O2
endif

ODIR=./src/obj
LDIR = ./lib
SDIR=./src

#LIBS=-lm

_DEPS =
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

OBJ = $(patsubst $(SDIR)/%.c,$(ODIR)/%.o,$(wildcard $(SDIR)/*.c))

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY: clean all

all: program

program: $(OBJ)
		$(CC) -o $@ $^ $(CFLAGS) $(LIBS)
clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~
