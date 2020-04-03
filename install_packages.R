# Install packages to a docker image with packrat

### Initialize packrat ###

# Install packrat
install.packages("packrat", repos = "https://cran.rstudio.com/")

# Initialize packrat, but don't let it try to find packages to install itself.
packrat::init(
  infer.dependencies = FALSE,
  enter = TRUE,
  restart = FALSE
)

### Install packages ###

# All packages will be installed to
# the project-specific packrat library.


# Install CRAN packages
cran_packages <- c(
  "ggplot2",
  "EpiEstim",
  "dplyr",
  "tidyr",
  "vroom",
  "here",
  "drake",
  "purrr"
)

install.packages(cran_packages)

### Take snapshot ###

packrat::snapshot(
  snapshot.sources = FALSE,
  ignore.stale = TRUE,
  infer.dependencies = FALSE
)
