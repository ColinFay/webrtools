
#' @title A test function
#'
#' @description A test function
#'
#' @return A numeric value
#'
#' @param x A numeric vector
#'
#' @export
#'
#' @examples
#' testfun(1)
#' testfun(1:10)

testfun <- function(x) {
  sum(x + 1)
}