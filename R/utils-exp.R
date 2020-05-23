#
# utils.R
# 2020-05-21
#

host <- function() {
  out <- Sys.info()[["sysname"]]
  return(out)
}


locate_rstudio_index <- function(override = FALSE) {
  if (override == TRUE) {
    # Allow user to override the returned location
    print('overriding...')
  } else {
    switch(
      host(), "Could not determine the operating system.",
      Darwin = {
        paths <- list(default = "/Applications/RStudio.app/",
                      user    = "~/Applications/RStudio.app/",
                      index   = "Contents/Resources/www/index.htm")
      },
      Windows_NT = {
        paths <- list(default = "C:/Program Files/RStudio/",
                      user    = "~/R/RStudio/",
                      index   = "/www/index.htm")
      }
    )
    locate_index <- function(p) {
      default_path <- paste0(p[["default"]], p[["index"]])
      user_path    <- paste0(p[["user"]],    p[["index"]])

      index_path <- which(
        fs::file_exists(default_path), fs::file_exists(user_path)
      )
      index_path <- names(index_path)
      return(index_path)
    }
    rstudio_index <- locate_index(p = paths)
  }
  return(rstudio_index)
}






backup_index <- function() {

}

# May Use Later

mac_path <- function() {
  default <- "/Applications/RStudio.app/"
  user <- "~/Applications/RStudio.app/"

  rstudio_path <- which(fs::dir_exists(default), fs::dir_exists(user))
  if (length(rstudio_path) == 0) return(NULL)

  rstudio_path <- names(rstudio_path)
  return(rstudio_path)
}


win_path <- function() {
  default <- "C:/Program Files/RStudio/"
  user <- "~/R/RStudio/"

  rstudio_path <- which(fs::dir_exists(default), fs::dir_exists(user))
  if (length(rstudio_path) == 0) return(NULL)

  rstudio_path <- names(rstudio_path)
  return(rstudio_path)
}


index_paths <- function() {
  switch(
    host(),        NULL,
    "Darwin"     = { "Contents/Resources/www/index.htm" },
    "Windows_NT" = { "www/index.htm" }
  )
}


