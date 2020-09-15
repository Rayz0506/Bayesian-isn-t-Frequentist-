#Q3 (Exercise 11.32)
HemoData <- data.frame(read.table('T11-8.DAT', header=FALSE))
library(MASS)
colnames(HemoData) = c("V1","V2","V3")

#(a)
library(mvtnorm)
group1 = subset(HemoData, V1==1)[,2:3]
group2 = subset(HemoData, V1==2)[,2:3] 
par(mfrow=c(2,2))
qqnorm(group1$V2)
qqline(group1$V2)
qqnorm(group1$V3)
qqline(group1$V3)
qqnorm(group2$V2)
qqline(group2$V2)
qqnorm(group2$V3)
qqline(group2$V3)

zd1=apply(group1, 1, function(x, a, b)(x-a)%*%solve(b)%*%(x-a), colMeans(group1), var(group1))
zd2=apply(group2, 1, function(x, a, b)(x-a)%*%solve(b)%*%(x-a), colMeans(group2), var(group2))

par(mfrow=c(1,2))  
qqplot(zd1, qchisq(ppoints(zd1)[order(order(zd1))], df=2), xlab="Chi-Square quantiles", ylab="Empirical quantiles")
abline(0,1)

qqplot(zd2, qchisq(ppoints(zd2)[order(order(zd2))], df=2), xlab="Chi-Square quantiles", ylab="Empirical quantiles")
abline(0,1)

#(b)
x1.bar = colMeans(group1)
x2.bar = colMeans(group2)
S1 = var(group1)
S2 = var(group2)
n1 = dim(group1)[1]
n2 = dim(group2)[1]
SP = ((n1-1)*S1 + (n2-1)*S2)/(n1+n2-2)
SP
a = (x1.bar-x2.bar)%*%solve(SP)
a
b = 0.5*a%*%(x1.bar + x2.bar)
b

z.cv <- lda(V1 ~ V2 + V3, data = HemoData, prior=c(0.5,0.5), CV=T)
table(z.cv$class, HemoData$V1)
#AER=(4+8)/(30+45)=0.16

#(c)
NewHemo <- read.table('T11-8B.DAT', header=FALSE)
z.out <- lda(V1 ~ V2 + V3, data = HemoData, prior=c(0.5,0.5), CV=F)
predict(z.out, newdata=data.frame(V2=NewHemo$V1, V3=NewHemo$V2), prior=z.out$prior)

plot(group1$V2, group1$V3, col="blue", xlab="AHF activity", ylab="AHF antigen", xlim=c(-1,0.2),ylim=c(-0.6,0.4), pch="+")
points(group2$V2, group2$V3, col="red", pch="*")
abline(coef=c(3.599/17.124, 19.319/17.124))
points(NewHemo[,1], NewHemo[,2], col="black", pch="o")

#(d)
zz.cv <- lda(V1 ~ V2 + V3, data = HemoData, prior=c(3,1)/4, CV=T)
table(zz.cv$class, HemoData$V1)
#AER=(0+18)/(30+45)=0.24
zz.out <- lda(V1 ~ V2 + V3, data = HemoData, prior=c(3,1)/4, CV=F)              
predict(zz.out, newdata=data.frame(V2=NewHemo$V1, V3=NewHemo$V2), prior=zz.out$prior)

plot(group1$V2, group1$V3, col="blue", xlab="AHF activity", ylab="AHF antigen", xlim=c(-1,0.2),ylim=c(-0.6,0.4), pch="+")                               
points(group2$V2, group2$V3, col="red", pch="*")                                
abline(coef=c(4.658/17.124, 19.319/17.124))
points(NewHemo[,1], NewHemo[,2], col="black", pch="o")

