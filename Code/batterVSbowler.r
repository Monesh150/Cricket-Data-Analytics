data <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/Conversion_demo.csv")
count <- 0
dismissals <- data.frame('Bowler' = character(), 'Batter' = character(), 'Score' = numeric())
print(nrow(data))
for (i in 1:nrow(data)) {
    if (data$wickets[i] != 0) {
        count = count + 1
        dismissals = rbind(dismissals, data.frame('Bowler' = data$baller[i], 'Batter' = data$batter[i], 'Score' = data$total_score[i]))
    }
}
print(dismissals)