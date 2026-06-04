#!/usr/bin/env python3

import argparse
import json
import os
from pathlib import Path

import pandas as pd


def parse_args():
    parser = argparse.ArgumentParser(description="Summarize GOSDT sweep metrics.")
    parser.add_argument("--sweep-dir", required=True, help="Directory containing task_* subdirectories.")
    parser.add_argument("--output-csv", required=True, help="Path to save summary CSV.")
    return parser.parse_args()


def main():
    args = parse_args()

    sweep_dir = Path(args.sweep_dir)
    rows = []

    for task_dir in sorted(sweep_dir.glob("task_*")):
        metrics_path = task_dir / "metrics.json"
        if not metrics_path.exists():
            print(f"Skipping {task_dir}: no metrics.json")
            continue

        with open(metrics_path, "r") as f:
            metrics = json.load(f)

        row = dict(metrics)
        row["task_dir"] = str(task_dir)
        rows.append(row)

    if not rows:
        raise RuntimeError(f"No metrics found under {sweep_dir}")

    df = pd.DataFrame(rows)

    sort_cols = ["test_accuracy", "train_accuracy"]
    df = df.sort_values(sort_cols, ascending=False)

    os.makedirs(os.path.dirname(args.output_csv), exist_ok=True)
    df.to_csv(args.output_csv, index=False)

    print("===== SWEEP SUMMARY =====")
    print(df[[
        "regularization",
        "depth_budget",
        "binarized_n_features",
        "train_accuracy",
        "test_accuracy",
        "gosdt_training_time",
        "task_dir",
    ]])
    print()
    print("Saved summary to:", args.output_csv)


if __name__ == "__main__":
    main()