library(rvest)
library(tidyverse)

base_url = "https://basketball.realgm.com/nba/players/"

players_list = list()

for (i in 1:72){
  base_year = 1946
  url = paste0(base_url, base_year+i)
  print(url)
  
  tables <- read_html(url) %>% 
    html_table()
  players_list[[i]] = tables[[1]]
  players_list[[i]]$Year = base_year+i
}

Players_df <- do.call(rbind, players_list)


