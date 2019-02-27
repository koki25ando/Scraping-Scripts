company_list <- read.csv("company_list.csv")
Review_link <- paste0(company_list$URL, "/reviews#company-nav")

Review_num <- function (url) {
  page <- read_html(as.character(url))
  
  name <- page %>% 
    html_nodes("div.v2-company-header__name") %>% 
    html_text()
  
  review_num <- page %>% 
    html_nodes("div.reviews__title") %>% 
    html_nodes("span") %>% 
    html_text() %>% 
    str_remove_all("\n") %>% 
    str_remove("件）") %>% 
    str_remove("（")
  
  df <- data.frame(name, review_num)
  names(df) <- c("Name", "Review_num")
  df
}

review_num_list = list()

for (i in 29030:44448){
  review_num_list[[i]] = Review_num(Review_link[-29048][i])
  if (i %% 50 == 0){
    print(i)
  } else {
    NULL
  }
}

Review_NumDF <- do.call(rbind, review_num_list)
write.csv(Review_NumDF, "OneCareer_ReviewNum.csv")
