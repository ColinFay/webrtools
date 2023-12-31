#' Download packages and deps from DESCRIPTION
#'
#' @param description path to DESCRIPTION
#' @param path_to_installation passed to `download_pak_and_deps()`
#'
#' @export
download_packs_and_deps_from_desc <- function(
  description,
  path_to_installation = "./webr_packages"
) {
  if (!file.exists(description)) {
    stop("DESCRIPTION file not found")
  }
  deps <- desc::desc_get_deps(description)

  for (pak in deps$package) {
    download_packs_and_deps(pak, path_to_installation = path_to_installation)
  }
}