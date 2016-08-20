# How have emissions from motor vehicle sources
# changed from 1999–2008 in Baltimore City?

# Setup
library(ggplot2)

if (!dir.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "data/data.zip", method = "curl")
unzip("./data/data.zip", exdir = "./data")

# Read files into working directory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Plot 5
NEI.Baltimore.Motor <- subset(NEI, fips == "24510" & type == "ON-ROAD")
emissions_by_year <- aggregate(Emissions ~ year, NEI.Baltimore.Motor, FUN = sum)
colnames(emissions_by_year)[2] <- "emissions"

png("plot5.png", width = 600, height = 450)
g <- ggplot(emissions_by_year, aes(factor(year), emissions))
g <- g + geom_bar(stat = "identity")
g <- g + labs(title = "Motor Vehicle Emissions in Baltimore City", x = "Year", y = "Total PM2.5 emissions (tons)")
print(g)
dev.off()