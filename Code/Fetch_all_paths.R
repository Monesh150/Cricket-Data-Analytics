# Get the list of JSON files
files <- list.files(path = "./Minor_Project-II/Data", pattern = "*.json", full.names = TRUE, recursive = TRUE)

# Import the Convert module
current_directory <- dirname(rstudioapi::getSourceEditorContext()$path)
convert_path <- file.path(current_directory, "Convert.R")
source(convert_path)

# Loop through each JSON file
for (file in files) {
  print(file)
  # Read JSON data from the current file
  jsonData <- read_cricket_json(file)
  
  # Process the JSON data and convert it into a dataframe
  df <- process_cricket_data(jsonData)
  
  # Get the file name without extension
  file_name <- tools::file_path_sans_ext(basename(file))
  
  if (!is.null(df) && nrow(df) > 0) {
    # Save the dataframe as a CSV file
    write.csv(df, paste0("/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/CSV/", file_name, ".csv"), row.names = FALSE)
  }
  
}
