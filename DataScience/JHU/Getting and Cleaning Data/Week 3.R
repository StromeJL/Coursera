###Week 3

##Subsetting and Sorting

#Subsetting - quick review

#creating "random" data frame
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X

#first column
X[,1]

#one column by column name
X[,"var1"]

#subset rows and columns
X[1:2,"var2"]

#Logicals ands and ors

X[(X$var1 <= 3 & X$var3 > 11),]
#subsets rows where 'var1 is <= 3 and var3 is > 11

#using or
X[(X$var1 <= 3 | X$var3 > 15),]

#Dealing with missing values
#using which command
X[which(X$var2 > 8),]
#returns indices without NA's

#Sorting

#Sort values in increasing order
sort(X$var1)

#Sort in decreasing order
sort(X$var1,decreasing=TRUE)

#Sort and put NA's last
sort(X$var2,na.last=TRUE)

#Ordering

#Order data frame 'X' by 'var1'
X[order(X$var1),]

#Order by multiple variables
X[order(X$var1,X$var3),]
#orders 'X' by 'var1' then by 'var3' if 'var1' values are equal

#Ordering with plyr
#arrange
library(plyr)
arrange(X,var1)
#orders data frame 'X' by 'var1'
?arrange

#Decreasing order
arrange(X,desc(var1))

?desc

#Adding rows and columns
X$var4 <- rnorm(5)
#adds column 'var4' to data frame 'X' with values specified by "rnorm(5)"
X

?rnorm

#Using cbind()
#cbind = Column bind
#Like below column 'rnorm(5)' will be added to the right of data frame 'X'
Y <- cbind(X,rnorm(5))
#"Y <- cbind(rnorm(5),X)" would bind "rnorm(5)' to the left of 'X'
Y

#can also bind rows using rbind()
#When second, 'rnorm' will be added to bottom of 'X' using rbind
#When first, 'rnorm' will be added to top of 'X'

'http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf'


##Summarizing Data

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")

head(restData,n=3)

tail(restData,n=3)

?head
?tail

summary(restData)

?summary

str(restData)

?str

quantile(restData$councilDistrict,na.rm=TRUE)
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))

?quantile

table(restData$zipCode,useNA="ifany")
table(restData$councilDistrict,restData$zipCode)

?table

sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

?any
?all

colSums(is.na(restData))
all(colSums(is.na(restData))==0)

?colSums

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))

restData[restData$zipCode %in% c("21212","21213"),]
#logical vector


#Cross Tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

?as.data.frame

xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt

?xtabs

warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~.,data=warpbreaks)
xt

?warpbreaks

#Flat tables from cross tabs
ftable(xt)

?ftable

#size of Data
fakeData = rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData),units="Mb")

?object.size

##Creating New Variables

#Creating sequences

s1 <- seq(1,10,by=2) ; s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along = x)

#Subsetting variables

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

#Creating binary variables

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)

?ifelse

#Creating categorical variables

restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)

table(restData$zipGroups,restData$zipCode)

?cut

install.packages("Hmisc")
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)

#Creating factor variable

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]

?factor

class(restData$zcf)

?class

#Levels of factor variables

yesno <- sample(c("yes","no"),size=10,replace=TRUE)
yesnofac = factor(yesno,levels=c("yes","no"))
relevel(yesnofac,ref="yes")

as.numeric(yesnofac)

?relevel
?as.numeric

# Cutting produces factor variables

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)

#Use the mutate function

library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

?mutate

#Common transforms

http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf
http://statmethods.net/management/functions.html

http://plyr.had.co.nz/09-user/
http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf


## Reshaping Data

#The goal is tidy data

http://vita.had.co.nz/papers/tidy-data.pdf
http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0026895

#Start with reshaping

install.packages("reshape2")
library(reshape2)
head(mtcars)

#Melting data frames

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)

tail(carMelt,n=3)

?melt

#Casting data frames

cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData

?dcast

#Averaging values

head(InsectSprays)

tapply(InsectSprays$count,InsectSprays$spray,sum)

?tapply

'http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/'

#another way - split

spIns =  split(InsectSprays$count,InsectSprays$spray)
spIns

?split

#another way - apply

sprCount = lapply(spIns,sum)
sprCount

?lapply

#another way -  combine

unlist(sprCount)

sapply(spIns,sum)

?unlist
?sapply

#another way - plyr package

ddply(InsectSprays,.(spray),summarize,sum=sum(count))

?ddply

#Creating a new variable

spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)

head(spraySums)

?ave
?dim

' http://plyr.had.co.nz/09-user/'
'http://www.slideshare.net/jeffreybreen/reshaping-data-in-r'
'http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/'

