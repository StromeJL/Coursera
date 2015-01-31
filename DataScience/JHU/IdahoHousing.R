URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL, destfile = "./IdahoHousing1.csv")
IdahoHousing <- read.csv("IdahoHousing1.csv")
head(IdahoHousing)
length(subset(IdahoHousing, ADJUST >= 1000000, select=ADJUST))
HighRoller <- subset(IdahoHousing, VAL ==24, select=VAL)


URL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(URL2, destfile = "./NGAP.xlsx")
library(xlsx)
?read.xlsx
?read.csv
NGAP <- read.xlsx("NGAP.xlsx", 1)
file.exists("NGAP.xlsx")
library(gdata)
install.packages(gdata)
NGAP <- read.xlsx("NGAP.xlsx", 1 , stringsAsFactors=F)
library(rJava)
NGAP <- read.xlsx("getdata-data-DATA.gov_NGAP.xlsx", 1)
dat <- read.xlsx("getdata-data-DATA.gov_NGAP.xlsx", 1 , rowIndex=18:23, colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T) 

?install.packages
install.packages(XML)
library(XML)

URL3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(URL3, destfile = "BaltimoreRestaurants.xml")
rest <- xmlTreeParse("BaltimoreRestaurants.xml", useInternal=TRUE)
roodNode <- xmlRoot(rest)
xmlName(roodNode)
names(roodNode)
roodNode[[1]]
xmlSApply(roodNode,xmlValue)
zipCodeList <- xpathSApply(roodNode,"//zipcode",xmlValue)
length(zipCode == 21231)
zipCode <- as.data.frame(table(zipCode))
zipCode

?as.data.frame
?table

sum(zipCodeList == 21231)

?sum

?fread
help.search("fread")

install.packages("data.table")
library(data.table)

?fread

URL4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
DTFile <- download.file(URL4, destfile = "fread.csv")
DT <- fread(DTFile)
file.exists("fread.csv")
DT <- fread("fread.csv")

DT[,mean(pwgtp15),by=SEX]
mean(DT$pwgtp15,by=DT$SEX)
tapply(DT$pwgtp15,DT$SEX,mean)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
sapply(split(DT$pwgtp15,DT$SEX),mean)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
