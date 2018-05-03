#!/usr/bin/env bash

version=${VERSION:-1.4.7}
workdir=/tmp/sbcl/work

cd ${workdir}/sbcl-${version}/tests
sh ./run-tests.sh
