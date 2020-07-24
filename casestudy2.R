## Baltimore example.
dat = read.csv("911_Calls_for_Service.csv") ## Takes forever, if it opens at all
dim(dat) # 2892458 rows, 7 columns
## Possibility 1: Take a sample of 5% of the rows
fraction = 0.05
set.seed(12345) ## Change this to your own number
sample_rows = sample(1:nrow(dat), floor(nrow(dat) * fraction))
dat_sample = dat[sample_rows,]
write.csv(dat_sample,"Baltimore_Fraction_05.csv")
dat = dat_sample # overwrite the old dat
dat_sample = NULL # To clear RAM
gc() # garbage collection to further clear RAM

balt = read.csv("Baltimore_Fraction_05.csv")
head(balt)

library(mice)
length(which(is.na(balt)))

balt$location[which(balt$location == "(,)")] = NA

imp_obj = mice(balt) # will only impute on the numeric with PMM
## Hmmm... dummy variable issue


balt = read.csv("Baltimore_Fraction_05.csv", as.is=TRUE)
length(which(is.na(balt)))

balt$location[which(balt$location == "(,)")] = NA

imp_obj = mice(balt) # will only impute on the numeric with PMM




### Say we want to impute the priority level

table(balt$priority)


subset(balt, priority=="")[,1:5]

bad_priority = which(balt$priority %in% c("","Out of Service"))
balt$priority[bad_priority] = NA

balt$prior_num = NA
balt$prior_num[balt$priority == "Non-Emergency"] = 0
balt$prior_num[balt$priority == "Low"] = 1
balt$prior_num[balt$priority == "Medium"] = 2
balt$prior_num[balt$priority == "High"] = 3
balt$prior_num[balt$priority == "Emergency"] = 4

balt = subset(balt, !(district %in% c("EVT1","EVT2")))


## What about location?
as.factor(balt$location)[1:20]
length(which(balt$location == "(,)")) # lots, but not NA


#(,) (0,0) (0.000000,0.000000)
# what else?

library(stringr)
## Use stringr to extract the x and y 
## and to find coordinates that are far outside Baltimore
## via substring, or regex

x = balt$location

### Split the variables by the comma ,
all_locs = str_split_fixed(balt$location,",",2)  ## Fixed 2 means each string will produce 2 strings
## and the output will be a 2xN vector
head(all_locs)

loc_x = str_extract(all_locs[,1], "[0-9]+.[0-9]+")
loc_y = str_extract(all_locs[,2], "-[0-9]+.[0-9]+")
head(loc_x)
head(as.numeric(loc_x))

balt$loc_x = as.numeric(loc_x)
balt$loc_y = as.numeric(loc_y)
plot(balt$loc_x, balt$loc_y)

quantile(balt$loc_x,na.rm=TRUE)
quantile(balt$loc_x,na.rm=TRUE,probs=c(0,0.001,0.999,1))
quantile(balt$loc_y,na.rm=TRUE)
quantile(balt$loc_y,na.rm=TRUE,probs=c(0,0.001,0.999,1))

length(which(balt$loc_x < 39))
length(which(balt$loc_x > 40))
length(which(balt$loc_y > -76))
length(which(balt$loc_y < -77))


balt$loc_x[which(balt$loc_x < 39)] = NA
balt$loc_x[which(balt$loc_x > 40)] = NA
balt$loc_y[which(balt$loc_y > -76)] = NA
balt$loc_y[which(balt$loc_y < -77)] = NA

plot(balt$loc_x, balt$loc_y)
#now only locations within Baltimore is considered

balt$callDateTime = balt$ï..callDateTime #fix column name error
test = str_sub(balt$callDateTime,2,6)

hour = str_sub(balt$callDateTime,12,13)
pm = str_sub(balt$callDateTime,21,22)

hour = as.numeric(hour)
hour[which(pm == "PM")] = hour[which(pm == "PM")] + 12
hour = hour %% 24 #now variable hour is in 24hr format

plot(table(hour),type='b') #b for both points and lines

balt$hour = as.factor(hour)
balt$description = toupper(balt$description)

high_em = subset(balt, priority %in% c("High","Emergency"))
unique(high_em$description)
he_desc = unique(high_em$description)

is_he_desc = rep(0,nrow(balt))
is_he_desc[which(balt$description %in% he_desc)] = 1
table(is_he_desc)

balt$is_he_desc = is_he_desc

balt2 = balt[,c("prior_num","district","loc_x","loc_y","hour","is_he_desc")]
balt2$prior_num = as.factor(balt2$prior_num)

library(mice)

##Compare: SLOW!!!
imp_obj = mice(balt2) # will only impute on the numeric with PMM

## Three variables with missing data
## First one: priority, ordinal (use: polr)
## Second, third: location, numeric (use: pmm)


#Prior_num: ordinal, polr
#District: categorical (unordered), polyreg
#loc_x, loc_y: Numeric, pmm
#Binary: logreg
imp_obj = mice(balt2,method=c("polr","polyreg","pmm","pmm","polyreg","logreg"))
head(imp_obj)
str(imp_obj)
is.na(imp_obj)

abc<-complete(imp_obj)
is.na(abc)


abc$priority[abc$priority == "Non-Emergency"] = 0
abc$priority[abc$priority == "Low"] = 1
abc$priority[abc$priority == "Medium"] = 2
abc$priority[abc$priority == "High"] = 3
abc$priority[abc$priority == "Emergency"] = 4


library(stringi)
times = stri_datetime_parse(abc$ï..callDateTime, format = "MM/dd/uu HH:mm:ss a")
head(times)
str(abc)

library(dplyr)
abc<-mutate(abc,times)
str(abc)
plot(abc$times,abc$priority)


#plot


#table
t1<-table(abc$priority,abc$district)
plot(t1)
plot1<-barplot(t1,col=c('red','blue','grey','green'),legend=rownames(t1),beside=TRUE)
plot2<-barplot(t1,col=c('red','blue','grey','green'),legend=rownames(t1))

t2<-table(abc$priority)
t2
barplot(t2)

library(plotrix)
abc$priority<-as.numeric(abc$priority)
pie(na.omit(abc$priority))
#terry, nov 1st
#note that only prior_num, loc_x, loc_y have missing values
#prior_num is a vector of factors, just remove the missing ones
length(which(is.na(balt2$prior_num) == TRUE))/length(balt2$prior_num) #=0.00262
#less than 1 percent of the data will be removed
balt3 = subset(balt2, select=c(prior_num, loc_x, loc_y))
head(balt3)
balt3[complete.cases(balt3[,2:3]),]
imp2 = mice(balt3, method = "norm.nob", m=5, seed = 12345)

