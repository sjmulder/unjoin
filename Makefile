DESTDIR   ?=
PREFIX    ?= /usr/local
MANPREFIX ?= $(PREFIX)/man

CFLAGS += -Wall -Wextra

all: unjoin funjoin

clean:
	rm -f unjoin funjoin

check: all
	echo one_two | ./unjoin _ >/dev/null
	echo one_two | ./funjoin _ && rm xx01 xx02

install: unjoin funjoin
	install -d $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(MANPREFIX)/man1
	install -m755 unjoin    $(DESTDIR)$(PREFIX)/bin/
	install -m755 funjoin   $(DESTDIR)$(PREFIX)/bin/
	install -m644 unjoin.1  $(DESTDIR)$(MANPREFIX)/man1/
	install -m644 funjoin.1 $(DESTDIR)$(MANPREFIX)/man1/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/unjoin
	rm -f $(DESTDIR)$(PREFIX)/bin/funjoin
	rm -f $(DESTDIR)$(MANPREFIX)/man1/unjoin.1
	rm -f $(DESTDIR)$(MANPREFIX)/man1/funjoin.1

.PHONY: all clean check install uninstall
