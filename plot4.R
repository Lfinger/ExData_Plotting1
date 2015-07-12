##This program creates a plot with various plots of power usage and voltage against time. 
##The plot is exported as a png file that is 480 pixels wide and 480 pixels high. 

##Install the packages lubridate and xts to help with the data sorting and date formatting
install.packages(c("lubridate","xts"))
library(lubridate)
library(xts)
##read in the data file to a dataframe
powerdata<-read.csv("household_power_consumption.txt", sep=";")
##creating a combined date and time column for later plotting
powerdata$datetime <-dmy(powerdata$Date)+hms(powerdata$Time)
##creating a time series object for latter plotting
powerdataxt <- xts(powerdata[,3:(ncol(powerdata)-1)],order.by=powerdata$datetime)
##setting a start and end date then creating subset called usext of required dates data
s <- ymd("2007-02-01")
e <- ymd("2007-02-02")
usext <- powerdataxt[paste(s,e,sep="/")]
colnames(usext)
##creating plot 4
png("plot4.png",width=480,height=480)
par(mfcol=c(2,2))
plot(index(usext),as.numeric(usext$Global_active_power),xlab="", ylab="",main="",type="l")
title(ylab="Global Active Power (kilowatts)")
plot(index(usext),as.numeric(usext$Sub_metering_1),xlab="", ylab="",main="",type="l")
lines(index(usext),as.numeric(usext$Sub_metering_2),col="red")
lines(index(usext),as.numeric(usext$Sub_metering_3),col="blue")
title(ylab="Energy sub metering")
legend("topright",col=c("black","red","blue"),legend=colnames(usext)[5:7],lty=1,lwd=1,)
plot(index(usext),as.numeric(usext$Voltage),xlab="datetime", ylab="",main="",type="l")
title(ylab="Voltage")
plot(index(usext),as.numeric(usext$Global_reactive_power),xlab="datetime", ylab="",main="",type="l")
title(ylab="Global_reactive_power")
dev.off()

