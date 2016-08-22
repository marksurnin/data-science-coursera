# Setup
library(ggplot2)
library(grid)

if (!dir.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1471996800&Signature=kFfSXKWMFIEoAo6ThsGgGdv9~HiXeLFdd-395oRYlWw8YtKKQuTBFMBAwre6GGiLYGj-~zjFhtiuytvPJeT2pceZWmpVrbRPqgvStiJiS8-m65enZ2q0idEaLYosCnozYUyeXADsa-3OzSnS8AQFc5BGz394f~DJ05gWUji6dcY_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"
download.file(fileUrl, destfile = "data/payments.csv", method = "curl")

payments <- read.csv("./data/payments.csv", header = TRUE)

# Plot 1
pdf("plot1.pdf")              # Log scale suits this range better
ggplot(payments, aes(log10(Average.Covered.Charges), log10(Average.Total.Payments))) +
  geom_point(alpha = 1/8) +   # Set opacity to see point density
  geom_smooth() +             # Add a loess fit curve with confidence region
  ggtitle("Mean Covered Charges vs Mean Total Payments in New York") +
  theme_bw() +
  theme(plot.title = element_text(size=12))
dev.off()


# Plot2
pdf("plot2.pdf")
p1 <- ggplot(payments, aes(log(Average.Covered.Charges), log(Average.Total.Payments), color = DRG.Definition)) +
  geom_point(alpha = 1/8) +   # Set opacity to see point density
  geom_smooth() +             # Add a loess fit curve with confidence region
  ggtitle("Mean Covered Charges vs Mean Total Payments in New York by Medical Condition") +
  theme_bw() +
  theme(plot.title = element_text(size=10), legend.text=element_text(size=6)) +
  scale_color_discrete(name="Medical Condition",
                       labels=c("Simple pneumonia & pleurisy",
                                "Heart failure & shock",
                                "Digestive disorders",
                                "Miscellaneous disorders",
                                "Kidney & urinary tract infections",
                                "Septicemia or severe sepsis"))

p2 <- ggplot(payments, aes(log(Average.Covered.Charges), log(Average.Total.Payments), color = Provider.State)) +
  geom_point(alpha = 1/8) +   # Set opacity to see point density
  geom_smooth() +             # Add a loess fit curve with confidence region
  ggtitle("Mean Covered Charges vs Mean Total Payments in New York by State") +
  theme_bw() +
  theme(plot.title = element_text(size=10), legend.text=element_text(size=6)) +
  scale_color_discrete(name = "State",
                       labels = c("California",
                                  "Florida",
                                  "Illionois",
                                  "New York",
                                  "Pennsylvania",
                                  "Texas"))

pushViewport(viewport(layout = grid.layout(2, 1)))
print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
dev.off()