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

## subset & filter SCC dataset formotor vehicle source entries
Vehicles <- grepl(pattern = "vehicle",x = SCC$SCC.Level.Two,ignore.case = TRUE)
VehiclesSCC <- SCC[Vehicles,]$SCC
VehiclesEPANEI <- EPANEI[EPANEI$SCC %in% VehiclesSCC,]
BaltimoreVehiclEPANEI <- (VehiclesEPANEI[VehiclesEPANEI$fips == "24510",])

#create plot and store as a png file
png(filename = "plot5.png",width = 480, height = 480,units = "px",)
g <- ggplot(data = BaltimoreVehiclEPANEI, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity",fill = "grey", width = 0.75) +
  theme_grey(base_size = 14,base_family = "") +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Vehicle Emission Source, Baltimore City"))
print(g)
dev.off()
