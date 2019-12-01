install.packages("devtools")
devtools::install_github('dkahle/ggmap', force  = T)
library(ggmap)
library(dplyr)
library(tidyverse)

register_google(key = '구글 오픈 API를 여기에 적으면 된다')   #####  구글 API 를 다운 받아야 된다.
         ########## 1년은 무료고 카드번호를 적어도 돈이 자동 결제 될 일은 없다
  



data = read.csv('starbucks_loc_calc.csv')   ############ 스타벅스 위도 경도 
nrow(data)
center <- c(mean(x = data$lng), mean(x = data$lat))  ######## 지도의 중간지점을 계산한다
center

library(showtext)                               # 패키지 설치

font_add_google("Nanum Gothic", "nanumgothic")            ##############   한글이라 폰트를 바꾼다.


qmap(location = center,
     zoom = 11,
     maptype = 'roadmap',
     source = 'google') + 
  geom_point(data = data, 
             aes(x = lng,               #######서울에 있는 모든 스타벅스 위치를 시각화 한다
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


######################### 이번에는 서울시 공공자전거 대여소 위치를 파악 해보자
data = read.csv('bycle_locations.csv')

nrow(data)               ############# 1505 개의 대여소가 존재한다
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
             shape = '▼',         #원하는 모양이랑 원하는 색상 옵션을 여기에 쓰면 된다
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


