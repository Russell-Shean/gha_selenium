if(!require(pacman)){install.packages("pacman")}

pacman::p_load("RSelenium",
              "rvest", 
              "magrittr")


# downloading in folder temp
fprof <- makeFirefoxProfile(list(browser.helperApps.neverAsk.openFile = "text/csv",
                                 browser.helperApps.neverAsk.saveToDisk = "text/csv"))

# now add this to new list
exCap <- list(firefox_profile = fprof$firefox_profile, 
              "moz:firefoxOptions" = list(args = list('--headless')))

# and use it here
rD <- rsDriver(browser = "firefox", port = 4569L, chromever = NULL , extraCapabilities = exCap
               )


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
