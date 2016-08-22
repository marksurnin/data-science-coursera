# Write a function that takes a directory of data files and a threshold for
# complete cases and calculates the correlation between sulfate and nitrate
# for monitor locations where the number of completely observed cases
# (on all variables) is greater than the threshold. The function
# should return a vector of correlations for the monitors that
# meet the threshold requirement. If no monitors meet the
# threshold requirement, then the function should return
# a numeric vector of length 0.

corr <- function(directory, threshold = 0) {
  completeFiles <- complete(directory)
  aboveThreshold <- completeFiles[completeFiles$nobs > threshold, ]
  indicesAboveThreshold <- aboveThreshold[, 1]

  corVector = numeric()

  if (nrow(aboveThreshold) == 0) {
    return(corVector)
  }
  
  for (i in indicesAboveThreshold) {
    index <- sprintf('%03d', i)
    filename <- paste(directory, '/', index, '.csv', sep='')
    data <- read.csv(filename)
    data <- data[complete.cases(data), ]
    corValue <- cor(data$sulfate, data$nitrate)
    corVector <- c(corVector, corValue)
  }
  
  corVector
}