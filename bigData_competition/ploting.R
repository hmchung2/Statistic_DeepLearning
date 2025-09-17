getwd()

library(readxl)
getwd()
setwd("c:/r_project/merge_folder")
relocation <- read_excel("relocation.xlsx")
dim(relocation)
names(relocation)
relocation$stationId
data2018_use %>% names()


data2018_use %>% group_by(대여소명) %>% summarise(distance = sum(이동거리),
              time = sum(이용시간),age = max(연령대코드), 
              use_count = sum(이용건수))






data2018_use = read.csv('data2018.csv')
##########################################################3
the_data = data2018_use %>% group_by(대여소번호) %>% summarise(distance = sum(이동거리),time = sum(이동시간),
                                              age = names(which.max(table(연령대코드))), use_count = sum(이용건수),
                                              female = sum(table(성별)['F']),
                                              male= sum(table(성별)['M']))

the_data
names(data2018_use)
kk = data2018_use %>% group_by(대여소번호,대여시간) %>% summarise(count = sum(이용건수))
kk %>% head(15)
kkk = kk %>% spread(대여시간,count)
kkk[is.na(kkk)] <- 0
kkk[1,] %>% sum()
kkk[,-1]
library(factoextra)

fit <- eclust(x =kkk[,-1], FUNcluster = 'kmeans', k = 4, hc_metric = 'euclidean', seed = 1234)

grouped_loc = cbind(kkk, cluster =  fit$cluster) 

grouped_loc[grouped_loc$cluster == 4,]


vip = grouped_loc[grouped_loc$cluster == 4, 1]
names(vip)[1] = 'id'
tid = all_station_location[,c(1,5,6)]
tid
vip

vip2 = merge(vip,tid, by = 'id')
library(devtools)
install_github('qkdrk777777/geocode')
library(geocode)
install.packages('RSelenium')
library(RSelenium)
a=geocode(name=c('경주시사정동','경주시노서동','대구','daegu','대구'),plot=F,n=3)




55
##################################333
relocation

names(data2018_use)

names(which.max(table(연령대코드)))


data2018_use$이동시간 %>% is.na() %>% table()

relocation

library(lubridate)
relocation$hour <- hour(relocation$시간)
relocation %>% group_by()
names(relocation)

hour(relocation$시간)
re <- relocation

repair2$정비날짜_월 <- month(repair2$정비날짜)
repair2$정비날짜_일 <- day(repair2$정비날짜)

repair3 <- repair2 %>% group_by(자전거번호, 정비날짜_년, 정비날짜_월, 정비날짜_일) %>% summarise(count = n ())



names(station_gu)
names(relocation)[7] = 'id'
names(relocation)
names(station_gu)
dim(station_gu)
station_gu %>% names()

str(relocation)
relocation$id
all_id_location %>% str()
relocation %>% dim()
relocation$id =  str_remove(relocation$id, '(=?\\S\\T\\-)') %>% as.numeric()
station_gu$gu = as.character(station_gu$gu)
relocation_added = merge(relocation,station_gu[,c(1,3)], by = 'id')
relocation_added

relocation_added2 <- relocation_added[,c(2,3,9)]
relocation_added2$gu = as.factor(relocation_added2$gu)
p <- ggplot(data = relocation_added2, aes(x = 시간, y = 자전거주차총건수)) + 
geom_line(color = gu)

relocation_added %>% str()
#############
#gather(key = "variable", value = "value", -date)
df <- relocation_added %>%
  select(시간, psavert, uempmed) %>%
  gather(key = "variable", value = "value", -date)
head(df, 3)



p <- ggplot(data = relocation3, aes(x = 시간, y = average))+geom_line(color = gu) 
p
relocation_added2 %>% str()
ggplot(relocation_added2)+geom_line(aes(x=시간, y=자전거주차총건수, colour=gu))
relocation_added2

relocation_added2 %>% dim()
relocation_added2$gu %>% table()
economics
df <- economics %>%
  select(date, psavert, uempmed) %>%
  gather(key = "variable", value = "value", -date)
head(df, 3)

economics %>%
  select(date, psavert, uempmed) %>%
  gather(key = "variable", value = "value", -date) %>% dim()

economics %>% dim()

ggplot(df, aes(x = date, y = value)) + 
  geom_line(aes(color = variable), size = 1)
df$variable %>% table()
str(df)
str(relocation_added2)
relocation_added2$gu = as.character(relocation_added2$gu)


ggplot(relocation_added2, aes(x = 시간, y = 자전거주차총건수)) + 
  geom_line(aes(color = gu), size = 1)

ok = relocation_added2[relocation_added2$gu == '마포구',]

table(ok$시간)

setwd("c:/r_project/merge_folder/bike")
library(rjson)
filenames <- list.files("c:/r_project/merge_folder/bike", pattern="*.json", full.names=TRUE) # this should give you a character vector, with each file name represented by an entry
myJSON <- lapply(filenames, function(x) fromJSON(file=x))


