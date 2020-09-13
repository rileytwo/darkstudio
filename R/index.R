#'
#' index.R
#' Created by Riley Roach on 2020-05-24
#' @keywords internal
index <- list(
  find = function(path = NULL, type = NULL) {
    # RR: Check if path has been provided
    if (length(path) != 0) {
      path_index <- path
      return(path_index)
    }

    host <- Sys.info()[["sysname"]]

    switch(
      host, stop("Could not determine the operating system."),
      Darwin = {
        paths <- list(system = "/Applications/RStudio.app/",
                      user    = "~/Applications/RStudio.app/",
                      index   = "Contents/Resources/www/index.htm")
      },
      Windows = {
        paths <- list(system = "C:/Program Files/RStudio/",
                      user    = "~/R/RStudio/",
                      index   = "www/index.htm")
      },
      Linux = {
        # RR: `rs_ver` is not needed on Debian-based distros. #13
        paths <- list(system = "/usr/local/rstudio/",
                      user    = "/usr/local/rstudio/",
                      index   = "www/index.htm")
      }
    )

    check_paths <- function(p) {
      .system <- fs::path_join(c(p$system, p$index))
      .user    <- fs::path_join(c(p$system, p$index))

      path_index <- which(fs::file_exists(.system), fs::file_exists(.user))
      if (length(path_index) == 0) {
        return(NULL)
      }

      path_index <- names(path_index)

      return(path_index)
    }

    path_index <- check_paths(p = paths)
    index$path <- path_index

    return(index$path)
  },


  backup = function(path = NULL) {
    if (length(path) == 0) {
      stop("A file must be specified for backup.")
    }

    parent_dir <- dirname(path)
    ds_dir <- fs::path_join(c(parent_dir, "darkstudio"))

    path_backup <- fs::path_join(c(ds_dir, "index.htm.pre-ds"))

    if (fs::file_exists(path_backup)) {
      err <- paste("A backup index file already exists.",
                   "Run darkstudio::deactivate() and retry",
                   "darkstudio::activate().")
      stop(err)
    } else {
      fs::file_copy(path, path_backup)
    }
  },


  restore = function(path = NULL) {
    if (length(path) == 0) {
      stop("A file must be specified for restoration.")
    }

    parent_dir <- dirname(path)
    ds_dir <- fs::path_join(c(parent_dir, "darkstudio"))

    path_backup <- fs::path_join(c(ds_dir, "index.htm.pre-ds"))

    if (!fs::file_exists(path_backup)) {
      err <- paste(path_backup, "does not exist.", "Is darkstudio activated?")
      stop(err)
    }

    fs::file_copy(path_backup, path, overwrite = TRUE)
  },


  read = function(path = NULL) {
    .con <- path
    contents_index <- readLines(con = .con)
    return(contents_index)
  },


  modify = function(file = NULL, .ds_link = NULL) {
    if (length(file) == 0) {
      stop("No index file was given to modify.")
    }
    # Dirty workaround to make sure we add our link in before the closing
    # </html> tag
    # The goal is to simply add in a <link> handle and modify nothing else.
    # For example, the index file (as of 2020-06-27) usually looks something
    # like this near the end of the file:
    #
    # ...
    #   </body>
    #
    # </html>
    #
    # We want to change that to
    # ...
    #   </body>
    #
    #   <link rel="stylesheet" href="darkstudio/darkstudio.css" type="text/css"/>
    # </html>
    #
    for (line in seq_along(file)) {
      line_current  <- line
      line_next     <- line_current + 1


      if (index$modified(index_file = file)) {
        err <- paste(
          "The index file already contains a link to darkstudio.css.",
          "Execute darkstudio::deactivate() in the console,",
          "or manually remove the link in the index file")
        stop(err)
      }

      if (file[[line_current]] == "</html>") {
        # Create a new line, and copy the closing </html> to that new line
        file[[line_next]] <- file[[line_current]]

        # Add in the link
        file[[line_current]] <- .ds_link
      }
    }

    return(file)
  },


  modified = function(index_file = NULL) {
    if (length(index_file) == 0) {
      stop("The path of the index file is unknown.")
    }

    status <- logical()

    for (line in seq_along(index_file)) {
      line_current  <- line

      if (isTRUE(grepl("darkstudio", index_file[[line_current]], perl = TRUE))) {
        status <- TRUE
      } else {
        status <- FALSE
      }
    }
    return(status)
  }
)
