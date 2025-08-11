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
##Plot 1: Frequency Y-axis, Global Active Power X-axis
par(mfrow = c(1,1))
png(filename = "plot1.png", width = 480, height = 480)
hist(subset_data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     breaks = 15)
dev.off()