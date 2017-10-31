.PHONY: setup
setup:
	virtualenv .env
	.env/bin/pip install -r requirements.txt

.PHONY: test
test:
	LD_LIBRARY_PATH="$$ORACLE_HOME/lib" .env/bin/pytest *test.py

