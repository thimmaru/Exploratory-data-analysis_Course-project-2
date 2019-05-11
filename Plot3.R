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
BaltimoreNEI <- (EPANEI[EPANEI$fips == "24510",])

#aggregate the data
agregdatBaltimore <- aggregate(Emissions~year,data = BaltimoreNEI,FUN = sum)

#create plot and store as a png file
png(filename = "Plot3.png",width = 750, height = 602,units = "px",)
g <- ggplot(data = BaltimoreNEI, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  facet_grid(facets = .~type,scales = "free",space = "free") +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))
print(g)
dev.off()
