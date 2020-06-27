#' Update Styles
#'
#' Updates the \code{darkstudio.css}. Meant to be used after upgrading
#' \code{daRkStudio} and/or after upgrading RStudio.
#'
#' @return Returns \code{TRUE} if the operation is successful.
#' @export
update_styles <- function(path = NULL) {
  if (length(path) != 0) {
    path <- path
  }
  if (deactivate(path = path) == TRUE) {
    activate(path = path)
  }
  return(TRUE)
}
