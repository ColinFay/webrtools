# 0.0.3.9000

* Working on a `Library` class series for loading package in webR

# 0.0.3

* Now using webR.FS.mount to load the packages instead of doing it ourselves. Requires web >= 0.2.2

# 0.0.2

+ Splitted `loadPackages` into `loadPackages` and the more general `loadFolder`

+ Refactored the RScripts to:
  + install from github with `remotes::install_github("colinfay/webrtools", subdir = "r-pkg")`
  + use functions from the R package `{webtrools}` (instead of raw R code)

# 0.0.1

First draft of loadPackages