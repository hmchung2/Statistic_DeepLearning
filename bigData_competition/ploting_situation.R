cut = c("둑섬유원지역 1번출구 앞","여의나루역 1번출구 앞",
        "홍대입구2번출구 앞","고속터미널역8-1번,8-2번 출구사이",
        "봉림교 교통섬", "롯데월드타원(잠실역 2번 출구 쪽)",
        "마포구민체육센터 앞","건대입구역 사거리(롯데백화점)",
        "안암로터리 버스정류장 앞", "CJ드림시티")

봄 = c(32738,29821,22513,19645,19071,18579,15697,15001,14499) 
여름 = c()

library(readxl)
library(tidyverse)
library(dplyr)
library(readr)
setwd( "C:/r_project")

full_data = read.csv('full_data.csv')
full_data %>% head()
str(full_data)

bike2018raw = read.csv('bike2018.csv')
bike2018 = bike2018raw[,-1]
str(bike2018)

bike2017 = read.csv('bike2017.csv', header = F)
names(bike2017) = names(bike2018)
################################2017 정리
str(bike2017)
bike2017$대여일자 = as.character(bike2017$대여일자)
bike2017$대여시간 =as.character(bike2017$대여시간)
bike2017$대여소번호 = as.character(bike2017$대여소번호)
bike2017$대여소명 = as.character(bike2017$대여소명)
bike2017$대여구분코드 =as.character(bike2017$대여구분코드)
bike2017$성별 = as.character(bike2017$성별)
bike2017$연령대코드 = as.character(bike2017$연령대코드)

bike2017$대여일자 = gsub("\'", "", bike2017$대여일자)
bike2017$대여시간 =gsub("\'", "",bike2017$대여시간)
bike2017$대여소번호 = gsub("\'", "",bike2017$대여소번호)
bike2017$대여소명 = gsub("\'", "",bike2017$대여소명)
bike2017$대여구분코드 =gsub("\'", "",bike2017$대여구분코드)
bike2017$성별 = gsub("\'", "",bike2017$성별)
bike2017$연령대코드 = gsub("\'", "",bike2017$연령대코드)

############################### 2018 정리
str(bike2018)
bike2018$대여일자 = as.character(bike2018$대여일자)
bike2018$대여시간 = as.character(bike2018$대여시간)
bike2018$대여소번호 = as.character(bike2018$대여소번호)
bike2018$대여소명 = as.character(bike2018$대여소명)
bike2018$대여구분코드 = as.character(bike2018$대여구분코드)
bike2018$성별 = as.character(bike2018$성별)
bike2018$연령대코드 = as.character(bike2018$연령대코드)

bike2018 = rbind(bike2017,bike2018)

bike2018 = bike2018 %>% group_by(대여일자,대여시간,대여소번호) %>% summarise(이용건수 = sum(이용건수))


library(lubridate)




########################################
bike2018$mon =  substring(bike2018$대여일자, 6, 7) %>% as.numeric()
str(bike2018)



breaks  = as.Date(c("2018-01-01","2018-02-01","2018-05-01","2018-08-01","2018-11-01","2019-12-01"))
breaks = month(breaks)

labels <- c("겨울", "봄", "여름", "가을","겨울")


bike2018$season <- cut(x= bike2018$mon, breaks = breaks, labels = labels, include.lowest=T)

bike2018$대여시간 = as.numeric(bike2018$대여시간)

bike2018 %>% head()

vis_data = bike2018 %>% group_by(대여시간,season) %>% summarise(count = sum(이용건수))

###############################vis_data$대여시간 = as.factor(vis_data$대여시간)

ggplot(data = vis_data, aes(x = 대여시간, y = count, fill = season)) + # adding bar plot
  geom_bar(stat="identity", position = position_dodge())+   # changing of y axis
  theme(axis.text = element_text(colour = "black", size = 15),  # some theme options
        axis.title.y = element_text(size = 15))  +
  xlab("") + ylab("이용건수") +geom_line(aes(y = count, x = 대여시간, colour = season), size=1.5,
           data = vis_data, stat="identity")

bike2018 %>% head()


cor.test(vis_data$count,vis_data$대여시간)
oneway.test(count ~ 대여시간, data = vis_data)
model = aov(count~대여시간, data = vis_data)
summary(model)

bike2018_test = bike2018
str(bike2018_test)
bike2018_test$대여시간 = as.factor(bike2018_test$대여시간)
head(bike2018_test)
bike2018_test =  bike2018_test %>% group_by(대여시간,대여소번호) %>% summarise(이용건수 = sum(이용건수))

