# CPU Debug Slurm Template

## Purpose

Use this template for small CPU debugging jobs.

## When to use

- test Python environment
- test imports
- test paths
- run tiny scripts
- check whether code works on compute nodes

## When not to use

- long experiments
- GPU jobs
- large data processing
- final paper experiments

## Default resources

Partition:
compsci

CPUs:
1

Memory:
1G or 2G

Time:
5 to 10 minutes

GPU:
none

## Standard sections

1. SBATCH resource request
2. job metadata printing
3. environment activation
4. run directory creation
5. main test command
6. output validation

## Required log information

- Job ID
- hostname
- working directory
- start time
- Python executable
- Python version
- package versions
- output path
- end time