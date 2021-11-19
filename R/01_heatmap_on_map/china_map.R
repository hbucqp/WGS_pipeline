library(ggplot2)
library(sf)
library(scales)
library(dplyr)


setwd('/Users/cuiqingpo/Nutstore Files/Scripts/Python_Scripts/WGS_pipeline/R/01_heatmap_on_map')

# 1-9	#B7CDFF
# 10-19	#9DB9F1
# 20-29	#84A5E4
# 30-39	#6A91D6
# 40-49	#507DC8
# 50-59	#3769BB
# >60	#1D55AD



china <- read_sf("china_full_map.json")

heatmap_data <- read.csv('data_china.csv', header = T, sep=',')
heatmap_data$Group <- cut(heatmap_data$Value, breaks = c(0,9,19,29,39,49,59,80))
china_map_plot <- left_join(china, heatmap_data, by = c("NAME"="Name"))

ggplot() +
  geom_sf(data=china_map_plot, alpha = 0.4, aes(fill = Group), color = "gray")+ 
  geom_sf(data=subset(china_map_plot, 
                      NAME=="小地图框格"), 
          color = "gray", size = 0.5) +
  # geom_sf_text(data=china_map_plot, aes(label=Value)) + # 是否显示各省数量
  theme(legend.position = c(0.2, 0.1),
        legend.direction = "horizontal",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) + 
  guides(fill = guide_legend(title = "No. of isolates",
                             title.position = "top",
                             title.hjust = 0.3,
                             nrow = 3)) + 
  scale_fill_manual(breaks=levels(heatmap_data$Group),
                    values = c('#B7CDFF','#9DB9F1','#84A5E4', 
                               '#6A91D6', '#507DC8','#3769BB', 
                               '#1D55AD'),
                    label=c('1-9','10-19','20-29','30-39','40-49','50-59','>60')) +
  annotation_north_arrow(location = "tl", which_north = "False",
                         height = unit(1, "cm"),
                         pad_x = unit(0.5, "cm"),
                         pad_y = unit(0.65, "cm")) +
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

ggsave(file='china_map_new.pdf',width=16,height=12)

