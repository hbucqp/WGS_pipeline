import os
import argparse
from Bio import SeqIO


def args_parse():
    "Parse the input argument, use '-h' for help."
    parser = argparse.ArgumentParser(
        usage='checkfasta.py - i < fasta_file >')
    parser.add_argument("-i", help="<input_fasta_file>: test.fa")
    return parser.parse_args()


def is_fasta(filename):
    with open(filename, "r") as handle:
        fasta = SeqIO.parse(handle, "fasta")
        # False when `fasta` is empty, i.e. wasn't a FASTA file
        return any(fasta)


def main():
    args = args_parse()
    input_file = args.i
    input_file = os.path.abspath(input_file)
    result = is_fasta(input_file)
    print(input_file + '\t' + str(result))


if __name__ == '__main__':
    main()
