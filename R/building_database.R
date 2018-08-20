library(rvest)
library(purrr)
library(tidyr)
library(dplyr)
library(stringr)

#cso_links is the file from the CSV. The short codes here are correct!
cso_links <- read.csv("~/R/CSO/cso_links.csv", header=FALSE)
cso_links_vec <- pull(cso_links[4], V4)
cso_links$Page.Code <- cso_links$V4 %>%
  str_extract(".*(?=&SPtext)") %>%
  str_extract("(?<=DB_).*")
for(i in 2:nrow(cso_links)){
  if(cso_links$V1[i]==""){
    cso_links$V1[i] <- cso_links$V1[i-1]
  }
  if(cso_links$V2[i]==""){
    cso_links$V2[i] <- cso_links$V2[i-1]
  }
  if(cso_links$V3[i]==""){
    cso_links$V3[i] <- cso_links$V3[i-1]
  }
}



extract_links <-  function(link_address){
  webpage <- read_html(paste(link_address)) %>% html_nodes(".row") %>% html_nodes("a")
  titles <- tibble(webpage %>% html_text() )
  names(titles) <- "Item"
  titles <- titles %>% filter(Item!="Table" & Item != "JSON")
  titles$Page.Code <- link_address %>%
    str_extract(".*(?=&SPtext)") %>%
    str_extract("(?<=DB_).*")
  titles
}

#cso_database is from the web-scraping.
cso_database <- unnest(tibble(map(cso_links_vec , extract_links)))
cso_database$Short.Code <- cso_database$Item %>% str_extract("^.{1,8}- " ) %>%
  str_replace("[:punct:]","") %>% str_replace("[:blank:]","")

cso_database <- full_join(cso_links , cso_database , by="Page.Code")
cso_database <- select(cso_database , -V4)
names(cso_database) <- c("Theme", "Section" , "Subsection", "Page.Code", "Title","Short.Code")
cso_database <- cso_database[c("Theme", "Section" , "Subsection","Title",
                                      "Page.Code", "Short.Code")]

devtools::use_data(cso_database , overwrite = TRUE )
