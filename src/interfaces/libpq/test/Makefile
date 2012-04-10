subdir = src/interfaces/libpq/test
top_builddir = ../../../..
include $(top_builddir)/src/Makefile.global

ifeq ($(PORTNAME), win32)
LDLIBS += -lws2_32
endif

override CPPFLAGS := -I$(libpq_srcdir) $(CPPFLAGS)
override LDLIBS := $(libpq_pgport) $(LDLIBS)

PROGS = uri-regress

all: $(PROGS)

check:
	BINDIR='$(bindir)' PGPORT='$(DEF_PGPORT)' SUBDIR='$(subdir)' SRCDIR='$(top_srcdir)' \
		   $(SHELL) $(top_srcdir)/$(subdir)/regress.sh

clean distclean maintainer-clean:
	rm -f $(PROGS)
	rm -f regress.out regress.diff
