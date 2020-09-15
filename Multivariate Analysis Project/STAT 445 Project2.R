# Q1 (c). we simulate 3000 pairs.
# Hypothesis: we hypothesize the (X1, X2) is not bivariate normal where X1 ~ N(O,1)and X2 = -X1, if |X_1| <= 1; otherwise equal.
# Methodology: we will use scatterplot to visualize if the 3000 simulated pairs will form ellipsoid data cloud.
# Results: the scattplot appears to be a cross that is not an ellipse shape at all.
# Conclusion: The hypothesis is true; that is, (X1, X2) are not jointly normally distributed.

# R code:
library(MASS)
simulate = function(n=3000,mu=0,sigma=1){
  x1 = rnorm(n, mu, sigma)
  x2 = rep(0,n)
  for(i in 1:n){
    if (abs(x1[i]) <= 1) x2[i] = -x1[i] else x2[i] = x1[i]
  }
  par(mfrow=c(1,2))
  qqnorm(x2) 
  qqline(x2)
  plot(x1,x2) 
}
simulate()

# Q2
fat = read.table("fat_dat.txt", header = FALSE)
fat = fat[,-1]
fat.b = fat [,"V2"]
fat.s = fat [,"V3"]

# (a)
fat.mean = apply(fat,2,mean)[1:2]
fat.mean
fat.cov = cov(fat[1:2])
fat.cov
(251/252)*fat.cov
fat

# (b)
library(mvtnorm)
par(mfrow=c(1,1))
dataplot = cbind(x=rep(seq(-4,44,0.1), rep(481, 481)), y=rep(seq(-4,44,0.1), 481))
data = matrix(dmvnorm(dataplot, mean = fat.mean,sigma = (251/252)*fat.cov), ncol = 481, byrow = T)
persp(seq(-4,44,0.1), seq(-4,44,0.1), data,theta = 30, phi= 30, r = 20, expand = 0.5)

#c)
contour(seq(-4,44,0.1), seq(-4,44,0.1), data)

# Q3
circumf = fat [,9:18]
p = dim(circumf)[2]
n = dim(circumf)[1]
xbar = apply(circumf, 2, mean)
S    = var(circumf)
dj2 = apply(circumf,1, function(x, mu, sigma)(x-mu) %*% solve(sigma) %*% (x-mu),xbar,S)
dj2order = sort(dj2)
qchi = qchisq((1:n - 0.5)/n, df = p)
plot(dj2order, qchi, xlim = c(0, 30), ylim = c(0, 30), 
     xlab = expression(d[(j)]^2), ylab = expression(q[j]),
     main = "Q-Q plot")
abline(0,1)

#From the q-q plot, as the line does not fix the points, which means the derivation of the line petty large, 
#the data does not suggest a 10-dimensional multivariate normal distribution.


