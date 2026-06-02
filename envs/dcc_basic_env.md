# DCC Basic Python Environment

## Purpose

This environment is used for basic cluster-learning tests and small CPU experiments.

## Location

/home/users/yw676/envs/dcc-basic
```
mkdir -p /home/users/yw676/envs
python3 -m venv /home/users/yw676/envs/dcc-basic

source /home/users/yw676/envs/dcc-basic/bin/activate

python -m pip install --upgrade pip
```

(dcc-basic) yw676@compsci-login-04$ which python
/home/users/yw676/envs/dcc-basic/bin/python

## Python version

Python 3.10.12

## Creation method

venv

python3 -m venv /home/users/yw676/envs/dcc-basic

## Main packages
```
pip install numpy pandas matplotlib scikit-learn
```
- numpy
- pandas
- matplotlib
- scikit-learn

## Activation test

which python:
/home/users/yw676/envs/dcc-basic/bin/python

python version:
Python 3.10.12

## Package test

numpy: 2.2.6
pandas: 2.3.3
sklearn: 1.7.2
matplotlib: 3.10.9

## Slurm test

Job ID:
11826418

Succeeded:
yes 

```
Job ID: 11826418
Node: compsci-cluster-fitz-35
Start time: Tue Jun  2 04:04:26 AM EDT 2026
/home/users/yw676/envs/dcc-basic/bin/python
Python 3.10.12
Python executable: /home/users/yw676/envs/dcc-basic/bin/python
Python version: 3.10.12 (main, Mar  3 2026, 11:56:32) [GCC 11.4.0]
Node: compsci-cluster-fitz-35
numpy: 2.2.6
pandas: 2.3.3
sklearn: 1.7.2
matplotlib: 3.10.9
Basic calculation: 3.0
Environment test succeeded.
End time: Tue Jun  2 04:04:28 AM EDT 2026
Succeeded: yes
```
## Notes

This environment is lightweight and should not contain heavy deep learning packages.