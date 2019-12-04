#install.packages("tidyverse")
library(dplyr)
library(tidyverse)

wine <- read.csv(file='https://bit.ly/2RmU1Wd', sep = ";")
wine
str(wine)
tbl <- table(x= wine$quality)   ######## see wine qulity
tbl
tbl %>% prop.table() %>% cumsum() %>% round(digits= 4L) * 100 # to see proportion

bp <- barplot(height=tbl, ylim = c(0,2400), xlab =  "Wine Quality") # see barplot
text(x = bp, y= tbl, labels = tbl, pos = 3)

str(wine)
wine$grade <- ifelse(test=wine$quality >= 7, yes = 'best', no = 'good')  ### labeling  라벨링 
wine$grade

wine$grade <- as.factor(wine$grade)
wine$grade


scale(wine[,1:11]) %>% as.data.frame() -> wineScaled      #### 표준화
mean(wineScaled[,1])
dim(wineScaled)

wineScaled <- cbind(wineScaled, grade = wine$grade)
wineScaled
dim(wineScaled)


#####################  grouping trainset and testset
set.seed(1234)
index <- sample(1:2, size = nrow(wineScaled), prob = c(0.7,0.3), replace = T)
table(index)
trainSet <- wineScaled[index==1,]
dim(trainSet)
testSet <- wineScaled[index == 2, ]
dim(testSet)
trainSet$grade %>% table() %>% prop.table()

testSet$grade %>% table() %>% prop.table()

table(index)


############################  knn algorithm (KNN-알고리즘)
library(class)
set.seed(1234)
k <- trainSet %>% nrow() %>% sqrt() %>% ceiling()   ### k 숫자를 정하는 대중적인 방법
k

knn(train =  trainSet[,1:11],test = testSet[,1:11], 
    cl = trainSet$grade, k=k, prob = T) -> fitKnn


length(fitKnn)
table(fitKnn) %>% prop.table()
trainSet$grade %>% table() %>% prop.table()  #### 먼저 대략적인 비율부터 확인
testSet$grade %>% table() %>% prop.table()



attr(fitKnn,which = 'prob')[1:100]     ######## 확률


####################################   이제 정확도 체크
pred <-fitKnn
real <- testSet$grade
table(pred,real)
table(pred)
table(real)


install.packages("MLmetrics")
#################################  f1 score 확인

library(MLmetrics)
F1_Score(y_pred = pred, y_true = real, positive = 'best') ###### 정확도는 좋지만 f1 score 낮다 



################################################# cofnusion matrix
install.packages("caret")
install.packages("e1071")
library(caret)
library(e1071)
confusionMatrix(data= pred, reference = real, positive = 'best')

install.packages("ROCR") 
#######################################################  ROC 커브 
library(ROCR)
predObj <- prediction(predictions= as.numeric(pred), labels = as.numeric(real))
predObj
perform <- performance(prediction.obj = predObj, measure = 'tpr', x.measure = 'fpr')
plot(x= perform, main = "ROC curve")

install.packages("pROC")
############################## roc curve 넓이 
library(pROC)
auc(response = as.numeric(x=real), predictor = as.numeric(x = pred))


########################################  over sampleing 해서 샘플링 개수 평준화
install.packages("ROSE")
library(ROSE)
head(trainSet)
ovun.sample(formula = grade~.,data= trainSet, method = 'both', p = 0.5) -> trainSetBall
trainSetBall$data %>% dim()



############################################################### kknn
install.packages("kknn")
library(kknn)
kknn(formula = grade~.,train = trainSetBall$data,test =   testSet, k = k , kernel = 'triangular') -> fitKnnW


predBalW <- fitKnnW$fitted.values
predBalW


levels(predBalW)
relevel(x= predBalW, ref = 'best') -> predBalW    ####### 혹시 모르니 ovun.sample 이후엔 relevel
predBalW
table(predBalW)
real %>% table()
pred %>%  table()



####################  결과  이전 보단 조금 나아짐
confusionMatrix(data=predBalW, reference = real, positive = 'best')
F1_Score(y_pred = predBalW, y_true = real, positive = 'best')
predObj1 <- prediction(predictions = as.numeric(predBalW), labels= as.numeric(real))
perform2 <- performance(prediction.obj = predObj1, measure = 'tpr', x.measure = 'fpr')
plot(x = perform2, main = "ROC curve")

