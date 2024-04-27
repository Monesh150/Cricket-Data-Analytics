# Read the data
data <- read.csv("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Combined.csv")

# Select features
selected_features <- c("batter_style", "wickets", "bowler_style")
x <- data[selected_features]

# Convert categorical variables to numeric
x$batter_style <- ifelse(x$batter_style == "right", 0, 1)
x$bowler_style <- ifelse(x$bowler_style == "fast", 0, 1)

# Extract the target variable
y <- data$balls

# Train a linear regression model
model <- lm(y ~ ., data = x)

summary(model)
# Predict using the trained model
new_data <- data.frame(batter_style = 0, wickets = 1, bowler_style = 0)  # Example new data
predicted_value <- predict(model, newdata = new_data)

# Print the predicted value
print(predicted_value)
# Save the trained model to a file
saveRDS(model, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Code/Model/trained_model.rds")

