# function to get the percentage of a scholar's cites that are from first-authored pubs

get_pct_first <- function(id) {
  surname <- tail(unlist(str_split(get_profile(id)$name," ")),1)
  pubs <- get_publications(id)
  pubs$first_author <- str_extract(pubs$author,"[^,]+")
  pubs$lead_flag <- if_else(grepl(surname,pubs$first_author)==T,1,0)
  round(sum(pubs$cites[pubs$lead_flag==1])/sum(pubs$cites)*100,1)
}
