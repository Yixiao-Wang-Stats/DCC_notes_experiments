## Standard Slurm script structure

1. Interpreter
2. SBATCH resource request
3. Safety settings
4. Job metadata printing
5. Environment activation
6. Run directory setup
7. Main command
8. Output validation

slurm:
login node
    ↓
Slurm Scheduler
    ↓
compute node
    ↓
train.slurm

sh:
login node
    ↓
train.slurm