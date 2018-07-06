CFLAGS += -ansi -g
CFLAGS += -D_POSIX_C_SOURCE=200112L
CFLAGS += -Wall -Wextra -pedantic

# BSD conventions by default, override to taste
prefix  ?= /usr/local
bindir  ?= $(prefix)/bin
man1dir ?= $(prefix)/man/man1

all: funjoin

clean:
	rm -f funjoin

install:
	install -d $(bindir) $(man1dir)
	install funjoin $(bindir)/
	install funjoin.1 $(man1dir)/

uninstall:
	rm -f $(bindir)/funjoin
	rm -f $(man1dir)/funjoin.1

.PHONY: all clean install uninstall
