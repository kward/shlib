#!/bin/sh
#
# shlib unit test suite runner.
#
# Copyright 2017 Kate Ward. All rights reserved.
# Released under the Apache 2.0 license.
#
# Author: kate.ward@forestent.com (Kate Ward)
# https://github.com/kward/shlib

true; TRUE=$?
false; FALSE=$?

export SHLIB_LIBDIR='../lib'

rtrn=${TRUE}
for d in functions standalone; do
  (
    cd "${d}"
    tests="$(echo *_test.sh)"
    for t in ${tests}; do
      echo "-------------------------------------------------------------------------------"
      echo "Running ${d}/${t}".
      echo
      ( "./${t}"; )
      [ $? -eq ${TRUE} ] || rtrn=${FALSE}
      echo
    done
    exit "${rtrn}"
  )
  rtrn=$?
done
exit "${rtrn}"
