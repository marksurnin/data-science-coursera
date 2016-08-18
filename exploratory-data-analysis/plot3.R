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


# Plot 3

df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

## Add a DateTime column to the dataframe by merging Date and Time
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format = '%d/%m/%Y %H:%M:%S')

png('plot3.png')
plot(df$DateTime, df$Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering', cex = 0.64)
lines(df$DateTime, df$Sub_metering_3, col = 'blue')
lines(df$DateTime, df$Sub_metering_2, col = 'red')
lines(df$DateTime, df$Sub_metering_1)
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = c(2.5, 2.5, 2.5), col = c('black', 'red', 'blue'))
dev.off()