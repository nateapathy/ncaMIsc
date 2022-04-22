README
================

## Nate’s Miscellaneous Functions

Hi, I’m [Nate C. Apathy, PhD](https://www.nateapathy.com). I do health
services and health policy research focused on health information
technology. This is an R package that holds a bunch of miscellaneous
functions that I use in my research, or have just built for fun.

## Installing this package

This package isn’t on CRAN, so you’ll have to install it via `devtools`

``` r
devtools::install_github("nateapathy/ncaMisc")
```

## `get_gs_cite_data()`

This is a function that collects a bunch of data from a [Google
Scholar](https://scholar.google.com/) profile, including data on all of
the studies that cite a given scholar’s most-cited first-authored
publication. It has one argument: `id = "SCHOLARID"`. The SCHOLARID
value is the value in the URL of a given scholar’s profile following the
`user=` in the URL. For example, my SCHOLARID is `"DpaI7XMAAAAJ"` from
the URL of my profile:
`https://scholar.google.com/citations?user=DpaI7XMAAAAJ&hl=en`. All you
pass to this function is the id in quotes, and it returns a list of
information including information about the scholar, all of their
publications, and citations of their top-cited first-authored work.

``` r
nca_gs <- get_gs_cite_data(id=="DpaI7XMAAAAJ") # not run, data pre-loaded for example

str(nca_gs)
```

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.

## `get_pct_first()`

This is a function that calculates the share of a given scholar’s
