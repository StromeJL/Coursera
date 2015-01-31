#Getting and Cleaning Data Quiz 3
#Question 1

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL, destfile = "acs.csv")
acs_data <- read.csv("acs.csv")

?which
agricultureLogical <- with(acs_data, ACR == 3 & AGS ==6)
which(agricultureLogical)

acs_data[(acs_data$ACR ==3 & acs_data$AGS == 6),]
acs_data[which(acs_data$ACR ==3 & acs_data$AGS == 6),]

# Question 2

#from stack overflow
install.packages("jpeg")  ## if necessary

library(jpeg)
## get help
library(help = jpeg)
## get more help
?readJPEG

?download.file

URL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
#Image is binary file therefore 'mode="wb"'
download.file(URL2, destfile = "Question2.jpeg", mode="wb")
picture <- readJPEG("Question2.jpeg", native=TRUE)

?quantile
quantile(picture, probs = seq(.3, .8))
quantile(picture, probs = seq(.8, 1))
quantile(picture, probs = seq(0, .3))

# Question 3

#Data Sources
#GDP - 'http://data.worldbank.org/data-catalog/GDP-ranking-table'
#Edu - 'http://data.worldbank.org/data-catalog/ed-stats'

URL3a <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
URL3b <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(URL3a, destfile = "GDP.csv")
download.file(URL3b, destfile = "edu.csv")
GDP_data <- read.csv("GDP.csv")
edu_data <- read.csv("edu.csv")


library(plyr)
head(GDP_data)
head(edu_data)

head(mergedData, 3)

?merge
mergedData <- merge(GDP_data, edu_data, by.x="X", by.y="CountryCode", all=FALSE)
?sort
sortedData <- (as.numeric(mergedData$Gross.domestic.product.2012), decreasing=TRUE, na.last=TRUE)
?arrange
arrangeData <- arrange(GDP, desc(Gross.domestic.product.2012))

?rename
mergedData <- (rename(mergedData, GDP = Gross.domestic.product.2012))

vars <- c('X','X.2','Gross.domestic.product.2012')
GDP <- mergedData[,vars]
GDP
GDP$Gross.domestic.product.2012 <- as.numeric(GDP$Gross.domestic.product.2012)
sorted <- sort(GDP$Gross.domestic.product.2012, decreasing=TRUE, na.last=TRUE)


noOECD <- mergedData[mergedData$Income.Group == "High income: nonOECD",]
mean(as.numeric(noOECD$Gross.domestic.product.2012))

OECD <- mergedData[mergedData$Income.Group == "High income: OECD",]
mean(as.numeric(OECD$Gross.domestic.product.2012))
