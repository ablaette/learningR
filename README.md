Introducing learningR
================

<!-- badges: start -->

[![R build
status](https://github.com/ablaette/learningR/workflows/R-CMD-check/badge.svg)](https://github.com/ablaette/learningR/actions)
<!-- badges: end -->

## learningR: An introduction to R

The repository is used for an introductory course to scientific
programming and data visualisation with R.

## Installation

The package is a GitHub-only package at this stage. To avoid the
overhead of installing the
[devtools](https://CRAN.R-project.org/package=devtools) package which is
usually used for installing packages directly from GitHub (using
`devtools::install_github()`), I recommend using
`remotes::install_github()`. Indeed, devtools only re-exports the
original function of the
[remotes](https://CRAN.R-project.org/package=remotes) package.

``` r
install.packages("remotes")
remotes::install_github("ablaette/learningR", build_vignettes = TRUE, dependencies = TRUE)
```

Setting arguments `build_vignettes` and `dependencies` as `TRUE` is
important:

-   The slides included in the package are technically realized as
    vignettes. We need to ensure that they are built
    (`build_vignettes = TRUE`).
-   R packages used by the vignettes are suggested packages,
    `dependencies = TRUE` will ensure that these dependencies are
    installed if not yet present.

This installation mechanism works on macOS, Linux and Windows.

Experimentally, the package is also available via a “drat” (CRAN-style)
repository. Install the package as follows:

``` r
install.packages(pkg = "learningR", repos = "https://polmine.github.io/drat/")
```

## Using the package

### Viewing the slides

The slides are designed to work online as well as locally. If the
learningR package is installed, use the following command to open a
browser window that will show an overview over the slides within the
package.

``` r
browseVignettes(package = "learningR")
```

Then click on the respective HTML document to inspect one set of slides.

### Viewing R Markdown

To explore code included in the slides, you want to have access to the
original R code. Within RStudio, choose among the R Markdown files the
slides are based on using the following command.

``` r
open_rmd_file()
```

The chosen file will be opened in RStudio.

### Classroom use

The slides are designed to work well in a classroom setting - including
courses taught by video conference. In this scenario, you often want to
show slides and the R console at the same time, to demonstrate how a
piece of code works.

This is why we use [xaringan
Presentations](https://bookdown.org/yihui/rmarkdown/xaringan.html): You
can preview (show) slides within the Viewer pane of RStudio. At the
same, the R console is available. To launch the ‘infinite moon reader’,
ensure that the R Markdown document of the slides you want to use is the
active document. The slides are launched in the RStudio Viewer pane as
follows:

``` r
servr::daemon_stop(1)
xaringan::inf_mr()
```

## Finding the slides online

The package is work in progress, only a part of the slides is ready for
use. The following slides are available online:

-   [Erste
    Schritte](https://ablaette.github.io/learningR/a_getting-started.html#1)
-   [Installation von
    Paketen](https://ablaette.github.io/learningR/b_installation.html#1)
-   [Datenstrukturen:
    Vektoren](https://ablaette.github.io/learningR/c_vektoren.html#1)
-   [Matrizen - Listen -
    Tabellen](https://ablaette.github.io/learningR/d_data.frames.html#1)
-   [Funktionen und
    Kontrollstrukturen](https://ablaette.github.io/learningR/e_kontrollstrukturen.html#1)

## License

The package is an [Open Educational
Resource](https://de.wikipedia.org/wiki/Open_Educational_Resources)
licensed under a Creative Commons License ([CC BY
4.0](https://creativecommons.org/licenses/by/4.0/deed.de)). Tha package
may be used, shared and modified, but it is expected that authorship is
attributed.

## Quoting the slides (the package)

To get a suggestion how to quote the package, use the `citation()`
function:

``` r
citation(package = "learningR")
```

    ## 
    ## To cite package 'learningR' in publications use:
    ## 
    ##   Blaette, Andreas (2020). learningR. R package version v0.0.2.
    ## 
    ## Ein BibTeX-Eintrag für LaTeX-Benutzer ist
    ## 
    ##   @Manual{,
    ##     title = {learningR},
    ##     author = {Andreas Blaette},
    ##     year = {2021},
    ##     note = {R package version 0.0.2},
    ##   }
