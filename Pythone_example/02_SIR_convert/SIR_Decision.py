# -*- coding=utf-8 -*-

import re
import argparse
import pandas as pd
import numpy as np


def bp_mapping(x):
    '''
    convert breakpoint SIR value to float
    "<=" : x-0.0001
    ">=" : x+0.0001
    "1~2": left=1, right=2
    '''
    x = str(x)
    if re.search(r'>=', x):
        x = x.replace('>=', '')
        x = float(x)
        x = '%.4f' % x
    elif re.search(r'>[0-9]+', x):
        x = x.replace('>', '')
        x = float(x)
        x = x + 0.0001
    elif re.search(r'<=', x):
        x = x.replace('<=', '')
        x = float(x)
        x = '%.4f' % x
    elif re.search(r'<\d+', x):
        x = x.replace('<', '')
        x = float(x)
        x = x - 0.0001
    else:
        x = x
    return x


def mic2float(x):
    '''
    convert mic value to float type
    '''
    x = str(x)
    if re.search('/', x):
        x = x.split('/')[0]
        if re.search(r'>=', x):
            x = x.replace('>=', '')
            x = float(x)
            x = '%.4f' % x
        elif re.search(r'>[0-9]+', x):
            x = x.replace('>', '')
            x = float(x)
            x = x + 0.0001
        elif re.search(r'<=', x):
            x = x.replace('<=', '')
            x = float(x)
            x = '%.4f' % x
        elif re.search(r'<\d+', x):
            x = x.replace('<', '')
            x = float(x)
            x = x - 0.0001
        else:
            x = float(x)
    else:
        if re.search(r'>=', x):
            x = x.replace('>=', '')
            x = float(x)
            x = '%.4f' % x
        elif re.search(r'>[0-9]+', x):
            x = x.replace('>', '')
            x = float(x)
            x = x + 0.0001
        elif re.search(r'<=', x):
            x = x.replace('<=', '')
            x = float(x)
            x = '%.4f' % x
        elif re.search(r'<\d+', x):
            x = x.replace('<', '')
            x = float(x)
            x = x - 0.0001
        else:
            x = float(x)
    return x


def SIR_compare(dictbp, drug, x):
    '''
    get the 'S','I','R' based on the breakpoint dict, drug, and MIC value
    '''
    y = ''
    if np.isnan(x):
        y = np.nan
    else:
        x = float(x)
        s = float(dictbp[drug]['S'])
        i = dictbp[drug]['I']
        r = float(dictbp[drug]['R'])
        if r > 0:
            if x <= s:
                y = 'S'
            elif x >= r:
                y = 'R'
            else:
                if re.search('~', str(i)):
                    left, right = i.split('~')
                    left = float(left)
                    right = float(right)
                    if left <= x <= right:
                        y = 'I'
                else:
                    i = float(i)
#                     print(i)
                    if x == i:
                        y = 'I'
        else:
            y = np.nan
    return y


# def get_version():
#     return "1.0.0"


def arg_parse():
    "parse the input parameter, use '-h' for help"
    parser = argparse.ArgumentParser(prog='SIR_Desicion.py',
                                     description='Convert MIC value to SIR')
    # epilog='test',
    # usage='SIR_Decision.py -bp <breakpoint file> -in <csv format file with MIC value> -out <output with SIR>')
    parser.add_argument("-bp",
                        help="<breakpoint file>: breakpoint file")
    parser.add_argument("-input", type=argparse.FileType('r'),
                        help="<inputfile>: csv format file with MIC value, note the '< = >' symbols should be English symbols")
    parser.add_argument("-out",
                        help="<output Excel file with concatenate SIR value>: outfile with SIR")
    parser.add_argument('-v', '--version', action='version',
                        version='%(prog)s 1.0.0', help='<Display version>')
    return parser.parse_args()


def main():
    args = arg_parse()

    breakpoint_file = args.bp
    input_file = args.input
    output_file = args.out

    # read breakpoint csv file
    df_bp = pd.read_csv(breakpoint_file, sep='\t', index_col='Drug')

    # convert breakpoint value to float value
    df_bp['R'] = df_bp['R'].apply(bp_mapping)
    df_bp['I'] = df_bp['I'].apply(bp_mapping)
    df_bp['S'] = df_bp['S'].apply(bp_mapping)

    # create breakpoint dict
    dict_bp = df_bp.to_dict(orient='index')
    # print(dict_bp)

    # read mic table
    df_mic = pd.read_csv(input_file)
    columns_list = df_mic.columns.to_list()

    # get common element from mic dataframe and breakpoint dict keys
    drug_list = []
    for i in columns_list:
        if i in dict_bp.keys():
            drug_list.append(i)
    # print(drug_list)

    for drug in drug_list:
        # print(drug)
        drug_sircol = str(drug) + '_SIR'
        print(f'Converting {drug} SIR ...')
        df_mic[drug_sircol] = df_mic[drug].apply(mic2float).map(
            lambda x: SIR_compare(dict_bp, drug, float(x)))

    df_mic.to_excel(output_file, index=False)


if __name__ == '__main__':
    main()
