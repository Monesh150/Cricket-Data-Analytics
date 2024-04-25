# Function to read a CSV file
read_csv_file <- function(file_path) {
  return(read.csv(file_path))
}

# Function to trim leading and trailing spaces from player names
trim_player_names <- function(df) {
  df$player <- trimws(df$player)
  return(df)
}

# Function to create hash tables for player names and their batting/bowling styles
create_hash_tables <- function(df) {
  batter <- hash()
  bowler <- hash()
  
  for (i in 1:nrow(df)) {
    batter[[df$player[i]]] <- df$batting[i]
    bowler[[df$player[i]]] <- df$bowling[i]
  }
  
  return(list(batter = batter, bowler = bowler))
}

# Function to get batting and bowling styles for each player from hash tables
get_styles <- function(df, batter, bowler, default_batting = "right", default_bowling = "fast") {
  batting_vector <- c()
  bowling_vector <- c()
  
  for (i in 1:nrow(df)) {
    row <- df[i, ]
    batter_name <- trimws(as.character(row$batter))
    bowler_name <- trimws(as.character(row$baller))
    batting_style <- batter[[batter_name]]
    bowling_style <- bowler[[bowler_name]]
    
    # Check if batting style is null
    if (is.null(batting_style)) {
      batting_style <- default_batting
    }
    
    # Check if bowling style is null
    if (is.null(bowling_style)) {
      bowling_style <- default_bowling
    }
    
    batting_vector <- c(batting_vector, batting_style)
    bowling_vector <- c(bowling_vector, bowling_style)
  }
  return(list(batting_vector = batting_vector, bowling_vector = bowling_vector))
}

# Function to add batting and bowling styles vectors to dataframe and write back to CSV
add_styles_to_dataframe <- function(df, batting_vector, bowling_vector, output_file) {
  print(output_file)
  df$batter_style <- batting_vector
  df$bowler_style <- bowling_vector
  write.csv(df, paste0("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Datasets/", output_file, ".csv"), row.names = FALSE)
}

