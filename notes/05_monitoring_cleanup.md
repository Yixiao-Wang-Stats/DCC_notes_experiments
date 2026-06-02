# Monitoring and Cleanup

## Purpose

## Slurm job monitoring
### squeue
```
squeue -u yw676
```
Purpose:
Check my pending or running Slurm jobs.

Use cases:
- Did my job enter the queue?
- Is it pending or running?
- Which node is it running on?
- Why is it pending?

### sacct

Purpose:
Check historical information for submitted jobs, including completed or failed jobs.

Use cases:
- Did my job complete successfully?
- How long did it run?
- Was it killed by timeout or memory?
- What was the final state?

### scontrol show job

Purpose:
Inspect detailed information of a specific Slurm job.

Use cases:
- What resources did I request?
- Which partition did I use?
- Which node was allocated?
- Why is the job pending?
- What output file path did I specify?

### scancel

Purpose:
Cancel my own Slurm job when it is wrong, unnecessary, or wasting resources.

Rule:
Before canceling, confirm the JobID belongs to me.

Job ID: 11826344
squeue observation:
   JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          11826344   compsci python_t    yw676  R       0:26      1 compsci-cluster-fitz-35
scontrol observation:
    JobId=11826344 JobName=python_test_5
    UserId=yw676(1547419) GroupId=oitusers(1000000) MCS_label=N/A
    Priority=1048 Nice=0 Account=users QOS=normal
    JobState=RUNNING Reason=None Dependency=(null)
    Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
    RunTime=00:00:13 TimeLimit=00:03:00 TimeMin=N/A
    SubmitTime=2026-06-02T02:11:19 EligibleTime=2026-06-02T02:11:19
    AccrueTime=2026-06-02T02:11:19
    StartTime=2026-06-02T02:11:19 EndTime=2026-06-02T02:14:19 Deadline=N/A
    SuspendTime=None SecsPreSuspend=0 LastSchedEval=2026-06-02T02:11:19 Scheduler=Main
    Partition=compsci AllocNode:Sid=compsci-login-03:3188365
    ReqNodeList=(null) ExcNodeList=(null)
    NodeList=compsci-cluster-fitz-35
    BatchHost=compsci-cluster-fitz-35
    NumNodes=1 NumCPUs=1 NumTasks=1 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
    ReqTRES=cpu=1,mem=2G,node=1,billing=1
    AllocTRES=cpu=1,mem=2G,node=1,billing=1
    Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
    MinCPUsNode=1 MinMemoryNode=2G MinTmpDiskNode=0
    Features=(null) DelayBoot=00:00:00
    OverSubscribe=OK Contiguous=0 Licenses=(null) LicensesAlloc=(null) Network=(null)
    Command=/home/users/yw676/projects/DCC_notes_experiments/experiments/000_test_environment/test_python_5.slurm
    SubmitLine=sbatch experiments/000_test_environment/test_python_5.slurm
    WorkDir=/home/users/yw676/projects/DCC_notes_experiments
    StdErr=
    StdIn=/dev/null
    StdOut=/home/users/yw676/projects/DCC_notes_experiments/experiments/000_test_environment/logs/python_test_5.out
    TresPerTask=cpu=1
sacct final state:
11826344     python_te+    compsci      users          1  COMPLETED      0:0 
11826344.ba+      batch                 users          1  COMPLETED      0:0 
11826344.ex+     extern                 users          1  COMPLETED      0:0 

log file:
/home/users/yw676/projects/DCC_notes_experiments/experiments/000_test_environment/logs/python_test_5.out

outputs:
Start time: 2026-06-02 02:11:20.083550
End time: 2026-06-02 02:13:20.133175


## Process monitoring

Purpose:
Check whether I have unexpected processes running on the login node.

Common suspicious processes:
- python
```
pgrep -a -u $USER python
```
- python3
- jupyter
```
pgrep -a -u $USER jupyter
```
- R
- Rscript
- node
- code-server

```
ps -u $USER -o pid,ppid,stat,etime,%cpu,%mem,cmd --sort=-%cpu

# -o: output formation

ps -u $USER -o pid,ppid,stat,etime,%cpu,%mem,cmd | grep -E 'python|python3|jupyter|Rscript|(^|/)R($| )|node|code-server|vscode' | grep -v grep  # only check suspicious processes

```

CPU
```
top -u yw676  # q:quit, P:CPU rank, M:memory rank
```



Before killing a process:
- confirm it belongs to me
- confirm it is not an active VSCode session
- confirm it is not a Slurm-managed process I still need
- record the PID and command

```
ps -p <PID> -ww -o user,pid,ppid,stat,etime,%cpu,%mem,cmd
kill <PID>
```


Rule:
Do not leave idle Jupyter kernels running, especially on login nodes.

VSCode server crash
old server remains
extension consumes CPU
remote connection unstable

## Disk usage monitoring

Purpose:
Avoid filling home/project storage with caches, model weights, logs, and temporary outputs.

High-risk directories:
- .cache
- .conda
- .local
- .venv
- outputs
- checkpoints
- wandb
- huggingface cache

```
du -sh ~

du -sh ~/.cache  # disk usage -s:summary -h:human readable
du -sh ~/.conda
du -sh ~/.local
du -sh ~/.cache/huggingface
```