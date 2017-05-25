##! /bin/env/bash
#
#
##This script will:
##	1) sort the gzipped raw data into separate folders based on pool, 
##	2)create barcode files from the Diascia.Full.Barcodes.No.Blanks.Heads.txt (no blank lines and no headers) file, which will list
##  the individuals for that pool and the barcodes associated with them
##	3) calls process_radtags from the package STACKS which will demultiplex each pool and sort each individual's 
##  sequences into separate files
##	4) Move these files into a final folder, Demultiplexed.Sequences. For now, ALL INTERMEDIARY FILES CREATED
##  WILL BE KEPT. This is to help make sure all steps are working properly. If you don't wont extra copies of files
##  your computer, simply remove the # from before each rm line included here in the script.
##	5) Rename created fq.gz and rem.fq.gz files for processing using dDocent, which requires 
#   PopIdentifier_IndividualIdentifier.R1.fq.gz and PopIdentifier_IndividualIdentifier.R2.fq.gz
#   format for each paired read.
#
#
##creates our final folder, for demultiplexed sequences
#
mkdir Demultiplexed.Sequences

#Create directory for rem.fq.gz files cuz they're a goddamn hassle to manage otherwise

mkdir Rem.FQGZ
#
##So first step, create our 13 pool folders.
#
##okay so what if i first create my list of file names, subset those into applicable file names, then cp files with those names. 
##lets try
#
for i in {1..13}
do


echo $i


mkdir Pool.$i


echo "Copying:"
ls /Volumes/Diascia.Genomics/SA.Data/16651_pool$i_S*.gz | grep "pool$i\_"
echo "into directory Pool.$i"
#ls /Volumes/Diascia.Genomics/SA.Data/16651_pool$i_S*.gz | grep "pool$i\_" > Pool.$i.Files.txt

#cp -v $(<Pool.$i.Files.txt) Pool.$i

#ls ./Pool.$i
#
##So this cuts the barcodes and sample names out of our text file, based on the pool, and moves them into new
##files in the new folders we just created. 
#

awk -v i=$i -F '\t'  'BEGIN {RS= "\r"} $5==i {print $6 FS $2}' Diascia.Full.Barcodes.No.Blanks.Heads.txt > ./Pool.$i/Pool.$i.Barcodes.txt
#


cd Pool.$i
#

process_radtags -1 16651_pool$i_S*L006*R1_001.fastq.gz -2 16651_pool$i_S*R2_001.fastq.gz -b Pool.$i.Barcodes.txt -e ecoRI --renz_2 mspI -r -i gzfastq
#


process_radtags -1 16651_pool$i_S*L007*R1_001.fastq.gz -2 16651_pool$i_S*L007*R2_001.fastq.gz -b Pool.$i.Barcodes.txt -e ecoRI --renz_2 mspI -r -i gzfastq
#


mv *.rem.1.fq.gz /Volumes/Diascia.Genomics/SA.Data/Practice.Run/Rem.FQGZ



for i in *1.fq.gz
do

mv -- "$i" "${i/%1.fq.gz/F.fq.gz}"
mv -- "$i" "${i//^[A-G][1-12]}"

done

for i in *2.fq.gz
do

mv -- "$i" "${i/%2.fq.gz/R.fq.gz}"
mv -- "$i" "${i//^[A-G][1-12]}"

done


echo "Copying all newly created demultiplexed fq.gz and rem.fq.gz files into Demultiplexed.Sequences directory"
cp *.fq.gz /Volumes/Diascia.Genomics/SA.Data/Practice.Run/Demultiplexed.Sequences
#
cd ..
#
done
#


cd Demultiplexed.Sequences


#Renaming our sequence files for dDocent, making the 1's and 2's into F's and R's, and trying
#to cut the leading well identifications off.

for i in *1.fq.gz
do

mv -- "$i" "${i/%1.fq.gz/F.fq.gz}"
mv -- "$i" "${i//^[A-G][1-12]}"

done

for i in *2.fq.gz
do

mv -- "$i" "${i/%2.fq.gz/R.fq.gz}"
mv -- "$i" "${i//^[A-G][1-12]}"

done


for i in *.fq.gz
do


mv -v "$i" "${i##[A-Z][1-9]_}" 2>/dev/null;


mv -v "$i" "${i##[A-Z][1-9][0-9]_}" 2>/dev/null;



done


for i in Z-*.fq.gz
do

mv -v "$i" "${i##Z-}" 2>/dev/null;

done