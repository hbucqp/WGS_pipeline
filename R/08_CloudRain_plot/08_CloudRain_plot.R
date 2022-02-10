library(ggplot2)
library(ggridges)
library(RColorBrewer)
library(ggpubr)
library(rstatix)
library(gghalves)
# source("/Users/cuiqingpo/NutstoreCloudBridge/Scripts/R/half_flat_violinplot.R")



####################################读取数据#####################################
data <- read.csv('耐药基因数量.csv', header = T, check.names = F)
serotype_order <- c("1|2","1", "2","3","4","5","6","7","8","9","10","11","12","14","15","16","17","18","19","21","23","24","25", "28","29","30","31",'nt' )
data$Serotype <- factor(data$Serotype, levels = rev(serotype_order))



####################################过滤数据#####################################
data1 <- data %>% filter( !Serotype %in% c('6', '17', "23", '25', '28'))




##################################ggplot2画图####################################
ggplot(data1, aes(y=Serotype, x=number, fill=factor(as.integer(Serotype) %% 2))) +
  geom_density_ridges(quantile_lines=TRUE, quantile_fun=function(x,...)mean(x), scale=1.2,
                      position = position_nudge(x=0.5, y=0)) + #画平均值指示线
  scale_fill_manual(values = c('0' = '#B7CDFF', '1' = '#84A5E4'), guide=F) +
  scale_x_continuous(breaks=seq(from = 0, to =20, by =2)) +
  labs(x="Number of ARGs", y='') +
  theme_bw() +
  theme(axis.text.y = element_text( face = 'italic', size=15),
        axis.text = element_text(size = 15),
        axis.title.x = element_text(size=20),
        plot.margin = unit(c(1,1,0,0), "cm"),
  )

ggsave('ridges.pdf', width = 10, height = 16)


