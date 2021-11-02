## load libraries
library(dplyr)
library(networkD3)
library(tidyr)




data <- read.csv("/home/cui/data/Sankey/原始数据汇总.csv")
data
node.order <- read.csv("/home/cui/data/Sankey/nodes.csv")


data1 <- data %>% group_by(geo_loc_name, Host.Source,) %>% summarise(count=n())
data1

data2 <- data %>% group_by(Host.Source, Seroype) %>% summarise(count=n())
data2


data1 <- data1 %>% rename(A = geo_loc_name, B=Host.Source)
data2 <- data2 %>% rename(A = Host.Source, B=Seroype)
data1
data2

links <- rbind(data1, data2)
nodes <- data.frame(name=c(as.character(links$A), as.character(links$B)) %>% unique())
nodes


links$IDA <- match(links$A, nodes$name) - 1
links$IDB <- match(links$B, nodes$name) - 1
links

links$IDA <- match(links$A, node.order$name) - 1
links$IDB <- match(links$B, node.order$name) - 1
links

nodes$group <- 1:42
sankeyNetwork(Links = links, Nodes = node.order,
              Source = "IDA", Target = "IDB",
              Value = "count", NodeID = "name", LinkGroup = "A", units = 2,
              sinksRight=T, iterations = 0)
