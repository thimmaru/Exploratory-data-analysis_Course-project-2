#Set working directory
setwd("C:\\Users\\TRUDR\\OneDrive - Monsanto\\Migrated from My PC\\Desktop\\Data\\Ex._data\\Course project 2")
#Step 0. Create directory, downloading the dataset from the source and unzip
if(!file.exists("./data")){dir.create("./data")}
#Load ggplot2
library(ggplot2)
#url for the dataset source for the project:
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to the directory-Data
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## read the data from the source files & load
EPANEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## subset & filter SCC dataset for Combustion & Coal related entries
Combustion <- grepl(pattern = "combust",x = SCC$SCC.Level.One,ignore.case = TRUE)
Coal <- grepl(pattern = "coal",x = SCC$SCC.Level.Four,ignore.case = TRUE)
CombustionCoal <- (Combustion & Coal)
CombustionSCC <- SCC[CombustionCoal,]$SCC
CombustionEPANEI <- EPANEI[EPANEI$SCC %in% CombustionSCC,]

#create plot and store as a png file
png(filename = "plot4.png",width = 480, height = 480,units = "px",)
g <- ggplot(data = CombustionEPANEI, aes(factor(year), Emissions/10^5)) +
  geom_bar(stat = "identity",fill = "grey", width = 0.75) +
  theme_grey(base_size = 14,base_family = "") +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions - US 1999-2008"))
print(g)
dev.off()
