library(xgboost)

data <- read.csv("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Combined.csv")
wicket_model <- readRDS("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Code/Model/trained_model.rds")
summary(wicket_model)
# Data preprocessing
names(data)
selected_features <- c("balls", "batter_style", "bowler_style", "innings", "country", "toss_decision", "toss_winner")
X <- data[selected_features]
mean_balls <- mean(X$balls)
sd_balls <- sd(X$balls)

# Normalize the 'balls' column
normalized_balls <- (balls - mean_balls) / sd_balls
X$balls<-normalized_balls
# Convert categorical variables to numeric
X$batter_style <- ifelse(X$batter_style == "right", 1, 0)
X$bowler_style <- ifelse(X$bowler_style == "fast", 1, 0)
X$country <- ifelse(X$country == "India", 1, 0)
X$toss_decision <- ifelse(X$toss_decision == "bat", 1, 0)
X$toss_winner <- ifelse(X$toss_winner == "Australia", 1, 0)

y <- data$runsperball
length(unique(y))
# XGBoost model
model_xgb <- xgboost(data = as.matrix(X), label = as.matrix(y), nrounds = 100)
wickets=data$wickets
model_xgb <- xgboost(data = as.matrix(X), label = as.matrix(y), nrounds = 100)