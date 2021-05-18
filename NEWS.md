# learningR v0.0.2

- To reduce the size of the vignettes in the installed package, relevant css files are present in the vignettes folder and in the inst/doc folder; the header files of the vignettes include hard-coded paths.
- Added https://polmine.github.io/drat/ to field 'Additional_repositories' in DESCRIPTION file so that the gles package can be installed from there.
- Code chunks in the slides on vectors that rely on the polmineR are not evaluated: Tbe current CRAN release of polmineR throws an error if `localeToCharset()` is `NA`, which occurs on GitHub actions Linux test machines.
- The slides on package installation have been extended to include an information how to cite R packages and R.
- A new slide explains the use of the magrittr pipe operator `%>%`, in a rudimentary fashion though.
- The package now includes a dataset `coronastats` with the reports of Open Data Duisburg.