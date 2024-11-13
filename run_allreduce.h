ROOT_PATH=$(dirname "$(readlink -f "$0")")

HOSTFILE=${1:-$ROOT_PATH/hostfile.1node}
NNODES=`cat $HOSTFILE | wc -l`
GPUS_PER_NODE=`sed -n 's/.*slots=\([0-9]*\).*/\1/p' $HOSTFILE | head -n 1`
NGPUS=$((NNODES*GPUS_PER_NODE))

mpirun --allow-run-as-root --hostfile $HOSTFILE -np $NGPUS -x CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 -x NCCL_DEBUG=INFO -x NCCL_DEBUG_SUBSYSTEM=INIT $ROOT_PATH/nccl-tests/build/all_reduce_perf -b 128K -e 1G -f 2 -g 1
