ROOT_PATH=$(readlink -f "$0")

# Make sure all submodules have been cloned, if not
# git submodule init && git submodule update

# Build nccl
cd $ROOT_PATH/nccl/
make -j32 src.build NVCC_GENCODE="-gencode=arch=compute_70,code=sm_70 -gencode=arch=compute_80,code=sm_80 -gencode=arch=compute_90,code=sm_90"

# Build nccl-tests
cd $ROOT_PATH/nccl-tests/
make -j32 MPI=1 MPI_HOME=/usr/local/mpi CUDA_HOME=/usr/local/cuda NCCL_HOME=$ROOT_PATH/nccl

