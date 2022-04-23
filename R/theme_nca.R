# placeholder package for my own ggplot theme
#

theme_nca <- function() {
  font <- "AppleGothic"   #assign font family up front

  theme_minimal() %+replace%    #replace elements we want to change

    theme(

      #grid elements
      panel.grid.major = element_blank(),    #strip major gridlines
      panel.grid.minor = element_blank(),    #strip minor gridlines
      axis.ticks = element_blank(),          #strip axis ticks

      #since theme_minimal() already strips axis lines,
      #we don't need to do that again

      #text elements
      plot.title = element_text(  #title
        family = font,            #set font family
        size = 14,                #set font size
        hjust = 0,                #left align
        vjust = 2),               #raise slightly

      plot.subtitle = element_text(#subtitle
        family = font,             #font family
        face="italic",             #italicize
        size = 12,
        hjust=0),                #font size

      plot.caption = element_text(#caption
        family = font,            #font family
        size = 9,                 #font size
        face="italic",            #ital
        hjust = 0),               #left align

      axis.title = element_text(             #axis titles
        family = font,            #font family
        size = 12),               #font size

      axis.text = element_text(              #axis text
        family = font,            #axis famuly
        size = 10),                #font size

      axis.text.x = element_text(            #margin for axis text
        margin=margin(5, b = 10)),

      legend.position="bottom",    # legend on bottom
    )
}
