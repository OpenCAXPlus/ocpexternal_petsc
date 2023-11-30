#!/bin/bash
# This is a template script to install the external project
# You should create a configuration folder and copy this script
# to the folder for actual installation.
config=$(basename "${BASH_SOURCE[0]}" .sh)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
root="$script_dir/.."
source_dir="$script_dir/../source"
build_dir="$script_dir/../build/$OCP_COMPILER/$config"
install_dir="$script_dir/../install/$OCP_COMPILER/$config"


# ncpu=$(cat /proc/cpuinfo| grep "cpu cores"| uniq | sed 's/[^0-9]//g')
# use_cpu=$(($ncpu-1))

mkdir -p $build_dir
cp -r $source_dir/* $build_dir
cd $build_dir
CC=$OCP_CC CXX=$OCP_CXX ./configure --prefix=${install_dir} --with-fortran-bindings=0 \
        --with-hypre-dir=$OCP_HYPRE_DIR \
        --with-debugging=0 \
        COPTFLAGS="-O3" \
        CXXOPTFLAGS="-O3" \

make -j$(($(nproc) - 1))
make install
