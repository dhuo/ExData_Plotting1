#!/usr/bin/Rscript

#read data
X = read.csv("household_power_consumption.txt",sep=";",colClasses=c("character","character",rep("numeric",7)))
#filter by dates
arg = which( (as.Date(X$Date,format="%d/%m/%Y") == as.Date("01/02/2007",format="%d/%m/%Y") | (as.Date(X$Date,format="%d/%m/%Y")==as.Date("02/02/2007",format="%d/%m/%Y"))) )
#convert Time to decimal hours
temp=strsplit(as.character(X$Time[arg]),":")
decH = c()
for (i in seq_along(arg)) {
    decH = c(decH, as.numeric(temp[[i]][1]) + as.numeric(temp[[i]][2])/60 + as.numeric(temp[[i]][3])/3600)
}

arg1 = which( (as.Date(X$Date[arg],format="%d/%m/%Y") == as.Date("01/02/2007",format="%d/%m/%Y")) )
arg2 = which( (as.Date(X$Date[arg],format="%d/%m/%Y")==as.Date("02/02/2007",format="%d/%m/%Y")) )

x = c(decH[arg1], decH[arg2]+24) #add 24 hours to day "2"
y = c(as.numeric(X$Global_active_power[arg][arg1])/500, as.numeric(X$Global_active_power[arg][arg2])/500)

png(file='plot2.png')
#plot day1
plot(x,y, xlab="", ylab='Global Active Power (kilowatts)',type="l",xaxt="n")
axis(side=1,at=c(0,24,48),labels=c("Thur","Fri","Sat"))
dev.off()
