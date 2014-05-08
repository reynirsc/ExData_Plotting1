#Set working directory
#setwd('~/R/eda')

#Set locale for English graphs
Sys.setlocale(category = "LC_ALL", locale = "C")

#read file header
dataheader= readLines('household_power_consumption.txt', n = 1)

#read data matching dates
lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'), value=T)

#load in data combining header and read lines
data = read.table(textConnection(c(dataheader, lines)), header=T, sep=";", na.strings="?" )

# clean up Date and Time
DateTime= paste(data$Date, data$Time, sep=" ")
DateTime = strptime(DateTime, format="%d/%m/%Y %H:%M:%S", tz="")

#add DateTime column to data
data = cbind(data, DateTime)

par(mfrow=c(1,1))
#Plot 3
plot(data$DateTime, data$Sub_metering_1, type="l",
     ylab="Energy sub metering",
     xlab="",
     col="black"
)
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
lgnd_text=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
lgnd_col=c("black", "red", "blue")
legend("topright", legend=lgnd_text, col=lgnd_col, lty=c(1,1,1), cex=0.6)
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()