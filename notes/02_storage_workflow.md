# Storage Workflow

## Purpose

## Storage types
| Storage | Path example | Use for | Do not use for | Backup? | Auto cleanup? |
|---|---|---|---|---|---|
| Home | /home/users/yw676 | code, notes, configs | large data, cache, checkpoints | likely protected | quota-limited |
| Git repo | /home/users/yw676/projects/DCC_notes_experiments | notes, templates, small scripts | large outputs/data/cache | via GitHub for tracked files | no |
| xtmp | /usr/xtmp/yw676 | temporary large files, intermediate outputs | unique important results | no | yes, old files removed |
| Local disk | /var/tmp/yw676 or /var/tmp/local/yw676 | job-local scratch, fast IO | anything important | no | yes/no depending path |
| Project space | /usr/project/... | group data, important shared results | uncontrolled temp junk | need confirm | need confirm |
## Home directory

## Project space

## xtmp temporary storage

## Local disk on compute nodes

## What goes to GitHub
### Tabpfn
Code/config:
home Git repo

Model cache:
xtmp or project scratch

Input datasets:
project or xtmp

Temporary outputs:
xtmp

Final result summaries:
repo + project

Large prediction files:
xtmp/project, not GitHub

### ZEUS

Code:
home repo

HuggingFace / model cache:
xtmp or project scratch

Generated images:
xtmp during experiments

Selected final figures:
project/home repo if small

Videos:
project/xtmp, not GitHub

Checkpoints:
project or xtmp depending importance

Temporary latents:
local disk or xtmp, delete after use
## What should not go to GitHub

## Workflow for experiments

ls -ld /usr/xtmp
/usr/xtmp/yw676/model_cache
    put 
        HF_HOME
        TRANSFORMERS_CACHE
        TORCH_HOME

mkdir -p /usr/xtmp/yw676

mkdir -p /usr/xtmp/yw676/datasets

mkdir -p /usr/xtmp/yw676/model_cache

mkdir -p /usr/xtmp/yw676/DCC_runs

## My storage plan

Code and notes:
/home/users/yw676/projects/DCC_notes_experiments

Large temporary runs:
/usr/xtmp/yw676/DCC_runs

Large temporary datasets:
/usr/xtmp/yw676/datasets

Large model cache:
/usr/xtmp/yw676/model_cache

Job-local scratch:
/var/tmp/yw676/$SLURM_JOB_ID

Final selected results:
TBD project space + GitHub summary
## summary
A. check the size of repo
```
du -sh .
```
Repo size: 316K    .

B. mkdir xtmp
xtmp root exists:
yes

Created directories:
- DCC_runs
- datasets
- model_cache
see:yw676@compsci-login-04$ ls -ha /usr/xtmp/yw676/
./  ../  datasets/  DCC_runs/  model_cache/

C. see interactive job in local disk

Compute node: compsci-cluster-fitz-35
```
df -h /var/tmp
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p2  3.5T   39G  3.3T   2% /

Local scratch path:
/var/tmp/yw676/test_scratch

Created small test file:
yes 

Removed local scratch:
yes 

full code:
```
yw676@compsci-login-04$ srun \
  --partition=compsci \
  --cpus-per-task=1 \
  --mem=1G \
  --time=10:00 \
  --pty bash
yw676@compsci-cluster-fitz-35$ hostname
compsci-cluster-fitz-35
yw676@compsci-cluster-fitz-35$ df -h /var/tmp
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p2  3.5T   39G  3.3T   2% /
yw676@compsci-cluster-fitz-35$ mkdir -p /var/tmp/yw676/test_scratch
yw676@compsci-cluster-fitz-35$ echo "hello cluster" > /var/tmp/yw676/test_scratch/test.txt
yw676@compsci-cluster-fitz-35$ ls -lah /var/tmp/yw676/test_scratch
total 12K
drwxr-xr-x 2 yw676 oitusers 4.0K Jun  2 03:48 ./
drwxr-xr-x 3 yw676 oitusers 4.0K Jun  2 03:48 ../
-rw-r--r-- 1 yw676 oitusers   14 Jun  2 03:48 test.txt
yw676@compsci-cluster-fitz-35$ cat /var/tmp/yw676/test_scratch/test.txt
hello cluster
yw676@compsci-cluster-fitz-35$ rm -rf /var/tmp/yw676/test_scratch
yw676@compsci-cluster-fitz-35$ ls -lah /var/tmp/yw676
total 8.0K
drwxr-xr-x 2 yw676 oitusers 4.0K Jun  2 03:49 ./
drwxrwxrwt 9 root  root     4.0K Jun  2 03:48 ../
```
## My storage policy

1. I keep code, notes, Slurm templates, and configs in GitHub.
2. I do not put large datasets, model weights, caches, checkpoints, or large outputs in GitHub.
3. I use home for lightweight, important, human-readable project files.
4. I use xtmp for large temporary data and intermediate experiment outputs.
5. I use local disk on compute nodes for high-IO temporary scratch files during a job.
6. I copy important final results back to project/home/local backup.
7. I record all large output paths in README or run_info files.
8. I clean temporary files after experiments.