#!/usr/bin/Rscript

#read data
X = read.csv("household_power_consumption.txt",sep=";",colClasses=c("character","character",rep("numeric",7)))
#filter by dates
arg = which( (as.Date(X$Date,format="%d/%m/%Y") == as.Date("01/02/2007",format="%d/%m/%Y") | (as.Date(X$Date,format="%d/%m/%Y")==as.Date("02/02/2007",format="%d/%m/%Y"))) )

png(file='plot1.png')
hist(X$Global_active_power[arg], col='red', xlab='Global Active Power (kilowatts)', ylab='Frequency', main='Global Active Power')
dev.off()
