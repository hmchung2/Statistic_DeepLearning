weight_dif_path= read.csv("weighted_dif_pat.csv")
getwd()

require(leaflet)

require(geosphere)
library(ggmap)
library(googleway)
library(dplyr)
################################# color function
t_col <- function(color, percent = 20, name = NULL) {
  #	  color = color name
  #	percent = % transparency
  #	   name = an optional name for the color
  ## Get RGB values for named color
  rgb.val <- col2rgb(color)
  ## Make new color using input color as base and alpha set by transparency
  t.col <- rgb(rgb.val[1], rgb.val[2], rgb.val[3],
               max = 255,
               alpha = (100-percent)*255/100,
               names = name)
  ## Save the color
  invisible(t.col)
  
}
##########################################
a = head(weight_dif_path,400)
dim(weight_dif_path)
names(a)[4:7] = c('Exit_Station_Lat','Exit_Station_Long','Entry_Station_Lat','Entry_Station_Long')
names(a)[8] = 'id'
names(a)

a= a %>% arrange(id)
a
#format data
a$Entry_Station_Long = as.numeric(as.character(a$Entry_Station_Long))
a$Entry_Station_Lat = as.numeric(as.character(a$Entry_Station_Lat))
a$Exit_Station_Long = as.numeric(as.character(a$Exit_Station_Long))
a$Exit_Station_Lat = as.numeric(as.character(a$Exit_Station_Lat))


#create some colors
#factpal <- colorFactor(heat.colors(30), a$id)

#create a list of interpolated paths

pathList = NULL
for(i in 1:nrow(a)){
  tmp = gcIntermediate(c(a$Entry_Station_Long[i],
                         a$Entry_Station_Lat[i]),
                       c(a$Exit_Station_Long[i],
                         a$Exit_Station_Lat[i]),n = 1,
                       addStartEnd=TRUE)
  tmp = data.frame(tmp)
  tmp$id = a[i,]$id
  tmp$color <- if(a[i,]$id >100){
    'red'}
  else{
    t_col('blue',90)
  }   
  
  pathList = c(pathList,list(tmp))
}
#create empty base leaflet object
leaflet() %>% addTiles() -> lf

#add each entry of pathlist to the leaflet object
pathList
for (path in pathList){
  lf %>% addPolylines(data = path,
                      lng = ~lon, 
                      lat = ~lat,
                      color = ~color  ) -> lf
  
}
#show output
lf

path


b = a[a$id > 200,]
a$id = (a$id - 81) / 20 
b$id = (b$id - 81) / 20 

library(ggmap)
register_google(key = 'AIzaSyBu3tLXXVlXAcYi-hwPytWSjh6VakLsgHo')
coord <-geocode('Seoul')
#########################################################
m <-  leaflet() %>% leaflet() %>% addTiles(urlTemplate = "https://mts1.google.com/vt/lyrs=s&hl=en&src=app&x={x}&y={y}&z={z}&s=G", attribution = 'Google') %>% 
  setView(coord$lon, coord$lat, zoom = 11) %>% 
  addCircles(data =a, lng =  ~Entry_Station_Long, lat =  ~Entry_Station_Lat,
             weight = ~id, color="#ffa500", stroke = TRUE, fillOpacity = 0.8) %>% 
  addPolylines(data = a,
               lng = ~Exit_Station_Long, lat = ~Exit_Station_Lat,
               stroke = TRUE,color = "blue", weight = 0.5, opacity = 0.5,
               fill = FALSE, fillOpacity = 0.1, dashArray = NULL,
               smoothFactor = 1)





m <- m %>% addCircles(data =b, lng =  ~Entry_Station_Long, lat =  ~Entry_Station_Lat,
                      weight = ~id, color="red", stroke = TRUE, fillOpacity = 0.8) %>% 
  addPolylines(data = b,
               lng = ~Exit_Station_Long, lat = ~Exit_Station_Lat,
               stroke = TRUE,color = "red", weight = 1.5, opacity = 0.9,
               fill = FALSE, fillOpacity = 0.1, dashArray = NULL,
               smoothFactor = 1)


d = tail(b,15)
d$borrowing_s_name = as.character(d$borrowing_s_name)
d = d[!duplicated(d$borrowing_s_name),]
d$borrowing_s_name %>% table()
m <- m %>% addLabelOnlyMarkers(data = d, lng =  ~d$Entry_Station_Long, lat =  ~d$Entry_Station_Lat,
                    label =  ~as.character(d$borrowing_s_name),
                    labelOptions = labelOptions(noHide = T, direction = 'top', textOnly = T, 
                                                style =list("color" = "red",
                                            "font-family" = "serif",
                                           "font-style" = "italic",
                                    "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                      "font-size" = "13px",
                                      "border-color" = "rgba(0,0,0,0.5)")),
                    options = markerOptions(riseOnHover = TRUE))
m

###############################################



