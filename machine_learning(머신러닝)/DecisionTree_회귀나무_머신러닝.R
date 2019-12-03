library(dplyr)
library(tidyverse)
####################회귀나무 알고리즘

house <- read.table(file = 'https://goo.gl/jsvkYS', header = TRUE) ## 데이터 다운로드
head(house)
str(house)

############################# grouping trainset and testset
set.seed(seed = 1234)
index <- sample(x = 1:2, size = nrow(house), prob = c(0.7,0.3), replace = TRUE)
trainSet <- house[index == 1 , ]
testSet <- house[index == 2 ,  ] 
trainSet$MedianHouseValue %>% mean()   ### 평균값들 확인
testSet$MedianHouseValue %>%  mean()

library(rpart)
fit <- rpart(formula = MedianHouseValue ~ Longitude + Latitude, 
             data = trainSet, control = rpart.control(minsplit=20, cp = 0.01))
summary(fit)   ############## 나눠진 노드들 확인
printcp(fit)


library(rpart.plot)
rpart.plot(fit , type = 0)


############################################## 그래프 디자인 및 색깔 고르기
#install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()
display.brewer.pal(n = 9, name = 'Spectral')
myPal <- brewer.pal(n=9, name = 'Oranges')
prp(fit, faclen = 0, extra = 101, cex = 1.0, box.pal = myPal[1:8])
plotcp(fit)



####################################   회귀나무 지역 모형
set.seed(seed= 1234)
fit1 <- rpart(formula = MedianHouseValue ~ Longitude + Latitude, data = trainSet, 
              control = rpart.control(minsplit = 20, cp = 0.001))
pred <- predict(fit, newdata = testSet, type = 'vector')
pred1 <- predict(fit1, newdata = testSet, type = 'vector')

wow = factor(pred)
wow ########### 16 levels because there are 15 splits in pred
printcp(fit)
printcp(fit1)
real <- testSet$MedianHouseValue
plot(real, pred1)

real %>% mean()
summary(fit)

#회귀모형 성능 평가
error1 <- real - pred1
error1^2 %>% mean() %>% sqrt()


########## 선형회귀모형과 성능 비교
fit2 <- lm(formula = MedianHouseValue ~ Longitude + Latitude, data = trainSet)
summary(fit2)


pred2 <- predict(object = fit2, newdata = testSet, type = 'response')
error2 <- real - pred2
error2^2 %>%  mean() %>% sqrt()

plot(real, pred2)
plot(real, pred1)                     #### 그래프도 더 좋은 모양을 보여준다 

#install.packages("tree")

library(tree)

fitTree <- tree(MedianHouseValue ~ Longitude + Latitude, data = house)
summary(fitTree)
plot(fitTree)
text(fitTree)
plot(fit)
text(fit)
summary(fit)
summary(fitTree)
####### 10단위 분위수를 생성
deciles <- quantile(x = house$MedianHouseValue, probs = seq(from = 0, to = 1 , length.out = 11))

######## 목표변수를  데실 기준 10등급으로 나누고 등급별 빈도수를 확인합니다
grade <- cut(x= house$MedianHouseValue, breaks = deciles, include.lowest = T)
table(grade, useNA = 'ifany')


############ 시각화
plot(x = house$Longitude, y = house$Latitude,
    col = grey(level = seq(1,0, length.out = 11))[grade],  
     pch = 20,
     xlab = 'Longitude',
     ylab = 'Latitude')

partition.tree(tree = fitTree,
               ordvars = c('Longitude', 'Latitude'),
               col = 'red',
               cex = 0.8,
               font = 2,
               add = TRUE) ########의사결정나무 규칙으로 화면을 분할하고 중앙에 평균값을 출력