auc(response = as.numeric(real), predictor = as.numeric(predBalW))
table(predBalW,real)


########################################## 은행 데이타
bank <- read.csv(file = 'https://goo.gl/vE8GyN', stringsAsFactors = FALSE)
bank

summary(bank)
bank <- bank %>% select(-ID,-ZIP.Code) # 전처리
bank
bank$Education = as.factor(bank$Education)
bank$PersonalLoan <- as.factor(bank$PersonalLoan)
bank$SecuritiesAccount <- as.factor(bank$SecuritiesAccount)
bank$CDAccount <- as.factor(bank$CDAccount)
bank$Online <- as.factor(bank$Online)
bank$CreditCard <- as.factor(bank$CreditCard)
bank$PersonalLoan %>% table() %>% prop.table()

map_df(bank[,c(6,8:12)], as.factor) -> bank[,c(6,8:12)]
summary(bank)

########################grouping trainset and testset
set.seed(seed=1234)
index <- sample(x=1:2, size = nrow(bank), prob = c(0.7,0.3), replace = T)
bank$PersonalLoan %>%  table()
trainSet <- bank[index == 1,]
testSet <- bank[index == 2, ]

trainSet$PersonalLoan %>%  table() %>%  prop.table()
testSet$PersonalLoan %>%  table() %>%  prop.table()



########################################### 회귀나무
install.packages("rpart")
library(rpart)
#정지규칙 의사결정 
set.seed(seed = 1234)
fit1 <- rpart(PersonalLoan~., data = trainSet, control = rpart.control(minsplit = 20, cp = 0.01 , maxdepth = 10))
summary(fit1)
plot(fit1, compress =TRUE, uniform = TRUE, branch = 0.4, margin = 0.05)
text(fit1, use.n= TRUE , cex = 1.0, all = TRUE)

################################## better graph

install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(fit1 , type = 2 , extra = 104 , fallen.leaves =  F)

################################## 가지치기

printcp(fit1)
plotcp(fit1)

fit2 <- prune.rpart(tree = fit1, cp = 0.017)

printcp(fit2)

############## 정기규칙 변경 
set.seed(seed= 1234)
fit1 <- rpart(formula =  PersonalLoan~., data = trainSet, control = rpart.control(minsplit = 20, cp =0.001, maxdepth = 30))
summary(fit1)

printcp(fit1)
plotcp(fit1)
fit2 <- prune.rpart(fit1, cp = 0.0039)
printcp(fit2)
plotcp(fit2)


saveRDS(object = fit2 , file = 'fitDT.RDS')   #RDS 로 save
fit_test = readRDS('fitDT.RDS')     #읽기
summary(fit_test)
######## 

######################### 추정값 산출 관련 함수
pred1 <- predict(fit1, newdata = testSet, type = 'class')
pred2 <- predict(fit2, newdata = testSet, type = "class") 
real <- testSet$PersonalLoan
table(pred1)
table(pred2)
install.packages("caret")
library(caret)
confusionMatrix(data = pred1, reference = real, positive = "1")
confusionMatrix(data = pred2, reference = real, positive = "1")

printcp(fit1)
printcp(fit2)
install.packages("MLmetrics")
library(MLmetrics)
is.factor(pred1)
is.factor(real)
F1_Score(y_pred = pred1, y_true = real, positive = '1')
F1_Score(y_pred = pred2, y_true = real, positive = '1')
#역시 가지치기 한후 f1 스코어, 정확도 , 민감도, 정밀도 전부 나아진 형상 이다


######################## ROC 커브 모양/ 넓이 까지 구하기
install.packages("pROC")
library(pROC)

auc(response = as.numeric(real), predictor = as.numeric(pred1))

auc(response = as.numeric(real), predictor = as.numeric(pred2))


prediction(predictions = as.numeric(pred1), labels = as.numeric(real)) -> predobj

perform <- performance(prediction.obj = predobj , measure = 'tpr', x.measure = 'fpr')
plot(perform)
prediction(predictions = as.numeric(pred2), labels = as.numeric(real)) -> predobj2

perform <- performance(prediction.obj = predobj2 , measure = 'tpr', x.measure = 'fpr')
plot(perform)




