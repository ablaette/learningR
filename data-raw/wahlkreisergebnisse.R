library(tibble)
library(magrittr)
library(dplyr)

url <- "https://www.bundeswahlleiter.de/dam/jcr/ce2d2b6a-f211-4355-8eea-355c98cd4e47/btw_kerg.zip"
local_zip <- file.path(tempdir(), basename(url))
curl::curl_download(url = url, destfile = local_zip)
setwd(tempdir())
files <- unzip(local_zip)

btw17_raw <- read.table(
  grep("2017", files, value = TRUE),
  header = T, skip = 5, fill = TRUE, fileEncoding = "UTF-8", sep = ";"
) 
btw17 <- btw17_raw %>% as_tibble() %>% select(1:(ncol(.) - 1L))

parties <- unname(sapply(colnames(btw17)[1:((ncol(btw17) - 3) / 4) * 4], rep, times = 4))
vote <- unlist(unname(lapply(btw17[1,][2:(((ncol(btw17) - 3) / 2) + 1) * 2], rep, times = 2)))
what <- paste(parties, vote, btw17[2,4:ncol(btw17)], sep = "/")
colnames(btw17)[4:ncol(btw17)] <- what

btw17 <- btw17[3:nrow(btw17),]
btw2017 <- subset(btw17, !is.na(Nr))

for (i in 3L:ncol(btw2017)) btw2017[[i]] <- as.integer(btw2017[[i]])

parties <- c(
  CDU = "Christlich\\.Demokratische\\.Union\\.Deutschlands",
  CSU = "Christlich\\.Soziale\\.Union\\.in\\.Bayern\\.e\\.V.",
  SPD = "Sozialdemokratische\\.Partei\\.Deutschlands",
  LINKE = "DIE\\.LINKE",
  GRUENE = "BÜNDNIS\\.90\\.DIE\\.GRÜNEN",
  FDP = "Freie\\.Demokratische\\.Partei",
  AfD = "Alternative\\.für\\.Deutschland"
)

for (i in 1L:length(parties)){
  colnames(btw2017) <- gsub(unname(parties[i]), names(parties)[i], colnames(btw2017))
}

btw2017 <- btw2017[, c(1:19, sapply(names(parties), grep, x = colnames(btw2017)))]

save(btw2017, file = "~/Lab/github/learningR/data/btw.RData")
