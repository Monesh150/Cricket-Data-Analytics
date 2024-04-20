# Install and load the hash library
#install.packages("hash")
library(hash)

# Read the datasets
df1 <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/CSVs/Conversion_demo.csv")
df2 <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/Players_with_info.csv")

# Remove leading and trailing spaces from player names
df2$player <- trimws(df2$player)

# Create an empty hash table
batter <- hash()
bowler <- hash()

# Populate the hash table with player names as keys and batting styles as values
for (i in 1:nrow(df2)) {
  batter[[df2$player[i]]] <- df2$batting[i]
  bowler[[df2$player[i]]] <- df2$bowling[i]
}

# Initialize an empty vector to store batting styles
batting_vector <- c()
bowling_vector <- c()

# Loop through df1 to get batting style for each player
for (i in 1:nrow(df1)) {
  row <- df1[i, ]
  batter_name <- trimws(as.character(row$batter))
  bowler_name <- trimws(as.character(row$baller))
  batting_style <- batter[[batter_name]]
  print(bowler_name)
  bowling_style <- bowler[[bowler_name]]
  batting_vector <- c(batting_vector, batting_style)
  bowling_vector <- c(bowling_vector, bowling_style)
}

# Print batting styles vector
print(batting_vector)
print(bowling_vector)

# Add batting styles vector to df1
df1$batter_style <- batting_vector
df1$bowler_style <- bowling_vector

# Write df1 back to CSV
write.csv(df1, "D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/CSVs/Conversion_demo.csv", row.names = FALSE)
