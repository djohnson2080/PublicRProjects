library(dplyr)
library(tidyr)

titanic.original <- read.csv("C:\\Users\\darren.johnson\\Desktop\\Data Science Training\\Exercise\\1 - Data Wrangling\\titanic_original.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

embarks <- as.vector(titanic.original$embarked)

embarks[embarks == ""] <- "S"
embarks[is.na(embarks)] <- "S"

titanic.original$embarked <- embarks

rm(embarks)

avg.age <- round(mean(titanic.original$age, na.rm=TRUE))

clean.age <- titanic.original$age

clean.age[is.na(clean.age)] <- avg.age

titanic.original$age <- clean.age

titanic.original$boat[titanic.original$boat == ""] <- "None"

cabins <- as.vector(titanic.original$cabin)

titanic.original$has_cabin <- as.numeric(cabins > "")

write.table(titanic.original,"titanic_clean.csv", sep=",", row.names = FALSE)

