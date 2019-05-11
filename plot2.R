#Set working directory
setwd("C:\\Users\\TRUDR\\OneDrive - Monsanto\\Migrated from My PC\\Desktop\\Data\\Ex._data\\Course project 2")
#Step 0. Create directory, downloading the dataset from the source and unzip
if(!file.exists("./data")){dir.create("./data")}

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

#create plot and store as apng file
png(filename = "plot2.png",width = 480, height = 480,units = "px")
barplot(agregdatBaltimore$Emissions,
        names.arg = agregdatBaltimore$year,
        col = "blue",
        xlab = "Years",
        ylab = "PM2.5 Emissions(Ton)",
        main = "Total PM2.5 Emissions levels in Baltimore from 1999 to 2008"
)
dev.off()
