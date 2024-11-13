ROOT_PATH=$(dirname "$(readlink -f "$0")")

HOSTFILE=${1:-$ROOT_PATH/hostfile}
NNODES=`cat $HOSTFILE | wc -l`
GPUS_PER_NODE=`sed -n 's/.*slots=\([0-9]*\).*/\1/p' $HOSTFILE | head -n 1`
NGPUS=$((NNODES*GPUS_PER_NODE))

#mpirun --allow-run-as-root --hostfile $HOSTFILE -np $NGPUS -x NCCL_DEBUG=INFO -x NCCL_DEBUG_SUBSYSTEM=NET -x NCCL_IB_HCA=mlx5_2 -x NCCL_NET_GDR_LEVEL=PXB -x NCCL_IB_QPS_PER_CONNECTION=4 -x NCCL_BUFFSIZE=67108864 $ROOT_PATH/nccl-tests/build/sendrecv_perf -b 128K -e 1G -f 2 -g 1
mpirun --allow-run-as-root --hostfile $HOSTFILE -np $NGPUS -x NCCL_DEBUG=INFO -x NCCL_DEBUG_SUBSYSTEM=NET -x NCCL_NET_GDR_LEVEL=PXB -x NCCL_IB_QPS_PER_CONNECTION=4 -x NCCL_BUFFSIZE=67108864 $ROOT_PATH/nccl-tests/build/sendrecv_perf -b 128K -e 1G -f 2 -g 1
