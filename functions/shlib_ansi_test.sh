#!/bin/sh
# vim:et:ft=sh:sts=2:sw=2
#
# Unit tests for shlib_ansi.
#
# Copyright 2018 Kate Ward. All Rights Reserved.
# Released under the Apache 2.0 license.
#
# Author: kate.ward@forestent.com (Kate Ward)
# https://github.com/kward/shlib

# Treat unset variables as an error.
set -u

testANSIInit() {
  while read -r mode none ok; do
    [ "${none}" = "''" ] && none=''

    (
      tput='mock_tput'
      shlib_ansi_init "${mode}" >"${stdoutF}" 2>"${stderrF}"
      echo $? >"${returnF}"
      echo "${shlib_ansi_none}" >"${gotF}"
    )

    got=`cat "${returnF}"`
    want="${ok}"
    test "${got}" = "${want}"
    assertTrue "${mode} ok: ansi_init exited with '${got}', want '${want}'" $?

    [ "${ok}" -eq "${SHLIB_TRUE}" ] || continue

    echo "${none}" >"${wantF}"
    diff -u "${gotF}" "${wantF}"
    assertTrue "${mode} got and want differ" $?
  done <<EOF
always  ${SHLIB_ANSI_NONE} ${SHLIB_TRUE}
auto    ${SHLIB_ANSI_NONE} ${SHLIB_TRUE}
none    ''                 ${SHLIB_TRUE}
invalid ''                 ${SHLIB_FALSE}
EOF
}

# tput overrides the OS tput command.
mock_tput() {
  echo 256
}

oneTimeSetUp() {
  # Load the function.
  # shellcheck disable=SC1090
  . "$(echo "$0" |sed 's/_test.sh$//')"

  stdoutF="${SHUNIT_TMPDIR}/stdout"
  stderrF="${SHUNIT_TMPDIR}/stderr"
  returnF="${SHUNIT_TMPDIR}/return"
  gotF="${SHUNIT_TMPDIR}/got"
  wantF="${SHUNIT_TMPDIR}/want"
  export stdoutF stderrF returnF gotF wantF
}

# Run shUnit2.
# shellcheck disable=SC1090,SC1091
. "${SHLIB_LIBDIR:-../lib}/shunit2"
