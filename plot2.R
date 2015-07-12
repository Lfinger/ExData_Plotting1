##This program creates a plot of power usage (kW) against time, for period 1 and 2 February 2007. 
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
##creating plot 2
png("plot2.png",width=480,height=480)
plot(index(usext),as.numeric(usext$Global_active_power),xlab="", ylab="",main="",type="l")
title(ylab="Global Active Power (kilowatts)")
dev.off()

