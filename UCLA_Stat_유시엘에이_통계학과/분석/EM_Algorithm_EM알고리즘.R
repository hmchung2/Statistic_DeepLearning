###################################################################
#                                          Daniel Chung           #
#                                          504132141              #
#                                           HW:8, Date:6/ 5/2019  #
#                                            Section: 1B          #
###################################################################

#######a.
pollen = c(rnorm(50,25,1),rnorm(50,30,2),rnorm(50,40,4))
length(pollen)

x = iris[,-5]  # deleting categorical variable

xc=scale(x, scale=F)   # centering 
sx=var(xc)
EP = eigen(sx)
V=EP$vectors                  #eigen vectors
Lambda= diag(EP$values)
Lambda                            # eigen values 

PC=xc%*%V                            
head(PC) # these are the principal componenets

PC1 = PC[,1]             # each column is one of pcs.
PC2 = PC[,2]
PC3 = PC[,3]
PC4 = PC[,4]

model = lm(formula = pollen~PC1+PC2+PC3+PC4)   # regression
summary(model)                                 # summary of regression


################ b.
cor(PC1, pollen)                   # getting correlation between PCs and pollen.
cor(PC2, pollen)
cor(PC3, pollen)
cor(PC4, pollen)


cor(PC1, pollen)^2                #   To compare all the coefficients we need to square them
cor(PC2, pollen)^2
cor(PC3, pollen)^2
cor(PC4, pollen)^2

                                  #  1 and 3 are the highest coefficients                                      

model2 = lm(formula = pollen ~ PC1+PC3)     
summary(model2)                      # new model

################# c.

install.packages("psych")    ## installing new package
library(psych)

re = principal(xc, nfactors = 4, rotate = "varimax")
re       # As you can see, high correlations between 3 variables except sepal width on both pc1 and pc3

biplot(re) # Please only look at the one between rc1 and rc3
          # Both PC 1 and PC3 have the similar weights on 3 variables except for sepal width
V              #this shows the eigen vectors


################ d.

f <- function(x,mu,sigma2){
  exp((-1/(2*sigma2))*sum((x-mu)^2))
  
}


EM_algorithm <- function(X,sigma2=1){
  n <- nrow(X)
  # Initialization 
  ## Setting initial alpha and mu values
  alpha <- matrix(rep(1/2,2),ncol=2) # probability of being located in each cluster is the same
  ### 
  ### Setting 2 distinct observations as the starting cluster centers
  ## and arranging each observation in a column. The way it is, we choose the 
  ## first two observations. 
  for (i in 2:nrow(X)){
    if(sum(X[1,]-X[i,])!=0 ) {
      mu <- matrix(c(X[1,],X[i,]),ncol = 2)
      break
    }else{
      if (i==ncol(X)) stop("All observations are the same")
    }
  }
  ##While indicator is different than pastindicator vector we will keep going
  indicator <- 1:nrow(X)
  pastIndicator <- nrow(X):1
  t <- 1 ## for storing values in the alpha matrix
  while(sum(pastIndicator!=indicator)!=0){
    pastIndicator <- indicator
    ## E-step 
    w1 <- apply(X,1,function(x){
      alpha[t,1]*f(x,as.numeric(mu[,1]),sigma2)
    })
    w2 <- apply(X,1,function(x){
      alpha[t,2]*f(x,as.numeric(mu[,2]),sigma2)
    })
    W <- cbind(w1,w2)
    W <- W/rowSums(W)
    ## Assigning observations to clusters based on weights
    indicator <- max.col(W)
    ## M-step updating the alphas 
    nk <- colSums(W)
    alpha <- rbind(alpha,nk/n)
    t <- t+1
    ## M step - updating the mus (1pt)
    temp1 <- (W[,1]*X)/nk[1]
    temp2 <- (W[,2]*X)/nk[2]
    mu[,1] <- colSums(temp1)
    mu[,2] <- colSums(temp2)
  }
  
  cat("The mu for the first cluster is (",as.numeric(mu[1,1]),",",as.numeric(mu[2,1]),")\n",sep = "")
  cat("The mu for the second cluster is (",as.numeric(mu[1,2]),",",as.numeric(mu[2,2]),")\n\n",sep = "")
  cat("The probability of being in the first cluster is ",alpha[t,1],"\n",sep = "")
  cat("The probability of being in the second cluster is ",alpha[t,2],"\n\n",sep = "")
  cat("The final allocation vector is given by\n",indicator,"\n\n",sep = "")
  cat("This algorithm took ",t," iterations\n",sep = "")
  indicator
}


iris_EM <- EM_algorithm(xc)

pc_iris = EM_algorithm(PC)

table(pc_iris,iris_EM)


# As you can see the table of comparing between PC and raw data using,
#em algorithm.

