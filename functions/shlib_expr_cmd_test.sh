#! /bin/sh
# vim:et:ft=sh:sts=2:sw=2
#
# Unit tests for shlib_expr_cmd.
#
# Copyright 2020 Kate Ward. All Rights Reserved.
# Released under the Apache 2.0 license.
#
# Author: kate.ward@forestent.com (Kate Ward)
# https://github.com/kward/shlib

# Exit immediately if a simple command exits with a non-zero status.
set -e

# Treat unset variables as an error when performing parameter expansion.
set -u

testExprCmd() {
	expr_cmd=$(shlib_expr_cmd)
	assertTrue $?
	assertNotEquals "${expr_cmd}" ''

	echo "expr_cmd: ${expr_cmd}" >&2
}

oneTimeSetUp() {
 # Load the function.
  # shellcheck disable=SC1090
  . "$(echo "$0" |sed 's/_test.sh$//')"
}

# Load and run shUnit2.
# shellcheck disable=SC2034
[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
# shellcheck disable=SC1090
. "${SHUNIT_LIB:-../lib}/shunit2"
