# unjoin

Split input lines on separators.

## Synopsis

**unjoin** _separator_ ...

## Description

**unjoin** copies standard input to standard output, replacing occurences of
any _separator_ with a newline character.

## Examples

Split on underscores and double colons:

    $ echo "one::two_three" | unjoin _ ::
    one
    two
    three

## Building

Unix-likes:

    make

    # tweak Makefile to taste
    make install
    make uninstall

## Authors

Sijmen J. Mulder (<ik@sjmulder.nl>)
