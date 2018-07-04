# Author: Rohil Narula

# Adding required packages
require("data.table")
require("dplyr")
require("tidyr")

path = getwd() # Set this to your path

# Reading data between the required dates
householdData <- fread(file.path(path, "household_power_consumption.txt"))
householdData <- filter(householdData, grepl("^1/2/2007", householdData$Date) | grepl("^2/2/2007", householdData$Date))

# Converting to numeric
householdData$Global_active_power <- as.numeric(householdData$Global_active_power)

# Converting dates
householdData$Date <- strptime(paste(householdData$Date, householdData$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
householdData$Date <- as.POSIXct(householdData$Date)
householdData <- tbl_df(householdData)

# Converting to numeric (submetering)
subMetering1 <- as.numeric(householdData$Sub_metering_1)
subMetering2 <- as.numeric(householdData$Sub_metering_2)
subMetering3 <- as.numeric(householdData$Sub_metering_3)

# Plotting and saving
plot(householdData$Date, subMetering1, type = "l", ylab = "Energy Submetering", xlab = "")
lines(householdData$Date, subMetering2, type = "l", col = "red")
lines(householdData$Date, subMetering3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.copy(png, file = "plot3.png")
dev.off()
