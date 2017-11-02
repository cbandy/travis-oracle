.PHONY: test
test: *.js *.sh test/*.sh
	@./test/runner

.PHONY: setup
setup:
	$(MAKE) -C test/node setup
	$(MAKE) -C test/python setup
	$(MAKE) -C test/ruby setup

.PHONY: test-all
test-all: test
	$(MAKE) -C test/node test
	$(MAKE) -C test/python test
	$(MAKE) -C test/ruby test
