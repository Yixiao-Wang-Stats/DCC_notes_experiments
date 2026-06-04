#!/bin/bash
#SBATCH --job-name=gosdt_bc_sweep
#SBATCH --partition=compsci
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=00:20:00
#SBATCH --array=0-8
#SBATCH --output=experiments/001_gosdt_cpu/outputs/gosdt_bc_sweep_%A_%a.out
#SBATCH --error=experiments/001_gosdt_cpu/outputs/gosdt_bc_sweep_%A_%a.err

set -euo pipefail

MASTER_RUN_ID="2026-06-02_002_gosdt_breast_cancer_sweep"
PROJECT="gosdt_cpu"
REPO_DIR="/home/users/yw676/projects/DCC_notes_experiments"
ENV_PATH="/usr/xtmp/yw676/envs/gosdt-cpu"
OUTPUT_ROOT="/usr/xtmp/yw676/DCC_runs/${PROJECT}/${MASTER_RUN_ID}"

REG_VALUES=(0.05 0.02 0.01)
DEPTH_VALUES=(2 3 4)

TASK_ID="${SLURM_ARRAY_TASK_ID}"

REG_INDEX=$(( TASK_ID / 3 ))
DEPTH_INDEX=$(( TASK_ID % 3 ))

REG="${REG_VALUES[$REG_INDEX]}"
DEPTH="${DEPTH_VALUES[$DEPTH_INDEX]}"

CHILD_RUN_ID="task_${TASK_ID}_reg_${REG}_depth_${DEPTH}"
OUTPUT_DIR="${OUTPUT_ROOT}/${CHILD_RUN_ID}"

mkdir -p "${OUTPUT_DIR}"

cd "${REPO_DIR}"

echo "===== GOSDT SWEEP TASK START ====="
echo "master_run_id: ${MASTER_RUN_ID}"
echo "child_run_id: ${CHILD_RUN_ID}"
echo "array_job_id: ${SLURM_ARRAY_JOB_ID}"
echo "array_task_id: ${SLURM_ARRAY_TASK_ID}"
echo "job_id: ${SLURM_JOB_ID}"
echo "partition: ${SLURM_JOB_PARTITION}"
echo "node: $(hostname)"
echo "cpus: ${SLURM_CPUS_PER_TASK}"
echo "regularization: ${REG}"
echo "depth_budget: ${DEPTH}"
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
  --regularization "${REG}" \
  --depth-budget "${DEPTH}" \
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
echo "===== GOSDT SWEEP TASK END ====="