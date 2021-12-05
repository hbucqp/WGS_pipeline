#!/bin/bash

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 8

export PATH=/disk1/cau/cvmcjp/miniconda3/envs/cfsan_snp/bin:$PATH
export PATH=/disk1/cau/cvmcjp/.local/bin:$PATH
export PATH=/disk1/cau/cvmcjp/software/bowtie2-2.3.4.1-linux-x86_64:$PATH

export CLASSPATH=~/software/varscan.v2.3.9/VarScan.jar:$CLASSPATH
export CLASSPATH=~/miniconda3/pkgs/picard-2.18.4-py36_0/share/picard-2.18.4-0/picard.jar:$CLASSPATH
export CLASSPATH=~/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar:$CLASSPATH


cfsan_snp_pipeline run -m soft -o /disk1/cau/cvmcjp/data/20211115_cau_wy/mcr1/snp_out -s /disk1/cau/cvmcjp/data/20211115_cau_wy/mcr1/samples /disk1/cau/cvmcjp/data/20211115_cau_wy/mcr1/ref.fa
