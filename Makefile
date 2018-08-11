CFLAGS += -ansi -g
CFLAGS += -Wall -Wextra -pedantic

# BSD conventions by default, override to taste
prefix  ?= /usr/local
bindir  ?= $(prefix)/bin
man1dir ?= $(prefix)/man/man1

all: unjoin

clean:
	rm -f unjoin

install: unjoin
	install -d $(bindir) $(man1dir)
	install unjoin $(bindir)/
	install unjoin.1 $(man1dir)/

uninstall:
	rm -f $(bindir)/unjoin
	rm -f $(man1dir)/unjoin.1

.PHONY: all clean install uninstall
