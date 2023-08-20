CC=gcc
flags=-O3 -Wall

srcfiles=$(wildcard *.c)
binfiles=$(patsubst %.c, ../%, $(srcfiles))

all: $(binfiles)

../%: %.c
	$(CC) $(flags) -o $@ $<
