#!/bin/bash

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 8


# 拼接数据的质量控制

export PATH=/disk1/cau/cvmcjp/miniconda3/envs/py36/bin:$PATH

mkdir -p result/quast

for file in ./seq
do
    quast ./seq/*.fa -o ./result/quast
done
