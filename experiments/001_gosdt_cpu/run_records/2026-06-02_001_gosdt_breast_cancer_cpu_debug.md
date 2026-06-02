# Run Record: 2026-06-02_001_gosdt_breast_cancer_cpu_debug

## Purpose

Run the first GOSDT CPU debug experiment on the Duke CS cluster using sklearn's breast cancer dataset.

## Status

success

## Git information

Commit:
"run godst for breast cancer"

Working tree clean before run:
yes

## Config

Config path:
experiments/001_gosdt_cpu/configs/breast_cancer_debug.yaml

Important parameters:
- dataset: sklearn breast cancer
- seed: 2026
- regularization: 0.02
- depth_budget: 3
- time_limit: 60
- gbdt_n_estimators: 20
- gbdt_max_depth: 1

## Slurm information

Job ID:
11826582

Partition:
compsci


CPUs:
2

Memory:
4G

GPU:
none

Final state:
COMPLETED

ExitCode:
0:0

## Environment

Environment name:
gosdt-cpu

Python path:
/usr/xtmp/yw676/envs/gosdt-cpu/bin/python

Python version:
Python 3.10.12

## Outputs

Output directory:
/usr/xtmp/yw676/DCC_runs/gosdt_cpu/2026-06-02_001_gosdt_breast_cancer_cpu_debug

Metrics file:
/usr/xtmp/yw676/DCC_runs/gosdt_cpu/2026-06-02_001_gosdt_breast_cancer_cpu_debug/metrics.json

Tree file:
/usr/xtmp/yw676/DCC_runs/gosdt_cpu/2026-06-02_001_gosdt_breast_cancer_cpu_debug/tree.txt

Slurm stdout:
<fill>

Slurm stderr:
/usr/xtmp/yw676/envs/gosdt-cpu/lib/python3.10/site-packages/sklearn/utils/deprecation.py:132: FutureWarning: 'force_all_finite' was renamed to 'ensure_all_finite' in 1.6 and will be removed in 1.8.
  warnings.warn(
/usr/xtmp/yw676/envs/gosdt-cpu/lib/python3.10/site-packages/sklearn/utils/deprecation.py:132: FutureWarning: 'force_all_finite' was renamed to 'ensure_all_finite' in 1.6 and will be removed in 1.8.
  warnings.warn(


## Result summary

Train accuracy:
  "train_accuracy": 0.9494505494505494,

Test accuracy:

  "test_accuracy": 0.9385964912280702,

Binarized number of features:
9

GOSDT training time:
0


## Next action

Try regularization values such as 0.05, 0.02, 0.01 and depth budgets 2, 3, 4.