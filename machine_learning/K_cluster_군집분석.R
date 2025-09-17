### 군집분석

#################### 데이터 확인
install.packages("dplyr")
install.packages("tidyverse")
library(dplyr)
library(tidyverse)
USArrests %>% str()

head(USArrests)

summary(USArrests)
cor(USArrests)

USAscaled <- scale(USArrests)
#distMat <- dist(USAscaled, method = 'euclidian', diag = T, upper= T)
distMat <- dist(USAscaled, method = 'euclidian')
var(USAscaled)  ################ 상관계수가 됨 스케일 된거를 분산매트릭스하면 바로 상관계수가 됨
USAscaled %>% as.data.frame() -> temp

apply(X=temp,MARGIN = 2,FUN = function(x)mean(x) %>% round(1))  ### 평균 0 인지 확인 

distMat

hc <- hclust(distMat, method = 'complete')
hc
plot(hc)
rect.hclust(tree = hc, k = 3 , border = 'red')

hclustPlot <- function(d,method,title,k){
  hc <- hclust(d=d,method = method)
  plot(x=hc, main = title)
  rect.hclust(tree = hc, k = k , border = 'red')
}
hclustPlot(distMat,'complete','최장연결법',3)단  ########## 최장 연결법이 훨씬 괜찮다 


hclustPlot(distMat,'ward.D2','최ㄷ연결법',3)


#################### 비계층적 군집 분석
install.packages("factoextra")
library(factoextra)
fit1 <- eclust(x =USAscaled, FUNcluster = 'kmeans', k = 3, hc_metric = 'euclidean', seed = 1234)    ##### 주성분으로 그래프도 시각화
print(fit1)
fit1$silinfo$clus.avg.widths
fit1$silinfo$widths[,3] %>%  mean()

fit1$cluster


