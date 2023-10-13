
#' Download a package and its deps for webR
#'
#' @param pk_to_install what package do you want to install
#' @param path_to_installation Where should it be downloaded
#'
#' @export
#'
#' @example
#' downloaded_pak_and_deps("golem", tempdir())
downloaded_pak_and_deps <- function(
  pk_to_install,
  path_to_installation = "./webr_packages"
){
  # Build the repos url
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

  # Now the package list
  pkg_deps <- c(
    pk_to_install,
    deps
  )

  # I don't want to re-download things so I'm listing all the already
  # downloaded folders
  already_installed <- list.files(
    path_to_installation
  )

  # Getting the list of available package
  info <- utils::available.packages(contriburl = repos)

  # Now we can install
  for (pkg in pkg_deps) {
    # Don't redownload things
    if (pkg %in% already_installed) {
      message("Package ", pkg, " already installed")
      next
    }
    # Not available: either it's not on the repo or it's included
    # in the base distribution of R
    if (!(pkg %in% info[, "Package"])) {
      message("Package {", pkg, "} not found in repo (unavailable or is base package)")
      next
    }
    message("Installing ", pkg)
    # Name of the targz, should be on the form of pkg_version.this.that.tgz
    targz_file <- paste0(pkg, "_", info[info[, "Package"] == pkg, "Version"], ".tgz")
    # Location of file on the repo
    url <- paste0(repos, "/", targz_file)
    # Download the file and untar the archive on the local lib
    tmp <- tempfile(fileext = ".tgz")
    download.file(url, destfile = tmp)
    untar(tmp, exdir = path_to_installation)
    unlink(tmp)
  }

  message("Done")
}