DESTDIR   ?=
PREFIX    ?= /usr/local
MANPREFIX ?= $(PREFIX)/man

CFLAGS += -ansi -g
CFLAGS += -D_POSIX_C_SOURCE=200112L
CFLAGS += -Wall -Wextra -pedantic

all: funjoin

clean:
	rm -f funjoin

install:
	install -d $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(MANPREFIX)/man1
	install -m755 funjoin   $(DESTDIR)$(PREFIX)/bin/
	install -m644 funjoin.1 $(DESTDIR)$(MANPREFIX)/man1/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/funjoin
	rm -f $(DESTDIR)$(MANPREFIX)/man1/funjoin.1

.PHONY: all clean install uninstall
