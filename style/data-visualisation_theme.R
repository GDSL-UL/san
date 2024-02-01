library(ggplot2)
library(ggthemes)
library(showtext)

# Set ggplot themes

# font style

# load font
font_add_google("Roboto Condensed", "robotocondensed")
# automatically use showtext to render text
showtext_auto()

# theme for maps
theme_map_tufte <- function(...) {
  theme_tufte() +
    theme(
      text = element_text(family = "robotocondensed"),
      # remove all axes
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank()
    )
}


# theme for plots
theme_plot_tufte <- function(...) {
  theme_tufte() +
    theme(
      text = element_text(family = "robotocondensed")
    ) +
    theme(axis.text.y = element_text(size = 12),
          axis.text.x = element_text(size = 12),
          axis.title=element_text(size=14)
    )
}
