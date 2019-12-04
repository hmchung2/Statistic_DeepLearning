############# Daniel Chung

############ 504132141



data1 = read.csv("http://www.stat.ucla.edu/~jsanchez/stat102b/butterflies.csv")
dim(data1)

distances = dist(scale(data1[,-1], scale = F), method = "euclidean", diag = TRUE, upper = TRUE, p =2) 



# Converts dataframe into a square matrix

bt.mat <- as.matrix(distances) 

dim(bt.mat)

colnames(bt.mat) = data1[,1]

rownames(bt.mat) <- colnames(bt.mat)

bt.mat

# It is preferable to convert the square matrix into a dist class matrix (lower diagonal)



dist.bt <- as.dist(bt.mat)

dist.bt                       # Table 11.5

# Running classic metric multidimensional scaling first (Principal Coordinate Analysis),

# as described on page 210. The stress function is created here (stress.fun) 

# in order to compute the stress for each dimension (k=2,3,4).

stress.fun <- function(datadist,fitteddist) {
  
  
  
  sqrt(sum((datadist-fitteddist)^2)/sum(datadist^2))
  
  
  
}



MDSdim2Vote.cmd <- cmdscale(dist.bt, eig=TRUE, k=2)



(stress.2d.cmd <- stress.fun(dist.bt,dist(MDSdim2Vote.cmd$points)))



MDSdim3Vote.cmd <- cmdscale(dist.bt, eig=TRUE, k=3)



(stress.3d.cmd <- stress.fun(dist.bt,dist(MDSdim3Vote.cmd$points)))



MDSdim4Vote.cmd <- cmdscale(dist.bt, eig=TRUE, k=4)



(stress.4d.cmd <- stress.fun(dist.bt,dist(MDSdim4Vote.cmd$points)))



#



# We run non metric multidimensional scaling with isoMDS from package MASS



# Defaults for the number of iterations and tolerance are used



# Before running library(MASS) make sure you have installed the package


install.packages("MASS")
library(MASS)



MDSdim2Vote.iso <- isoMDS(dist.bt)        # k=2



MDSdim3Vote.iso <- isoMDS(dist.bt, k=3)



MDSdim4Vote.iso <- isoMDS(dist.bt, k=4)



# Remark: the configuration produced by isoMDS is only determined up to rotations 



# and reflections. Thus, the result can vary considerably from machine to machine



# This explains why the stress in three dimensions and plots do not match 



# exactly the results given in Example 11.2



#



# Plots similar to those shown in Figure 11.5 are displayed as two separate plots



# Dimension 1 vs Dimension 2





plot(MDSdim3Vote.iso$points[,1],MDSdim3Vote.iso$points[,2], pch=16, col="blue", ylim=c(-25,45),
     
     
     
     xlab="Dimension 1",ylab="Dimension 2",
     
     
     
     main="isoMDS function")



text(MDSdim3Vote.iso$points[,1],MDSdim3Vote.iso$points[,2],
     
     
     
     labels=rownames(MDSdim3Vote.iso$points), cex=0.7, pos=3)



abline(h=0)



abline(v=0)



# Dimension 1 vs Dimension 3



dev.new()



plot(MDSdim3Vote.iso$points[,1],MDSdim3Vote.iso$points[,3], pch=16, col="blue",
     
     
     
     xlab="Dimension 1",ylab="Dimension 3",
     
     
     
     main="isoMDS function")



text(MDSdim3Vote.iso$points[,1],MDSdim3Vote.iso$points[,3],
     
     
     
     labels=rownames(MDSdim3Vote.iso$points), cex=0.7, pos=3)



abline(h=0)



abline(v=0)



# Producing a Shepard plot



MDS2Voteiso.Shep <- Shepard(dist.bt,MDSdim3Vote.iso$points, p=3)



dev.new()



plot(MDS2Voteiso.Shep$yf,MDS2Voteiso.Shep$x, pch = 15,cex=0.7,
     
     
     
     xlab="Configuration Distance",ylab="Data Dissimilarities",main="Shepard plot")



lines(MDS2Voteiso.Shep$yf,MDS2Voteiso.Shep$x, type = "S",col="red")

data1

data1[c(16,3),]

cat("To interpret dimension 1 first graph, we need to look at GL adn WSB since they are at each end. As you can see above, there is huge difference in Altitude and minmum temperature between GL and WSB")

data1[c(8,9,10,12),]

cat(" For interpretation of dimension 2, we will look at UO, LO, DP,MC, because these 4 represent the each end of dimension 2 and it seems that each data in the same end have some common. Especially, they have big difference in altitude again but also in PFPgi0.40 variable")

cat("For dimension 3, it looks almost the same except it is upside down, for example MC DP data are at the opposite end and vice versa")

cat("Finally, the last graph shows a plot of the distances between the data for the original data wuth configuration. This informs us how 3 dimensional plots fits data. However it does not keep increses")

cat("But instead, it increases time to time, showing discreteness in the data. Maybe it indicates our variables are more discrete")

