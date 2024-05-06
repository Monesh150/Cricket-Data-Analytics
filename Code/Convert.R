# File: cricket_data_processing.R

library(jsonlite)

# Function to read JSON data from a file
read_cricket_json <- function(json_path) {
  jsonData <- read_json(json_path)
  return(jsonData)
}

# Function to process cricket JSON data and convert it into a dataframe
process_cricket_data <- function(jsonData) {
  print(jsonData$info$outcome$result)
  if (!is.null(jsonData$info$outcome$result)) {
    return(data.frame())  # Return an empty data frame
  }
  balls <- 0
  toss <- c()
  match_winner <- c()
  flag <- TRUE
  batter_vector <- c()
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
  total_score <- c()
  wickets <- c()
  cum_wickets <- 0
  
  for (inn in Innings) {
    cummulative_score <- 0
    flag <- TRUE
    balls <- 0
    cumm_wickets <- 0
    
    while (balls <= 300 && flag) {
      tryCatch({
        over_index <- balls %/% 6 + 1
        if (over_index > length(jsonData$innings[[inn]]$overs)) {
          flag <- FALSE
          break
        }
        over_balls <- length(jsonData$innings[[inn]]$overs[[over_index]]$deliveries)
        currball <- 1
        extras_count <- 0
        
        while (currball <= over_balls) {
          ball_index <- (balls %/% 6) * 6 + currball
          toss <- c(toss, jsonData$info$toss$winner)
          match_winner <- c(match_winner, jsonData$info$outcome$winner)
          batter <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$batter
          bowler <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$bowler
          runs <- jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$runs$batter 
          team <- jsonData$innings[[inn]]$team
          
          batter_vector <- c(batter_vector, batter)
          baller_vector <- c(baller_vector, bowler)
          balls_vector <- c(balls_vector, balls %/% 6 + 0.1 * (currball - extras_count))
          cummulative_score <- cummulative_score + jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$runs$total
          runsperball_vector <- c(runsperball_vector, runs)
          country_vector <- c(country_vector, team)
          Innings_vector <- c(Innings_vector, inn)
          toss_winner <- c(toss_winner, toss)
          toss_decision <- c(toss_decision, jsonData$info$toss$decision)
          
          if (!is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$extras)) {
            if (is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$extras$legbyes)) {
              extras_count <- extras_count + 1
            }
            extra_vector <- c(extra_vector, TRUE)
          } else {
            extra_vector <- c(extra_vector, FALSE)
          }
          
          if (!is.null(jsonData$info$outcome$by$wickets)) {
            margin <- c(margin, paste(jsonData$info$outcome$by$wickets, " wickets"))
          } else {
            margin <- c(margin, paste(jsonData$info$outcome$by$wickets, " runs"))
          }
          
          total_score <- c(total_score, cummulative_score)
          
          if (!is.null(jsonData$innings[[inn]]$overs[[over_index]]$deliveries[[currball]]$wickets)) {
            cum_wickets <- cum_wickets + 1
            wickets <- c(wickets, cum_wickets)
          } else {
            wickets <- c(wickets, 0)
          }
          
          currball <- currball + 1
        }
        
        balls <- balls + 6
      }, error = function(e) {
        flag <- FALSE
      })
    }
  }
  
  df <- data.frame(
    baller = baller_vector,
    batter = batter_vector,
    balls = balls_vector,
    runsperball = runsperball_vector,
    extra = extra_vector,
    total_score = total_score,
    wickets = wickets,
    country = country_vector,
    innings = Innings_vector,
    toss_decision = toss_decision,
    toss_winner = match_winner,
    margin = margin,
    match_winner = match_winner
  )
  
  return(df)
}

