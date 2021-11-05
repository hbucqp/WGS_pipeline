#!/bin/sh

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16


#Hybrid_assembly
mkdir -p ./result ./result/nanopore_assemble
for filename in *_1.fq.gz
do
        base=$(basename $filename _1.fq.gz)
        unicycler -1 ${base}_1.fq.gz -2 ${base}_2.fq.gz -l ./nanopore/${base}_ps_nanopore.fastq.gz -o ./result/nanopore_assemble/${base} --pilon_path ~/anaconda3/envs/py36/bin/pilon --vcf --bcftools_path ~/anaconda3/envs/py36/bin/bcftools -t 16
done
