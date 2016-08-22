# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Setup
if (!dir.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "data/data.zip", method = "curl")
unzip("./data/data.zip", exdir = "./data")

# Read files into working directory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Plot 1
emissions_by_year <- aggregate(NEI$Emissions, by = NEI["year"], FUN = sum)
colnames(emissions_by_year)[2] <- "emissions"

png("plot1.png", width = 600, height = 450)
par(mar = c(5, 5, 3, 1))
barplot(emissions_by_year$emissions, names = emissions_by_year$year, xlab = "Year", ylab = "Total PM2.5 emissions (tons)", main = "PM2.5 Emissions in the United States by Year")
dev.off()