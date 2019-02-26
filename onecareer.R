# setwd("/Users/KokiAndo/Desktop/R/R report/Scraping script/scraping script")
library(tidyverse)
library(rvest)

head_url = "https://www.onecareer.jp/companies?page="
company_listURL = paste0(head_url, 1:1778)

company_list = list()
title_scraping <- function(main_url){
  
  main <- read_html(main_url) %>% 
    html_nodes("a.v2-companies__title")
  name <- main %>% 
    html_text() %>% 
    str_remove("\n")
  url <- main %>% 
    html_attr("href")
  
  industry <- read_html(main_url) %>% 
    html_nodes("div.v2-companies__business-field") %>% 
    html_text() %>% 
    str_remove_all("\n\n")

  df <- data.frame(name, paste0("https://www.onecareer.jp", url), industry)
  names(df) <- c("Name", "URL", "Industry")
  df
  
}

for (i in 1:1778){
  print(i)
  company_list[[i]] = title_scraping(company_listURL[[i]])
}
campany_df = do.call(rbind, company_list)
head(campany_df)
campany_df <- campany_df %>% 
  separate(Industry, into = c("Industry", "Type"),
           sep = "\n")
write.csv(campany_df, "company_list.csv")
