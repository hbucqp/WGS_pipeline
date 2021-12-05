#!/bin/bash

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16


export PATH=/disk1/cau/cvmcjp/miniconda3/envs/amr/bin:$PATH

# 基于resfinder的耐药基因分析


# 点突变支持Species
# Available species:
# Campylobacter,
# Campylobacter jejuni,
# Campylobacter coli,
# Enterococcus faecalis,
# Enterococcus faecium,
# Escherichia coli,
# Helicobacter pylori,
# Klebsiella,
# Mycobacterium tuberculosis,
# Neisseria gonorrhoeae,
# Plasmodium falciparum,
# Salmonella,
# Salmonella enterica,
# Staphylococcus aureus
# -s "Other" can be used for metagenomic samples or samples with unknown species.


# 拼接数据查找耐药基因
mkdir -p ./result/resfinder
for filename in ./seq/*.fa
do
        base=$(basename $filename .fa)
        mkdir -p ./result/resfinder/${base}
        python3 /disk1/cau/cvmcjp/software/resfinder/run_resfinder.py -db_res /disk1/cau/cvmcjp/database/resfinder_db -s Other \
        --point -db_point /disk1/cau/cvmcjp/database/pointfinder_db \
        -o ./result/resfinder/${base} -l 0.6 -t 0.9 \
        --acquired -ifa ./seq/${base}.fa
        # Deprecated
        # python3 /disk1/cau/cvmcjp/software/resfinder/resfinder.py -i ./seq1395/${base}.fasta -p /disk1/cau/cvmcjp/database/resfinder_db -o
        # ./result/resfinder1395/${base} -mp blastn -x -t 0.9 -l 0.6
done


# 原始数据查找耐药基因
# 以原始数据（A_1.fq.gz,A_2.fq.gz）格式的数据说明，如果后缀不对，请自行修改后缀名称

mkdir -p ./result/resfinder
for filename in ./fq/*_1.fq.gz
do
        base=$(basename $filename _1.fq.gz)
        mkdir -p ./result/resfinder/${base}
        python3 /disk1/cau/cvmcjp/software/resfinder/run_resfinder.py -db_res /disk1/cau/cvmcjp/database/resfinder_db -s Salmonella \
        --point -db_point /disk1/cau/cvmcjp/database/pointfinder_db \
        -o ./result/resfinder/${base} -l 0.6 -t 0.9 \
        --acquired -if1 ./fq/${base}_1.fq.gz ./fq/${base}_2.fq.gz
        # Deprecated
        # python3 /disk1/cau/cvmcjp/software/resfinder/resfinder.py -i ./seq1395/${base}.fasta -p /disk1/cau/cvmcjp/database/resfinder_db -o
        # ./result/resfinder1395/${base} -mp blastn -x -t 0.9 -l 0.6
done


