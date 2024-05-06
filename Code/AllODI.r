ball_by_ball = source('D:/Minor_Project-II/Code/Convert.R')
over_by_over = source('D:/Minor_Project-II/Code/OverByOver.R')

library(jsonlite)
base_dir <- "D:/Minor_Project-II/Data/All India Matches/ODI"
year_folders <- list.files(base_dir)
c=0
aggregated_over_by_over = data.frame()
for (year in year_folders){
    json_files <- list.files(paste(base_dir, year, sep = "/"))
    for (json_file in json_files){

        print(paste0(year,'/',json_file))
        df = process_cricket_data(read_json(paste(base_dir, year, json_file, sep = "/")))
        o_df = OverBYOver(df,json_file)
        c = c+1
        if(nrow(o_df)>0){
            print('Aggregating')
            aggregated_over_by_over = rbind(aggregated_over_by_over,o_df)
        }
        
    }

}
# write.csv(aggregated_over_by_over, "D:/Minor_Project-II/Data/All India Matches/AllODI.csv", row.names = FALSE)


# df = process_cricket_data(read_json("D:/Minor_Project-II/Data/All India Matches/ODI/2003/66356.json"))
# print(df)