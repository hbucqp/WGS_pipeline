library(ggplot2)
library(ape)
library(ggtree)
library(tidytree)


set.seed(2017)
tree <- rtree(4)
tree
ggtree(tree) +
  geom_tiplab() +
  geom_text2(aes(subset=!isTip, label=node))

