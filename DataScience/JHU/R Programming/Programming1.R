temp <- tempfile()
URL <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
download.file(URL, temp)
unzip(temp)
unlink(temp)


##pollutantmean function
# This way takes really long because you copy dat
# and add to it each of 332 you go through the loop
pollutantmean <- function(directory, pollutant, id = 1:332) {
      files_list <- list.files(directory, full.names=TRUE)
      dat <- data.frame()
      for (i in 1:332){
           dat <- rbind(dat, read.csv(files_list[i]))
      }
      dat_subset <- dat[which(dat[, "ID"] == id)]
      mean(dat_subset$pollutant, na.rm=TRUE)
}

?formatC
?paste

pollutantmean("specdata", "sulfate", 1:5)

head(read.csv("specdata/001.csv"))


