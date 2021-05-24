#' learningR package.
#'
#' This is a story to be told.
#' @author Andreas Blaette (andreas.blaette@@uni-due.de)
#' @keywords package
#' @docType package
#' @rdname learningR-package
#' @name learningR
#' @importFrom xaringan moon_reader
NULL


#' Corona-Faelle in Duisburg.
#'
#' @docType data
#' @keywords datasets
"coronastats"

#' Corona auf Ebene der Landkreise.
#'
#' @docType data
#' @keywords datasets
"corona_by_county"

#' Open R Markdown sourcecode in RStudio
#'
#' @importFrom utils menu
#' @importFrom rstudioapi navigateToFile
#' @export
open_rmd_file <- function(){
  rmd_files <- grep(
    "\\.Rmd",
    list.files(system.file(package = "learningR", "doc"), full.names = TRUE),
    value = TRUE
  )
  choice <- menu(choices = basename(rmd_files))
  if (exists("choice")) navigateToFile(rmd_files[choice])

}
