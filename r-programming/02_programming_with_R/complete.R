# Write a function that reads a directory full of files and reports the number
# of completely observed cases in each data file. The function should return
# a data frame where the first column is the name of the file and the second
# column is the number of complete cases.

complete <- function(directory, id = 1:332) {
  indices = numeric()
  numOfCompleteCases = numeric()
  
  for (i in id) {
    index <- sprintf('%03d', i)
    filename <- paste(directory, '/', index, '.csv', sep='')
    newRead <- read.csv(filename)
    good <- complete.cases(newRead)
    numOfCompleteCases <- c(numOfCompleteCases, length(which(good)))
    indices <- c(indices, i)
  }
  
  df <- data.frame('id' = indices, 'nobs' = numOfCompleteCases)
  df
}