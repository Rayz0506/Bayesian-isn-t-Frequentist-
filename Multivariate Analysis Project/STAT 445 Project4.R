#Q2
morph = read.table("morph.data.csv", header = TRUE, sep = ",", na.string=".") 
morph = morph[,-1]

#(a)
morph_corr = cor(morph)
morph_eigen = eigen(morph_corr)
round(morph_eigen$values,4)
round(morph_eigen$vectors,4)

#(b)
z = princomp(x=morph, cor=T)
z
par(mfrow=c(1,2))
screeplot(z, type="barplot")
screeplot(z, type="lines")

#(c)
loadings(z)
summary(z)
out = cbind(-sqrt(morph_eigen$values[1])*morph_eigen$vectors[,1], sqrt(morph_eigen$values[2])*morph_eigen$vectors[,2])
rownames(out) = colnames(morph)
#the cumulative proportion explained by the first two principle component is 63%

#(d)
library(plotrix)
par(mfrow=c(1,1))
biplot(z)
#the 1st PC has 11 variables and the 2nd PC has 7 variables
#the 2nd PC own the positive correlation and the 1st PC own both negative and positive correlation
#in biplot we can see there are 4 variables (AA,SV,FPW and FIA) parallel to the 1st PC

#(e)
colnames(morph)[order(abs(z$loadings[,1]),decreasing=T)]
# the rank is from the strongest to the weakest

#(f)
# Absolutely not enough because the first two principal components are only account for 63% of the total variability. 
# but as we expected, we want to arrive cumulatuve proportion of variablility is 80% to 90%
# Not enough to summarize the variability effectively. 

#Q3
fat = read.table("fat_dat.txt", header = F) 
fat = fat[,-1]
fat1 = fat[,"V2"]
fat2 = fat[,"V3"]
circumf = fat[,9:18]

#(a)
w = princomp(x=circumf, cor=F)
w
summary(w)
circumf_load = loadings(w)
predict_circumf = predict(w)
index_circumf = predict_circumf[,1]
plot(index_circumf,fat1, xlab="Centered first PC of circumferences", ylab="Brozek's fat percent", main="Q3(a)")
#We can see there is a decreasing trend in this scatterplot, it means smaller first two principal components and fat percent.
#as we can see the first principle components explains 86% of total variability of the 10 circumference variables
#and there is a negative correlation relationship between Brozek's percent body fat and the circumference.

#(b) 
fit = lm(fat1 ~ index_circumf)
summary(fit)
res_fit = resid(fit)
fit_fit = fitted(fit)
par(mfrow=c(2,2))
plot(res_fit, fit_fit, xlab="Fitted values", ylab="Residuals", main="Q3(b)-1")
plot(res_fit, index_circumf, xlab="Centered 1st PC", ylab="Residuals", main="Q3(b)-2")
qqnorm(res_fit, main="Q3(b)-3")
qqline(res_fit)

#(c)
lmfit = lm(fat1~ V10 + V11 + V12 + V13 + V14 + V15 + V16 + V17 + V18 + V19, data=circumf)
lmfit
summary(lmfit)
res_lmfit = resid(lmfit)
fit_lmfit = fitted(lmfit)
par(mfrow=c(1,2))
plot(res_lmfit, fit_lmfit, xlab="Fitted values", ylab="Residuals", main="Q3(c)-1")
qqnorm(res_lmfit, main="Q3(c)-2")
qqline(res_fit)

#d)
#  I think the (c) is better because the adjusted R square of (c) (0.7241) is great than the adjusted R square of (b) (0.5667).