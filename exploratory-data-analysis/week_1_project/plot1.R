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


# Plot 1

df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

png('plot1.png')
hist(df$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red')
dev.off()