#!/bin/bash
#SBATCH --job-name=dcc_basic_test
#SBATCH --partition=compsci
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:05:00
#SBATCH --output=experiments/000_test_environment/dcc_basic_%j.out
#SBATCH --error=experiments/000_test_environment/dcc_basic_%j.err

echo "Job ID: $SLURM_JOB_ID"
echo "Node: $(hostname)"
echo "Start time: $(date)"

source /home/users/yw676/envs/dcc-basic/bin/activate

which python
python --version

python experiments/000_test_environment/test_env.py

echo "End time: $(date)"
echo "Succeeded: yes"