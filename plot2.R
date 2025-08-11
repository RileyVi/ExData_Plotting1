##Load appropriate libraries and packages
library(readtext)
library(readr)
library(dplyr)
library(lubridate)
library(sqldf) 

sql_query <- "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

subset_data <- read.csv.sql("~/Household Power Consumption/household_power_consumption.txt",
                            sql = sql_query,
                            sep = ";",
                            header = TRUE)
head(subset_data, 5)

#Format Date and Time to Date/Time Formats
subset_data$Date <- as.Date(subset_data$Date, format = "%d/%m/%Y")
subset_data$datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), 
                                   format = "%Y-%m-%d %H:%M:%S")
subset_data$Time <- as.POSIXlt(paste(subset_data$Date, subset_data$Time),
                               format = "%Y-%m-%d %H:%M:%S")
##Plot 2: Global Active Power Y-axis, datetime x-axis
par(mfrow = c(1,1))
png(filename = "plot2.png", width = 480, height = 480)
plot(subset_data$datetime, subset_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n")

tick_positions <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
axis(1, at = tick_positions, labels = c("Thurs", "Fri", "Sat"))
dev.off()