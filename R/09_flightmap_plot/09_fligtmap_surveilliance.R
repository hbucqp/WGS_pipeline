###########所有的哨点医院绘制地图#############
# 输入：                                       #
#      链接数据库获取所有启用的医院            #
#      用baidumap获取所有医院的IP              #
# 输出：                                       #
#     地图                                     #
################################################




library(baidumap)
options(baidumap.key = 'YOURKEY') # 需替换为自己的KEY
options(remap.ak = "YOURAK") # 需替换为自己的AK
library(REmap)
library(tidyverse)



####################航线图#####################
BN.CDC <- read.csv("2021-接入用户.csv", header = T)
BN.CDC

colnames(BN.CDC)[1:2] <- c("province", "CDC")

BN.CDC <- BN.CDC %>%
  mutate(CDC = gsub("CDC", "", CDC),
         CDC = gsub("升级", "", CDC))

BN.CDC$origin <- if_else(BN.CDC$province == BN.CDC$CDC, "北京市", BN.CDC$province)
BN.CDC$destination <- BN.CDC$CDC
dat <- BN.CDC %>% select( 'destination', 'origin')
dat1 <- dat %>% mutate(destination = gsub("国家食品安全风险评估中心", '北京市', destination)) %>% 
  filter(origin != destination)
dat1$destination <- fun.abbre.varia(dat1$destination)
dat1$origin <- fun.abbre.varia(dat1$origin)


##########################整理各个省份数量############################
fun.abbre.varia <- function(df){
  df <- gsub("[省市]", "", df )
  df <- gsub("自治区", "", df )
  df <- gsub("维吾尔", "", df )
  df <- gsub("回族", "", df )
  df <- gsub("壮族", "", df )
  df <- gsub("生产建设兵团", "兵团", df )
  return (df)
}

BN.CDC$province <- fun.abbre.varia(BN.CDC$province)
BN.CDC$province[BN.CDC$province == '国家食品安全风险评估中心'] = '北京'
BN.CDC$province[BN.CDC$province == '新疆建设兵团'] = '新疆'

data <- BN.CDC %>%
  group_by(province) %>%
  summarise(count = n_distinct(CDC))




remap(dat1,title = "TraNet监测点",subtitle = "theme:Bright",
      theme = get_theme(theme = "Dark",backgroundColor= NA, 
                        titleColor= "#848487",labelShow = F,borderColor = "grey",
                        regionColor = NA))

remapC(as.data.frame(data),
       markLineData = dat1,
       title = 'TraNet监测点分布',
       theme = get_theme(theme = "none",
                         backgroundColor= "white", titleColor= "black"),
       # markLineTheme =  markLineControl(effect = F, color = "grey", symbolSize = c(1,1.5)),
       markPointTheme = markPointControl(effect = FALSE,
                                         symbolSize = 0.3,
                                         effectType = "pink"))





