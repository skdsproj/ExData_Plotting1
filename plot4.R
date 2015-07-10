## This assignment uses data from the UC Irvine Machine Learning Repository, a popular
## repository for machine learning datasets. In particular, this assignment uses the
## "Individual household electric power consumption" dataset. The dataset contains
## measurements of electric power consumption in one household with a one-minute sampling
## rate over a period of almost 4 years. Different electrical quantities and some 
## sub-metering values are available.

## The dataset has 9 variables and the requirement for this R script is to load the dataset
## and plot 4 graphs:

## Graph 1: X-Y plot to show how the household global minute-averaged active power varies
## over the duration of the day.

## Graph 2: X-Y plot to show voltage fluctuations over the duration of the day.

## Graph 3: X-Y plot to show how the electricity consumption varies between different
## areas of the household (split and measured by different sub-meters) over the duration 
## of the day.

## Graph 4: X-Y plot to show how the household global minute-averaged reactive power varies
## over the duration of the day.

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
png("plot4.png", width=480, height=480, bg="transparent")

## First, use the par() function to set the graph area. mfrow specifies the number of rows
## and  columns and mar specifies the margins for each plot. 
par(mfrow=c(2,2), mar=c(4,4,2,2))

## Plot the first graph. This will be plotted on the 1st row, 1st column of the graph area.
plot(elecdata$datetime, elecdata$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

## Plot the second graph. This will be plotted on the 1st row, 2nd column of the graph area.
plot(elecdata$datetime, elecdata$Voltage, type = "l", xlab="datetime", ylab="Voltage")

## Plot the third graph. This will be plotted on the 2nd row, 1st column of the graph area.
plot(elecdata$datetime, elecdata$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
points(elecdata$datetime, elecdata$Sub_metering_2, type = "l", col="red")
points(elecdata$datetime, elecdata$Sub_metering_3, type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

## Plot the fourth graph. This will be plotted on the 2nd row, 2nd column of the graph area.
plot(elecdata$datetime, elecdata$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")

## Close the png device.
dev.off()