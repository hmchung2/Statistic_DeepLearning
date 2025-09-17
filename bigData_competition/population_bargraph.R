setwd("c:/r_project")

df <- read.csv("C:/r_project/bike2018.csv", header=T)

df %>% dim()
names(df)


library(ggplot2)
library(readr)
report <- read_delim("C:/r_project/report.txt", 
                            "\t", escape_double = FALSE, trim_ws = TRUE)


dim(report)
names(report)

demo = report[-c(1,2,3),]
demo = demo[demo$구분=="계",]
head(demo)
write.csv(demo,'population_by_age.csv')
report$행정구역별
dim(demo)
head(demo)
report$계
p <-ggplot(demo, aes(행정구역별,demo$`20~24세`))
p
p +geom_bar(stat = "identity")









replaceCommas<-function(x){
  x<-as.numeric(gsub("\\,", "", x))
}
a  = demo[,5:25]
a
ncol(a)
data = c()
for(i in 1:nrow(a)){
  for(j in 1:ncol(a)){
data = c(data,replaceCommas(a[i,j]))      
  }
}
data
dim(demo)
dim(a)
as.numeric(data)

mydata2 = data.frame(place = rep(demo$행정구역별,1, each = ncol(a)),values = data)


types = rep(colnames(a),25)
types
d <-ggplot(mydata2, aes(x = reorder(place,-values), y = values))
d  <- d + geom_bar(stat = "identity", aes(fill = types))
d <- d + theme(axis.text.x=element_text(angle=45, hjust=1, face = 'bold'))
d <- d+ ggtitle("서울시 인구 분포도") + xlab("구") + ylab("인구")
d +  scale_y_continuous(breaks = int_breaks)

int_breaks <- function(x, n = 5) pretty(x, n)[pretty(x, n) %% 1 == 0] 
p = p + scale_y_continuous(formatter = function(x) format(x*10000))
p + ggtitle("Plot of length \n by dose") +
  xlab("Dose (mg)") + ylab("Teeth length")
p + theme(plot.title = element_text(family, face, colour, size))
# x axis title 
p + theme(axis.title.x = element_text(family, face, colour, size))
# y axis title
p + theme(axis.title.y = element_text(family, face, colour, size))

p <- ggplot(df, aes(x = reorder(f.name, -age), y = age))
p <- p + geom_bar(stat="identity", color='skyblue',fill='steelblue')
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))
p
p + theme(
  plot.title = element_text(color="red", size=14, face="bold.italic"),
  axis.title.x = element_text(color="blue", size=14, face="bold"),
  axis.title.y = element_text(color="#993333", size=14, face="bold")
)

q = (demo)[7:12]
data2 = c()
for(i in 1:nrow(q)){
  for(j in 1:ncol(q)){
    data2 = c(data2,replaceCommas(q[i,j]))      
  }
}
data2

library(dplyr)
mydata3 = data.frame(place = rep(demo$행정구역별,1, each = ncol(q)),values = data2)
final = mydata3 %>% group_by(place) %>% summarise(population = sum(values))

types2 = rep(colnames(q),25)
types2
final %>% dim()




e <-ggplot(mydata3, aes(place, values))
e +geom_bar(stat = "identity", aes(fill = types2))


library(ggmap)
install.packages("raster") 
library(raster)

getwd()
write.csv(final,"seoul_data")

mydata3
korea <- getData('GADM', country='kor', level=2)


seoul <- korea[korea$id <= 11740, ] 
ggplot() + geom_polygon(data=korea, aes(x=long, y=lat, group=group), fill='white', color='black')

ggplot() + geom_polygon(data=seoul, aes(x=long, y=lat, group=group), fill='white', color='black')

seoul <- korea[korea$id <= 11740, ]



getwd()
report <- read.csv("data_use.csv")
bike_rent_station_gu
all_id_location =  read_xlsx("all_station_location.xlsx")

all_id_location %>% dim()
names(all_id_location)[1] = 'id'

merge(top_low_use,all_id_location[,c(1,2)], by = 'id')
d = all_id_location[,c(1,2)]
d
top_low_use



merge(top_low_use,k,by='id')

k = data.frame('id' =c(2393) )

typeof(d)
typeof(top_low_use)
class(d)
class(top_low_use)
str(d)
str(top_low_use)


all_id_location %>% dim()
