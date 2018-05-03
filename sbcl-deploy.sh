#!/usr/bin/env bash

version=${VERSION:-1.4.7}
prefix=${PREFIX:-/tmp/sbcl/sbcl-bin}
workdir=/tmp/sbcl/work

uname_s=$(uname -s)

case ${uname_s} in
    Darwin*)
        arch=x86-64-darwin
        md5=md5
        ;;
    Linux*)
        arch=x86-64-linux
        md5=md5sum
        ;;
    *)
        echo 'Only macOS and Linux are supported!'
        exit 1
        ;;
esac

cd $workdir
rm -rf sbcl-${version}-${arch}
mv sbcl-${version} sbcl-${version}-${arch}
sbcl-${version}-${arch}/binary-distribution.sh sbcl-${version}-${arch}
bzip2 sbcl-${version}-${arch}-binary.tar
echo $(${md5} sbcl-${version}-${arch}-binary.tar.bz2)
echo $(pwd)/sbcl-${version}-${arch}-binary.tar.bz2 >/tmp/artifact.txt
