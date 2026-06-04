#!/bin/bash
#SBATCH --job-name=tabpfn_gpu_debug
#SBATCH --partition=compsci-gpu
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=00:30:00
#SBATCH --gres=gpu:1
#SBATCH --output=experiments/002_tabpfn_foundation_model/outputs/tabpfn_gpu_debug_%j.out
#SBATCH --error=experiments/002_tabpfn_foundation_model/outputs/tabpfn_gpu_debug_%j.err

set -euo pipefail

RUN_ID="2026-06-02_002_tabpfn_breast_cancer_gpu_debug"
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

echo "===== TABPFN GPU DEBUG JOB START ====="
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

if command -v nvidia-smi &> /dev/null; then
  echo "===== NVIDIA SMI ====="
  nvidia-smi
else
  echo "nvidia-smi not found"
fi

source "${ENV_PATH}/bin/activate"

echo "python_path: $(which python)"
python --version

python - <<'PY'
import torch
print("torch:", torch.__version__)
print("torch cuda available:", torch.cuda.is_available())
print("torch cuda device count:", torch.cuda.device_count())
if torch.cuda.is_available():
    print("gpu name:", torch.cuda.get_device_name(0))
PY

python experiments/002_tabpfn_foundation_model/scripts/run_tabpfn_breast_cancer.py \
  --output-dir "${OUTPUT_DIR}" \
  --device cuda \
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
echo "===== TABPFN GPU DEBUG JOB END ====="