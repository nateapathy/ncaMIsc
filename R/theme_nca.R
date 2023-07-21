# placeholder package for my own ggplot theme
#

theme_nca <- function() {

    theme(

      #grid elements
      panel.grid.major = element_line(color="grey90",linetype=2),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(color="grey90"),
      axis.ticks = element_blank(),
      plot.title.position = "plot",
      plot.caption.position = "plot",

      #text elements
      plot.title = element_text(
        family="Helvetica",
        face="bold",
        size = rel(1.7),
        margin=margin(b=7,unit="mm")),

      plot.subtitle = element_text(
        face="italic",
        size = rel(1.1)),

      plot.caption = element_text(
        size = 9,
        hjust = 0,
        face="italic"),

      axis.title = element_text(
        face="italic",
        size = rel(1.1)),

      axis.text = element_text(
        size = 10),

      legend.position="bottom",
    )
}
