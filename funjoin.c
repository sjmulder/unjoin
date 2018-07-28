/* funjoin.c - Copyright (c) 2018 Sijmen J. Mulder, see LICENSE.md */

#ifdef __OpenBSD__
/* for plegde */
#define _BSD_SOURCE
#include <unistd.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <getopt.h>
#include <err.h>

#define LEN(a) (sizeof(a)/sizeof(*(a)))

int
main(int argc, char **argv)
{
	/* options */
	const char *prefix = "xx";
	int ndigits = 2;
	int maxfiles = 1;
	int ch;
	char *end;

	/* input processing */
	char buf[4096];
	size_t lens[512];
	size_t maxlen = 0;
	size_t buflen = 0;
	int i;

	/* output */
	FILE *file = NULL;
	char filename[NAME_MAX];
	int filenum = 0;
	int n;

#ifdef __OpenBSD__
	if (pledge("stdio wpath cpath", NULL) == -1)
		err(1, "pledge");
#endif

	while ((ch = getopt(argc, argv, "f:n:")) != -1) {
		switch (ch) {
		case 'f':
			prefix = optarg;
			break;
		case 'n':
			ndigits = (int)strtol(optarg, &end, 10);
			if (*end || ndigits < 1)
				errx(1, "bad -n");
			break;
		default:
			return 1;
		}
	}
	
	argc -= optind;
	argv += optind;

	if (!argc) {
		fputs("usage: funjoin [-f prefix] [-n number] SEPARATOR "
		    "...\n", stderr);
		return 1;
	}

	if ((size_t)argc >= LEN(lens))
		errx(1, "too many arguments\n");

	for (i = 0; i < argc; i++) {
		lens[i] = strlen(argv[i]);
		if (!lens[i])
			errx(1, "bad argument %d: empty string", i);
		if (lens[i] > LEN(buf))
			errx(1, "bad argument %d: too long", i);
		if (lens[i] > maxlen)
			maxlen = lens[i];
	}

	for (i=0; i<ndigits; i++)
		maxfiles *= 10;

	while ((buflen += fread(buf+buflen, 1, maxlen-buflen, stdin))) {
		for (i = 0; i < argc; i++) {
			if (buflen < lens[i])
				continue;
			if (strncmp(buf, argv[i], lens[i]))
				continue;

			/* have match */

			if (file) {
				fclose(file);
				file = NULL;
			}

			buflen -= lens[i];
			memmove(buf, buf+lens[i], buflen);
			break;
		}

		if (!file) {
			if (++filenum >= maxfiles)
				errx(1, "too many files, use -n");
			n = snprintf(filename, LEN(filename), "%s%0*d",
			    prefix, ndigits, filenum);
			if (n >= (int)LEN(filename))
				errx(1, "filename too long");
			if (!(file = fopen(filename, "w")))
				err(1, "cannot open '%s'", filename);
		}

		if (i != argc)
			continue;

		/* no match */

		fputc(buf[0], file);
		buflen--;
		memmove(buf, buf+1, buflen);
	}

	if (file)
		fclose(file);

	return 0;
}
