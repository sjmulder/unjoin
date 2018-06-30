# funjoin

Split separated input into files

## Synopsis

**unjoin** [**-f** _prefix_] [**-n** _number_] _separator_ ...

## Description

**funjoin** splits standard input, separated by any _separator_, into files
named "xx" and two decimal digits.

Options:

**-f** _prefix_ -- Use _prefix_ instead of "xx".

**-n** _number_ -- Use _number_ of digits instead of 2.

## Examples

Split on underscores and double colons:

    $ echo "one::two_three" | function _ ::
    $ cat xx01
    two

## Building

Unix-likes:

    make

    # tweak Makefile to taste
    make install
    make uninstall

## See also

[csplit(1)](https://man.openbsd.org/csplit.1),
[split(1)](https://man.openbsd.org/split.1),
[unjoin(1)](https://github.com/sjmulder/unjoin).

## Authors

By Sijmen J. Mulder (<ik@sjmulder.nl>).
Based on [unjoin(1)](https://github.com/sjmulder/unjoin).
Options output file naming copied from OpenBSD
[csplit(1)](https://man.openbsd.org/csplit.1).
