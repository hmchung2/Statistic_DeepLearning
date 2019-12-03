library(tidyverse)
library(httr)
library(rvest)
library(jsonlite)
URL = 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'

'LAWD_CD=11110
&DEAL_YMD=201512
&serviceKey=서비스키'
#### url 로부터 인증키 구하기 
key = 'get an api key from the url'

GET(url ='http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'
    , query = list(LAWD_CD = '11110',
                   DEAL_YMD = '201709',
                serviceKey= I(x=key))) ->res 

#httr package  ## I -> as.is function ## 퍼센트지가 문자 그대로 집어 너라

print(res)

res %>% content(as= 'text', encoding = 'UTF-8') %>% fromJSON() -> json


json$response$body$items$item



json$response$body$totalCount
str(object = json)
ceiling(json$response$body$totalCount / 10)  -> pages
pages

json$response$body$totalCount/10

result <- data.frame()

for(page in 1:pages){
  GET(url = 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev' 
      , query = list(LAWD_CD = '11680',
                     DEAL_YMD = '201909',
                     serviceKey= I(x=key),
                     pageNo = page,
                     numOfRows = 10)) ->res 
  res %>% content(as= 'text', encoding = 'UTF-8') %>% fromJSON() -> json
  json$response$body$items$item ->df
  result <- rbind(result,df)
  Sys.sleep(time = 1)
}
result

result$거래금액  <- result$거래금액 %>% str_remove(pattern = ',') %>% as.numeric
typeof(result$거래금액)

a = result %>% select(법정동,아파트,거래금액,전용면적) %>% group_by(법정동,아파트)
a

a %>%  summarise(거래건수  = n(), 금액합계 = sum(거래금액), 면적합계 = sum(전용면적)) %>% 
mutate(평균금액 = 금액합계/거래건수, 단위금액 = 금액합계/ 면적합계)


k = a %>% summarise(거래건수 = n(), 금액합계 = sum(거래금액),면적합계 = sum(전용면적)) 



result %>% select(법정동,아파트,거래금액,전용면적) %>% 
group_by(법정동,아파트) %>%
summarise(거래건수  = n(), 금액합계 = sum(거래금액), 면적합계 = sum(전용면적)) %>% 
mutate(평균금액 = 금액합계/거래건수, 단위금액 = 금액합계/ 면적합계) ->aptStat


aptStat
aptStat2 <- aptStat[aptStat$평균금액 >= 200000,]
aptStat3 <- aptStat[aptStat$단위금액 >= 2500,]
plot(x= aptStat$단위금액, y = aptStat$평균금액) 
points(x =aptStat2$단위금액, y = aptStat2$평균금액, pch = 19, col = 'blue'  )
text(x =aptStat2$단위금액, y = aptStat2$평균금액, labels =  aptStat2$아파트, col = 'blue', pos = 2)
points(aptStat3$단위금액, y = aptStat3$평균금액, pch = 19, col = 'red')
text(aptStat3$단위금액, aptStat3$평균금액, labels = aptStat3$아파트, col = 'red', pos = 3)





