# Import the module
current_directory <- dirname(rstudioapi::getSourceEditorContext()$path)
current_directory
print(current_directory)
convert_path <- file.path(current_directory, "Scoreboard.r")
convert_path
source(convert_path)
list.files("./Minor_Project-II/Data/IND vs AUS")
files <- list.files(path = "./Minor_Project-II/Data/CSV", pattern = "*.csv", full.names = TRUE, recursive = TRUE)
files
# Read the datasets
for(file in files){
  print(file)
  df1 <- read_csv_file(file)
  df2 <- read_csv_file("D:/Minor_Project-II/Data/IND vs AUS/ODI/Players_with_info.csv")
  
  # Trim leading and trailing spaces from player names
  df2 <- trim_player_names(df2)
  
  # Create hash tables for player names and their batting/bowling styles
  hash_tables <- create_hash_tables(df2)
  batter <- hash_tables$batter
  bowler <- hash_tables$bowler
  
  # Get batting and bowling styles for each player from hash tables
  styles <- get_styles(df1, batter, bowler)
  batting_vector <- styles$batting_vector
  bowling_vector <- styles$bowling_vector
  
  # Add batting and bowling styles vectors to df1
  add_styles_to_dataframe(df1, batting_vector, bowling_vector, df1)
}
