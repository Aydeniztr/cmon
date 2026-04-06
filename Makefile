CC = gcc
CFLAGS = -Wall -O2 -D_XOPEN_SOURCE_EXTENDED=1
LDFLAGS = -lncursesw

all: cmon

cmon: main.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

main.o: main.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o cmon
