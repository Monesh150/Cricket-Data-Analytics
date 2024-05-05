library(randomForest)
library(rpart)
library(caret)

# df <- read.csv("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Combined.csv")
df <- read.csv("D:/Minor_Project-II/Data/Combined.csv")

selected_features <- c("batter_style", "wickets", "bowler_style")
x <- df[selected_features]

x$batter_style <- ifelse(x$batter_style == "right", 0, 1)
x$bowler_style <- ifelse(x$bowler_style == "fast", 0, 1)

y <- df$balls

models <- list(
  linear_reg = caret::train(x, y, method = "lm"),
  rf_model = caret::train(x, y, method = "rf"),
  xgboost = caret::train(x, y, method = "xgbTree")
)

predictions <- data.frame(
  linear_reg = predict(models$linear_reg, newdata = x),
  rf_model = predict(models$rf_model, newdata = x),
  xgboost = predict(models$xgboost, newdata = x, iteration_range = c(1, models$xgboost$bestTune$nrounds))
)

stack_model <- caret::train(
  x = predictions,
  y = y,
  method = "lm"
)

stacked_predictions <- predict(stack_model, newdata = predictions)

mae <- mean(abs(y - stacked_predictions))
rmse <- sqrt(mean((y - stacked_predictions)^2))

cat("Stacked Model MAE:", mae, "\n")
cat("Stacked Model RMSE:", rmse, "\n")

new_data <- data.frame(
  batter_style = 0,
  wickets = 1,
  bowler_style = 0
)

new_predictions <- data.frame(
  linear_reg = predict(models$linear_reg, newdata = new_data),
  rf_model = predict(models$rf_model, newdata = new_data),
  xgboost = predict(models$xgboost, newdata = new_data, iteration_range = c(1, models$xgboost$bestTune$nrounds))
)

final_predictions <- predict(stack_model, newdata = new_predictions)

print(final_predictions)

# saveRDS(stack_model, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Code/Model/hybrid_wicket_trained_model.rds")
saveRDS(stack_model, "D:/Minor_Project-II/Code/Model/hybrid_wicket_trained_model.rds")
