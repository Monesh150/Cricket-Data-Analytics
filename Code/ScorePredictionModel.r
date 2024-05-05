# Load necessary libraries
library(tidyr)
library(dplyr)
library(caret)

# Read the aggregated CSV file
data <- read.csv("D:/Minor_Project-II/Data/Datasets/OverByOver/Aggregated.csv")

# Handle missing values
data$required_run_rate[is.na(data$required_run_rate)] <- 0  # Substitute NA with 0 in required run rate

# Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_index <- createDataPartition(data$score, p = 0.8, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Define features and target variable
features <- c("over", "wickets_in_over", 
              "runs_in_over", "run_rate", "required_run_rate", "runs_in_previous_3_overs", "innings")
target <- "score"

# Train the model
model <- train(
  score ~ ., 
  data = train_data[, c(features, target)], 
  method = "lm"  # Linear regression
)

# Evaluate the model
predictions <- predict(model, newdata = test_data[, features])
mae <- mean(abs(predictions - test_data$score))
mse <- mean((predictions - test_data$score)^2)
rmse <- sqrt(mse)

# Print evaluation metrics
cat("Mean Absolute Error (MAE):", mae, "\n")
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")
input_data <- data.frame(
  over = c(25, 46, 47),  # Example over numbers
  wickets_in_over = c(0, 1, 1),  # Example wickets in each over
  wickets_in_prev_3_overs = c(1, 2, 2),  # Example wickets in previous 3 overs
  runs_in_over = c(10, 8, 6),  # Example runs scored in each over
  run_rate = c(7.5, 4.3, 4.0),  # Example run rate
  required_run_rate = c(0, 6.2, 6.2),  # Example required run rate
  runs_in_previous_3_overs = c(20, 18, 16),  # Example runs scored in previous 3 overs
  innings = c(1, 2, 2)  # Example innings (2nd innings)
)

# Make predictions
predictions <- predict(model, newdata = input_data)

# Print predictions
print(ceiling(predictions))

saveRDS(model, "D:/Minor_Project-II/Code/Model/score_prediction_model.rds")
###########################Hybrid-Model-Here#####################################
# # Load necessary libraries
# library(tidyr)
# library(dplyr)
# library(caret)
# library(randomForest)
# # Read the aggregated CSV file
# data <- read.csv("D:/Minor_Project-II/Data/Datasets/OverByOver/Aggregated.csv")

# # Handle missing values
# data$required_run_rate[is.na(data$required_run_rate)] <- 0  # Substitute NA with 0 in required run rate

# # Split the data into training and testing sets
# set.seed(123)  # For reproducibility
# train_index <- createDataPartition(data$score, p = 0.8, list = FALSE)
# train_data <- data[train_index, ]
# test_data <- data[-train_index, ]

# # Define features and target variable
# features <- c("over", "wickets_in_over", 
#               "runs_in_over", "run_rate", "required_run_rate", "runs_in_previous_3_overs", "innings")
# target <- "score"

# # Train the model
# model_lm <- train(
#   score ~ ., 
#   data = train_data[, c(features, target)], 
#   method = "lm"  # Linear regression
# )

# # Evaluate the model
# model_rf <- randomForest(
#   score ~ ., 
#   data = train_data[, c(features, target)]
# )

# # Combine predictions from base models
# predictions_lm <- predict(model_lm, newdata = test_data[, features])
# predictions_rf <- predict(model_rf, newdata = test_data[, features])
# predictions_hybrid <- (predictions_lm + predictions_rf) / 2  # Average predictions

# # Evaluate the hybrid model
# mae_hybrid <- mean(abs(predictions_hybrid - test_data$score))
# mse_hybrid <- mean((predictions_hybrid - test_data$score)^2)
# rmse_hybrid <- sqrt(mse_hybrid)

# # Print evaluation metrics for the hybrid model
# cat("Hybrid Model - Mean Absolute Error (MAE):", mae_hybrid, "\n")
# cat("Hybrid Model - Mean Squared Error (MSE):", mse_hybrid, "\n")
# cat("Hybrid Model - Root Mean Squared Error (RMSE):", rmse_hybrid, "\n")

# #Custom Predictions
# input_data <- data.frame(
#   over = c(25, 46, 47),  # Example over numbers
#   wickets_in_over = c(0, 1, 1),  # Example wickets in each over
#   wickets_in_prev_3_overs = c(1, 2, 2),  # Example wickets in previous 3 overs
#   runs_in_over = c(10, 8, 6),  # Example runs scored in each over
#   run_rate = c(7.5, 4.3, 4.0),  # Example run rate
#   required_run_rate = c(0, 6.2, 6.2),  # Example required run rate
#   runs_in_previous_3_overs = c(20, 18, 16),  # Example runs scored in previous 3 overs
#   innings = c(1, 2, 2)  # Example innings (2nd innings)
# )

# # Make predictions
# predictions <- predict(model, newdata = input_data)

# # Print predictions
# print(ceiling(predictions))

