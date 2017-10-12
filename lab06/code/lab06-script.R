# ===================================================================
# Title: Cleaning Data
# Description:
#   This script performs cleaning tasks and transformations on 
#   various columns of the raw data file.
# Input(s): data file 'raw-data.csv'
# Output(s): data file 'clean-data.csv'
# Author: Noah Weingarten
# Date: 10-05-2017
# ===================================================================

# packages
library(readr)    # importing data
library(dplyr)    # data wrangling
library(ggplot2)  # graphics

nba2017_players <- read_csv("C://Users/13noa/stat133/stat133-hws-fall17/lab06/data/nba2017-players.csv")

warriors <- nba2017_players %>%
  filter(nba2017_players$team == "GSW")

write.csv(warriors, file = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/data/warriors.csv", row.names = TRUE)

lakers <- nba2017_players %>%
  filter(nba2017_players$team == "LAL")

lakers <- arrange(lakers, desc(experience))

write_csv(lakers, path = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/data/lakers.csv")

sink(file = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/output/data-structure.txt")
str(nba2017_players)
sink()

sink(file = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/output/summary-warriors.txt")
summary(warriors)
sink()


sink(file = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/output/summary-lakers.txt")
summary(lakers)
sink()


png(filename = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/images/scatterplot-height-weight.png")
plot(nba2017_players$height, nba2017_players$weight, pch = 20, xlab = 'Height', ylab = 'Weight')
dev.off()



png(filename = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/images/scatterplot-height-weight-hi-res.png", height = 700,
    width = 800)
plot(nba2017_players$height, nba2017_players$weight, pch = 20, xlab = 'Height', ylab = 'Weight')
dev.off()

jpeg(filename = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/images/histogram-height-weight.jpeg", width = 600,
     height = 400)
hist(x = nba2017_players$age)
dev.off()

pdf(file = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/images/histogram-height-weight.pdf", height = 5)
hist(x = nba2017_players$age)
dev.off()

gg_pts_salary <- ggplot(nba2017_players, aes(x = points, y = salary)) + geom_point()
ggsave(filename = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/images/points_salary.pdf", width = 7, height = 5,
       plot = gg_pts_salary)

gg_ht_wt_position <- ggplot(nba2017_players, aes(x = height, y = weight)) + geom_point() + facet_wrap(~position)
ggsave(filename = "C://Users/13noa/stat133/stat133-hws-fall17/lab06/images/height_weight_by_position.pdf", 
       width = 7, height = 5, plot = gg_ht_wt_position)

lakers %>%
  select(player)

warriors %>%
  filter(position == "PG") %>%
  select(player, salary)

nba2017_players %>%
  filter(experience > 10, salary < 10000000) %>%
  select(player, age, team)

head(
  nba2017_players %>%
    filter(experience == 0, age == 20) %>%
    select(player, team, height, weight),
  5
)

gsw_mpg <- warriors %>%
  mutate(min_per_game = minutes / games) %>%
  select(player, experience, min_per_game) %>%
  arrange(desc(min_per_game))

head(nba2017_players %>%
  group_by(team) %>%
  summarise(
    avg_3 = mean(points3)
  ) %>%
  arrange(avg_3),
  5
)

nba2017_players %>%
  filter(position == "PF", experience >= 5, experience <= 10) %>%
  summarise(
    avg_age_PF = mean(age),
    sd_age_PF = sd(age)
  )