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

#' Wahlkreisergebnisse 2017.
#'
#' @docType data
#' @keywords datasets
"btw2017"

#' SentiWS.
#'
#' @docType data
#' @keywords datasets
"senti_ws"



#' Corona auf Ebene der Landkreise.
#'
#'
#' @docType data
#' @keywords datasets
#' @format A `data.frame` with 400 rows (representing counties) and 13 columns (variables):
#' \describe{
#'   \item{RS}{Abbreviation for "Regionalschluessel", a unique key issued for
#'   each county. One to two digits for the regional state, one for the
#'   administrative district (Regierungsbezirk) and two digits for the county
#'   ("Landkreis") or "kreisfreie Stadt".
#'   }
#'   \item{name}{Name of the "Landkreis" or "kreisfreie Stadt".}
#'   \item{region}{Regional stated (abbreviated, two uppercase letters),}
#'   \item{type}{Type of regional entity (Landkreis / kreisfreie Stadt).}
#'   \item{population_total}{Total population living in the county. Source: ...}
#'   \item{cases7_per_100k}{7-Tage-Inzidenz, Stand: ...}
#'   \item{death_rate}{Todesrate, }
#'   \item{foreign_pop_total}{Total number of foreigners / persons without
#'   German citizenship. Data source: Migration.Integration.Regionen, Gemeinsames Datenangebot von Destatis, BA und BAMF,
#'   data for
#'   \href{https://service.destatis.de/DE/karten/migration_integration_regionen.html#ANT_AI}{map on share of foreigenrs in regions (31.12.2019)}
#'   }
#'   \item{afd}{Percantage of the share of AfD }
#'   \item{income}{Average household income. Source: \href{http://rstudio.com}{Rstudio}}
#'   \item{per_100km2}{Population density.}
#'   \item{agequot}{Share of persons aged 65 or older.}
#' }
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
