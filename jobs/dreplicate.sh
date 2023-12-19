#!/bin/bash
#SBATCH --job-name=dreplicate-995
#SBATCH -p short
#SBATCH --mem=100gb
#SBATCH -N 1
#SBATCH -n 33
#SBATCH -t 1-0:00:00
#SBATCH -o "logs/slurm/dereplicate/stdout.chicken.995.%j.%N"
#SBATCH -e "logs/slurm/dereplicate/stderr.chicken.995.%j.%N"
#SBATCH --mail-user=paul.villanueva@usda.gov
#SBATCH --mail-type=BEGIN,END,FAIL

cd /project/fsepru/paul.villanueva/repos/ppahs
source /home/${USER}/.bashrc
source activate drep

date
time dRep dereplicate \
    dRep_outputs_chicken_995 \
    --ignoreGenomeQuality \
    -sa 0.995 \
    -p 32 \
    -g data/genomes/chicken_genomes_with_pesi/*
date
