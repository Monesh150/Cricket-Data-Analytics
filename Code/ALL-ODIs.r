# ball_by_ball = source('D:/Minor_Project-II/Code/Convert.R')
# over_by_over = source('D:/Minor_Project-II/Code/OverByOver.R')

# library(jsonlite)
# base_dir <- "E:/Minor Project-II/DATA/Male ODI"
# # year_folders <- list.files(base_dir)
# c=0
# aggregated_over_by_over = data.frame()
# json_files <- list.files(base_dir)
# # for (year in year_folders){
# #     json_files <- list.files(paste(base_dir, year, sep = "/"))
#     for (json_file in json_files){

#         print(json_file)
#         df = process_cricket_data(read_json(paste(base_dir, json_file, sep = "/")))
#         o_df = OverBYOver(df,json_file)
#         c = c+1
#         if(nrow(o_df)>0){
#             print('Aggregating')
#             aggregated_over_by_over = rbind(aggregated_over_by_over,o_df)
#         }
        
#     }

# # }
# write.csv(aggregated_over_by_over, "C:/Users/DELL/OneDrive/Desktop/AllODI.csv", row.names = FALSE)
# print(paste0(c,' files processed'))

# # df = process_cricket_data(read_json("D:/Minor_Project-II/Data/All India Matches/ODI/2003/66356.json"))
# # print(df)

# Load necessary libraries
library(tidyr)
library(dplyr)
library(caret)

# Read the aggregated CSV file
# data <- read.csv("D:/Minor_Project-II/Data/Datasets/OverByOver/Aggregated.csv")
data <- read.csv("D:/Minor_Project-II/Data/All India Matches/AllODI.csv")
data <- rbind(data,aggregated_over_by_over)
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

# saveRDS(model, "D:/Minor_Project-II/Code/Model/score_prediction_model.rds")