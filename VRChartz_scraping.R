# Loding packages
library(tidyverse)
library(rvest)

# set up links that the following function scrape data from
links <- paste0("http://www.vgchartz.com/games/games.php?page=", 1:271,
                "&results=200&name=&console=&keyword=&publisher=&genre=&order=Sales&ownership=Both&boxart=Both&banner=Both&showdeleted=&region=All&goty_year=&developer=&direction=DESC&showtotalsales=1&shownasales=1&showpalsales=1&showjapansales=1&showothersales=0&showpublisher=1&showdeveloper=1&showreleasedate=1&showlastupdate=0&showvgchartzscore=1&showcriticscore=1&showuserscore=1&alphasort=")

# Function Setup
VGChartz_gamedb_scraping <- function (url) {
  # Read html file
  page <- read_html(url)
  # Extract table contents
  tables <- page %>% 
    html_table(fill = TRUE)
  # Pick up 1 table that we focus on
  table <- tables[[7]]
  # Clean data
  table <- table[-1]
  names(table) <- table[2,]
  # Export
  table[-c(1:2),]
}

# Loop using apply function
GameDB.Main.list <- apply(data.frame(links[1:271]), 1, VGChartz_gamedb_scraping)
# Merge lists into 1 huge dataset
GameDB.Main.df <- do.call(rbind, GameDB.Main.list)

# Export file
# write.csv(GameDB.Main.df, file = "VGChratz_GameDB.csv")

