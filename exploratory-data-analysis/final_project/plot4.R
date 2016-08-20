# Across the United States, how have emissions from coal combustion-related sources
# changed from 1999–2008?

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

# Plot 4
indices <- grep("coal", SCC$Short.Name, ignore.case=TRUE)
SCC.Coal <- SCC[indices, ]
NEI.Coal <- NEI[NEI$SCC %in% SCC.Coal$SCC, ]

emissions_by_year <- aggregate(Emissions ~ year, NEI.Coal, FUN = sum)
colnames(emissions_by_year)[2] <- "emissions"

png("plot4.png", width = 600, height = 450)
g <- ggplot(emissions_by_year, aes(factor(year), emissions))
## Tell ggplot that the data is already summarised via geom_bar(stat = "identity")
g <- g + geom_bar(stat = "identity")
g <- g + labs(title = "Emissions from Coal Combusion Related Sources", x = "Year", y = "Total PM2.5 emissions (tons)")
print(g)
dev.off()