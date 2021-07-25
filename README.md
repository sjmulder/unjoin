unjoin
======
[![Build status](
 https://builds.sr.ht/~sjmulder/unjoin.svg)](
 https://builds.sr.ht/~sjmulder/unjoin)

Split input on separators.

**unjoin** _separator_ ...

**funjoin** [**-f** _prefix_] [**-n** _number_] _separator_ ...

Description
-----------
**unjoin** copies standard input to standard output, replacing occurences of
any _separator_ with a newline character.

**funjoin** splits standard input, separated by any _separator_, into files
named "xx" (or another _prefix_)  and two (or _number_) decimal digits.

Examples
--------
Split on underscores and double colons:

    $ echo "one::two_three" | unjoin _ ::
    one
    two
    three

The same, but outputing to separate files rather than separate lines:

    $ echo "one::two_three" | funjoin _ ::
    $ cat xx01
    two

Building
--------
Unix-likes:

    make

    # tweak Makefile to taste
    make install
    make uninstall

See also
--------
[sed(1)](https://man.openbsd.org/sed.1).

Authors
-------
Sijmen J. Mulder (<ik@sjmulder.nl>).
Options output file naming copied from OpenBSD
[csplit(1)](https://man.openbsd.org/csplit.1).
