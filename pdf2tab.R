library(tabulizer)

pdf_doc <- "/home/blaette/Lab/gitlab/learningR/pdf/btw_ab49_gesamt.pdf"
outdir <- "/home/blaette/Lab/gitlab/learningR/RData/wahlergebnisse"

for (page in 5:105){
  print(page)
  data <- extract_tables(file = pdf_doc, pages = page)
  saveRDS(data, file = file.path(outdir, paste("page", page, ".RData", sep = "")))
}

