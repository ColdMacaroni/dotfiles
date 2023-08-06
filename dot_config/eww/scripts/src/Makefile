CC=gcc
flags=-O3

srcfiles=$(wildcard *.c)
binfiles=$(patsubst %.c, ../%, $(srcfiles))

all: $(binfiles)

../%: %.c
	$(CC) $(flags) -o $@ $<
