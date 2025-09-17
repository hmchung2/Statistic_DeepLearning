
library(xlsx)
library(dplyr)

###################자전거 이용 정보 데이터를 갖고 온다
full_data = read.csv("full_data.csv")
head(full_data)

################## 전처리 과정 


full_data %>% group_by(bike) %>% summarise(time = sum(time), distance = sum(distance)) -> full_data_grouped
head(full_data_grouped)

################# 자전거 고장 데이터 정보를 갖고 온다

count <- read.csv("merged.csv",encoding = "EUC-KR")
head(count)


################# 전처리 과정 

names(count) = c('bike','repair','report')

final_data = merge(full_data_grouped,count, by= 'bike', all = T)
dim(final_data)
head(final_data)
write.csv(final_data, 'repair_final.csv',  row.names = F )

final_outer = read.csv('repair_final.csv')
head(final_outer)
final_outer$repair[is.na(final_outer$repair)] = 0  
final_outer$report[is.na(final_outer$report)] = 0 
final_outer$time %>% is.na() %>% table()
final_outer$distance %>% is.na() %>% table()


modified = final_outer[which(!is.na(final_outer$distance)),]
modified2 = modified


a = sample(1:31735,3000)

############ 군집분석 
scaled2 <- scale(modified2[,-1])
library(factoextra)
head(scaled2)
fit2 <- eclust(x =scaled2[a,], FUNcluster = 'kmeans', k = 2, hc_metric = 'euclidean', seed = 1234)
saveRDS(fit2, file = "fit2.rds")
#fit2 = readRDS(file = "fit2.rds")


########################  램 메모리가 바쳐주지 못하면 필요 없는 데이터는 지워야 한다.

.ls.objects <- function (pos = 1, pattern, order.by,
                         decreasing=FALSE, head=FALSE, n=5) {
  napply <- function(names, fn) sapply(names, function(x)
    fn(get(x, pos = pos)))
  names <- ls(pos = pos, pattern = pattern)
  obj.class <- napply(names, function(x) as.character(class(x))[1])
  obj.mode <- napply(names, mode)
  obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
  obj.prettysize <- napply(names, function(x) {
    capture.output(print(object.size(x), units = "auto")) })
  obj.size <- napply(names, object.size)
  obj.dim <- t(napply(names, function(x)
    as.numeric(dim(x))[1:2]))
  vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
  obj.dim[vec, 1] <- napply(names, length)[vec]
  out <- data.frame(obj.type, obj.size, obj.prettysize, obj.dim)
  names(out) <- c("Type", "Size", "PrettySize", "Rows", "Columns")
  if (!missing(order.by))
    out <- out[order(out[[order.by]], decreasing=decreasing), ]
  if (head)
    out <- head(out, n)
  out
}

lsos <- function(..., n=10) {
  .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}

lsos()
rm(full_data)
####################################


grouped2 = data.frame(modified2[a,],cluster = fit2$cluster)
summary(grouped2[grouped2$cluster == 1,-1])
summary(grouped2[grouped2$cluster == 2,-1])

##############회귀 모형

library(tree)
library(rpart)
fitpart2 <- rpart(formula=  report~ distance+time, data = grouped2, control = rpart.control(minsplit = 20, cp = 0.01, maxdepth = 10))
fitTree <- tree(formula = report ~ distance + time, data = grouped2)
summary(fitTree)
plot(fitpart2)
text(fitpart2)

deciles <- quantile(x = grouped2$report , probs = seq(from = 0.5 , to = 1 , length.out = 4))
deciles
grade <- cut(x = grouped2$report , breaks = deciles  ,include.lowest = T)
table(grade)
plot(x = grouped2$distance, y = grouped2$time, col = grey(level=seq(from = 1 , to = 0.5, length.out = 4 ))[grade],
     pch =20,
     xlab = '이동거리',
     ylab = '이용시간')
partition.tree(tree = fitTree,
               ordvars = c('distance','time'),
               col = 'red',
               cex = 0.8,
               font = 2,
               add = T)


library(rpart.plot)
rpart.plot(x = fitpart2, type = 1 , fallen.leaves = FALSE)
str(grouped2)
model_fix = lm(repair ~ time * distance, data = grouped2)
summary(model_fix)
grouped2 %>% dim()

################## 회귀 분석도 해주어서 의미가 유효성이 없다는걸 증명한다.
set.seed(seed=1238)
a = sample(1:nrow(grouped2), 100 ,replace=F)
model_fix = lm(repair ~ time * distance, data = grouped2[a,])
summary(model_fix)

################# distance 의 문제점 
a = density(grouped2$distance)
plot(a, xlim =c(0,6000000))
max(grouped2$distance) 
b = density(grouped2$time)
plot(b)
boxplot(grouped2$distance)
outlier_values <- boxplot.stats(grouped2$distance)$out  # outlier values
outlier_values
min(outlier_values)

############################ 아웃라이어 빼고 다시 지역모형 회귀나무


grouped3 = grouped2[grouped2$distance < min(outlier_values),]
dim(grouped3)  ############ 고작 100개 차이


which(grouped3$report != 0) %>% length()
which(grouped3$report == 0) %>% length()
library(tree)
fitTree <- tree(formula = report ~ distance + time, data = grouped3)

str(grouped2)
plot(fitTree)
text(fitTree)
deciles <- quantile(x = grouped3$report , probs = seq(from = 0.5 , to = 1 , length.out = 5))
deciles
grade <- cut(x = grouped3$report , breaks = deciles  ,include.lowest = T)
grade
plot(x = grouped3$distance, y = grouped3$time, col = grey(level=seq(from = 1 , to = 0.5, length.out = 4 ))[grade],
     pch =20,
     xlab = '이동거리',
     ylab = '이용시간',
     main = '신고 횟수 회귀나무')
