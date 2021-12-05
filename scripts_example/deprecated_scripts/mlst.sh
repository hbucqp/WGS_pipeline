#!/bin/bash


#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16

export PATH=/disk1/cau/cvmcjp/anaconda3/envs/py36/bin:$PATH

mkdir -p /disk1/cau/cvmmlc/allseq/result/mlst1395 #/disk1/cau/cvmmlc/allseq/result/mlst1395为结果输出路径
for filename in /disk1/cau/cvmmlc/allseq/seq1395/*.fasta #fasta文件所在路径
do
        mlst $filename >> /disk1/cau/cvmmlc/allseq/result/mlst1395/mlst_sum1395.txt
done
