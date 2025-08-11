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
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

# Define custom tick positions for x-axis
tick_positions <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
tick_labels <- c("Thu", "Fri", "Sat")


# 1. Global Active Power
plot(subset_data$datetime, subset_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     xaxt = "n")
axis(1, at = tick_positions, labels = tick_labels)

# 2. Voltage
plot(subset_data$datetime, subset_data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     xaxt = "n")
axis(1, at = tick_positions, labels = tick_labels)

# 3. Energy sub metering
plot(subset_data$datetime, subset_data$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black",
     xaxt = "n")
lines(subset_data$datetime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$datetime, subset_data$Sub_metering_3, col = "blue")
axis(1, at = tick_positions, labels = tick_labels)
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 1,
       bty = "n")

# 4. Global Reactive Power
plot(subset_data$datetime, subset_data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global Reactive Power",
     xaxt = "n")
axis(1, at = tick_positions, labels = tick_labels)

dev.off()