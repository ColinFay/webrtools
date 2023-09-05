#!/usr/bin/env Rscript

if (!requireNamespace("pak", quietly = TRUE)) {
  install.packages("pak", dependencies = TRUE)
}

if (is.na(commandArgs(trailingOnly = TRUE)[1])) {
  stop("This script requires at least one argument")
}

if (is.na(commandArgs(trailingOnly = TRUE)[2])) {
  path_to_installation <- "./webr_packages"
} else {
  path_to_installation <- commandArgs(trailingOnly = TRUE)[2]
}

pkg_deps <- pak::pkg_deps(commandArgs(trailingOnly = TRUE)[1])$ref

already_installed <- list.files(
  path_to_installation
)
repos <- sprintf(
  "https://repo.r-wasm.org/bin/emscripten/contrib/%s.%s",
  # Get major R version
  R.version$major,
  substr(R.version$minor, 1, 1)
)
info <- utils::available.packages(contriburl = repos)

for (pkg in pkg_deps){
  if (pkg %in% already_installed) {
    message("Package ", pkg, " already installed")
    next
  }
  if (!(pkg %in% info[, "Package"])) {
    message("Package ", pkg, " not found in repo")
    next
  }
  message("Installing ", pkg)
  targz_file <- paste0(pkg, "_", info[info[, "Package"] == pkg, "Version"], ".tgz")
  url <- paste0(repos, "/", targz_file)
  tmp <- tempfile(fileext = ".tgz")
  download.file(url, destfile = tmp)
  untar(tmp, exdir = path_to_installation)
  unlink(tmp)
}

message("Done")