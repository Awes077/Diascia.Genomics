#! /bin/env/bash

mkdir Assembly.Test

cd Demultiplexed.Sequences

cp *fq.gz /data/dops-ngs-pipeline/dops0687/ARC.Transfer/Assembly.Test

cd ..
cd Assembly.Test

mv /data/dops-ngs-pipeline/dops0687/ARC.Transfer/Diascia.Genomics/Trim.Only.txt /data/dops-ngs-pipeline/dops0687/ARC.Transfer/Assembly.Test

dDocent < Trim.Only.txt

cd ..

