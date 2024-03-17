# Load required library
library(jsonlite)
library(hash)

# Read JSON data
jsonData <- read_json(path = "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/65244.json")
#Mushtaq's json path
# jsonData <- read_json(path = "D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/65244.json")
# Initialize hash
h <- hash()
h_bowler<-hash()

balls <- 0
flag <- TRUE
Innings <- c(1, 2)

for (inn in Innings) {
  cummulative_score <- 0
  flag <- TRUE
  balls <- 0
  
  while (balls < 300 && flag) {
    tryCatch({
      over_index <- balls %/% 6 + 1
      
      if (over_index > length(jsonData$innings[[inn]]$overs)) {
        flag <- FALSE
        break
      }
      
      over_balls <- length(jsonData$innings[[inn]]$overs[[over_index]]$deliveries)
      currball <- 1
      
      while (currball <= over_balls) {
        batter <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$batter
        bowler <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$bowler
        runs <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$runs$batter
        team <- jsonData$innings[[inn]]$team
        
        if (!(batter %in% names(h))) {
          h[[batter]] <- list(country = team, runs = 0, balls = 0)
        }
        bowler_country <- jsonData$innings[[1]]$team
        if (inn == 1) {
          bowler_country <- jsonData$innings[[2]]$team
        }
        
      
        
        if(!(bowler %in% names(h_bowler))){
          h_bowler[[bowler]]<-list(country=bowler_country,runs=0,balls=0,extras=0)
        }
        h_bowler[[bowler]][[3]]=h_bowler[[bowler]][[3]]+1
        h[[batter]][[2]] <- h[[batter]][[2]] + runs
        
        if (!is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$extras)) {
          if (!is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$extras$legbyes)) {
            h_bowler[[bowler]][[4]]=h_bowler[[bowler]][[4]]+1
            runs=runs+1
            
          } 
          if (!is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$extras$wide)){
            h[[batter]][[3]]=h[[batter]][[3]]+1 
          }
          
        } else {
          h[[batter]][[3]]=h[[batter]][[3]]+1 
        }
        h_bowler[[bowler]][[2]]=h_bowler[[bowler]][[2]]+runs
        
        currball <- currball + 1
      }
      
      balls <- balls + 6
    }, error = function(e) {
      flag <- FALSE
    })
  }
} 
print(2)
print(h)
print(h_bowler)
# Convert hash h to a data frame
h_df <- as.data.frame(t(sapply(h, unlist)))
h_df <- data.frame(batter = rownames(h_df), h_df, row.names = NULL)

# Convert hash h_bowler to a data frame
h_bowler_df <- as.data.frame(t(sapply(h_bowler, unlist)))
h_bowler_df <- data.frame(bowler = rownames(h_bowler_df), h_bowler_df, row.names = NULL)

# Write data frames to CSV files
write.csv(h_df, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/batter.csv", row.names = FALSE)
write.csv(h_bowler_df, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/h_bowler.csv", row.names = FALSE)

# Mushtaq's path
# write.csv(df,"D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/batter.csv", row.names = FALSE)
# write.csv(df,"D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/h_bowler.csv",row.names = FALSE)