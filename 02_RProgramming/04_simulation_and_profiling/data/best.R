best <- function(state, outcome) {
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
  
  # Filter data by the given `state`.
  data <- data[data$State == state, ]
  
  # Find the row(s) in the data frame with the minimum value for the given outcome.
  minimum <- data[which(data[feature_column] == min(data[feature_column], na.rm = TRUE)), ]
  
  # In case there is a tie, sort hospitals by name and return the first one.
  if (nrow(minimum) > 1) {
    minimum <- minimum[order(minimum$Hospital.Name), ] 
    minimum <- minimum[1, ]
  }
  minimum$Hospital.Name
}