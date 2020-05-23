#' Install daRkStudio
#'
#' daRkStudio modifies `index.htm`, a file used by RStudio to construct it's
#' DOM (Document Object Model).
#'
#' The only change we make is the inclusion of a `<link>` element near the end
#' of the file, which tells RStudio to load `darkstudio.css`.
#'
#'
#' On Windows, you will likely need Administrator Privileges if you've
#' installed RStudio to the default location, "C:\Program Files\RStudio".
#'
#' Installation on a Mac shouldn't require any additional privileges.
#'
#' @return nothing.
#' @export
install_darkstudio <- function(backup = TRUE) {

  # Fail quickly if the RStudio API is not available
  if (!rstudioapi::isAvailable()) {
    stop("RStudio must be running in order to install daRkStudio.")
  }

  # Print message about compatibility with older RStudio versions
  if (rstudioapi::versionInfo()$version <= "1.2") {
    wmsg <- paste0(
      "Colors, menus, buttons, and other UI elements of this version of ",
      "RStudio may not look or function as expected. Please consider ",
      "updating RStudio to the latest stable version. For the best results, ",
      "RStudio Preview is recommended."
    )
    warning(wmsg)
  }

  index_file <- find_index_file()

}

