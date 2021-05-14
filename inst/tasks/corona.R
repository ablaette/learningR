
df <- read.table("https://opendata-duisburg.de/sites/default/files/Corona%2030.04.2020.csv", sep = ";")
column_names <- df[1,]

df_min <- df[2:nrow(df),]
colnames(df_min) <- column_names
df_min[,2] <- as.numeric(gsub("^.*?(\\d+).*?$", "\\1", df_min[,2]))
