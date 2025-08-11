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
##Plot 3: Energy sub-metering y-axis, datetime x-axis
png(filename = "plot3.png", width = 480, height = 480)
plot(subset_data$datetime, subset_data$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering", 
     xaxt = "n")
axis(1, at = tick_positions, labels = c("Thurs", "Fri", "Sat"))

lines(subset_data$datetime, subset_data$Sub_metering_2, col = "red")

lines(subset_data$datetime, subset_data$Sub_metering_3, col = "blue")

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 1)
dev.off()