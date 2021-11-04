library(ggtree)
library(ape)
library(tidyverse)

tree <- read.tree(text = "((t2:0.04,t1:0.34):0.89,(t5:0.37,(t4:0.03,t3:0.67):0.9):0.59);")
tree

p <- ggtree(tree) +
  geom_tree() + 
  theme_tree2() +
  scale_x_continuous(labels = abs) +
  geom_tiplab(size=3, fontface='italic')


revts(p)
