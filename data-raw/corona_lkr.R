library(dplyr)
library(tibble)
library(openxlsx)

mi_url <- "https://service.destatis.de/DE/karten/data/migration_integration_regionen.zip"
mi_reg <- file.path(tempdir(), basename(mi_url))
download.file(url = mi_url, destfile = mi_reg)
setwd(tempdir())
unzip(zipfile = mi_reg)

mi <- read.csv(file = file.path(tempdir(), "migration_integration_regionen_daten.csv")) %>%
  as_tibble() %>%
  select(c("RS", "NAME", "INSGESAMT", "AUSL_INSG", "ANT_AI"))

# https://www-genesis.destatis.de/gis/genView?GenMLURL=https%3A//www-genesis.destatis.de/regatlas/AI005.xml&CONTEXT=REGATLAS01
afd <- read.csv(file = "~/Lab/github/learningR/data-raw/afd_zweitanstimmenanteil_2017.csv", sep = ";") %>%
  as_tibble() %>%
  rename(RS = "Schluessel", AfD = "Wert")

rki <- read.csv(file = "~/Lab/github/learningR/data-raw/RKI_Corona_Landkreise.csv") %>%
  select(c("RS", "BEZ", "death_rate", "cases7_per_100k"))


## Altersquotient

age <- read.csv(file = "~/Lab/github/learningR/data-raw/12411-0017.csv", skip = 5, sep = ";", fileEncoding = "latin1")
cols <- unname(unlist(read.csv(file = "~/Lab/github/learningR/data-raw/12411-0017.csv", skip = 5, nrows = 1, header = FALSE, sep = ";")))
cols[1:3] <- c("date", "RS", "region")
colnames(age) <- cols
age <- filter(age, !is.na(RS))
agequot <- data.frame(
  RS = age$RS,
  agequot = round((as.integer(age[["65 bis unter 75 Jahre"]]) + as.integer(age[["75 Jahre und mehr"]])) / as.integer(age[["Insgesamt"]]) * 100, 1)
)


## Bevölkerungsdichte

url_density <- "https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/Administrativ/04-kreise.xlsx;jsessionid=2CBF45B087AEF3907975E8C64A6A0997.live711?__blob=publicationFile"
xlsx_local_density <- file.path(tempdir(), strsplit(basename(url_density), ";")[[1]][1])
download.file(url_density, destfile = xlsx_local_density)

density <- openxlsx::read.xlsx(xlsx_local_density, sheet = 2, startRow = 6)
colnames(density) <- c("RS", "RegBez", "Region", "NUTS3", "km2", "BevInsg", "BevM", "BevW", "per_km2")
density_min <- filter(density, !is.na(NUTS3)) %>%
  select(RS, per_km2)
density_min$RS <- as.integer(density_min$RS)


## Einkommen der Haushalte
# Quelle: https://www.statistikportal.de/de/vgrdl/ergebnisse-kreisebene/einkommen-kreise

url <- "https://www.statistikportal.de/sites/default/files/2021-05/vgrdl_r2b3_bs2019.xlsx"
xlsx_local <- file.path(tempdir(), basename(url))
download.file(url, destfile = xlsx_local)

raw <- openxlsx::read.xlsx(xlsx_local, sheet = "2.4")
df <- raw[5:nrow(raw),]
colnames(df) <- raw[4,]
df[["RS"]] <- as.integer(df[["Regional-schlüssel"]])

econ <- as_tibble(df) %>%
  rename(lkr = "NUTS 3") %>%
  filter(!is.na(lkr)) %>%
  select("RS", "Land", "2018") %>%
  rename(income = "2018")

corona_by_county <- inner_join(x = mi, y = afd, by = "RS") %>%
  inner_join(y = rki, by = "RS") %>%
  left_join(y = econ, by = "RS") %>%
  left_join(y = density_min, by = "RS") %>%
  left_join(y = agequot, by = "RS") %>%
  select(!Name) %>%
  rename(name = "NAME",  population_total = "INSGESAMT", foreign_pop_total = "AUSL_INSG", foreign_pop_share = "ANT_AI", afd = "AfD", type = "BEZ", region = "Land") %>%
  relocate(RS, name, region, type, population_total, cases7_per_100k, death_rate, foreign_pop_total, foreign_pop_share, afd)


save(corona_by_county, file = "~/Lab/github/learningR/data/countydata.RData")

# w <- openxlsx::createWorkbook()
# openxlsx::addWorksheet(wb = w, sheetName = "coronastats")
# openxlsx::writeData(wb = w, sheet = "coronastats", x = corona_by_county)
# openxlsx::saveWorkbook(wb = w, file = "~/Lab/tmp/coronastats.xlsx")
