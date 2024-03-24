ScoreBoard<- function(data){

library(hash)

# Read the CSV file
# df <- read.csv("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/CSVs/Conversion_demo.csv")
# df <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/CSVs/Conversion_demo.csv")

df <- data
# Create a hash table to store batsman data
batsman <- hash()

# Loop through each row of the dataframe
for (i in 1:nrow(df)) {
  curr_row <- df[i,]
  batter <- curr_row$batter
  
  # Check if batter exists in the hash table, if not, initialize the values
  if (!(batter %in% names(batsman))) {
    batsman[[batter]] <- list(runs = 0, balls = 0, fours = 0, sixes = 0, out = "Notout")
  }
  
  # Update runs
  batsman[[batter]][[1]] <- batsman[[batter]][[1]] + curr_row$runsperball
  
  # Update balls
  if (!curr_row$extra) {
    batsman[[batter]][[2]] <- batsman[[batter]][[2]] + 1
  }
  
  # Update fours
  if (curr_row$runsperball == 4) {
    batsman[[batter]][[3]] <- batsman[[batter]][[3]] + 1
  }
  
  # Update sixes
  if (curr_row$runsperball == 6) {
    batsman[[batter]][[4]] <- batsman[[batter]][[4]] + 1
  }
  
  # Check if the batsman got out
  if (curr_row$wickets) {
    batsman[[batter]][[5]] <- curr_row$baller
  }
}

# Print the hash table
h_df <- as.data.frame(t(sapply(batsman, unlist)))
h_df2 <- data.frame(player = rownames(h_df), h_df, row.names = NULL)
return(h_df2)

}
# ScoreBoard(read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/CSVs/Conversion_demo.csv"))
# print(h_df2)

# write.csv(h_df, "D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/CSVs/Scoreboard.csv")
# write.csv(h_df, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/Scoreboard.csv")
