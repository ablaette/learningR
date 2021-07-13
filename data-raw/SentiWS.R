library(data.table)
get_sentiws <- function(){
  
  sentiws_tmp_dir <- file.path(tempdir(), "sentiws")
  if (!file.exists(sentiws_tmp_dir)) dir.create(sentiws_tmp_dir)
  sentiws_zipfile <- file.path(sentiws_tmp_dir, "SentiWS_v2.0c.zip")
  sentiws_url <- "http://pcai056.informatik.uni-leipzig.de/downloads/etc/SentiWS/SentiWS_v2.0.zip"
  download.file(url = sentiws_url, destfile = sentiws_zipfile)
  unzip(zipfile = sentiws_zipfile, exdir = sentiws_tmp_dir)
  
  .unfold <- function(.SD){
    pos <- gsub("^([A-Z]+)\\s+.*$", "\\1", .SD[["data"]][1])
    weight <- as.numeric(gsub("^[A-Z]+\\s+(-?\\d\\.\\d+).*$", "\\1", .SD[["data"]][1]))
    words <- gsub("^[A-Z]+\\s+-?\\d\\.\\d+\\s*(.*?)\\s*$", "\\1", .SD[["data"]][1])
    words <- if (!grepl("^\\s*$", words)) strsplit(x = words, split = ",")[[1]] else NULL
    list(
      word = c(.SD[["word"]][1], words),
      base = c(TRUE, rep(FALSE, times = length(words))),
      lemma = .SD[["word"]][1],
      pos = pos,
      weight = weight
    )
  }
  
  
  dts <- lapply(
    c(positive = "SentiWS_v2.0_Positive.txt", negative = "SentiWS_v2.0_Negative.txt"),
    function(filename){
      dt <- fread(file.path(sentiws_tmp_dir, filename), sep = "|")
      colnames(dt) <- c("word", "data")
      dt[, "id" :=  1L:nrow(dt)]
      dt[, .unfold(.SD), by = c("id")]
    }
  )
  rbindlist(dts)
}

senti_ws <- get_sentiws()

save(senti_ws, file = "~/Lab/github/learningR/data/SentiWS.RData")
