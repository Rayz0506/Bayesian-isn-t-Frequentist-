A<-read.csv('Bowley.csv',header=T)
head(A)
TC<-A$Value
plot(TC,type='l')
TC.ts<-ts(TC)
library(TSA)
adf.test(TC.ts)
plot.ts(TC.ts, main="Bowley's example of the method of smoothing curves", pch=16, ylab ='Value of British and Irish Exports', xlab='year')
periodogram(TC.ts)
d1<-diff(TC.ts,lag=1)
plot(d1)
adf.test(d1)
#p-value is small than 0.01, it is a stationary.
d2<-diff(TC.ts,lag=2)
d2
plot(d2)
adf.test(d2)
#2. choose the model pdq  acf pacf eacf build the model    arima(data, order=c())
par(mfrow=c(2,1))
acf(d1) 
pacf(d1)
eacf(d1)

acf(d2)
pacf(d2)
eacf(d2)

library(forecast)
auto.arima(TC.ts)

m1<-arima(d1, order=c(1,1,2))
m2<-arima(d1, order=c(0,1,2))
m3<-arima(d1, order=c(2,1,3))
m4<-arima(d2, order=c(1,2,1))
m5<-arima(d2, order=c(1,2,2))
m6<-arima(d2, order=c(2,2,3))
m7<-arima(TC.ts, order=c(0,2,2))

#3. use AIC BIC delet some model
AIC(m1)
AIC(m2)
AIC(m3)
AIC(m4)
AIC(m5)
AIC(m6)
AIC(m7)
#m1 model has smallest value
BIC(m1)
BIC(m2)
BIC(m3)
BIC(m4)
BIC(m5)
BIC(m6)
BIC(m7)
#m1 model has smallest value

#4. diagnosis the model which choose the best one, 
qqnorm(m1$residuals,main='Normal Q-Q plot', xlab='Theoretical Quantiles',ylab='Sample Quantiles',plot.it=TRUE,datax=FALSE)
qqline(m1$residuals,datax=FALSE)

qqnorm(m2$residuals,main='Normal Q-Q plot', xlab='Theoretical Quantiles',ylab='Sample Quantiles',plot.it=TRUE,datax=FALSE)
qqline(m2$residuals,datax=FALSE)

qqnorm(m3$residuals,main='Normal Q-Q plot', xlab='Theoretical Quantiles',ylab='Sample Quantiles',plot.it=TRUE,datax=FALSE)
qqline(m3$residuals,datax=FALSE)

qqnorm(m4$residuals,main='Normal Q-Q plot', xlab='Theoretical Quantiles',ylab='Sample Quantiles',plot.it=TRUE,datax=FALSE)
qqline(m4$residuals,datax=FALSE)

qqnorm(m5$residuals,main='Normal Q-Q plot', xlab='Theoretical Quantiles',ylab='Sample Quantiles',plot.it=TRUE,datax=FALSE)
qqline(m5$residuals,datax=FALSE)

qqnorm(m6$residuals,main='Normal Q-Q plot', xlab='Theoretical Quantiles',ylab='Sample Quantiles',plot.it=TRUE,datax=FALSE)
qqline(m6$residuals,datax=FALSE)

qqnorm(m7$residuals,main='Normal Q-Q plot', xlab='Theoretical Quantiles',ylab='Sample Quantiles',plot.it=TRUE,datax=FALSE)
qqline(m7$residuals,datax=FALSE)

shapiro.test(m1$residuals)#h0, p-value smaller then 0.05, reject h0, it is not a normal distributed
shapiro.test(m2$residuals)
shapiro.test(m3$residuals)
shapiro.test(m4$residuals)
shapiro.test(m5$residuals)
shapiro.test(m6$residuals)
shapiro.test(m7$residuals)

hist(m1$residuals, breaks=100)
hist(m2$residuals, breaks=100)
hist(m3$residuals, breaks=100)
hist(m4$residuals, breaks=100)
hist(m5$residuals, breaks=100)
hist(m6$residuals, breaks=100)
hist(m7$residuals, breaks=100)

Box.test(m1$residuals, type='Ljung-Box')
Box.test(m2$residuals, type='Ljung-Box')
Box.test(m3$residuals, type='Ljung-Box')
Box.test(m4$residuals, type='Ljung-Box')
Box.test(m5$residuals, type='Ljung-Box')
Box.test(m6$residuals, type='Ljung-Box')
Box.test(m7$residuals, type='Ljung-Box')

#from box.test, M3 is dependent. m7 is the best one. h0: it is a independed distributed.
#adf.test() is the argmented Dickey-Fuller Unit Root Tests, H0: the data needs to be differenced to make it stationary


adf.test(m1$residuals)
adf.test(m2$residuals)
adf.test(m3$residuals)
adf.test(m4$residuals)
adf.test(m5$residuals)
adf.test(m6$residuals)
adf.test(m7$residuals)

tsdiag(m1)
tsdiag(m2)
tsdiag(m3)
tsdiag(m4)
tsdiag(m5)
tsdiag(m6)
tsdiag(m7)

#5. prediction
forecast(TC.ts,h=10)
