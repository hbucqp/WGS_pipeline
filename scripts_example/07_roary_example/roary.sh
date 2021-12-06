#!/bin/bash


#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 8

export PATH=/disk1/cau/cvmcjp/miniconda3/envs/py36/bin:$PATH

# roary pangenome analysis example code

roary -e --mafft -p 8 *.gff
query_pan_genome -a difference -i  17SC5B93.gff, 17SD1B21.gff -t 17SC4B13.gff, 17SC4B14.gff
