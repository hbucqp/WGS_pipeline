library(ggplot2)
library(ggbreak)

data <- read.csv('depth.txt', header = F, sep='\t')
colnames(data) <- c('Ref','Pos','Depth')


p <- ggplot(data=data, aes(x=Pos, y=Depth)) +
  geom_line(color='firebrick') +
  scale_x_continuous(breaks=seq(0, 1700000, 100000)) +
  theme_minimal()
p  
p + scale_wrap(n=6)



p + scale_y_break(c(150, 8000))  
ggsave('test.pdf', height = 4, width = 20)





