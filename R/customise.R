#' custom.R
#' Created by Stefano Coretta on 2023-12-18
#' @keywords internal
customise <- function(ds_css, font_family) {

  # read darkstudio.css
  css_lines <- readLines(ds_css)

  if (is.null(font_family)) {
    ui_font_line <- grep("-apple-system", css_lines)
    # use original darkstudio fonts
    css_lines[ui_font_line] <- paste0(
      "--ds-ui-font: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica,
    Arial, sans-serif;")

    writeLines(css_lines, ds_css)

  } else if (font_family == "rstudio") {
    ui_font_line <- grep("-apple-system", css_lines)
    # use RStudio default UI fonts
    css_lines[ui_font_line] <- paste0(
      "--ds-ui-font: 'Lucida Grande', 'Lucida Sans Unicode', Helvetica, sans-serif;")

    writeLines(css_lines, ds_css)

  } else if (!is.null(font_family)) {
    ui_font_line <- grep("-apple-system", css_lines)
    # add user font; hard-coded from original .css
    css_lines[ui_font_line] <- paste0(
      "--ds-ui-font: '", font_family, "', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica,
    Arial, sans-serif;")

    writeLines(css_lines, ds_css)

  } else {

  }
}
