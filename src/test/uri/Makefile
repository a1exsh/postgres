subdir = src/test/uri
top_builddir = ../../..
include $(top_builddir)/src/Makefile.global

all: installcheck

installcheck:
	BINDIR='$(bindir)' $(SHELL) ./regress.sh

clean:
	rm -f regress.out regress.diff
