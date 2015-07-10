## This assignment uses data from the UC Irvine Machine Learning Repository, a popular
## repository for machine learning datasets. In particular, this assignment uses the
## "Individual household electric power consumption" dataset. The dataset contains
## measurements of electric power consumption in one household with a one-minute sampling
## rate over a period of almost 4 years. Different electrical quantities and some 
## sub-metering values are available.

## The dataset has 9 variables and the requirement for this R script is to load the dataset
## and plot a X-Y plot to show how the household global minute-averaged active power varies
## over the duration of the day. The data from the entire dataset is not required for the 
## plot; and only the data of 1/2/2007 and 2/2/2007 is required.

## Since we need the data of only two dates, the sqldf package is used and a sql query
## pulls out data of the two dates.

library(sqldf)

## Import the data using read.csv.sql from the sqldf package. The sql query chooses
## all the rows where date is 1/2/2007 or 2/2/2007
elecdata <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE, sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

## Close the file connection
closeAllConnections()

## Create a new column datetime by pasting Date and Time data.
elecdata$datetime <- paste(elecdata$Date, elecdata$Time)

## Convert the datetime variable which is a character into the POSIXlt class.
elecdata$datetime <- strptime(elecdata$datetime, format = "%d/%m/%Y %H:%M:%S")

## Open a png device to save the plot that will be created.
png("plot2.png", width=480, height=480, bg="transparent")

## Create a X-Y of the variables datetime and  Global_active_power
## Use type = "l" to get a line that connects all the data points
## Choose appropriate labels as per the given plot that needs to be reproduced
plot(elecdata$datetime, elecdata$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)", bg="transparent")

## Close the png device.
dev.off()