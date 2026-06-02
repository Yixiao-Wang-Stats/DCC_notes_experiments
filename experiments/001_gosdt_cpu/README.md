# 001 GOSDT CPU Workflow

## Purpose

This project tests how to deploy and run GOSDT, a CPU-based optimal sparse decision tree method, on the Duke CS cluster.

## Learning goals

- Create a project-specific Python environment.
- Install and test the `gosdt` package.
- Run a small sklearn dataset example.
- Submit the experiment through Slurm.
- Save logs, metrics, outputs, and run records.
- Understand CPU-only experiment management.

## Storage policy

Code, configs, Slurm scripts, and run records are stored in this Git repo.

Large outputs are stored under:

/usr/xtmp/yw676/DCC_runs/gosdt_cpu

## Environment
```
python3 -m venv /usr/xtmp/yw676/envs/gosdt-cpu
```

Environment name:
gosdt-cpu

Environment location:
/usr/xtmp/yw676/envs/gosdt-cpu

outputs:(dcc-basic) yw676@compsci-login-04$ ls /usr/xtmp/yw676/envs
./  ../  gosdt-cpu/

```
source /usr/xtmp/yw676/envs/gosdt-cpu/bin/activate
```
## First target

Run a small binary classification example using sklearn's breast cancer dataset.

```
srun \
  --partition=compsci \
  --cpus-per-task=2 \
  --mem=4G \
  --time=02:00:00 \
  --pty bash
```

```
python -m pip install --upgrade pip setuptools wheel
```

outputs:yw676@compsci-cluster-fitz-35$ python --version
Python 3.10.12
yw676@compsci-cluster-fitz-35$ which python
/usr/xtmp/yw676/envs/gosdt-cpu/bin/python

```
python -m pip install numpy pandas scikit-learn matplotlib gosdt
```

```
mkdir -p /usr/xtmp/yw676/DCC_runs/gosdt_cpu/manual_debug
```

```
python experiments/001_gosdt_cpu/scripts/run_gosdt_breast_cancer_debug.py \
  --output-dir /usr/xtmp/yw676/DCC_runs/gosdt_cpu/manual_debug \
  --seed 2026 \
  --regularization 0.02 \
  --depth-budget 3 \
  --time-limit 120
```

```
ls -lah /usr/xtmp/yw676/DCC_runs/gosdt_cpu/manual_debug
```

```
yw676@compsci-cluster-fitz-35$ cat /usr/xtmp/yw676/DCC_runs/gosdt_cpu/manual_debug/metrics.json
{
  "seed": 2026,
  "regularization": 0.02,
  "depth_budget": 3,
  "time_limit": 120,
  "gbdt_n_estimators": 20,
  "gbdt_max_depth": 1,
  "raw_n_train": 455,
  "raw_n_test": 114,
  "raw_n_features": 30,
  "binarized_n_features": 9,
  "train_accuracy": 0.9494505494505494,
  "test_accuracy": 0.9385964912280702,
  "gosdt_training_time": 0.0
}
```