## Download and Unzip data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./ExploratoryDataAnalysis")){
  dir.create("./ExploratoryDataAnalysis/")
  download.file(fileUrl, destfile="./ExploratoryDataAnalysis/Dataset.zip", method="curl")
}
unzip(zipfile="./ExploratoryDataAnalysis/Dataset.zip", exdir="./ExploratoryDataAnalysis")
file_path <- file.path("./ExploratoryDataAnalysis")
files <- list.files(file_path, recursive = TRUE)
files
## Get full dataset
data_full <- read.csv("./ExploratoryDataAnalysis/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subset the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Make Plot 2
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
