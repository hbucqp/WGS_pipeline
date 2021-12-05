#!/bin/bash

#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -pe mpi 16

export PATH=/disk1/cau/cvmcjp/anaconda3/envs/py36/bin:$PATH #导入环境变量

mkdir -p ./result/kraken #设置结果输出路径，此处为脚本运行路径的result/kraken下

for filename in ./seq/*.fa  #循环读取当前路径下seq文件夹下的fa格式的文件
do
        base=$(basename $filename .fa)
        # 下行为kraken2运行代码，可根据自己需求进行修改
        kraken2 --use-names --threads 16 --db /disk1/cau/cvmcjp/database/minikraken_8GB_20200312 --report ./result/kraken/${base}.report ./seq/${base}.fa > ./result/kraken/${base}.kraken
        bracken -d /disk1/cau/cvmcjp/database/minikraken_8GB_20200312 -i ./result/kraken/${base}.report -l S -o ./result/kraken/${base}.txt
done
