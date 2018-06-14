OBJS = cpyc.py
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

.PHONY: all
all: $(OBJS)

.PHONY: clean
clean:
	rm -f $(OBJS)

.PHONY: install
install:
	install -m 755 cpyc.py $(BINDIR)/cpyc

.PHONY: uninstall
uninstall:
	rm -f $(BINDIR)/cpyc

.PHONY: test
test: all
	cat test.c | ./cpyc.py

%.py: %.ipynb
	jupyter nbconvert --to script $<
	mv $@ $@~
	(echo "#!/usr/bin/env python2"; cat $@~) > $@
	rm -f $@~
	chmod +x $@
