#!/bin/sh
#
# shlib unit test suite runner.
#
# Copyright 2017 Kate Ward. All rights reserved.
# Released under the Apache 2.0 license.
#
# Author: kate.ward@forestent.com (Kate Ward)
# https://github.com/kward/shlib

BASENAME="$(basename "$0")"
export SHLIB_LIBDIR='lib'

find . -name "*.sh" |grep -v "/${BASENAME}$" |xargs -n1 -P1 /bin/sh
