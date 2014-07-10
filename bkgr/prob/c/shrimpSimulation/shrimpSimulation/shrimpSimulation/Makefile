
#define the suffixes
# .SUFFIXES:	.o .c .f 

#macro definitions
SHELL = /bin/sh
##CC=mpic++
CC=g++
cc=gcc
## CC=/opt/SUNWhpc/HPC8.2.1/gnu/bin/mpic++
##CFLAGS=-O3 -Winline -finline-functions   -finline-limit=1200  -I/usr/local/include -Wall -std=c++0x
CFLAGS=-O3 -Winline -finline-functions   -finline-limit=1200  -I/usr/local/include -Wall
LIB=-lm -lpthread
LDEP=
DEP= 

.cpp.o:	
	$(CC) $(CFLAGS) $(CURLFLAGS) -c $<

.c.o:	
	$(cc) $(CFLAGS) $(CURLFLAGS) -c $<


all:	main

main: main.o $(DEP) $(LDEP)
	$(cc) $(CFLAGS) -o $@ $@.o $(LIB)


clean:
	rm -f *.o *~ main

