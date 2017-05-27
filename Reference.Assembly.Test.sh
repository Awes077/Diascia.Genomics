#! /bin/env/bash

mkdir Assembly.Test

cp -a Demultiplexed.Sequences/. Assembly.Test/

#So the first thing I need to do is create a ref.opt folder.

cp /Volumes/Diascia.Genomics/SA.Data/Practice.Run/Place.Names.txt ./Assembly.Test/Trimmed.Reads

cd Assembly.Test/Trimmed.Reads


mkdir Ref.Opt

#Now I need to figure a clever way to take five individuals from each group. Okay, small idea.
#Create a variable called groupname. In group name I cut the first section of the first file name.
#I then loop through all files, checking if the first section of the file name is the same
#as group name. If it is, move into new folder, up to five times. If it isn't, change group
#name to new first section, check subsequent files and move five, repeat. Something like that.
#hmmm. I'm not sure that's as elegant as I wanted.

#So the goal here is to have a list of the place names, loop through them,
#basically grep the file list for the directory, output the names of files containing the current 
#place name using ls -n 5.

#First we create our name list. Thinking just sort through and 



while read PLACE 
do

FILES=$(ls| grep "$PLACE" | head -n 10)

echo $FILES
cp -v $FILES Ref.Opt

cd ..

FILES2=$(ls|grep "$PLACE" | grep "F.fq.gz" | head -n 5)
FILES3=$(ls|grep "$PLACE" | grep "R.fq.gz" | head -n 5)

cp -v $FILES2 Trimmed.Reads/Ref.Opt

cp -v $FILES3 Trimmed.Reads/Ref.Opt

cd Trimmed.Reads


done<Place.Names.txt