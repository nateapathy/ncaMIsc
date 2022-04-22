# define a function to take a google scholar ID
# and save publication data and all cites of the top-cited first authored pub
# returns an 8-item list

get_gs_cite_data <- function(id) {
  # this takes a scholar's ID, and scrapes info on their most cited first authored pub
  # so get scholar name
  prof <- scholar::get_profile(id)
  l_name <- trimws(str_extract(prof$name,"\\s+[^ ]+$"))
  # now get the cid of their top cited first authored pub
  pub_dat <- scholar::get_publications(id) %>%
    mutate(first_author=str_extract(author, "[^,]+"),
           lead_flag=if_else(grepl(l_name,first_author)==T,1,0))
  top_cid <- pub_dat %>%
    filter(lead_flag==1&cites==max(cites[lead_flag==1])) %>% pull(cid)
  top_cid <- top_cid[1] # take the first one in the case of ties
  top_cid_yr <- pub_dat %>%
    filter(cid==top_cid) %>% pull(year)
  # now get the number of cites that one CID has, to know how many pages we need to loop through
  cites_top_cid <- pub_dat %>% filter(cid==top_cid) %>% pull(cites)
  strts <- c(0:floor(cites_top_cid/10))*10 # 10 results per page
  # but index it to 0 intentionally bc the "start=0" is the default
  # now do the scraping
  # init the vector of urls to loop through
  urls <- character()
  for (i in c(1:length(strts))) {
    urls[i] <- paste0("https://scholar.google.com/scholar?start=",strts[i],
                      "&hl=en&as_sdt=5,39&sciodt=0,39&cites=",top_cid,
                      "&scipsc=")
  }
  # init the list to hold the html scraped results
  citing_articles_html <- list()
  for (i in c(1:length(urls))) {
    citing_articles_html[[i]] <- read_html(urls[i])
  }

  # now parse the html we've just saved into the data frame we want
  # init the list
  citing_dat <- list()

  for (i in c(1:length(citing_articles_html))) {
    title <- citing_articles_html[[i]] %>%
      html_nodes(".gs_rt") %>%
      html_text() %>%
      str_replace(pattern="\\[HTML\\]\\[HTML\\] ","") %>%
      tail(-1)

    ajy <- citing_articles_html[[i]] %>%
      html_nodes(".gs_a") %>%
      html_text() %>%
      tibble() %>%
      mutate(authors=gsub('^(.*?)\\W+-\\W+.*', '\\1',., perl = TRUE),
             yr=as.numeric(gsub('^.*(\\d{4}).*', '\\1', ., perl = TRUE))) %>%
      rename(scrape=".")

    cites <- citing_articles_html[[i]] %>%
      html_nodes(".gs_fl") %>%
      html_text() %>%
      # only keep it if it has "Save Cite..."
      # bc some haven't been cited or don't have html links
      # this ensures we're getting the right line
      tibble() %>%
      filter(grepl("Save Cite",.)==T) %>%
      mutate(cited_by=as.numeric(str_extract(.,pattern="(?i)(?<=Cited by\\D)\\d+"))) %>%
      replace_na(list(cited_by=0)) %>%
      pull(cited_by)

    citing_dat[[i]] <- cbind(title,ajy,cites)
  }

  citing_article_data <- bind_rows(citing_dat)  %>%
    # filter out infeasible citations from before the index article was published
    filter(yr>=top_cid_yr) # et voila

  return(list("scholar_dat"=prof,
              "pubs"=pub_dat,
              "top_cid"=top_cid,
              "cites_of_top_cid"=cites_top_cid,
              "strts"=strts,
              "urls"=urls,
              "citing_articles_html"=citing_articles_html,
              "citing_article_data"=citing_article_data))
}
