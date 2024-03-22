# library(ggplot2)

# # Sample data (replace with your actual dataset)
# #players1 <- c("Player A", "Player B", "Player C", "x", "Player D", "Player E")
# batting_averages1 <- c(35.6, 42.3, 28.7, 38.2, 0, 32.5)
# #players2 <- c("Player A", "Player B", "Player C", "x", "Player D", "Player E")
# batting_averages2 <- c(30, 42.3, 18.7, 32.2, 0, 0.5)

# # Create dataframes
# data1 <- data.frame(BattingAverage = batting_averages1)
# data2 <- data.frame(BattingAverage = batting_averages2)

# # Add a grouping variable to distinguish between the two datasets
# data1$Group <- "Group 1"
# data2$Group <- "Group 2"

# # Merge the datasets
# combined_data <- rbind(data1, data2)

# # Create a KDE plot of batting averages
# ggplot(combined_data, aes(x = BattingAverage, fill = Group, color = Group)) +
#   geom_density(alpha = 0.7) +
#   labs(title = "Kernel Density Estimation Plot of Batting Averages",
#        x = "Batting Average",
#        y = "Density") +
#   scale_fill_manual(values = c("blue", "orange")) +
#   scale_color_manual(values = c("blue", "orange")) +
#   theme_minimal()
# print("Rough.R executed successfully!")


data <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv")
for (i in 1:nrow(data)){
  
    print(data[i,]$player)
}