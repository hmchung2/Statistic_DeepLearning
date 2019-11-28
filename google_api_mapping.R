install.packages("devtools")

devtools::install_github('dkahle/ggmap', force  = T)
library(ggmap)

register_google(key = '너의 API')   #####  구글 API 를 다운 받아야 된다.
get_map(location = '서울',          ########## 1년은 무료고 카드번호를 적어도 돈이 자동 결제 될 일은 없다
        zoom = 14,
        maptype = 'roadmap',
        source = 'google') %>% 
ggmap()


getwd()
setwd("c:/r_class")


data = read.csv('starbucks_loc_calc')   ############ 스타벅스 위도 경도 
data
nrow(data)
center <- c(mean(x = data$lng), mean(x = data$lat))
center

library(tidyverse)
#install.packages("showtext")
library(showtext)

font_add_google("Nanum Gothic", "nanumgothic")            ##############   한글이라 폰트를 바꾼다.
qmap(location = center,
     zoom = 11,
     maptype = 'roadmap',
     source = 'google') + 
  geom_point(data = data, 
             aes(x = lng,
                 y = lat), 
             shape = '▼', 
             color = 'red', 
             size = 4) + 
  geom_text(data = data,
            aes(x = lng,
                y = lat,
                label = seq(1,500)),
            color = 'black',
            hjust = 0.5,
            vjust = -1.0,
            size = 2.5,
            fontface = 'bold')

data = read.csv('bycle_locations')
data
nrow(data)
center <- c(mean(x = data$lng), mean(x = data$lat))
center
font_add_google("Nanum Gothic", "nanumgothic")
qmap(location = center,
     zoom = 11,
     maptype = 'roadmap',
     source = 'google') + 
  geom_point(data = data, 
             aes(x = lng,
                 y = lat), 
             shape = '▼', 
             color = 'red', 
             size = 4) + 
  geom_text(data = data,
            aes(x = lng,
                y = lat,
                label = rep(1,1505)),
            color = 'black',
            hjust = 0.5,
            vjust = -1.0,
            size = 2.5,
            fontface = 'bold')


