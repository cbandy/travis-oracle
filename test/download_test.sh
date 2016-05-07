#!/usr/bin/env bash
. ./test/helper.sh

test_downloaded_file() {
	assertTrue "'$ORACLE_FILE' does not exist" '[ -f "$( basename "$ORACLE_FILE" )" ]'
}

SHUNIT_PARENT=$0 . $SHUNIT2
