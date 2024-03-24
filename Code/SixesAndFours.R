sixes_and_fours<- function(file_path){
library(jsonlite)
# batsman_data = read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv")
# data <- read_json(path="D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/65244.json")
data <- read_json(path=file_path)
boundaries <- data.frame(player = character(), six = numeric(), four = numeric())
for (innings in data$innings){
for(over in innings$overs){
    for(ball in over$deliveries){
        if (ball$runs$batter == 6){
            if (ball$batter %in% boundaries$player){
                boundaries[boundaries$player == ball$batter, "six"] <- boundaries[boundaries$player == ball$batter, "six"] + 1
            }
            else{
                boundaries <- rbind(boundaries, data.frame(player = ball$batter, six = 1, four = 0))
            }
            
        }
        else if (ball$runs$batter == 4){
            if (ball$batter %in% boundaries$player){
                boundaries[boundaries$player == ball$batter, "four"] <- boundaries[boundaries$player == ball$batter, "four"] + 1
            }
            else{
                boundaries <- rbind(boundaries, data.frame(player = ball$batter, six = 0, four = 1))
            }
        }
        else{
            pass <- NULL
        }
    }
}
}
return(boundaries)
}
# print(boundaries)

# l = rep(0, 143)
# batsman_data$sixes = l
# batsman_data$fours = l
# for (i in 1:nrow(boundaries)){
#     row = boundaries[i,]
#     if(row$player %in% batsman_data$player){
#         batsman_data[batsman_data$player == row$player, "sixes"] <- batsman_data[batsman_data$player == row$player, "sixes"] + row$six
#         batsman_data[batsman_data$player == row$player, "fours"] <- batsman_data[batsman_data$player    == row$player, "fours"] + row$four 
#         print(row)
#     }
#         else{
#             batsman_data <- rbind(batsman_data, 
#                                   data.frame(player = row$player, 
#                                              sixes = row$six, 
#                                              fours = row$four))
#         }
#         }
    
# # print(batsman_data)
# #     # Save the updated batsman_data to a new CSV file
# write.csv(batsman_data, file = "D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv", row.names = FALSE)
boundaries<-sixes_and_fours("D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/65244.json")
print(boundaries)