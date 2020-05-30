#
# tools.R
# Created by Riley Roach on 2020-05-30
#
#
preview_changes <- function(path = ".") {
  darkstudio_css <- fs::path(path, "/inst/resources/darkstudio.css")

  index_file <- find_index_file()

  darkstudio_dir <- darkstudio_dir_exists(
    path = index_file, value = TRUE
  )

  fs::file_copy(darkstudio_css, darkstudio_dir, overwrite = TRUE)
}
