library(jsonlite)
base_dir <- "D:/Minor_Project-II/Data/IND vs AUS/ODI"
year_folders <- list.files(base_dir)

#Reading the Aussies's CSV file
players_details <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/players_details.csv")

for (year in year_folders){
    json_files <- list.files(paste(base_dir, year, sep = "/"))
    for (json_file in json_files){
        if (json_file == "CSVs"){
            next()
        }
        file_path <- paste(base_dir, year, json_file, sep = "/")
        print(file_path)
        json_data <- read_json(path=file_path)
        aplayers <- json_data$info$players$Australia
        for (player in aplayers){
            if (player %in% players_details$player){
                next()
            }
            else{
                players_details <- rbind(players_details, data.frame(player=player, country="Australia", batting="None", bowling_style="None"))
            }
        }
        iplayers <- json_data$info$players$India
        for (player in iplayers){
            if (player %in% players_details$player){
                next()
            }
            else{
                players_details <- rbind(players_details, data.frame(player=player, country="India", batting="None", bowling_style="None"))
            }
        }
    }
}
write.csv(players_details,"D:/Minor_Project-II/Data/IND vs AUS/ODI/players_details.csv")
# # write(aus_players, file = file_path)
