#!/usr/bin/env python3

import argparse
import json
import os
import platform
import socket
import sys
from datetime import datetime

import numpy as np
import pandas as pd
from sklearn.datasets import load_breast_cancer
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

from gosdt import ThresholdGuessBinarizer, GOSDTClassifier


def parse_args():
    parser = argparse.ArgumentParser(description="GOSDT CPU debug experiment.")
    parser.add_argument("--output-dir", required=True, help="Directory to save outputs.")
    parser.add_argument("--seed", type=int, default=2026)
    parser.add_argument("--regularization", type=float, default=0.02)
    parser.add_argument("--depth-budget", type=int, default=3)
    parser.add_argument("--time-limit", type=int, default=60)
    parser.add_argument("--gbdt-n-estimators", type=int, default=20)
    parser.add_argument("--gbdt-max-depth", type=int, default=1)
    return parser.parse_args()


def main():
    args = parse_args()
    os.makedirs(args.output_dir, exist_ok=True)

    print("===== GOSDT BREAST CANCER DEBUG START =====", flush=True)
    print("time:", datetime.now(), flush=True)
    print("hostname:", socket.gethostname(), flush=True)
    print("platform:", platform.platform(), flush=True)
    print("python:", sys.executable, flush=True)

    data = load_breast_cancer(as_frame=True)
    X = data.data
    y = data.target

    print("raw X shape:", X.shape, flush=True)
    print("raw y shape:", y.shape, flush=True)
    print("class counts:", dict(pd.Series(y).value_counts().sort_index()), flush=True)
    
    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=0.2,
        random_state=args.seed,
        stratify=y,
    )

    print("X_train shape:", X_train.shape, flush=True)
    print("X_test shape:", X_test.shape, flush=True)

    print("Step 1: threshold guessing / binarization", flush=True)
    binarizer = ThresholdGuessBinarizer(
        n_estimators=args.gbdt_n_estimators,
        max_depth=args.gbdt_max_depth,
        random_state=args.seed,
    )
    binarizer.set_output(transform="pandas")

    X_train_bin = binarizer.fit_transform(X_train, y_train)
    X_test_bin = binarizer.transform(X_test)

    print("X_train_bin shape:", X_train_bin.shape, flush=True)
    print("X_test_bin shape:", X_test_bin.shape, flush=True)

    print("Step 2: reference model for warm labels", flush=True)
    ref_model = GradientBoostingClassifier(
        n_estimators=args.gbdt_n_estimators,
        max_depth=args.gbdt_max_depth,
        random_state=args.seed,
    )
    ref_model.fit(X_train_bin, y_train)
    y_ref = ref_model.predict(X_train_bin)

    print("Step 3: train GOSDTClassifier", flush=True)
    clf = GOSDTClassifier(
        regularization=args.regularization,
        depth_budget=args.depth_budget,
        time_limit=args.time_limit,
        similar_support=False,
        verbose=True,
    )
    clf.fit(X_train_bin, y_train, y_ref=y_ref)

    print("Step 4: evaluate", flush=True)
    train_pred = clf.predict(X_train_bin)
    test_pred = clf.predict(X_test_bin)

    train_acc = accuracy_score(y_train, train_pred)
    test_acc = accuracy_score(y_test, test_pred)

    training_time = None
    if hasattr(clf, "result_") and hasattr(clf.result_, "time"):
        training_time = clf.result_.time

    metrics = {
        "seed": args.seed,
        "regularization": args.regularization,
        "depth_budget": args.depth_budget,
        "time_limit": args.time_limit,
        "gbdt_n_estimators": args.gbdt_n_estimators,
        "gbdt_max_depth": args.gbdt_max_depth,
        "raw_n_train": int(X_train.shape[0]),
        "raw_n_test": int(X_test.shape[0]),
        "raw_n_features": int(X_train.shape[1]),
        "binarized_n_features": int(X_train_bin.shape[1]),
        "train_accuracy": float(train_acc),
        "test_accuracy": float(test_acc),
        "gosdt_training_time": training_time,
    }

    metrics_path = os.path.join(args.output_dir, "metrics.json")
    with open(metrics_path, "w") as f:
        json.dump(metrics, f, indent=2)

    tree_path = os.path.join(args.output_dir, "tree.txt")
    with open(tree_path, "w") as f:
        f.write(str(clf))

    print("metrics:", json.dumps(metrics, indent=2), flush=True)
    print("metrics saved to:", metrics_path, flush=True)
    print("tree saved to:", tree_path, flush=True)
    print("===== GOSDT BREAST CANCER DEBUG END =====", flush=True)


if __name__ == "__main__":
    main()