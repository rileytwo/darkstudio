# daRkStudio

This is something I did for fun, and figured other people might want to have more control over their RStudio experience. I personally use a Mac, so I'll be able to provide better support the MacOS platform. However, I use a PC for work and have found this to work on Windows also.

Using this configuration for RStudio is easy, and only requires overwriting two (for now) files, `index.htm` and `custom_styles.css`, into RStudio's application directory. `index.htm` is rarely updated, so you'll likely only need to do this once. Nearly all of the updates from me pertain to `custom_styles.css`. This project is a work in progress, and is something I did because the blue color of RStudio's Modern theme left a bad taste in my mouth. I have little experience in writing css and javascript, and even less experience in building IDEs. If anyone would like to help out by contributing, please do! I'd love the help :).

Please create an issue if you have any problems!

### Darker RStudio

> Darker Modern Theme
> ![DarkRStudio](images/dark-rstudio.png)

<hr>

# Using "Dark" RStudio

To use this theme, you'll need to do a few things. First, go to `~/RStudio.app/Contents/Resources/www/` and paste custom_styles.css in that directory. Next, paste `index.htm` into the same directory, and allow this file to replace the old `index.htm`.
