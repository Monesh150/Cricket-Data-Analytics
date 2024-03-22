library(ggplot2)

# Sample data (replace with your actual dataset)
players <- c("Player A", "Player B", "Player C", "Player D", "Player E")
batting_averages <- c(35.6, 42.3, 28.7, 38.2, 32.5)

# Create a dataframe
data <- data.frame(Player = players, BattingAverage = batting_averages)

# Create a KDE plot of batting averages
ggplot(data, aes(x = BattingAverage)) +
  geom_density(fill = "blue", alpha = 0.5) +
  labs(title = "Kernel Density Estimation Plot of Batting Averages",
       x = "Batting Average",
       y = "Density")