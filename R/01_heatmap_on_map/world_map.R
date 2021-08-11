# LIBRARIES ----
library(tidyverse)
library(maps)
library(mapproj)

# 1.0 MAP DATA -----
?map_data()

setwd("/Users/cuiqingpo/Downloads/mlc_map")

# read data table
isolate_stat <- read.csv('world_map.csv', header = T, sep=',', check.names = F)


world_tbl <- map_data('world') %>% 
  left_join(isolate_stat, by=c("region"="Country")) %>% 
  as.tibble() %>% 
  mutate(Group=cut(Count, breaks = c(0,9,99,199,499,999)))
world_tbl
distinct(world_tbl, Group, .keep_all=T) %>% pull()
distinct(world_tbl, Group, .keep_all=T)
world_tbl %>% filter(!is.na(Group))


world_tbl %>% group_by(group)


world_tbl %>% 
  ggplot(aes(long, lat, group=region)) +
  geom_map(aes(map_id=region),
           map=world_tbl,
           color = "black", fill = "lightgray", size = 0.1) +
  geom_polygon(aes(group = group, fill = Group), color = "black") +
  scale_fill_manual(breaks=levels(world_tbl$Group),
                    values = c('#B7CDFF','#90AFEA','#6A91D6', 
                               '#4473C2', '#1D55AD'),
                    name='No. of isolates',
                    label=c('1-9','10-99','100-199','200-499','500-1000')) +
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
ggsave('world_map.pdf', width = 20, height = 12)
