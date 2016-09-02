# Setup
library(ggplot2)
library(grid)
library(data.table)


if (!dir.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
download.file(fileUrl, destfile = "./data/storm_data.csv.bz2", method = "curl")

storm.data <- read.csv("./data/storm_data.csv.bz2")
setnames(storm.data, old = c("EVTYPE","INJURIES", "FATALITIES"), new = c("Event.Type", "Injuries", "Fatalities"))
storm.data$Event.Type <- tolower(storm.data$Event.Type)

# 1.
harmful <- aggregate(Injuries + Fatalities ~ Event.Type, storm.data, sum)
names(harmful)[2] <- "Total.Casualties"
harmful <- harmful[order(harmful$Total.Casualties, decreasing = TRUE), ]
head(harmful, 10)
## Make harmful$EVTYPE an ordered factor
harmful$Event.Type <- factor(harmful$Event.Type, levels = harmful$Event.Type)

ggplot(harmful[1:10,], aes(factor(Event.Type), Total.Casualties)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x  = element_text(angle=30, hjust = 0.9, vjust=0.9)) +
  xlab("Event type") + ylab("Total Casualties") + ggtitle("Most Harmful Severe Weather Event Types")


# 2
damage <- subset(storm.data, PROPDMGEXP == "K" | PROPDMGEXP == "M" | PROPDMGEXP == "B" | CROPDMGEXP == "K" | CROPDMGEXP == "M" | CROPDMGEXP == "B")
damage$PROPDMGEXP <- as.numeric(lapply(damage$PROPDMGEXP, function (x) if (x=="K") 1000 else if (x=="M") 1e+06 else if (x=="B") 1e+09 else 0))
damage$CROPDMGEXP <- as.numeric(lapply(damage$CROPDMGEXP, function (x) if (x=="K") 1000 else if (x=="M") 1e+06 else if (x=="B") 1e+09 else 0))

damage$PROPDMGNUM <- damage$PROPDMG * damage$PROPDMGEXP
damage$CROPDMGNUM <- damage$CROPDMG * damage$CROPDMGEXP
# damage <- damage[]