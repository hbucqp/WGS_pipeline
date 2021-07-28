#!/bin/bash

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16


export PATH=/disk1/cau/cvmcjp/anaconda3/envs/py36/bin:$PATH

mkdir -p result/sero1395

for file in ./seq1395/*.fasta
do
	base=$(basename $file .fasta)
	/disk1/cau/cvmcjp/software/SsuisSero/SsuisSero.sh -x fasta -s ${base} -i ./seq1395/${base}.fasta -o ./result/sero1395/${base}
done
