subdir = src/interfaces/libpq/test
top_builddir = ../../../..
include $(top_builddir)/src/Makefile.global

all: installcheck

installcheck:
	BINDIR='$(bindir)' PGPORT='$(DEF_PGPORT)' SUBDIR='$(subdir)' SRCDIR='$(top_srcdir)' \
		   $(SHELL) $(top_srcdir)/$(subdir)/regress.sh

clean distclean maintainer-clean:
	rm -f regress.out regress.diff
