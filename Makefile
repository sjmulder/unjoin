DESTDIR   ?=
PREFIX    ?= /usr/local
MANPREFIX ?= $(PREFIX)/man

CFLAGS += -Wall -Wextra

all: funjoin

clean:
	rm -f funjoin

check: funjoin
	echo one_two | ./funjoin _ && rm xx01 xx02

install:
	install -d $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(MANPREFIX)/man1
	install -m755 funjoin   $(DESTDIR)$(PREFIX)/bin/
	install -m644 funjoin.1 $(DESTDIR)$(MANPREFIX)/man1/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/funjoin
	rm -f $(DESTDIR)$(MANPREFIX)/man1/funjoin.1

.PHONY: all clean check install uninstall
