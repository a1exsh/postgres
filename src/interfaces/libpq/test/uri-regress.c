#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "libpq-fe.h"

int
main(int argc, char *argv[])
{
	char *errmsg = NULL;
	PQconninfoOption *opts;
	PQconninfoOption *defs;
	PQconninfoOption *opt;
	PQconninfoOption *def;

	if (argc != 2)
		return 1;

	opts = PQconninfoParse(argv[1], &errmsg);
	if (opts == NULL)
	{
		fprintf(stderr, "uri-regress: %s\n", errmsg);
		return 1;
	}

	defs = PQconndefaults();
	if (defs == NULL)
	{
		fprintf(stderr, "uri-regress: cannot fetch default options\n");
		return 1;
	}

	for (opt = opts, def = defs; opt->keyword; ++opt, ++def)
	{
		if (opt->val != NULL &&
			(def->val == NULL || strcmp(opt->val, def->val) != 0))
			printf("%s='%s' ", opt->keyword, opt->val);
	}
	printf("\b\n");

	return 0;
}
