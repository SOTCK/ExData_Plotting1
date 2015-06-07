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
# 4. Convert Time variable to POSIXct
hhpower_feb2007$Time <- as.POSIXct(paste(hhpower_feb2007$Date,hhpower_feb2007$Time,format="%Y-%m-%d %H:%M:%S"),tz="GMT")

#ORDER OF STEPS: Make Plot 4: Four charts in one plot
#Initiate  a png file and set the plot space to a 2x2 layout with ample margins.
png(filename="Plot4.png",height=480,width=480,units="px")
par(mfrow=c(2,2), mar=c(4,4,4,4))
#Plot the upper left chart.
#Plot the upper right chart.
#Plot the lower left chart.
#Plot the lower right chart.
with(hhpower_feb2007,plot(Time,Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l",pch="26"))

with(hhpower_feb2007,plot(Time,Voltage,xlab="datetime",ylab="Voltage",type="l",pch="26"))

plot(hhpower_feb2007$Sub_metering_1 ~ hhpower_feb2007$Time,xlab="",type="l",ylab="Energy Sub Metering",ylim=c(0,40))
par(new=TRUE)
plot(hhpower_feb2007$Sub_metering_2 ~ hhpower_feb2007$Time,xlab="",type="l",ylab="Energy Sub Metering",ylim=c(0,40),col="red")
par(new=TRUE)
plot(hhpower_feb2007$Sub_metering_3 ~ hhpower_feb2007$Time,xlab="",type="l",ylab="Energy Sub Metering",ylim=c(0,40),col="blue")
legend("topright",legend = (c("Sub_metering_1","Sub_metering_2","Sub_metering_3")),lty=1,col=c("black","red","blue"),cex=1)

with(hhpower_feb2007,plot(Time,Global_reactive_power,xlab="datetime",type="l",pch="26"))

dev.off()
