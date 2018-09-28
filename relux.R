library(rvest)
library(tidyverse)

# Main palce script

main.url <- "https://rlx.jp/"
main.page <- read_html(main.url)

location.links <- paste0("https://rlx.jp", main.page %>% 
                           html_nodes("div.other") %>% 
                           html_nodes("div.left") %>% 
                           html_nodes("td") %>% 
                           html_nodes("a.hover") %>% 
                           html_attr("href"), "?lang=en")



## Each Main Place scraping script
## Define function
Relux_Hotel_Scarping <- function(url){
  
  page <- read_html(as.character(url)) 
  
  Hotel.Name <- page %>% 
    html_nodes("div#search_list") %>% 
    html_nodes("p.hotel_name") %>% 
    html_nodes("a") %>% 
    html_text()
  
  Hotel.Location <- page %>% 
    html_nodes("p.hotel_location") %>% 
    html_text() %>% 
    str_remove("\n                ") %>% 
    str_remove("      ") %>% 
    str_replace(" >", ",")
  
  Hotel.Description <- page %>% 
    html_nodes("p.hotel_description") %>% 
    html_text() %>% 
    str_remove("\n        ") %>% 
    str_remove("      ")
  
  Hotel.Price <- page %>% 
    html_nodes("span.hotel_price") %>% 
    html_text() %>% 
    str_remove("\n                ") %>% 
    str_remove("\n                            ") %>% 
    str_replace("                                ", ":")
  
  Hotel.Link <- paste0("https://rlx.jp", 
                       page %>% 
                         html_nodes("div.hotel_link") %>% 
                         html_nodes("a.btn") %>% 
                         html_attr("href"))
  
  data.frame(Hotel.Name, Hotel.Location, Hotel.Price, Hotel.Description, Hotel.Link)
  
}

## Execute functions
Relux.Hotel.List <- apply(data.frame(location.links), 1, Relux_Hotel_Scarping)
Relux.Hotel.df <- do.call(rbind, Relux.Hotel.List)

# Export
write.csv(Relux.Hotel.df, file = "Relux_Hotel.csv")

