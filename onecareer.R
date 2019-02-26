library(tidyverse)
library(rvest)

head_url = "https://www.onecareer.jp/companies?page="
company_listURL = paste0(head_url, 1:1778)


