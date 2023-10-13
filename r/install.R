#!/usr/bin/env Rscript

# This script only works if you pass it at least one arg
if (is.na(commandArgs(trailingOnly = TRUE)[1])) {
  stop("This script requires at least one argument")
} else {
  pk_to_install <- commandArgs(trailingOnly = TRUE)[1]
}

# If no second value, defaulting to webr_packages
if (is.na(commandArgs(trailingOnly = TRUE)[2])) {
  path_to_installation <- "./webr_packages"
} else {
  path_to_installation <- commandArgs(trailingOnly = TRUE)[2]
}

if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

remotes::install_github("colinfay/webrtools", subdir = "r-pkg")

webrtools::install(pk_to_install, path_to_installation)