# Setup

if (!dir.exists('./data')) {
  dir.create('./data')
}

fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile = './data/dataset.zip', method = 'curl')
unzip('./data/dataset.zip', exdir = './data')

files <- list.files('./data')

df <- read.table(file = './data/household_power_consumption.txt', sep = ';', header = TRUE)
## Select data from the 2-day period in February, 2007.
df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007", ]


# Plot 4

df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

## Add a DateTime column to the dataframe by merging Date and Time
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format = '%d/%m/%Y %H:%M:%S')

png('plot4.png')
par(mfrow = c(2, 2), mar = c(5, 5, 2, 1))

## 1)
plot(df$DateTime, df$Global_active_power, type = 'n', xlab = '', ylab = 'Global Active Power')
lines(df$DateTime, df$Global_active_power)

## 2)
plot(df$DateTime, df$Voltage, type = 'n', xlab = 'datetime', ylab = 'Voltage')
lines(df$DateTime, df$Voltage)

## 3)
plot(df$DateTime, df$Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering', cex = 0.64)
lines(df$DateTime, df$Sub_metering_3, col = 'blue')
lines(df$DateTime, df$Sub_metering_2, col = 'red')
lines(df$DateTime, df$Sub_metering_1)
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = c(2.5, 2.5, 2.5), col = c('black', 'red', 'blue'))

## 4)
plot(df$DateTime, df$Global_reactive_power, type = 'n', xlab = 'datetime', ylab = 'Global_reactive_power')
lines(df$DateTime, df$Global_reactive_power)

dev.off()