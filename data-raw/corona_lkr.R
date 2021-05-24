library(dplyr)
library(tibble)

mi_url <- "https://service.destatis.de/DE/karten/data/migration_integration_regionen.zip"
mi_reg <- file.path(tempdir(), basename(mi_url))
download.file(url = url, destfile = mi_reg)
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
  select(c("RS", "BEZ", "death_rate", "BL", "cases7_per_100k"))

corona_by_county <- inner_join(x = mi, y = afd, by = "RS") %>%
  inner_join(y = rki, by = "RS") %>%
  select(!Name) %>%
  rename(name = "NAME",  population_total = "INSGESAMT", foreign_pop_total = "AUSL_INSG", foreign_pop_share = "ANT_AI", afd = "AfD", type = "BEZ", region = "BL") %>%
  relocate(RS, name, region, type, population_total, cases7_per_100k, death_rate, foreign_pop_total, foreign_pop_share, afd)

save(corona_by_county, file = "~/Lab/github/learningR/data/countydata.RData")