partition.tree(tree = fitTree,
               ordvars = c('distance','time'),
               col = 'red',
               cex = 2,
               font = 6,
               add = T)
###############################   군집 분석이랑 회귀나무랑 동시에 ggplot을 이용해서 시각화를 한다. 
library(ggplot2)

gg.partition.tree <- function (tree, label = "yval", ordvars, ...) 
{
  ptXlines <- function(x, v, xrange, xcoord = NULL, ycoord = NULL, 
                       tvar, i = 1L) {
    if (v[i] == "<leaf>") {
      y1 <- (xrange[1L] + xrange[3L])/2
      y2 <- (xrange[2L] + xrange[4L])/2
      return(list(xcoord = xcoord, ycoord = c(ycoord, y1, 
                                              y2), i = i))
    }
    if (v[i] == tvar[1L]) {
      xcoord <- c(xcoord, x[i], xrange[2L], x[i], xrange[4L])
      xr <- xrange
      xr[3L] <- x[i]
      ll2 <- Recall(x, v, xr, xcoord, ycoord, tvar, i + 
                      1L)
      xr <- xrange
      xr[1L] <- x[i]
      return(Recall(x, v, xr, ll2$xcoord, ll2$ycoord, tvar, 
                    ll2$i + 1L))
    }
    else if (v[i] == tvar[2L]) {
      xcoord <- c(xcoord, xrange[1L], x[i], xrange[3L], 
                  x[i])
      xr <- xrange
      xr[4L] <- x[i]
      ll2 <- Recall(x, v, xr, xcoord, ycoord, tvar, i + 
                      1L)
      xr <- xrange
      xr[2L] <- x[i]
      return(Recall(x, v, xr, ll2$xcoord, ll2$ycoord, tvar, 
                    ll2$i + 1L))
    }
    else stop("wrong variable numbers in tree.")
  }
  if (inherits(tree, "singlenode")) 
    stop("cannot plot singlenode tree")
  if (!inherits(tree, "tree")) 
    stop("not legitimate tree")
  frame <- tree$frame
  leaves <- frame$var == "<leaf>"
  var <- unique(as.character(frame$var[!leaves]))
  if (length(var) > 2L || length(var) < 1L) 
    stop("tree can only have one or two predictors")
  nlevels <- sapply(attr(tree, "xlevels"), length)
  if (any(nlevels[var] > 0L)) 
    stop("tree can only have continuous predictors")
  x <- rep(NA, length(leaves))
  x[!leaves] <- as.double(substring(frame$splits[!leaves, "cutleft"], 
                                    2L, 100L))
  m <- model.frame(tree)
  if (length(var) == 1L) {
    x <- sort(c(range(m[[var]]), x[!leaves]))
    if (is.null(attr(tree, "ylevels"))) 
      y <- frame$yval[leaves]
    else y <- frame$yprob[, 1L]
    y <- c(y, y[length(y)])
    if (add) 
      lines(x, y, type = "s", ...)
    else {
      a <- attributes(attr(m, "terms"))
      yvar <- as.character(a$variables[1 + a$response])
      xo <- m[[yvar]]
      if (is.factor(xo)) 
        ylim <- c(0, 1)
      else ylim <- range(xo)
      plot(x, y, ylab = yvar, xlab = var, type = "s", ylim = ylim, 
           xaxs = "i", ...)
    }
    invisible(list(x = x, y = y))
  }
  else {
    if (!missing(ordvars)) {
      ind <- match(var, ordvars)
      if (any(is.na(ind))) 
        stop("unmatched names in vars")
      var <- ordvars[sort(ind)]
    }
    lab <- frame$yval[leaves]
    if (is.null(frame$yprob)) 
      lab <- format(signif(lab, 3L))
    else if (match(label, attr(tree, "ylevels"), nomatch = 0L)) 
      lab <- format(signif(frame$yprob[leaves, label], 
                           3L))
    rx <- range(m[[var[1L]]])
    rx <- rx + c(-0.025, 0.025) * diff(rx)
    rz <- range(m[[var[2L]]])
    rz <- rz + c(-0.025, 0.025) * diff(rz)
    xrange <- c(rx, rz)[c(1, 3, 2, 4)]
    xcoord <- NULL
    ycoord <- NULL
    xy <- ptXlines(x, frame$var, xrange, xcoord, ycoord, 
                   var)
    xx <- matrix(xy$xcoord, nrow = 4L)
    yy <- matrix(xy$ycoord, nrow = 2L)
    return(
      list(
        annotate(geom="segment", x=xx[1L, ], y=xx[2L, ], xend=xx[3L, ], yend=xx[4L, ]),
        annotate(geom="text", x=yy[1L, ], y=yy[2L, ], label=as.character(lab), ...)
      )
    )
  }
}
names(grouped3)
grouped4 <- data.frame(grouped3 , = as.factor(grouped3$cluster))
head(grouped4)
str(grouped3)

ggplot(grouped4, 
       aes(distance, time, group=그룹)) + 
  geom_point(aes(color = 그룹)) +ggtitle("신고 횟수 회귀나무") + xlab("이동거리") + ylab("이용시간")
gg.partition.tree(tree(report ~ distance + time, data=grouped4),
                  label="cluster",size = 1, color = "green4", cex = 7)


head(grouped4)
