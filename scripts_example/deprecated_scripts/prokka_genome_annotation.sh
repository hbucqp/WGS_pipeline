#!/bin/bash

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16

export PATH=/disk1/cau/cvmcjp/anaconda3/envs/py36/bin:$PATH

# prokka基因功能注释

mkdir -p ./result/prokka335 #./result/prokka335为结果输出路径
for filename in ./seq335/*.fasta #./seq335/*.fasta为拼接后的fasta文件所在路径
do
          base=$(basename $filename .fasta)
          prokka --kingdom Bacteria --genus Streptococcussuis --prefix ${base} --locustag ${base} --outdir result/prokka335/${base} seq335/${base}.fasta
done




