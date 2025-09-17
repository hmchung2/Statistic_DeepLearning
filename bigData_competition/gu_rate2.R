rate_loc2 %>% dim()
rate_loc %>% head()
dim(full_data)
head(full_data)
full_data$borrowing_s_number %>% is.na() %>% table()
full_data$borrowing_s_name %>% is.na() %>% table()
full_data$returning_s_name %>% is.na() %>% table()
bad_full$borrowing_s_name %>% is.na() %>% table()
str(bad_full)
bad_full$borrowing_s_name = as.character(bad_full$borrowing_s_name)

bad_full$borrowing_s_name =  gsub("\'", "", bad_full$borrowing_s_name)
bad_full$borrowing_s_name =  gsub(" ","", bad_full$borrowing_s_name)
dim(bad_full)

str(loc)

bad_full2 = merge(bad_full, loc , by = "returning_s_name")
dim(bad_full2)

loc2 = loc
names(loc2)[2] = "borrowing_s_name"
bad_full3 = merge(bad_full2, loc2, by = "borrowing_s_name")
dim(bad_full3)
head(bad_full3)
names(bad_full3)


bad_path = bad_full3 %>% group_by(bike,borrowing_s_name,returning_s_name,위도.y,경도.y,위도.x,경도.x) %>% summarise(count = n())
bad_path[bad_path$count == 4,]

dim(bad_path)
bad_path %>% group_by(bike) %>% summarise(counting = sum(count)) %>% arrange(desc(counting)) -> aaaa

dif_path = bad_path[bad_path$borrowing_s_name != bad_path$returning_s_name, ]


getwd()
weight_dif_path = dif_path %>% group_by(borrowing_s_name,returning_s_name,위도.y,경도.y,위도.x,경도.x) %>% summarise(count = n()) %>% arrange(desc(count))
write.csv(weight_dif_path, " weighted_dif_pat.csv")

library(leaflet)