m <-  leaflet() %>% addTiles('http://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
                             attribution='Map tiles by <a href="http://stamen.com">Stamen Design</a>, 
<a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
  setView(coord$lon, coord$lat, zoom = 11) %>%
  addCircles(data =a, lng =  ~Entry_Station_Long, lat =  ~Entry_Station_Lat,
             weight = ~id, color="#ffa500", stroke = TRUE, fillOpacity = 0.8) %>% 
  addPolylines(data = a,
               lng = ~Exit_Station_Long, lat = ~Exit_Station_Lat,
               stroke = TRUE,color = "deepskyblue", weight = 0.4, opacity = 0.4,
               fill = FALSE, fillOpacity = 0.1, dashArray = NULL,
               smoothFactor = 1)





m <- m %>% addCircles(data =b, lng =  ~Entry_Station_Long, lat =  ~Entry_Station_Lat,
                      weight = ~id, color="red", stroke = TRUE, fillOpacity = 0.8) %>% 
  addPolylines(data = b,
               lng = ~Exit_Station_Long, lat = ~Exit_Station_Lat,
               stroke = TRUE,color = "red", weight = 1.5, opacity = 0.9,
               fill = FALSE, fillOpacity = 0.1, dashArray = NULL,
               smoothFactor = 1)


d = tail(b,15)
d$borrowing_s_name = as.character(d$borrowing_s_name)
d = d[!duplicated(d$borrowing_s_name),]
d$borrowing_s_name %>% table()
m <- m  %>% 
  addMarkers(lng=d$Entry_Station_Long, lat= d$Entry_Station_Lat, 
             popup= d$borrowing_s_name
  )
m



































#########################################################################################3
m <-  leaflet(options = leafletOptions(zoomControl = TRUE,
                                       minZoom = 10, maxZoom = 17,
                                       dragging = TRUE))  %>% 
  setView(coord$lon, coord$lat, zoom = 11) %>%
  addProviderTiles("Stamen.Watercolor",options = providerTileOptions(opacity = 0.35)) %>% 
  addProviderTiles("Stamen.TonerHybrid",options = providerTileOptions(opacity = 0.75)) %>% 
  addCircles(data =a, lng =  ~Entry_Station_Long, lat =  ~Entry_Station_Lat,
             weight = ~id, color="#ffa500", stroke = TRUE, fillOpacity = 0.8) %>% 
  addPolylines(data = a,
               lng = ~Exit_Station_Long, lat = ~Exit_Station_Lat,
               stroke = TRUE,color = "#6eff2a", weight = 0.8, opacity = 0.8,
               fill = FALSE, fillOpacity = 0.1, dashArray = NULL,
               smoothFactor = 1)

m <- m %>% addCircles(data =b, lng =  ~Entry_Station_Long, lat =  ~Entry_Station_Lat,
                      weight = ~id, color="red", stroke = TRUE, fillOpacity = 0.8) %>% 
  addPolylines(data = b,
               lng = ~Exit_Station_Long, lat = ~Exit_Station_Lat,
               stroke = TRUE,color = "red", weight = 1.5, opacity = 0.9,
               fill = FALSE, fillOpacity = 0.1, dashArray = NULL,
               smoothFactor = 1)


d = tail(b,15)
d$borrowing_s_name = as.character(d$borrowing_s_name)
d = d[!duplicated(d$borrowing_s_name),]
d$borrowing_s_name %>% table()
m <- m  %>% 
  addMarkers(lng=d$Entry_Station_Long, lat= d$Entry_Station_Lat, 
             popup= d$borrowing_s_name
  )
m




library(htmlwidgets)
saveWidget(m, file="m.html")


###########################################################################
m <-  leaflet() %>% leaflet() %>% addTiles() %>% addProviderTiles(providers$Stamen.Toner) %>%  
  setView(coord$lon, coord$lat, zoom = 11) %>% 
  addCircles(data =a, lng =  ~Entry_Station_Long, lat =  ~Entry_Station_Lat,
             weight = ~id, color="#ffa500", stroke = TRUE, fillOpacity = 0.8) %>% 
  addPolylines(data = a,
               lng = ~Exit_Station_Long, lat = ~Exit_Station_Lat,
               stroke = TRUE,color = "#6eff2a", weight = 0.7, opacity = 0.7,
               fill = FALSE, fillOpacity = 0.1, dashArray = NULL,
               smoothFactor = 1)





m <- m %>% addCircles(data =b, lng =  ~Entry_Station_Long, lat =  ~Entry_Station_Lat,
                      weight = ~id, color="red", stroke = TRUE, fillOpacity = 0.8) %>% 
  addPolylines(data = b,
               lng = ~Exit_Station_Long, lat = ~Exit_Station_Lat,
               stroke = TRUE,color = "red", weight = 1.5, opacity = 0.9,
               fill = FALSE, fillOpacity = 0.1, dashArray = NULL,
               smoothFactor = 1)


d = tail(b,15)
d$borrowing_s_name = as.character(d$borrowing_s_name)
d = d[!duplicated(d$borrowing_s_name),]
d$borrowing_s_name %>% table()
m <- m  %>% 
  addMarkers(lng=d$Entry_Station_Long, lat= d$Entry_Station_Lat, 
             popup= d$borrowing_s_name
  )
m






