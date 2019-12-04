#the observed sample
x = c(0.04304550,0.50263474)
#the function containing the formula for the negative log likelihood
mlogL = function(theta){
  return(-(length(x)*log(theta) - theta*sum(x)))
}
# Finding numerically the MLE and using fisher information to compute standard error
fit =nlm(mlogL,p=1, hessian=T) # need p=initial value for parameter theta.
fit # view summary of results
hat.theta=fit$estimate # extract the estimate of theta
hat.theta
hessian=fit$hessian # extract negative of second derivative = I

se= sqrt(1/fit$hessian) # extract the standard error of the estimate.
se
fit
d = matrix(c(8,0,0,2),ncol = 2)
solve(d)
