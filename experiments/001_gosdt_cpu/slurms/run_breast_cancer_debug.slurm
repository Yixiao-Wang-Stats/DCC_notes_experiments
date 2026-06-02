#!/bin/bash
#SBATCH --job-name=gosdt_bc_debug
#SBATCH --partition=compsci
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=00:20:00
#SBATCH --output=experiments/001_gosdt_cpu/outputs/gosdt_bc_debug_%j.out
#SBATCH --error=experiments/001_gosdt_cpu/outputs/gosdt_bc_debug_%j.err

set -euo pipefail

RUN_ID="2026-06-02_001_gosdt_breast_cancer_cpu_debug"
PROJECT="gosdt_cpu"
REPO_DIR="/home/users/yw676/projects/DCC_notes_experiments"
ENV_PATH="/usr/xtmp/yw676/envs/gosdt-cpu"
OUTPUT_ROOT="/usr/xtmp/yw676/DCC_runs/${PROJECT}"
OUTPUT_DIR="${OUTPUT_ROOT}/${RUN_ID}"

mkdir -p "${OUTPUT_DIR}"

cd "${REPO_DIR}"

echo "===== GOSDT CPU JOB START ====="
echo "run_id: ${RUN_ID}"
echo "job_id: ${SLURM_JOB_ID}"
echo "partition: ${SLURM_JOB_PARTITION}"
echo "node: $(hostname)"
echo "cpus: ${SLURM_CPUS_PER_TASK}"
echo "output_dir: ${OUTPUT_DIR}"
echo "start_time: $(date)"
echo "current_dir: $(pwd)"
echo "git_commit: $(git rev-parse HEAD)"

source "${ENV_PATH}/bin/activate"

echo "python_path: $(which python)"
python --version

python experiments/001_gosdt_cpu/scripts/run_gosdt_breast_cancer_debug.py \
  --output-dir "${OUTPUT_DIR}" \
  --seed 2026 \
  --regularization 0.02 \
  --depth-budget 3 \
  --time-limit 60 \
  --gbdt-n-estimators 20 \
  --gbdt-max-depth 1

if [ ! -f "${OUTPUT_DIR}/metrics.json" ]; then
  echo "ERROR: metrics.json was not created."
  exit 1
fi

echo "metrics_file: ${OUTPUT_DIR}/metrics.json"
echo "tree_file: ${OUTPUT_DIR}/tree.txt"
echo "end_time: $(date)"
echo "final_status: success"
echo "===== GOSDT CPU JOB END ====="