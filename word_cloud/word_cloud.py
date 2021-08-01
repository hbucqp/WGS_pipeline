from wordcloud import WordCloud as wc
from PIL import Image
from collections import Counter
import matplotlib.pyplot as plt
import numpy as np


word_list = []
with open('word.txt', mode='r', encoding='utf-8') as f:  # 打开文件
    for line in f.readlines():      # 将文件存储到变量content
        line = line.strip()
        print(line)
        word_list.append(line)

word_could_dict = Counter(word_list)
print(word_could_dict)
mk = np.array(Image.open('worldmap.png'))  # 将图片转换为数组
# word_cloud = wc(font_path='hwkt.ttf', repeat=True, max_font_size=100, mask=mk, width=1600, height=800,  # repeat=True:对文本进行循环，#colormap:词云图字体颜色，
#                 background_color='white', colormap='GnBu', contour_width=1, contour_color='lightcoral')  # contour_width:词云图轮廓宽度，contour_color：词云图轮廓颜色

word_cloud = wc(width=1600, height=800, mask=mk, background_color='white',
                contour_width=1, contour_color='lightcoral', repeat=True)
word_cloud.generate_from_frequencies(word_could_dict)  # 根据文本生成词云图
# fig, ax = plt.subplots(1, 1, figsize=(30, 20))
plt.figure(figsize=(20, 10))
plt.imshow(word_cloud)
plt.axis('off')
plt.tight_layout(pad=0)
# ax.spines['top'].set_visible(False)
# ax.spines['right'].set_visible(False)
# ax.spines['left'].set_visible(False)
# ax.spines['bottom'].set_visible(False)
# plt.show()
plt.savefig('wordcloud.pdf', bbox_inches='tight')
