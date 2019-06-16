# Overview

This is something I did for fun, and figured other people
might want to have more control
over their RStudio experience. I personally use a Mac,
so I'll be able to provide better support the MacOS platform.
However, I do use a PC for work and have found this to work on Windows also.

This project is a work in progress,
and is something I did because the blue color
of RStudio's Modern theme left a bad taste in my mouth.

I have little experience in writing css and javascript,
and even less experience in building IDEs. I did most of the work
in RStudio's DevTools, by selecting elements
and changing their properties. So, if anyone would
like to help out by contributing, please do! I'd love the help :).

### What it does:

> Darker Modern Theme
> ![DarkRStudio](images/dark-rstudio.png)

<hr>

# How do I use this?

### macOS
```sh
git clone https://github.com/livelaughriley/daRkStudio

cp "daRkStudio/custom_styles.css" \
    "/Applications/RStudio.app/Contents/Resources/www/custom_styles.css"

cp "daRkStudio/index.htm" 
    "/Applications/RStudio.app/Contents/Resources/www/index.htm"
```
### Windows
```pwsh
git clone https://github.com/livelaughriley/daRkStudio

Copy-Item "daRkStudio\custom_styles.css" `
    "C:\Program Files\RStudio\Resources\www\custom_styles.css" `
    -Force

Copy-Item "daRkStudio\index.htm" ` 
    "C:\Program Files\RStudio\Resources\www\index.htm"
    ` -Force
```

### Linux
```sh
git clone https://github.com/livelaughriley/daRkStudio

cp "daRkStudio/custom_styles.css" \
    "/usr/local/rstudio/<version-goes-here>/resources/www/custom_styles.css"

cp "daRkStudio/index.htm" \
    "/usr/local/rstudio/<version-goes-here>/resources/www/index.htm"
```

# But Wait!
**You may want to back up the original files.**

I recommend placing them into a folder, something like `before-daRkStudio`,
`RStudio-original`, `original-rstudio-files-that-were-there-before-i-started-using-this-awesome-repo-thanksriley` etc., somewhere outside of RStudio's file directory
(so they won't be removed when you update RStudio!).

If you run into any troubles, please file an issue.

