# CPU Batch Slurm Template

## Purpose

Use this template for formal CPU experiments.

## Example use cases

- GODST experiments
- scikit-learn experiments
- CPU simulations
- preprocessing jobs
- cross-validation jobs

## Default resources

Partition:
compsci or appropriate research partition

CPUs:
start small, then increase only if needed

Memory:
estimate from data size

Time:
based on debug run

GPU:
none

## Required experiment metadata

Every run should record:

- project name
- run id
- git commit
- command
- config file
- dataset path
- output path
- Slurm job ID   
- partition
- node
- CPU count
- memory request
- start time
- end time
- final status

## Output policy

Small summaries:
may be saved in Git repo

Large outputs:
save to xtmp or project space

Final selected results:
copy to stable storage and record path


run_id:
YYYY-MM-DD_project_task_resource_shortname

log:
logs/<run_id>_%j.out
logs/<run_id>_%j.err

output path:
/usr/xtmp/yw676/DCC_runs/<project>/<run_id>/