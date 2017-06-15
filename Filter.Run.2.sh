#!/bin/bash

# set the number of nodes
#SBATCH --nodes=1

#set the amount of memory
#SBATCH --mem=250000

# set max wallclock time
#SBATCH --time=100:00:00

# set name of job
#SBATCH --job-name=FilterRun2-HWE

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=awes077@gmail.com

# run the application
cd /data/dops-ngs-pipeline/dops0687/ARC.Transfer/Assembly.Test/
module load python/anaconda3
module load perl
source activate ddocent_env
vcfallelicprimitives Filter.Test.Script.FIL.recode.vcf --keep-info --keep-geno > Filter.Test.prim.vcf
vcftools --vcf Filter.Test.prim.vcf --remove-indels --recode --recode-INFO-all --out SNP.Filter.Test
filter_hwe_by_pop.pl -v SNP.Filter.Test.recode.vcf -p popmap -o SNP.Filter.Test.HWE -h 0.001 
