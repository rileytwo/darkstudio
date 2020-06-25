#'
#'  tools.R
#'  Created by Riley Roach on 2020-05-30
#'
#' @keywords internal
preview_changes <- function(path = ".") {
  darkstudio_css <- fs::path(path, "/inst/resources/darkstudio.css")

  index_file <- darkstudio:::find_index_file()

  darkstudio_dir <- darkstudio:::darkstudio_dir_exists(
    path = index_file, value = TRUE
  )

  fs::file_copy(darkstudio_css, darkstudio_dir, overwrite = TRUE)
}


load_functions <- function(path = NULL) {
  if (length(path) == 0) {
    path = "."
  }
  if ("R" %in% dir() && dir.exists("R")) {
    for (i in dir("R")) {
      source(paste("R", i, sep = "/"))
    }
  }
}
