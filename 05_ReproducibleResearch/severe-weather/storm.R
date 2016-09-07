# Setup
library(ggplot2)
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
health.harm <- aggregate(Injuries + Fatalities ~ Event.Type, storm.data, sum)
names(health.harm)[2] <- "Total.Casualties"
health.harm <- health.harm[order(health.harm$Total.Casualties, decreasing = TRUE), ]
head(health.harm, 10)

## Make health.harm$EVTYPE an ordered factor
health.harm$Event.Type <- factor(health.harm$Event.Type, levels = health.harm$Event.Type)

ggplot(health.harm[1:10,], aes(factor(Event.Type), Total.Casualties)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x  = element_text(angle=30, hjust = 0.9, vjust = 0.9)) +
  xlab("Event type") + ylab("Total Casualties") + ggtitle("Most Harmful Weather Event Types")


# 2
temp <- subset(storm.data, PROPDMGEXP == "K" | PROPDMGEXP == "M" | PROPDMGEXP == "B" | CROPDMGEXP == "K" | CROPDMGEXP == "M" | CROPDMGEXP == "B")
temp$PROPDMGEXP <- as.numeric(lapply(temp$PROPDMGEXP, function (x) if (x=="K") 1000 else if (x=="M") 1e+06 else if (x=="B") 1e+09 else 0))
temp$CROPDMGEXP <- as.numeric(lapply(temp$CROPDMGEXP, function (x) if (x=="K") 1000 else if (x=="M") 1e+06 else if (x=="B") 1e+09 else 0))

temp$PROPDMGNUM <- temp$PROPDMG * temp$PROPDMGEXP
temp$CROPDMGNUM <- temp$CROPDMG * temp$CROPDMGEXP

head(temp)

econ.harm <- aggregate(PROPDMGNUM + CROPDMGNUM ~ Event.Type, temp, sum)
names(econ.harm)[2] <- "Amount"
econ.harm <- econ.harm[order(econ.harm$Amount, decreasing = TRUE), ]

## Make health.harm$EVTYPE an ordered factor
econ.harm$Event.Type <- factor(econ.harm$Event.Type, levels = econ.harm$Event.Type)

ggplot(econ.harm[1:10,], aes(factor(Event.Type), Amount/1e+09)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 30, hjust = 0.9, vjust = 0.9)) +
  xlab("Event Type") + ylab("Damage amount (in billions, USD)") + ggtitle("Most Economically Harmful Weather Event Types")
