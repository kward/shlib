#!/bin/sh
# Copyright 2008 Kate Ward. All Rights Reserved.
# Released under the Apache 2.0 license.
#
# Author: kate.ward@forestent.com (Kate Ward)

mock_pwd() { echo '/path/to/cwd'; }

testRelToAbsPath() {
  pwd='mock_pwd'

  cwd='/path/to/cwd'
  parent='/path/to'
  grandparent='/path'

  # Save STDIN and redirect it from an in-line file.
  exec 9<&0 <<EOF
abc ${cwd}/abc
abc/def ${cwd}/abc/def
abc/def/ghi ${cwd}/abc/def/ghi
abc/./def ${cwd}/abc/def
abc/../def ${cwd}/def
abc/../def/../ghi ${cwd}/ghi
/abc /abc
/abc/def /abc/def
/abc/def/ghi /abc/def/ghi
/abc/def/../../ghi /ghi
/abc/def/ghi/../../jkl /abc/jkl
/abc/../def /def
/abc/../def/../ghi /ghi
./abc ${cwd}/abc
../abc ${parent}/abc
../abc/def ${parent}/abc/def
../../abc/def ${grandparent}/abc/def
${cwd}/../../abc/def ${grandparent}/abc/def
EOF
  while read relPath absPath; do
    # Ignore comment and blank lines.
    echo "${relPath}" |egrep -v "^(#|$)" >/dev/null || continue

    # Test the function.
    newPath=`PWD=${cwd} shlib_relToAbsPath "${relPath}"`
    assertEquals "${relPath}" "${absPath}" "${newPath}"
  done
  exec 0<&9 9<&-
}

oneTimeSetUp() {
	SHLIB_PWD_DEFAULT=${SHLIB_PWD}

	# Load the function.
  . './'`basename $0 |sed 's/_test.sh$/.sh/'`
}

setUp() {
  SHLIB_PWD='mock_pwd'
}

tearDown() {
  SHLIB_PWD=${SHLIB_PWD_DEFAULT}
}

# Run shunit2.
. ../lib/shunit2
