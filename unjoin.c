/* unjoin.c - Copyright (c) 2018 Sijmen J. Mulder, see LICENSE.md */

#include <stdio.h>
#include <string.h>
#include <err.h>

#ifdef __OpenBSD__
#include <unistd.h>
#endif

#define LEN(a) (sizeof(a)/sizeof(*(a)))

int
main(int argc, char **argv)
{
	char buf[4096];
	size_t lens[512];
	size_t maxlen = 0;
	size_t buflen = 0;
	int i;

#ifdef __OpenBSD__
	if (pledge("stdio", NULL) == -1)
		err(1, "pledge");
#endif

	if (argc < 2) {
		fputs("usage: unjoin SEPARATOR ...\n", stderr);
		return 1;
	}

	if ((size_t)argc > LEN(lens))
		errx(1, "too many arguments\n");

	for (i = 1; i < argc; i++) {
		lens[i] = strlen(argv[i]);
		if (!lens[i])
			errx(1, "bad argument %d: empty string", i);
		if (lens[i] > LEN(buf))
			errx(1, "bad argument %d: too long", i);
		if (lens[i] > maxlen)
			maxlen = lens[i];
	}

	while ((buflen += fread(buf+buflen, 1, maxlen-buflen, stdin))) {
		for (i = 1; i < argc; i++) {
			if (buflen < lens[i])
				continue;
			if (strncmp(buf, argv[i], lens[i]))
				continue;

			/* have match */
			putchar('\n');
			buflen -= lens[i];
			memmove(buf, buf+lens[i], buflen);
			break;
		}

		if (i == argc) {
			/* no match */
			putchar(buf[0]);
			buflen--;
			memmove(buf, buf+1, buflen);
		}
	}

	return 0;
}
