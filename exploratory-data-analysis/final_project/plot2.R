# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system
# to make a plot answering this question.

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

# Plot 2
NEI.Baltimore <- subset(NEI, fips == "24510")
emissions_by_year <- aggregate(Emissions ~ year, NEI.Baltimore, FUN = sum)
colnames(emissions_by_year)[2] <- "emissions"

png("plot2.png", width = 600, height = 450)
par(mar = c(5, 5, 3, 1))
barplot(emissions_by_year$emissions, names = emissions_by_year$year, xlab = "Year", ylab = "Total PM2.5 emissions (tons)", main = "PM2.5 Emissions in Baltimore City by Year")
#abline(lm(emissions_by_year$emissions ~ emissions_by_year$year))
dev.off()