####Week 1 Project for Coursera - Getting and Cleaning Data
####R version 3.3.3 (2017-03-06) x86_64-w64-mingw32

###Prepares working directory and obtain source data for the assignment 
if(!file.exists("./data")) dir.create("./data")

##Checks whether the zip-file has already been downloaded, if not downloads the file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filedest <- "./data/w1plotdata.zip"
if(!file.exists(filedest)) download.file(fileurl, destfile = filedest)

##Checks whether the zip-file has already been unzipped, if not unzips the file
filename <- "./data/household_power_consumption.txt"
if(!file.exists(filename)) unzip(filedest, exdir = "./data")

##Reads data for 1-2 Feb 2007
con <- file(filename)
hpower <- read.table(text = c(readLines(con, n=1), grep("^[1,2]/2/2007",readLines(con),value=TRUE)), 
                     header=TRUE, sep=";", stringsAsFactors = FALSE, dec=".")
close(con)

##Plot 2
hpower$datetime <- with(hpower, strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S")) 
png("plot2.png", width=480, height=480)
with(hpower, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()