install.packages("devtools")

devtools::install_github('dkahle/ggmap', force  = T)
library(ggmap)

register_google(key = '너의 API')
get_map(location = '서울',
        zoom = 14,
        maptype = 'roadmap',
        source = 'google') %>% 
ggmap()


getwd()
setwd("c:/r_class")


data = read.csv('starbucks_loc_calc')
data
nrow(data)
center <- c(mean(x = data$lng), mean(x = data$lat))
center

library(tidyverse)
#install.packages("showtext")
library(showtext)

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


