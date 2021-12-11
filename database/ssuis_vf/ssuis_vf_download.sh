#!/bin/bash

#IFS='\t'

while read a b c
do
    echo ">suisvf~~~$a~~~$b~~~$c" >> vf_sequence.fa
    efetch -db protein -format fasta_cds_na -id $b | grep -v ">" >> vf_sequence.fa
done < id.txt
