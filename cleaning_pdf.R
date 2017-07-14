test <- c("Das", "Regierungs-", "programm", "der", "schwarz-schwarzen", "CDU", "sieht", "Müßig-", "gang", "skeptisch", ".")
test <- wordList[[14]]
test2 <- test[- grep("^\\s*$", test)]

positions <- grep("-$", test2)
for (i in rev(positions)){
  if (!test2[i+1] == "und"){
    withoutHyphen <- gsub("-", "", test2[i])
    test2[i] <- paste(withoutHyphen, test2[i+1], sep = "", collapse = "")
    test2 <- test2[-(i+1)]
  }
}
