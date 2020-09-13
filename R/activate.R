#' Activate daRkStudio
#'
#' @param path character:
#'   Path to RStudio's \code{index.htm}. Useful for times when the default
#'   installation method cannot successfully locate the file.
#' @param backup logical:
#'   TRUE or FALSE. Copies the default \code{index.htm} file to
#'   \code{index.htm.pre-ds}. Defaults to TRUE.
#' @param type character:
#'   Accepts 'user' or NULL. If 'user', \code{activate()} will look for RStudio
#'   in \code{/Users/xxx/Applications} instead of \code{/Applications} on macOS.
#'
#' daRkStudio modifies \code{index.htm}, a file used by RStudio to construct
#' it's DOM (Document Object Model).
#'
#' The only change to \code{index.htm} the inclusion of a \code{<link>} element
#' near the end of the file, which tells RStudio to load \code{darkstudio.css}.
#'
#' daRkStudio creates a directory, "darkstudio", inside the \code{www} folder,
#' which is found at \code{/Applications/RStudio.app/Contents/Resources/www} on
#' macOS, and \code{C:\\Program Files\\RStudio\\www} on Windows.
#'
#' \code{activate()} will create a backup of \code{index.htm} at
#' \code{www/darkstudio/index.htm.pre-ds}. \code{www/darkstudio} is also where
#' you will find \code{darkstudio.css}, which is the bread and butter of this
#' package.
#'
#' On Windows, you will likely need Administrator Privileges if you've
#' installed RStudio to the default location, \code{C:\\Program Files\\RStudio}.
#'
#'
#' @examples
#' \dontrun{
#' # Default:
#' activate()
#'
#' # macOS:
#' path_index <- "/Applications/RStudio.app/Contents/Resources/www/index.htm"
#' activate(path = path_index, backup = TRUE)
#'
#' # Windows:
#' path_index <- "C:/Program Files/RStudio/www/index.htm"
#'   activate(path = path_index, backup = TRUE)
#' }
#'
#' @return TRUE
#' @return Returns \code{TRUE} if the operation is successful.
#' @export
activate <- function(path = NULL, backup = TRUE, type = NULL) {
  # Fail quickly if the RStudio API is not available
  if (!rstudioapi::isAvailable()) {
    stop("RStudio must be running in order to install darkstudio.")
  }
  # Print message about compatibility with older RStudio versions
  if (rstudioapi::versionInfo()$version <= "1.2") {
    msg <- paste(
      "Colors, menus, buttons, and other UI elements of this version of",
      "RStudio may not look or function as expected. Please consider",
      "updating RStudio to the latest stable version. For the best results,",
      "RStudio Preview is recommended."
    )
    warning(msg)
  }

  path_index <- index$find(path = path, type = type)

  if (!settings_dir(path = path_index)) {
    ds_dir <- settings_dir_create(path = path_index)
  } else {
    ds_dir <- settings_dir(path = path_index, value = TRUE)
  }

  if (isTRUE(backup)) {
    index$backup(path = path_index)
  }

  ds_css <- fs::path(
    fs::path_package(package = "darkstudio"), "resources/darkstudio.css"
  )

  fs::file_copy(path = ds_css, new_path = ds_dir, overwrite = TRUE)

  file_index <- index$read(path = path_index)

  if (!index$modified(file_index)) {
    file_index <- index$modify(
      file = file_index, .ds_link = index_link()
    )
  }

  writeLines(text = file_index, con = path_index)

  return(TRUE)
}
