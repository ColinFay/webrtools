#!/usr/bin/env Rscript

# If the path to DESCRIPTION is not provided, try stop
description <- commandArgs(trailingOnly = TRUE)[1]
if (is.na(description)) {
  stop("This script requires at least one argument (path to DESCRIPTION)")
}
description <- normalizePath(description)


if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

remotes::install_github("colinfay/webrtools", subdir = "r-pkg")

webrtools::install_from_desc(description)

