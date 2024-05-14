library(jsonlite)
base_dir = "D:/Minor_Project-II/Data/All India Matches/T20I"
json_files = list.files(base_dir)

#create the batsman dataframe here
# batsman_data = data.frame(
#     player = character(),
#     runs = integer(),
#     balls = integer(),
#     fours = integer(),
#     sixes = integer(),
#     batting_average = numeric(),
#     strike_rate = numeric(),
#     matches_played = integer(),
#     dismissals = integer()
# )


## for batsaman data

# for (file in json_files){
#     print(file)
#     data = read_json(paste0(base_dir, "/", file))
#     players = data$info$players$India
#     for(player in players){
#         if(player %in% batsman_data$player){
#             index = which(batsman_data$player == player)
#             batsman_data$matches_played[index] = batsman_data$matches_played[index] + 1
#         }else{
#             batsman_data = rbind(batsman_data, data.frame(player = player, runs = 0, balls = 0, fours = 0, sixes = 0, strike_rate = 0, matches_played = 1,dismissals = 0))
#         }
#     }
#     if (data$innings[[1]]$team == "India") {
#     #write your code here
#         inning = data$innings[[1]]
#     }
#     else{
#         if (length(data$innings)==2)
#         {
#         inning = data$innings[[2]]}
#     }
#         for(over in inning$overs){
#             for(ball in over$deliveries){
#                 player = ball$batter
#                 # print(player)
#                 # print(ball$runs$batter)
#                 if(player %in% batsman_data$player){
#                     index = which(batsman_data$player == player)
#                     batsman_data$runs[index] = batsman_data$runs[index] + ball$runs$batter
#                     batsman_data$balls[index] = batsman_data$balls[index] + 1
#                     if(ball$runs$batter == 4){
#                         batsman_data$fours[index] = batsman_data$fours[index] + 1
#                     }
#                     if(ball$runs$batter == 6){
#                         batsman_data$sixes[index] = batsman_data$sixes[index] + 1
#                     }
#                 }else{
#                     batsman_data = rbind(batsman_data, data.frame(player = player, runs = ball$runs$batter, balls = 1, fours = ifelse(ball$runs$batter == 4, 1, 0), sixes = ifelse(ball$runs$batter == 6, 1, 0), strike_rate = 0,matches_played = 1, dismissals = 1))
#                 }
#                 #if ball$wickets exists then the dismissed batsman is ball$wickets$player_out
#                 if(!is.null(ball$wickets)){
#                     dismissed_player = ball$wickets[[1]]$player_out
#                     if(dismissed_player %in% batsman_data$player){
#                         index = which(batsman_data$player == dismissed_player)
#                         batsman_data$dismissals[index] = batsman_data$dismissals[index] + 1
#                     }else{
#                         batsman_data = rbind(batsman_data, data.frame(player = dismissed_player, runs = 0, balls = 0, fours = 0, sixes = 0, strike_rate = 0, matches_played = 1, dismissals = 1))
#                     }
#                 }
#             }
#         }
    

# }
# batsman_data$strike_rate = (batsman_data$runs / batsman_data$balls) * 100
# batsman_data$batting_average = batsman_data$runs / batsman_data$dismissals
# #if batting average is NaN or Inf then replace it with 0
# batsman_data$batting_average[is.nan(batsman_data$batting_average)] = 0
# batsman_data$batting_average[batsman_data$batting_average==Inf] = 0
# print(batsman_data)

# write.csv(batsman_data, "D:/Minor_Project-II/Data/All India Matches/T20I/T20_batsman_data.csv", row.names = FALSE)

#for bowler data
bowler_data = data.frame(
    player = character(),
    runs = integer(),
    balls = integer(),
    wickets = integer(),
    economy = numeric(),
    matches_played = integer(),
    dot_balls = integer()
)

for(file in json_files){
    print(file)
    data = read_json(paste0(base_dir, "/", file))
    players = data$info$players$India
    for(player in players){
        if(player %in% bowler_data$player){
            index = which(bowler_data$player == player)
            bowler_data$matches_played[index] = bowler_data$matches_played[index] + 1
        }else{
            bowler_data = rbind(bowler_data, data.frame(player = player, runs = 0, balls = 0, wickets = 0, economy = 0, matches_played = 1,dot_balls = 0))
        }
    }
    if (data$innings[[1]]$team != "India") {
    #write your code here
        inning = data$innings[[1]]
    }
    else{
        if (length(data$innings)==2)
        {
        inning = data$innings[[2]]}
    }
        for(over in inning$overs){
            for(ball in over$deliveries){
                player = ball$bowler
                if(player %in% bowler_data$player){
                    index = which(bowler_data$player == player)
                    bowler_data$runs[index] = bowler_data$runs[index] + ball$runs$total
                    bowler_data$balls[index] = bowler_data$balls[index] + 1
                    if (ball$runs$total == 0){
                        bowler_data$dot_balls[index] = bowler_data$dot_balls[index] + 1
                    }
                    if(!is.null(ball$wickets)){
                        if(ball$wickets[[1]]$kind != "run out"){
                        bowler_data$wickets[index] = bowler_data$wickets[index] + 1
                        }
                    }
                }else{
                    bowler_data = rbind(bowler_data, data.frame(player = player, runs = ball$runs$extras + ball$runs$total, balls = 1, wickets = ifelse(!is.null(ball$wickets), 1, 0), economy = 0, matches_played = 1))
                }
            }
        }
}

bowler_data$economy = (bowler_data$runs / bowler_data$balls) * 6
bowler_data$economy = round(bowler_data$economy, 2)
bowler_data$bowling_average = bowler_data$runs / bowler_data$wickets
bowler_data$bowling_average[is.nan(bowler_data$bowling_average)] = 0
bowler_data$economy[is.nan(bowler_data$economy)] = 0
bowler_data$bowling_average[bowler_data$bowling_average==Inf] = 0
bowler_data$economy[bowler_data$economy==Inf] = 0
bowler_data$overs = bowler_data$balls/6
bowler_data$overs = round(bowler_data$overs, 0)
print(bowler_data)

# write.csv(bowler_data, "D:/Minor_Project-II/Data/All India Matches/T20_bowler_data.csv", row.names = FALSE)