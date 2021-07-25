DESTDIR   ?=
PREFIX    ?= /usr/local
MANPREFIX ?= $(PREFIX)/man

CFLAGS += -ansi -g
CFLAGS += -Wall -Wextra -pedantic

all: unjoin

clean:
	rm -f unjoin

check: all
	echo one_two | ./unjoin _ >/dev/null

install: unjoin
	install -d $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(MANPREFIX)/man1
	install -m755 unjoin   $(DESTDIR)$(PREFIX)/bin/
	install -m644 unjoin.1 $(DESTDIR)$(MANPREFIX)/man1/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/unjoin
	rm -f $(DESTDIR)$(MANPREFIX)/man1/unjoin.1

.PHONY: all clean check install uninstall
