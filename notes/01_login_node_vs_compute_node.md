## Step 1.1 Identity check
```
whoami
```

Purpose:
Confirm that I am operating under my Duke CS account.

Observation:
My current user is: yw676

Conclusion:
I am now operating on the Duke CS cluster as user yw676.

## Step 1.2 Host check

```
hostname #
nvidia-smi
```

Purpose:
Determine whether I am on a login node or a compute node.

Observation:
Current hostname: compsci-login-03

Interpretation:
If the hostname is login/login.cs.duke.edu, I should only edit files, submit jobs, monitor jobs, and transfer files here.

Conclusion:
I should not run heavy Python, training, GPU inference, or long experiments directly here.

## Step 1.3 Working directory check

Purpose:
Know where my cluster learning project is stored.

Observation:
Current working directory: /home/users/yw676/projects/DCC_notes_experiments

Interpretation:
This directory is used for notes, scripts, templates, and experiment records.
It should not store large datasets, model checkpoints, or heavy outputs.

Conclusion:
This repository is my control center, not my large data warehouse.

## Step 1.4 Git status check

Purpose:
Confirm that this project is version-controlled.

Observation:
Git branch: master
Remote repository: origin  https://github.com/Yixiao-Wang-Stats/DCC_notes_experiments.git (fetch)
origin  https://github.com/Yixiao-Wang-Stats/DCC_notes_experiments.git (push)
Uncommitted changes: yes (as I add notes but have not commit)

Conclusion:
This repo will track notes, scripts, configs, and templates, but not large data or outputs.



DCC_notes_experiments is my control center for learning Duke CS cluster usage, Slurm workflow, environment management, and reproducible experiments.