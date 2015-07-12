##This program creates a histogram plot of how many minutes the active power was a given value of kW,
##between 1 and 2 February 2007. 
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
##creating historgram that is plot 1
png("plot1.png",width=480,height=480)
hist(as.numeric(usext$Global_active_power),col="red", xlab="",main="")
title(xlab="Global Active Power (kilowatts)")
title(main="Global Active Power")
dev.off()
