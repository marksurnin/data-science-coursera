# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in emissions
#from 1999–2008 for Baltimore City? Which have seen increases in emissions
#from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

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

# Plot 3
NEI.Baltimore <- subset(NEI, fips == "24510")
emissions_by_year <- aggregate(Emissions ~ year + type, NEI.Baltimore, FUN = sum)
colnames(emissions_by_year)[3] <- "emissions"

png("plot3.png", width = 600, height = 450)
g <- ggplot(emissions_by_year, aes(factor(year), emissions, color = type, group = type))
g <- g + geom_point()
g <- g + geom_line()
g <- g + labs(title = "Emission by Type in Baltimore City, Maryland", x = "Year", y = "Total PM2.5 emissions (tons)")
print(g)
dev.off()