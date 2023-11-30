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

cd $source_dir
./configure --with-cc=$OCP_CC --with-cxx=$OCP_CXX --with-fc=$OCP_FC  --prefix=${install_dir} \
    --with-cxx=${CXX} --with-fc=gfortran --with-petsc4py=1 --download-mpi4py \
    --download-openblas \
    --download-mpich --download-metis --download-parmetis --download-suitesparse \
    --download-mumps --download-hypre --download-slepc --download-eigen \
    --download-scalapack --download-superlu --download-fftw

make -j$(($(nproc) - 1))
make install
