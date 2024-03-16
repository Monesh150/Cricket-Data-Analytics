library(jsonlite)

# Set the directory path
directory <- "/Data/IND vs AUS/ODI/2003"

# Get the list of JSON files in the directory
json_files <- list.files(directory, pattern = "*.json", full.names = TRUE)

# Read each JSON file
for (file in json_files) {
    data <- fromJSON(file)
    # Do something with the data
}