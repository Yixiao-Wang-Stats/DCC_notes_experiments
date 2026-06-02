# Configs

This folder stores lightweight experiment configuration files.

Configs describe experiment parameters, not large data or outputs.

Each formal run should have:
- a config file
- a run id
- a git commit
- a Slurm job id
- an output path
- a run record


eg:
project: dcc_test
run_type: cpu_debug
environment: dcc-basic
partition: compsci
cpus: 1
memory: 1G
time: 10 minutes
output_root: /usr/xtmp/yw676/DCC_runs/dcc_test
purpose: test reusable CPU debug Slurm template