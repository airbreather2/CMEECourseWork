#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb

module load anaconda3/personal

echo "R is about to run"

cp $HOME/sed24_HPC_2024_demographic_cluster.R $TMPDIR
cp $HOME/Demographic.R $TMPDIR

R --vanilla < $HOME/sed24_HPC_2024_demographic_cluster.R

mv output_* $HOME/results/

mv $HOME/demographic_cluster_run_script.sh.e* $HOME/errors/

mv $HOME/demographic_cluster_run_script.sh.o* $HOME/output/

echo "R has finished running"

