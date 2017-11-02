.PHONY: setup
setup:
	npm install

.PHONY: test
test:
	LD_LIBRARY_PATH="$$ORACLE_HOME/lib" node_modules/.bin/mocha *spec.js
