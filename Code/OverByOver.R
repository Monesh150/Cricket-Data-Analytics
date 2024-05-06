# library(xgboost)

# data <- read.csv("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Combined.csv")
# wicket_model <- readRDS("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Code/Model/trained_model.rds")
# summary(wicket_model)
# # Data preprocessing
# names(data)
# selected_features <- c("balls", "batter_style", "bowler_style", "innings", "country", "toss_decision", "toss_winner")
# X <- data[selected_features]
# mean_balls <- mean(X$balls)
# sd_balls <- sd(X$balls)

# # Normalize the 'balls' column
# normalized_balls <- (balls - mean_balls) / sd_balls
# X$balls<-normalized_balls
# # Convert categorical variables to numeric
# X$batter_style <- ifelse(X$batter_style == "right", 1, 0)
# X$bowler_style <- ifelse(X$bowler_style == "fast", 1, 0)
# X$country <- ifelse(X$country == "India", 1, 0)
# X$toss_decision <- ifelse(X$toss_decision == "bat", 1, 0)
# X$toss_winner <- ifelse(X$toss_winner == "Australia", 1, 0)

# y <- data$runsperball
# length(unique(y))
# # XGBoost model
# model_xgb <- xgboost(data = as.matrix(X), label = as.matrix(y), nrounds = 100)
# wickets=data$wickets
# model_xgb <- xgboost(data = as.matrix(X), label = as.matrix(y), nrounds = 100)


# Load necessary 

OverBYOver<- function(ball_by_ball,filename){
library(dplyr)
library(tidyr)
library(zoo)
# ball_by_ball <- read.csv("D:/Minor_Project-II/Data/Datasets/65244.csv")
# # print(ball_by_ball[1,])
if(nrow(ball_by_ball)==0){
  return(data.frame())
}
over_by_over <- ball_by_ball %>%
  group_by(innings, over = floor(balls)) %>%
  summarise(
    runs_in_over = sum(runsperball),
    wickets_in_over = ifelse(sum(wickets)>10,sum(wickets)%%10,sum(wickets)),
    run_rate = sum(runsperball) / 6,
    score = max(total_score),
  )



# over_by_over <- read.csv("D:/Minor_Project-II/Code/over_by_over.csv")

over_by_over <- over_by_over %>%
  group_by(innings) %>%
  mutate(
    required_run_rate = ifelse(innings == 1, 0, (max(score) - score) / (50 - over))
  )
over_by_over <- over_by_over %>%
  group_by(innings) %>%
  mutate(
    runs_in_previous_3_overs = rollapplyr(runs_in_over, width = 3, FUN = sum, fill = 0),

  )

# print(over_by_over)

# write.csv(over_by_over, "D:/Minor_Project-II/Code/over_by_over.csv", row.names = FALSE)
# write.csv(over_by_over, paste0("D:/Minor_Project-II/Data/Datasets/OverByOver/", filename), row.names = FALSE)
return(over_by_over)
}


names = c()
list = list.files("D:/Minor_Project-II/Data/Datasets/BallByBall")

library(jsonlite)
base_dir <- "D:/Minor_Project-II/Data/IND vs AUS/ODI"
year_folders <- list.files(base_dir)
for (year in year_folders){
    json_files <- list.files(paste(base_dir, year, sep = "/"))
    for (json_file in json_files){
        len = nchar(json_file)
        # print(substr(json_file,1,len-5))
        names = c(names,paste0(substr(json_file,1,len-5),".csv"))
    }
}
# print(length(names))
names = intersect(names,list)
# print(length(names))
# print(list)
# print(names)
aggregated_over_by_over <- data.frame()
for(i in 1:length(names)){
    
    x = read.csv(paste0("D:/Minor_Project-II/Data/Datasets/BallByBall/",names[i]))
    df = OverBYOver(x,names[i])
    aggregated_over_by_over <- rbind(aggregated_over_by_over,df)
}
write.csv(aggregated_over_by_over, "D:/Minor_Project-II/Data/Datasets/OverByOver/Aggregated.csv", row.names = FALSE)