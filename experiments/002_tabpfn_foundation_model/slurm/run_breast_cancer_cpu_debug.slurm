#!/bin/bash
#SBATCH --job-name=tabpfn_cpu_debug
#SBATCH --partition=compsci
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=00:30:00
#SBATCH --output=experiments/002_tabpfn_foundation_model/outputs/tabpfn_cpu_debug_%j.out
#SBATCH --error=experiments/002_tabpfn_foundation_model/outputs/tabpfn_cpu_debug_%j.err

set -euo pipefail

RUN_ID="2026-06-02_001_tabpfn_breast_cancer_cpu_debug"
PROJECT="tabpfn"
REPO_DIR="/home/users/yw676/projects/DCC_notes_experiments"
ENV_PATH="/usr/xtmp/yw676/envs/tabpfn"
OUTPUT_ROOT="/usr/xtmp/yw676/DCC_runs/${PROJECT}"
OUTPUT_DIR="${OUTPUT_ROOT}/${RUN_ID}"

mkdir -p "${OUTPUT_DIR}"

export XDG_CACHE_HOME="/usr/xtmp/yw676/model_cache/xdg"
export HF_HOME="/usr/xtmp/yw676/model_cache/huggingface"
export TORCH_HOME="/usr/xtmp/yw676/model_cache/torch"

cd "${REPO_DIR}"

echo "===== TABPFN CPU DEBUG JOB START ====="
echo "run_id: ${RUN_ID}"
echo "job_id: ${SLURM_JOB_ID}"
echo "partition: ${SLURM_JOB_PARTITION}"
echo "node: $(hostname)"
echo "cpus: ${SLURM_CPUS_PER_TASK}"
echo "output_dir: ${OUTPUT_DIR}"
echo "start_time: $(date)"
echo "current_dir: $(pwd)"
echo "git_commit: $(git rev-parse HEAD)"
echo "CUDA_VISIBLE_DEVICES: ${CUDA_VISIBLE_DEVICES:-not_set}"
echo "XDG_CACHE_HOME: ${XDG_CACHE_HOME}"
echo "HF_HOME: ${HF_HOME}"
echo "TORCH_HOME: ${TORCH_HOME}"

source "${ENV_PATH}/bin/activate"

echo "python_path: $(which python)"
python --version

python experiments/002_tabpfn_foundation_model/scripts/run_tabpfn_breast_cancer.py \
  --output-dir "${OUTPUT_DIR}" \
  --device cpu \
  --max-train-samples 100 \
  --max-test-samples 50 \
  --seed 2026

if [ ! -f "${OUTPUT_DIR}/metrics.json" ]; then
  echo "ERROR: metrics.json was not created."
  exit 1
fi

echo "metrics_file: ${OUTPUT_DIR}/metrics.json"
echo "end_time: $(date)"
echo "final_status: success"
echo "===== TABPFN CPU DEBUG JOB END ====="