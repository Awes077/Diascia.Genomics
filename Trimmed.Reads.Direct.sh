#! /bin/env/bash

cd Assembly.Test

mkdir Trimmed.Reads



echo "Moving all R1 reads to Trimmed.Reads"

cp -v *R1.fq* Trimmed.Reads

echo "Moving all R2 reads to Trimmed.Reads"

cp -v *R2.fq* Trimmed.Reads