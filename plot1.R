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

#aggregate the data
agregdata <- aggregate(Emissions~year,data = EPANEI,FUN = sum)

#create plot and store as apng file
png(filename = "plot1.png",width = 480, height = 480,units = "px")
barplot(  (agregdata$Emissions)/10^6,  names.arg = agregdata$year, col = "blue", xlab = "Year",  ylab = "PM2.5 Emissions (10^6 Tons)",
          main = "PM2.5 Emissions - US Total")
dev.off()  
