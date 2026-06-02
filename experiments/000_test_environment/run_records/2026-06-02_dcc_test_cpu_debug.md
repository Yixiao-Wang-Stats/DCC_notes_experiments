# Run Record: 2026-06-02_dcc_test_cpu_debug

## Purpose

Test the reusable CPU debug Slurm template on Duke CS cluster.

## Status

success

## Git information

Commit:
0b357f9269a27a1c9056d2cfd3e3adec8cc5e1f2

Working tree clean before run:
yes / no

## Slurm information

Job ID:
11826464

Partition:
compsci

Node:
compsci-cluster-fitz-35

CPUs:
1

GPU:
none

## Environment

Environment name:
dcc-basic

Python path:
/home/users/yw676/envs/dcc-basic/bin/python

Python version:
3.10.12

Main packages:
- numpy 2.2.6
- pandas 2.3.3
- scikit-learn 1.7.2
- matplotlib 3.10.9

## Paths

Working directory:
/home/users/yw676/projects/DCC_notes_experiments

Output directory:
/usr/xtmp/yw676/DCC_runs/dcc_test/2026-06-02_dcc_test_cpu_debug

Result file:
/usr/xtmp/yw676/DCC_runs/dcc_test/2026-06-02_dcc_test_cpu_debug/result.txt

Log file:
______

## Result summary

The job successfully activated the dcc-basic environment, imported core Python packages, computed a simple numpy mean, and wrote a result file.

## Lessons learned

A reusable CPU debug Slurm template should print metadata, activate the environment, create a run directory, save output, and report final status.