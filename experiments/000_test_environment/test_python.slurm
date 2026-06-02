#!/bin/bash

#SBATCH --job-name=python_test
#SBATCH --partition=compsci
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:01:00
#SBATCH --output=experiments/000_test_environment/logs/python_test.out

python3 -c "
import platform
import socket
from datetime import datetime

print('Python:', platform.python_version())
print('Hostname:', socket.gethostname())
print('Time:', datetime.now())
"