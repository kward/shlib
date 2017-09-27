#!/bin/sh
#
# shlib unit test suite runner.
#
# Copyright 2017 Kate Ward. All rights reserved.
# Released under the Apache 2.0 license.
#
# Author: kate.ward@forestent.com (Kate Ward)
# https://github.com/kward/shlib

export SHLIB_LIBDIR='../lib'

for d in functions standalone; do
  (
  	cd "${d}"
  	tests="$(echo *_test.sh)"
  	for t in ${tests}; do
  		echo "-------------------------------------------------------------------------------"
  		echo "Running ${d}/${t}".
  		echo
  	  ( "./${t}"; )
  	  echo
  	done
  )
done
