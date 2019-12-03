
####################### Daniel Chung
###################### 504132141
data=read.csv("http://www.stat.ucla.edu/~jsanchez/stat102b/bp.csv",header=T) 

#########(a)

reg <- lm( time~ bp + dose , data=data)
summary(reg) 
cat("I got 0.1545 for r squared and it decreases by 0.6882 per every bp and increases 17.4 for every dose")

###########(b)
library(mice)
library(VIM)
library(lattice)
library(ggplot2)
md.pattern(data)
p <- md.pairs(data)
p
imp1 <- mice(data, m = 10)
imp1

fitreg <- with(imp1, lm(time ~ bp + dose))
summary(fitreg)
pool(fitreg)
summary(pool(fitreg))

##############(c)
summary(reg)
summary(pool(fitreg))

cat("I think the new pooled data greatly reprsents the data")
cat("the standrd errors, means, intercepts and almost everything are similar between these two summaries ")



