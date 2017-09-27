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
# Unit tests for sgrep

test_sgrep() {
  expected="[section 1]
abc = def"
  result=$(sgrep 'def' "${dataFile}" 2>&1)
  assertEquals "${expected}" "${result}"

  expected="[section 2]
abc = ghi

[section 4]
ghi = jkl"
  result=$(sgrep 'ghi' "${dataFile}" 2>&1)
  assertEquals "${expected}" "${result}"
}

setUp() {
  dataFile="${__shunit_tmpDir:-/tmp}/data"
  cat >"${dataFile}" <<EOF
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

# Run shUnit2.
# shellcheck disable=SC1091
. "${SHLIB_LIBDIR:-../lib}/shunit2"
