# library(ggplot2)
# library(ggpubr)

# # Load the trained stacked model
stack_model <- readRDS("D:/Minor_Project-II/Code/Model/hybrid_wicket_trained_model.rds")
print(str(stack_model))
# # df <- read.csv("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Combined.csv")
# df <- read.csv("D:/Minor_Project-II/Data/Combined.csv")


# selected_features <- c("batter_style", "wickets", "bowler_style")
# x <- df[selected_features]

# x$batter_style <- ifelse(x$batter_style == "right", 0, 1)
# x$bowler_style <- ifelse(x$bowler_style == "fast", 0, 1)

# y <- df$balls
# # Make predictions using the loaded model
# stacked_predictions <- predict(stack_model, newdata = x)

# # Calculate evaluation metrics
# mae <- mean(abs(y - stacked_predictions))
# rmse <- sqrt(mean((y - stacked_predictions)^2))

# cat("Stacked Model MAE:", mae, "\n")
# cat("Stacked Model RMSE:", rmse, "\n")

# # Generate predictions for new data
# new_data <- data.frame(
#   batter_style = 0,
#   wickets = 1,
#   bowler_style = 0
# )

# new_predictions <- data.frame(
#   linear_reg = predict(models$linear_reg, newdata = new_data),
#   rf_model = predict(models$rf_model, newdata = new_data),
#   xgboost = predict(models$xgboost, newdata = new_data, iteration_range = c(1, models$xgboost$bestTune$nrounds))
# )

# final_predictions <- predict(stack_model, newdata = new_predictions)

# print(final_predictions)

# # Actual vs. Predicted Plot
# actual_vs_predicted <- ggplot(data.frame(actual = y, predicted = stacked_predictions), aes(x = actual, y = predicted)) +
#   geom_point() +
#   geom_abline(intercept = 0, slope = 1, color = "red") +
#   labs(x = "Actual Balls", y = "Predicted Balls", title = "Actual vs. Predicted Plot")

# # Residuals Plot
# residuals_plot <- ggplot(data.frame(residuals = residuals(stack_model)), aes(x = residuals)) +
#   geom_histogram(bins = 30, fill = "skyblue", color = "black", alpha = 0.7) +
#   labs(x = "Residuals", y = "Frequency", title = "Residuals Plot")

# # Combine plots in a single canvas
# combined_plot <- ggarrange(actual_vs_predicted, residuals_plot, ncol = 2)

# # Print the combined plot
# print(combined_plot)
