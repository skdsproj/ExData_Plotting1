## This assignment uses data from the UC Irvine Machine Learning Repository, a popular
## repository for machine learning datasets. In particular, this assignment uses the
## "Individual household electric power consumption" dataset. The dataset contains
## measurements of electric power consumption in one household with a one-minute sampling
## rate over a period of almost 4 years. Different electrical quantities and some 
## sub-metering values are available.

## The dataset has 9 variables and the requirement for this R script is to load the dataset
## and plot an X-Y plot to show how the electricity consumption varies between different
## areas of the household (split and measured by different sub-meters) over the duration 
## of time. Energy sub-meter 1 (in watt-hour of active energy) corresponds to the kitchen.
## Energy sub-meter 2 corresponds to the laundry room and Energy sub-meter 3 corresponds to
## an electric water-heater and an air-conditioner.

## The data from the entire dataset is not required for the plot; and only the data of 
## 1/2/2007 and 2/2/2007 is required.

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
png("plot3.png", width=480, height=480, bg="transparent")

## First, create a X-Y of the variables datetime and  Sub_metering_1. Set the y axis label
## in this plot, Use type = "l" to get a line that connects all the data points.
plot(elecdata$datetime, elecdata$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")

## Add the data of sub_metering_2 to the above plot using the points() function. Set the
## color to "red" to distinguish it from sub_meter_1 data.
points(elecdata$datetime, elecdata$Sub_metering_2, type = "l", col="red")

## Now, add the data of sub_metering_3 to the plot. Set the color to "blue". 
points(elecdata$datetime, elecdata$Sub_metering_3, type = "l", col="blue")

## Create a legend for the graph using the legend() function.
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

## Close the png device.
dev.off()