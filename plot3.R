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
#Sub_metering_1
y1 = c(as.character(X$Sub_metering_1[arg][arg1]), as.character(X$Sub_metering_1[arg][arg2]))
#Sub_metering_2
y2 = c(as.character(X$Sub_metering_2[arg][arg1]), as.character(X$Sub_metering_2[arg][arg2]))
#Sub_metering_1
y3 = c(as.character(X$Sub_metering_3[arg][arg1]), as.character(X$Sub_metering_3[arg][arg2]) )

png(file='plot3.png')
#plot day1
plot(x,y1, xlab="", ylab='Energy sub metering',type="l",xaxt="n",yaxt="n", col='black')
lines(x,y2, xlab="",col='red')
lines(x,y3, xlab="",col='blue')
axis(side=1,at=c(0,24,48),labels=c("Thur","Fri","Sat"))
axis(side=2,at=seq(0,30,10))
legend("topright",lty=1,col=c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
