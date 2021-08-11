library(ggplot2)
library(sf)
library(scales)
library(dplyr)
library(ggimage)

setwd('/Users/cuiqingpo/Downloads/mlc_map')

# 1-9	#B7CDFF
# 10-19	#9DB9F1
# 20-29	#84A5E4
# 30-39	#6A91D6
# 40-49	#507DC8
# 50-59	#3769BB
# >60	#1D55AD


load(file = "map_province.Rdata")

heatmap_data <- read.csv('data_china.csv', header = T, sep=',')
heatmap_data$Group <- cut(heatmap_data$Value, breaks = c(0,9,19,29,39,49,59,80))
china_map_plot <- left_join(china_map_province, heatmap_data, by = c("NAME"="Name"))

ggplot() +
  geom_sf(data=china_map_plot, alpha = 0.4, aes(fill = Group), color = "gray")+  # ????
  geom_image(data = data.frame(x =2296959, y =3004574), aes(x = x, y = y), image = "islands1.png", size =0.1)+
  # geom_label2(aes(label='PINYIN_NAM')) +
  # scale_fill_distiller(palette = "GnBu", direction = 1)+
  # scale_fill_gradient(name=paste0(drug, ' Prevalence(%)'), low='yellow',high='brown', limits=c(0, 100), labels=percent(0.25*0:3, accuracy = 0.01)) +
  # scale_fill_gradientn(breaks = seq(1, 80), values = c(1, 80), colors=c('#B7CDFF','#9DB9F1','#84A5E4', '#6A91D6', '#507DC8','#3769BB','#1D55AD')) +
  scale_fill_manual(breaks=levels(heatmap_data$Group),
                    values = c('#B7CDFF','#9DB9F1','#84A5E4', 
                               '#6A91D6', '#507DC8','#3769BB', 
                               '#1D55AD'),
                    name='No. of isolates',
                    label=c('1-9','10-19','20-29','30-39','40-49','50-59','>60')) +
  geom_text(data=china_map_plot, aes(label = Group))+
  theme(
    panel.background = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    legend.title = element_text(size=20),
    legend.text = element_text(size =15)
  )




