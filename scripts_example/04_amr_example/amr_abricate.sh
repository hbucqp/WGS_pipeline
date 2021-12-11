#!/bin/bash

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16


export PATH=/disk1/cau/cvmcjp/miniconda3/envs/amr/bin:$PATH



# 基于abricate的耐药基因分析
mkdir -p ./result/abricate_amr
for filename in ./seq/*.fa
do
    base=$(basename $filename .fa)
    # mkdir -p ./result/vfdb/${base}
    abricate --db resfinder --minid 90 --mincov 60 ./seq/${base}.fa > ./result/abricate_amr/${base}.tab
done
