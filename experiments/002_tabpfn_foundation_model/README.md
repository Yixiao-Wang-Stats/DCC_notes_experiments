# 002 TabPFN Foundation Model Workflow

## Purpose

This project tests how to deploy and run TabPFN on the Duke CS cluster, with a focus on comparing CPU and GPU execution.

## Learning goals

- Create a TabPFN-specific Python environment.
- Understand PyTorch CPU vs GPU behavior.
- Run TabPFN on a small sklearn dataset using CPU.
- Run the same TabPFN experiment using GPU.
- Compare runtime, device information, and accuracy.
- Manage model cache outside the Git repo and home directory.
- Save logs, metrics, outputs, and run records.

## Storage policy

Code, configs, Slurm scripts, and run records are stored in this Git repo.

Large model cache and experiment outputs are stored under:

/usr/xtmp/yw676/model_cache
/usr/xtmp/yw676/DCC_runs/tabpfn

## Environment

Environment name:
tabpfn

Environment location:
/usr/xtmp/yw676/envs/tabpfn

## First target

Run a small sklearn breast cancer classification example on both CPU and GPU.

30 days api:


run by cpu:
```
python experiments/002_tabpfn_foundation_model/scripts/run_tabpfn_breast_cancer.py \
  --output-dir /usr/xtmp/yw676/DCC_runs/tabpfn/manual_cpu_debug \
  --device cpu \
  --max-train-samples 100 \
  --max-test-samples 50 \
  --seed 2026
```

cat /usr/xtmp/yw676/DCC_runs/tabpfn/manual_cpu_debug/metrics.json

{
  "seed": 2026,
  "requested_device": "cpu",
  "selected_device": "cpu",
  "hostname": "compsci-cluster-fitz-36",
  "python": "/usr/xtmp/yw676/envs/tabpfn/bin/python",
  "torch_version": "2.12.0+cu130",
  "sklearn_version": "1.7.2",
  "tabpfn_class": "TabPFNClassifier",
  "cuda_available": false,
  "cuda_device_count": 0,
  "gpu_name": null,
  "gpu_total_memory_gb": null,
  "cuda_visible_devices": null,
  "n_train": 100,
  "n_test": 50,
  "n_features": 30,
  "accuracy": 0.96,
  "roc_auc": 0.9983579638752051,
  "fit_time_sec": 5.913421720266342,
  "predict_time_sec": 8.115943253040314,
  "total_time_sec": 14.029364973306656,
  "output_dir": "/usr/xtmp/yw676/DCC_runs/tabpfn/manual_cpu_debug"
}

