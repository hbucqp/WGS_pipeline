#!/bin/bash

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16


export PATH=/disk1/cau/cvmcjp/anaconda3/envs/py36/bin:$PATH

# 基于resfinder的耐药基因分析

mkdir -p ./result/resfinder1395
for filename in ./seq1395/*.fasta
do
        base=$(basename $filename .fasta)
        mkdir -p ./result/resfinder1395/${base}
        python3 /disk1/cau/cvmcjp/software/resfinder/resfinder.py -i ./seq1395/${base}.fasta -p /disk1/cau/cvmcjp/database/resfinder_db -o ./result/resfinder1395/${base} -mp blastn -x -t 0.9 -l 0.6
done
