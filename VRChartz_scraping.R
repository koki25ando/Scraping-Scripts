library(tidyverse)
library(rvest)
urls <- paste0("http://www.vgchartz.com/gamedb/?page=", 1:1082)

links <- paste0("http://www.vgchartz.com/games/games.php?page=", 1:271,
                "&results=200&name=&console=&keyword=&publisher=&genre=&order=Sales&ownership=Both&boxart=Both&banner=Both&showdeleted=&region=All&goty_year=&developer=&direction=DESC&showtotalsales=1&shownasales=1&showpalsales=1&showjapansales=1&showothersales=0&showpublisher=1&showdeveloper=1&showreleasedate=1&showlastupdate=0&showvgchartzscore=1&showcriticscore=1&showuserscore=1&alphasort=")

link <-links[[1]]
test <- VGChartz_gamedb_scraping(url = link)


VGChartz_gamedb_scraping <- function (url) {
  page <- read_html(url)
  tables <- page %>% 
    html_table(fill = TRUE)
  table <- tables[[7]]
  table <- table[-1]
  names(table) <- table[2,]
  table[-c(1:2),]
}

test <- VGChartz_gamedb_scraping(urls[[5]])

GameDB.Main.list1 <- apply(data.frame(links[1:100]), 1, VGChartz_gamedb_scraping)
# GameDB.Main.list1 <- apply(data.frame(urls[2:10]), 1, VGChartz_gamedb_scraping)
GameDB.Main.df <- do.call(rbind, GameDB.Main.list)

