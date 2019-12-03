house <- read.table(file='https://goo.gl/jsvkYS', header = TRUE)
str(house)

library(tidyverse)
library(caret)


################# 그룹핑
set.seed(see=1234)
index <- sample(x=1:2, size = nrow(x= house), prob = c(0.7,0.3),replace = TRUE)
trainSet <- house[index == 1 , ]
testSet <- house[index == 2 , ]

trainSet$MedianHouseValue %>% mean()
testSet$MedianHouseValue %>% mean()

library(randomForest)
set.seed(seed=1234)
fitRFR <- randomForest(x = trainSet[,-1],
                       y = trainSet[,1],
                       xtest = testSet[,-1],
                       ytest = testSet[,1],
                       ntree = 100,
                       mtry = 3,
                       importance = T ,
                       do.trace = 50,
                       keep.forest = T
                       )
plot(fitRFR)
importance(fitRFR)
varImpPlot(fitRFR)

fitRFR %>% treesize(terminal = T) %>%  hist()

pred <- predict(object = fitRFR, newdata = testSet, type = 'response')
pred %>% mean()
pred <-fitRFR$test$predicted
pred %>% mean()
real <- testSet$MedianHouseValue

error <- real - pred
error^2 %>% mean() %>% sqrt()

plot(x = real, y = pred)


############# 그냥 리니어 리그레션
full <- lm(formula = MedianHouseValue ~., data = trainSet)
summary(full)
#install.packages("DAAG")
library(DAAG)
vif(full)
null <- lm(formula = MedianHouseValue ~1, data = trainSet)
fitStep <- step(object = null, scope = list(lower = null, upper = full),direction = 'both')
vif(fitStep)
summary(fitStep)
############# 10 넘어 가는거 다지워 - 넘어가는거 없을 때 까지 계속 만들고 파이널 모델 만들기

########### save

saveRDS(object = fitRFR, file = "fitRFR.RDS")




