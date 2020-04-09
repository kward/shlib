#! /bin/sh
#
# Unit test for test_runner.
#
# Copyright 2017 Kate Ward. All Rights Reserved.
# Released under the Apache 2.0 license.
#
# Author: kate.ward@forestent.com (Kate Ward)
# https://github.com/kward/shlib
#
### ShellCheck (http://www.shellcheck.net/)
# Disable source following.
#   shellcheck disable=SC1090,SC1091

# Treat unset variables as an error.
set -u

test_testName() {
  # shellcheck disable=SC2162
  while read desc t tName; do
    got=$(_runner_testName "${t}")
    want=${tName}
    assertEquals "${desc}" "${want}" "${got}"
  done <<EOF
valid   valid_script_test.sh valid_script
unknown invalid_script       unknown
empty   ''                   unknown
EOF
  unset desc suite suiteName
}

oneTimeSetUp() {
  . ./test_runner
}

# Configure zsh properly for shUnit2.
if [ -n "${ZSH_VERSION:-}" ]; then
  # shellcheck disable=SC2034
  SHUNIT_PARENT=$0
  setopt shwordsplit
fi

# Load and run shUnit2.
# shellcheck disable=SC2034
[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
# shellcheck disable=SC1090
. "${SHUNIT_INC:-../lib/shunit2}"
