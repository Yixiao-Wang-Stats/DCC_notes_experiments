#!/usr/bin/env python3

import argparse
import json
import os
import platform
import socket
import sys
import time
from datetime import datetime

import numpy as np
import pandas as pd
import sklearn
import torch
from sklearn.datasets import load_breast_cancer
from sklearn.metrics import accuracy_score, roc_auc_score
from sklearn.model_selection import train_test_split

from tabpfn import TabPFNClassifier


def parse_args():
    parser = argparse.ArgumentParser(description="TabPFN CPU/GPU debug benchmark.")
    parser.add_argument("--output-dir", required=True)
    parser.add_argument("--device", choices=["cpu", "cuda", "auto"], default="auto")
    parser.add_argument("--seed", type=int, default=2026)
    parser.add_argument("--max-train-samples", type=int, default=300)
    parser.add_argument("--max-test-samples", type=int, default=100)
    return parser.parse_args()


def choose_device(requested_device: str) -> str:
    if requested_device == "auto":
        return "cuda" if torch.cuda.is_available() else "cpu"

    if requested_device == "cuda" and not torch.cuda.is_available():
        raise RuntimeError("Requested device=cuda, but torch.cuda.is_available() is False.")

    return requested_device


def get_gpu_info():
    if not torch.cuda.is_available():
        return {
            "cuda_available": False,
            "cuda_device_count": 0,
            "gpu_name": None,
            "cuda_visible_devices": os.environ.get("CUDA_VISIBLE_DEVICES"),
        }

    device_index = 0
    props = torch.cuda.get_device_properties(device_index)
    return {
        "cuda_available": True,
        "cuda_device_count": torch.cuda.device_count(),
        "gpu_name": torch.cuda.get_device_name(device_index),
        "gpu_total_memory_gb": props.total_memory / (1024 ** 3),
        "cuda_visible_devices": os.environ.get("CUDA_VISIBLE_DEVICES"),
    }


def subset_data(X_train, X_test, y_train, y_test, max_train, max_test, seed):
    rng = np.random.default_rng(seed)

    if len(X_train) > max_train:
        train_idx = rng.choice(len(X_train), size=max_train, replace=False)
        X_train = X_train.iloc[train_idx]
        y_train = y_train.iloc[train_idx]

    if len(X_test) > max_test:
        test_idx = rng.choice(len(X_test), size=max_test, replace=False)
        X_test = X_test.iloc[test_idx]
        y_test = y_test.iloc[test_idx]

    return X_train, X_test, y_train, y_test


def main():
    args = parse_args()
    os.makedirs(args.output_dir, exist_ok=True)

    device = choose_device(args.device)
    gpu_info = get_gpu_info()

    print("===== TABPFN BREAST CANCER RUN START =====", flush=True)
    print("time:", datetime.now(), flush=True)
    print("hostname:", socket.gethostname(), flush=True)
    print("platform:", platform.platform(), flush=True)
    print("python:", sys.executable, flush=True)
    print("requested_device:", args.device, flush=True)
    print("selected_device:", device, flush=True)
    print("torch:", torch.__version__, flush=True)
    print("torch cuda available:", torch.cuda.is_available(), flush=True)
    print("gpu_info:", json.dumps(gpu_info, indent=2), flush=True)

    data = load_breast_cancer(as_frame=True)
    X = data.data
    y = pd.Series(data.target)

    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=0.2,
        random_state=args.seed,
        stratify=y,
    )

    # X_train, X_test, y_train, y_test = subset_data(
    #     X_train,
    #     X_test,
    #     y_train,
    #     y_test,
    #     args.max_train_samples,
    #     args.max_test_samples,
    #     args.seed,
    # )

    print("X_train shape:", X_train.shape, flush=True)
    print("X_test shape:", X_test.shape, flush=True)

    t0 = time.perf_counter()

    clf = TabPFNClassifier(device=device)
    clf.fit(X_train, y_train)

    fit_end = time.perf_counter()

    pred = clf.predict(X_test)

    proba = None
    auc = None
    try:
        proba = clf.predict_proba(X_test)[:, 1]
        auc = roc_auc_score(y_test, proba)
    except Exception as exc:
        print("predict_proba failed:", repr(exc), flush=True)

    end = time.perf_counter()

    acc = accuracy_score(y_test, pred)

    metrics = {
        "seed": args.seed,
        "requested_device": args.device,
        "selected_device": device,
        "hostname": socket.gethostname(),
        "python": sys.executable,
        "torch_version": torch.__version__,
        "sklearn_version": sklearn.__version__,
        "tabpfn_class": "TabPFNClassifier",
        "cuda_available": gpu_info["cuda_available"],
        "cuda_device_count": gpu_info["cuda_device_count"],
        "gpu_name": gpu_info.get("gpu_name"),
        "gpu_total_memory_gb": gpu_info.get("gpu_total_memory_gb"),
        "cuda_visible_devices": gpu_info.get("cuda_visible_devices"),
        "n_train": int(X_train.shape[0]),
        "n_test": int(X_test.shape[0]),
        "n_features": int(X_train.shape[1]),
        "accuracy": float(acc),
        "roc_auc": None if auc is None else float(auc),
        "fit_time_sec": float(fit_end - t0),
        "predict_time_sec": float(end - fit_end),
        "total_time_sec": float(end - t0),
        "output_dir": args.output_dir,
    }

    metrics_path = os.path.join(args.output_dir, "metrics.json")
    with open(metrics_path, "w") as f:
        json.dump(metrics, f, indent=2)

    preds_path = os.path.join(args.output_dir, "predictions.csv")
    pred_df = pd.DataFrame({
        "y_true": np.asarray(y_test),
        "y_pred": np.asarray(pred),
    })
    if proba is not None:
        pred_df["proba_1"] = proba
    pred_df.to_csv(preds_path, index=False)

    print("metrics:", json.dumps(metrics, indent=2), flush=True)
    print("metrics saved to:", metrics_path, flush=True)
    print("predictions saved to:", preds_path, flush=True)
    print("===== TABPFN BREAST CANCER RUN END =====", flush=True)


if __name__ == "__main__":
    main()