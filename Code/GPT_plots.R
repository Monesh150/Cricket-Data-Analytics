# Load necessary libraries
library(ggplot2)
# library(dplyr)
library(plotly)

# Read the dataset
data <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv")
# print(data)
# # 1. Violin Plot of Batting Averages and Bowling Averages
p <- ggplot(data, aes(x = country, y = batting_average, fill = country)) +
  geom_violin(trim = FALSE) +
  labs(title = "Distribution of Batting Averages by Country") +
  scale_fill_manual(values = c("Australia" = "yellow", "India" = "blue")) +  # Customize fill colors
  theme_minimal()

# Print the plot
print(p)

# ggplot(data, aes(x = country, y = economy, fill = country)) +
#   geom_violin(trim = FALSE) +
#   labs(title = "Distribution of Ecomonies by Country") +
#   theme_minimal()

# 2. Heatmap of Batting and Bowling Performance Metrics
# heatmap_data <- select(data, player, runs, out, balls, country, batting_average, strike_rate)

# # Convert the data to a dataframe
# heatmap_data <- as.data.frame(heatmap_data)

# # Set the 'player' column as row names
# rownames(heatmap_data) <- heatmap_data$player
# heatmap_data$player <- NULL

# # Convert any character columns to numeric (if needed)
# heatmap_data <- mutate_if(heatmap_data, is.character, as.numeric)

# # Plot the heatmap
# heatmap(as.matrix(heatmap_data), Rowv = NA, Colv = NA, col = cm.colors(256), scale = "column", margins = c(5, 10))

# 3. Joint Distribution Plot of Batting and strike rates
# ggplot(data, aes(x = bowling_average, y = economy, color = country)) +
#   geom_point() +
#   geom_smooth(method = "lm", se = FALSE) +
#   labs(title = "Joint Distribution of Bowling Averages and Economies") +
#   scale_color_manual(values = c("India" = "blue", "Australia" = "yellow")) + # Differentiate colors for both teams
#   theme_minimal()

# # 4. Clustered Bar Chart of Player Statistics by Country
# Create a ggplot object
# p <- ggplot(data, aes(x = player, y = wickets, fill = country)) +
#   geom_bar(stat = "identity", position = "dodge") +
#   labs(title = "Wickets Taken by Player and Country", x = "Player", y = "Wickets") + # Add axis labels
#   theme_minimal()

# # # Convert the ggplot object to a plotly object
# p <- ggplotly(p, tooltip = c("player", "wickets"))  # Set tooltip to show player's name and runs

# # # Print the plot
# print(p)


# # 5. Interactive Bubble Chart of Player Performance Metrics


# plot_ly(data, x = ~score, y = ~wickets, size = ~economy,
#         color = ~country, text = ~player, hoverinfo = "text",
#         mode = "markers", type = "scatter") %>%
#   layout(title = "Bubble Chart of Bowler Performance Metrics",
#          xaxis = list(title = "Runs Conceded"),
#          yaxis = list(title = "wickets"),
#          showlegend = TRUE)

# # 6. Pairwise Scatterplot Matrix of Performance Metrics
# pairs(data[, c("runs", "batting_average", "bowling_average")])

# # 7. Network Analysis of Player Collaborations (Optional)
# # You may need to preprocess the data to create a network graph

