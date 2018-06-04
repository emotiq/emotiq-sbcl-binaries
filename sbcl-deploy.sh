#!/usr/bin/env bash

version=${VERSION:-1.4.7}
prefix=${PREFIX:-/tmp/sbcl/sbcl-bin}
project_dir="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z ${platform+x} ]; then
  echo "\$platform is unset."
  echo "Expected architecture (e.g. linux)"
  exit 1
fi

workdir=work/${platform}
arch=x86-64-${platform}

cd $workdir
rm -rf sbcl-${version}-${arch}
mv sbcl-${version} sbcl-${version}-${arch}
sbcl-${version}-${arch}/binary-distribution.sh sbcl-${version}-${arch}
bzip2 sbcl-${version}-${arch}-binary.tar
echo $(${md5} sbcl-${version}-${arch}-binary.tar.bz2)
echo $(pwd)/sbcl-${version}-${arch}-binary.tar.bz2 >/tmp/artifact.txt
