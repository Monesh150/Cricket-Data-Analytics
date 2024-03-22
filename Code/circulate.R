library(jsonlite)
base_dir <- "D:/Minor_Project-II/Data/IND vs AUS/ODI"
year_folders <- list.files(base_dir)

batsman_scores <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv")

for (year in year_folders){
    json_files <- list.files(paste(base_dir, year, sep = "/"))
    for (json_file in json_files){
        if (json_file == "CSVs" || json_file == "65244.json"){
            next()
        }
        file_path <- paste(base_dir, year, json_file, sep = "/")
        json_data <- read_json(path=file_path)
        print(file_path)
        
        # Send file_path to conversion.r and get converted data
        source("D:/Minor_Project-II/Code/conversion.r")
        csv_converted <- convert_to_csv(file_path)
        source("D:/Minor_Project-II/Code/PlayerScores.r")
        batsman_bowler_data<-player_scores(csv_converted)
        # print(batsman_bowler_data)
        for(i in 1:nrow(batsman_bowler_data[[1]])){
            row = batsman_bowler_data[[1]][i,]
            row$runs = as.numeric(row$runs)
            row$out = as.numeric(row$out)
            row$balls = as.numeric(row$balls)
            if(row$player %in% batsman_scores$player){
                batsman_scores[batsman_scores$player == row$player, "runs"] <- batsman_scores[batsman_scores$player == row$player, "runs"] + row$runs
                batsman_scores[batsman_scores$player == row$player, "out"] <- batsman_scores[batsman_scores$player == row$player, "out"] + row$out
                batsman_scores[batsman_scores$player == row$player, "balls"] <- batsman_scores[batsman_scores$player == row$player, "balls"] + row$balls
        }
        else{
            batsman_scores <- rbind(batsman_scores, data.frame(player = row$player, runs = row$runs, out = row$out, balls = row$balls, country = row$country))
    }
    }
}
print(batsman_scores)
}