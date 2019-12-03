###Generating MVN random variables. Using Choleski. Example 1.  (Example in the notes)

mu=c(-2, 0, 5)  

mu 

Sigma= matrix(c( 1, 0.6, -0.9, 0.6, 1, -0.5, -0.9, -0.5, 1), ncol=3)  

Sigma  

eigen(Sigma)



## Generate one random vector from a normal distribution with that mu 

## and Sigma 



X1.t= rnorm(3)%*%chol(Sigma)+mu 

X1.t



## Now generate many mor, a whole matrix n by 3 



rmvn.Choleski = 
  
  function(n, mu, Sigma) {
    
    # generate n random vectors from MVN(mu, Sigma)
    
    # dimension is inferred from mu and Sigma
    
    d = length(mu)
    
    Q = chol(Sigma) # Choleski factorization of Sigma
    
    Z = matrix(rnorm(n*d), nrow=n, ncol=d)
    
    X = Z %*% Q + matrix(mu, n, d, byrow=TRUE)
    
    X
    
  }



#### Generate the random numbers. Give the function something to put in.



X=   rmvn.Choleski(200,mu,Sigma ) 

Sigma

head(X)  # to see the first MVN vectors (rows)











###Generating MVN random variables. Using Choleski. Example 2. 



#### Defining the parameters of the MVN



mu=c(5,10,15) 

mu    # see mu entered correctly

Sigma = matrix(c( 1, -0.5,0.5,-0.5,2,-0.5,0.5,-0.5,3), ncol=3) 

Sigma  # see Sigma entered correctly

eigen(Sigma)



#### Choleski function to generate MVN(mu, Sigma)

### A function is something you compile, but it gives nothing until executed. 

rmvn.Choleski = 
  
  function(n, mu, Sigma) {
    
    # generate n random vectors from MVN(mu, Sigma)
    
    # dimension is inferred from mu and Sigma
    
    d = length(mu)
    
    Q = chol(Sigma) # Choleski factorization of Sigma
    
    Z = matrix(rnorm(n*d), nrow=n, ncol=d)
    
    X = Z %*% Q + matrix(mu, n, d, byrow=TRUE)
    
    X
    
  }



#### Generate the random numbers. Give the function something to put in.



X=   rmvn.Choleski(200,mu,Sigma ) 

Sigma

head(X)  # to see the first MVN vectors (rows)



#### Pairs plot 





pairs(X,lower.panel=NULL, labels=c("X1","X2","X3"),   
      
      font.labels=2, cex.labels=4.5) 





#### Double check that the random numbers  are as desired

### i.e., check that the random sample resembles the 

### parent distribution. 



# The sample means and covariances should close to the

# entered vector mu and variance Sigma



cov(X)  # cov matrix of generated numbers

colMeans(X) # means of generated vectors. 



#Since they ask to see that correlations agree



cor(X)   # cor matrix of generated numbers







Last modified: Tuesday, 23 April 2019, 6:35 AM PDT
Jump to...