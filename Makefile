test: *.js *.sh test/*.sh
	@./test/runner

setup:
	$(MAKE) -C test/ruby setup

test-all: test
	$(MAKE) -C test/ruby test

.PHONY: setup test test-all
