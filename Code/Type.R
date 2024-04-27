library(hash)
df <- read.csv("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Combined.csv")

bat <- hash()
for (i in 1:nrow(df)) {
    row <- df[i, ]
    batter <- row$batter
    if (!(batter %in% names(bat))) {
        bat[[as.character(batter)]] <- list(balls = 0, runs = 0)
    } else {
        bat[[as.character(batter)]][[1]] <- bat[[as.character(batter)]][[1]] + 1
        bat[[as.character(batter)]][[2]] <- bat[[as.character(batter)]][[2]] + row$runs
    }
}

# Add Batting_Style column based on hash table
df$Batting_Type <- sapply(df$batter, function(x) {
  ifelse(bat[[as.character(x)]][[2]] > 100 & (bat[[as.character(x)]][[2]] / bat[[as.character(x)]][[1]]) * 100 > 90, "Aggressive", "Defensive")
})

# Print the dataframe with the new column
write.csv(df,"/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Combined.csv")
