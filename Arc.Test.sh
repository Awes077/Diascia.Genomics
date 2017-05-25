#!/bin/bash

# set the number of nodes
#SBATCH --nodes=1

# set max wallclock time
#SBATCH --time=10:00:00

# set name of job
#SBATCH --job-name=testDemultiplexRefMapOpt

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=awes077@gmail.com

# run the application
cd ARC.Transfer
bash Sort.And.Demultiplex.Pooled.FQGZ.Files.sh
bash Trimmed.Reads.Direct.sh

bash RefOpt.sh
bash RefMapOpt.sh