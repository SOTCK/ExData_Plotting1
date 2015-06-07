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

#ORDER OF STEPS: Make Plot 3: Multiple series on a single line chart
#How to display multiple series? stackoverflow.com/questions/14383237/plot-two-different-series-on-the-same-graph-in-r (answer by Thierry Silbermann)

#Time permitting, I would have explored an alternate approach of combining the three Sub_metering columns in a new data frame, with the original column names
#...as factors in a second column. That new set could have been saved as a variable, and then the series could have been plotted as three subsets of that
#...new variable.
#TIP: Control the size of the legend with the cex argument. By trial and error, I settled on cex=1 as the best value.
#Plot the first series. Use par(new=TRUE) to enable the second series to appear in the same plot.
#Plot the second series. Use par(new=TRUE) to enable the third series to appear in the same plot. 
#Plot the final series. 
#Add a legend, using lty=1 to use lines as symbols for each series, and to specify the line type as solid.
png(filename="Plot3.png",height=480,width=480,units="px")
par(mar=c(2,2,2,2))
plot(hhpower_feb2007$Sub_metering_1 ~ hhpower_feb2007$Time,xlab="",type="l",ylab="Energy Sub Metering",ylim=c(0,40))
par(new=TRUE)
plot(hhpower_feb2007$Sub_metering_2 ~ hhpower_feb2007$Time,xlab="",type="l",ylab="Energy Sub Metering",ylim=c(0,40),col="red")
par(new=TRUE)
plot(hhpower_feb2007$Sub_metering_3 ~ hhpower_feb2007$Time,xlab="",type="l",ylab="Energy Sub Metering",ylim=c(0,40),col="blue")
legend("topright",legend = (c("Sub_metering_1","Sub_metering_2","Sub_metering_3")),lty=1,col=c("black","red","blue"), cex=1)
dev.off()
