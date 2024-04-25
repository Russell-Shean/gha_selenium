if(!require(pacman)){install.packages("pacman")}

pacman::p_load("RSelenium",
              "rvest", 
               "stringr",
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
#remDr$open()

# go to google's trending search page
remDr$navigate("https://trends.google.com/trends/trendingsearches/daily?geo=US&hl=en-US")

# pull html
  page_html <- remDr$getPageSource()[[1]] %>% 
    read_html()

# extract date
todays_date <- page_html |> 
  html_elements("div.feed-list-wrapper:nth-child(1) > div:nth-child(1) > div:nth-child(1)") |>
  html_text()


# extract top search term
search_term <- page_html |> 
  html_elements("div.feed-list-wrapper:nth-child(1) > md-list:nth-child(2) > feed-item:nth-child(1) > ng-include:nth-child(1) > div:nth-child(1) .details-top a") |>
  html_attr("title") |> 
  str_remove("Explore ")


# extract number of views
search_count <- page_html |> 
  html_elements("div.feed-list-wrapper:nth-child(1) > md-list:nth-child(2) > feed-item:nth-child(1) > ng-include:nth-child(1) > div:nth-child(1) .search-count-title") |>
  html_text()



msg <- paste0("The top trending search in English on google in the US on ", todays_date, " is ", search_term, " it has received ",
              search_count, " searches.")


print(msg)
