# Makefile for inform-mode

# Edit these variables to override the version of emacs and where to
# put the installed files
EMACS=emacs
PREFIX=/usr/local/share/emacs/site-lisp

# There is normally no need to edit anything below this line.

VERSION=1.6.0
ELS=inform-mode.el
ELCS=$(ELS:.el=.elc)
DIST_FILES=$(ELS) AUTHORS COPYING COPYING-GPL-3 INSTALL Makefile README

EMACSFLAGS=
BATCH=$(EMACS) $(EMACSFLAGS) -batch -q -no-site-file -eval \
  "(setq load-path (cons (expand-file-name \".\") load-path))"

%.elc: %.el
	$(BATCH) --eval '(byte-compile-file "$<")'

all: $(ELCS)

install: all
	mkdir -p $(PREFIX)
	install -m 644 $(ELS) $(ELCS) $(PREFIX)

uninstall: 
	rm -f $(PREFIX)/${ELCS} $(PREFIX)/${ELS}

dist: inform-mode-$(VERSION).tar.gz

inform-mode-$(VERSION).tar.gz: $(DIST_FILES)
	mkdir -p inform-mode-$(VERSION)
	cp --preserve=timestamps $(DIST_FILES) inform-mode-$(VERSION)
	tar cvzf inform-mode-$(VERSION).tar.gz inform-mode-$(VERSION)
	rm -rf inform-mode-$(VERSION)

clean:
	rm -rf *~ $(ELCS) *.tar.gz inform-mode-$(VERSION)


