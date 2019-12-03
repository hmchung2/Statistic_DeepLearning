
key <- '70726a5844686d633734585747534a'
URL <- 'http://openapi.seoul.go.kr:8088'


'?ServiceKey=인증키&baseDt=201712&pageNo=1&numOfRows=3&type=xml'


library(tidyverse)
library(httr)
library(rvest)
library(jsonlite)

res <- GET(url = URL, query = list(
  KEY = I(key),
  TYPE = 'json',
  SERVICE = 'bikeList',
  START_INDEX= 1,
  END_INDEX=5
  ))

res



Sys.setlocale("LC_CTYPE", "UTF-8")

thepage = readLines('http://openapi.seoul.go.kr:8088/4255696748686d6331313976766a746c/json/bikeList/1/5/.json',encoding = "UTF-8" )
fromJSON(thepage)
library(jsonlite)
jFile <- fromJSON(thepage)
jFile$rentBikeStatus$row

