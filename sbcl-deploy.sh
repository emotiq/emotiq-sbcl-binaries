#!/usr/bin/env bash

version=${VERSION:-1.4.7}
prefix=${PREFIX:-/tmp/sbcl/sbcl-bin}
project_dir="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z ${arch+x} ]; then
  echo "\$arch is unset."
  echo "Expected architecture (e.g. x86-64-linux)"
  exit 1
fi

cd $workdir
rm -rf sbcl-${version}-${arch}
mv sbcl-${version} sbcl-${version}-${arch}
sbcl-${version}-${arch}/binary-distribution.sh sbcl-${version}-${arch}
bzip2 sbcl-${version}-${arch}-binary.tar
echo $(${md5} sbcl-${version}-${arch}-binary.tar.bz2)
echo $(pwd)/sbcl-${version}-${arch}-binary.tar.bz2 >/tmp/artifact.txt
