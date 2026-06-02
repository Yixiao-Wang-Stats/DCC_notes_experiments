#!/bin/bash

#SBATCH --job-name=python_test_5
#SBATCH --partition=compsci
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:03:00
#SBATCH --output=experiments/000_test_environment/logs/python_test_5.out

python3 experiments/000_test_environment/test_5.py