player_scores<- function(df){
# Load required library
library(jsonlite)
library(hash)

# Read JSON data
# df <- read.csv("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/CSVs/Conversion_demo.csv")
# df<- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/CSVs/Conversion_demo.csv")

# Initialize hash
h <- hash()
h_bowler <- hash()
prev_inn=0
for(i in 1:nrow(df)) {
  row_data <- df[i,]
  
  # Update runs for batter
  if(!(row_data$batter %in% names(h))) {
    
    h[[row_data$batter]] <- list(runs=row_data$runsperball,out=0,balls=0,country=row_data$country)
  } else {
    h[[row_data$batter]][[1]] <- h[[row_data$batter]][[1]] + row_data$runsperball
  }
  if(!row_data$extra){
    h[[row_data$batter]][[3]]=h[[row_data$batter]][[3]]+1
  }
  # Update runs and wickets for bowler
  prev_score <- 0
  
  if(i != 1 && row_data$innings==prev_inn) {
    prev_score <- df[i - 1,]$total_score
  }
  prev_inn=row_data$innings
  if(!(row_data$baller %in% names(h_bowler))) {
    if(row_data$country=="Australia"){
      h_bowler[[row_data$baller]] <- list(score = 0, wickets = 0,extra=0,country="India")
    }
    else{
      h_bowler[[row_data$baller]] <- list(score = 0, wickets = 0,extra=0,country="Australia")
    }
  }
  if(row_data$extra){
    h_bowler[[row_data$baller]][[3]]=h_bowler[[row_data$baller]][[3]]+1
  }
  if(row_data$wickets != 0) {
    h_bowler[[row_data$baller]][[2]] <- h_bowler[[row_data$baller]][[2]] + 1
    h[[row_data$batter]][[2]]=1
  }
  
  h_bowler[[row_data$baller]][[1]] <- h_bowler[[row_data$baller]][[1]]+row_data$total_score - prev_score
  # print(h_bowler)
}

h_df <- as.data.frame(t(sapply(h, unlist)))
h_df1 <- data.frame(player = rownames(h_df), h_df, row.names = NULL)
# write.csv(h_df, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/players_details.csv", row.names = FALSE)
# write.csv(h_df, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv", row.names = FALSE)
h_df <- as.data.frame(t(sapply(h_bowler, unlist)))
h_df2 <- data.frame(player = rownames(h_df), h_df, row.names = NULL)
# write.csv(h_df, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/players_details.csv", row.names = FALSE)
# write.csv(h_df, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/BowlerStats.csv", row.names = FALSE)
return (list(h_df1,h_df2))
}
