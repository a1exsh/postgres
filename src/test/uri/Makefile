subdir = src/test/uri
top_builddir = ../../..
include $(top_builddir)/src/Makefile.global

all: installcheck

installcheck:
	@echo 'Running libpq URI support test...'
	BINDIR='$(bindir)' $(SHELL) ./regress.sh

clean:
	rm -f regress.out regress.diff
