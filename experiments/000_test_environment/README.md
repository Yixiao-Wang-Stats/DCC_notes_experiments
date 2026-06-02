# 000 Test Environment

## Purpose

This experiment checks whether I can correctly use Slurm to run a small CPU job on a compute node instead of the login node.

## Resource plan

Partition:
compsci

CPU:
1 core

Memory:
small, around 1G to 4G

Time:
short, around 5 to 10 minutes

GPU:
none

## Expected learning outcome

After this experiment, I should understand:
- how to request a small CPU job
- how to tell whether I am on a login node or compute node
- how to monitor my Slurm job
- how to save logs
- how to avoid running heavy tasks on the login node


## interactive session
command structure:
srun
  choose partition
  choose CPU number
  choose memory
  choose time
  request an interactive shell
```
srun --partition=<partition> --cpus-per-task=<number> --mem=<memory> --time=<time> --pty bash

srun --partition=compsci --cpus-per-task=1 --mem=1G --time=01:00:00 --pty bash
```

Interactive job hostname: compsci-cluster-fitz-35

```
python3 -c "
import platform
import socket
from datetime import datetime

print('Python:', platform.python_version())
print('Hostname:', socket.gethostname())
print('Time:', datetime.now())
"
```
outputs: Python: 3.10.12
Hostname: compsci-cluster-fitz-35
Time: 2026-06-02 00:21:47.456784

exit: Ctrl+D or exit 

Interactive session closed:
yes

## Batch job resource request

Partition:
compsci

CPUs:
1

Memory:
1G or 2G

Time:
5 to 10 minutes

GPU:
none

Output log:
experiments/000_test_environment/logs/

Job ID: 11826037
Node: compsci-cluster-fitz-35
logs: output=experiments/000_test_environment/logs/python_test.out


Succeeded: yes/no