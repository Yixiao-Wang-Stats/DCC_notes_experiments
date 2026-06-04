# python experiments/002_tabpfn_foundation_model/scripts/compare_cpu_gpu_metrics.py \
#   --cpu-metrics /usr/xtmp/yw676/DCC_runs/tabpfn/2026-06-02_001_tabpfn_breast_cancer_cpu_debug/metrics.json \
#   --gpu-metrics /usr/xtmp/yw676/DCC_runs/tabpfn/2026-06-02_002_tabpfn_breast_cancer_gpu_debug/metrics.json \
#   --output-csv experiments/002_tabpfn_foundation_model/outputs/cpu_gpu_comparison.csv

#!/usr/bin/env python3

import argparse
import json
from pathlib import Path

import pandas as pd


def load_metrics(path):
    with open(path, "r") as f:
        return json.load(f)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cpu-metrics", required=True)
    parser.add_argument("--gpu-metrics", required=True)
    parser.add_argument("--output-csv", required=True)
    args = parser.parse_args()

    rows = []
    for label, path in [("cpu", args.cpu_metrics), ("gpu", args.gpu_metrics)]:
        m = load_metrics(path)
        rows.append({
            "run_type": label,
            "selected_device": m.get("selected_device"),
            "cuda_available": m.get("cuda_available"),
            "gpu_name": m.get("gpu_name"),
            "n_train": m.get("n_train"),
            "n_test": m.get("n_test"),
            "accuracy": m.get("accuracy"),
            "roc_auc": m.get("roc_auc"),
            "fit_time_sec": m.get("fit_time_sec"),
            "predict_time_sec": m.get("predict_time_sec"),
            "total_time_sec": m.get("total_time_sec"),
            "hostname": m.get("hostname"),
        })

    df = pd.DataFrame(rows)
    Path(args.output_csv).parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(args.output_csv, index=False)

    print(df.to_string(index=False))
    print("Saved comparison to:", args.output_csv)


if __name__ == "__main__":
    main()