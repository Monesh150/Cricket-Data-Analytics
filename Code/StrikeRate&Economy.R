#Batsman data manipulation
# batsman_data = read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv")
# print(batsman_data)
# strikerate = (batsman_data$runs/batsman_data$balls)*100
# batsman_data$strike_rate = strikerate
# print(batsman_data)
batting_average = ifelse(batsman_data$out != 0, batsman_data$runs/batsman_data$out, 0)
print(batting_average)
batsman_data$batting_average = batting_average
write.csv(batsman_data, "D:/Minor_Project-II/Data/IND vs AUS/ODI/BatsmanScores.csv", row.names = FALSE)

#Bowler data manipulation
# bowler_data = read.csv("D:/Minor_Project-II/Data/IND vs AUS/ODI/BowlerStats.csv")
# bowling_average = ifelse(bowler_data$wickets != 0, bowler_data$score/bowler_data$wickets, 0)
# economy = ifelse((bowler_data$balls)/6 != 0, bowler_data$score/(bowler_data$balls/6), 0)
# print((economy))
# bowler_data$bowling_average = bowling_average
# bowler_data$economy = economy
# print(bowler_data)
# write.csv(bowler_data, "D:/Minor_Project-II/Data/IND vs AUS/ODI/BowlerStats.csv", row.names = FALSE)

