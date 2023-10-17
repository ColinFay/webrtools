# 0.0.2

+ Splitted `loadPackages` into `loadPackages` and the more general `loadFolder`

+ Refactored the RScripts to:
  + install from github with `remotes::install_github("colinfay/webrtools", subdir = "r-pkg")`
  + use functions from the R package `{webtrools}` (instead of raw R code)

# 0.0.1

First draft of loadPackages