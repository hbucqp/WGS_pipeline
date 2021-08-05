import pandas as pd

chrom = ['chrom1', 'chr2', 'chr3', 'chromX']

chr = pd.Series(chrom, index=[0, 1, 2, 3])

test = chr.str.replace(r'^.*([\d+|X|Y|M])', r"chr\1", regex=True)
print(test)
