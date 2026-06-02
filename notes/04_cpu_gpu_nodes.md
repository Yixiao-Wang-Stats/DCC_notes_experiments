# CPU/GPU Nodes and Partitions

Partition = a queue or group of machines managed by Slurm.

compsci:
General CPU / departmental compute partition. Use it when I am unsure or when the job does not need GPU.

compsci-gpu:
GPU partition. Use it only when the job actually needs GPU.

rudin:
Research-group partition for Cynthia Rudin's group. It gives priority access to Rudin group resources, but it is still a shared research resource and should be used responsibly.

A node is a physical machine. A partition is a queue that contains multiple nodes.
## Purpose

## Core concepts

## Duke CS partitions
```
sinfo  // partitions
sinfo -N // see nodes
```

compsci, compsci-gpu*, rudin

TIMELIMIT: 90hours

What is the number of NODES mean? <= how many nodes do they have in this partition

STATE:drain (not allowed to use), mix (partially be used), idle (completely free), alloc(allocated)

## CPU resources

## GPU resources

RTX 6000 Pro    96GB VRAM
A6000           48GB VRAM
RTX 5000 Ada    32GB VRAM
V100            32GB VRAM
A5000           24GB VRAM
P100            12GB VRAM
2080 RTX Ti     11GB VRAM

## Rudin partition

## How I choose resources

GPU selection is mainly determined by VRAM, model size, batch size, and whether I need multi-GPU training.

## compsci partition observation
```
scontrol show partition compsci
```

PartitionName:compsci
DefaultTime: 4 days
MaxTime: 90 days
TotalNodes: 48
TotalCPUs: 2448 => average number of slurm is 50
Default memory: 4500M 4.5G
Node list: compsci-cluster-fitz-[35-44],linux[1-7,9-22,24-40]



## compsci-gpu partition observation

compsci-gpu summary:
- DefaultTime: same
- MaxTime: same
- TotalNodes: 62 
- TotalCPUs: 3192
- GPU node examples: gres/gpu=217,gres/gpu:a5000=124,gres/gpu:a6000=16,gres/gpu:p100=25,gres/gpu:rtx_2080=22,gres/gpu:rtx_5000=5,gres/gpu:rtx_pro_6000=20,gres/gpu:v100=5

