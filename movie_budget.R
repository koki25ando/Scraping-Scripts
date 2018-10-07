library(tidyverse)
library(rvest)


## Set Up
url.list <- paste0("https://www.the-numbers.com/movie/budgets/all/", 0:55, "01")
url.list[[1]] <- "https://www.the-numbers.com/movie/budgets/all"


## Scraping Function Set up

Budget_Scraping <- function (url) {
  tables <- read_html(as.character(url)) %>% 
    html_table(fill = T)
  table <- tables[[1]]
  table %>% na.omit()
}

## Scraping function execution

Movie.Budget.List <- apply(data.frame(url.list), 1, Budget_Scraping)
Movie.Budget.df <- do.call(rbind, Movie.Budget.List)

## Cleaning
Movie.Budget.df$'Production Budget' <- Movie.Budget.df$'Production Budget' %>% 
  str_remove_all(",") %>% 
  str_remove("\\$")
Movie.Budget.df$'Domestic Gross' <- Movie.Budget.df$'Domestic Gross' %>% 
  str_remove_all(",") %>% 
  str_remove("\\$")
Movie.Budget.df$'Worldwide Gross' <- Movie.Budget.df$'Worldwide Gross' %>% 
  str_remove_all(",") %>% 
  str_remove("\\$")
Movie.Budget.df[,-1] <- Movie.Budget.df[,-1]

Movie.Budget.df$'Release Date' <- as.Date(Movie.Budget.df$'Release Date', format = "%m/%d/%Y")


# write.csv(Movie.Budget.df, "Moview_Budget.csv")




