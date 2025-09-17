library(xlsx)
library(dplyr)
getwd()

cluster1 <- read.csv("cluster1.csv")
#names(cluster1) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                   #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster2 <- read.csv("cluster2.csv")
#names(cluster2) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster3 <- read.csv("cluster3.csv")
#names(cluster3) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster4 <- read.csv("cluster4.csv")
#names(cluster4) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
library(readxl)
cluster5 <- read_excel("cluster5.xlsx")
#names(cluster5) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster6 <- read_excel("cluster6.xlsx")
#names(cluster6) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster7 <- read_excel("cluster7.xlsx")
#names(cluster7) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster8 <- read_excel("cluster8.xlsx")
#names(cluster8) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster9 <- read_excel("cluster9.xlsx")
#names(cluster9) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster10 <- read_excel("cluster10.xlsx")
#names(cluster10) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )
cluster11 <- read.csv("cluster11.csv")
#names(cluster11) = c('bike','borrowing_time','borrowing_s_number','borrowing_s_name','borrowing_locked_number','returning_time','returning_s_number',
                    #'returning_s_name','returning_locked_nunmber','time','distance' )

final2 = rbind(cluster1,cluster2,cluster3,cluster4,cluster5,cluster6,cluster7,cluster8,cluster9,cluster10,cluster11)
dim(final2)
rbind(c(1,2,3),c(5,6,7))


rbind(cluster1,cluster2)





write.csv(final2,'full_data.csv')

names(cluster1) == names(cluster8)
names(cluster8)


cluster11 %>% is.na() %>% table()

is.na(final2$borrowing_time) %>% table()





