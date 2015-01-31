#Jake Stromecki
#download data for Ques. 1 of Quiz 1 Getting and Cleaning Data from JHU on Coursera
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./Desktop/Coursera/Data Science/JHU/IdahoHousing.csv", method = "curl")
list.files("./Desktop/Coursera/Data Science/JHU")

dateDownloaded <- date()
dateDownloaded

IdahoHousingData <- read.csv(".\Desktop\Coursera\Data Science\JHU\IdahoHousing.csv")
head(IdahoHousingData)

list.files("./Desktop/Coursera/Data Science/JHU")
