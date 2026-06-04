# Run Record: 2026-06-02_002_gosdt_breast_cancer_sweep

## Purpose

Run a small parameter sweep for GOSDT on sklearn breast cancer dataset.

## Status

success / failed

## Git information
```
git rev-parse HEAD
git log -1
```
Commit:
9827e42254c044870335c766d5e51808f7cd5de3

Working tree clean before run:
yes
## Config

Config path:
experiments/001_gosdt_cpu/configs/breast_cancer_sweep.yaml

Parameter grid:
- regularization: 0.05, 0.02, 0.01
- depth_budget: 2, 3, 4

Total tasks:
9

## Slurm information

Master Job ID:
11826610

Array tasks:
0-8

Partition:
compsci

CPUs per task:
2

Memory per task:
4G

GPU:
none

Final state:
COMPLETED

ExitCode:
0:0

## Outputs

Sweep directory:
/usr/xtmp/yw676/DCC_runs/gosdt_cpu/2026-06-02_002_gosdt_breast_cancer_sweep

Summary CSV:
experiments/001_gosdt_cpu/outputs/breast_cancer_sweep_summary.csv

Slurm logs:
experiments/001_gosdt_cpu/outputs/gosdt_bc_sweep_<jobid>_<taskid>.out

## Result summary

Best setting:
depth =234,regularization =0.02,0.01

Best test accuracy:
0.9385964912280702

Observations:
depth =234,regularization =0.02,0.01 all the same

## Issues

Null

## Next action

Use the same workflow for another small dataset or convert this into a reusable GOSDT sweep template.