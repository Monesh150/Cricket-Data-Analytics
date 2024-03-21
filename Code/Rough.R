library(jsonlite)
base_dir <- "D:/Minor_Project-II/Data/IND vs AUS/ODI"
year_folders <- list.files(base_dir)

#Reading the Aussies's CSV file
aus_players <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/ausplayers.csv")

#Reading the Indians's CSV file
# indian_players <- read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/indianplayers.csv")

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
            if (player %in% aus_players){
                next()
            }
            else{
                aus_players <- rbind(aus_players, player)
            }
        }
    }
}
write.csv(aus_players,"D:/Minor_Project-II/Data/IND vs AUS/ODI/ausplayers.csv")
# write(aus_players, file = file_path)
