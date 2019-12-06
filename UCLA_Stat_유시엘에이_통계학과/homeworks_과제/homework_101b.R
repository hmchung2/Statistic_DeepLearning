### Daniel Chung
### 504132141

#######(a)
install.packages("mice")
install.packages("VIM")
install.packages("lattice")
install.packages("ggplot2")
require(mice)
require(VIM) 
require(lattice)
require(ggplot2)
missdata1=read.csv("http://www.stat.ucla.edu/~jsanchez/stat102b/missdata1.csv",header=T)
head(missdata1)
set.seed(20032005)
#######(b)
md.pattern(missdata1)
cat("There are  54%  rows with missing values of at least one variable (13/24)")

########(c)
aggr(missdata1)
marginplot(missdata1[c(1,2)], col=c("blue","red","orange"))
marginplot(missdata1[c(1,3)], col=c("blue","red","orange"))
marginplot(missdata1[c(1,4)], col=c("blue","red","orange"))
marginplot(missdata1[c(1,5)], col=c("blue","red","orange"))
marginplot(missdata1[c(2,3)], col=c("blue","red","orange"))
marginplot(missdata1[c(2,4)], col=c("blue","red","orange"))
marginplot(missdata1[c(2,5)], col=c("blue","red","orange"))
marginplot(missdata1[c(3,4)], col=c("blue","red","orange"))
marginplot(missdata1[c(3,5)], col=c("blue","red","orange"))
marginplot(missdata1[c(4,5)], col=c("blue","red","orange"))
pbox(missdata1,pos=1)
pbox(missdata1,pos=2)
pbox(missdata1,pos=3)
pbox(missdata1,pos=4)
pbox(missdata1,pos=5)
cat(" I conclude none of the missing variables are due to mcar, since all marginplots did not show identical length of bars.")
cat(" However, pbox at position 4 showed non overlapping bars, therefore missing values of x3 mightbe due to mar")
cat("also aggr function shows that x8 has the highest number of missing values")

##### (d)

imp.missdata1=mice(missdata1,m=10)

imp.missdata1
cat("there are ones everywhere, so for each variable, all other variables were used to create predicted values")

######(e)

summary(imp.missdata1$imp$y[1]) # summary of the imputed values 
summary(missdata1[,1])   # summary of the nonmissing observations 
cat("they are very different in mean and max")

summary(imp.missdata1$imp$x1[1]) # summary of the imputed values 
summary(missdata1[,2])   # summary of the nonmissing observations 
cat("the range decreased so much")

summary(imp.missdata1$imp$x3[1]) # summary of the imputed values 
summary(missdata1[,3])   # summary of the nonmissing observations 
cat("they are similar")

summary(imp.missdata1$imp$x4[1]) # summary of the imputed values 
summary(missdata1[,4])   # summary of the nonmissing observations 
cat("they are similar")

summary(imp.missdata1$imp$x8[1]) # summary of the imputed values 
summary(missdata1[,5])   # summary of the nonmissing observations 
cat("they are similar")


#######(f)
imp.missdata1$imp$x8[8]
cat("the imputed values are 54 32 23 50 22" )

#######(g)

imp.missdata1.totalplusours= complete(imp.missdata1,"long",inc=TRUE)

imp.missdata1.totalplusours

#######(h)

fifthcopy= complete(imp.missdata1,5)
fifthcopy
model5=lm(y ~ x1+x3+x4+x8, data=fifthcopy)
summary(model5)

eithcopy = complete(imp.missdata1,8)
eithcopy
model8 = lm(y ~ x1+x3+x4+x8, data = eithcopy)
summary(model8)
###(i)

fit.original= lm(y ~ x1+x3+x4+x8, data=missdata1) # for original data set
fitmodel=with(imp.missdata1, lm(y ~ x1+x3+x4+x8)) # for all copies 
summary(fitmodel)

####(j)

pooled=pool(fitmodel)
summary(pooled)
cat("the standard error of fitmodel with imputed data decreased little bit, which might be due to impuation. However, there is no big difference, so the imputation method was not bad")

####(k)
#THe equation is total variance = variance between + variance within + (variance between/m)
m = 10
k = 5
coef_matrix = se_matrix = matrix(rep(0,m*k),nrow = m)
coef_matrix
for(i in 1:m){
  coef_matrix[i,] = coef(summary(fitmodel$analyses[[i]]))[,1]
  se_matrix[i,] = coef(summary(fitmodel$analyses[[i]]))[,2]
}
V_T = rep(0,k)
for(j in 1:k){
  V_B = var(coef_matrix[,j])
  V_W = mean(se_matrix[,j]^2)
  V_T[j] = V_B+V_W+(V_B/m)
}     
V_T

