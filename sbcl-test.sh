#!/usr/bin/env bash

version=${VERSION:-1.4.8}
project_dir="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case $(uname -s) in
    Darwin*)
        workdir=${project_dir}/work/darwin
        ;;
    Linux*)
        workdir=${project_dir}/work/linux
        ;;
    *)
        echo 'Only macOS and Linux are supported!'
        exit 1
        ;;
esac

cd ${workdir}/sbcl-${version}/tests
sh ./run-tests.sh
