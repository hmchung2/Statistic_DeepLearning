
library(dplyr)
library(tidyverse)
###############그래디언트 부스팅 학습
bank <- read.csv(file = 'https://goo.gl/vE8GyN', stringsAsFactors = FALSE)
summary(bank)
bank <- bank %>% select(-ID,-ZIP.Code)

map_df(bank[,c(6,8:12)], as.factor) -> bank[,c(6,8:12)]  ###### 팩터로 형식 바꾸기

set.seed(seed=1234)
index <- sample(x=1:2, size = nrow(bank), prob = c(0.7,0.3), replace = T)
bank$PersonalLoan %>%  table()

trainSet <- bank[index == 1,]                         ########### trainset 만들기
testSet <- bank[index == 2, ]                         ########### testset 만들기


library(gbm)                                     ########gbm 패키지
set.seed(seed= 1234)
fitGBC <- gbm(formula = PersonalLoan~., data = trainSet, distribution = 'multinomial', 
              n.trees = 5000, interaction.depth = 3,
              shrinkage = 0.01, n.minobsinnode = 10,            
              bag.fraction =0.5,
              cv.folds = 5, 
              n.cores = 3)    ####### gradient 알고리즘은 오래 걸리는 단점이 있다

library(parallel)
detectCores()

fitGBC %>% print()
########### 상대적 영향을준 변수
summary(fitGBC) ######### income 이 제일 영향이 크다

#education 과 personalLoan 관계
plot(fitGBC, i = 'Education')

chisq.test(x= trainSet$Education, y= trainSet$PersonalLoan)

table(trainSet$Education, trainSet$PersonalLoan)

pred <- predict(object = fitGBC, newdata = testSet, type = 'response')
pred


maxCol <- apply(X = pred, MARGIN = 1, FUN = which.max)
maxCol
################# 추정갑
colnames(x= pred)[maxCol] %>% as.factor -> pred

real <- testSet$PersonalLoan
####################### 성능 평가

library(caret)
confusionMatrix(data = pred, reference = real, positive = '1') # 정확도를 알 수 있다 

library(MLmetrics)
F1_Score(y_pred = pred, y_true = real, positive = '1')  # f1 score

library(ROCR)
predObj <- prediction(predictions = as.numeric(x=pred), labels = as.numeric(x=real))
perform <- performance(prediction.obj = predObj, measure = 'tpr', x.measure = 'fpr')
plot(perform)
library(pROC)
auc(response = as.numeric(x=real), predictor = as.numeric(x=pred))

grid <- expand.grid(depth = c(1,3,5),
                    learn = c(0.01,0.05,0.1),
                    min = c(5,7,10),
                    bag = c(0.5,0.8,1.0),
                    tree = NA,
                    loss = NA)
grid


for(i in 1:nrow(x=grid)){
  set.seed(seed=1234)
  fit <- gbm(formula = PersonalLoan~., 
                data = trainSet, 
                distribution = 'multinomial', 
                n.trees = 5000, 
                interaction.depth = grid$depth[i],
                shrinkage = grid$learn[i], 
                n.minobsinnode = grid$min[i],
                bag.fraction = grid$bag[i],
                train.fraction = 0.75)
  grid$tree[i] <-which.min(x= fit$valid.error)
  grid$loss[i] <- min(fit$valid.error)
}

grid[6,]
fitGBC$valid.error

which.min(fitGBC$valid.error)



########################################## 회귀 모형 그래디언트

house <- read.table(file = 'https://goo.gl/jsvkYS', header =T)
library(caret)
set.seed(seed= 1234)
createDataPartition(y= house$MedianHouseValue ,  p = 0.7, list = FALSE) -> index
trainSet <- house[index,]
testSet <- house[-index,]
trainSet$MedianHouseValue %>%  mean()
testSet$MedianHouseValue %>% mean()

set.seed(seed= 1234)
fitGBR <- gbm(formula = MedianHouseValue~.,data = trainSet, 
              distribution = 'gaussian',
              n.trees = 5000,
              interaction.depth = 4,
              shrinkage = 0.01,
              n.minobsinnode = 10,
              bag.fraction = 0.5,
              cv.folds =5,
              n.cores = 3)

which.min(fitGBR$cv.error)
gbm.perf(object = fitGBR, method = 'cv')
plot(x= fitGBR, i = 'MedianIncome')

cor(trainSet$MedianIncome,trainSet$MedianHouseValue)
cor.test(trainSet$MedianIncome,trainSet$MedianHouseValue)

###################추정
pred <- predict(object = fitGBR, newdata = testSet, n.trees = 5000)
nrow(testSet)
length(pred)

########### 성능 확인
real <-testSet$MedianHouseValue
error <- real - pred
error^2 %>% mean() %>% sqrt()
plot(real, pred)

setwd("c:/r_ml")
getwd()
fitRFR <-readRDS(file = 'fitRFR.RDS')
bestRFR %>% summary()



library(randomForest)
pred2 <- predict(object = fitRFR, newdata = testSet, type = 'response')

pred2 %>%  length()

length(pred)





