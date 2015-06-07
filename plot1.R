# #ORDER OF STEPS: Reading and preparing data.
# 1. Download data and save in working directory as .txt file: household_power_consumption.txt (LINK: ______________)
# 2. Read data into a data frame called data_hhpower, and change column classes:
data_hhpower <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
# 
# 
# 3. Subset data based on date range, using method from "docendo dicimus" at Stack Overflow:
# http://stackoverflow.com/questions/23622338/subset-a-dataframe-between-2-dates-in-r-better-way
# I chose this route because several attempts to convert all rows in the Time variable to POSIXlt (or POSIXct) resulted in dates only. 
myfunc <- function(x,y){data_hhpower[data_hhpower$Date >= x & data_hhpower$Date <= y,]}
DATE1 <- strptime("2007-02-01","%Y-%m-%d")
DATE2 <- strptime("2007-02-02","%Y-%m-%d")
hhpower_feb2007 <- myfunc(DATE1,DATE2)
#
#
# 4. Convert Time variable to POSIXct to enable math if necessary
hhpower_feb2007$Time <- as.POSIXct(paste(hhpower_feb2007$Date,hhpower_feb2007$Time,format="%Y-%m-%d %H:%M:%S"),tz="GMT")

#ORDER OF STEPS: Make Plot 1: Histogram
png(filename="Plot2.png",height=480,width=480,units="px")
par(mar=c(2,2,2,2))
hist(hhpower_feb2007$Global_active_power,breaks=12,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red",xlim=c(0,6),ylim=c(0,1200))
dev.off()