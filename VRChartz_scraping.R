library(tidyverse)
library(rvest)
urls <- paste0("http://www.vgchartz.com/gamedb/?page=", 1:1082)


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

GameDB.Main.list1 <- apply(data.frame(urls[5:10]), 1, VGChartz_gamedb_scraping)
# GameDB.Main.list1 <- apply(data.frame(urls[2:10]), 1, VGChartz_gamedb_scraping)
GameDB.Main.df <- do.call(rbind, GameDB.Main.list)

