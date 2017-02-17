#
# plot3.R
#

# read the data

data_src <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(data_src,temp)
f <- read.csv( unz(temp, "household_power_consumption.txt"),
               sep=";",
               stringsAsFactors=FALSE,
               colClasses=c(rep('character',9))
)
unlink(temp)

f$dt <- strptime( paste( f$Date, f$Time ), format="%d/%m/%Y %H:%M:%S" )

# subset to the period of interest

startDate <- strptime("01/02/2007","%d/%m/%Y" )
toDate <- strptime("03/02/2007", "%d/%m/%Y" )
cc <- subset( f, dt >= startDate & dt < toDate )

# fix datatypes

class( cc$Global_active_power ) <- 'numeric'
class( cc$Global_reactive_power ) <- 'numeric'
class( cc$Voltage ) <- 'numeric'
class( cc$Sub_metering_1 ) <- 'numeric'
class( cc$Sub_metering_2 ) <- 'numeric'
class( cc$Sub_metering_3 ) <- 'numeric'

# MAIN PLOT

png(filename="plot3.png", width=480,height=480, bg = "transparent" )
plot( x=cc$dt, y=cc$Sub_metering_1, ylab="Energy Sub Metering", xlab="", typ='l', col='black' )
lines( x=cc$dt, y=cc$Sub_metering_2, col='orange')
lines( x=cc$dt, y=cc$Sub_metering_3, col='blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c('black', 'orange', 'blue'),
       lty = c(1, 1, 1),
       lwd=c(2,2,2),
       box.col='white', inset=0.02)

dev.off()


