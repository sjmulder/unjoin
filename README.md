unjoin
=====
Split input lines on separators.

**unjoin** _separator_ ...

Description
-----------
**unjoin** copies standard input to standard output, replacing occurences of
any _separator_ with a newline character.

Examples
--------
Split on underscores and double colons:

    $ echo "one::two_three" | unjoin _ ::
    one
    two
    three

Building
--------
Unix-likes:

    make

    # tweak Makefile to taste
    make install
    make uninstall

See also
--------
[sed(1)](https://man.openbsd.org/sed.1),
[funjoin(1)](https://github.com/sjmulder/funjoin).

Authors
-------
Sijmen J. Mulder (<ik@sjmulder.nl>)
