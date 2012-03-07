#!/bin/sh
if [ -z "$PGUSER" ]; then
PGUSER=$USER
fi
if [ -z "$PGPORT" ]; then
PGPORT=5432
fi

"${BINDIR}/createdb" "$PGUSER"

echo "Running libpq URI support test..."

while read uri
do
    "${BINDIR}/psql" -d "$uri" -At -c "SELECT '$uri'"
done >regress.out <<EOF
postgresql://${PGUSER}@localhost:${PGPORT}/${PGUSER}
postgresql://${PGUSER}@localhost/${PGUSER}
postgresql://localhost:${PGPORT}/${PGUSER}
postgresql://localhost/${PGUSER}
postgresql://${PGUSER}@localhost:${PGPORT}/
postgresql://${PGUSER}@localhost/
postgresql://localhost:${PGPORT}/
postgresql://localhost:${PGPORT}
postgresql://localhost/${PGUSER}
postgresql://localhost/
postgresql://localhost
postgresql://
postgresql://%6Cocalhost/
postgresql://localhost/${PGUSER}?user=${PGUSER}
postgresql://localhost/${PGUSER}?user=${PGUSER}&port=${PGPORT}
postgresql://localhost/${PGUSER}?user=${PGUSER}&port=${PGPORT}
postgresql://localhost:${PGPORT}?user=${PGUSER}
postgresql://localhost?user=${PGUSER}
postgresql://localhost?uzer=
postgresql://localhost?
postgresql://[::1]:${PGPORT}/${PGUSER}
postgresql://[::1]/${PGUSER}
postgresql://[::1]/
postgresql://[::1]
postgres://
postgres:///tmp
EOF

if diff -c expected.out regress.out >regress.diff; then
    echo "========================================"
    echo "All tests passed"
    exit 0
else
    echo "========================================"
    echo "FAILED: the test result differs from the expected output"
    echo
    echo "Review the difference in regress.diff"
    echo "========================================"
    exit 1
fi
