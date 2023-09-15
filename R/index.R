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
                      index   = "Contents/Resources/app/www/index.htm")
      },
      Windows = {
        paths <- list(system = "C:/Program Files/RStudio/",
                      user    = "~/R/RStudio/",
                      index   = "resources/app/www/index.htm")
      },
      Linux = {
        # RR: `rs_ver` is not needed on Debian-based distros. #13
        # RR: `lib`, not `local`, for Linux common distros. #13`
        paths <- list(system = "/usr/lib/rstudio/",
                      user    = "/usr/lib/rstudio/",
                      index   = "www/index.htm")
      }
    )

    check_paths <- function(p) {
      systempath <- fs::path_join(c(p$system, p$index))
      userpath    <- fs::path_join(c(p$system, p$index))

      path_index <- which(fs::file_exists(systempath), fs::file_exists(userpath))
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
    
    for(i in (1:length(file))) {
      if (grepl("</head>", file[i])) {
        file[i] <- paste0(.ds_link, "\n", file[i])
      }
    }

    return(file)
  },


  modified = function(index_file = NULL) {
    if (length(index_file) == 0) {
      stop("No index file was given to check for modifications")
    }

    status <- logical()
    for (line in seq_along(index_file)) {
      line_current  <- line

      if (isTRUE(grepl("darkstudio", index_file[[line_current]], perl = TRUE))) {
        status <- TRUE
        break
      } else {
        status <- FALSE
      }
    }

    if (isTRUE(status)) {
      warning("index.htm is already modified. Not modifying.")
    }

    return(status)
  }
)
