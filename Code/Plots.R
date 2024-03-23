library(ggplot2)
# data <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv")
# aus_players_strike_rate <- data.frame( strike_rate = numeric())
# aus_players_batting_avg <- data.frame( batting_avg = numeric())
# ind_players_strike_rate <- data.frame(strike_rate = numeric())
# ind_players_batting_avg <- data.frame(batting_avg = numeric())
# for (i in 1:nrow(data)) {
#   if (data$country[i] == "Australia") {
#     aus_players_strike_rate <- rbind(aus_players_strike_rate, data.frame(strike_rate = data$strike_rate[i]))
#     aus_players_batting_avg <- rbind(aus_players_batting_avg, data.frame(batting_avg = data$batting_average[i]))
#   } 
#   else{
#     ind_players_strike_rate <- rbind(ind_players_strike_rate, data.frame(strike_rate = data$strike_rate[i]))
#     ind_players_batting_avg <- rbind(ind_players_batting_avg, data.frame(batting_avg = data$batting_average[i]))

#   }
# }

# aus_players_strike_rate$Group <- "Australia"
# ind_players_strike_rate$Group <- "India"

# combined_data <- rbind( aus_players_strike_rate, ind_players_strike_rate)
# # Create a KDE plot of strike rates
# strike_rate_plot<-ggplot(combined_data, aes(x = strike_rate, fill = Group, color = Group)) +
#   geom_density(alpha = 0.7) +
#   labs(title = "Kernel Density Estimation Plot of Strike Rates",
#        x = "Strike Rate",
#        y = "Density") +
#   scale_fill_manual(values = c("yellow","blue")) +
#   scale_color_manual(values = c("yellow","blue")) +
#   theme_minimal()

# aus_players_batting_avg$Group <- "Australia"
# ind_players_batting_avg$Group <- "India"
# combined_data <- rbind( aus_players_batting_avg, ind_players_batting_avg)
# # Create a KDE plot of strike rates
# batting_avg_plot<-ggplot(combined_data, aes(x = batting_avg, fill = Group, color = Group)) +
#   geom_density(alpha = 0.7) +
#   labs(title = "Kernel Density Estimation Plot of Batting Averages",
#        x = "Batting Average",
#        y = "Density") +
#   scale_fill_manual(values = c("yellow","blue")) +
#   scale_color_manual(values = c("yellow","blue")) +
#   theme_minimal()


# library(gridExtra)

# grid.arrange(strike_rate_plot, batting_avg_plot, nrow = 1)

#Bowler Analysis

# data <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BowlerStats.csv")
# aus_players_economy <- data.frame( economy = numeric())
# aus_players_bowling_avg <- data.frame( bowling_avg = numeric())
# ind_players_economy <- data.frame(economy = numeric())
# ind_players_bowling_avg <- data.frame(bowling_avg = numeric())
# for (i in 1:nrow(data)) {
#   if (data$country[i] == "Australia") {
#     aus_players_economy <- rbind(aus_players_economy, data.frame(economy = data$economy[i]))
#     aus_players_bowling_avg <- rbind(aus_players_bowling_avg, data.frame(bowling_avg = data$bowling_average[i]))
#   } 
#   else{
#     ind_players_economy <- rbind(ind_players_economy, data.frame(economy = data$economy[i]))
#     ind_players_bowling_avg <- rbind(ind_players_bowling_avg, data.frame(bowling_avg = data$bowling_average[i]))

#   }
# }

# aus_players_economy$Group <- "Australia"
# ind_players_economy$Group <- "India"

# combined_data <- rbind( aus_players_economy, ind_players_economy)
# # Create a KDE plot of strike rates
# economy_plot<-ggplot(combined_data, aes(x = economy, fill = Group, color = Group)) +
#   geom_density(alpha = 0.7) +
#   labs(title = "Kernel Density Estimation Plot of Economies",
#        x = "Economy",
#        y = "Density") +
#   scale_fill_manual(values = c("yellow","blue")) +
#   scale_color_manual(values = c("yellow","blue")) +
#   theme_minimal()

# aus_players_bowling_avg$Group <- "Australia"
# ind_players_bowling_avg$Group <- "India"
# combined_data <- rbind( aus_players_bowling_avg, ind_players_bowling_avg)
# # Create a KDE plot of strike rates
# bowling_avg_plot<-ggplot(combined_data, aes(x = bowling_avg, fill = Group, color = Group)) +
#   geom_density(alpha = 0.7) +
#   labs(title = "Kernel Density Estimation Plot of Bowling Averages",
#        x = "Bowling Average",
#        y = "Density") +
#   scale_fill_manual(values = c("yellow","blue")) +
#   scale_color_manual(values = c("yellow","blue")) +
#   theme_minimal()


# library(gridExtra)

# grid.arrange(economy_plot, bowling_avg_plot, nrow = 1)

# Create a violin plot of batting averages
data$Group <- c(rep("Australia", nrow(aus_players_batting_avg)), rep("India", nrow(ind_players_batting_avg)))

batting_avg_violin_plot <- ggplot(data, aes(x = Group, y = batting_avg, fill = Group)) +
  geom_violin() +
  labs(title = "Violin Plot of Batting Averages",
    x = "Group",
    y = "Batting Average") +
  scale_fill_manual(values = c("yellow", "blue")) +
  theme_minimal()

# Create a violin plot of bowling averages
# bowling_avg_violin_plot <- ggplot(data, aes(x = Group, y = bowling_avg, fill = Group)) +
#   geom_violin() +
#   labs(title = "Violin Plot of Bowling Averages",
#     x = "Group",
#     y = "Bowling Average") +
#   scale_fill_manual(values = c("yellow", "blue"))
#   theme_minimal()

# Arrange the violin plots in a grid
# library(gridExtra)
# grid.arrange(batting_avg_violin_plot, bowling_avg_violin_plot, nrow = 1)
