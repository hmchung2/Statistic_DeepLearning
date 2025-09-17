### Daniel Chung
### 504132141
### question 2

##############(a)
install.packages("mice")
install.packages("VIM")
install.packages("lattice")
install.packages("ggplot2")
require(mice)
require(VIM) 
require(lattice)
require(ggplot2)

missdata2=read.csv("http://www.stat.ucla.edu/~jsanchez/stat102b/missdata2.csv",header=T)
head(missdata2)
set.seed(21302009)

################(b)

md.pattern(missdata2)
226/ (226+280)
cat("There are  44.6%  rows with missing values of at least one variable (13/24)")

###############(c)

aggr(missdata2)
marginplot(missdata2[c(1,2)], col=c("blue","red","orange")) # very different length
marginplot(missdata2[c(1,3)], col=c("blue","red","orange"))
marginplot(missdata2[c(1,4)], col=c("blue","red","orange"))
marginplot(missdata2[c(1,5)], col=c("blue","red","orange"))
marginplot(missdata2[c(1,6)], col=c("blue","red","orange"))
marginplot(missdata2[c(2,3)], col=c("blue","red","orange"))
marginplot(missdata2[c(2,4)], col=c("blue","red","orange"))
marginplot(missdata2[c(2,5)], col=c("blue","red","orange")) #very different length
marginplot(missdata2[c(2,6)], col=c("blue","red","orange")) # very different length
marginplot(missdata2[c(3,4)], col=c("blue","red","orange"))  # very different length
marginplot(missdata2[c(3,5)], col=c("blue","red","orange"))
marginplot(missdata2[c(3,6)], col=c("blue","red","orange"))
marginplot(missdata2[c(4,5)], col=c("blue","red","orange"))
marginplot(missdata2[c(4,6)], col=c("blue","red","orange"))
marginplot(missdata2[c(5,6)], col=c("blue","red","orange"))
pbox(missdata2,pos=1)
pbox(missdata2,pos=2)
pbox(missdata2,pos=3)
pbox(missdata2,pos=4)
pbox(missdata2,pos=5)
pbox(missdata2,pos=6)

cat("distempl variable had the highest number of missing values")
cat("marginal plots showed some of bars have significantly different lengths, which indicate some of them are not due to mcar")
cat("almost all pboxplots overlapped, so the missing values are not due to mar")

############(d)

imp.missdata2=mice(missdata2,m=10)
imp.missdata2

cat("for each variable, they used all other variables to make prediction. (It is all 1s)")

############(e)
head(missdata2)
summary(imp.missdata2$imp$MedianValue[1]) # summary of the imputed values 
summary(missdata2[,1])   # summary of the nonmissing observations 
cat("they are similar")

summary(imp.missdata2$imp$Crime[1]) # summary of the imputed values 
summary(missdata2[,2])   # summary of the nonmissing observations 
cat("they are very similar")

summary(imp.missdata2$imp$Rooms[1]) # summary of the imputed values 
summary(missdata2[,3])   # summary of the nonmissing observations 
cat("they are very similar")

summary(imp.missdata2$imp$Bef__1940[1]) # summary of the imputed values 
summary(missdata2[,4])   # summary of the nonmissing observations 
cat("they are similar except minion")

summary(imp.missdata2$imp$DistEmpl[1]) # summary of the imputed values 
summary(missdata2[,5])   # summary of the nonmissing observations 
cat("they are very similar")

summary(imp.missdata2$imp$LowStatus[1]) # summary of the imputed values 
summary(missdata2[,6])   # summary of the nonmissing observations 
cat("median and mean are little off")

###############(f)

imp.missdata2$imp$LowStatus[8]
cat(imp.missdata2$imp$LowStatus$`8`)

##############(g)

imp.missdata2.totalplusours= complete(imp.missdata2,"long",inc=TRUE)
imp.missdata2.totalplusours

###############(h)

fifthcopy2= complete(imp.missdata2,5)
fifthcopy2
model52=lm(MedianValue ~ Crime+Rooms+Bef__1940+DistEmpl+LowStatus, data=fifthcopy2)
summary(model52)

eithcopy2 = complete(imp.missdata2,8)
eithcopy2
model82 = lm(MedianValue ~ Crime+Rooms+Bef__1940+DistEmpl+LowStatus, data=eithcopy2)
summary(model82)

###############(i)

fit.original2= lm(MedianValue ~ Crime+Rooms+Bef__1940+DistEmpl+LowStatus, data=missdata2) # for original data set
fitmodel2=with(imp.missdata2, lm(MedianValue ~ Crime+Rooms+Bef__1940+DistEmpl+LowStatus)) # for all copies 
summary(fitmodel2)

###############(j)

pooled2=pool(fitmodel2)
summary(pooled2)
cat("the standard error of fitmodel with imputed data decreased.")

#############(k)

#THe equation is total variance = variance between + variance within + (variance between/m)
m = 10
k = 6
coef_matrix = se_matrix = matrix(rep(0,m*k),nrow = m)
coef_matrix
for(i in 1:m){
  coef_matrix[i,] = coef(summary(fitmodel2$analyses[[i]]))[,1]
  se_matrix[i,] = coef(summary(fitmodel2$analyses[[i]]))[,2]
}
V_T = rep(0,k)
for(j in 1:k){
  V_B = var(coef_matrix[,j])
  V_W = mean(se_matrix[,j]^2)
  V_T[j] = V_B+V_W+(V_B/m)
}     
V_T

###########(l)
stripplot(imp.missdata2, pch = 20, cex = 1.2)

cat("i think plot works and shows us many information. Observed rates and missing rates are cleary visible and can find the pattern between variables")