fromJSON(filenames[1])
library(dplyr)
filenames[2] %>% fromJSON()


filenames %>% length()

df = data.frame()
rbind(df,filenames[2] %>% fromJSON())

for(i in 1:1847){
  df = rbind(df,filenames[i] %>% fromJSON())
}

df %>% dim()

names(df)
setwd("c:/r_project/merge_folder")
getwd()
5+5
write.csv(df,'livedata.csv')

df %>% str()
as.Date(df$timestamp)

df$timestamp = strptime(df$timestamp, format="%Y-%m-%d_%H-%M")

str(df)
library(readxl)
location = read_xlsx('all_station_location.xlsx')
location %>% names()
location2 = location[,c(1,7)]
location2 %>% str()

library(tidyverse)
df$stationId =  str_remove(df$stationId, '(=?\\S\\T\\-)') %>% as.numeric()
str(df)
names(df)[7] = 'id'
names(location2)[1] = 'id'

df2 = merge(df,location2, by = 'id')
df2 %>% head()

str(df2)
df2$timestamp =  as.POSIXct(df2$timestamp)
df2$rackTotCnt = as.integer(df2$rackTotCnt)
library(lubridate)
df2$Hour =  hour(df2$timestamp)
df2 %>% str()
df3 = df2[df2$구 == '마포구',]
df3 %>% head()
#df3 = df3 %>% group_by(구,Hour) %>% summarise(count = mean(rackTotCnt))
df3$id %>% table() %>% length()
df3
ggplot(df3, aes(x = timestamp, y =parkingBikeTotCnt)) + 
  geom_line(aes(color = id), size = 1)

df3$count %>% table()

getwd()
setwd("c:/r_project/")
day_time = read.csv("data2018.csv")

library(readxl)
all_station_location <- read_excel("C:/r_project/merge_folder/all_station_location.xlsx")
names(all_station_location)[1] = 'id'
names(day_time)[4] =  'id'
day_time2 = merge(day_time,all_station_location[,c(1,7)], by = 'id')
#day_time2 %>% group_by(구,)
day_time2$대여일자  = as.Date(day_time2$대여일자)
vis1 = day_time2 %>% group_by(구,대여일자) %>% summarise(count = mean(이용건수))

p <- ggplot(data = vis1, aes(x = 대여일자, y = count))+geom_line(aes(color = 구), size = 1)
p + ggtitle('2018년 일일 자전거 이용건수') +ylab('구별 이용건수')+xlab('날짜 (월)')+theme(
  plot.title = element_text(color="red", size=14, face="bold.italic"),
  axis.title.x = element_text(color="blue", size=14, face="bold"),
  axis.title.y = element_text(color="#993333", size=14, face="bold")
)

names(day_time2)
vis2 = day_time2 %>% group_by(구,대여시간) %>% summarise(count = mean(이용건수))
vis2

p2 <- ggplot(data = vis2, aes(x = 대여시간, y = count))+geom_line(aes(color = 구), size = 1)
p2 + ggtitle('2018년 실시간 평균 자전거 이용건수') +ylab('평균 이용건수')+theme(
  plot.title = element_text(color="red", size=14, face="bold.italic"),
  axis.title.x = element_text(color="blue", size=14, face="bold"),
  axis.title.y = element_text(color="#993333", size=14, face="bold")
)


# main title
p + theme(plot.title = element_text(family, face, colour, size))
# x axis title 
p + theme(axis.title.x = element_text(family, face, colour, size))
# y axis title
p + theme(axis.title.y = element_text(family, face, colour, size))


# Default plot
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) + geom_boxplot() +
  ggtitle("Plot of length \n by dose") +
  xlab("Dose (mg)") + ylab("Teeth length")
p
# Change the color, the size and the face of
# the main title, x and y axis labels
p + theme(
  plot.title = element_text(color="red", size=14, face="bold.italic"),
  axis.title.x = element_text(color="blue", size=14, face="bold"),
  axis.title.y = element_text(color="#993333", size=14, face="bold")
)


getwd()
setwd("c:/r_project/")
full <- read.csv("full_data.csv")

names(full)
full %>% group_by(borrowing_s_name,returning_s_name) %>% summarise(count = n()) ->df2

df2$count %>% table() -> wow

full %>% dim()
#df2[order(-df2$count),]

a = df2$borrowing_s_name != df2$returning_s_name

str(df2)
df2$borrowing_s_name= as.character(df2$borrowing_s_name)
df2$returning_s_name = as.character(df2$returning_s_name)


df3  = df2[a,]
df3[order(-df3$count),] %>% head(20)


df2[order(-df2$count),] %>% head(20)


df2[df2$borrowing_s_name=='대방역6번출구',] -> df5
df5[order(-df5$count),] %>% head(20)


