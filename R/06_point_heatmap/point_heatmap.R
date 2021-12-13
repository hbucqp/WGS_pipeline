library(ggtree)
library(ggtreeExtra)
library(ggplot2)
library(ggnewscale)
library(reshape2)
library(dplyr)
library(tidytree)
library(ggstar)
library(TDbook)
library(RColorBrewer)


# set work directory
setwd('/Users/cuiqingpo/Downloads/ytt')


# read point heatmap data
point <- read.csv('MOB_ggstar.csv')
point

# convert sample to factors
order <- c('aminoglycoside', 'beta-lactam', 'bleomycin', 'chloramphenicol',
           'colistin', 'macrolide-lincosamide-streptogramin', 'quinolone',
           'rifamycin', 'sulfonamide', 'tetracycline', 'trimethoprim',
           'IncA/C2', 'IncFII', 'IncHI2', 'IncHI2A', 'IncI2', 'IncN', 'IncX4',
           'MOBF', 'MOBH', 'MOBPB', 'MOBV', 'MPFF', 'MPFG', 'MPFT')
point$sample <- factor(point$sample, levels = order)


# read tree file
tree <- read.tree('my_plasmid_core_tree.newick')

# set colors
cols <- colorRampPalette(brewer.pal(3, 'Paired'))
mypal <- cols(length(unique(point$group)))


# create tree 
p <- ggtree(tree) +
  new_scale_fill()


star1_layer <- geom_fruit(
  data=point,
  geom=geom_star,
  mapping=aes(y=id, x=sample, fill=subgroup),
  size = 3,
  starstroke=0,
  starshape = 15,
  offset=0.04,
  pwidth=1,
  axis.params = list(axis="x", text.size=1, vjust=1, line.size=0, text.angle=-90, hjust=0)
) 
star2_layer <- geom_fruit(
    data=point,
    geom=geom_star,
    mapping=aes(x=sample, y=id, color=group),
    size = 3,
    starshape=15,
    offset=0.04,
    pwidth=1
  )


linecolor <- scale_color_manual(values= mypal)
fillcolor <- scale_fill_manual(values= mypal, na.translate = FALSE)

all_layer <- geom_fruit_list(star2_layer, star1_layer, linecolor, fillcolor)

p + all_layer +
  theme(plot.margin = unit(c(0,0,2,1), 'cm'))
