# Load required library
library(jsonlite)
#install.packages('hash')
library(hash)

# Read JSON data
jsonData <- read_json(path = "/Users/morampudigopiprashanthraju/Desktop/DataScience/Minor_Project-II/Data/IND vs AUS/ODI/2003/65244.json")
#Mushtaq's json path
#jsonData <- read_json(path = "D:/Minor_Project-II/Data/IND vs AUS/ODI/2003/65244.json")
# Initialize hash
h <- hash()
print(jsonData$info$players)
con=c("India","Australia")
for(country in con){
  print(country)
  for(pla in jsonData$info$players[[country]]){
    print(pla)
    h[[pla]]=list(country=country,batting="NONE",bowling_style="None")
  }
}
print(h)