?acast
?arrange
?mutate

##Managing Data Frames dplyr

?arrange
?filter
?select
?mutate
?rename
?summarize

#dplyr is made for working with dataframes
#data frame is a key data structure

#select: return a subset of the columns of data frame
#filter: extract a subset of rows from a data frame based on logical conditions
#arrange: reorder rows of a data frame
#rename: rename variables in a data frame
#mutate: add new variables/columns or transform existing variables
#summarize: generate summary statistics of different variables in the data frame, possibly within strata

#Properties
#first argument is always a data frame
#subsequent argument describe what to do with it, you can refer to columns in data frame directly (by name) without using '$'
#Result is always a new data frame
#Data frames must be properly formatted and annotated for this to be useful\

##select
head(select(chicago, city:dptp))
#selects all columns in 'chicago' data frame between 'city' column and 'dptp' (dewpoint) column

#can use '-' to select all columns but those
head(select(chicago, -(city:dptp)))

#to do this without dplyr and select in R requires add'l lines of code
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
#^^finding indices of those columns
head(chicago[, -(i:j)])

##filter
chic.f <- filter(chicago, pm25tmean2 > 30)
#extracts rows of 'chicago' data frame where the value of column 'pm25tmean2' is greater than 30

head(chic.f, 10)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

#arrange
chicago <- arrange(chicago, date)
#arranges chicago data frame by date
head(chicago)
tail(chicago)

chicago <- arrange(chicago, desc(date))
#arranges by date in descending order
head(chicago)
tail(chicago)

#rename
chicago <- (rename(chicago, pm25 = pm25tmean2, dewpoint = dptp))
#renames column 'pm25tmean2' to 'pm25' and 'dptp' to 'dewpoint' in chicago data frame
head(chicago)

#mutate
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm=TRUE))
#adds column 'pm25detrend' to 'chicago' data frame
# 'pm25detrend' has data equal to the 'pm25' data as modified above
head(select(chicago, pm25, pm25detrend))

#group_by
chicago<- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
#groups 'chicago' data frame by 'tempcat' factor/variable
hotcold

#summarize
#summarize by hot and cold days (see group_by above)
summarize(hotcold, pm25 = mean(pm25), o3 = max(o3tmean2), no2 = median(no2tmean2))

summarize(hotcold, pm25 = mean(pm25, na.rm=TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

#summarize data by year
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
#creates column containing year
years <- group_by(chicago, year)
#groups by year
#summary by year
summarize(years, pm25 = mean(pm25, na.rm=TRUE), o3 = max(o3tmean2, no2 = median(no2tmean2)))

#pipeline operator: '%>%'
chicago %>% mutate(month = asPOSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm=TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

#learn dplyr grammar
#Other benefits:
#dplyr can work with other data frame "backends"
#data.table for large fast tables
#SQL interface for relational databases via DBI package

#Merging data
'http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895'

#Peer review data
#Two files - Two data frames: reviews & solutions
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")

head(reviews,2)

head(solutions,2)

#Merging data - merge()
?merge
#Merges data frames
#Important parameters: x, y , by, by.x, by.y, all

names(reviews)
#displays names of columns in 'reviews' data frame

names(solutions)
#displays names of columns in 'solutions' data frame

#Can use 'solution_id' variable in 'reviews' and 'id' variable in 'solutions' to match and merge the data frames

#Important parameters: x & y are the data frames you want to merge
#'By': by default merge() merges data frames by variables that have the same name
#In this case, it would merge by 'id' variable in both data frames - NOT WHAT WE WANT

#Instead use 'by.x' and 'by.y' to specify which variables to merge in the respective data frames
mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
#all=TRUE ensures that non matching rows will also be merged but with NA for the values that are missing from the other data frame
head(mergedData)

#Default - merge all common column names
intersect(names(solutions),names(reviews))
#shows variable names common to both 'solutions' and 'reviews' data frames
?intersect

mergedData2 = merge(reviews,solutions,all=TRUE)
#creates an even larger data frame because it merges based on all common column names as default when no 'by' is specified
head(mergedData2)

#Using join in the plyr package
#Faster but less full featured - defaults to left join, see help file for more
?join
#only merges on common column names
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)

#If you have multiple data frames
#can be difficult using merge
#but much faster and easier using join_all if they have a common id
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
#create data frame list
dfList = list(df1,df2,df3)
#joins all data frames in list
join_all(dfList)

'http://www.statmethods.net/management/merging.html'
'http://plyr.had.co.nz/'

#Types of Joins
'http://en.wikipedia.org/wiki/Join_(SQL))'