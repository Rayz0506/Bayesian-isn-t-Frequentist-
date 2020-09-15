#STAT445 Assignment 1
#Guangji Zou (Ray)
#Student ID:301216239

#1 c)
a=eigen(matrix(c(25,-2,4,-2,4,1,4,1,9),3,3))
a
# d)
a=matrix(c(25,-2,4,-2,4,1,4,1,9),3,3)
e=eigen(a)
evector=e$vectors
transpose=t(evector)
evalue=e$values
ediagonal=diag(sqrt(evalue))
squareroot=evector*ediagonal*transpose
squareroot

#2
morph=read.csv('morph.data.csv',header=TRUE)[, -1]
morph = as.matrix(morph)
dim(morph) 
head(morph)
n = dim(morph)[1]
# Mean of each variable
Xbar = apply(morph, 2, mean)

# Calculate the sample covariance matrix
S1 = 1/(n-1)*(morph[1,] - Xbar)%*%t(morph[1,] - Xbar)
for(i in 2:n)
{
  S1 = S1 + 1/(n-1)*as.matrix(morph[i,] - Xbar)%*%t(morph[i,] - Xbar)
}

Vtilde1 = diag(diag(S1))
R1 = diag(1/sqrt(diag(Vtilde1)))%*%S1%*%diag(1/sqrt(diag(Vtilde1)))
S2 = cov(morph)
R2 = cor(morph)
Vtilde2 = diag(diag(S2))

#Find eigenvalues and eigenvectors of the sample covariance matrix and those of the sample correlation matrix
samplecovariance=eigen(S2)
S2
samplecorrelation=eigen(R2)
R2

# The covariance and correlation matrices lead to the not same eigenvalues and eigenvectors
# because row and sigma are different lead to they are not same

#Find the square-root matrix
e=eigen(S2)
evector=e$vectors
transpose=t(evector)
evalue=e$values
ediagonal=diag(sqrt(evalue))
squareroot=evector*ediagonal*transpose
squareroot
eigen(cov(morph))$values
round(eigen(cov(morph))$values,4)

#4
library(ellipse)
mu    = c(3, 2)
sigma = matrix(c(5,4,4,5),2,2)

# try different value for t and see what is the corresponding value for c2
eps = ellipse(x = sigma, centre = mu, t = 0.5,
              xlim = c(-10, 10), ylim = c(-10, 10))
c_fun = function(x){t(x - mu)%*%solve(sigma)%*%(x - mu)}
(c2    = apply(eps, 1, c_fun))
plot(eps, type = "l")

# high correlation
sigma = matrix(c(5,-4,-4,5),2,2)
t = 2
eps = ellipse(x = sigma, centre = mu, t = 2, 
              xlim = c(-10, 10), ylim = c(-10, 10))
plot(eps, type = "l")

# small correlation
sigma = matrix(c(3,0,0,3),2,2)
t = 2
eps = ellipse(x = sigma, centre = mu, t = 2, 
              xlim = c(-10, 10), ylim = c(-10, 10))
lines(eps)

#5
#a)
morph=read.csv('morph.data.csv',header=TRUE)[, -1]
mean=rowMeans(morph)
mean
samplemean=mean(mean)
samplemean
sample_variance=var(mean)
sample_variance
#b)
measure=morph[,1]
measure
difference=measure-mean
difference
difference_mean=mean(difference)
difference_mean
difference_variance=var(difference)
difference_variance
