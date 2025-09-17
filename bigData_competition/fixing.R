
library(readxl)
library(tidyverse)
library(dplyr)
library(readr)
setwd( "C:/r_project")

full_data = read.csv('full_data.csv')
full_data %>% head()

fix_bike = read.csv('repair_final.csv')


a = order(fix_bike$repair, decreasing = T)[1:50]

top_repair =   fix_bike[a,]
full_data2 =  full_data[,c(2,4,8)]




top_repair$bike %>% as.character() -> top_repair$bike
full_data2$bike %>% as.character() -> full_data2$bike

top_repair$bike
full_data2 %>% head()
full_data2 %>% head()

full_data2$bike =  gsub("\'", "", full_data2$bike)




merge(full_data2, top_repair, by = 'bike') -> df
df %>% dim()
df

table(df$bike)
top_repair$repair %>% table()

df2 = df[!is.na(df$borrowing_s_number),]
df2
getwd()
write.csv(df2,"top50repair_path.csv")

df2
loc = read_excel('all_station_location.xlsx')
names(loc)
names(df2)
df3 = df2[,c(1,2,3)]



df3$borrowing_s_number = as.character(df3$borrowing_s_number)
df3$returning_s_number = as.character(df3$returning_s_number)
df3$borrowing_s_number =  gsub("\'",'',df3$borrowing_s_number)
df3$returning_s_number =  gsub("\'",'',df3$returning_s_number)


loc$대여소번호 = as.character(loc$대여소번호)
str(loc)
names(loc)
loc2 = loc[,c(1,5,6)]

df3 %>% head()
#merge(X, Y, by.x='id', by.y='ID')
str(df3)
bor_loc = merge(df3,loc2, by.x = "borrowing_s_number", by.y = '대여소번호')
str(bor_loc)

ret_loc = merge(bor_loc,loc2, by.x = "returning_s_number" , by.y = '대여소번호')
str(ret_loc)


head(ret_loc)
table(ret_loc$위도.x) %>% length()
table(ret_loc$위도.y) %>% length()
table(ret_loc$경도.x) %>% length()
table(ret_loc$경도.y) %>% length()

dim(ret_loc)
install.packages("leaflet")
library(leaflet)

head(ret_loc)
bad_path = ret_loc %>% group_by(위도.x,경도.x,위도.y,경도.y) %>% summarise(count = n())


map3 = leaflet(re) %>% addTiles()
names(ret_loc)
map3 %>% addMarkers(~위도.x,~경도.x, popup=~bike)

install.packages("mapdeck")
library(mapdeck)

set_token("MAPBOX_TOKEN")  ## set your mapbox token here

df$Exit_Station_Lat <- as.numeric(as.character(df$Exit_Station_Lat))
df$Exit_Station_Long <- as.numeric(as.character(df$Exit_Station_Long))

bad_path_test = bad_path[1:200,]
sapply(bad_path_test,mean)

install.packages("googleway")
library(googleway)

df = bad_path_test
names(df) = c('Entry_Station_Lat','Entry_Station_Long','Exit_Station_Lat','Exit_Station_Long','count')

df$polyline <- apply(df, 1, function(x) {
  lat <- c(x['Entry_Station_Lat'], x['Exit_Station_Lat'])
  lon <- c(x['Entry_Station_Long'], x['Exit_Station_Long'])
  encode_pl(lat = lat, lon = lon)
})


mapKey <- 'AIzaSyBu3tLXXVlXAcYi-hwPytWSjh6VakLsgHo'

style <- '[ { "stylers": [{ "visibility": "simplified"}]},{"stylers": [{"color": "#131314"}]},{"featureType": "water","stylers": [{"color": "#131313"},{"lightness": 7}]},{"elementType": "labels.text.fill","stylers": [{"visibility": "on"},{"lightness": 25}]}]'


google_map(key = mapKey, style = style) %>%
  add_polylines(data = df, 
                polyline = "polyline", 
                mouse_over_group = "Entry_Station_Lat",
                stroke_weight = 2,  
                stroke_opacity = 3,
                stroke_colour = "#ccffff")

library(mapdeck)

set_token("MAPBOX_TOKEN")  ## set your mapbox token here

df$Exit_Station_Lat <- as.numeric(as.character(df$Exit_Station_Lat))
df$Exit_Station_Long <- as.numeric(as.character(df$Exit_Station_Long))

mapdeck(location = c(37, 126)
  ) %>%
  add_arc(
    data = df
    , origin = c("Entry_Station_Long", "Entry_Station_Lat")
    , destination = c("Exit_Station_Long", "Exit_Station_Lat")
    , layer_id = 'arcs'
    , stroke_from_opacity = 100
    , stroke_to_opacity = 100
    , stroke_width = 3
    , stroke_from = "#ccffff"
    , stroke_to = "#ccffff"
  )





