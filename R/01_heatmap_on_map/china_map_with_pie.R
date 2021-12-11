library(ggplot2)
library(sf)
library(ggspatial)
library(scales)
library(dplyr)
library(RColorBrewer)
library(scatterpie)
library(new)
library(circlize)
library(ggnewscale)

setwd("/Users/cuiqingpo/Downloads/gxw")

# <1 #ffffff
# 1-9	#ffe3d5
# 10-19	#ffc6ac
# 20-29	#ffa985
# 30-39	#ff8b5e
# 40-49	#ff6b36
# >50	#ff4500


china <- read_sf("china_full_map.json")
china


heatmap_data <- read.csv('data_China_pie.csv', header = T, sep=',')
heatmap_data

heatmap_data$Group <- cut(heatmap_data$Value, breaks = c(0,9,19,29,39,60))
china_map_plot <- left_join(china, heatmap_data, by = c("NAME"="Name"))
group <- c("(0,9]", "(9,19]", "(19,29]", "(29,39]", "(39,60]")

cols <- colorRampPalette(brewer.pal(5, 'Reds'))
Mypal <- cols(length(unique(china_map_plot$Group)))


# read center lon and lat
center <- read.csv('china_center.csv', header = T)
pie_data <- left_join(heatmap_data, center, by=c("Name"= "NAME"))
pie_data


p <- ggplot() +
  geom_sf(data=china_map_plot, alpha = 1, aes(fill = Group ), color = "gray")+ 
  geom_sf(data=subset(china_map_plot, 
                      NAME=="China"), 
          color = "gray", size = 0.5) +
  geom_sf_text(data=china_map_plot, aes(label=Value), family = "serif") + # 
  theme(legend.position = c(0.2, 0.1),
        legend.direction = "horizontal",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) + 
  guides(fill = guide_legend(title = "No. of isolates",
                             title.position = "top",
                             title.hjust = 0.3,
                             nrow = 2)) + 
  scale_fill_manual(values=Mypal, na.value = 'white') +
  annotation_north_arrow(location = "tl", which_north = "False",
                                           height = unit(1, "cm"),
                                           pad_x = unit(0.5, "cm"),
                                           pad_y = unit(0.65, "cm")) + #ָ?
  theme(                panel.background = element_blank(),
                        axis.title.x = element_blank(),
                        axis.title.y = element_blank(),
                        axis.text = element_blank(),
                        axis.ticks = element_blank(),
                        axis.title = element_blank(),
                        legend.title = element_text(family = "serif", size=20),
                        legend.text = element_text(family = "serif", size =15)) +
  new_scale_fill()
p
p + geom_scatterpie(data=pie_data,
                  aes(x=lon,y=lat),
                  cols = colnames(pie_data)[3:4], alpha=1, color=NA) +
  geom_scatterpie_legend(pie_data$Value*1500,x = 1500000,y=1500000,n = 3,
                         labeller=function(x) x/1500) +
  scale_fill_manual(breaks=c('Diseased', 'Healthy'), values=c("#f0b500", "#006a9a"))
ggsave(file='china_map_new.pdf',width=16,height=12)
                    
                    
                    
                    
                    
                    
                    