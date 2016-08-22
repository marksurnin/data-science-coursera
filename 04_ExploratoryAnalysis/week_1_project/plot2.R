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


# Plot 2

## Add a DateTime column to the dataframe by merging Date and Time
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format = '%d/%m/%Y %H:%M:%S')

png('plot2.png')
plot(df$DateTime, df$Global_active_power, type = 'n', xlab = '', ylab = 'Global Active Power (kilowatts)')
lines(df$DateTime, df$Global_active_power)
dev.off()