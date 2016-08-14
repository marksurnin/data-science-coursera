rankall <- function(outcome, num = "best") {
  # Read outcome data.
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Construct a state vector
  state_vec <- unique(data$State)
  state_vec <- sort(state_vec)
  state_vec
  
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
  
  df <- data.frame(hospital = character(0), state = character(0), stringsAsFactors = FALSE)
  print(df)
  
  for (state in state_vec) {
    # Filter data by the given `state`.
    state_data <- data[data$State == state, ]
    state_data <- state_data[order(state_data[, feature_column], state_data$Hospital.Name, na.last = NA), ]
    
    result <- NA
    
    if (num == 'best') {
      result <- state_data[1, ]
    } else if (num == 'worst') {
      result <- state_data[nrow(state_data), ]
    } else if ((class(num) == 'numeric') && (num < nrow(state_data))) {
      result <- state_data[num, ]
    }
    
    # If the result is not NA, return the name of the hospital
    if (!is.na(result)) {
      temp_vec <- c(result$Hospital.Name, state)
    } else {
      # Return NA
      temp_vec <- c(result, state)
    }

    df[nrow(df) + 1, ] <- temp_vec
  }
  df
}