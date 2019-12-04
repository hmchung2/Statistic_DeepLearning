

###############################   데이터 불러오기
bank <- read.csv(file = 'https://goo.gl/vE8GyN', stringsAsFactors = FALSE)
house <- read.table(file='https://goo.gl/jsvkYS', header = TRUE)
str(house)
install.packages("tidyverse")
library(tidyverse)

bank <- bank %>% select(-ID,-ZIP.Code)
bank[,c(6,8:12)] <- map_df(.x=bank[,c(6,8:12)],.f = as.factor)
set.seed(see=1234)
index <- sample(x=1:2, size = nrow(x= bank), prob = c(0.7,0.3),replace = TRUE)
trainSet <- bank[index == 1 , ]
testSet <- bank[index == 2 , ]


install.packages("randomForest")
library(randomForest)
colnames(trainSet)[8]
set.seed(seed = 1234)
fitRFC <- randomForest(x= trainSet[,-8],    ################ 1000개의 나무로 지정 그리고 학스
                       y= trainSet[,8],
                       xtest = testSet[,-8],
                       ytest = testSet[,8],
                       ntree = 1000,
                       mtry = 3,
                       importance = TRUE,
                       do.trace =  T,
                       keep.forest = TRUE
                       )




summary(fitRFC)                             ##### 결과
importance(fitRFC)

plot(x=fitRFC$err.rate[,1], type = 'l')      #### 사실 나무 300개만 있어도 충분 하다는걸 알수 있다
plot(fitRFC)

importance(fitRFC)
varImpPlot(fitRFC)

############## 노드 개수 보기 시각화
fitRFC %>% treesize(terminal = T) %>% hist()

###############추정라벨 생성

pred <- predict(object = fitRFC, newdata = testSet, type = 'response')

table(pred)

fitRFC$test$predicted %>% table()

################## 추정확률 생성
prob <- predict(object = fitRFC, newdata= testSet, type = 'vote')
prob <- prob[,2]

tail(prob)
real <- testSet$PersonalLoan
install.packages("caret")
library(caret)
confusionMatrix(data = pred, reference = real, positive = '1')   ### 회귀 나무보다 훨씬 정확도가 높다

fitDT <- readRDS("fitDT.RDS")                             ### 저장된 회귀나무 머신러닝 RDS 파일 불러 와서 비교를 해보자
list.files(pattern= "fit")                            
list.files()
predDT = predict(object = fitDT, newdata = testSet, type = 'class')
confusionMatrix(data = predDT, reference = real, positive = '1')
str(testSet)
dim(testSet)
############### f1 score 비교
install.packages("MLmetrics")
library(MLmetrics)
F1_Score(y_pred = pred, y_true = real, positive = '1')
F1_Score(y_pred = predDT, y_true = real, positive = '1')

###############ROC curve 비교
install.packages("ROCR")
library(ROCR)
predObj <- prediction(predictions = as.numeric(x = pred), labels = as.numeric(x=real))
perform <- performance(prediction.obj = predObj, measure = 'tpr', x.measure = 'fpr')
plot(x = perform, main = 'ROC curve')


prediction(predictions = as.numeric(x = predDT), labels = as.numeric(x=real))%>% performance( measure = 'tpr', x.measure = 'fpr')%>% plot( main = 'ROC curve')

prediction(predictions = as.numeric(x = prob), labels = as.numeric(x=real))%>% performance( measure = 'tpr', x.measure = 'fpr')%>% plot( main = 'ROC curve')

############## auc score 비교
install.packages("pROC")
library(pROC)
auc(response = as.numeric(x= real), predictor = as.numeric(x=pred))
auc(response = as.numeric(x= real), predictor = as.numeric(x=predDT))

#################### GBM 패키지 다운로드
#################### grid 형식을 깔아서 여러개의 경우의 수를 보자
install.packages("gbm")
library(gbm)
grid <- expand.grid(ntree= c(300,500,700,1000), mtry = c(3,5,7,9,11))
grid
i = 1
tuned <-data.frame()
for(i in 1:nrow(x= grid)){
  set.seed(seed=1234)
  cat(i, '행 실행중! [ntree:', grid[i,'ntree'],',mtry:',grid[i,'mtry'],'] \n\n')
  fit <- randomForest(x= trainSet[,-8],
                         y= trainSet[,8],
                         xtest = testSet[,-8],
                         ytest = testSet[,8],
                         ntree = grid$ntree[i],
                         mtry = grid$mtry[i],
                         importance = TRUE,
                         do.trace =  50,
                         keep.forest = TRUE
                    )
  mcSum <- sum(fit$predicted != trainSet$PersonalLoan)
  mcRate <- mcSum / nrow(x = trainSet)
  df <-data.frame(index = i, misClassRate = mcRate)
  tuned <- rbind(tuned,df)
  cat('\n')

}
tuned
################ 어떤게 가장 적은 오분류률

plot(tuned$index, tuned$misClassRate)
abline(h = min(tuned$misClassRate),col = 'red',lty = 2)

which(tuned$misClassRate == min(x= tuned$misClassRate)) -> loc
loc

bestPara <- grid[loc,]
bestPara      ################ 이게 best parameter 로 지정


set.seed(seed=1234)
bestRFC <- randomForest(x= trainSet[,-8],
                        y= trainSet[,8],
                        xtest = testSet[,-8],
                        ytest = testSet[,8],
                        ntree = bestPara$ntree,
                        mtry = bestPara$mtry,
                        importance = TRUE,
                        do.trace =  50,
                        keep.forest = TRUE
)

plot(bestRFC$err.rate[,1], type = 'l')
plot(bestRFC)

importance(bestRFC)
varImpPlot(bestRFC)




################### testing all scores with DT
####################  결과 비교 
####################  랜덤포레스트 > 회귀나무  하지만 모델을 설명 할수 없는 부분에서 아쉽다. 
predB <- predict(object = bestRFC, newdata = testSet, type = 'response')

confusionMatrix(data = predB, reference =real, positive = '1')
confusionMatrix(data = predDT, reference =real, positive = '1')

F1_Score(y_pred = predB, y_true = real, positive = '1')
F1_Score(y_pred = predDT, y_true = real, positive = '1')

saveRDS(object = bestRFC, file = 'bestRFC.RDS')

auc(response = as.numeric(x = real), predictor = as.numeric(x=predB))
auc(response = as.numeric(x = real), predictor = as.numeric(x=predDT))




