#!/usr/bin/env bash

version=${VERSION:-1.4.7}

case $(uname -s) in
    Darwin*)
        workdir=${CI_PROJECT_DIR:-/tmp/sbcl}/work/osx
        ;;
    Linux*)
        workdir=${CI_PROJECT_DIR:-/tmp/sbcl}/work/linux
        ;;
    *)
        echo 'Only macOS and Linux are supported!'
        exit 1
        ;;
esac

cd ${workdir}/sbcl-${version}/tests
sh ./run-tests.sh
