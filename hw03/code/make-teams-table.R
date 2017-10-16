#=====================================================
#
#Title: Creating a Data Table
#Description: This is a script that will create the 'csv' that I am going to use for ranking NBA teams for HW03
#Input(s): 'nba2017-roster.csv', 'nba2017-stats.csv'
#Output(s): 'nba2017-teams-csv'
#
#=====================================================

#Loading necessary packages
library(readr)
library(dplyr)
library(ggplot2)

#Reading the raw data into R
roster.raw <- read_csv("./data/nba2017-roster.csv")
stats.raw <- read_csv("./data/nba2017-stats.csv")

#Mutating the missing necessary statistics
stats <- stats.raw %>%
              mutate(missed_fg = field_goals_atts - field_goals_made,
              missed_ft = points1_atts - points1_made,
              points = 3 * points3_made + 2 * points2_made + points1_made,
              rebounds = off_rebounds + def_rebounds,
              efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers)/games_played)

#Creating Efficiency Summary file
sink(file = "./output/efficiency-summary.txt")
summary(stats[ , "efficiency"])
sink()

#Raw team data
teams.raw <- left_join(stats, roster.raw)

#Cleaning up the team data
teams <- teams.raw %>%
  group_by(team) %>%
  summarise(experience = sum(experience),
            salary = round(sum(salary)/(10^6), digits = 2),
            points3 = sum(3 * points3_made),
            points2 = sum(2 * points2_made),
            free_throws = sum(points1_made),
            points = sum(points),
            off_rebounds = sum(off_rebounds),
            def_rebounds = sum(def_rebounds),
            assists = sum(assists),
            steals = sum(steals),
            blocks = sum(blocks),
            turnovers = sum(turnovers),
            fouls = sum(fouls),
            efficiency = sum(efficiency))

#Creating team summary file
sink(file = "./data/teams-summary.txt")
summary(teams)
sink()

#Creating the final csv
write_csv(teams, "./data/nba2017-teams.csv")

#Stars PDF
pdf(file = "./images/teams_star_plot.pdf")
stars(teams[ , -1], labels = teams$team)
dev.off()

#Scatterplot PDF
experience_salary <- ggplot(teams, aes(x = experience, y = salary)) + geom_point()

ggsave(filename = "./images/experience_salary.pdf", plot = experience_salary)




