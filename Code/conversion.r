# Load required library
library(jsonlite)

# Read JSON data
jsonData <- read_json(path = "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/65244.json")

# Initialize variables
balls <- 0
flag <- TRUE
batter_vector<-c()
baller_vector <- c()
balls_vector <- c()
runsperball_vector <- c()
extra_vector <- c()
country_vector <- c()
Innings_vector <- c()
toss <- c()
toss_winner <- c()
Innings <- c(1, 2)
toss_decision <- c()
match_winner <- c()
margin <- c()
for (inn in Innings) {
  flag <- TRUE
  balls<-0
  while (balls < 300 && flag) {
    # print(toss_decision)
    tryCatch({
      over_index <- balls %/% 6 + 1
      if (over_index > length(jsonData$innings[[inn]]$overs)) {
        flag <- FALSE
        break
      }
      
      over_balls <- length(jsonData$innings[[inn]]$overs[[over_index]]$deliveries)
      currball <- 1
      
      while (currball <= over_balls) {
        ball_index <- (balls %/% 6) * 6 + currball  # Calculate the current ball index
        
        if (!is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$extras)) {
          extra_vector <- c(extra_vector, TRUE)
        } else {
          extra_vector <- c(extra_vector, FALSE)
        }
        if (!is.null(jsonData$info$outcome$by$wickets)) {
          margin <- c(margin, paste(jsonData$info$outcome$by$wickets, " wickets"))
        } else {
          margin <- c(margin, paste(jsonData$info$outcome$by$wickets, " runs"))
        }
        toss <- c(toss, jsonData$info$toss$winner)
        match_winner <- c(match_winner, jsonData$info$outcome$winner)
        batter <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$batter
        bowler <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$bowler
        runs <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$runs$batter
        team <- jsonData$innings[[inn]]$team
        batter_vector<-c(batter_vector,batter)
        baller_vector <- c(baller_vector, bowler)
        balls_vector <- c(balls_vector, balls + currball)
        runsperball_vector <- c(runsperball_vector, runs)
        country_vector <- c(country_vector, team)
        Innings_vector <- c(Innings_vector, inn)
        toss_decision <- c(toss_decision, jsonData$info$toss$decision)
        
        currball <- currball + 1
      }
      
      balls <- balls + 6
    }, error = function(e) {
      flag <- FALSE
    })
  }
} 

# print(baller_vector)
# print(balls_vector)
# print(runsperball_vector)
# print(extra_vector)
# print(country_vector)
# print(Innings_vector)
# print(toss_decision)
# print(toss)
# print(match_winner)
# Create dataframe from collected data
df <- data.frame(
  baller = baller_vector,
  batter = batter_vector,
  balls = balls_vector,
  runsperball = runsperball_vector,
  extra = extra_vector,
  country = country_vector,
  innings = Innings_vector,
  toss_decision = toss_decision,
  match_winner = match_winner
)

# Print the dataframe
print(length(df))

