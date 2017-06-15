#!/bin/bash

# set the number of nodes
#SBATCH --nodes=1

#set the amount of memory
#SBATCH --mem=250000

# set max wallclock time
#SBATCH --time=100:00:00

# set name of job
#SBATCH --job-name=FilterRun1

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=awes077@gmail.com

# run the application
cd /data/dops-ngs-pipeline/dops0687/ARC.Transfer/Assembly.Test/
module load python/anaconda3
source activate ddocent_env
bash dDocent_filters Final.recode.vcf Filter.Script.Test
