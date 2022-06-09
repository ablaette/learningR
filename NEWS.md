# learningR v0.0.7

- updated `coronastats` dataset included in the package.

# learningR v0.0.4

- Packages xaringan and rstudioapi habe been moved from 'Depends:' to 'Imports:'
- Entirely reworked slide 'f_statistics.Rmd' with introductory statistics.
- Preliminary file 'regression_draft.Rmd' has been removed from the data-raw folder.
- The missing region value in the `corona_by_county` for Hamburg (RS 2000) has been filled so that there are not NA values in the region column (#14).

# learningR v0.0.3

- The package includes a new dataset `corona_by_county`.
- A new slide in 'b_installation.Rmd' explains where to find help on a package you are not yet acquainted with.

# learningR v0.0.2

- To reduce the size of the vignettes in the installed package, relevant css files are present in the vignettes folder and in the inst/doc folder; the header files of the vignettes include hard-coded paths.
- Added https://polmine.github.io/drat/ to field 'Additional_repositories' in DESCRIPTION file so that the gles package can be installed from there.
- Code chunks in the slides on vectors that rely on the polmineR are not evaluated: Tbe current CRAN release of polmineR throws an error if `localeToCharset()` is `NA`, which occurs on GitHub actions Linux test machines.
- The slides on package installation have been extended to include an information how to cite R packages and R.
- A new slide explains the use of the magrittr pipe operator `%>%`, in a rudimentary fashion though.
- The package now includes a dataset `coronastats` with the reports of Open Data Duisburg.
- Code not working on Windows has been adjusted.

