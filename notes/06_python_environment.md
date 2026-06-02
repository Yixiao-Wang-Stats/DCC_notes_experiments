# Python Environment Management

1. Python interpreter
   eg. python3.10

2. Python packages
   eg. numpy, pandas, torch, tabpfn

3. Environment variables
   eg. PATH, PYTHONPATH, CUDA_VISIBLE_DEVICES, HF_HOME

4. Native libraries
   eg. CUDA, C++ runtime, BLAS, libstdc++

## Purpose

## System Python vs virtual environment
system Python:
  cluster 已有的 Python

user site packages:
  用 --user 安装到用户目录的包

virtual environment:
  某个项目专属的隔离 Python 包环境
## pip, venv, conda, module

## Where environments should live
DCC_notes_experiments:
  可以用 repo 内 .venv 或 home/envs/dcc-basic

TabPFN:
  /usr/xtmp/yw676/envs/tabpfn

ZEUS:
  /usr/xtmp/yw676/envs/zeus

GODST:
  根据编译需求，先用 /usr/xtmp/yw676/envs/godst 或项目单独 build dir


## Environment strategy for DCC projects

Purpose:
DCC basic learning environment

Packages:
numpy
pandas
matplotlib
scikit-learn

/home/users/yw676/envs/dcc-basic
## Environment reproducibility

## Slurm + environment activation

## Cache management
For large model projects, I should explicitly set cache directories to /usr/xtmp/yw676/model_cache instead of silently using ~/.cache.
## Common mistakes

## My environment checklist