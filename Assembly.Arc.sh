#!/bin/bash

# set the number of nodes
#SBATCH --nodes=1

# set max wallclock time
#SBATCH --time=100:00:00

# set name of job
#SBATCH --job-name=AssemblyRefOptTest

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=awes077@gmail.com

# run the application
cd /data/dops-ngs-pipeline/dops0687/ARC.Transfer/
module load python/anaconda3
source activate ddocent_env
#bash Reference.Assembly.Test.Remote.sh
cd /data/dops-ngs-pipeline/dops0687/ARC.Transfer/Assembly.Test/Trimmed.Reads/Ref.Opt
#bash ReferenceOpt.sh 4 8 4 8 PE 8
bash RefMapOpt.sh 4 8 4 8 0.9 8 PE

