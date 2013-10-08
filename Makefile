# Makefile for inform-mode

# Edit these variables to override the version of emacs and where to
# put the installed files
EMACS=emacs
PREFIX=/usr/local/share/emacs/site-lisp

# There is normally no need to edit anything below this line.

VERSION=1.6.2
ELS=inform-mode.el
ELCS=$(ELS:.el=.elc)
OTHER_FILES=AUTHORS COPYING COPYING-GPL-3 INSTALL Makefile NEWS README
DIST_FILES=$(ELS) $(OTHER_FILES)

EMACSFLAGS=
BATCH=$(EMACS) $(EMACSFLAGS) -batch -q -no-site-file -eval \
  "(setq load-path (cons (expand-file-name \".\") load-path))"

ZIP=zip

%.elc: %.el
	$(BATCH) --eval '(byte-compile-file "$<")'

all: $(ELCS)

install: all
	mkdir -p $(PREFIX)
	install -m 644 $(ELS) $(ELCS) $(PREFIX)

uninstall: 
	rm -f $(PREFIX)/${ELCS} $(PREFIX)/${ELS}

dist: inform-mode-$(VERSION).tar.gz inform-mode-$(VERSION).zip

inform-mode-$(VERSION).tar.gz: $(DIST_FILES)
	mkdir -p inform-mode-$(VERSION)
	cp --preserve=timestamps $(DIST_FILES) inform-mode-$(VERSION)
	tar cvzf inform-mode-$(VERSION).tar.gz inform-mode-$(VERSION)
	rm -rf inform-mode-$(VERSION)

inform-mode-$(VERSION).zip: $(DIST_FILES)
	mkdir -p inform-mode-$(VERSION)
	cp --preserve=timestamps $(DIST_FILES) inform-mode-$(VERSION)
	(cd inform-mode-$(VERSION); for x in $(OTHER_FILES); do mv $$x $$x.txt; done; rm -f Makefile.txt)
	$(ZIP) -l inform-mode-$(VERSION).zip inform-mode-$(VERSION)/*
	rm -rf inform-mode-$(VERSION)

clean:
	rm -rf *~ $(ELCS) *.tar.gz *.zip inform-mode-$(VERSION)