str(bike2018_test)
head(bike2018_test)
model_all = aov(이용건수~대여시간, data = bike2018_test)
summary(model_all)




#######################################   두번째 그래프 및 테스트

bike2018_test$대여시간 %>% table() %>% sum()


bike2018$date = as.Date(bike2018$대여일자)

bike2018$week = weekdays(bike2018$date)
vis_data2 = bike2018 %>% group_by(week,season) %>% summarise(count = sum(이용건수))

  
vis_data2
str(vis_data2)



vis_data2$week=  factor(vis_data2$week,  levels = c("월요일","화요일","수요일","목요일","금요일","토요일","일요일") )
levels(vis_data2$week)
ggplot(data = vis_data2, aes(x = week, y = count, fill = season)) + # adding bar plot
  geom_bar(stat="identity", position = position_dodge())+
# changing of y axis
theme(axis.text = element_text(colour = "black", size = 15),  # some theme options
      axis.title.y = element_text(size = 15))  


names(bike2018)

oneway.test(count ~ week, data = vis_data2)
kruskal.test(count ~ week, data = vis_data2)
model2 = aov(count~week, data = vis_data2)
summary(model2)

bike2018$week = as.factor(bike2018$week)
head(bike2018)
bike2018_week = bike2018
bike2018_week$week = as.factor(bike2018_week$week)
bike2018_week = bike2018 %>% group_by(대여소번호,week) %>% summarise(이용건수 = sum(이용건수))
head(bike2018_week)
bike2018_week = bike2018_week[-c(1,2),]
model3 = aov(이용건수~week, data = bike2018_week)
summary(model3)
bike2018 %>% names()
ok = aggregate(bike2018_week[,3], list(bike2018_week$week), mean)
ok
aggregate(bike2018_week[,3], list(bike2018_week$week), sd)
table(bike2018_week$week)

zzz = ((1487-1)*(687.9339^2) + (1482-1)*(647.9982^2))/(1487+1482-2)
106.1536 / sqrt(zzz)

sd(ok$이용건수)
sd(ok2$이용건수)

head(bike2018)
ok$이용건수 %>% max()

ok$이용건수 %>% min()
ok$이용건수 %>% max() - ok$이용건수 %>% min()
str(bike2018_test)
bike2018_test
ok2 = aggregate(bike2018_test[,3], list(bike2018_test$대여시간), mean)

ok2
ok2$이용건수 %>% max()
ok2$이용건수 %>% min()
ok2$이용건수 %>% max() - ok2$이용건수 %>% min()
aggregate(bike2018_test[,3], list(bike2018_test$대여시간), sd)
table(bike2018_test$대여시간)
#18 and 5

zz = ((1478-1)*(538.80182^2) + (1371-1) *(44.45709^2)) / (1478 +1371 - 2 )
sqrt(zz)
458.0374 / sqrt(zz)


bike2018$이용건수 %>% mean()


summary(model_all)

LM <- lm(이용건수 ~ week, data=bike2018)
summary(LM)

LM2 <- lm(이용건수 ~ 대여시간 , data = bike2018_test)
summary(LM2)

LM3 <- lm(count~week, data = vis_data2)
summary(LM3)

vis_data_test = vis_data
vis_data_test$대여시간 = factor(vis_data_test$대여시간,levels = c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0,1,2,3,4))
LM4 <-lm(count ~ 대여시간, data = vis_data_test)
summary(LM4)







head(bike2018)
str(bike2018)
str(bike2018_test)


bike2018$season = as.factor(bike2018$season)
bike2018_season = bike2018 %>% group_by(season,대여소번호) %>% summarise(이용건수 = sum(이용건수))
model_season = aov(이용건수 ~ season, data = bike2018_season)
summary(model_season)

bike2018_season


ok3 = aggregate(bike2018_season[,3], list(bike2018_season$season), mean)
aggregate(bike2018_season[,3], list(bike2018_season$season), sd)
ok3$이용건수 %>% max()
ok3$이용건수 %>% min()
ok3
bike2018_season$season %>% table()
2144.5670 - 497.2184


zzzzz = ((1284-1)*(1636.1754^2) + (1053-1)*(417.4338^2)) / (1053 +1284 - 2)




ok3$이용건수 %>% max() - ok3$이용건수 %>% min()

1647.349/ sqrt(zzzzz)

