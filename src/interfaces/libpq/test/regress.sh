#!/bin/sh
if [ -z "$PGUSER" ]; then
PGUSER=$USER
fi
if [ -z "$PGPORT" ]; then
PGPORT=5432
fi
if [ -z "$PGDATABASE" ]; then
PGDATABASE=regression
fi
export PGUSER PGPORT PGDATABASE

"${BINDIR}/createdb" "${PGDATABASE}"

echo "Running libpq URI support test..."

while read line
do
	echo "trying $line"

	# First, expand variables in the test URI line.
	uri=$(eval echo "$line")

	# But SELECT the original line, so test result doesn't depend on
	# the substituted values.
	"${BINDIR}/psql" -d "$uri" -At -c "SELECT '$line'"
	echo ""
done < "${SRCDIR}/${SUBDIR}"/regress.in >regress.out 2>&1

if diff -c "${SRCDIR}/${SUBDIR}/"expected.out regress.out >regress.diff; then
	echo "========================================"
	echo "All tests passed"
	exit 0
else
	echo "========================================"
	echo "FAILED: the test result differs from the expected output"
	echo
	echo "Review the difference in ${SUBDIR}/regress.diff"
	echo "========================================"
	exit 1
fi
