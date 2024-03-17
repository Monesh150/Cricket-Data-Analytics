# Load required library
library(jsonlite)
library(hash)

# Read JSON data
jsonData <- read_json(path = "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/65244.json")

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
          h[[batter]] <- list(country = team, runs = 0, b = 0)
        }
        bowler_country <- jsonData$innings[[1]]$team
        if (inn == 1) {
          bowler_country <- jsonData$innings[[2]]$team
        }
        
      
        
        if(!(bowler %in% names(h_bowler))){
          h_bowler[[bowler]]<-list(country=bowler_country,runs=0,balls=0)
        }
        h_bowler[[bowler]][[3]]=h_bowler[[bowler]][[3]]+1
        h[[batter]][[2]] <- h[[batter]][[2]] + runs
        
        if (!is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$extras)) {
          if (!is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$extras$legbyes)) {
            runs=runs+1
            extra <- TRUE
          } else {
            extra <- FALSE
          }
        } else {
          extra <- FALSE
        }
        h_bowler[[bowler]][[2]]=h_bowler[[bowler]][[2]]+runs
        if (!extra) {
          h[[batter]][[3]] <- h[[batter]][[3]] + 1
        }
        
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
