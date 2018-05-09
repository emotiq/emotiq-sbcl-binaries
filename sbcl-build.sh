#!/usr/bin/env bash

version=${VERSION:-1.4.7}
prefix=${PREFIX:-/tmp/sbcl/sbcl-bin}
workdir=/tmp/sbcl/work
source_tar=http://prdownloads.sourceforge.net/sbcl/sbcl-${version}-source.tar.bz2
patch0_name=patch-make-doc.diff
patch0_url="https://raw.githubusercontent.com/Homebrew/formula-patches/c5ffdb11/sbcl/${patch0_name}"

for d in $prefix $workdir ; do
  mkdir -p $d
done

install_deps_linux() {
  sudo apt-get update && sudo apt-get install -y \
    build-essential \
    ed \
    wget
}

uname_s=$(uname -s)

case ${uname_s} in
    Darwin*)
        bootstrap_lisp_url='http://prdownloads.sourceforge.net/sbcl/sbcl-1.2.11-x86-64-darwin-binary.tar.bz2'
        bootstrap_folder=${workdir}/sbcl-1.2.11-x86-64-darwin
        ;;
    Linux*)
        bootstrap_lisp_url='http://prdownloads.sourceforge.net/sbcl/sbcl-1.4.7-x86-64-linux-binary.tar.bz2'
        bootstrap_folder=${workdir}/sbcl-1.4.7-x86-64-linux
        install_deps_linux
        ;;
    *)
        echo 'Only macOS and Linux are supported!'
        exit 1
        ;;
esac

cp patches/patch-test-frlock.diff ${workdir}
cd $workdir
wget -O - ${bootstrap_lisp_url} | tar xfj -
wget -O - ${source_tar} | tar xfj -
wget ${patch0_url}
cd sbcl-${version}
patch -p0 <${workdir}/${patch0_name}
patch -p0 <${workdir}/patch-test-frlock.diff

command="${bootstrap_folder}/src/runtime/sbcl"
core="${bootstrap_folder}/output/sbcl.core"

sh ./make.sh --prefix=${prefix} --xc-host="${command} --core ${core} --disable-debugger --no-userinit --no-sysinit"
