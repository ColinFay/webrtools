#' Title
#'
#' Description
#'
#' @param
#'
#' @export
#'
#' @example
install_from_desc <- function(
  description,
  path_to_installation = "./webr_packages"
) {
  if (!file.exists(description)) {
    stop("DESCRIPTION file not found")
  }
  deps <- desc::desc_get_deps(description)

  for (pak in deps$package) {
    downloaded_pak_and_deps(pak, path_to_installation = path_to_installation)
  }
}