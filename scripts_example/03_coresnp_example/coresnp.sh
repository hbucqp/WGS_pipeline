#!/bin/bash


#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16

export PATH=/disk1/cau/cvmcjp/miniconda3/envs/coresnp/bin/:$PATH

# parsnp运行脚本，可根据实际需求更改
# -g为genbank格式的参考基因组，-o为结果输出路径
parsnp -p 16 -mmd 1 -g /disk1/cau/cvmmlc/allseq/SC84.gb -d /disk1/cau/cvmmlc/allseq/seq123 -o tree123
