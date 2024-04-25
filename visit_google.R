if(!require(pacman)){install.packages("pacman")}

pacman::p_load("RSelenium",
              "rvest", 
              "magrittr")

rD <- rsDriver(browser="phantomjs", port=4553L, chromever = NULL)
remDr <- rD[["client"]]

# Navigate to webpage -----------------------------------------------------
remDr$open()
remDr$navigate()


# click on I'm feeling lucky
remDr$findElements("css", "#gbqfbb")[[1]]$clickElement()

# figure out what we just clicked on lol
# pull html
  page_html <- remDr$getPageSource()[[1]] %>% 
    read_html()

# extract top title
title <- page_html %>% 
           html_nodes("h1.title")

print(title)
