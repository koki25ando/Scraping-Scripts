library(tidyverse)
library(rvest)

## Coutry
country_link <- "https://www.esportsearnings.com/countries"

country_page <- read_html(country_link)
country_tables <- country_page %>% 
  html_table()
country_table <- country_tables[[1]]
names(country_table) <- c("Rank", "Country", "Earnings", "Player")
country_table$Earnings <- country_table$Earnings %>% 
  str_remove_all(",") %>% 
  str_remove("\\$")

country_table$Player <- country_table$Player %>% 
  str_remove(" Players") %>% 
  str_remove(" Player")

# Export
# write.csv(country_table, file = "Country_Earnings.csv")


## Players' ernings
player_links <- paste0("https://www.esportsearnings.com/players/highest-overall-x", 0:4, "00")


Player_Earnings_Scraping <- function (player_link) {
  player_page <- read_html(player_link)
  players_tables <- player_page %>% 
    html_table()
  players_table <- players_tables[[1]]

  players_table <- players_table %>% 
    select(-X5)
  names(players_table) <- players_table[1,]
  players_table <- players_table[-1,]
  names(players_table) <- c("Rank", "PlayerID", "PlayerName", "TotalOverall", "HighestPayingGame", "TotalGame", "PercentOfTotal")
  players_table
}

Player.Earning.list <- apply(data.frame(player_links), 1, Player_Earnings_Scraping)
Player.Earning.df <- do.call(rbind, Player.Earning.list)


Player.Earning.df$TotalOverall <- Player.Earning.df$TotalOverall %>% 
  str_remove_all(",")
Player.Earning.df$TotalOverall <- Player.Earning.df$TotalOverall %>% 
  str_remove_all("\\$")
Player.Earning.df$TotalGame <- Player.Earning.df$TotalGame %>% 
  str_remove_all(",")
Player.Earning.df$TotalGame <- Player.Earning.df$TotalGame %>% 
  str_remove_all("\\$")



# write.csv(Player.Earning.df, file = "Player_Earnings.csv")
