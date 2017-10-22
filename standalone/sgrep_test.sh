#! /bin/sh
#
# Unit test for sgrep.
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

# DATA_FILE will be overridden in oneTimeSetUp().
DATA_FILE=''

test_sgrep() {
  expected="[section 1]
abc = def"
  result=$(./sgrep 'def' "${DATA_FILE}" 2>&1)
  assertEquals "${expected}" "${result}"

  expected="[section 2]
abc = ghi

[section 4]
ghi = jkl"
  result=$(./sgrep 'ghi' "${DATA_FILE}" 2>&1)
  assertEquals "${expected}" "${result}"
}

oneTimeSetUp() {
  DATA_FILE="${SHUNIT_TMPDIR}/data"
  cat >"${DATA_FILE}" <<EOF
[section 1]
abc = def

[section 2]
abc = ghi

[section 3]
abc = jkl

[section 4]
ghi = jkl
EOF
}

setUp() {
  case $(uname -s) in
  	Darwin) startSkipping ;;
  esac
}

# Configure zsh properly for shUnit2.
if [ -n "${ZSH_VERSION:-}" ]; then
  # shellcheck disable=SC2034
  SHUNIT_PARENT=$0
  setopt shwordsplit
fi

# Load and run shUnit2.
. "${SHUNIT_INC:-../lib/shunit2}"
