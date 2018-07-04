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
householdData <- tbl_df(householdData)
householdData$Global_active_power <- as.numeric(householdData$Global_active_power)

# Plotting and saving
hist(householdData$Global_active_power, col = "red", breaks = 12, xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()
