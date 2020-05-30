#' Install daRkStudio
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
#' \code{install_darkstudio()} will create a backup of \code{index.htm} at
#' \code{www/darkstudio/index.htm.pre-ds}. \code{www/darkstudio} is also where
#' you will find \code{darkstudio.css}, which is the bread and butter of this
#' package.
#'
#' On Windows, you will likely need Administrator Privileges if you've
#' installed RStudio to the default location, \code{C:\\Program Files\\RStudio}.
#'
#'
#' @param backup logical:
#'   TRUE or FALSE. Copies the default \code{index.htm} file to
#'   \code{index.htm.pre-ds}. Defaults to TRUE.
#' @param index_file character:
#'   Path to RStudio's \code{index.htm}. Useful for times when the default
#'   installation method cannot successfully locate the file.
#'
#' @examples
#' # Default:
#' install_darkstudio()
#'
#'
#' # macOS:
#' index_htm <- "/Applications/RStudio.app/Contents/Resources/www/index.htm"
#' install_darkstudio(backup = TRUE, index_file = index_htm)
#'
#'
#' # Windows:
#' index_htm <- "C:/Program Files/RStudio/www/index.htm"
#' install_darkstudio(backup = TRUE, index_file = index_htm)
#'
#' @return nothing.
#' @export
install_darkstudio <- function(backup = TRUE, index_file = NULL) {
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

  index_file_path <- find_index_file(path = index_file)

  if (!darkstudio_dir_exists(path = index_file_path)) {
    ds_dir <- darkstudio_dir_create(path = index_file_path)
  } else {
    ds_dir <- darkstudio_dir_exists(path = index_file_path, value = TRUE)
  }

  if (backup == TRUE) {
    backup_index_file(.index_file_path = index_file_path)
  }

  ds_css <- fs::path(
    fs::path_package(package = "darkstudio"), "resources/darkstudio.css"
  )

  fs::file_copy(path = ds_css, new_path = ds_dir)

  index_file <- read_index_file(.index_file_path = index_file_path)
  new_index_file <- modify_index_file(
    .index_file = index_file,
    .ds_link    = index_link()
  )

  writeLines(text = new_index_file, con = index_file_path)
}


#' Uninstall daRkStudio
#'
#' Remove and replace the modified \code{index.htm} with the backup
#' \code{index.htm.bak} file.
#' @return nothing
#' @export

uninstall_darkstudio <- function(index_file = NULL) {
  msg <- paste(
    "This function does NOT uninstall the darkstudio package.",
    "To uninstall the darkstudio package, copy and",
    "paste remove.packages('darkstudio') into the console."
  )
  warning(msg)
  index_file_path <- find_index_file(path = index_file)

  restore_index_file(.index_file_path = index_file_path)

  if (!darkstudio_dir_exists(path = index_file_path)) {
    warning("daRkStudio directory does not exist.")
  } else {
    ds_dir <- darkstudio_dir_exists(path = index_file_path, value = TRUE)
    fs::dir_delete(ds_dir)
  }

}


