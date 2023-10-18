#!/bin/bash
# This is a template script to install the external project
# You should create a configuration folder and copy this script
# to the folder for actual installation.
config=$(basename "${BASH_SOURCE[0]}" .sh)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
root="$script_dir/.."
source_dir="$script_dir/../source"
build_dir="$script_dir/../build/$config"
install_dir="$script_dir/../install/$config"
CC=gcc
CXX=g++

ncpu=$(cat /proc/cpuinfo| grep "cpu cores"| uniq | sed 's/[^0-9]//g')
use_cpu=$(($ncpu-1))

cd $source_dir
./configure --prefix=${install_dir}  --with-cc=${CC} \
    --with-cxx=${CXX} --with-fc=gfortran --with-petsc4py=1 --download-mpi4py \
    --with-blas-lib=${OCP_CACHE}/lapack/3.11.0/install/lib/libblas.a \
    --with-lapack-lib=${OCP_CACHE}/lapack/3.11.0/install/lib/liblapack.a \
    --download-mpich --download-metis --download-parmetis --download-suitesparse \
    --download-mumps --download-hypre --download-slepc --download-eigen \
    --download-scalapack --download-superlu --download-fftw

make -j${use_cpu}
make install
