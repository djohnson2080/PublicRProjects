library(dplyr)
library(tidyr)

toydata <- read.csv("C:\\Users\\darren.johnson\\Desktop\\Data Science Training\\Exercise\\0 - Data Wrangling\\refine_original.csv",header=TRUE)

toydata$company <- tolower(toydata$company)

toydata$company <- sub(pattern="ak zo",replacement="akzo", x = toydata$company)
toydata$company <- sub(pattern="akz0",replacement="akzo", x = toydata$company)
toydata$company <- sub(pattern="fillips",replacement="phillips", x = toydata$company)
toydata$company <- sub(pattern="philips",replacement="phillips", x = toydata$company)
toydata$company <- sub(pattern="phillps",replacement="phillips", x = toydata$company)
toydata$company <- sub(pattern="phlips",replacement="phillips", x = toydata$company)
toydata$company <- sub(pattern="phllips",replacement="phillips", x = toydata$company)
toydata$company <- sub(pattern="unilver",replacement="unilever", x = toydata$company)
companies <- summarise(group_by(toydata, company))

toydata.separated <- separate(toydata,Product.code...number,c("product_code","product_number"),sep="-")

prod.category <- data.frame(cbind(c("p","v","x","q"),c("Smartphone","TV","Laptop","Tablet")))

colnames(prod.category) <- c("product_code","product_category")

toydata.categorised <- left_join(toydata.separated, prod.category, by = "product_code")

toydata.fulladdress <- unite(toydata.categorised,"full_address",address, city, country, sep=", ")

is.phillips <- toydata.fulladdress$company == "phillips"
is.akzo <- toydata.fulladdress$company == "akzo"
is.unilever <- toydata.fulladdress$company == "unilever"
is.vanh <-toydata.fulladdress$company == "van houten"

toydata.binary1 <- cbind(toydata.fulladdress,is.akzo,is.phillips,is.unilever,is.vanh)

colnames(toydata.binary1)[7:10] <- c("company_akzo","company_phillips","company_unilever","company_van_houten")

product_smartphone <- toydata.binary1$product_category == "Smartphone"
product_laptop <- toydata.binary1$product_category == "Laptop"
product_tv <- toydata.binary1$product_category == "TV"
product_tablet <- toydata.binary1$product_category == "Tablet"
toydata.binary2 <- cbind(toydata.binary1,product_smartphone,product_tv,product_laptop,product_tablet)

write.table(toydata.binary2, "c:/clean_toydata.csv", sep=",") 