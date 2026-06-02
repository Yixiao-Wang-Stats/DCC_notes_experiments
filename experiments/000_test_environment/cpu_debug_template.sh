#!/bin/bash
#SBATCH --job-name=cpu_debug
#SBATCH --partition=compsci
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --output=experiments/000_test_environment/logs/cpu_debug_%j.out
#SBATCH --error=experiments/000_test_environment/logs/cpu_debug_%j.err

set -euo pipefail

PROJECT_NAME="dcc_test"
RUN_ID="$(date +%Y-%m-%d)_dcc_test_cpu_debug"
export OUTPUT_DIR="/usr/xtmp/yw676/DCC_runs/${PROJECT_NAME}/${RUN_ID}"

mkdir -p "${OUTPUT_DIR}"

echo "===== CPU DEBUG JOB START ====="
echo "run_id: ${RUN_ID}"
echo "job_id: ${SLURM_JOB_ID}"
echo "partition: ${SLURM_JOB_PARTITION}"
echo "node: $(hostname)"
echo "cpus: ${SLURM_CPUS_PER_TASK}"
echo "output_dir: ${OUTPUT_DIR}"
echo "start_time: $(date)"
echo "current_dir: $(pwd)"
echo "git_commit: $(git rev-parse HEAD 2>/dev/null || echo 'not a git repo')"

source /home/users/yw676/envs/dcc-basic/bin/activate

echo "python_path: $(which python)"
python --version

python - << 'EOF'
import os
import socket
import platform
import numpy as np
import pandas as pd
import sklearn
import matplotlib

print("===== PYTHON ENV TEST =====")
print("hostname:", socket.gethostname())
print("platform:", platform.platform())
print("numpy:", np.__version__)
print("pandas:", pd.__version__)
print("sklearn:", sklearn.__version__)
print("matplotlib:", matplotlib.__version__)

x = np.arange(10)
print("x:", x)
print("mean:", x.mean())

output_dir = os.environ.get("OUTPUT_DIR")
if output_dir is None:
    output_dir = "/usr/xtmp/yw676/DCC_runs/dcc_test/manual_test"

os.makedirs(output_dir, exist_ok=True)

result_path = os.path.join(output_dir, "result.txt")
with open(result_path, "w") as f:
    f.write("CPU debug job succeeded.\n")
    f.write(f"mean = {x.mean()}\n")

print("result saved to:", result_path)
EOF

echo "end_time: $(date)"
echo "final_status: success"
echo "===== CPU DEBUG JOB END ====="