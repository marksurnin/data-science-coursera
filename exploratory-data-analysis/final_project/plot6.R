# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

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

# Plot 6
NEI.Baltimore.Motor <- subset(NEI, fips == "24510" & type == "ON-ROAD")
NEI.LA.Motor <- subset(NEI, fips == "06037" & type == "ON-ROAD")
NEI.Motor <- rbind(NEI.Baltimore.Motor, NEI.LA.Motor)
emissions_by_year <- aggregate(Emissions ~ year + fips, NEI.Motor, FUN = sum)

## Convert fips to county name
emissions_by_year$fips <- replace(emissions_by_year$fips, emissions_by_year$fips == "24510", "Baltimore")
emissions_by_year$fips <- replace(emissions_by_year$fips, emissions_by_year$fips == "06037", "Los Angeles")
colnames(emissions_by_year)[2] = "county"
colnames(emissions_by_year)[3] <- "emissions"

png("plot6.png", width = 600, height = 450)
g <- ggplot(emissions_by_year, aes(factor(year), emissions, fill = factor(county)))
g <- g + geom_bar(position = "dodge", stat = "identity")
g <- g + labs(title = "Motor Emissions in Baltimore vs. Los Angeles", x = "Year", y = "Total PM2.5 emissions (tons)", fill = "County")
print(g)
dev.off()