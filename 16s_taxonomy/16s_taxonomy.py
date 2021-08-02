#!/usr/bin/python

import re
import os
import pandas as pd
import numpy as np
import subprocess
import argparse


def arg_parse():
    "parse the input parameter, use '-h' for help"
    parser = argparse.ArgumentParser(
        usage='16s_taxonomy.py -input <fasta file> -outdir <output>')
    parser.add_argument("-i", help="<fasta file>: 16s assemble fasta file")
    parser.add_argument("-db", help="<database>: 16s blast database")
    parser.add_argument("-o", help="<blast output directory>: 16s blast file")
    parser.add_argument(
        "-t", type=int, help="<treads>: number of threads", default=4)
    return parser.parse_args()


def blast_16s(seq, db, out, threads):
    seq_prefix = os.path.splitext(os.path.basename(seq))[0]
    # print(seq_prefix)
    out = os.path.abspath(out)
    output_file = os.path.join(out, str(seq_prefix + '_blast.txt'))
    # print(output_file)
    command = f'blastn -query {seq} -num_threads {threads} -db {db} -outfmt "6 qseqid salltitles pident qlen length mismatch gapope evalue bitscore" -max_target_seqs 5'
    print(command)
    # command = f'blastn -query {seq} -db {db} -outfmt 5 -max_target_seqs 1'
    # command = f'blastn -query {seq} -db {db} -max_target_seqs 1'
    with open(output_file, 'w') as output:
        subprocess.run(command, shell=True, stdout=output)


def result_concat(out):
    df_final = pd.DataFrame()
    files = os.listdir(out)
    for file in files:
        df_tmp = pd.read_csv(file, sep='\t', names=[
                             'qseqid', 'salltitles', 'pident', 'qlen', 'length', 'mismatch', 'gapope', 'evalue', 'bitscore'])
        df_final = pd.concat([df_final, df_tmp], axis=0)
    return df_final


def main():
    args = arg_parse()
    seq = os.path.abspath(args.i)
    threads = args.t
    print(threads)
    try:
        f = open(seq, 'r')
        f.close
    except IOError:
        print('File is not accessble')
    db = args.db
    out = os.path.abspath(args.o)
    if not os.path.exists(out):
        os.mkdir(out)
    blast_16s(seq, db, out, threads)


if __name__ == '__main__':
    main()
