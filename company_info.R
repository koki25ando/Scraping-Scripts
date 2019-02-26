Company_info <- function(url){
  page <- read_html(as.character(url))
  name <- page %>% 
    html_nodes("h1.v2-company-header__name--field") %>% 
    html_text()

  category <- page %>% 
    html_nodes("div.v2-company-header__category") %>% 
    html_text()

  fav_num <- page %>% 
    html_nodes("div.v2-company-heder__like-pc") %>% 
    html_nodes("a") %>% 
    html_text() %>% 
    str_remove("お気に入り\n（") %>% 
    str_remove("人）\n")

  description <- page %>% 
    html_nodes("div.v2-company-heder__description") %>% 
    html_text() %>% 
    magrittr::extract2(1) %>% 
    str_remove_all("\n")
  
  info <- page %>% 
    html_nodes("div.v2-company-infomation__list") %>% 
    html_nodes("table") %>% 
    magrittr::extract2(1) %>% 
    html_text()

  positions <- page %>% 
    html_nodes("div.v2-company-job-category-menu__items") %>% 
    magrittr::extract2(1) %>% 
    html_text() %>% 
    str_remove("\n")
    
  df <- data.frame(name, category, fav_num, description, info, positions)
  names(df) <- c("Name", "Category", "Star_num", "Description", "Info", "Positions")
  df
}


company_info_list = list()

for (i in 1:44448){
  print(i)
  company_info_list[[i]] = Company_info(campany_df$URL[[i]])
}

Company_InfoDF = do.call(rbind, company_info_list)
write.csv(Company_InfoDF, "Company_Info.csv")
