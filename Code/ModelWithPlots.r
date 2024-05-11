# Load necessary libraries
library(tidyr)
library(dplyr)
library(caret)
library(ggplot2)
library(ggpubr)
library(pdp)

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

# Check if the columns exist in the training data
if (all(features %in% colnames(train_data)) && target %in% colnames(train_data)) {
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

  # Actual vs. Predicted Plot
  actual_vs_predicted <- ggplot() +
    geom_point(aes(x = test_data$score, y = predictions)) +
    geom_abline(intercept = 0, slope = 1, color = "red") +
    labs(x = "Actual Score", y = "Predicted Score", title = "Actual vs. Predicted Plot")

  # Distribution of Residuals
  residuals_distribution <- ggplot() +
    geom_histogram(aes(x = residuals(model), fill = "Residuals"), bins = 30, alpha = 0.7) +
    labs(x = "Residuals", y = "Frequency", title = "Distribution of Residuals")

  # Feature Importance Plot
  feature_importance <- varImp(model)$importance
  feature_importance_plot <- ggplot(as.data.frame(feature_importance), aes(x = reorder(rownames(feature_importance), Overall), y = Overall)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    coord_flip() +
    labs(x = "Features", y = "Importance", title = "Feature Importance Plot")

  # Calculate RMSE for different training set sizes
  train_sizes <- seq(0.1, 0.9, by = 0.1)
  rmse_values <- sapply(train_sizes, function(size) {
    train_index <- sample(1:nrow(train_data), size = size * nrow(train_data))
    model <- train(
      score ~ ., 
      data = train_data[train_index, c(features, target)], 
      method = "lm"
    )
    predictions <- predict(model, newdata = test_data[, features])
    rmse <- sqrt(mean((predictions - test_data$score)^2))
    return(rmse)
  })

  # Learning Curve
  learning_curve <- ggplot() +
    geom_line(aes(x = train_sizes, y = rmse_values)) +
    labs(x = "Training Set Size", y = "RMSE", title = "Learning Curve")

  # Partial Dependence Plots (PDP)
  partial_dependence_plots <- list()
  for (feature in features) {
    pdp_data <- partial(model, pred.var = feature)
    pdp_plot <- autoplot(pdp_data, feature = feature) +
      labs(title = paste("Partial Dependence Plot for", feature))
    partial_dependence_plots[[feature]] <- pdp_plot
  }

  # Residuals vs. Features Plots
  residuals_vs_features_plots <- list()
  for (feature in setdiff(features, "wickets_in_prev_3_overs")) {
    residuals_vs_feature_plot <- ggplot(train_data, aes_string(x = feature, y = residuals(model))) +
      geom_point() +
      geom_smooth() +
      labs(x = feature, y = "Residuals", title = paste("Residuals vs.", feature))
    residuals_vs_features_plots[[feature]] <- residuals_vs_feature_plot
  }

  # Combine all plots in a single canvas
  combined_plot <- ggarrange(actual_vs_predicted, residuals_distribution, feature_importance_plot, learning_curve, 
                             ncol = 2, nrow = 2, labels = c("A", "B", "C", "D"), common.legend = TRUE)

  # Print the combined plot
  print(combined_plot)

  # Save the combined plot to a file
  # ggsave("combined_plot.png", combined_plot, width = 15, height = 12, units = "cm")
} else {
  cat("Some of the specified columns do not exist in the training data.")
}
