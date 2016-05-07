#!/usr/bin/env bash
. ./test/helper.sh

test_shared_memory() {
	local directory='/dev/shm'
	assertTrue "'$directory' is not a directory" '[ -d "$directory" ]'

	local size="$( df -B1 "$directory" | awk -- 'NR == 2 { print $2 }' )"
	assertTrue "'$size' is less than two GiB" '[ "$size" -ge 2147483648 ]'
}

test_stubbed_chkconfig() {
	local executable='/sbin/chkconfig'
	local fstat="$( stat -c '%a' "$executable" )"

	assertTrue "$executable is not executable ($fstat)" '[ "$fstat" = 744 ]' || return
	assertEquals '#!/bin/sh' "$( cat "$executable" )"
}

test_lock_directory() {
	local directory='/var/lock/subsys'
	assertTrue "'$directory' is not a directory" '[ -d "$directory" ]'
}

test_oracle_installed() {
	assertTrue "Missing init script" '[ -e /etc/init.d/oracle-xe ]'
	assertTrue "Missing '$ORACLE_HOME'" '[ -e "$ORACLE_HOME" ]'
	assertTrue "Missing SQL*Plus" '[ -x "$ORACLE_HOME/bin/sqlplus" ]'
}

test_normal_access_without_password() {
	"$ORACLE_HOME/bin/sqlplus" -L -S / <<< exit
	assertEquals 0 $?
}

test_dba_access_without_password() {
	"$ORACLE_HOME/bin/sqlplus" -L -S / AS SYSDBA <<< exit
	assertEquals 0 $?
}

SHUNIT_PARENT=$0 . $SHUNIT2
