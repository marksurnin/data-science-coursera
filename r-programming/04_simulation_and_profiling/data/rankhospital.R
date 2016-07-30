rankhospital <- function(state, outcome, num = "best") {
  # Read outcome data.
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check that state and outcome are valid.
  state_list <- unique(data$State)
  if (!is.element(state, state_list)) {
    stop("invalid state")
  }
  
  outcome_list <- c("heart attack", "heart failure", "pneumonia")
  if (!is.element(outcome, outcome_list)) {
    stop("invalid outcome")
  }
  
  # Filter data by the given `state`.
  data <- data[data$State == state, ]
  
  # Depending on the given `outcome`, cast that column to numeric.
  if (outcome == "heart attack") {
    feature_column = 11
    data[, feature_column] <- as.numeric(data[, feature_column])
  } else if (outcome == "heart failure") {
    feature_column = 17
    data[, feature_column] <- as.numeric(data[, feature_column])
  } else if (outcome == "pneumonia") {
    feature_column = 23
    data[, feature_column] <- as.numeric(data[, feature_column])
  }
  
  data <- data[order(data[, feature_column], na.last = NA), ]
  
  if (num == 'best') {
    result <- data[1, ]
  } else if (num == 'worst') {
    result <- data[nrow(data), ]
  } else if ((class(num) == 'numeric') && (num < nrow(data))) {
    result <- data[num, ]
  }
  
  result$Hospital.Name
}