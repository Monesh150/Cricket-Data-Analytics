# List CSV files
files <- list.files(path = "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Datasets", pattern = "*.csv", full.names = TRUE)
files
# Initialize an empty data frame to store concatenated data
combined_df <- data.frame()

# Loop through each CSV file
for (file in files) {
  # Read CSV file
  df <- read.csv(file)
  
  # Concatenate data frames
  combined_df <- rbind(combined_df, df)
}

# Write to CSV
write.csv(combined_df, "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/Combined.csv", row.names = FALSE)
