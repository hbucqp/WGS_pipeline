import os
import argparse
import pandas as pd
import numpy as np


def args_parse():
    "Parse the input argument, use '-h' for help."
    parser = argparse.ArgumentParser(
        usage='resfidner_tidy.py -i <resfinder_sum_file> -o <output_file_name>')
    parser.add_argument("-i", help="<input_file>: resfinder_sum_file")
    parser.add_argument("-o", help="<output_file_path>: output_file_path")
    return parser.parse_args()


def main():
    args = args_parse()
    input_file = args.i
    # print(input_file)
    input_file = os.path.abspath(input_file)
    if not os.path.exists(args.o):
        os.mkdir(args.o)
    output_file_path = os.path.abspath(args.o)
    output_file = os.path.join(output_file_path ,'resfinder_sum.csv')
    print(output_file)
    df = pd.read_csv(input_file, sep='\t',
                     names=['Strain', 'Database', 'Resistance gene', 'Identity', 'Query / Template length', 'Contig', 'Position in contig', 'Predicted phenotype', 'Accession number'])
    df_final = df.pivot_table(index='Strain', columns=[
                              'Database', 'Resistance gene'], values='Identity', aggfunc=lambda x: ','.join(map(str, x)))
    # print(df_final)
    df_final.to_csv(output_file)


if __name__ == '__main__':
    main()
