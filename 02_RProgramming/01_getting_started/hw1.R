data <- read.csv("hw1_data.csv")
good <- complete.cases(data)

# Extract the first 2 rows of the data frame and print them
# to the console. What does the output look like?
head(data, 2)

# How many observations (i.e. rows) are in this data frame? 153
nrow(data)

# Extract the last 2 rows of the data frame and print them
# to the console. What does the output look like?
tail(data, 2)

# What is the value of Ozone in the 47th row? 21
data[47,1]

# How many missing values are in the Ozone column of this data frame? 37
length(which(is.na(data[,1])))

# What is the mean of the Ozone column in this dataset?
# Exclude missing values (coded as NA) from this calculation.
## Indices of entries with non-NA Ozone values
indices <- which(!is.na(data[,1]))
## Actual values
values <- data[indices, 1]
## Get their mean ~42.1
mean(values)

# Extract the subset of rows of the data frame
# where Ozone values are above 31 and Temp values
# are above 90. What is the mean of Solar.R in this subset?

airquality <- data[good, ]

airquality <- airquality[airquality$Ozone > 31, ]
airquality <- airquality[airquality$Temp > 90, ]
head(airquality)
mean(airquality[, 2]) #212.8


# What is the mean of "Temp" when "Month" is equal to 6?

airquality <- data[good, ]
airquality <- airquality[airquality$Month == 6, ]
mean(airquality[, 4])

# What was the maximum ozone value in the month of May (i.e. Month is equal to 5)? 115

airquality <- data[good, ]
airquality <- airquality[airquality$Month == 5, ]
max(airquality[, 1])

