#!/usr/bin/env Rscript

if (is.na(commandArgs(trailingOnly = TRUE)[1])) {
  stop("This script requires at least one argument")
}

if (is.na(commandArgs(trailingOnly = TRUE)[2])) {
  path_to_installation <- "./webr_packages"
} else {
  path_to_installation <- commandArgs(trailingOnly = TRUE)[2]
}

pk_to_install <- commandArgs(trailingOnly = TRUE)[1]

repos <- sprintf(
  "https://repo.r-wasm.org/bin/emscripten/contrib/%s.%s",
  # Get major R version
  R.version$major,
  substr(R.version$minor, 1, 1)
)

deps <- unique(
  unlist(
    use.names = FALSE,
    tools::package_dependencies(
      recursive = TRUE,
      pk_to_install
    )
  )
)

pkg_deps <- c(
  pk_to_install,
  deps
)

already_installed <- list.files(
  path_to_installation
)

info <- utils::available.packages(contriburl = repos)

for (pkg in pkg_deps){
  if (pkg %in% already_installed) {
    message("Package ", pkg, " already installed")
    next
  }
  if (!(pkg %in% info[, "Package"])) {
    message("Package {", pkg, "} not found in repo (unavailable or is base package)")
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