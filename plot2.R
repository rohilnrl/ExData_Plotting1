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

# Plotting and saving
plot(householdData$Date, householdData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()
