install.packages("sqldf")
library(sqldf)

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(URL, destfile = "acs.csv")
acs <- read.csv("acs.csv")

sqldf("select pwgtp1 from acs where AGEP < 50")
?sqldf
sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select * from acs where AGEP < 50")

unique(acs$AGEP)
sqldf("select AGEP where unique from acs")
sqldf("select unique AGEP from acs")
sqldf("select distinct AGEP from acs")

con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

url2 <- "http://biostat.jhsph.edu/~jleek/contact.html"
?nchar

install.packages("httr")
library(httr)
library(XML)

html2 = GET("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText=TRUE)
parsedHtml

?readLines
ques4 <- readLines(url2)

install.packages("rvest")
library(rvest)
vignette("selectorgadget")

oauth_endpoints("github")
myapp <- oauth_app("github", "2b791204a2b7229d760e","e47e792adf17b35c9b78196ca5da5d64425a24c7")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)

?connections
close(con)

url5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
?read.fwf
noaa <- read.fwf("noaa.for", skip = 4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
?sum
sum(noaa[, 4])
col4 <- noaa[, 4]
col4
sum(col4, na.rm = TRUE)
?colSums
colSums(noaa)
noaa[, 4] <- as.numeric(as.character( noaa[, 4] ))

library(httr)
library(httpuv)
install.packages("httpuv")

myapp <- oauth_app("github",key="2b791204a2b7229d760e",secret = "e47e792adf17b35c9b78196ca5da5d64425a24c7")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
