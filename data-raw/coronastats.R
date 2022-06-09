library(readr)

coronastats <- readr::read_delim(
  file = "https://www.opendata-duisburg.de/sites/default/files/Corona%2001.04.2022_0.csv",
  col_types = cols(col_date(format = "%d.%m.%Y"), col_number(), col_number(), col_number(), col_number()),
  locale = locale(decimal_mark = ",", grouping_mark = "."),
  delim = ";",
  na = c("", "\u00A0")
)

save(coronastats, file = "~/Lab/github/learningR/data/coronastats.RData")
