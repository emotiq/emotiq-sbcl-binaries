#!/usr/bin/env bash

version=${VERSION:-1.4.7}
workdir=${CI_PROJECT_DIR:-/tmp/sbcl}/work

cd ${workdir}/sbcl-${version}/tests
sh ./run-tests.sh
