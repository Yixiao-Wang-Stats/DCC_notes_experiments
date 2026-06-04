# TabPFN Environment

## Purpose

This environment is used for TabPFN foundation-model experiments, including CPU and GPU comparison.

## Location

/usr/xtmp/yw676/envs/tabpfn

## Creation method

Python venv

## Main packages

- numpy
- pandas
- scikit-learn
- matplotlib
- torch
- tabpfn

## Cache policy

Large model caches should be stored under:

/usr/xtmp/yw676/model_cache

Environment variables used in jobs:

XDG_CACHE_HOME=/usr/xtmp/yw676/model_cache/xdg
HF_HOME=/usr/xtmp/yw676/model_cache/huggingface
TORCH_HOME=/usr/xtmp/yw676/model_cache/torch

## Activation

source /usr/xtmp/yw676/envs/tabpfn/bin/activate

## Python executable

<fill>

## Python version

<fill>

## Package versions

numpy:
pandas:
scikit-learn:
matplotlib:
torch:
tabpfn:
torch cuda available on CPU job:
<fill>

numpy: 2.2.6
pandas: 2.3.3
sklearn: 1.7.2
torch: 2.12.0+cu130
torch cuda available: False
tabpfn import: success

## Notes

This environment is stored in xtmp, so it may need to be rebuilt if cleaned.
CPU jobs are for debugging only; GPU jobs are preferred for practical TabPFN inference.