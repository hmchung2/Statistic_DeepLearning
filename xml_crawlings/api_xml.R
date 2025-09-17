
##### url 로 부터 인증키 구하기
key <- 'get an key from the url'
URL <- 'http://apis.data.go.kr/1192000/openapi/service/ManageExpNationItemService/getExpNationItemList'


'?ServiceKey=인증키&baseDt=201712&pageNo=1&numOfRows=3&type=xml'

install.packages("dplyr")
install.packages("tidyverse")
install.packages("rvest")
install.packages("jsonlite")
install.packages("httr")

library(dplyr)
library(tidyverse)
library(httr)
library(rvest)
library(jsonlite)

res <- GET(url = URL, query = list(
  ServiceKey = I(key),
  baseDt = '201501',
  pageNo = 1,
  numOfRows= 10,
  type='Json'
))

res %>% content(as = 'text', encoding = 'UTF-8') %>% fromJSON() -> json
json$response$body$item[1:3,]



res <- GET(url = URL, query = list(
  ServiceKey = I(key),
  baseDt = '201501',
  pageNo = 1,
  numOfRows= 10,
  type='xml'
))


res %>% read_xml(encoding = 'UTF-8') %>%  xml_nodes(css = 'body > items > item') -> items
items %>% xml_node(css = 'nationCode') %>%  xml_text(trim = T) -> nationcode
items %>% xml_node(css = 'nationNm') %>%  xml_text(trim = T) -> nationname


df <- data.frame(nationcode,nationname)
df

df <- data.frame()
for(page in 1:5){
  res <- GET(url = URL, query = list(
    ServiceKey = I(key),
    baseDt = '201701',
    pageNo = page,
    numOfRows= 10,
    type='xml'
  ))
  res %>% read_xml(encoding = 'UTF-8') %>%  xml_nodes(css = 'body > items > item') -> items
  items %>% xml_node(css = 'nationCode') %>%  xml_text(trim = T) -> nationcode
  items %>% xml_node(css = 'nationNm') %>%  xml_text(trim = T) -> nationname
  wow <- as.data.frame(nationcode,nationname)
  rbind(df,wow) -> df
}
df %>% nrow()
df
install.packages("RJSONIO")
library(RJSONIO)
toJSON(res$date)



