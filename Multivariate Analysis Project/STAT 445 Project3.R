# Q1.
fat = read.table("fat_dat.txt", header = FALSE)
fat = fat[,-1] 
circumf = fat[,9:18] 
circum_mean = apply(circumf,2,mean)
circum_cov = cov(circumf)
n = 252

#(a)
cbind(circum_mean - sqrt(qchisq(0.95,10))*as.vector(sqrt(diag(circum_cov)/n)), circum_mean + sqrt(qchisq(0.95,10))*as.vector(sqrt(diag(circum_cov)/n)))

#(b)
A = rbind(c(0,1,rep(0,8)),c(0,0,1,rep(0,7)))
cbar = A%*%circum_mean
CS = A%*%circum_cov%*%t(A)
qchisq(0.95,2)

library(ellipse)
out = ellipse(CS/n, centre=cbar, t =sqrt(qchisq(0.95,2)))
plot(out, type="l" , xlab="Chest Circumference", ylab="Abdomen Circumference", main="95% Simultaneous Confidence Region")

#(c)
cbind(circum_mean - qnorm(1-0.05/20)*as.vector(sqrt(diag(circum_cov)/252)), circum_mean + qnorm(1-0.05/20)*as.vector(sqrt(diag(circum_cov)/252)) )

#(d)
cbind(cbar - qnorm(1-0.05/20)*as.vector(sqrt(diag(CS)/252)), cbar + qnorm(1-0.05/20)*as.vector(sqrt(diag(CS)/252)) )

plot(ellipse(CS/262, centre=cbar, t =sqrt(qchisq(0.95,10))), type="l" , xlab="Chest Circumference", ylab="Abdomen Circumference", main="95% Simultaneous Confidence Region versus Bonferroni Confidence Rectangle")
abline(v=c(99.33347, 102.31494),lty=2)
abline(h=c(90.64922, 94.46269),lty=3)

#(e)
a = c(0,1,-1,rep(0,7))
c(a%*%circum_mean - qnorm(1-0.05/22)*sqrt((a%*%circum_cov%*%a)/252), a%*%circum_mean + qnorm(1-0.05/22)*sqrt((a%*%circum_cov%*%a)/252) )

#Q2 a)
amit = read.table("T7-6.DAT")
y1 = amit[,1] 
z1 = amit[,3] 
z2 = amit[,4]
z3 = amit[,5] 
z4 = amit[,6] 
z5 = amit[,7]

linear1 = lm(y1 ~ z1 + z2 + z3 + z4 + z5)
summary(linear1)

#(ii)
res1 = resid(linear1)
fit1 = fitted(linear1)
par(mfrow=c(2,2))
plot(c(1:17),res1, main="Fig 6(a)")
abline(h=0,col="red")
plot(fit1,res1, main="Fig 6(b)")
abline(h=0,col="red")
qqnorm(res1, main="Fig 6(c): TOT")
qqline(res1)

#(iii)
new.z = data.frame(z1=1, z2=1200, z3=140, z4=70, z5=85)
predict(linear1,new.z, interval="prediction", level=0.95, type="response")

#(b)
#(i) 
y2=amit[,2] 
linear2 = lm(y2 ~ z1 + z2 + z3 + z4 + z5)
summary(linear2)

#(ii)
res2 = resid(linear2)
fit2 = fitted(linear2)
par(mfrow=c(2,2))
plot(c(1:17),res1, main="Fig 7(a)")
abline(h=0,col="red")
plot(fit2,res2, main="Fig 7(b)")
abline(h=0,col="red")
qqnorm(res2, main="Fig 7(c): AMI")
qqline(res2)

#(iii)
new.z = data.frame(z1=1, z2=1200, z3=140, z4=70, z5=85) 
predict(linear2,new.z, interval="prediction", level=0.95, type="response")

#(c)
#(i) 
amit = as.matrix(amit)
linear3 = lm(amit[,1:2] ~ amit[,3] + amit[,4] + amit[,5] + amit[,6] + amit[,7])
summary(linear3)

#(ii)
res3 = resid(linear3)
fit3 = fitted(linear3)
pairs(cbind(res3,fit3),c("res1","res2","fit1","fit2"),main="Fig 8: Pair Plot")

par(mfrow=c(2,2))

qqnorm(res3[,1], main="Fig 9(a): res1")
qqline(res3[,1])

qqnorm(res3[,2], main="Fig 9(b): res2")            
qqline(res3[,2])

zd2 = apply(res3, 1, function(x, mu, sigma)(x-mu)%*%solve(sigma)%*%(x-mu), 
            colMeans(res3), var(res3))
qqplot(qchisq(ppoints(zd2)[order(order(zd2))], df=2), zd2, xlab="Quantiles of Chisquare", main="Fig 9(c): Chisquare QQ Plot")
abline(0,1)

#(iii)
z0=c(1,1,1200,140,70, 85) 
par(mfrow=c(1,1))
library(ellipse)
plot(ellipse(t(resid(linear3))%*%resid(linear3)/(17 - 5 - 1), centre = z0 %*% coef(linear3),
             t=sqrt((1+t(z0)%*%solve(t(model.matrix(linear3))%*%model.matrix(linear3))%*%z0)*2*(17-5-1)*qf(.95,2,17-5-2)/(17-5-2))),
     xlab="TOT", ylab="AMI", type="l")
title("Fig 10: 95% Prediction Ellipse")
abline(v=c(41.34785, 1417.702), col="red", lty=2)
abline(h=c(-139.8674, 1291.318), col="blue", lty=3)
# Now we can see the 95% Prediction Ellipse takes the correlation of the two outcome variables into account.
# It defines sensible area of possible values to predict TOT and AMI
# the rectangle region ignores the correlation, which is not efficient.
